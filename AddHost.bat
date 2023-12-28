@echo off
setlocal enabledelayedexpansion

:inputLoop
@REM Prompt user for virtual hostname
set /p hostName=Enter hostname ['exit']:

@REM Check if the user wants to exit
if /i "!hostName!" equ "exit" (
    echo Exiting...
    goto :eof
)

@REM Check if the user entered a hostname
if not defined hostName (
    echo You must enter a hostname. Exiting...
    goto :eof
)

@REM Check if the host already exists
findstr /i /c:"!hostName!" %SystemRoot%\System32\drivers\etc\hosts >nul
if %errorLevel% equ 0 (
    echo The virtual host !hostName! already exists in the hosts file.
) else (
    @REM Prompt user for IP address or default to 127.0.0.1
    set /p ipAddress=Enter IP address [127.0.0.1]:
    if not defined ipAddress set "ipAddress=127.0.0.1"

    @REM Append to hosts file
    echo !ipAddress! !hostName! >> %SystemRoot%\System32\drivers\etc\hosts

    @REM Echo success message
    echo Added !hostName! with IP address !ipAddress! to hosts file.
)

echo.

@REM Go back to the input loop
goto inputLoop

:eof
@REM Pause to keep the console window open (optional)
pause
