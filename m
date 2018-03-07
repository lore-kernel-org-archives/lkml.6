Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeCGOCr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:02:47 -0500
Received: from broccolo.seppia.net ([185.61.148.186]:57704 "EHLO
        broccolo.seppia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCGOCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:02:41 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.seppia.net 5A1361E001D
From: Salvatore Bellizzi <lkml@seppia.net>
To: <linux-kernel@vger.kernel.org>, <bleung@chromium.org>,
        <olof@lixom.net>
Cc: <linuxbugs@vittgam.net>
Subject: [RESEND][PATCH] platform/chrome: cros_ec_lpc: Add support for Google devices using custom coreboot firmware
Content-Type: text/plain; charset=UTF-8
Message-ID: <cros-ec-patch-20180307@mail.seppia.net>
Date: Wed,  7 Mar 2018 14:56:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds generic device information to the DMI table of
the cros_ec_lpc driver, needed for Chromebooks/boxes using a
custom coreboot firmware.

The DMI info would not contain "Google_*" as BIOS version string,
instead the system vendor string would still be "GOOGLE", so this
seems to be a reasonable match for every Chromebook/box running
a custom firmware.

Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
---
 drivers/platform/chrome/cros_ec_lpc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index af89e82eecd2..c8450ae3cd60 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -341,6 +341,18 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BIOS_VERSION, "Google_"),
 		},
 	},
+	{
+		/*
+		 * If the box is running custom coreboot firmware then the
+		 * DMI BIOS version string will not be matched by "Google_",
+		 * but the system vendor string will still be matched by
+		 * "GOOGLE".
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
+		},
+	},
 	{
 		/* x86-link, the Chromebook Pixel. */
 		.matches = {
-- 
2.16.2
