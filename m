Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeDELeM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:34:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33984 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeDELdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:33:24 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] mfd: cros_ec_dev: Register cros_ec_accel_legacy driver as a subdevice.
Date: Thu,  5 Apr 2018 13:33:10 +0200
Message-Id: <20180405113313.27340-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405113313.27340-1-enric.balletbo@collabora.com>
References: <20180405113313.27340-1-enric.balletbo@collabora.com>
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

Changes in v5:
- [5/8] For cros_ec_sensor_platform struct place the entries on a single line (Lee Jones)

Changes in v4:
- [5/8] Nit: EC -> ECs (Lee Jones)
- [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)

Changes in v3:
- [5/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [5/8] Add the Reviewed-by Gwendal.

 drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index e00bfb1e9030..535ffa3cf497 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -389,6 +389,69 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static struct cros_ec_sensor_platform sensor_platforms[] = {
+	{ .sensor_num = 0 },
+	{ .sensor_num = 1 }
+};
+
+static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
+	{
+		.name = "cros-ec-accel-legacy",
+		.id = 0,
+		.platform_data = &sensor_platforms[0],
+		.pdata_size = sizeof(struct cros_ec_sensor_platform),
+	},
+	{
+		.name = "cros-ec-accel-legacy",
+		.id = 1,
+		.platform_data = &sensor_platforms[1],
+		.pdata_size = sizeof(struct cros_ec_sensor_platform),
+	}
+};
+
+static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
+{
+	struct cros_ec_device *ec_dev = ec->ec_dev;
+	u8 status;
+	int ret;
+
+	/*
+	 * ECs that need legacy support are the main EC, directly connected to
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
+	ret = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+			      cros_ec_accel_legacy_cells,
+			      ARRAY_SIZE(cros_ec_accel_legacy_cells),
+			      NULL, 0, NULL);
+	if (ret)
+		dev_err(ec_dev->dev, "failed to add EC sensors\n");
+}
+
 static const struct mfd_cell cros_ec_rtc_cells[] = {
 	{ .name = "cros-ec-rtc" }
 };
@@ -440,6 +503,9 @@ static int ec_device_probe(struct platform_device *pdev)
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
+	else
+		/* Workaroud for older EC firmware */
+		cros_ec_accel_legacy_register(ec);
 
 	/* Check whether this EC instance has RTC host command support */
 	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
-- 
2.16.3
