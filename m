Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeENIHA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:07:00 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41445 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeENIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:06:51 -0400
X-Google-Smtp-Source: AB8JxZpl00hr4DHzoQvH4xiErrE8I4SgKFU2gR3LyYe1h+yeHyWQp51RUcQxGpAi49OzPOvTwathyA==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 02/19 v3] regulator: gpio: Get enable GPIO using GPIO descriptor
Date: Mon, 14 May 2018 10:06:23 +0200
Message-Id: <20180514080640.12515-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We augment the GPIO regulator to get the *enable* regulator
GPIO line (not the other lines) using a descriptor rather than
a global number.

We then pass this into the regulator core which has been
prepared to hande enable descriptors in a separate patch.

Switch over the two boardfiles using this facility and clean
up so we only pass descriptors around.

Cc: Philipp Zabel <philipp.zabel@gmail.com> # HX4700/Magician maintainer
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 arch/arm/mach-pxa/hx4700.c               | 12 +++++++++++-
 arch/arm/mach-pxa/magician.c             | 11 ++++++++++-
 drivers/regulator/gpio-regulator.c       | 23 +++++++++++------------
 include/linux/regulator/gpio-regulator.h |  3 ---
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index e2e7f247a645..6717a10180eb 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/input/navpoint.h>
@@ -711,7 +712,6 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name = "bq24022",
 
-	.enable_gpio = GPIO72_HX4700_BQ24022_nCHARGE_EN,
 	.enable_high = 0,
 	.enabled_at_boot = 0,
 
@@ -733,6 +733,15 @@ static struct platform_device bq24022 = {
 	},
 };
 
+static struct gpiod_lookup_table bq24022_gpiod_table = {
+	.dev_id = "gpio-regulator",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO72_HX4700_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /*
  * StrataFlash
  */
@@ -875,6 +884,7 @@ static void __init hx4700_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
 
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 14c0f80bc9e7..9a5bda3ea194 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -657,7 +657,6 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name		= "bq24022",
 
-	.enable_gpio		= GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
 	.enable_high		= 0,
 	.enabled_at_boot	= 1,
 
@@ -679,6 +678,15 @@ static struct platform_device bq24022 = {
 	},
 };
 
+static struct gpiod_lookup_table bq24022_gpiod_table = {
+	.dev_id = "gpio-regulator",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /*
  * fixed regulator for ads7846
  */
@@ -1007,6 +1015,7 @@ static void __init magician_init(void)
 	regulator_register_always_on(0, "power", pwm_backlight_supply,
 		ARRAY_SIZE(pwm_backlight_supply), 5000000);
 
+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
 
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index a86b8997bb54..9d6094c4d71c 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -31,6 +31,7 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/gpio-regulator.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
@@ -161,10 +162,6 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	config->enable_gpio = of_get_named_gpio(np, "enable-gpio", 0);
-	if (config->enable_gpio < 0 && config->enable_gpio != -ENOENT)
-		return ERR_PTR(config->enable_gpio);
-
 	/* Fetch GPIOs. - optional property*/
 	ret = of_gpio_count(np);
 	if ((ret < 0) && (ret != -ENOENT))
@@ -255,6 +252,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg = { };
+	enum gpiod_flags gflags;
 	int ptr, ret, state;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gpio_regulator_data),
@@ -340,21 +338,22 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
 
-	if (gpio_is_valid(config->enable_gpio)) {
-		cfg.ena_gpio = config->enable_gpio;
-		cfg.ena_gpio_initialized = true;
-	}
 	cfg.ena_gpio_invert = !config->enable_high;
 	if (config->enabled_at_boot) {
 		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
+			gflags = GPIOD_OUT_HIGH;
 		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
+			gflags = GPIOD_OUT_LOW;
 	} else {
 		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
+			gflags = GPIOD_OUT_LOW;
 		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
+			gflags = GPIOD_OUT_HIGH;
+	}
+	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "enable", gflags);
+	if (IS_ERR(cfg.ena_gpiod)) {
+		ret = PTR_ERR(cfg.ena_gpiod);
+		goto err_stategpio;
 	}
 
 	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regulator/gpio-regulator.h
index 19fbd267406d..536cab86f2d5 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -44,8 +44,6 @@ struct gpio_regulator_state {
 /**
  * struct gpio_regulator_config - config structure
  * @supply_name:	Name of the regulator supply
- * @enable_gpio:	GPIO to use for enable control
- *			set to -EINVAL if not used
  * @enable_high:	Polarity of enable GPIO
  *			1 = Active high, 0 = Active low
  * @enabled_at_boot:	Whether regulator has been enabled at
@@ -69,7 +67,6 @@ struct gpio_regulator_state {
 struct gpio_regulator_config {
 	const char *supply_name;
 
-	int enable_gpio;
 	unsigned enable_high:1;
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
-- 
2.17.0
