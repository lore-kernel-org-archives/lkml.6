Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeEJVxb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:53:31 -0400
Received: from server1.vittgam.net ([213.239.197.142]:62235 "EHLO
        mail.vittgam.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbeEJVxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:53:30 -0400
X-DKIM: OpenDKIM Filter v2.4.2 mail.vittgam.net w4ALrNxj152699
X-VittGamMilter-Outgoing-SubjectPrefix: [linux-kernel]
X-VittGamMilter-Outgoing-OriginalSubject: [PATCH] platform/chrome: cros_ec_lpc: Add support for newer Google devices using custom coreboot firmware or stock SeaBIOS.
Date: Thu, 10 May 2018 23:53:23 +0200
Message-Id: <201805102153.w4ALrNxj152699@mail.vittgam.net>
From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
To: <linux-kernel@vger.kernel.org>, <bleung@chromium.org>,
        <bleung@google.com>, <olof@lixom.net>
Cc: "Salvatore Bellizzi" <lkml@seppia.net>, <groeck@chromium.org>,
        <groeck@google.com>, <dmitry.torokhov@gmail.com>
Subject: [PATCH] platform/chrome: cros_ec_lpc: Add support for newer Google devices using custom coreboot firmware or stock SeaBIOS.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Custom coreboot firmware does not contain "Google_*" as BIOS
version string; also, booting through stock SeaBIOS will present
an empty BIOS version string to Linux. So the generic match at
the top would not work.

A previous patch added the "GOOGLE" match for DMI system vendor,
but newer machines such as Skylake-based Caroline use "Google"
instead.

Also amend the previous comment adding a note that this is needed
for stock SeaBIOS too.

Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>

---

--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -347,7 +347,8 @@
 	},
 	{
 		/*
-		 * If the box is running custom coreboot firmware then the
+		 * If the box is running custom coreboot firmware,
+		 * or is booting Linux through stock SeaBIOS, then the
 		 * DMI BIOS version string will not be matched by "Google_",
 		 * but the system vendor string will still be matched by
 		 * "GOOGLE".
@@ -358,6 +359,16 @@
 		},
 	},
 	{
+		/*
+		 * Newer machines use "Google" instead of "GOOGLE" as
+		 * DMI system vendor string.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+		},
+	},
+	{
 		/* x86-link, the Chromebook Pixel. */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
