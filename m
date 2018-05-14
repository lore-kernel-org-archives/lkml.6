Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeENIIm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:08:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42435 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeENIH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:28 -0400
X-Google-Smtp-Source: AB8JxZpOmx9hX940ukTIAr121cOysWScTEYvKlMOlEZWw0BASe6HlHrm/llTZ+ZenC3ElPERvMBn+A==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 17/19 v3] regulator: gpio: Convert to fully use descriptors
Date: Mon, 14 May 2018 10:06:38 +0200
Message-Id: <20180514080640.12515-18-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the GPIO regulator driver to use decriptors only.
We have to let go of the array gpio handling: the fetched descriptors
are handled individually anyway, and the array retrieveal function
does not make it possible to retrieve each GPIO descriptor with
unique flags. Instead get them one by one.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 arch/arm/mach-pxa/hx4700.c               |  10 +-
 arch/arm/mach-pxa/magician.c             |  11 ++-
 drivers/regulator/gpio-regulator.c       | 113 ++++++++---------------
 include/linux/regulator/gpio-regulator.h |  12 ++-
 4 files changed, 56 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 05148016c620..24ba230340d8 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -700,9 +700,7 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies      = bq24022_consumers,
 };
 
-static struct gpio bq24022_gpios[] = {
-	{ GPIO96_HX4700_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+static enum gpiod_flags bq24022_gpiod_gflags[] = { GPIOD_OUT_LOW };
 
 static struct gpio_regulator_state bq24022_states[] = {
 	{ .value = 100000, .gpios = (0 << 0) },
@@ -714,8 +712,8 @@ static struct gpio_regulator_config bq24022_info = {
 
 	.enabled_at_boot = 0,
 
-	.gpios = bq24022_gpios,
-	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
+	.gflags = bq24022_gpiod_gflags,
+	.ngpios = ARRAY_SIZE(bq24022_gpiod_gflags),
 
 	.states = bq24022_states,
 	.nr_states = ARRAY_SIZE(bq24022_states),
@@ -735,6 +733,8 @@ static struct platform_device bq24022 = {
 static struct gpiod_lookup_table bq24022_gpiod_table = {
 	.dev_id = "gpio-regulator",
 	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO96_HX4700_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("gpio-pxa", GPIO72_HX4700_BQ24022_nCHARGE_EN,
 			    "enable", GPIO_ACTIVE_LOW),
 		{ },
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index fab63c52d50e..5d21de79135b 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -645,9 +645,8 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies	= bq24022_consumers,
 };
 
-static struct gpio bq24022_gpios[] = {
-	{ EGPIO_MAGICIAN_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+
+static enum gpiod_flags bq24022_gpiod_gflags[] = { GPIOD_OUT_LOW };
 
 static struct gpio_regulator_state bq24022_states[] = {
 	{ .value = 100000, .gpios = (0 << 0) },
@@ -659,8 +658,8 @@ static struct gpio_regulator_config bq24022_info = {
 
 	.enabled_at_boot	= 1,
 
-	.gpios			= bq24022_gpios,
-	.nr_gpios		= ARRAY_SIZE(bq24022_gpios),
+	.gflags = bq24022_gpiod_gflags,
+	.ngpios = ARRAY_SIZE(bq24022_gpiod_gflags),
 
 	.states			= bq24022_states,
 	.nr_states		= ARRAY_SIZE(bq24022_states),
@@ -680,6 +679,8 @@ static struct platform_device bq24022 = {
 static struct gpiod_lookup_table bq24022_gpiod_table = {
 	.dev_id = "gpio-regulator",
 	.table = {
+		GPIO_LOOKUP("gpio-pxa", EGPIO_MAGICIAN_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("gpio-pxa", GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
 			    "enable", GPIO_ACTIVE_LOW),
 		{ },
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 16ef08406739..756b7b50ffba 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -30,17 +30,15 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/gpio-regulator.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 struct gpio_regulator_data {
 	struct regulator_desc desc;
 	struct regulator_dev *dev;
 
-	struct gpio *gpios;
+	struct gpio_desc **gpiods;
 	int nr_gpios;
 
 	struct gpio_regulator_state *states;
@@ -83,7 +81,7 @@ static int gpio_regulator_set_voltage(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state = target;
 
@@ -120,7 +118,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state = target;
 
@@ -139,7 +137,8 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 {
 	struct gpio_regulator_config *config;
 	const char *regtype;
-	int proplen, gpio, i;
+	int proplen, i;
+	int ngpios;
 	int ret;
 
 	config = devm_kzalloc(dev,
@@ -159,47 +158,31 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	/* Fetch GPIOs. - optional property*/
-	ret = of_gpio_count(np);
-	if ((ret < 0) && (ret != -ENOENT))
-		return ERR_PTR(ret);
-
-	if (ret > 0) {
-		config->nr_gpios = ret;
-		config->gpios = devm_kzalloc(dev,
-					sizeof(struct gpio) * config->nr_gpios,
-					GFP_KERNEL);
-		if (!config->gpios)
+	/* Fetch GPIO init levels */
+	ngpios = gpiod_count(dev, NULL);
+	if (ngpios > 0) {
+		config->gflags = devm_kzalloc(dev,
+					      sizeof(enum gpiod_flags)
+					      * ngpios,
+					      GFP_KERNEL);
+		if (!config->gflags)
 			return ERR_PTR(-ENOMEM);
 
-		proplen = of_property_count_u32_elems(np, "gpios-states");
-		/* optional property */
-		if (proplen < 0)
-			proplen = 0;
+		for (i = 0; i < ngpios; i++) {
+			u32 val;
 
-		if (proplen > 0 && proplen != config->nr_gpios) {
-			dev_warn(dev, "gpios <-> gpios-states mismatch\n");
-			proplen = 0;
-		}
+			ret = of_property_read_u32_index(np, "gpios-states", i,
+							 &val);
 
-		for (i = 0; i < config->nr_gpios; i++) {
-			gpio = of_get_named_gpio(np, "gpios", i);
-			if (gpio < 0) {
-				if (gpio != -ENOENT)
-					return ERR_PTR(gpio);
-				break;
-			}
-			config->gpios[i].gpio = gpio;
-			config->gpios[i].label = config->supply_name;
-			if (proplen > 0) {
-				of_property_read_u32_index(np, "gpios-states",
-							   i, &ret);
-				if (ret)
-					config->gpios[i].flags =
-							   GPIOF_OUT_INIT_HIGH;
-			}
+			/* Default to high per specification */
+			if (ret)
+				config->gflags[i] = GPIOD_OUT_HIGH;
+			else
+				config->gflags[i] =
+					val ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 		}
 	}
+	config->ngpios = ngpios;
 
 	/* Fetch states. */
 	proplen = of_property_count_u32_elems(np, "states");
@@ -250,7 +233,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg = { };
 	enum gpiod_flags gflags;
-	int ptr, ret, state;
+	int ptr, ret, state, i;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gpio_regulator_data),
 			       GFP_KERNEL);
@@ -264,33 +247,22 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 			return PTR_ERR(config);
 	}
 
+	for (i = 0; i < config->ngpios; i++) {
+		drvdata->gpiods[i] = devm_gpiod_get_index(&pdev->dev,
+							  config->supply_name,
+							  i,
+							  config->gflags[i]);
+		if (IS_ERR(drvdata->gpiods[i]))
+			return PTR_ERR(drvdata->gpiods[i]);
+	}
+	drvdata->nr_gpios = config->ngpios;
+
 	drvdata->desc.name = kstrdup(config->supply_name, GFP_KERNEL);
 	if (drvdata->desc.name == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate supply name\n");
 		return -ENOMEM;
 	}
 
-	if (config->nr_gpios != 0) {
-		drvdata->gpios = kmemdup(config->gpios,
-					 config->nr_gpios * sizeof(struct gpio),
-					 GFP_KERNEL);
-		if (drvdata->gpios == NULL) {
-			dev_err(&pdev->dev, "Failed to allocate gpio data\n");
-			ret = -ENOMEM;
-			goto err_name;
-		}
-
-		drvdata->nr_gpios = config->nr_gpios;
-		ret = gpio_request_array(drvdata->gpios, drvdata->nr_gpios);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"Could not obtain regulator setting GPIOs: %d\n",
-					ret);
-			goto err_memgpio;
-		}
-	}
-
 	drvdata->states = kmemdup(config->states,
 				  config->nr_states *
 					 sizeof(struct gpio_regulator_state),
@@ -298,7 +270,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	if (drvdata->states == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate state data\n");
 		ret = -ENOMEM;
-		goto err_stategpio;
+		goto err_name;
 	}
 	drvdata->nr_states = config->nr_states;
 
@@ -325,7 +297,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	/* build initial state from gpio init data. */
 	state = 0;
 	for (ptr = 0; ptr < drvdata->nr_gpios; ptr++) {
-		if (config->gpios[ptr].flags & GPIOF_OUT_INIT_HIGH)
+		if (config->gflags[ptr] == GPIOD_OUT_HIGH)
 			state |= (1 << ptr);
 	}
 	drvdata->state = state;
@@ -347,7 +319,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "enable", gflags);
 	if (IS_ERR(cfg.ena_gpiod)) {
 		ret = PTR_ERR(cfg.ena_gpiod);
-		goto err_stategpio;
+		goto err_memstate;
 	}
 
 	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
@@ -363,10 +335,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 
 err_memstate:
 	kfree(drvdata->states);
-err_stategpio:
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-err_memgpio:
-	kfree(drvdata->gpios);
 err_name:
 	kfree(drvdata->desc.name);
 	return ret;
@@ -377,12 +345,7 @@ static int gpio_regulator_remove(struct platform_device *pdev)
 	struct gpio_regulator_data *drvdata = platform_get_drvdata(pdev);
 
 	regulator_unregister(drvdata->dev);
-
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-
 	kfree(drvdata->states);
-	kfree(drvdata->gpios);
-
 	kfree(drvdata->desc.name);
 
 	return 0;
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regulator/gpio-regulator.h
index 4f3cc1a73ade..11cd6375215d 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -21,6 +21,8 @@
 #ifndef __REGULATOR_GPIO_H
 #define __REGULATOR_GPIO_H
 
+#include <linux/gpio/consumer.h>
+
 struct regulator_init_data;
 
 enum regulator_type;
@@ -49,9 +51,9 @@ struct gpio_regulator_state {
  *			This is used to keep the regulator at
  *			the default state
  * @startup_delay:	Start-up time in microseconds
- * @gpios:		Array containing the gpios needed to control
- *			the setting of the regulator
- * @nr_gpios:		Number of gpios
+ * @gflags:		Array of GPIO configuration flags for initial
+ *			states
+ * @ngpios:		Number of GPIOs and configurations available
  * @states:		Array of gpio_regulator_state entries describing
  *			the gpio state for specific voltages
  * @nr_states:		Number of states available
@@ -68,8 +70,8 @@ struct gpio_regulator_config {
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
 
-	struct gpio *gpios;
-	int nr_gpios;
+	enum gpiod_flags *gflags;
+	int ngpios;
 
 	struct gpio_regulator_state *states;
 	int nr_states;
-- 
2.17.0
