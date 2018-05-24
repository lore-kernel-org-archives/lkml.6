Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965653AbeEXI4B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:56:01 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40051 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965605AbeEXIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:55:15 -0400
X-Google-Smtp-Source: AB8JxZpow2wi+FGtSfgTS6xPuohw8XrKsJUds/4y18GiLfU0jUAFNyKvAjAcxWsXUdHgaW7SSSOGmw==
From: Neil Armstrong <narmstrong@baylibre.com>
To: airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
Subject: [PATCH v5 5/6] mfd: cros_ec_dev: Add CEC sub-device registration
Date: Thu, 24 May 2018 10:55:00 +0200
Message-Id: <1527152101-17278-6-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527152101-17278-1-git-send-email-narmstrong@baylibre.com>
References: <1527152101-17278-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC can expose a CEC bus, thus add the cros-ec-cec MFD sub-device
when the CEC feature bit is present.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 1d6dc5c..272969e 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -383,6 +383,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static const struct mfd_cell cros_ec_cec_cells[] = {
+	{ .name = "cros-ec-cec" }
+};
+
 static const struct mfd_cell cros_ec_rtc_cells[] = {
 	{ .name = "cros-ec-rtc" }
 };
@@ -426,6 +430,18 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
+	/* Check whether this EC instance has CEC host command support */
+	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
+		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+					 cros_ec_cec_cells,
+					 ARRAY_SIZE(cros_ec_cec_cells),
+					 NULL, 0, NULL);
+		if (retval)
+			dev_err(ec->dev,
+				"failed to add cros-ec-cec device: %d\n",
+				retval);
+	}
+
 	/* Check whether this EC instance has RTC host command support */
 	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
 		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-- 
2.7.4
