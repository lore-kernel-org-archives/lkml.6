Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 05080C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D2C20864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaDD0lwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D2C20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964920AbeFNWRI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:17:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34629 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936045AbeFNWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:17:05 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so11791098lfk.1;
        Thu, 14 Jun 2018 15:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=avFvAsXYwdLu/5FxKxoi34+Os5rVKhF5UnCr5mhGw+o=;
        b=EaDD0lwYQKJxJd6xWvFQq6vrETlJoyyUg11j30f1KtwdQiv8HiyKx0Blsh8dL/sDaC
         PicvscV5g7IeuNwpkNMgiWG5HtjL5vETwcbAy6oHzKQyDx4OOhUhSo5ckFY0/QSAeBhk
         6u4X73baeR20rR9OHbydGSYsH13bm97dBJopcaAdfsNyExipJSaYImrTLAKzM9cftPeh
         Xn2ZU6/x2RpyGFtoNOfCbh/qNNwB+4jzpEr3g20rGCVd+QhwqqLkgtYmesa5vyOku8eW
         zUW2qWIsJiikTBrvOhe8v8g9j5ifjTnvbYVy+0xLM91IM3La9idP9zIPyAv8fuQSdqJq
         c1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=avFvAsXYwdLu/5FxKxoi34+Os5rVKhF5UnCr5mhGw+o=;
        b=iTR7NBV34UBRmEjcbvOZk14jJsOiHEjFnxIaPf2/gTRQyUF+JVlgUA+XWIy/OcuLTI
         K+4OQ5PefnnCdis7PbWHscXsoKOTLF2vUw8+UEfAowsgUtJKztZ/CEmRzNk29QaeoVuS
         Q6T8vRJyzhwoAaiuOFuHEA7LTmA+UG946TRAZiEYO6IM5wPd2J/VB21/Et32dPZ5/ukz
         gjVLwIy9xcuZnDhScAP4fGCUsA+pgO17X+VB2s9OfPYzwRJOYCEhSIftaJt/mSBdp5bO
         3ZcXuv6o1LFTp7GC0uNDHqzYPygIpT5iiseAAqQQnusq7MNRLZRkJ3o/tiKmMXgSQyCp
         aoJA==
X-Gm-Message-State: APt69E2gCyfqC0ugfxXSLD6fPInaDFnmXmvo7FTcHBO0/muC/61Lh3Jv
        aoVx2mM0a1B/ZhKUhrIWNLg=
X-Google-Smtp-Source: ADUXVKJvAHzGSk4tJh8IGMTB4C3xJhn+W1CtA4DASDotnIhbtlSSZdWjfSAj0QmCeOzDCnrBAeL68g==
X-Received: by 2002:a2e:2b1b:: with SMTP id q27-v6mr310012lje.145.1529014623717;
        Thu, 14 Jun 2018 15:17:03 -0700 (PDT)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id o7-v6sm1131010ljh.97.2018.06.14.15.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 15:17:02 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 4/10 v2] Input: ams_delta_serio: Replace power GPIO with regulator
Date:   Fri, 15 Jun 2018 00:16:49 +0200
Message-Id: <20180614221649.12850-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180613205144.GB62746@dtor-ws>
References: <20180613205144.GB62746@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the driver so it no longer requests and manipulates the
"keybrd_pwr" GPIO pin but a "vcc" regulator supply instead.

For this to work with Amstrad Delta, define a regulator over the
"keybrd_pwr" GPIO pin with the "vcc" supply for ams-delta-serio device
and register it from the board file.  Both assign an absulute GPIO
number to the soon depreciated .gpio member of the regulator config
structure, and also build and register a GPIO lookup table so it is
ready for use by the regulator driver as soon as its upcoming update
is applied.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: Extend the comment above error code conversion, thanks Dmitry for 
    requesting that.

If you prefer me to resubmit the whole series as v2, please let me know.
In that case, I'll also add the patch which moves substitution of IRQ
handler out of the driver and submit complete v2 as soon as I get access
to the device (next weekend) and can test that extra change, otherwise
I'll submit it as a separate patch.

Thanks,
Janusz


 arch/arm/mach-omap1/board-ams-delta.c | 63 +++++++++++++++++++++++++++++++++--
 drivers/input/serio/ams_delta_serio.c | 37 +++++++++++++++-----
 2 files changed, 89 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 2119d2d3ba84..706eb2f9301d 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -509,6 +509,46 @@ static struct platform_device ams_delta_serio_device = {
 	.id		= PLATFORM_DEVID_NONE,
 };
 
+static struct regulator_consumer_supply keybrd_pwr_consumers[] = {
+	/*
+	 * Initialize supply .dev_name with NULL.  It will be replaced
+	 * with serio dev_name() as soon as the serio device is registered.
+	 */
+	REGULATOR_SUPPLY("vcc", NULL),
+};
+
+static struct regulator_init_data keybrd_pwr_initdata = {
+	.constraints		= {
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(keybrd_pwr_consumers),
+	.consumer_supplies	= keybrd_pwr_consumers,
+};
+
+static struct fixed_voltage_config keybrd_pwr_config = {
+	.supply_name		= "keybrd_pwr",
+	.microvolts		= 5000000,
+	.gpio			= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
+	.enable_high		= 1,
+	.init_data		= &keybrd_pwr_initdata,
+};
+
+static struct platform_device keybrd_pwr_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= PLATFORM_DEVID_AUTO,
+	.dev	= {
+		.platform_data	= &keybrd_pwr_config,
+	},
+};
+
+static struct gpiod_lookup_table keybrd_pwr_gpio_table = {
+	.table = {
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_PWR, NULL,
+			    GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&latch1_gpio_device,
 	&latch2_gpio_device,
@@ -526,6 +566,7 @@ static struct platform_device *late_devices[] __initdata = {
 
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
 	&ams_delta_audio_gpio_table,
+	&keybrd_pwr_gpio_table,
 };
 
 static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
@@ -566,12 +607,30 @@ static void __init ams_delta_init(void)
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 	/*
-	 * As soon as devices have been registered, assign their dev_names
-	 * to respective GPIO lookup tables before they are added.
+	 * As soon as regulator consumers have been registered, assign their
+	 * dev_names to consumer supply entries of respective regulators.
+	 */
+	keybrd_pwr_consumers[0].dev_name =
+			dev_name(&ams_delta_serio_device.dev);
+
+	/*
+	 * Once consumer supply entries are populated with dev_names,
+	 * register regulator devices.  At this stage only the keyboard
+	 * power regulator has its consumer supply table fully populated.
+	 */
+	platform_device_register(&keybrd_pwr_device);
+
+	/*
+	 * As soon as GPIO consumers have been registered, assign
+	 * their dev_names to respective GPIO lookup tables.
 	 */
 	ams_delta_audio_gpio_table.dev_id =
 			dev_name(&ams_delta_audio_device.dev);
+	keybrd_pwr_gpio_table.dev_id = dev_name(&keybrd_pwr_device.dev);
 
+	/*
+	 * Once GPIO lookup tables are populated with dev_names, register them.
+	 */
 	gpiod_add_lookup_tables(ams_delta_gpio_tables,
 				ARRAY_SIZE(ams_delta_gpio_tables));
 
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 551a4fa73fe4..854d0d3ada52 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -39,6 +40,7 @@ MODULE_LICENSE("GPL");
 
 struct ams_delta_serio {
 	struct serio *serio;
+	struct regulator *vcc;
 };
 
 static int check_data(struct serio *serio, int data)
@@ -94,16 +96,18 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 
 static int ams_delta_serio_open(struct serio *serio)
 {
-	/* enable keyboard */
-	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 1);
+	struct ams_delta_serio *priv = serio->port_data;
 
-	return 0;
+	/* enable keyboard */
+	return regulator_enable(priv->vcc);
 }
 
 static void ams_delta_serio_close(struct serio *serio)
 {
+	struct ams_delta_serio *priv = serio->port_data;
+
 	/* disable keyboard */
-	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 0);
+	regulator_disable(priv->vcc);
 }
 
 static const struct gpio ams_delta_gpios[] __initconst_or_module = {
@@ -117,11 +121,6 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 		.flags	= GPIOF_DIR_IN,
 		.label	= "serio-clock",
 	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "serio-power",
-	},
 	{
 		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT,
 		.flags	= GPIOF_OUT_INIT_LOW,
@@ -146,6 +145,26 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 		goto serio;
 	}
 
+	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
+	if (IS_ERR(priv->vcc)) {
+		err = PTR_ERR(priv->vcc);
+		dev_err(&pdev->dev, "regulator request failed (%d)\n", err);
+		/*
+		 * When running on a non-dt platform and requested regulator
+		 * is not available, devm_regulator_get() never returns
+		 * -EPROBE_DEFER as it is not able to justify if the regulator
+		 * may still appear later.  On the other hand, the board can
+		 * still set full constriants flag at late_initcall in order
+		 * to instruct devm_regulator_get() to returnn a dummy one
+		 * if sufficient.  Hence, if we get -ENODEV here, let's convert
+		 * it to -EPROBE_DEFER and wait for the board to decide or
+		 * let Deferred Probe infrastructure handle this error.
+		 */
+		if (err == -ENODEV)
+			err = -EPROBE_DEFER;
+		goto gpio;
+	}
+
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
 			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
 			DRIVER_NAME, priv);
-- 
2.16.1

