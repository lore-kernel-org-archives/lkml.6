Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161170AbeEXTOe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:14:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56596 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967742AbeEXTO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:14:28 -0400
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max8973: Pass descriptor instead of GPIO number" to the regulator tree
In-Reply-To: <20180212131717.27193-8-linus.walleij@linaro.org>
Message-Id: <E1fLvgt-00069Z-0U@debutante>
Date: Thu, 24 May 2018 20:14:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8973: Pass descriptor instead of GPIO number

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

>From e7d2be696faa3c8add5b21006ad8fec6b6ed85f1 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 10:06:25 +0200
Subject: [PATCH] regulator: max8973: Pass descriptor instead of GPIO number

Instead of passing a global GPIO number, pass a descriptor looked
up with the standard devm_gpiod_get_optional() call.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8973-regulator.c | 54 ++++++++++++++-------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index e0c747aa9f85..7cd493ec6315 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -34,6 +34,7 @@
 #include <linux/regulator/max8973-regulator.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_gpio.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
@@ -114,7 +115,6 @@ struct max8973_chip {
 	struct regulator_desc desc;
 	struct regmap *regmap;
 	bool enable_external_control;
-	int enable_gpio;
 	int dvs_gpio;
 	int lru_index[MAX8973_MAX_VOUT_REG];
 	int curr_vout_val[MAX8973_MAX_VOUT_REG];
@@ -567,7 +567,6 @@ static struct max8973_regulator_platform_data *max8973_parse_dt(
 
 	pdata->enable_ext_control = of_property_read_bool(np,
 						"maxim,externally-enable");
-	pdata->enable_gpio = of_get_named_gpio(np, "maxim,enable-gpio", 0);
 	pdata->dvs_gpio = of_get_named_gpio(np, "maxim,dvs-gpio", 0);
 
 	ret = of_property_read_u32(np, "maxim,dvs-default-state", &pval);
@@ -633,6 +632,8 @@ static int max8973_probe(struct i2c_client *client,
 	struct max8973_chip *max;
 	bool pdata_from_dt = false;
 	unsigned int chip_id;
+	struct gpio_desc *gpiod;
+	enum gpiod_flags gflags;
 	int ret;
 
 	pdata = dev_get_platdata(&client->dev);
@@ -647,8 +648,7 @@ static int max8973_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	if ((pdata->dvs_gpio == -EPROBE_DEFER) ||
-		(pdata->enable_gpio == -EPROBE_DEFER))
+	if (pdata->dvs_gpio == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
 	max = devm_kzalloc(&client->dev, sizeof(*max), GFP_KERNEL);
@@ -696,15 +696,11 @@ static int max8973_probe(struct i2c_client *client,
 	max->desc.n_voltages = MAX8973_BUCK_N_VOLTAGE;
 
 	max->dvs_gpio = (pdata->dvs_gpio) ? pdata->dvs_gpio : -EINVAL;
-	max->enable_gpio = (pdata->enable_gpio) ? pdata->enable_gpio : -EINVAL;
 	max->enable_external_control = pdata->enable_ext_control;
 	max->curr_gpio_val = pdata->dvs_def_state;
 	max->curr_vout_reg = MAX8973_VOUT + pdata->dvs_def_state;
 	max->junction_temp_warning = pdata->junction_temp_warning;
 
-	if (gpio_is_valid(max->enable_gpio))
-		max->enable_external_control = true;
-
 	max->lru_index[0] = max->curr_vout_reg;
 
 	if (gpio_is_valid(max->dvs_gpio)) {
@@ -757,27 +753,35 @@ static int max8973_probe(struct i2c_client *client,
 			break;
 		}
 
-		if (gpio_is_valid(max->enable_gpio)) {
-			config.ena_gpio_flags = GPIOF_OUT_INIT_LOW;
-			if (ridata && (ridata->constraints.always_on ||
-					ridata->constraints.boot_on))
-				config.ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
-			config.ena_gpio = max->enable_gpio;
+		if (ridata && (ridata->constraints.always_on ||
+			       ridata->constraints.boot_on))
+			gflags = GPIOD_OUT_HIGH;
+		else
+			gflags = GPIOD_OUT_LOW;
+		gpiod = devm_gpiod_get_optional(&client->dev,
+						"maxim,enable",
+						gflags);
+		if (IS_ERR(gpiod))
+			return PTR_ERR(gpiod);
+		if (gpiod) {
+			config.ena_gpiod = gpiod;
+			max->enable_external_control = true;
 		}
+
 		break;
 
 	case MAX77621:
-		if (gpio_is_valid(max->enable_gpio)) {
-			ret = devm_gpio_request_one(&client->dev,
-					max->enable_gpio, GPIOF_OUT_INIT_HIGH,
-					"max8973-en-gpio");
-			if (ret) {
-				dev_err(&client->dev,
-					"gpio_request for gpio %d failed: %d\n",
-					max->enable_gpio, ret);
-				return ret;
-			}
-		}
+		/*
+		 * We do not let the core switch this regulator on/off,
+		 * we just leave it on.
+		 */
+		gpiod = devm_gpiod_get_optional(&client->dev,
+						"maxim,enable",
+						GPIOD_OUT_HIGH);
+		if (IS_ERR(gpiod))
+			return PTR_ERR(gpiod);
+		if (gpiod)
+			max->enable_external_control = true;
 
 		max->desc.enable_reg = MAX8973_VOUT;
 		max->desc.enable_mask = MAX8973_VOUT_ENABLE;
-- 
2.17.0
