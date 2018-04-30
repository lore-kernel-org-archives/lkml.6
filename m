Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbeD3NOT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:14:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51908 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeD3NOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:14:15 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
Subject: [PATCH v2 3/3] mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.
Date: Mon, 30 Apr 2018 15:14:03 +0200
Message-Id: <20180430131403.14296-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430131403.14296-1-enric.balletbo@collabora.com>
References: <20180430131403.14296-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether this EC instance has USBPD host command support and
instatiate the cros_usbpd-charger driver as a subdevice in such case.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- [3/3] Use ARRAY_SIZE instead of hardcoded 1.

 drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 1d6dc5c7a19d..d06870da3a2e 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -387,6 +387,10 @@ static const struct mfd_cell cros_ec_rtc_cells[] = {
 	{ .name = "cros-ec-rtc" }
 };
 
+static const struct mfd_cell cros_usbpd_charger_cells[] = {
+	{ .name = "cros-usbpd-charger" }
+};
+
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -438,6 +442,18 @@ static int ec_device_probe(struct platform_device *pdev)
 				retval);
 	}
 
+	/* Check whether this EC instance has the PD charge manager */
+	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
+		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+					 cros_usbpd_charger_cells,
+					 ARRAY_SIZE(cros_usbpd_charger_cells),
+					 NULL, 0, NULL);
+		if (retval)
+			dev_err(ec->dev,
+				"failed to add cros-usbpd-charger device: %d\n",
+				retval);
+	}
+
 	/* Take control of the lightbar from the EC. */
 	lb_manual_suspend_ctrl(ec, 1);
 
-- 
2.17.0
