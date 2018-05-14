Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeENILE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:11:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32818 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeENIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:15 -0400
X-Google-Smtp-Source: AB8JxZpH0n0F7OWMGW9di6U9QMjQMODRN1L0cDDk5nFXljeQPZhUUe68vXDdWmqX3UXS1JgodVuaTg==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/19 v3] regulator: tps65090: Pass descriptor instead of GPIO number
Date: Mon, 14 May 2018 10:06:33 +0200
Message-Id: <20180514080640.12515-13-linus.walleij@linaro.org>
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
- Rebase the patch on the other changes.
- Collect Lee's ACK.
---
 drivers/regulator/tps65090-regulator.c | 50 ++++++++++++--------------
 include/linux/mfd/tps65090.h           |  8 +++--
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 395f35dc8cdb..2d398fa3b720 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -19,8 +19,8 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
@@ -300,26 +300,6 @@ static int tps65090_regulator_disable_ext_control(
 	return tps65090_config_ext_control(ri, false);
 }
 
-static void tps65090_configure_regulator_config(
-		struct tps65090_regulator_plat_data *tps_pdata,
-		struct regulator_config *config)
-{
-	if (gpio_is_valid(tps_pdata->gpio)) {
-		int gpio_flag = GPIOF_OUT_INIT_LOW;
-
-		if (tps_pdata->reg_init_data->constraints.always_on ||
-				tps_pdata->reg_init_data->constraints.boot_on)
-			gpio_flag = GPIOF_OUT_INIT_HIGH;
-
-		config->ena_gpio = tps_pdata->gpio;
-		config->ena_gpio_initialized = true;
-		config->ena_gpio_flags = gpio_flag;
-	} else {
-		config->ena_gpio = -EINVAL;
-		config->ena_gpio_initialized = false;
-	}
-}
-
 #ifdef CONFIG_OF
 static struct of_regulator_match tps65090_matches[] = {
 	{ .name = "dcdc1", },
@@ -385,9 +365,26 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 		rpdata->enable_ext_control = of_property_read_bool(
 					tps65090_matches[idx].of_node,
 					"ti,enable-ext-control");
-		if (rpdata->enable_ext_control)
-			rpdata->gpio = of_get_named_gpio(np,
-					"dcdc-ext-control-gpios", 0);
+		if (rpdata->enable_ext_control) {
+			enum gpiod_flags gflags;
+
+			if (ri_data->constraints.always_on ||
+			    ri_data->constraints.boot_on)
+				gflags = GPIOD_OUT_HIGH;
+			else
+				gflags = GPIOD_OUT_LOW;
+
+			rpdata->gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
+								    tps65090_matches[idx].of_node,
+								    "dcdc-ext-control-gpios", 0,
+								    gflags,
+								    "tps65090");
+			if (IS_ERR(rpdata->gpiod))
+				return ERR_CAST(rpdata->gpiod);
+			if (!rpdata->gpiod)
+				dev_err(&pdev->dev,
+					"could not find DCDC external control GPIO\n");
+		}
 
 		if (of_property_read_u32(tps65090_matches[idx].of_node,
 					 "ti,overcurrent-wait",
@@ -455,8 +452,7 @@ static int tps65090_regulator_probe(struct platform_device *pdev)
 		 */
 		if (tps_pdata && is_dcdc(num) && tps_pdata->reg_init_data) {
 			if (tps_pdata->enable_ext_control) {
-				tps65090_configure_regulator_config(
-						tps_pdata, &config);
+				config.ena_gpiod = tps_pdata->gpiod;
 				ri->desc->ops = &tps65090_ext_control_ops;
 			} else {
 				ret = tps65090_regulator_disable_ext_control(
diff --git a/include/linux/mfd/tps65090.h b/include/linux/mfd/tps65090.h
index 67d144b3b8f9..f05bf4a146e2 100644
--- a/include/linux/mfd/tps65090.h
+++ b/include/linux/mfd/tps65090.h
@@ -83,6 +83,8 @@ enum {
 #define TPS65090_MAX_REG	TPS65090_REG_AD_OUT2
 #define TPS65090_NUM_REGS	(TPS65090_MAX_REG + 1)
 
+struct gpio_desc;
+
 struct tps65090 {
 	struct device		*dev;
 	struct regmap		*rmap;
@@ -95,8 +97,8 @@ struct tps65090 {
  * @reg_init_data: The regulator init data.
  * @enable_ext_control: Enable extrenal control or not. Only available for
  *     DCDC1, DCDC2 and DCDC3.
- * @gpio: Gpio number if external control is enabled and controlled through
- *     gpio.
+ * @gpiod: Gpio descriptor if external control is enabled and controlled through
+ *     gpio
  * @overcurrent_wait_valid: True if the overcurrent_wait should be applied.
  * @overcurrent_wait: Value to set as the overcurrent wait time.  This is the
  *     actual bitfield value, not a time in ms (valid value are 0 - 3).
@@ -104,7 +106,7 @@ struct tps65090 {
 struct tps65090_regulator_plat_data {
 	struct regulator_init_data *reg_init_data;
 	bool enable_ext_control;
-	int gpio;
+	struct gpio_desc *gpiod;
 	bool overcurrent_wait_valid;
 	int overcurrent_wait;
 };
-- 
2.17.0
