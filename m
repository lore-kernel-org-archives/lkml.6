Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23775C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F435223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tY0zaZpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F435223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbeKPF4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:56:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57966 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeKPF4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NIzKPHM727Q72rObW0ulzFG81qsMVkgaJiH4hLwoxV0=; b=tY0zaZpBr3sD
        3kuAtr7BhqOeh3d2Yc/GS27ZYWmIItWa9Ku8oEk7DTDs7o/yWx+ph8NQ6BV45aSgTmR86iSyHljN8
        mwrVjylpcio92vBVkIRGKu8QQyGNtGlbeAs9rLdPdCGx1JQcjDUGiKyqkKhZHye0gptjzdEyB4O8a
        OYaA4=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNNbY-0006Fd-AF; Thu, 15 Nov 2018 19:47:08 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9C09B44007A; Thu, 15 Nov 2018 19:47:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     patches@opensource.cirrus.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm8994: Pass descriptor instead of GPIO number" to the regulator tree
In-Reply-To: 
Message-Id: <20181115194706.9C09B44007A@finisterre.ee.mobilebroadband>
Date:   Thu, 15 Nov 2018 19:47:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8994: Pass descriptor instead of GPIO number

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 1d2f46814d20a55c45ac171739b6885826e0c793 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 15 Nov 2018 09:01:18 +0100
Subject: [PATCH] regulator: wm8994: Pass descriptor instead of GPIO number

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.1

