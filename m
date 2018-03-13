Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeCMLnd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:43:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeCMLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:43:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-smbios: fix DCDBAS dependency, better
Date: Tue, 13 Mar 2018 12:42:57 +0100
Message-Id: <20180313114310.1998450-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:nybxwbCgdeoYPYu5te2q5jHQI7RjJkfqfdp3CNv/kyXCK2RjRYO
 GZzu9A0q5jTa5xYysPhmNK2gRR2MV8HgzaqU6AmKdHZ0o0RE7t56sAsMx90Vj61P8Ojg5nH
 FDu6adS3RezNwRzKgKT6VWsrmY66PT2+tZXJJ3Pc7/iF7L83iO+VbWOtJSWZSv7TW5OYHnU
 C5r9A8bjdktCHYjvoEjCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vJNa4cm7w7E=:8R8UzOkJcO3V2PeoFM80Lz
 dUABFE/7qr3Z/33VM+kAaoWdzlk9CZN+3akLmzfmfvuk/Pqah5EFisYQtpw/iVfmEOQ6Op3Tz
 GUXFtaaMpeE0EUol2oOj7ABeBJYVYTfrHtagX3OyYi3K/p3RN/VvzxSb1iyMy/Kll0h8/GD+X
 5gE59TYzHm2WVmoch1xyC4ZUChxyeNQCm6kzXez7dF9YKRrNPYyGDa1d+pYXOqbSNZRwM7nrk
 Go0liaQ1q1QHMJmmyJV2s3GWUKlpQbO28zabEncOTCqDZWv75NoMx7qHdyHlAPWJVwt+6u0SE
 DkStD50vF6uxsFvK4BmN5mHpFm6untMGqn2A1vK43GsMJGzFw1uIAgHVZuwFdOyrxC79deZuP
 LUVcolhWl9+4nwAhamkfkhyYJN3c9cQtAiFo3ZgsCQon6u5mkRfV6fB+pD8J07wjRy7fPyZR1
 SGSX3qRnz+ODB7udvDkXg52quKyTbstD+ObSfwFOBv6R97k1beJgWAqDZ/uD2C9PtpqEtW5VE
 rhsXrQq8uCtlI8dsHV1Tll5GzdHgI9hzF2aLSqeElUJ0h44UBeksdOS5FrkcadJhSDSYw7R3S
 0TYk2w2PmS2YdYIPJ/iioUlmTLLKZ5NMNKyBbywVsD1hXeARXqHFEHq60N5CeS+bRA1ZMoZuL
 PiXhZvqVxKMotqyaTm2LgZwtsMIGGzAthvRAVeVGqvbj39m+xuGJ3P+RjLbfyFBPTNci0QOIN
 v1IA2h82sDcvL9LQac6xUu6H1+dYDZbGSCbvgg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rework of the dell laptop modules caused a link error:

drivers/platform/x86/dell-smbios-smm.o: In function `dell_smbios_smm_call':
dell-smbios-smm.c:(.text+0x77): undefined reference to `dcdbas_smi_request'

We already have a fix for that, but this was only a partial solution,
since CONFIG_DELL_LAPTOP and CONFIG_DELL_WMI select CONFIG_DELL_SMBIOS
regardless of that dependency.

We can either add the same 'DCDBAS || DCDBAS=n' dependency for those two
as well, or replace the 'select' with a 'depends on'. The second approach
seems cleaner, so I'm picking that here.

Fixes: 32d7b19bad96 ("platform/x86: dell-smbios: Resolve dependency error on DCDBAS")
Fixes: 25d47027e100 ("platform/x86: dell-smbios: Link all dell-smbios-* modules together")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 28905793b5e5..0aec62bb5c61 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -151,7 +151,7 @@ config DELL_LAPTOP
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL || RFKILL = n
 	depends on SERIO_I8042
-	select DELL_SMBIOS
+	depends on DELL_SMBIOS
 	select POWER_SUPPLY
 	select LEDS_CLASS
 	select NEW_LEDS
@@ -165,8 +165,8 @@ config DELL_WMI
 	depends on DMI
 	depends on INPUT
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on DELL_SMBIOS
 	select DELL_WMI_DESCRIPTOR
-	select DELL_SMBIOS
 	select INPUT_SPARSEKMAP
 	---help---
 	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.
-- 
2.9.0
