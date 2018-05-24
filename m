Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034544AbeEXTPE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:15:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967783AbeEXTOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:14:18 -0400
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Milo Kim <milo.kim@ti.com>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp8788-ldo: Pass descriptor instead of GPIO number" to the regulator tree
In-Reply-To: <20180212131717.27193-11-linus.walleij@linaro.org>
Message-Id: <E1fLvgk-0005nX-69@debutante>
Date: Thu, 24 May 2018 20:14:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp8788-ldo: Pass descriptor instead of GPIO number

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

>From 2468f0d51548b23507ceb3bba5f4e3acaea117ba Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 10:06:28 +0200
Subject: [PATCH] regulator: lp8788-ldo: Pass descriptor instead of GPIO number

Instead of passing a global GPIO number, pass a descriptor looked
up with the standard devm_gpiod_get_index_optional() call.

This driver has supported passing a LDO enable GPIO for years,
yet this facility has never been put to use in the upstream kernel.
If someone desires to put in place GPIO control for the LDOs,
this can be done by adding a GPIO descriptor table in the MFD
nexus in drivers/mfd/lp8788.c for the LDO device when spawning the
MFD children, or using a board file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp8788-ldo.c | 32 ++++++++++++++++----------------
 include/linux/mfd/lp8788.h     | 16 ----------------
 2 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index cbfd35873575..f2347474a106 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -16,7 +16,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/lp8788.h>
 
 /* register address */
@@ -85,8 +85,6 @@
 #define LP8788_STARTUP_TIME_S		3
 
 #define ENABLE_TIME_USEC		32
-#define ENABLE				GPIOF_OUT_INIT_HIGH
-#define DISABLE				GPIOF_OUT_INIT_LOW
 
 enum lp8788_ldo_id {
 	DLDO1,
@@ -117,7 +115,7 @@ struct lp8788_ldo {
 	struct lp8788 *lp;
 	struct regulator_desc *desc;
 	struct regulator_dev *regulator;
-	struct lp8788_ldo_enable_pin *en_pin;
+	struct gpio_desc *ena_gpiod;
 };
 
 /* DLDO 1, 2, 3, 9 voltage table */
@@ -469,7 +467,6 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 					enum lp8788_ldo_id id)
 {
 	struct lp8788 *lp = ldo->lp;
-	struct lp8788_platform_data *pdata = lp->pdata;
 	enum lp8788_ext_ldo_en_id enable_id;
 	u8 en_mask[] = {
 		[EN_ALDO1]   = LP8788_EN_SEL_ALDO1_M,
@@ -504,11 +501,18 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 		return 0;
 	}
 
-	/* if no platform data for ldo pin, then set default enable mode */
-	if (!pdata || !pdata->ldo_pin || !pdata->ldo_pin[enable_id])
+	/* FIXME: check default mode for GPIO here: high or low? */
+	ldo->ena_gpiod = devm_gpiod_get_index_optional(&pdev->dev,
+						       "enable",
+						       enable_id,
+						       GPIOD_OUT_HIGH);
+	if (IS_ERR(ldo->ena_gpiod))
+		return PTR_ERR(ldo->ena_gpiod);
+
+	/* if no GPIO for ldo pin, then set default enable mode */
+	if (!ldo->ena_gpiod)
 		goto set_default_ldo_enable_mode;
 
-	ldo->en_pin = pdata->ldo_pin[enable_id];
 	return 0;
 
 set_default_ldo_enable_mode:
@@ -533,10 +537,8 @@ static int lp8788_dldo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ldo->en_pin) {
-		cfg.ena_gpio = ldo->en_pin->gpio;
-		cfg.ena_gpio_flags = ldo->en_pin->init_state;
-	}
+	if (ldo->ena_gpiod)
+		cfg.ena_gpiod = ldo->ena_gpiod;
 
 	cfg.dev = pdev->dev.parent;
 	cfg.init_data = lp->pdata ? lp->pdata->dldo_data[id] : NULL;
@@ -582,10 +584,8 @@ static int lp8788_aldo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ldo->en_pin) {
-		cfg.ena_gpio = ldo->en_pin->gpio;
-		cfg.ena_gpio_flags = ldo->en_pin->init_state;
-	}
+	if (ldo->ena_gpiod)
+		cfg.ena_gpiod = ldo->ena_gpiod;
 
 	cfg.dev = pdev->dev.parent;
 	cfg.init_data = lp->pdata ? lp->pdata->aldo_data[id] : NULL;
diff --git a/include/linux/mfd/lp8788.h b/include/linux/mfd/lp8788.h
index 786bf6679a28..2010e0de3e34 100644
--- a/include/linux/mfd/lp8788.h
+++ b/include/linux/mfd/lp8788.h
@@ -181,20 +181,6 @@ struct lp8788_buck2_dvs {
 	enum lp8788_dvs_sel vsel;
 };
 
-/*
- * struct lp8788_ldo_enable_pin
- *
- *   Basically, all LDOs are enabled through the I2C commands.
- *   But ALDO 1 ~ 5, 7, DLDO 7, 9, 11 can be enabled by external gpio pins.
- *
- * @gpio         : gpio number which is used for enabling ldos
- * @init_state   : initial gpio state (ex. GPIOF_OUT_INIT_LOW)
- */
-struct lp8788_ldo_enable_pin {
-	int gpio;
-	int init_state;
-};
-
 /*
  * struct lp8788_chg_param
  * @addr         : charging control register address (range : 0x11 ~ 0x1C)
@@ -288,7 +274,6 @@ struct lp8788_vib_platform_data {
  * @aldo_data    : regulator initial data for analog ldo
  * @buck1_dvs    : gpio configurations for buck1 dvs
  * @buck2_dvs    : gpio configurations for buck2 dvs
- * @ldo_pin      : gpio configurations for enabling LDOs
  * @chg_pdata    : platform data for charger driver
  * @alarm_sel    : rtc alarm selection (1 or 2)
  * @bl_pdata     : configurable data for backlight driver
@@ -306,7 +291,6 @@ struct lp8788_platform_data {
 	struct regulator_init_data *aldo_data[LP8788_NUM_ALDOS];
 	struct lp8788_buck1_dvs *buck1_dvs;
 	struct lp8788_buck2_dvs *buck2_dvs;
-	struct lp8788_ldo_enable_pin *ldo_pin[EN_LDOS_MAX];
 
 	/* charger */
 	struct lp8788_charger_platform_data *chg_pdata;
-- 
2.17.0
