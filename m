Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeEVXIq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:08:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42650 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeEVXIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:08:45 -0400
X-Google-Smtp-Source: AB8JxZpBBEicFPK4BRrcaOxYwpeKm2cajxG4BaIVV2YLBBsfUoMj/msz2lkDEdV7j2EClLv0yoUMJw==
Date: Tue, 22 May 2018 16:08:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benson Leung <bleung@chromium.org>
Cc: Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Vittorio Gambaletta <linuxbugs@vittgam.net>,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_lpc: do not try DMI match when ACPI
 device found
Message-ID: <20180522230841.GA22026@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older models of Chromebooks did not describe the LPC EC in their ACPI
tables; starting with Strago-based devices Google is using GOOG0004 device
to describe EC LPC.

DMI-based match is fragile and does not work reliably, especially when
using custom firmware. It is also not needed when we can locate the right
ACPI device, so let's stop bailing out when DMI does not match but the
right ACPI device is present.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index af89e82eecd23..a000d2fbbb0be 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -419,7 +419,13 @@ static int __init cros_ec_lpc_init(void)
 	int ret;
 	acpi_status status;
 
-	if (!dmi_check_system(cros_ec_lpc_dmi_table)) {
+	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
+				  &cros_ec_lpc_acpi_device_found, NULL);
+	if (ACPI_FAILURE(status))
+		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
+
+	if (!cros_ec_lpc_acpi_device_found &&
+	    !dmi_check_system(cros_ec_lpc_dmi_table)) {
 		pr_err(DRV_NAME ": unsupported system.\n");
 		return -ENODEV;
 	}
@@ -434,11 +440,6 @@ static int __init cros_ec_lpc_init(void)
 		return ret;
 	}
 
-	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
-				  &cros_ec_lpc_acpi_device_found, NULL);
-	if (ACPI_FAILURE(status))
-		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
-
 	if (!cros_ec_lpc_acpi_device_found) {
 		/* Register the device, and it'll get hooked up automatically */
 		ret = platform_device_register(&cros_ec_lpc_device);
-- 
2.17.0.441.gb46fe60e1d-goog


-- 
Dmitry
