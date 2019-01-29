Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922A32177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNeW6RTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfA2KcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:32:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33674 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2KcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:32:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so17056160ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJahcj5iUuUuf7WgRSE5QtMRLYgT/VDSwztkiPTjYNw=;
        b=aNeW6RToyfL3Fn+2rDPEJECaaRD9XIkYvWG7C0HpJPyqrSr+jPAl2WuV/zAEgQt1CT
         D5AyMNE7G2SbszOGU2fnFPtyt4JIvKvpZrVi239477t1MngjUQOi7u3LcFXMxfxqzdHn
         Kixdev48neO0GRVYmF7ghWutcu/gRSwWKZqxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJahcj5iUuUuf7WgRSE5QtMRLYgT/VDSwztkiPTjYNw=;
        b=ZJiwjYMgsIIg1otKHyuNMe8lcpSLyJSkUzmhIIwiigpTlRjzpwCpMIZrt6SfVhGL+0
         udIOTPS76+iMGGx0s9jMTWtwQ5US1SDPqt89VaVxPocesB078ImPeTNSdAAkKyQ4ggAC
         sFJ+/2zGoIChnXnTMGVIHP4t4TiuB/4x22TF4axN+N6dL1+KIJFjR685in5iaiTOQ5Qq
         Ur06iPKNyXmhXjJs70sD+BiHGoB/v2rjeunQM+GYgPRxngIdAQ32MgepE4r+MlyKiMI1
         HHEahVMrLnJgYR1aUo42NCZg9SFB7guwUJy9A1ujOMuib7m4gFOdpUwrS+jgk5lGXRK/
         FJRQ==
X-Gm-Message-State: AJcUuke0WnDeACNWIO4/Ze4Y9e50pzPGGuw3e6A//jMvSpcDPYuIzw1h
        FYad0KVD9ebanr39XIhmcmiikA==
X-Google-Smtp-Source: ALg8bN4nySBpc625VuNgp3uVtsbO1WnqKE8QJ8E6WDo0YlchrZNL7gF8Tn9Q0fmEO11b6Er3p2MVgA==
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr20774866ljc.172.1548757923366;
        Tue, 29 Jan 2019 02:32:03 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id y9sm3471540lfe.75.2019.01.29.02.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 02:32:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Petr Cvek <petr.cvek@tul.cz>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Paul Parsons <lost.distance@yahoo.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/5 v10] regulator: gpio: Convert to use descriptors
Date:   Tue, 29 Jan 2019 11:31:52 +0100
Message-Id: <20190129103156.10139-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the GPIO regulator driver to use decriptors only.

We have to let go of the array gpio handling: the fetched descriptors
are handled individually anyway, and the array retrieveal function
does not make it possible to retrieve each GPIO descriptor with
unique flags. Instead get them one by one.

We request the "enable" GPIO separately as before, and make sure
that this line is requested as nonexclusive since enable lines can
be shared and the regulator core expects this.

Most users of the GPIO regulator are using device tree.

There are two boards in the kernel using the gpio regulator from a
non-devicetree path: PXA hx4700 and magician. Make sure to switch
these over to use descriptors as well.

Cc: Philipp Zabel <p.zabel@pengutronix.de> # Magician
Cc: Petr Cvek <petr.cvek@tul.cz> # Magician
Cc: Robert Jarzmik <robert.jarzmik@free.fr> # PXA
Cc: Paul Parsons <lost.distance@yahoo.com> # hx4700
Cc: Kevin Hilman <khilman@baylibre.com> # Meson
Cc: Neil Armstrong <narmstrong@baylibre.com> # Meson
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v9->v10:
- Remove reliance on a syntactic change from a later patch
  in the series: I was using a local dev pointer in .probe()
  that is only introduced in a later clean-up patch.
ChangeLog v8->v9:
- Add a missing allocation.
- Collect Marek's Tested-by.
- Kevin/Neil: would be great if you could test this patch so as
  to make sure I don't break your stuff again!
ChangeLog v7->v8:
- Rebase on v5.0-rc1.
- Do not use devm_* to fetch the enable GPIO, use the regular
  call and hand over lifecycle management to the regulator
  core.
ChangeLog v6->v7:
- Resend with the rest.
ChangeLog v3->v6:
- Make sure to request the GPIO line nonexclusive as with other
  regulator GPIOs.
- Request the voltage controlling GPIOs from the name NULL as
  only "enable-gpio" is explicitly named.
- Make sure to delete all unused struct members and assignments
  in board files.
- Change numbering to fit the rest of the patches.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 arch/arm/mach-pxa/hx4700.c               |  23 ++--
 arch/arm/mach-pxa/magician.c             |  23 ++--
 drivers/regulator/gpio-regulator.c       | 150 +++++++++--------------
 include/linux/regulator/gpio-regulator.h |  12 +-
 4 files changed, 95 insertions(+), 113 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index b79b757fdd41..51d38d5e776a 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -702,9 +703,7 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies      = bq24022_consumers,
 };
 
-static struct gpio bq24022_gpios[] = {
-	{ GPIO96_HX4700_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+static enum gpiod_flags bq24022_gpiod_gflags[] = { GPIOD_OUT_LOW };
 
 static struct gpio_regulator_state bq24022_states[] = {
 	{ .value = 100000, .gpios = (0 << 0) },
@@ -714,12 +713,10 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name = "bq24022",
 
-	.enable_gpio = GPIO72_HX4700_BQ24022_nCHARGE_EN,
-	.enable_high = 0,
 	.enabled_at_boot = 0,
 
-	.gpios = bq24022_gpios,
-	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
+	.gflags = bq24022_gpiod_gflags,
+	.ngpios = ARRAY_SIZE(bq24022_gpiod_gflags),
 
 	.states = bq24022_states,
 	.nr_states = ARRAY_SIZE(bq24022_states),
@@ -736,6 +733,17 @@ static struct platform_device bq24022 = {
 	},
 };
 
+static struct gpiod_lookup_table bq24022_gpiod_table = {
+	.dev_id = "gpio-regulator",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO96_HX4700_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO72_HX4700_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * StrataFlash
  */
@@ -878,6 +886,7 @@ static void __init hx4700_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
 
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 08b079653c3f..6538a7c0e504 100644
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
@@ -657,12 +656,10 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name		= "bq24022",
 
-	.enable_gpio		= GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
-	.enable_high		= 0,
 	.enabled_at_boot	= 1,
 
-	.gpios			= bq24022_gpios,
-	.nr_gpios		= ARRAY_SIZE(bq24022_gpios),
+	.gflags = bq24022_gpiod_gflags,
+	.ngpios = ARRAY_SIZE(bq24022_gpiod_gflags),
 
 	.states			= bq24022_states,
 	.nr_states		= ARRAY_SIZE(bq24022_states),
@@ -679,6 +676,17 @@ static struct platform_device bq24022 = {
 	},
 };
 
+static struct gpiod_lookup_table bq24022_gpiod_table = {
+	.dev_id = "gpio-regulator",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", EGPIO_MAGICIAN_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * fixed regulator for ads7846
  */
@@ -1027,6 +1035,7 @@ static void __init magician_init(void)
 	regulator_register_always_on(0, "power", pwm_backlight_supply,
 		ARRAY_SIZE(pwm_backlight_supply), 5000000);
 
+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
 
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index b2f5ec4f658a..07fb41abd4e8 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -30,16 +30,15 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/gpio-regulator.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
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
@@ -82,7 +81,7 @@ static int gpio_regulator_set_voltage(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state = target;
 
@@ -119,7 +118,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state = target;
 
@@ -138,7 +137,8 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 {
 	struct gpio_regulator_config *config;
 	const char *regtype;
-	int proplen, gpio, i;
+	int proplen, i;
+	int ngpios;
 	int ret;
 
 	config = devm_kzalloc(dev,
@@ -153,59 +153,36 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	config->supply_name = config->init_data->constraints.name;
 
-	if (of_property_read_bool(np, "enable-active-high"))
-		config->enable_high = true;
-
 	if (of_property_read_bool(np, "enable-at-boot"))
 		config->enabled_at_boot = true;
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	config->enable_gpio = of_get_named_gpio(np, "enable-gpio", 0);
-	if (config->enable_gpio < 0 && config->enable_gpio != -ENOENT)
-		return ERR_PTR(config->enable_gpio);
-
-	/* Fetch GPIOs. - optional property*/
-	ret = of_gpio_count(np);
-	if ((ret < 0) && (ret != -ENOENT))
-		return ERR_PTR(ret);
-
-	if (ret > 0) {
-		config->nr_gpios = ret;
-		config->gpios = devm_kcalloc(dev,
-					config->nr_gpios, sizeof(struct gpio),
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
@@ -255,7 +232,8 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg = { };
-	int ptr, ret, state;
+	enum gpiod_flags gflags;
+	int ptr, ret, state, i;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gpio_regulator_data),
 			       GFP_KERNEL);
@@ -275,26 +253,21 @@ static int gpio_regulator_probe(struct platform_device *pdev)
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
+	drvdata->gpiods = devm_kzalloc(&pdev->dev, sizeof(struct gpio_desc *),
+				       GFP_KERNEL);
+	if (!drvdata->gpiods)
+		return -ENOMEM;
+	for (i = 0; i < config->ngpios; i++) {
+		drvdata->gpiods[i] = devm_gpiod_get_index(&pdev->dev,
+							  NULL,
+							  i,
+							  config->gflags[i]);
+		if (IS_ERR(drvdata->gpiods[i]))
+			return PTR_ERR(drvdata->gpiods[i]);
+		/* This is good to know */
+		gpiod_set_consumer_name(drvdata->gpiods[i], drvdata->desc.name);
 	}
+	drvdata->nr_gpios = config->ngpios;
 
 	drvdata->states = kmemdup(config->states,
 				  config->nr_states *
@@ -303,7 +276,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	if (drvdata->states == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate state data\n");
 		ret = -ENOMEM;
-		goto err_stategpio;
+		goto err_name;
 	}
 	drvdata->nr_states = config->nr_states;
 
@@ -330,7 +303,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	/* build initial state from gpio init data. */
 	state = 0;
 	for (ptr = 0; ptr < drvdata->nr_gpios; ptr++) {
-		if (config->gpios[ptr].flags & GPIOF_OUT_INIT_HIGH)
+		if (config->gflags[ptr] == GPIOD_OUT_HIGH)
 			state |= (1 << ptr);
 	}
 	drvdata->state = state;
@@ -340,21 +313,19 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
 
-	if (gpio_is_valid(config->enable_gpio)) {
-		cfg.ena_gpio = config->enable_gpio;
-		cfg.ena_gpio_initialized = true;
-	}
-	cfg.ena_gpio_invert = !config->enable_high;
-	if (config->enabled_at_boot) {
-		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
-		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
-	} else {
-		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
-		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
+	/*
+	 * The signal will be inverted by the GPIO core if flagged so in the
+	 * decriptor.
+	 */
+	if (config->enabled_at_boot)
+		gflags = GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+	else
+		gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+
+	cfg.ena_gpiod = gpiod_get_optional(&pdev->dev, "enable", gflags);
+	if (IS_ERR(cfg.ena_gpiod)) {
+		ret = PTR_ERR(cfg.ena_gpiod);
+		goto err_memstate;
 	}
 
 	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
@@ -370,10 +341,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 
 err_memstate:
 	kfree(drvdata->states);
-err_stategpio:
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-err_memgpio:
-	kfree(drvdata->gpios);
 err_name:
 	kfree(drvdata->desc.name);
 	return ret;
@@ -384,12 +351,7 @@ static int gpio_regulator_remove(struct platform_device *pdev)
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
index 19fbd267406d..49c407afb944 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -21,6 +21,8 @@
 #ifndef __REGULATOR_GPIO_H
 #define __REGULATOR_GPIO_H
 
+#include <linux/gpio/consumer.h>
+
 struct regulator_init_data;
 
 enum regulator_type;
@@ -53,9 +55,9 @@ struct gpio_regulator_state {
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
@@ -74,8 +76,8 @@ struct gpio_regulator_config {
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
 
-	struct gpio *gpios;
-	int nr_gpios;
+	enum gpiod_flags *gflags;
+	int ngpios;
 
 	struct gpio_regulator_state *states;
 	int nr_states;
-- 
2.20.1

