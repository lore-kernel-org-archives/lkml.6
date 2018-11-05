Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D601C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0553F20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAHGWlvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0553F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeKFIoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:44:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40550 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeKFIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:44:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id t22-v6so9697021lji.7;
        Mon, 05 Nov 2018 15:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WjJ3xiFUaId2qtdRhODuZFIjQndpEYO3YuyhVmsQaiQ=;
        b=HAHGWlvnS+G4RekpXLMKw0D9S1v6HIFFfGKruPN4UqftxWzRPREb4KvQJtwuSsFl4X
         ECFNsvFTzGMbxzvL/r6P4Yj88+1I4B8qlopJvv4jSCmfYaGi/imjKYaDtTUDwwv9mf2Z
         ILD3XJfLGqBvr/zyh/ApRjfM3YBVbJgBRNC3CzHrvxPpbI8q5u8N2T+pEIASYutfXvsE
         WFr9ZuKLXPdZbop7k5g5nrjGiqRs/0AOJ56s3G1Mo5gz/DhQ3La4+9fDf3r9+wwBlNJE
         aXOQL0+9FpwCu5rVRCQtvrIy/IavmgMSxymJl81qHAwDND+NPJQGfQ83TIJOuKDGX5Z2
         Ncig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WjJ3xiFUaId2qtdRhODuZFIjQndpEYO3YuyhVmsQaiQ=;
        b=fzwfCjcc+2X1pe+BYLijaN6ZuQDR4M5qwJ3Xx9r+Opc9M06WLXN1LieqltR15eGyuh
         +UMzHx2jo8S2jF8TuPkh83RfnkK2TGaOJariAHGMX5MvWhN/fqDw2GzbtG94TJoR7IAf
         HX7AWl6M6EqLKoFECk4LI7znGKucvPGirSEXKtfRNHH17o9zsu0oGEhXSz73DIMhj3TI
         7VxdhGie7GX8IPzi7gAzenZSticqcAIdqoBcwIvJrU5VEsPj12lp+O/AoylfkS+lgXBt
         04fdjasfqPDHVPuJ4ym7rILyODnO5AcsrktIV67hMeA1nlsLVVtcYfWNMO33r6bxQUHE
         WEHg==
X-Gm-Message-State: AGRZ1gJM3/UjZlkdDVADSEK2X7MOD7YlkNKKOq3MSJ0Yf6PhZMCJMEtM
        +R49GLr4e51Ig+jqgxPXOFQ=
X-Google-Smtp-Source: AJdET5dQQkpTIsoKm9IOn8ArgOYCVhehvacmbcA3Ev3+m2z/IBvulsYFUk3/KXX4SbQc8y4yWiPbxA==
X-Received: by 2002:a2e:568b:: with SMTP id k11-v6mr15830718lje.105.1541460126827;
        Mon, 05 Nov 2018 15:22:06 -0800 (PST)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id x11sm1843286lfd.81.2018.11.05.15.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 15:22:06 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device
Date:   Tue,  6 Nov 2018 00:23:49 +0100
Message-Id: <20181105232349.17351-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global GPIO numbers no longer have to be passed to leds-gpio driver,
replace their assignment with a lookup table.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 95 ++++++++++-------------------------
 1 file changed, 26 insertions(+), 69 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index b8acc9912a58..19e0c071d675 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -371,15 +371,9 @@ static struct gpiod_lookup_table ams_delta_lcd_gpio_table = {
 	},
 };
 
-/*
- * Dynamically allocated GPIO numbers must be obtained fromm GPIO device
- * before they can be put in the gpio_led table.  Before that happens,
- * initialize the table with invalid GPIO numbers, not 0.
- */
 static struct gpio_led gpio_leds[] __initdata = {
 	[LATCH1_PIN_LED_CAMERA] = {
 		.name		 = "camera",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 #ifdef CONFIG_LEDS_TRIGGERS
 		.default_trigger = "ams_delta_camera",
@@ -387,27 +381,22 @@ static struct gpio_led gpio_leds[] __initdata = {
 	},
 	[LATCH1_PIN_LED_ADVERT] = {
 		.name		 = "advert",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 	[LATCH1_PIN_LED_MAIL] = {
 		.name		 = "email",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 	[LATCH1_PIN_LED_HANDSFREE] = {
 		.name		 = "handsfree",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 	[LATCH1_PIN_LED_VOICEMAIL] = {
 		.name		 = "voicemail",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 	[LATCH1_PIN_LED_VOICE] = {
 		.name		 = "voice",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 };
@@ -417,6 +406,24 @@ static const struct gpio_led_platform_data leds_pdata __initconst = {
 	.num_leds	= ARRAY_SIZE(gpio_leds),
 };
 
+static struct gpiod_lookup_table leds_gpio_table = {
+	.table = {
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_CAMERA, NULL,
+				LATCH1_PIN_LED_CAMERA, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_ADVERT, NULL,
+				LATCH1_PIN_LED_ADVERT, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_MAIL, NULL,
+				LATCH1_PIN_LED_MAIL, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_HANDSFREE, NULL,
+				LATCH1_PIN_LED_HANDSFREE, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_VOICEMAIL, NULL,
+				LATCH1_PIN_LED_VOICEMAIL, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_VOICE, NULL,
+				LATCH1_PIN_LED_VOICE, 0),
+		{ },
+	},
+};
+
 static struct i2c_board_info ams_delta_camera_board_info[] = {
 	{
 		I2C_BOARD_INFO("ov6650", 0x60),
@@ -677,6 +684,8 @@ static void __init ams_delta_latch2_init(void)
 
 static void __init ams_delta_init(void)
 {
+	struct platform_device *leds_pdev;
+
 	/* mux pins for uarts */
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
@@ -740,6 +749,12 @@ static void __init ams_delta_init(void)
 	gpiod_add_lookup_tables(ams_delta_gpio_tables,
 				ARRAY_SIZE(ams_delta_gpio_tables));
 
+	leds_pdev = gpio_led_register_device(PLATFORM_DEVID_NONE, &leds_pdata);
+	if (!IS_ERR(leds_pdev)) {
+		leds_gpio_table.dev_id = dev_name(&leds_pdev->dev);
+		gpiod_add_lookup_table(&leds_gpio_table);
+	}
+
 	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
 
 	omapfb_set_lcd_config(&ams_delta_lcd_config);
@@ -793,64 +808,6 @@ static struct platform_device ams_delta_modem_device = {
 	},
 };
 
-/*
- * leds-gpio driver doesn't make use of GPIO lookup tables,
- * it has to be provided with GPIO numbers over platform data
- * if GPIO descriptor info can't be obtained from device tree.
- * We could either define GPIO lookup tables and use them on behalf
- * of the leds-gpio device, or we can use GPIO driver level methods
- * for identification of GPIO numbers as long as we don't support
- * device tree.  Let's do the latter.
- */
-static void __init ams_delta_led_init(struct gpio_chip *chip)
-{
-	struct gpio_desc *gpiod;
-	int i;
-
-	for (i = LATCH1_PIN_LED_CAMERA; i < LATCH1_PIN_DOCKIT1; i++) {
-		gpiod = gpiochip_request_own_desc(chip, i, NULL);
-		if (IS_ERR(gpiod)) {
-			pr_warn("%s: %s GPIO %d request failed (%ld)\n",
-				__func__, LATCH1_LABEL, i, PTR_ERR(gpiod));
-			continue;
-		}
-
-		/* Assign GPIO numbers to LED device. */
-		gpio_leds[i].gpio = desc_to_gpio(gpiod);
-
-		gpiochip_free_own_desc(gpiod);
-	}
-
-	gpio_led_register_device(PLATFORM_DEVID_NONE, &leds_pdata);
-}
-
-/*
- * The purpose of this function is to take care of assignment of GPIO numbers
- * to platform devices which depend on GPIO lines provided by Amstrad Delta
- * latch1 and/or latch2 GPIO devices but don't use GPIO lookup tables.
- * The function may be called as soon as latch1/latch2 GPIO devices are
- * initilized.  Since basic-mmio-gpio driver is not registered before
- * device_initcall, this may happen at erliest during device_initcall_sync.
- * Dependent devices shouldn't be registered before that, their
- * registration may be performed from within this function or later.
- */
-static int __init ams_delta_gpio_init(void)
-{
-	struct gpio_chip *chip;
-
-	if (!machine_is_ams_delta())
-		return -ENODEV;
-
-	chip = gpiochip_find(LATCH1_LABEL, gpiochip_match_by_label);
-	if (!chip)
-		pr_err("%s: latch1 GPIO chip not found\n", __func__);
-	else
-		ams_delta_led_init(chip);
-
-	return 0;
-}
-device_initcall_sync(ams_delta_gpio_init);
-
 static int __init modem_nreset_init(void)
 {
 	int err;
-- 
2.16.4

