Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeDRKZD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:25:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55512 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeDRKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:24:16 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v5 4/7] mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice.
Date: Wed, 18 Apr 2018 12:24:01 +0200
Message-Id: <20180418102405.17790-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418102405.17790-1-enric.balletbo@collabora.com>
References: <20180418102405.17790-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether this EC instance has RTC host command support and instatiate
the RTC driver as a subdevice in such case.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v5:
- [4/8] For mfd_cell struct use one line and no need for the comma.

Changes in v4:
- [4/8] Nit: check -> Check (Lee Jones)
- [4/8] Use ARRAY_SIZE() instead of hardcoded number (Lee Jones)

Changes in v3:
- [4/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [4/8] Add the Reviewed-by Gwendal.

 drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 5a7d4e1dea70..a393b3c11aa0 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -383,6 +383,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static const struct mfd_cell cros_ec_rtc_cells[] = {
+	{ .name = "cros-ec-rtc" }
+};
+
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -422,6 +426,18 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
+	/* Check whether this EC instance has RTC host command support */
+	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
+		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+					 cros_ec_rtc_cells,
+					 ARRAY_SIZE(cros_ec_rtc_cells),
+					 NULL, 0, NULL);
+		if (retval)
+			dev_err(ec->dev,
+				"failed to add cros-ec-rtc device: %d\n",
+				retval);
+	}
+
 	/* Take control of the lightbar from the EC. */
 	lb_manual_suspend_ctrl(ec, 1);
 
-- 
2.17.0
