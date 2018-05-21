Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbeEUFot (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 01:44:49 -0400
Received: from server1.vittgam.net ([213.239.197.142]:29361 "EHLO
        mail.vittgam.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeEUFon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 01:44:43 -0400
X-DKIM: OpenDKIM Filter v2.4.2 mail.vittgam.net w4L5iZ9B083096
X-VittGamMilter-Outgoing-SubjectPrefix: [linux-kernel]
X-VittGamMilter-Outgoing-OriginalSubject: [PATCH RESEND] platform/chrome: cros_ec_lpc: Add support for newer Google devices using custom coreboot firmware or stock SeaBIOS.
Date: Mon, 21 May 2018 07:44:35 +0200
Message-Id: <201805210544.w4L5iZ9B083096@mail.vittgam.net>
From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
To: <linux-kernel@vger.kernel.org>, <bleung@chromium.org>,
        <bleung@google.com>, <olof@lixom.net>
Cc: "Salvatore Bellizzi" <lkml@seppia.net>, <groeck@chromium.org>,
        <groeck@google.com>, <dmitry.torokhov@gmail.com>
Subject: [PATCH RESEND] platform/chrome: cros_ec_lpc: Add support for newer Google devices using custom coreboot firmware or stock SeaBIOS.
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
