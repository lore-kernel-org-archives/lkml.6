Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeEOMrh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:47:37 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40450 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753500AbeEOMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:47:30 -0400
X-Google-Smtp-Source: AB8JxZpL2ESeRCHaodEW0vqxTmYbgUXNnVAoYcbTI2m1SFVM9ddDJoprDPoAmuy9INBOEo9CWRSAgg==
From: Neil Armstrong <narmstrong@baylibre.com>
To: airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mfd: cros_ec_dev: Add CEC sub-device registration
Date: Tue, 15 May 2018 14:47:00 +0200
Message-Id: <1526388421-18808-5-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526388421-18808-1-git-send-email-narmstrong@baylibre.com>
References: <1526388421-18808-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC can expose a CEC bus, thus add the cros-ec-cec MFD sub-device
when the CEC feature bit is present.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index eafd06f..57064ec 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -383,6 +383,18 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static void cros_ec_cec_register(struct cros_ec_dev *ec)
+{
+	int ret;
+	struct mfd_cell cec_cell = {
+		.name = "cros-ec-cec",
+	};
+
+	ret = mfd_add_devices(ec->dev, 0, &cec_cell, 1, NULL, 0, NULL);
+	if (ret)
+		dev_err(ec->dev, "failed to add EC CEC\n");
+}
+
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -422,6 +434,10 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
+	/* check whether this EC handles CEC. */
+	if (cros_ec_check_features(ec, EC_FEATURE_CEC))
+		cros_ec_cec_register(ec);
+
 	/* Take control of the lightbar from the EC. */
 	lb_manual_suspend_ctrl(ec, 1);
 
-- 
2.7.4
