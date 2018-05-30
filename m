Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeE3Odj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:33:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeE3Od3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:33:29 -0400
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm8994: Fix shared GPIOs" to the regulator tree
In-Reply-To: 
Message-Id: <E1fO2AH-0004X6-0w@debutante>
Date: Wed, 30 May 2018 15:33:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8994: Fix shared GPIOs

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

>From ab4d11e2c2329cf7cb7be31ff22489aae4dee5dc Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 May 2018 15:15:20 +0100
Subject: [PATCH] regulator: wm8994: Fix shared GPIOs

This reverts commit 3c6b38d45fa51c7c51 "regulator: wm8994: Pass
descriptor instead of GPIO number" as it has problems with shared
GPIOs similar to that on s2mps11.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 17 ++---------------
 drivers/mfd/wm8994-core.c                    |  9 +++++++++
 drivers/regulator/wm8994-regulator.c         | 19 ++++++++-----------
 include/linux/mfd/wm8994/pdata.h             |  3 +++
 4 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 76c4855a03bc..5aa472892465 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -194,8 +194,8 @@ static struct wm8994_pdata wm8994_pdata = {
 		0x3,          /* IRQ out, active high, CMOS */
 	},
 	.ldo = {
-		 { .init_data = &wm8994_ldo1, },
-		 { .init_data = &wm8994_ldo2, },
+		 { .enable = S3C64XX_GPN(6), .init_data = &wm8994_ldo1, },
+		 { .enable = S3C64XX_GPN(4), .init_data = &wm8994_ldo2, },
 	},
 };
 
@@ -203,18 +203,6 @@ static const struct i2c_board_info wm1277_devs[] = {
 	{ I2C_BOARD_INFO("wm8958", 0x1a),  /* WM8958 is the superset */
 	  .platform_data = &wm8994_pdata,
 	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
-	  .dev_name = "wm8958",
-	},
-};
-
-static struct gpiod_lookup_table wm8994_gpiod_table = {
-	.dev_id = "i2c-wm8958", /* I2C device name */
-	.table = {
-		GPIO_LOOKUP("GPION", 6,
-			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("GPION", 4,
-			    "wlf,ldo2ena", GPIO_ACTIVE_HIGH),
-		{ },
 	},
 };
 
@@ -393,7 +381,6 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
 
 	gpiod_add_lookup_table(&wm5102_reva_gpiod_table);
 	gpiod_add_lookup_table(&wm5102_gpiod_table);
-	gpiod_add_lookup_table(&wm8994_gpiod_table);
 
 	if (i < ARRAY_SIZE(gf_mods)) {
 		dev_info(&i2c->dev, "%s revision %d\n",
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index c409464231f6..953d0790ffd5 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -21,6 +21,7 @@
 #include <linux/mfd/core.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -301,6 +302,14 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
 	if (of_find_property(np, "wlf,ldoena-always-driven", NULL))
 		pdata->lineout2fb = true;
 
+	pdata->ldo[0].enable = of_get_named_gpio(np, "wlf,ldo1ena", 0);
+	if (pdata->ldo[0].enable < 0)
+		pdata->ldo[0].enable = 0;
+
+	pdata->ldo[1].enable = of_get_named_gpio(np, "wlf,ldo2ena", 0);
+	if (pdata->ldo[1].enable < 0)
+		pdata->ldo[1].enable = 0;
+
 	return 0;
 }
 #else
diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index d3a5f48119c2..7a4ce6df4f22 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
 #include <linux/slab.h>
 
 #include <linux/mfd/wm8994/core.h>
@@ -129,7 +129,6 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	int id = pdev->id % ARRAY_SIZE(pdata->ldo);
 	struct regulator_config config = { };
 	struct wm8994_ldo *ldo;
-	struct gpio_desc *gpiod;
 	int ret;
 
 	dev_dbg(&pdev->dev, "Probing LDO%d\n", id + 1);
@@ -146,14 +145,12 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	config.driver_data = ldo;
 	config.regmap = wm8994->regmap;
 	config.init_data = &ldo->init_data;
-
-	/* Look up LDO enable GPIO from the parent device node */
-	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
-					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
-					GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod))
-		return PTR_ERR(gpiod);
-	config.ena_gpiod = gpiod;
+	if (pdata) {
+		config.ena_gpio = pdata->ldo[id].enable;
+	} else if (wm8994->dev->of_node) {
+		config.ena_gpio = wm8994->pdata.ldo[id].enable;
+		config.ena_gpio_initialized = true;
+	}
 
 	/* Use default constraints if none set up */
 	if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
@@ -162,7 +159,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 
 		ldo->init_data = wm8994_ldo_default[id];
 		ldo->init_data.consumer_supplies = &ldo->supply;
-		if (!gpiod)
+		if (!config.ena_gpio)
 			ldo->init_data.constraints.valid_ops_mask = 0;
 	} else {
 		ldo->init_data = *pdata->ldo[id].init_data;
diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index fca67bd194e2..90c60524a496 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -20,6 +20,9 @@
 #define WM8994_NUM_AIF   3
 
 struct wm8994_ldo_pdata {
+	/** GPIOs to enable regulator, 0 or less if not available */
+	int enable;
+
 	const struct regulator_init_data *init_data;
 };
 
-- 
2.17.0
