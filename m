Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeCTM3T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:29:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48648 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753134AbeCTM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:28:02 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice.
Date: Tue, 20 Mar 2018 13:27:47 +0100
Message-Id: <20180320122751.14019-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320122751.14019-1-enric.balletbo@collabora.com>
References: <20180320122751.14019-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether this EC instance has RTC host command support and instatiate
the RTC driver as a subdevice in such case.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v4:
- [4/8] Nit: check -> Check (Lee Jones)
- [4/8] Use ARRAY_SIZE() instead of hardcoded number (Lee Jones)

Changes in v3:
- [4/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [4/8] Add the Reviewed-by Gwendal.

 drivers/mfd/cros_ec_dev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index f98e5beffca6..f60a53f11942 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -389,6 +389,12 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static const struct mfd_cell cros_ec_rtc_cells[] = {
+	{
+		.name = "cros-ec-rtc",
+	}
+};
+
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -437,6 +443,18 @@ static int ec_device_probe(struct platform_device *pdev)
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
2.16.2
