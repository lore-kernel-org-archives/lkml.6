Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeENIJM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:09:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35254 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeENIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:23 -0400
X-Google-Smtp-Source: AB8JxZoHqd74fgKc5Riu3TIgs5w1AlC5AhegYJqQSdyJuYX3GiqegJeQFe3KWbXN28sqFQ4ylfhBtw==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 15/19 v3] regulator: fixed/gpio: Pull inversion/OD into gpiolib
Date: Mon, 14 May 2018 10:06:36 +0200
Message-Id: <20180514080640.12515-16-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pushes the handling of inversion semantics and open drain
settings to the GPIO descriptor and gpiolib. All affected board
files are also augmented.

This is especiallt nice since we don't have to have any
confusing flags passed around to the left and right littering
the fixed and GPIO regulator drivers and the regulator core.
It is all just very straight-forward: the core asks the GPIO
line to be asserted or deasserted and gpiolib deals with the
rest depending on how the platform is configured: if the line
is active low, it deals with that, if the line is open drain,
it deals with that too.

Cc: Alexander Shiyan <shc_work@mail.ru> # i.MX boards user
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> # MMP2 maintainer
Cc: Aaro Koskinen <aaro.koskinen@iki.fi> # OMAP1 maintainer
Cc: Tony Lindgren <tony@atomide.com> # OMAP1,2,3 maintainer
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com> # EM-X270 maintainer
Cc: Robert Jarzmik <robert.jarzmik@free.fr> # EZX maintainer
Cc: Philipp Zabel <philipp.zabel@gmail.com> # Magician maintainer
Cc: Daniel Mack <zonque@gmail.com> # Raumfeld maintainer
Cc: Marc Zyngier <marc.zyngier@arm.com> # Zeus maintainer
Cc: Geert Uytterhoeven <geert+renesas@glider.be> # SuperH pinctrl/GPIO maintainer
Cc: Russell King <rmk+kernel@armlinux.org.uk> # SA1100
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch series
- Cover the new user added in sa1100
---
 arch/arm/mach-imx/mach-mx21ads.c              |  1 -
 arch/arm/mach-imx/mach-mx27ads.c              |  2 +-
 arch/arm/mach-mmp/brownstone.c                |  1 -
 arch/arm/mach-omap1/board-ams-delta.c         |  1 -
 arch/arm/mach-omap2/pdata-quirks.c            |  1 -
 arch/arm/mach-pxa/em-x270.c                   |  1 -
 arch/arm/mach-pxa/ezx.c                       |  3 +-
 arch/arm/mach-pxa/hx4700.c                    |  3 +-
 arch/arm/mach-pxa/magician.c                  |  3 +-
 arch/arm/mach-pxa/raumfeld.c                  |  1 -
 arch/arm/mach-pxa/zeus.c                      |  3 +-
 arch/arm/mach-sa1100/assabet.c                |  1 -
 arch/sh/boards/mach-ecovec24/setup.c          |  2 --
 .../intel-mid/device_libs/platform_bcm43xx.c  |  1 -
 drivers/regulator/core.c                      |  8 ++---
 drivers/regulator/da9055-regulator.c          |  1 -
 drivers/regulator/fixed.c                     | 30 +++++--------------
 drivers/regulator/gpio-regulator.c            | 24 ++++++---------
 include/linux/regulator/fixed.h               | 10 -------
 include/linux/regulator/gpio-regulator.h      |  3 --
 20 files changed, 24 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 5d3b6b4fe6db..8c4a4920468a 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -205,7 +205,6 @@ static struct regulator_init_data mx21ads_lcd_regulator_init_data = {
 static struct fixed_voltage_config mx21ads_lcd_regulator_pdata = {
 	.supply_name	= "LCD",
 	.microvolts	= 3300000,
-	.enable_high	= 1,
 	.init_data	= &mx21ads_lcd_regulator_init_data,
 };
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 0fdb88db0cbd..08a7e217b9e6 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -237,7 +237,7 @@ static struct fixed_voltage_config mx27ads_lcd_regulator_pdata = {
 static struct gpiod_lookup_table mx27ads_lcd_regulator_gpiod_table = {
 	.dev_id = "reg-fixed-voltage.0", /* Let's hope ID 0 is what we get */
 	.table = {
-		GPIO_LOOKUP("LCD", 0, "enable", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("LCD", 0, "enable", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 563b5a278d65..502343b32c7f 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -149,7 +149,6 @@ static struct regulator_init_data brownstone_v_5vp_data = {
 static struct fixed_voltage_config brownstone_v_5vp = {
 	.supply_name		= "v_5vp",
 	.microvolts		= 5000000,
-	.enable_high		= 1,
 	.enabled_at_boot	= 1,
 	.init_data		= &brownstone_v_5vp_data,
 };
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 759fa18f6ab4..22e94da4af85 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -275,7 +275,6 @@ static struct fixed_voltage_config modem_nreset_config = {
 	.supply_name		= "modem_nreset",
 	.microvolts		= 3300000,
 	.startup_delay		= 25000,
-	.enable_high		= 1,
 	.enabled_at_boot	= 1,
 	.init_data		= &modem_nreset_data,
 };
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 7d1447204fb8..1c740c7e7c55 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -332,7 +332,6 @@ static struct fixed_voltage_config pandora_vwlan = {
 	.supply_name		= "vwlan",
 	.microvolts		= 1800000, /* 1.8V */
 	.startup_delay		= 50000, /* 50ms */
-	.enable_high		= 1,
 	.init_data		= &pandora_vmmc3,
 };
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 6d7d93981098..8d9ec158f118 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -987,7 +987,6 @@ static struct fixed_voltage_config camera_dummy_config = {
 	.supply_name		= "camera_vdd",
 	.input_supply		= "vcc cam",
 	.microvolts		= 2800000,
-	.enable_high		= 0,
 	.init_data		= &camera_dummy_initdata,
 };
 
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 2b4bd6d94855..13ebdfd697cc 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -714,7 +714,6 @@ static struct regulator_init_data camera_regulator_initdata = {
 static struct fixed_voltage_config camera_regulator_config = {
 	.supply_name		= "camera_vdd",
 	.microvolts		= 2800000,
-	.enable_high		= 0,
 	.init_data		= &camera_regulator_initdata,
 };
 
@@ -730,7 +729,7 @@ static struct gpiod_lookup_table camera_supply_gpiod_table = {
 	.dev_id = "reg-fixed-voltage.1",
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", GPIO50_nCAM_EN,
-			    "enable", GPIO_ACTIVE_HIGH),
+			    "enable", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 6717a10180eb..05148016c620 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -712,7 +712,6 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name = "bq24022",
 
-	.enable_high = 0,
 	.enabled_at_boot = 0,
 
 	.gpios = bq24022_gpios,
@@ -737,7 +736,7 @@ static struct gpiod_lookup_table bq24022_gpiod_table = {
 	.dev_id = "gpio-regulator",
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", GPIO72_HX4700_BQ24022_nCHARGE_EN,
-			    "enable", GPIO_ACTIVE_HIGH),
+			    "enable", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 9a5bda3ea194..fab63c52d50e 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -657,7 +657,6 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name		= "bq24022",
 
-	.enable_high		= 0,
 	.enabled_at_boot	= 1,
 
 	.gpios			= bq24022_gpios,
@@ -682,7 +681,7 @@ static struct gpiod_lookup_table bq24022_gpiod_table = {
 	.dev_id = "gpio-regulator",
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
-			    "enable", GPIO_ACTIVE_HIGH),
+			    "enable", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index ee766e4ebddc..30ea27b85bb0 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -886,7 +886,6 @@ static struct regulator_init_data audio_va_initdata = {
 static struct fixed_voltage_config audio_va_config = {
 	.supply_name		= "audio_va",
 	.microvolts		= 5000000,
-	.enable_high		= 1,
 	.enabled_at_boot	= 0,
 	.init_data		= &audio_va_initdata,
 };
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 58e05afcece0..428c2db6818a 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -426,7 +426,7 @@ static struct gpiod_lookup_table can_regulator_gpiod_table = {
 	.dev_id = "reg-fixed-voltage.0",
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", ZEUS_CAN_SHDN_GPIO,
-			    "enable", GPIO_ACTIVE_HIGH),
+			    "enable", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
@@ -547,7 +547,6 @@ static struct regulator_init_data zeus_ohci_regulator_data = {
 static struct fixed_voltage_config zeus_ohci_regulator_config = {
 	.supply_name		= "vbus2",
 	.microvolts		= 5000000, /* 5.0V */
-	.enable_high		= 1,
 	.startup_delay		= 0,
 	.init_data		= &zeus_ohci_regulator_data,
 };
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index dbb53c520165..705196a4b66f 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -468,7 +468,6 @@ static struct regulator_consumer_supply assabet_cf_vcc_consumers[] = {
 static struct fixed_voltage_config assabet_cf_vcc_pdata __initdata = {
 	.supply_name = "cf-power",
 	.microvolts = 3300000,
-	.enable_high = 1,
 };
 
 static struct gpiod_lookup_table assabet_cf_vcc_gpio_table = {
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index c296b5c399b7..6b9542616447 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -633,7 +633,6 @@ static struct regulator_init_data cn12_power_init_data = {
 static struct fixed_voltage_config cn12_power_info = {
 	.supply_name = "CN12 SD/MMC Vdd",
 	.microvolts = 3300000,
-	.enable_high = 1,
 	.init_data = &cn12_power_init_data,
 };
 
@@ -674,7 +673,6 @@ static struct regulator_init_data sdhi0_power_init_data = {
 static struct fixed_voltage_config sdhi0_power_info = {
 	.supply_name = "CN11 SD/MMC Vdd",
 	.microvolts = 3300000,
-	.enable_high = 1,
 	.init_data = &sdhi0_power_init_data,
 };
 
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c b/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
index fc77d69e51d7..8a579aad0b27 100644
--- a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
@@ -44,7 +44,6 @@ static struct fixed_voltage_config bcm43xx_vmmc = {
 	 */
 	.microvolts		= 2000000,		/* 1.8V */
 	.startup_delay		= 250 * 1000,		/* 250ms */
-	.enable_high		= 1,			/* active high */
 	.enabled_at_boot	= 0,			/* disabled at boot */
 	.init_data		= &bcm43xx_vmmc_data,
 };
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8d56f9b906b0..f3050eaa0a7e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -79,7 +79,6 @@ struct regulator_enable_gpio {
 	struct gpio_desc *gpiod;
 	u32 enable_count;	/* a number of enabled shared GPIO */
 	u32 request_count;	/* a number of requested shared GPIO */
-	unsigned int ena_gpio_invert:1;
 };
 
 /*
@@ -1949,7 +1948,6 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 		return -ENOMEM;
 
 	pin->gpiod = gpiod;
-	pin->ena_gpio_invert = config->ena_gpio_invert;
 	list_add(&pin->list, &regulator_ena_gpio_list);
 
 update_ena_gpio_to_rdev:
@@ -1999,8 +1997,7 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	if (enable) {
 		/* Enable GPIO at initial use */
 		if (pin->enable_count == 0)
-			gpiod_set_value_cansleep(pin->gpiod,
-						 !pin->ena_gpio_invert);
+			gpiod_set_value_cansleep(pin->gpiod, 1);
 
 		pin->enable_count++;
 	} else {
@@ -2011,8 +2008,7 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 
 		/* Disable GPIO if not used */
 		if (pin->enable_count <= 1) {
-			gpiod_set_value_cansleep(pin->gpiod,
-						 pin->ena_gpio_invert);
+			gpiod_set_value_cansleep(pin->gpiod, 0);
 			pin->enable_count = 0;
 		}
 	}
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index f40c3b8644ae..1a384258d0e5 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -457,7 +457,6 @@ static int da9055_gpio_init(struct da9055_regulator *regulator,
 		int gpio_mux = pdata->gpio_ren[id];
 
 		config->ena_gpiod = pdata->ena_gpiods[id];
-		config->ena_gpio_invert = 1;
 
 		/*
 		 * GPI pin is muxed with regulator to control the
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 1142f195529b..8c479cdb69a9 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -79,10 +79,6 @@ of_get_fixed_voltage_config(struct device *dev,
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	config->enable_high = of_property_read_bool(np, "enable-active-high");
-	config->gpio_is_open_drain = of_property_read_bool(np,
-							   "gpio-open-drain");
-
 	if (of_find_property(np, "vin-supply", NULL))
 		config->input_supply = "vin";
 
@@ -146,24 +142,14 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	drvdata->desc.fixed_uV = config->microvolts;
 
-	cfg.ena_gpio_invert = !config->enable_high;
-	if (config->enabled_at_boot) {
-		if (config->enable_high)
-			gflags = GPIOD_OUT_HIGH;
-		else
-			gflags = GPIOD_OUT_LOW;
-	} else {
-		if (config->enable_high)
-			gflags = GPIOD_OUT_LOW;
-		else
-			gflags = GPIOD_OUT_HIGH;
-	}
-	if (config->gpio_is_open_drain) {
-		if (gflags == GPIOD_OUT_HIGH)
-			gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
-		else
-			gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
-	}
+	/*
+	 * The signal will be inverted by the GPIO core if flagged so in the
+	 * decriptor.
+	 */
+	if (config->enabled_at_boot)
+		gflags = GPIOD_OUT_HIGH;
+	else
+		gflags = GPIOD_OUT_LOW;
 
 	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
 	if (IS_ERR(cfg.ena_gpiod))
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 9d6094c4d71c..16ef08406739 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -154,9 +154,6 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	config->supply_name = config->init_data->constraints.name;
 
-	if (of_property_read_bool(np, "enable-active-high"))
-		config->enable_high = true;
-
 	if (of_property_read_bool(np, "enable-at-boot"))
 		config->enabled_at_boot = true;
 
@@ -338,18 +335,15 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
 
-	cfg.ena_gpio_invert = !config->enable_high;
-	if (config->enabled_at_boot) {
-		if (config->enable_high)
-			gflags = GPIOD_OUT_HIGH;
-		else
-			gflags = GPIOD_OUT_LOW;
-	} else {
-		if (config->enable_high)
-			gflags = GPIOD_OUT_LOW;
-		else
-			gflags = GPIOD_OUT_HIGH;
-	}
+	/*
+	 * The signal will be inverted by the GPIO core if flagged so in the
+	 * decriptor.
+	 */
+	if (config->enabled_at_boot)
+		gflags = GPIOD_OUT_HIGH;
+	else
+		gflags = GPIOD_OUT_LOW;
+
 	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "enable", gflags);
 	if (IS_ERR(cfg.ena_gpiod)) {
 		ret = PTR_ERR(cfg.ena_gpiod);
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index 1a4340ed8e2b..f10140da7145 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -25,14 +25,6 @@ struct regulator_init_data;
  * @input_supply:	Name of the input regulator supply
  * @microvolts:		Output voltage of regulator
  * @startup_delay:	Start-up time in microseconds
- * @gpio_is_open_drain: Gpio pin is open drain or normal type.
- *			If it is open drain type then HIGH will be set
- *			through PULL-UP with setting gpio as input
- *			and low will be set as gpio-output with driven
- *			to low. For non-open-drain case, the gpio will
- *			will be in output and drive to low/high accordingly.
- * @enable_high:	Polarity of enable GPIO
- *			1 = Active high, 0 = Active low
  * @enabled_at_boot:	Whether regulator has been enabled at
  * 			boot or not. 1 = Yes, 0 = No
  * 			This is used to keep the regulator at
@@ -48,8 +40,6 @@ struct fixed_voltage_config {
 	const char *input_supply;
 	int microvolts;
 	unsigned startup_delay;
-	unsigned gpio_is_open_drain:1;
-	unsigned enable_high:1;
 	unsigned enabled_at_boot:1;
 	struct regulator_init_data *init_data;
 };
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regulator/gpio-regulator.h
index 536cab86f2d5..4f3cc1a73ade 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -44,8 +44,6 @@ struct gpio_regulator_state {
 /**
  * struct gpio_regulator_config - config structure
  * @supply_name:	Name of the regulator supply
- * @enable_high:	Polarity of enable GPIO
- *			1 = Active high, 0 = Active low
  * @enabled_at_boot:	Whether regulator has been enabled at
  *			boot or not. 1 = Yes, 0 = No
  *			This is used to keep the regulator at
@@ -67,7 +65,6 @@ struct gpio_regulator_state {
 struct gpio_regulator_config {
 	const char *supply_name;
 
-	unsigned enable_high:1;
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
 
-- 
2.17.0
