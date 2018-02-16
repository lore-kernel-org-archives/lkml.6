Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161749AbeBPRMW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:12:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48224 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161066AbeBPRMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:12:20 -0500
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9211: Pass descriptors instead of GPIO numbers" to the regulator tree
In-Reply-To: <20180212131717.27193-7-linus.walleij@linaro.org>
Message-Id: <E1emjYX-00083l-VR@debutante>
Date: Fri, 16 Feb 2018 17:12:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9211: Pass descriptors instead of GPIO numbers

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

>From 11da04af0d3b4c24ab057dd17f54dbc854d735de Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 12 Feb 2018 14:17:02 +0100
Subject: [PATCH] regulator: da9211: Pass descriptors instead of GPIO numbers

This augments the DA9211 regulator driver to fetch its GPIO descriptors
directly from the device tree using the newly exported
devm_get_gpiod_from_child().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.16.1
