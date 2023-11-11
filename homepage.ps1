$startpage = 'user_pref("browser.startup.homepage", "https://google.com");'
$firefoxprofiles =  Get-ChildItem -Path "$env:APPDATA\Mozilla\Firefox\Profiles\*default*\prefs.js";

foreach ($profile in $firefoxprofiles) {
    if (Select-String $profile -Pattern '"browser.startup.homepage"') {
        $line = Get-Content $profile | Select-String -Pattern '"browser.startup.homepage"' | Select-Object -ExpandProperty Line
        (Get-Content $profile) | ForEach-Object {$_.Replace($line,$startpage)} | Set-Content $profile
    }
    else {
        Add-Content -Path $profile -Value $startpage
    }
}
