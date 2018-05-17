Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeEQQlt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:41:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeEQQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:41:46 -0400
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: arizona-ldo1: Look up a descriptor and pass to the core" to the regulator tree
In-Reply-To: <20180514080640.12515-4-linus.walleij@linaro.org>
Message-Id: <20180517164139.CF93144007E@finisterre.ee.mobilebroadband>
Date: Thu, 17 May 2018 17:41:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona-ldo1: Look up a descriptor and pass to the core

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

>From e1739e86f0cb9c48e8745a610e6981a4e24cadad Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 10:06:24 +0200
Subject: [PATCH] regulator: arizona-ldo1: Look up a descriptor and pass to the
 core

Instead of passing a global GPIO number, pass a descriptor looked
up with the standard devm_gpiod_get_optional() call.

We have augmented the GPIO core to look up the regulator special
GPIO "wlf,ldoena" in commit 6a537d48461d
"gpio: of: Support regulator nonstandard GPIO properties".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 28 +++++++++++++++-----
 drivers/regulator/arizona-ldo1.c             | 19 +++++--------
 include/linux/regulator/arizona-ldo1.h       |  3 ---
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index f00988705408..5aa472892465 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio/machine.h>
 
 #include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
@@ -206,9 +207,6 @@ static const struct i2c_board_info wm1277_devs[] = {
 };
 
 static struct arizona_pdata wm5102_reva_pdata = {
-	.ldo1 = {
-		.ldoena = S3C64XX_GPN(7),
-	},
 	.gpio_base = CODEC_GPIO_BASE,
 	.irq_flags = IRQF_TRIGGER_HIGH,
 	.micd_pol_gpio = CODEC_GPIO_BASE + 4,
@@ -237,10 +235,16 @@ static struct spi_board_info wm5102_reva_spi_devs[] = {
 	},
 };
 
-static struct arizona_pdata wm5102_pdata = {
-	.ldo1 = {
-		.ldoena = S3C64XX_GPN(7),
+static struct gpiod_lookup_table wm5102_reva_gpiod_table = {
+	.dev_id = "spi0.1", /* SPI device name */
+	.table = {
+		GPIO_LOOKUP("GPION", 7,
+			    "wlf,ldoena", GPIO_ACTIVE_HIGH),
+		{ },
 	},
+};
+
+static struct arizona_pdata wm5102_pdata = {
 	.gpio_base = CODEC_GPIO_BASE,
 	.irq_flags = IRQF_TRIGGER_HIGH,
 	.micd_pol_gpio = CODEC_GPIO_BASE + 2,
@@ -264,6 +268,15 @@ static struct spi_board_info wm5102_spi_devs[] = {
 	},
 };
 
+static struct gpiod_lookup_table wm5102_gpiod_table = {
+	.dev_id = "spi0.1", /* SPI device name */
+	.table = {
+		GPIO_LOOKUP("GPION", 7,
+			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct spi_board_info wm5110_spi_devs[] = {
 	[0] = {
 		.modalias	= "wm5110",
@@ -366,6 +379,9 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
 					    rev == gf_mods[i].rev))
 			break;
 
+	gpiod_add_lookup_table(&wm5102_reva_gpiod_table);
+	gpiod_add_lookup_table(&wm5102_gpiod_table);
+
 	if (i < ARRAY_SIZE(gf_mods)) {
 		dev_info(&i2c->dev, "%s revision %d\n",
 			 gf_mods[i].name, rev + 1);
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 96fddfff5dc4..f6d6a4ad9e8a 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -17,12 +17,11 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 
 #include <linux/regulator/arizona-ldo1.h>
@@ -198,16 +197,6 @@ static int arizona_ldo1_of_get_pdata(struct arizona_ldo1_pdata *pdata,
 	struct device_node *init_node, *dcvdd_node;
 	struct regulator_init_data *init_data;
 
-	pdata->ldoena = of_get_named_gpio(np, "wlf,ldoena", 0);
-	if (pdata->ldoena < 0) {
-		dev_warn(config->dev,
-			 "LDOENA GPIO property missing/malformed: %d\n",
-			 pdata->ldoena);
-		pdata->ldoena = 0;
-	} else {
-		config->ena_gpio_initialized = true;
-	}
-
 	init_node = of_get_child_by_name(np, "ldo1");
 	dcvdd_node = of_parse_phandle(np, "DCVDD-supply", 0);
 
@@ -264,7 +253,11 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 		}
 	}
 
-	config.ena_gpio = pdata->ldoena;
+	/* We assume that high output = regulator off */
+	config.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "wlf,ldoena",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(config.ena_gpiod))
+		return PTR_ERR(config.ena_gpiod);
 
 	if (pdata->init_data)
 		config.init_data = pdata->init_data;
diff --git a/include/linux/regulator/arizona-ldo1.h b/include/linux/regulator/arizona-ldo1.h
index c685f1277c63..fe74ab9990e6 100644
--- a/include/linux/regulator/arizona-ldo1.h
+++ b/include/linux/regulator/arizona-ldo1.h
@@ -14,9 +14,6 @@
 struct regulator_init_data;
 
 struct arizona_ldo1_pdata {
-	/** GPIO controlling LDOENA, if any */
-	int ldoena;
-
 	/** Regulator configuration for LDO1 */
 	const struct regulator_init_data *init_data;
 };
-- 
2.17.0
