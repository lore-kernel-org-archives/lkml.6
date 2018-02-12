Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935265AbeBLNRt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:17:49 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40992 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935244AbeBLNRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:17:44 -0500
X-Google-Smtp-Source: AH8x225nTc5BI2RmrtS8CPOKTViDo6NTHB2gWjknd9bXvFRLJ/fOOLUHHn6XdeHlECUL4zsdlFn9eg==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/21] regulator: da9211: Pass descriptors instead of GPIO numbers
Date: Mon, 12 Feb 2018 14:17:02 +0100
Message-Id: <20180212131717.27193-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212131717.27193-1-linus.walleij@linaro.org>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This augments the DA9211 regulator driver to fetch its GPIO descriptors
directly from the device tree using the newly exported
devm_get_gpiod_from_child().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/da9211-regulator.c | 23 +++++++++++------------
 include/linux/regulator/da9211.h     |  4 +++-
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 9b8f47617724..6c122b3df5d0 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -25,7 +24,7 @@
 #include <linux/regmap.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/da9211.h>
 #include "da9211-regulator.h"
@@ -294,9 +293,12 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
 
 		pdata->init_data[n] = da9211_matches[i].init_data;
 		pdata->reg_node[n] = da9211_matches[i].of_node;
-		pdata->gpio_ren[n] =
-			of_get_named_gpio(da9211_matches[i].of_node,
-				"enable-gpios", 0);
+		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
+								  da9211_matches[i].of_node,
+								  "enable",
+								  0,
+								  GPIOD_OUT_HIGH,
+								  "da9211-enable");
 		n++;
 	}
 
@@ -382,13 +384,10 @@ static int da9211_regulator_init(struct da9211 *chip)
 		config.regmap = chip->regmap;
 		config.of_node = chip->pdata->reg_node[i];
 
-		if (gpio_is_valid(chip->pdata->gpio_ren[i])) {
-			config.ena_gpio = chip->pdata->gpio_ren[i];
-			config.ena_gpio_initialized = true;
-		} else {
-			config.ena_gpio = -EINVAL;
-			config.ena_gpio_initialized = false;
-		}
+		if (chip->pdata->gpiod_ren[i])
+			config.ena_gpiod = chip->pdata->gpiod_ren[i];
+		else
+			config.ena_gpiod = NULL;
 
 		chip->rdev[i] = devm_regulator_register(chip->dev,
 			&da9211_regulators[i], &config);
diff --git a/include/linux/regulator/da9211.h b/include/linux/regulator/da9211.h
index f2fd2d3bf58f..d1f2073e4d5f 100644
--- a/include/linux/regulator/da9211.h
+++ b/include/linux/regulator/da9211.h
@@ -21,6 +21,8 @@
 
 #define DA9211_MAX_REGULATORS	2
 
+struct gpio_desc;
+
 enum da9211_chip_id {
 	DA9211,
 	DA9212,
@@ -39,7 +41,7 @@ struct da9211_pdata {
 	 * 2 : 2 phase 2 buck
 	 */
 	int num_buck;
-	int gpio_ren[DA9211_MAX_REGULATORS];
+	struct gpio_desc *gpiod_ren[DA9211_MAX_REGULATORS];
 	struct device_node *reg_node[DA9211_MAX_REGULATORS];
 	struct regulator_init_data *init_data[DA9211_MAX_REGULATORS];
 };
-- 
2.14.3
