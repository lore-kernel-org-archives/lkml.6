Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82632087C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgQw9CMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82632087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeKSRgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:36:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40651 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKSRgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:36:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so20533359lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 23:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwX0jEa0UnMiRsgnGBjEdRBChwNBGU04OLNhFUV8CEU=;
        b=jgQw9CMbKjE+G0HSIkSNQbYdA485gyd4UdKh2HWh/maklG6H/i/fZPyZK9NHsN98ON
         6bkAPt/u0JlqxzMcbTR8Hadj9fTziBf+0bVCGe3psKlQf72wBcc0w2WXEMs3Msh9ngMY
         Bzp66YEsmQbgWxCpNi3r53RE54N0l04KegsAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwX0jEa0UnMiRsgnGBjEdRBChwNBGU04OLNhFUV8CEU=;
        b=F3uMPi98IzE/9t+B7vz/XCV1KxJox79pa5W/ie/aD6aCt371gWd7YaoCEeYU4tdLbX
         TXiulBXcPj8CjaEi2tPHplzAjxCpovxvqdoLGspD+qh9lpzosSMQZw8K3T5uRF3YCzPv
         PzWfqGfZyN2pMbqAdP+/rVvvgxXJebpYg9yl+r7utHXFzf4nkL0eAYZ15TLS2RuAgEg8
         87ZaTavskGk/DcA7abazNCq0e4/lEAcwHlz5O5ZxFttVTEqxU5cTUJj0/PjkMY6KPhaY
         pKLiCDba2LINHTUX5lh2beoaJrlTgeJf4nVfw2S1EYEGD0iP0AeXfUuFG2MMYgILXzd7
         TEgA==
X-Gm-Message-State: AGRZ1gKwtHuBAJlooaVtybrKYTSdoNXWaKSQk6+jCrflL/NunBrNtmno
        Ojk6xymrOtXvsJHhRiE9elPpqA==
X-Google-Smtp-Source: AJdET5fQJ0x2L0PtF2vHdu+podODkTLfYjup2D0dMW2XsBBe6Ea7rXXG8LpSTebWCfh0uApLEkKt8g==
X-Received: by 2002:a19:4402:: with SMTP id r2mr9623000lfa.111.1542611630929;
        Sun, 18 Nov 2018 23:13:50 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 10sm5531584lff.62.2018.11.18.23.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 23:13:49 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 2/5 v7] regulator: fixed/gpio: Pull inversion/OD into gpiolib
Date:   Mon, 19 Nov 2018 08:11:23 +0100
Message-Id: <20181119071126.8889-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119071126.8889-1-linus.walleij@linaro.org>
References: <20181119071126.8889-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pushes the handling of inversion semantics and open drain
settings to the GPIO descriptor and gpiolib. All affected board
files are also augmented.

This is especially nice since we don't have to have any
confusing flags passed around to the left and right littering
the fixed and GPIO regulator drivers and the regulator core.
It is all just very straight-forward: the core asks the GPIO
line to be asserted or deasserted and gpiolib deals with the
rest depending on how the platform is configured: if the line
is active low, it deals with that, if the line is open drain,
it deals with that too.

Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com> # OMAP1
Cc: Alexander Shiyan <shc_work@mail.ru> # i.MX boards user
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> # MMP2 maintainer
Cc: Aaro Koskinen <aaro.koskinen@iki.fi> # OMAP1 maintainer
Cc: Tony Lindgren <tony@atomide.com> # OMAP1,2,3 maintainer
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com> # EM-X270 maintainer
Cc: Robert Jarzmik <robert.jarzmik@free.fr> # EZX maintainer
Cc: Philipp Zabel <philipp.zabel@gmail.com> # Magician maintainer
Cc: Petr Cvek <petr.cvek@tul.cz> # Magician
Cc: Robert Jarzmik <robert.jarzmik@free.fr> # PXA
Cc: Paul Parsons <lost.distance@yahoo.com> # hx4700
Cc: Daniel Mack <zonque@gmail.com> # Raumfeld maintainer
Cc: Marc Zyngier <marc.zyngier@arm.com> # Zeus maintainer
Cc: Geert Uytterhoeven <geert+renesas@glider.be> # SuperH pinctrl/GPIO maintainer
Cc: Russell King <rmk+kernel@armlinux.org.uk> # SA1100
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- Fix a missed .enable_high on OMAP1.
ChangeLog v4->v6:
- Split out parts relation to GPIO regulator descriptor conversion
  to the right patch.
- Renumber to fit the rest of the series.
- Daniel Mack says he will probably delete the Raumfeld board file
  and replace it with a device tree, I suggest we just deal with that
  conflict upstream.
ChangeLog v3->v4:
- Rebase on fixed regulator changes.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch series
- Cover the new user added in sa1100
---
 arch/arm/mach-imx/mach-mx21ads.c              |  1 -
 arch/arm/mach-imx/mach-mx27ads.c              |  2 +-
 arch/arm/mach-mmp/brownstone.c                |  1 -
 arch/arm/mach-omap1/board-ams-delta.c         |  2 --
 arch/arm/mach-omap2/pdata-quirks.c            |  1 -
 arch/arm/mach-pxa/em-x270.c                   |  1 -
 arch/arm/mach-pxa/ezx.c                       |  3 +-
 arch/arm/mach-pxa/raumfeld.c                  |  1 -
 arch/arm/mach-pxa/zeus.c                      |  3 +-
 arch/arm/mach-sa1100/assabet.c                |  1 -
 arch/sh/boards/mach-ecovec24/setup.c          |  2 --
 .../intel-mid/device_libs/platform_bcm43xx.c  |  1 -
 drivers/regulator/core.c                      |  8 ++---
 drivers/regulator/da9055-regulator.c          |  1 -
 drivers/regulator/fixed.c                     | 35 +++++--------------
 include/linux/regulator/fixed.h               | 10 ------
 include/linux/regulator/gpio-regulator.h      |  6 ----
 17 files changed, 13 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 2e1e540f2e5a..d278fb672d40 100644
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
index f5e04047ed13..6dd7f57c332f 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -237,7 +237,7 @@ static struct fixed_voltage_config mx27ads_lcd_regulator_pdata = {
 static struct gpiod_lookup_table mx27ads_lcd_regulator_gpiod_table = {
 	.dev_id = "reg-fixed-voltage.0", /* Let's hope ID 0 is what we get */
 	.table = {
-		GPIO_LOOKUP("LCD", 0, NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("LCD", 0, NULL, GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index a04e249c654b..d2560fb1e835 100644
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
index 3d191fd52910..26e9b5969b0a 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -268,7 +268,6 @@ static struct fixed_voltage_config modem_nreset_config = {
 	.supply_name		= "modem_nreset",
 	.microvolts		= 3300000,
 	.startup_delay		= 25000,
-	.enable_high		= 1,
 	.enabled_at_boot	= 1,
 	.init_data		= &modem_nreset_data,
 };
@@ -529,7 +528,6 @@ static struct regulator_init_data keybrd_pwr_initdata = {
 static struct fixed_voltage_config keybrd_pwr_config = {
 	.supply_name		= "keybrd_pwr",
 	.microvolts		= 5000000,
-	.enable_high		= 1,
 	.init_data		= &keybrd_pwr_initdata,
 };
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 9fec5f84bf77..69a9182a9aff 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -330,7 +330,6 @@ static struct fixed_voltage_config pandora_vwlan = {
 	.supply_name		= "vwlan",
 	.microvolts		= 1800000, /* 1.8V */
 	.startup_delay		= 50000, /* 50ms */
-	.enable_high		= 1,
 	.init_data		= &pandora_vmmc3,
 };
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 67e37df637f5..97f428e3b77a 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -984,7 +984,6 @@ static struct fixed_voltage_config camera_dummy_config = {
 	.supply_name		= "camera_vdd",
 	.input_supply		= "vcc cam",
 	.microvolts		= 2800000,
-	.enable_high		= 0,
 	.init_data		= &camera_dummy_initdata,
 };
 
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 565965e9acc7..5e110e70ce5a 100644
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
-			    NULL, GPIO_ACTIVE_HIGH),
+			    NULL, GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index bd3c23ad6ce6..cffa182167a9 100644
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
index d53ea12fc766..9b8c2cf23111 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -426,7 +426,7 @@ static struct gpiod_lookup_table can_regulator_gpiod_table = {
 	.dev_id = "reg-fixed-voltage.0",
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", ZEUS_CAN_SHDN_GPIO,
-			    NULL, GPIO_ACTIVE_HIGH),
+			    NULL, GPIO_ACTIVE_LOW),
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
index 3e8c0948abcc..3723d70af471 100644
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
index 06a894526a0b..ffddec161292 100644
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
index dbfc5cf2aa93..e3b57c346f3b 100644
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
index 2c66b528aede..109bd2bee868 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -80,7 +80,6 @@ struct regulator_enable_gpio {
 	struct gpio_desc *gpiod;
 	u32 enable_count;	/* a number of enabled shared GPIO */
 	u32 request_count;	/* a number of requested shared GPIO */
-	unsigned int ena_gpio_invert:1;
 };
 
 /*
@@ -2047,7 +2046,6 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 	}
 
 	pin->gpiod = gpiod;
-	pin->ena_gpio_invert = config->ena_gpio_invert;
 	list_add(&pin->list, &regulator_ena_gpio_list);
 
 update_ena_gpio_to_rdev:
@@ -2098,8 +2096,7 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	if (enable) {
 		/* Enable GPIO at initial use */
 		if (pin->enable_count == 0)
-			gpiod_set_value_cansleep(pin->gpiod,
-						 !pin->ena_gpio_invert);
+			gpiod_set_value_cansleep(pin->gpiod, 1);
 
 		pin->enable_count++;
 	} else {
@@ -2110,8 +2107,7 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 
 		/* Disable GPIO if not used */
 		if (pin->enable_count <= 1) {
-			gpiod_set_value_cansleep(pin->gpiod,
-						 pin->ena_gpio_invert);
+			gpiod_set_value_cansleep(pin->gpiod, 0);
 			pin->enable_count = 0;
 		}
 	}
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 588c3d2445cf..417cafe2aba0 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -457,7 +457,6 @@ static int da9055_gpio_init(struct da9055_regulator *regulator,
 		int gpio_mux = pdata->gpio_ren[id];
 
 		config->ena_gpiod = pdata->ena_gpiods[id];
-		config->ena_gpio_invert = 1;
 
 		/*
 		 * GPI pin is muxed with regulator to control the
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index ccc29038f19a..adaac8f5ddca 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -79,15 +79,6 @@ of_get_fixed_voltage_config(struct device *dev,
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	/*
-	 * FIXME: we pulled active low/high and open drain handling into
-	 * gpiolib so it will be handled there. Delete this in the second
-	 * step when we also remove the custom inversion handling for all
-	 * legacy boardfiles.
-	 */
-	config->enable_high = 1;
-	config->gpio_is_open_drain = 0;
-
 	if (of_find_property(np, "vin-supply", NULL))
 		config->input_supply = "vin";
 
@@ -151,24 +142,14 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
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
 
 	/*
 	 * Some fixed regulators share the enable line between two
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
index 49c407afb944..11cd6375215d 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -46,10 +46,6 @@ struct gpio_regulator_state {
 /**
  * struct gpio_regulator_config - config structure
  * @supply_name:	Name of the regulator supply
- * @enable_gpio:	GPIO to use for enable control
- *			set to -EINVAL if not used
- * @enable_high:	Polarity of enable GPIO
- *			1 = Active high, 0 = Active low
  * @enabled_at_boot:	Whether regulator has been enabled at
  *			boot or not. 1 = Yes, 0 = No
  *			This is used to keep the regulator at
@@ -71,8 +67,6 @@ struct gpio_regulator_state {
 struct gpio_regulator_config {
 	const char *supply_name;
 
-	int enable_gpio;
-	unsigned enable_high:1;
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
 
-- 
2.19.1

