Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BEAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3573C2183D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tossL+Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3573C2183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeHUUib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:38:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36442 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeHUUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:38:24 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 20/24] MIPS: qi_lb60: Move PWM devices to devicetree
Date:   Tue, 21 Aug 2018 19:16:31 +0200
Message-Id: <20180821171635.22740-21-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871842; bh=omgOqb/tQC/ptmqAgz3TKhKtCWHfV/mahlCiSBmpyw0=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tossL+Z6hpd6CCOT4WzUVyOdy8gNGmnnr0cf9SKL+x7jhz2WeKJ1QwLcsvIPjvHqsZaU5tZV/LYPI0pZz6vMINicQOmZFg9qb84jPHuhYooIof0xPbOy0Y6dLCnQ9XWH8krQDhn5moIvjvPzx1eUFSWr3Rwhxvl2/lTkSZOG5eU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe the few drivers using PWMs from devicetree, now that we have a
devicetree node for the PWM driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: No change
    
     v7: No change

 arch/mips/boot/dts/ingenic/qi_lb60.dts | 14 ++++++++++++++
 arch/mips/jz4740/board-qi_lb60.c       | 19 -------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

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

