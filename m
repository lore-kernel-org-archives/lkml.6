Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031599AbeBNWDU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:03:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55649 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031524AbeBNWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:03:18 -0500
X-Google-Smtp-Source: AH8x226cVHTeHM8wohYxVN4ZIJULiKvxeeLKgEZ5lNMGNECfyKC+ZAFUS2QEDEiQ10YO48neB0lzXA==
From: Richard Lai <richard@richardman.com>
Cc: richard@richardman.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: chemical: ccs811: Corrected firmware boot/application mode transition
Date: Wed, 14 Feb 2018 22:02:36 +0000
Message-Id: <1518645768-2908-1-git-send-email-richard@richardman.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCS811 has different I2C register maps in boot and application mode. When
CCS811 is in boot mode, register APP_START (0xF4) is used to transit the
firmware state from boot to application mode. However, APP_START is not a
valid register location when CCS811 is in application mode (refer to
"CCS811 Bootloader Register Map" and "CCS811 Application Register Map" in
CCS811 datasheet). The driver should not attempt to perform a write to
APP_START while CCS811 is in application mode, as this is not a valid or
documented register location.

When prob function is being called, the driver assumes the CCS811 sensor
is in boot mode, and attempts to perform a write to APP_START. Although
CCS811 powers-up in boot mode, it may have already been transited to
application mode by previous instances, e.g. unload and reload device
driver by the system, or explicitly by user. Depending on the system
design, CCS811 sensor may be permanently connected to system power source
rather than power controlled by GPIO, hence it is possible that the sensor
is never power reset, thus the firmware could be in either boot or
application mode at any given time when driver prob function is being
called.

This patch:

1) Checks the STATUS register before attempting to send a write to
	APP_START. Only if the firmware is not in application mode and has
	valid firmware application loaded, then it will continue to start
	transiting the firmware boot to application mode.
2) Adds two macros for checking APP_VALID and FW_MODE bits in the STATUS
	register of CCS811 sensor.

Signed-off-by: Richard Lai <richard@richardman.com>
---
 drivers/iio/chemical/ccs811.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 840a6cb..4806aed 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -52,6 +52,11 @@
 #define CCS811_STATUS_FW_MODE_MASK	BIT(7)
 #define CCS811_STATUS_FW_MODE_APPLICATION	BIT(7)
 
+#define IS_APP_VALID_LOADED(x) \
+	(CCS811_STATUS_APP_VALID_LOADED == (CCS811_STATUS_APP_VALID_MASK & x))
+#define IS_FW_MODE_APPLICATION(x) \
+	(CCS811_STATUS_FW_MODE_APPLICATION == (CCS811_STATUS_FW_MODE_MASK & x))
+
 /* Measurement modes */
 #define CCS811_MODE_IDLE	0x00
 #define CCS811_MODE_IAQ_1SEC	0x10
@@ -129,8 +134,10 @@ static int ccs811_start_sensor_application(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if ((ret & CCS811_STATUS_APP_VALID_MASK) !=
-	    CCS811_STATUS_APP_VALID_LOADED)
+	if (IS_FW_MODE_APPLICATION(ret))
+		return 0;
+
+	if (!IS_APP_VALID_LOADED(ret))
 		return -EIO;
 
 	ret = i2c_smbus_write_byte(client, CCS811_APP_START);
@@ -141,8 +148,7 @@ static int ccs811_start_sensor_application(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if ((ret & CCS811_STATUS_FW_MODE_MASK) !=
-	    CCS811_STATUS_FW_MODE_APPLICATION) {
+	if (!IS_FW_MODE_APPLICATION(ret)) {
 		dev_err(&client->dev, "Application failed to start. Sensor is still in boot mode.\n");
 		return -EIO;
 	}
-- 
2.7.4
