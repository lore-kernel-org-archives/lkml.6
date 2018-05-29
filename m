Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965139AbeE2PAI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:00:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42306 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936475AbeE2PAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:00:04 -0400
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Applied "regulator: s2mps11: Fix boot on Odroid XU3" to the regulator tree
In-Reply-To: 
Message-Id: <E1fNg6U-0006FE-CO@debutante>
Date: Tue, 29 May 2018 16:00:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mps11: Fix boot on Odroid XU3

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

>From 37fa23dbccbd97663acc085bd79246f427e603a1 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Sat, 26 May 2018 11:03:17 +0100
Subject: [PATCH] regulator: s2mps11: Fix boot on Odroid XU3

The change to descriptors in 0369e02b75 "regulator: s2mps11: Pass
descriptor instead of GPIO number" has broken the boot on Odroid XU3
according to kernelci so let's revert that for now.  We get a NULL
pointer defererence in:

[    2.467929] [] (validate_desc) from [] (gpiod_set_value_cansleep+0x14/0x30)
[    2.476591] [] (gpiod_set_value_cansleep) from [] (_regulator_do_enable+0x2f8/0x370)
[    2.486032] [] (_regulator_do_enable) from [] (regulator_register+0xc54/0x1280)
[    2.495045] [] (regulator_register) from [] (devm_regulator_register+0x40/0x7c)
[    2.504057] [] (devm_regulator_register) from [] (s2mps11_pmic_probe+0x1c0/0x444)
[    2.513243] [] (s2mps11_pmic_probe) from [] (platform_drv_probe+0x6c/0xa4)

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mps11.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 9a1dca26362e..7726b874e539 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -18,7 +18,7 @@
 
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -27,6 +27,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
+#include <linux/of_gpio.h>
 #include <linux/mfd/samsung/core.h>
 #include <linux/mfd/samsung/s2mps11.h>
 #include <linux/mfd/samsung/s2mps13.h>
@@ -56,7 +57,7 @@ struct s2mps11_info {
 	 * Array (size: number of regulators) with GPIO-s for external
 	 * sleep control.
 	 */
-	struct gpio_desc **ext_control_gpiod;
+	int *ext_control_gpio;
 };
 
 static int get_ramp_delay(int ramp_delay)
@@ -523,7 +524,7 @@ static int s2mps14_regulator_enable(struct regulator_dev *rdev)
 	case S2MPS14X:
 		if (test_bit(rdev_get_id(rdev), s2mps11->suspend_state))
 			val = S2MPS14_ENABLE_SUSPEND;
-		else if (s2mps11->ext_control_gpiod[rdev_get_id(rdev)])
+		else if (gpio_is_valid(s2mps11->ext_control_gpio[rdev_get_id(rdev)]))
 			val = S2MPS14_ENABLE_EXT_CONTROL;
 		else
 			val = rdev->desc->enable_mask;
@@ -817,7 +818,7 @@ static int s2mps14_pmic_enable_ext_control(struct s2mps11_info *s2mps11,
 static void s2mps14_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
 		struct of_regulator_match *rdata, struct s2mps11_info *s2mps11)
 {
-	struct gpio_desc **gpio = s2mps11->ext_control_gpiod;
+	int *gpio = s2mps11->ext_control_gpio;
 	unsigned int i;
 	unsigned int valid_regulators[3] = { S2MPS14_LDO10, S2MPS14_LDO11,
 		S2MPS14_LDO12 };
@@ -828,20 +829,11 @@ static void s2mps14_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
 		if (!rdata[reg].init_data || !rdata[reg].of_node)
 			continue;
 
-		gpio[reg] = devm_gpiod_get_from_of_node(&pdev->dev,
-							rdata[reg].of_node,
-							"samsung,ext-control-gpios",
-							0,
-							GPIOD_OUT_HIGH,
-							"s2mps11-LDO");
-		if (IS_ERR(gpio[reg])) {
-			dev_err(&pdev->dev, "Failed to get control GPIO for %d/%s\n",
-				reg, rdata[reg].name);
-			continue;
-		}
-		if (gpio[reg])
-			dev_dbg(&pdev->dev, "Using GPIO for ext-control over %d/%s\n",
-				reg, rdata[reg].name);
+		gpio[reg] = of_get_named_gpio(rdata[reg].of_node,
+				"samsung,ext-control-gpios", 0);
+		if (gpio_is_valid(gpio[reg]))
+			dev_dbg(&pdev->dev, "Using GPIO %d for ext-control over %d/%s\n",
+					gpio[reg], reg, rdata[reg].name);
 	}
 }
 
@@ -1147,11 +1139,17 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s2mps11->ext_control_gpiod = devm_kmalloc(&pdev->dev,
-			sizeof(*s2mps11->ext_control_gpiod) * rdev_num,
+	s2mps11->ext_control_gpio = devm_kmalloc(&pdev->dev,
+			sizeof(*s2mps11->ext_control_gpio) * rdev_num,
 			GFP_KERNEL);
-	if (!s2mps11->ext_control_gpiod)
+	if (!s2mps11->ext_control_gpio)
 		return -ENOMEM;
+	/*
+	 * 0 is a valid GPIO so initialize all GPIO-s to negative value
+	 * to indicate that external control won't be used for this regulator.
+	 */
+	for (i = 0; i < rdev_num; i++)
+		s2mps11->ext_control_gpio[i] = -EINVAL;
 
 	if (!iodev->dev->of_node) {
 		if (iodev->pdata) {
@@ -1181,6 +1179,8 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 	config.dev = &pdev->dev;
 	config.regmap = iodev->regmap_pmic;
 	config.driver_data = s2mps11;
+	config.ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
+	config.ena_gpio_initialized = true;
 	for (i = 0; i < rdev_num; i++) {
 		struct regulator_dev *regulator;
 
@@ -1191,7 +1191,7 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 			config.init_data = rdata[i].init_data;
 			config.of_node = rdata[i].of_node;
 		}
-		config.ena_gpiod = s2mps11->ext_control_gpiod[i];
+		config.ena_gpio = s2mps11->ext_control_gpio[i];
 
 		regulator = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
@@ -1202,7 +1202,7 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (s2mps11->ext_control_gpiod[i]) {
+		if (gpio_is_valid(s2mps11->ext_control_gpio[i])) {
 			ret = s2mps14_pmic_enable_ext_control(s2mps11,
 					regulator);
 			if (ret < 0) {
-- 
2.17.0
