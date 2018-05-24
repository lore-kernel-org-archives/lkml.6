Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034532AbeEXTOH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:14:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034517AbeEXTOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:14:01 -0400
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: s5m8767: Pass descriptor instead of GPIO number" to the regulator tree
In-Reply-To: <20180212131717.27193-15-linus.walleij@linaro.org>
Message-Id: <E1fLvgV-0005Bw-1l@debutante>
Date: Thu, 24 May 2018 20:13:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s5m8767: Pass descriptor instead of GPIO number

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9ae5cc75ceaacf69cc50b9fd4713276c2aa62eb9 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 10:06:32 +0200
Subject: [PATCH] regulator: s5m8767: Pass descriptor instead of GPIO number

Instead of passing a global GPIO number for the enable GPIO, pass
a descriptor looked up from the device tree node for the
regulator.

This regulator supports passing platform data, but enable/sleep
regulators are looked up from the device tree exclusively, so
we can need not touch other files.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
