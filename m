Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeDVXKI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 19:10:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38328 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbeDVXKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 19:10:04 -0400
X-Google-Smtp-Source: AB8JxZp5odOhruVdTEfdVXd+f0hQlxW3S6HiCaIZ4h6i5NLnlLXiIe1H6a3UO8N1CNM+GCquAJ6lRA==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/18 v2] regulator: lm363x: Pass descriptor instead of GPIO number
Date: Mon, 23 Apr 2018 01:07:30 +0200
Message-Id: <20180422230742.3729-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180422230742.3729-1-linus.walleij@linaro.org>
References: <20180422230742.3729-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a global GPIO number, pass a descriptor looked
up with the standard devm_gpiod_get_index_optional() call.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 drivers/regulator/lm363x-regulator.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index ce5f7d9ad475..b615a413ca9f 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -16,7 +16,7 @@
 #include <linux/mfd/ti-lmu-register.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
@@ -219,7 +219,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
 	},
 };
 
-static int lm363x_regulator_of_get_enable_gpio(struct device_node *np, int id)
+static struct gpio_desc *lm363x_regulator_of_get_enable_gpio(struct device *dev, int id)
 {
 	/*
 	 * Check LCM_EN1/2_GPIO is configured.
@@ -227,11 +227,11 @@ static int lm363x_regulator_of_get_enable_gpio(struct device_node *np, int id)
 	 */
 	switch (id) {
 	case LM3632_LDO_POS:
-		return of_get_named_gpio(np, "enable-gpios", 0);
+		return devm_gpiod_get_index_optional(dev, "enable", 0, GPIOD_OUT_LOW);
 	case LM3632_LDO_NEG:
-		return of_get_named_gpio(np, "enable-gpios", 1);
+		return devm_gpiod_get_index_optional(dev, "enable", 1, GPIOD_OUT_LOW);
 	default:
-		return -EINVAL;
+		return NULL;
 	}
 }
 
@@ -243,7 +243,8 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 	struct regulator_dev *rdev;
 	struct device *dev = &pdev->dev;
 	int id = pdev->id;
-	int ret, ena_gpio;
+	struct gpio_desc *gpiod;
+	int ret;
 
 	cfg.dev = dev;
 	cfg.regmap = regmap;
@@ -252,10 +253,9 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 	 * LM3632 LDOs can be controlled by external pin.
 	 * Register update is required if the pin is used.
 	 */
-	ena_gpio = lm363x_regulator_of_get_enable_gpio(dev->of_node, id);
-	if (gpio_is_valid(ena_gpio)) {
-		cfg.ena_gpio = ena_gpio;
-		cfg.ena_gpio_flags = GPIOF_OUT_INIT_LOW;
+	gpiod = lm363x_regulator_of_get_enable_gpio(dev, id);
+	if (gpiod) {
+		cfg.ena_gpiod = gpiod;
 
 		ret = regmap_update_bits(regmap, LM3632_REG_BIAS_CONFIG,
 					 LM3632_EXT_EN_MASK,
-- 
2.14.3
