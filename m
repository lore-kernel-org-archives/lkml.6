Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D4C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B49223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG7aLZgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B49223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeKOSIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:08:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37594 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeKOSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:08:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so16486913lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e409FRfNNxbNIv4WwP9QrFJYpyLvnrAbpReEHge2WlU=;
        b=NG7aLZgZQ3w5PKicl3pDJQq/avxWcBa5X6pf8oBGH0iMHdb9hstNtioFlZMnilZMz1
         kYVUZ60fp/FoAMv9e6Es4ubk0dJcE8L/yLNTupFR2hLDIQ/Skq7Tm+N8TpPyRGToWV7P
         4sqCPADj/OYpvjFIaWGAjDpW5rcKBtUFpTXoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e409FRfNNxbNIv4WwP9QrFJYpyLvnrAbpReEHge2WlU=;
        b=knmF9bvsZCnzjTDtO9LIjKEYrvOwgUonvXfHUQelqXCRi2n3xLcxH7D14jTkd64M7H
         svJqV8KPN9g5p7H1sdm2jeI5OheqKQP5mNIKxtOqGldvipvZgxtl2BmQC15KlyojSzGd
         C2oS06MHslpoCnm4SgiE6MNN6DoCYhoy9QD8ts8STIW4GB3QY071dTu+3N+hlAKfYVOv
         IRLPgR4j+V07338ReUiFew/VVR8JfAgELHhs/G7SkwsoU3hmFVkcrKxr73e3vzsg6Bw1
         1OVoz/UcDWHFhRsAFjNiptD8oDdRTvlQQ9LS9ct9E47agpg7WVBcjOPZpLCCY84EPSoV
         OArw==
X-Gm-Message-State: AGRZ1gJdk8eVfmJOKyFNl16YVMBJ18NyJh37J9X5cGp9V+ewfAn4ijCJ
        OpN2h3WT7gYp3pGGucC6Y4GaNQ==
X-Google-Smtp-Source: AJdET5faLpqbAQE4jsQaYd1ncRtC+g04BVP7DamoX4HYjA8DQvXkwjjsRqeUXcLzKZfV0KVlsIJKHQ==
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr2937312lji.93.1542268894152;
        Thu, 15 Nov 2018 00:01:34 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o25sm4003427lfd.29.2018.11.15.00.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 00:01:33 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        patches@opensource.cirrus.com
Subject: [PATCH 2/8 v6] regulator: wm8994: Pass descriptor instead of GPIO number
Date:   Thu, 15 Nov 2018 09:01:18 +0100
Message-Id: <20181115080124.7789-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181115080124.7789-1-linus.walleij@linaro.org>
References: <20181115080124.7789-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a global GPIO number for the enable GPIO, pass
a descriptor looked up from the device tree node or the board file
decriptor table for the regulator.

There is a single board file passing the GPIOs for LDO1 and LDO2
through platform data, so augment this to pass descriptors
associated with the i2c device as well.

The special GPIO enable DT property for the enable GPIO is
nonstandard but this was accomodated in
commit 6a537d48461deacc57c07ed86d9915e5aa4b3539
"gpio: of: Support regulator nonstandard GPIO properties".

Cc: patches@opensource.cirrus.com
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v6:
- Request the GPIO line as shared as with other regulators.
- Renumber to fit the rest of the patch series.
ChangeLog v2->v3:
- Collect Charles' ACK.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
- Collect Lee's ACK.
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 17 +++++++++++++++--
 drivers/mfd/wm8994-core.c                    |  9 ---------
 drivers/regulator/wm8994-regulator.c         | 20 ++++++++++++--------
 include/linux/mfd/wm8994/pdata.h             |  3 ---
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 5aa472892465..76c4855a03bc 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -194,8 +194,8 @@ static struct wm8994_pdata wm8994_pdata = {
 		0x3,          /* IRQ out, active high, CMOS */
 	},
 	.ldo = {
-		 { .enable = S3C64XX_GPN(6), .init_data = &wm8994_ldo1, },
-		 { .enable = S3C64XX_GPN(4), .init_data = &wm8994_ldo2, },
+		 { .init_data = &wm8994_ldo1, },
+		 { .init_data = &wm8994_ldo2, },
 	},
 };
 
@@ -203,6 +203,18 @@ static const struct i2c_board_info wm1277_devs[] = {
 	{ I2C_BOARD_INFO("wm8958", 0x1a),  /* WM8958 is the superset */
 	  .platform_data = &wm8994_pdata,
 	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
+	  .dev_name = "wm8958",
+	},
+};
+
+static struct gpiod_lookup_table wm8994_gpiod_table = {
+	.dev_id = "i2c-wm8958", /* I2C device name */
+	.table = {
+		GPIO_LOOKUP("GPION", 6,
+			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPION", 4,
+			    "wlf,ldo2ena", GPIO_ACTIVE_HIGH),
+		{ },
 	},
 };
 
@@ -381,6 +393,7 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
 
 	gpiod_add_lookup_table(&wm5102_reva_gpiod_table);
 	gpiod_add_lookup_table(&wm5102_gpiod_table);
+	gpiod_add_lookup_table(&wm8994_gpiod_table);
 
 	if (i < ARRAY_SIZE(gf_mods)) {
 		dev_info(&i2c->dev, "%s revision %d\n",
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 22bd6525e09c..04a177efd245 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -21,7 +21,6 @@
 #include <linux/mfd/core.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -306,14 +305,6 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
 
 	pdata->csnaddr_pd = of_property_read_bool(np, "wlf,csnaddr-pd");
 
-	pdata->ldo[0].enable = of_get_named_gpio(np, "wlf,ldo1ena", 0);
-	if (pdata->ldo[0].enable < 0)
-		pdata->ldo[0].enable = 0;
-
-	pdata->ldo[1].enable = of_get_named_gpio(np, "wlf,ldo2ena", 0);
-	if (pdata->ldo[1].enable < 0)
-		pdata->ldo[1].enable = 0;
-
 	return 0;
 }
 #else
diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index 7a4ce6df4f22..d7fec533c403 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/mfd/wm8994/core.h>
@@ -129,6 +129,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	int id = pdev->id % ARRAY_SIZE(pdata->ldo);
 	struct regulator_config config = { };
 	struct wm8994_ldo *ldo;
+	struct gpio_desc *gpiod;
 	int ret;
 
 	dev_dbg(&pdev->dev, "Probing LDO%d\n", id + 1);
@@ -145,12 +146,15 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	config.driver_data = ldo;
 	config.regmap = wm8994->regmap;
 	config.init_data = &ldo->init_data;
-	if (pdata) {
-		config.ena_gpio = pdata->ldo[id].enable;
-	} else if (wm8994->dev->of_node) {
-		config.ena_gpio = wm8994->pdata.ldo[id].enable;
-		config.ena_gpio_initialized = true;
-	}
+
+	/* Look up LDO enable GPIO from the parent device node */
+	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
+					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
+					GPIOD_OUT_LOW |
+					GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	if (IS_ERR(gpiod))
+		return PTR_ERR(gpiod);
+	config.ena_gpiod = gpiod;
 
 	/* Use default constraints if none set up */
 	if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
@@ -159,7 +163,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 
 		ldo->init_data = wm8994_ldo_default[id];
 		ldo->init_data.consumer_supplies = &ldo->supply;
-		if (!config.ena_gpio)
+		if (!gpiod)
 			ldo->init_data.constraints.valid_ops_mask = 0;
 	} else {
 		ldo->init_data = *pdata->ldo[id].init_data;
diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index b19c370fe81a..f346167c0e00 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -20,9 +20,6 @@
 #define WM8994_NUM_AIF   3
 
 struct wm8994_ldo_pdata {
-	/** GPIOs to enable regulator, 0 or less if not available */
-	int enable;
-
 	const struct regulator_init_data *init_data;
 };
 
-- 
2.17.2

