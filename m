Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80286C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A4D21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fcV7veFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A4D21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeHJAMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:12:15 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38784 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeHJAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:12:14 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 20/24] MIPS: qi_lb60: Move PWM devices to devicetree
Date:   Thu,  9 Aug 2018 23:44:10 +0200
Message-Id: <20180809214414.20905-21-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533851126; bh=ud0udkoc/ygzPwD7ng+ltjpXM+BoA0DildI1rhzVmqw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fcV7veFy5jfeQ08cmUDv66XzaGaGIcv22S8vBxr3aToBXJUYmFaxelz6fl3jEnF7kDJyphYoyVebrT/t/vzfGrqu3twr2dyPL4v13s8zcfeWRosc6sh3lR1VmxWbiS2cCfyatUpEC64PmMtSkiaKmQsZGRcmh0RQlKkw8doHR5k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe the few drivers using PWMs from devicetree, now that we have a
devicetree node for the PWM driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 14 ++++++++++++++
 arch/mips/jz4740/board-qi_lb60.c       | 19 -------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

 v5: New patch

 v6: No change

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index 76aaf8982554..85529a142409 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -9,6 +9,14 @@
 	chosen {
 		stdout-path = &uart0;
 	};
+
+	beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm 4 0 0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_pwm4>;
+	};
 };
 
 &ext {
@@ -30,4 +38,10 @@
 		groups = "uart0-data";
 		bias-disable;
 	};
+
+	pins_pwm4: pwm4 {
+		function = "pwm4";
+		groups = "pwm4";
+		bias-disable;
+	};
 };
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 60f0767507c6..2db32cb9ed47 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -27,7 +27,6 @@
 #include <linux/power_supply.h>
 #include <linux/power/jz4740-battery.h>
 #include <linux/power/gpio-charger.h>
-#include <linux/pwm.h>
 
 #include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
@@ -391,17 +390,6 @@ static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
 	.power_active_low	= 1,
 };
 
-/* beeper */
-static struct pwm_lookup qi_lb60_pwm_lookup[] = {
-	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
-		   PWM_POLARITY_NORMAL),
-};
-
-static struct platform_device qi_lb60_pwm_beeper = {
-	.name = "pwm-beeper",
-	.id = -1,
-};
-
 /* charger */
 static char *qi_lb60_batteries[] = {
 	"battery",
@@ -450,10 +438,8 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_i2s_device,
 	&jz4740_codec_device,
 	&jz4740_adc_device,
-	&jz4740_pwm_device,
 	&jz4740_dma_device,
 	&qi_lb60_gpio_keys,
-	&qi_lb60_pwm_beeper,
 	&qi_lb60_charger_device,
 	&qi_lb60_audio_device,
 };
@@ -482,10 +468,6 @@ static struct pinctrl_map pin_map[] __initdata = {
 			"10010000.jz4740-pinctrl", "PD0", pin_cfg_bias_disable),
 	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
 			"10010000.jz4740-pinctrl", "PD2", pin_cfg_bias_disable),
-
-	/* PWM pin configuration */
-	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-pwm",
-			"10010000.jz4740-pinctrl", "pwm4", "pwm4"),
 };
 
 
@@ -503,7 +485,6 @@ static int __init qi_lb60_init_platform_devices(void)
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
 
-	pwm_add_table(qi_lb60_pwm_lookup, ARRAY_SIZE(qi_lb60_pwm_lookup));
 	pinctrl_register_mappings(pin_map, ARRAY_SIZE(pin_map));
 
 	return platform_add_devices(jz_platform_devices,
-- 
2.11.0

