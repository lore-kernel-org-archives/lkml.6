Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeENITC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:19:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38112 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeENIG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:06:57 -0400
X-Google-Smtp-Source: AB8JxZqoHgAKxSPt8LH2pF71cLblIf3pAeJ1L+XWqP6hPdej9C3zWNfb+xw48STsgsTiVsJ2Y+eFrA==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 04/19 v3] regulator: max8973: Pass descriptor instead of GPIO number
Date: Mon, 14 May 2018 10:06:25 +0200
Message-Id: <20180514080640.12515-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a global GPIO number, pass a descriptor looked
up with the standard devm_gpiod_get_optional() call.

Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
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
