Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeBSWlC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:41:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46550 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeBSWlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:41:00 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: groeck@chromium.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 3/6] mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice.
Date: Mon, 19 Feb 2018 23:40:53 +0100
Message-Id: <20180219224053.21458-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether this EC instance has RTC host command support and instatiate
the RTC driver as a subdevice in such case.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/cros_ec_dev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index e4fafdd96e5e..e0c604ab380f 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -389,6 +389,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static const struct mfd_cell cros_ec_rtc_cell = {
+	.name = "cros-ec-rtc",
+};
+
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -437,6 +441,16 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
+	/* check whether this EC instance has RTC host command support */
+	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
+		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+					 &cros_ec_rtc_cell, 1, NULL, 0, NULL);
+		if (retval)
+			dev_err(ec->dev,
+				"failed to add cros-ec-rtc device: %d\n",
+				retval);
+	}
+
 	/* Take control of the lightbar from the EC. */
 	lb_manual_suspend_ctrl(ec, 1);
 
-- 
2.16.1
