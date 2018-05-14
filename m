Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeENISe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:18:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40007 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeENIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:06:59 -0400
X-Google-Smtp-Source: AB8JxZpIMdKsDTDn4fdIuPQR7+rL50h/M/ZHucfy0JNxDxd0IZWb097V83d2WYC4v2bet0/YY0k0Vg==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 05/19 v3] regulator: max77686: Pass descriptor instead of GPIO number
Date: Mon, 14 May 2018 10:06:26 +0200
Message-Id: <20180514080640.12515-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a global GPIO number, pass a descriptor looked
up from the device tree configuration node.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Name the regulator "max77686-regulator"
- Set the regulator to NULL on erroneous lookup, restoring the
  old init data lookup behaviour.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 drivers/regulator/max77686-regulator.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index c301f3733475..37f98a8350f0 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -25,8 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
@@ -90,6 +89,7 @@ enum max77686_ramp_rate {
 };
 
 struct max77686_data {
+	struct device *dev;
 	DECLARE_BITMAP(gpio_enabled, MAX77686_REGULATORS);
 
 	/* Array indexed by regulator id */
@@ -269,16 +269,20 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpio = of_get_named_gpio(np,
-					"maxim,ena-gpios", 0);
-		config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
-		config->ena_gpio_initialized = true;
+		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
+								np,
+								"maxim,ena",
+								0,
+								GPIOD_OUT_HIGH,
+								"max77686-regulator");
+		if (IS_ERR(config->ena_gpiod))
+			config->ena_gpiod = NULL;
 		break;
 	default:
 		return 0;
 	}
 
-	if (gpio_is_valid(config->ena_gpio)) {
+	if (config->ena_gpiod) {
 		set_bit(desc->id, max77686->gpio_enabled);
 
 		return regmap_update_bits(config->regmap, desc->enable_reg,
@@ -521,6 +525,7 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	if (!max77686)
 		return -ENOMEM;
 
+	max77686->dev = &pdev->dev;
 	config.dev = iodev->dev;
 	config.regmap = iodev->regmap;
 	config.driver_data = max77686;
-- 
2.17.0
