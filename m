Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeENILC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:11:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41504 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeENIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:18 -0400
X-Google-Smtp-Source: AB8JxZqclI8Y2JktCrz00RvaLAxWhYGlL2xnGkjBFr6eFDYw2q/N62NTX6RxGaJDn1dTPGUiBkFNWA==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        patches@opensource.cirrus.com
Subject: [PATCH 13/19 v3] regulator: wm8994: Pass descriptor instead of GPIO number
Date: Mon, 14 May 2018 10:06:34 +0200
Message-Id: <20180514080640.12515-14-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
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
ChangeLog v2->v3:
- Collect Charles' ACK.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
- Collect Lee's ACK.
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 17 +++++++++++++++--
 drivers/mfd/wm8994-core.c                    |  9 ---------
 drivers/regulator/wm8994-regulator.c         | 19 +++++++++++--------
 include/linux/mfd/wm8994/pdata.h             |  3 ---
 4 files changed, 26 insertions(+), 22 deletions(-)

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
index 953d0790ffd5..c409464231f6 100644
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
@@ -302,14 +301,6 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
 	if (of_find_property(np, "wlf,ldoena-always-driven", NULL))
 		pdata->lineout2fb = true;
 
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
index 7a4ce6df4f22..d3a5f48119c2 100644
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
@@ -145,12 +146,14 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
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
+					GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod))
+		return PTR_ERR(gpiod);
+	config.ena_gpiod = gpiod;
 
 	/* Use default constraints if none set up */
 	if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
@@ -159,7 +162,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 
 		ldo->init_data = wm8994_ldo_default[id];
 		ldo->init_data.consumer_supplies = &ldo->supply;
-		if (!config.ena_gpio)
+		if (!gpiod)
 			ldo->init_data.constraints.valid_ops_mask = 0;
 	} else {
 		ldo->init_data = *pdata->ldo[id].init_data;
diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index 90c60524a496..fca67bd194e2 100644
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
2.17.0
