Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeENIMK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:12:10 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37494 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeENIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:04 -0400
X-Google-Smtp-Source: AB8JxZrlI4hjFaZ4YaioT6/Gfm3gBODm6OH8mB/9F1FbLnwl81UNjECFQDoBavJhdek2Q+zA4P/xow==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Milo Kim <milo.kim@ti.com>
Subject: [PATCH 07/19 v3] regulator: lp8788-ldo: Pass descriptor instead of GPIO number
Date: Mon, 14 May 2018 10:06:28 +0200
Message-Id: <20180514080640.12515-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a global GPIO number, pass a descriptor looked
up with the standard devm_gpiod_get_index_optional() call.

This driver has supported passing a LDO enable GPIO for years,
yet this facility has never been put to use in the upstream kernel.
If someone desires to put in place GPIO control for the LDOs,
this can be done by adding a GPIO descriptor table in the MFD
nexus in drivers/mfd/lp8788.c for the LDO device when spawning the
MFD children, or using a board file.

Cc: Milo Kim <milo.kim@ti.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
- Collect Lee's ACK.
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
