Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeBZK1o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:27:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48346 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeBZK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:26:18 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] mfd: cros_ec_dev: Register cros_ec_accel_legacy driver as a subdevice.
Date: Mon, 26 Feb 2018 11:26:03 +0100
Message-Id: <20180226102606.15093-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180226102606.15093-1-enric.balletbo@collabora.com>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, the cros_ec_ctl driver will register the legacy
accelerometer driver (named cros_ec_accel_legacy) if it fails to
register sensors through the usual path cros_ec_sensors_register().
This legacy device is present on Chromebook devices with older EC
firmware only supporting deprecated EC commands (Glimmer based devices).

Tested-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3:
- [5/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [5/8] Add the Reviewed-by Gwendal.

 drivers/mfd/cros_ec_dev.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 33fe1b439ee2..fd7f0068fb45 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -389,6 +389,63 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+#define CROS_EC_SENSOR_LEGACY_NUM 2
+static struct mfd_cell cros_ec_accel_legacy_cells[CROS_EC_SENSOR_LEGACY_NUM];
+
+static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
+{
+	struct cros_ec_device *ec_dev = ec->ec_dev;
+	u8 status;
+	int i, ret;
+	struct cros_ec_sensor_platform
+		sensor_platforms[CROS_EC_SENSOR_LEGACY_NUM];
+
+	/*
+	 * EC that need legacy support are the main EC, directly connected to
+	 * the AP.
+	 */
+	if (ec->cmd_offset != 0)
+		return;
+
+	/*
+	 * Check if EC supports direct memory reads and if EC has
+	 * accelerometers.
+	 */
+	if (!ec_dev->cmd_readmem)
+		return;
+
+	ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1, &status);
+	if (ret < 0) {
+		dev_warn(ec->dev, "EC does not support direct reads.\n");
+		return;
+	}
+
+	/* Check if EC has accelerometers. */
+	if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
+		dev_info(ec->dev, "EC does not have accelerometers.\n");
+		return;
+	}
+
+	/*
+	 * Register 2 accelerometers
+	 */
+	for (i = 0; i < CROS_EC_SENSOR_LEGACY_NUM; i++) {
+		cros_ec_accel_legacy_cells[i].name = "cros-ec-accel-legacy";
+		sensor_platforms[i].sensor_num = i;
+		cros_ec_accel_legacy_cells[i].id = i;
+		cros_ec_accel_legacy_cells[i].platform_data =
+			&sensor_platforms[i];
+		cros_ec_accel_legacy_cells[i].pdata_size =
+			sizeof(struct cros_ec_sensor_platform);
+	}
+	ret = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+			      cros_ec_accel_legacy_cells,
+			      CROS_EC_SENSOR_LEGACY_NUM,
+			      NULL, 0, NULL);
+	if (ret)
+		dev_err(ec_dev->dev, "failed to add EC sensors\n");
+}
+
 static const struct mfd_cell cros_ec_rtc_cell = {
 	.name = "cros-ec-rtc",
 };
@@ -440,6 +497,9 @@ static int ec_device_probe(struct platform_device *pdev)
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
+	else
+		/* Workaroud for older EC firmware */
+		cros_ec_accel_legacy_register(ec);
 
 	/* check whether this EC instance has RTC host command support */
 	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
-- 
2.16.1
