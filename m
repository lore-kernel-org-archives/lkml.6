Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8CEC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA65F2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SvzpZ+Yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfAYUJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:09:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48250 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfAYUJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548446990; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+qtoQrEMsAxuCO3NFkxjd0qE3pGAyDjYjSr5X5AQomU=;
        b=SvzpZ+YrLwDU/8idZFd9XE2y+I8ykRhIIFsDMsuHr8D/iBSf9UeH8mJvQ5N6y+rZuPyeR0
        mMyl+ZNOLpFse+vQnR6j0OFKzp1oaXU/qis8IxOKa/UwyeWxxdfJAd6CtwwlfZf59xhl/0
        9pUyYHcaFDNx5KBCfB/MpHo+dAUrQsE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] MIPS: qi_lb60: Move MMC configuration to devicetree
Date:   Fri, 25 Jan 2019 17:09:27 -0300
Message-Id: <20190125200927.21045-3-paul@crapouillou.net>
In-Reply-To: <20190125200927.21045-1-paul@crapouillou.net>
References: <20190125200927.21045-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the MMC configuration from the board C file to devicetree.

The 'power' GPIO was removed and instead the vmmc regulator is used,
to follow the changes introduced in the jz4740-mmc driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 33 +++++++++++++++++++++++++++++++++
 arch/mips/jz4740/board-qi_lb60.c       | 32 --------------------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index 76aaf8982554..cc26650562c2 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include "jz4740.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "qi,lb60", "ingenic,jz4740";
@@ -9,6 +10,15 @@
 	chosen {
 		stdout-path = &uart0;
 	};
+
+	mmc_power: fixedregulator {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_vcc";
+		gpio = <&gpd 2 0>;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &ext {
@@ -30,4 +40,27 @@
 		groups = "uart0-data";
 		bias-disable;
 	};
+
+	pins_mmc: mmc {
+		mmc {
+			function = "mmc";
+			groups = "mmc-1bit", "mmc-4bit";
+			bias-disable;
+		};
+
+		mmc-gpios {
+			pins = "PD0", "PD2";
+			bias-disable;
+		};
+	};
+};
+
+&mmc {
+	bus-width = <4>;
+	max-frequency = <24000000>;
+	cd-gpios = <&gpd 0 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&mmc_power>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_mmc>;
 };
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 6718efb400f4..8e4c7ac6ac02 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -33,7 +33,6 @@
 
 #include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
-#include <asm/mach-jz4740/jz4740_mmc.h>
 
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -382,19 +381,6 @@ static struct platform_device qi_lb60_gpio_keys = {
 	}
 };
 
-static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
-	/* Intentionally left blank */
-};
-
-static struct gpiod_lookup_table qi_lb60_mmc_gpio_table = {
-	.dev_id = "jz4740-mmc.0",
-	.table = {
-		GPIO_LOOKUP("GPIOD", 0, "cd", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("GPIOD", 2, "power", GPIO_ACTIVE_LOW),
-		{ },
-	},
-};
-
 /* beeper */
 static struct pwm_lookup qi_lb60_pwm_lookup[] = {
 	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
@@ -445,7 +431,6 @@ static struct gpiod_lookup_table qi_lb60_audio_gpio_table = {
 static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_udc_device,
 	&jz4740_udc_xceiv_device,
-	&jz4740_mmc_device,
 	&jz4740_nand_device,
 	&qi_lb60_keypad,
 	&qi_lb60_spigpio_device,
@@ -455,17 +440,12 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_codec_device,
 	&jz4740_adc_device,
 	&jz4740_pwm_device,
-	&jz4740_dma_device,
 	&qi_lb60_gpio_keys,
 	&qi_lb60_pwm_beeper,
 	&qi_lb60_charger_device,
 	&qi_lb60_audio_device,
 };
 
-static unsigned long pin_cfg_bias_disable[] = {
-	    PIN_CONFIG_BIAS_DISABLE,
-};
-
 static struct pinctrl_map pin_map[] __initdata = {
 	/* NAND pin configuration */
 	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-nand",
@@ -477,16 +457,6 @@ static struct pinctrl_map pin_map[] __initdata = {
 	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_SLEEP,
 			"10010000.jz4740-pinctrl", "lcd", "lcd-no-pins"),
 
-	/* MMC pin configuration */
-	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
-			"10010000.jz4740-pinctrl", "mmc", "mmc-1bit"),
-	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
-			"10010000.jz4740-pinctrl", "mmc", "mmc-4bit"),
-	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
-			"10010000.jz4740-pinctrl", "PD0", pin_cfg_bias_disable),
-	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
-			"10010000.jz4740-pinctrl", "PD2", pin_cfg_bias_disable),
-
 	/* PWM pin configuration */
 	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-pwm",
 			"10010000.jz4740-pinctrl", "pwm4", "pwm4"),
@@ -498,12 +468,10 @@ static int __init qi_lb60_init_platform_devices(void)
 	jz4740_framebuffer_device.dev.platform_data = &qi_lb60_fb_pdata;
 	jz4740_nand_device.dev.platform_data = &qi_lb60_nand_pdata;
 	jz4740_adc_device.dev.platform_data = &qi_lb60_battery_pdata;
-	jz4740_mmc_device.dev.platform_data = &qi_lb60_mmc_pdata;
 
 	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_nand_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_spigpio_gpio_table);
-	gpiod_add_lookup_table(&qi_lb60_mmc_gpio_table);
 
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
-- 
2.11.0

