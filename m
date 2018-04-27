Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932881AbeD0QGP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:06:15 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43346 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758639AbeD0QF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:05:27 -0400
X-Google-Smtp-Source: AB8JxZorVNLjFxMKioQllqA3+m8CcSck8zP4ho/OYJV5WhcADtvqpJK82RHTDc3oib+tXJJwERYviw==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 3/4] power: supply: max8998-charger: Parse device tree for required data.
Date: Fri, 27 Apr 2018 18:03:01 +0200
Message-Id: <1524844982-4714-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing code for reading charger configuration
from devicetree.

Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/power/supply/max8998_charger.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index 66438029bdd0..8fa0c3357625 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -21,6 +21,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -82,6 +83,49 @@ static const struct power_supply_desc max8998_battery_desc = {
 	.num_properties	= ARRAY_SIZE(max8998_battery_props),
 };
 
+static int max8998_pmic_dt_parse_pdata(struct max8998_dev *iodev,
+					struct max8998_platform_data *pdata)
+{
+	struct device_node *pmic_np = iodev->dev->of_node;
+	struct device_node *charger_np;
+	int ret;
+
+	charger_np = of_get_child_by_name(pmic_np, "charger");
+	if (!charger_np) {
+		dev_err(iodev->dev, "could not find charger sub-node\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"max8998,charge-eoc",
+					&pdata->eoc);
+	if (ret < 0) {
+		dev_err(iodev->dev,
+			"Could not find max8998,charge-eoc in devicetree\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"max8998,charge-restart",
+					&pdata->restart);
+	if (ret < 0) {
+		dev_err(iodev->dev,
+			"Could not find max8998,charge-restart in devicetree\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"max8998,charge-timeout",
+					&pdata->timeout);
+	if (ret < 0) {
+		dev_err(iodev->dev,
+			"Could not find max8998,charge-timeout in devicetree\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
@@ -96,6 +140,12 @@ static int max8998_battery_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_OF) && iodev->dev->of_node) {
+		ret = max8998_pmic_dt_parse_pdata(iodev, pdata);
+		if (ret)
+			return ret;
+	}
+
 	max8998 = devm_kzalloc(&pdev->dev, sizeof(struct max8998_battery_data),
 				GFP_KERNEL);
 	if (!max8998)
-- 
2.7.4
