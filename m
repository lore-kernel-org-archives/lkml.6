Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeENIHQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:07:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41495 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeENIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:13 -0400
X-Google-Smtp-Source: AB8JxZotUE2opLbFNzKkmu+vyJFSxPjXDBoKZ5gT+RlKRaX+LJvqDam97Lhe2L4tmohj6MGEwwKKEw==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/19 v3] regulator: s5m8767: Pass descriptor instead of GPIO number
Date: Mon, 14 May 2018 10:06:32 +0200
Message-Id: <20180514080640.12515-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a global GPIO number for the enable GPIO, pass
a descriptor looked up from the device tree node for the
regulator.

This regulator supports passing platform data, but enable/sleep
regulators are looked up from the device tree exclusively, so
we can need not touch other files.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes
- Collect Lee's ACK.
---
 drivers/regulator/s5m8767.c      | 26 +++++++++++++++-----------
 include/linux/mfd/samsung/core.h |  4 +++-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 4836947e1521..b8443a360646 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -13,6 +13,7 @@
 
 #include <linux/err.h>
 #include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
@@ -459,15 +460,14 @@ static void s5m8767_regulator_config_ext_control(struct s5m8767_info *s5m8767,
 		return;
 	}
 
-	if (!gpio_is_valid(rdata->ext_control_gpio)) {
+	if (!rdata->ext_control_gpiod) {
 		dev_warn(s5m8767->dev,
 				"ext-control for %s: GPIO not valid, ignoring\n",
-				rdata->reg_node->name);
+			 rdata->reg_node->name);
 		return;
 	}
 
-	config->ena_gpio = rdata->ext_control_gpio;
-	config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
+	config->ena_gpiod = rdata->ext_control_gpiod;
 }
 
 /*
@@ -577,8 +577,14 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 			continue;
 		}
 
-		rdata->ext_control_gpio = of_get_named_gpio(reg_np,
-			"s5m8767,pmic-ext-control-gpios", 0);
+		rdata->ext_control_gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
+								       reg_np,
+								       "s5m8767,pmic-ext-control-gpios",
+								       0,
+								       GPIOD_OUT_HIGH,
+								       "s5m8767");
+		if (IS_ERR(rdata->ext_control_gpiod))
+			return PTR_ERR(rdata->ext_control_gpiod);
 
 		rdata->id = i;
 		rdata->initdata = of_get_regulator_init_data(
@@ -954,10 +960,8 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 		config.driver_data = s5m8767;
 		config.regmap = iodev->regmap_pmic;
 		config.of_node = pdata->regulators[i].reg_node;
-		config.ena_gpio = -EINVAL;
-		config.ena_gpio_flags = 0;
-		config.ena_gpio_initialized = true;
-		if (gpio_is_valid(pdata->regulators[i].ext_control_gpio))
+		config.ena_gpiod = NULL;
+		if (pdata->regulators[i].ext_control_gpiod)
 			s5m8767_regulator_config_ext_control(s5m8767,
 					&pdata->regulators[i], &config);
 
@@ -970,7 +974,7 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		if (gpio_is_valid(pdata->regulators[i].ext_control_gpio)) {
+		if (pdata->regulators[i].ext_control_gpiod) {
 			ret = s5m8767_enable_ext_control(s5m8767, rdev);
 			if (ret < 0) {
 				dev_err(s5m8767->dev,
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index 5a23dd4df432..28f4ae76271d 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -39,6 +39,8 @@
 #define STEP_12_5_MV		12500
 #define STEP_6_25_MV		6250
 
+struct gpio_desc;
+
 enum sec_device_type {
 	S5M8751X,
 	S5M8763X,
@@ -151,7 +153,7 @@ struct sec_regulator_data {
 	int				id;
 	struct regulator_init_data	*initdata;
 	struct device_node		*reg_node;
-	int				ext_control_gpio;
+	struct gpio_desc		*ext_control_gpiod;
 };
 
 /*
-- 
2.17.0
