Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeFEXMc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:12:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40839 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbeFEXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:10:40 -0400
X-Google-Smtp-Source: ADUXVKJWNLFIAjpEntEMHC3QEZgzMUfjZITyeyVSh5q/y0nxv2fbIp7WyrK1y1eSl9ued1jSsfaMpw==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 06/12] mfd: da9063: Replace model with type
Date: Wed,  6 Jun 2018 01:10:07 +0200
Message-Id: <20180605231013.1803-6-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The model number stored in the struct da9063 is the same for all
variants of the da9063 since it is the chip ID, which is always
the same. Replace that with a separate identifier instead, which
allows us to discern the DA9063 variants by setting the type
based on either DT match or otherwise.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V2: Drop useless cast of id->driver_data
V3: Fix kernel 0day error , s/dev_model/type/
V4: No change
---
 drivers/mfd/da9063-core.c            | 1 -
 drivers/mfd/da9063-i2c.c             | 5 +++--
 drivers/regulator/da9063-regulator.c | 6 +++---
 include/linux/mfd/da9063/core.h      | 6 +++++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index a21a771f6177..9aff815877c0 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -215,7 +215,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 		return -ENODEV;
 	}
 
-	da9063->model = model;
 	da9063->variant_code = variant_code;
 
 	ret = da9063_irq_init(da9063);
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 7f84030c8d53..048ce55ebc5b 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -236,7 +236,7 @@ static const struct of_device_id da9063_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9063_dt_ids);
 static int da9063_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+			    const struct i2c_device_id *id)
 {
 	struct da9063 *da9063;
 	int ret;
@@ -248,6 +248,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, da9063);
 	da9063->dev = &i2c->dev;
 	da9063->chip_irq = i2c->irq;
+	da9063->type = id->driver_data;
 
 	if (da9063->variant_code == PMIC_DA9063_AD) {
 		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
@@ -280,7 +281,7 @@ static int da9063_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id da9063_i2c_id[] = {
-	{ "da9063", PMIC_CHIP_ID_DA9063 },
+	{ "da9063", PMIC_TYPE_DA9063 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 87c884ae0064..eeb0d431dda1 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -98,7 +98,7 @@ struct da9063_regulator_info {
 struct da9063_dev_model {
 	const struct da9063_regulator_info	*regulator_info;
 	unsigned				n_regulators;
-	unsigned				dev_model;
+	enum da9063_type			type;
 };
 
 /* Single regulator settings */
@@ -585,7 +585,7 @@ static struct da9063_dev_model regulators_models[] = {
 	{
 		.regulator_info = da9063_regulator_info,
 		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
-		.dev_model = PMIC_CHIP_ID_DA9063,
+		.type = PMIC_TYPE_DA9063,
 	},
 	{ }
 };
@@ -741,7 +741,7 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 
 	/* Find regulators set for particular device model */
 	for (model = regulators_models; model->regulator_info; model++) {
-		if (model->dev_model == da9063->model)
+		if (model->type == da9063->type)
 			break;
 	}
 	if (!model->regulator_info) {
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 5fed1c874926..6caf23483e8e 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -31,6 +31,10 @@
 
 #define PMIC_CHIP_ID_DA9063		0x61
 
+enum da9063_type {
+	PMIC_TYPE_DA9063 = 0,
+};
+
 enum da9063_variant_codes {
 	PMIC_DA9063_AD = 0x3,
 	PMIC_DA9063_BB = 0x5,
@@ -75,7 +79,7 @@ enum da9063_irqs {
 struct da9063 {
 	/* Device */
 	struct device	*dev;
-	unsigned short	model;
+	enum da9063_type type;
 	unsigned char	variant_code;
 	unsigned int	flags;
 
-- 
2.16.2
