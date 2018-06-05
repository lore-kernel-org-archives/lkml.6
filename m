Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932137AbeFEXLa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:11:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36201 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbeFEXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:10:46 -0400
X-Google-Smtp-Source: ADUXVKLJVyDVEPqSx/3slvbDzTYadJlzstuTKRrgTIzzvkJRwPoGBP2JL08V6i/QirjUSCqmwTL+VQ==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 11/12] regulator: da9063: Handle less LDOs on DA9063L
Date: Wed,  6 Jun 2018 01:10:12 +0200
Message-Id: <20180605231013.1803-11-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the LDOs present only on DA9063 at the end of the list, so that
the DA9063L can simply indicate less LDOs and still share the list of
regulators with DA9063.

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
V2: No change
V3: No change
V4: Change subject s/mfd/regulator/
---
 drivers/regulator/da9063-regulator.c | 76 +++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index eeb0d431dda1..0c09e73e0b23 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -529,6 +529,32 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_A,
 				 DA9063_BMEM_ILIM_MASK),
 	},
+	{
+		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
+		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO3_SEL),
+		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO3_LIM),
+	},
+	{
+		DA9063_LDO(DA9063, LDO7, 900, 50, 3600),
+		.suspend = BFIELD(DA9063_REG_LDO7_CONT, DA9063_VLDO7_SEL),
+		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO7_LIM),
+	},
+	{
+		DA9063_LDO(DA9063, LDO8, 900, 50, 3600),
+		.suspend = BFIELD(DA9063_REG_LDO8_CONT, DA9063_VLDO8_SEL),
+		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO8_LIM),
+	},
+	{
+		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
+		.suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
+	},
+	{
+		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
+		.suspend = BFIELD(DA9063_REG_LDO11_CONT, DA9063_VLDO11_SEL),
+		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO11_LIM),
+	},
+
+	/* The following LDOs are present only on DA9063, not on DA9063L */
 	{
 		DA9063_LDO(DA9063, LDO1, 600, 20, 1860),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO1_SEL),
@@ -537,11 +563,6 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 		DA9063_LDO(DA9063, LDO2, 600, 20, 1860),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO2_SEL),
 	},
-	{
-		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO3_SEL),
-		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO3_LIM),
-	},
 	{
 		DA9063_LDO(DA9063, LDO4, 900, 20, 3440),
 		.suspend = BFIELD(DA9063_REG_DVC_2, DA9063_VLDO4_SEL),
@@ -555,29 +576,11 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 		DA9063_LDO(DA9063, LDO6, 900, 50, 3600),
 		.suspend = BFIELD(DA9063_REG_LDO6_CONT, DA9063_VLDO6_SEL),
 	},
-	{
-		DA9063_LDO(DA9063, LDO7, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO7_CONT, DA9063_VLDO7_SEL),
-		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO7_LIM),
-	},
-	{
-		DA9063_LDO(DA9063, LDO8, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO8_CONT, DA9063_VLDO8_SEL),
-		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO8_LIM),
-	},
-	{
-		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
-	},
+
 	{
 		DA9063_LDO(DA9063, LDO10, 900, 50, 3600),
 		.suspend = BFIELD(DA9063_REG_LDO10_CONT, DA9063_VLDO10_SEL),
 	},
-	{
-		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO11_CONT, DA9063_VLDO11_SEL),
-		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO11_LIM),
-	},
 };
 
 /* Link chip model with regulators info table */
@@ -587,6 +590,11 @@ static struct da9063_dev_model regulators_models[] = {
 		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
 		.type = PMIC_TYPE_DA9063,
 	},
+	{
+		.regulator_info = da9063_regulator_info,
+		.n_regulators = ARRAY_SIZE(da9063_regulator_info) - 6,
+		.type = PMIC_TYPE_DA9063L,
+	},
 	{ }
 };
 
@@ -641,28 +649,34 @@ static struct of_regulator_match da9063_matches[] = {
 	[DA9063_ID_BPERI]            = { .name = "bperi",           },
 	[DA9063_ID_BCORES_MERGED]    = { .name = "bcores-merged"    },
 	[DA9063_ID_BMEM_BIO_MERGED]  = { .name = "bmem-bio-merged", },
+	[DA9063_ID_LDO3]             = { .name = "ldo3",            },
+	[DA9063_ID_LDO7]             = { .name = "ldo7",            },
+	[DA9063_ID_LDO8]             = { .name = "ldo8",            },
+	[DA9063_ID_LDO9]             = { .name = "ldo9",            },
+	[DA9063_ID_LDO11]            = { .name = "ldo11",           },
+	/* The following LDOs are present only on DA9063, not on DA9063L */
 	[DA9063_ID_LDO1]             = { .name = "ldo1",            },
 	[DA9063_ID_LDO2]             = { .name = "ldo2",            },
-	[DA9063_ID_LDO3]             = { .name = "ldo3",            },
 	[DA9063_ID_LDO4]             = { .name = "ldo4",            },
 	[DA9063_ID_LDO5]             = { .name = "ldo5",            },
 	[DA9063_ID_LDO6]             = { .name = "ldo6",            },
-	[DA9063_ID_LDO7]             = { .name = "ldo7",            },
-	[DA9063_ID_LDO8]             = { .name = "ldo8",            },
-	[DA9063_ID_LDO9]             = { .name = "ldo9",            },
 	[DA9063_ID_LDO10]            = { .name = "ldo10",           },
-	[DA9063_ID_LDO11]            = { .name = "ldo11",           },
 };
 
 static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 		struct platform_device *pdev,
 		struct of_regulator_match **da9063_reg_matches)
 {
+	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
 	struct da9063_regulators_pdata *pdata;
 	struct da9063_regulator_data *rdata;
 	struct device_node *node;
+	int da9063_matches_len = ARRAY_SIZE(da9063_matches);
 	int i, n, num;
 
+	if (da9063->type == PMIC_TYPE_DA9063L)
+		da9063_matches_len -= 6;
+
 	node = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
 	if (!node) {
 		dev_err(&pdev->dev, "Regulators device node not found\n");
@@ -670,7 +684,7 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 	}
 
 	num = of_regulator_match(&pdev->dev, node, da9063_matches,
-				 ARRAY_SIZE(da9063_matches));
+				 da9063_matches_len);
 	of_node_put(node);
 	if (num < 0) {
 		dev_err(&pdev->dev, "Failed to match regulators\n");
@@ -689,7 +703,7 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 	pdata->n_regulators = num;
 
 	n = 0;
-	for (i = 0; i < ARRAY_SIZE(da9063_matches); i++) {
+	for (i = 0; i < da9063_matches_len; i++) {
 		if (!da9063_matches[i].init_data)
 			continue;
 
-- 
2.16.2
