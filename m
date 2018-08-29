Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407FFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C811E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C811E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeH2QgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:36:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35685 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2QgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:36:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id q13-v6so4171597lfc.2;
        Wed, 29 Aug 2018 05:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1pTvLdsoS+24cphmfdBCRI+43bDgWoWhfuHaiE+2L04=;
        b=UyDbznKenpxE4hYPQGNvBk7Nj28DHxPS6ynPIxqIFRmGcv8Pq8P3G+1NcOp1ztMhTO
         jZ2j1TtvwBV9DhoRxrsP0MUB5xhhC5KEVQzgq+SFP36+h6gMwmauu8EciNEpd21AyqEo
         wG0REk8T7ZaVhag7W2DadVxUyIcTWsgF+B2JQy8UIjH0/fTl4azug6my6QnEVNaS6tZk
         dWYLiBWkmRVsE8sdgxbwutrfajTJdks4HomzDZSDkhbi0tBeAzfvskiOt/UJjsq4HePn
         RJM0BYrxziuAlnM8Bo386/PDHQKDyhNBDm2k/5WRNYsYtXP6hA3IIbNft/sTZaCQvP1L
         kcrw==
X-Gm-Message-State: APzg51CZnv4TdHj5kq/XGD79vmPTZh3w+Tg/dnyKCPApfw0g41+9BnzI
        cxCDkvyLlG2gWK7rMohb44I=
X-Google-Smtp-Source: ANB0VdbIN243TPoILDx7YNskYHlRvbX14a6MkPXP7u3i9a7o14obDtFI4eWnGe6tyboIhuJXTINgkA==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr4493708lfl.136.1535546374025;
        Wed, 29 Aug 2018 05:39:34 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v63-v6sm704612lje.20.2018.08.29.05.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:39:33 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:39:21 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 7/8] regulator: bd718XX use pickable ranges
Message-ID: <6fa8728de34a18623736d3b01537930eda2dd54e.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few regulators in BD71837 and BD71847 can output voltages from
different voltage ranges. Register interface is arranged so that
used range is selected by toggling bits which are not next to actual
voltage selection bits. Then the voltage inside selected range is
determined by voltage selection bits (as usual). Support BD71837
and BD71847 selectible range voltages using new pickable ranges
helpers.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd71837-regulator.c | 155 +++++++++++++++++++++++++++-------
 include/linux/mfd/rohm-bd718x7.h      |  38 +++++----
 2 files changed, 147 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 4780c92db49a..04bcbd636c2f 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -78,6 +78,34 @@ static int bd718xx_set_voltage_sel_restricted(struct regulator_dev *rdev,
 	return regulator_set_voltage_sel_regmap(rdev, sel);
 }
 
+static int bd718xx_set_voltage_sel_pickable_restricted(
+		struct regulator_dev *rdev, unsigned int sel)
+{
+	if (regulator_is_enabled_regmap(rdev))
+		return -EBUSY;
+
+	return regulator_set_voltage_sel_pickable_regmap(rdev, sel);
+}
+
+static struct regulator_ops bd718xx_pickable_range_ldo_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.set_voltage_sel = bd718xx_set_voltage_sel_pickable_restricted,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+};
+
+static struct regulator_ops bd718xx_pickable_range_buck_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.set_voltage_sel = bd718xx_set_voltage_sel_pickable_restricted,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
 static struct regulator_ops bd718xx_ldo_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -139,24 +167,61 @@ static const struct regulator_linear_range bd718xx_dvs_buck_volts[] = {
 
 /*
  * BD71837 BUCK5
+ * 0.7V to 1.35V  (range 0)
+ * and
+ * 0.675 to 1.325 (range 1)
+ */
+static const struct regulator_linear_range bd71837_buck5_volts[] = {
+	/* Ranges when VOLT_SEL bit is 0 */
+	REGULATOR_LINEAR_RANGE(700000, 0x00, 0x03, 100000),
+	REGULATOR_LINEAR_RANGE(1050000, 0x04, 0x05, 50000),
+	REGULATOR_LINEAR_RANGE(1200000, 0x06, 0x07, 150000),
+	/* Ranges when VOLT_SEL bit is 1  */
+	REGULATOR_LINEAR_RANGE(675000, 0x0, 0x3, 100000),
+	REGULATOR_LINEAR_RANGE(1025000, 0x4, 0x5, 50000),
+	REGULATOR_LINEAR_RANGE(1175000, 0x6, 0x7, 150000),
+};
+
+/*
+ * Range selector for first 3 linear ranges is 0x0
+ * and 0x1 for last 3 ranges.
+ */
+static const unsigned int bd71837_buck5_volt_range_sel[] = {
+	0x0, 0x0, 0x0, 0x80, 0x80, 0x80
+};
+
+/*
  * BD71847 BUCK3
- * 0.7V to 1.35V ()
  */
-static const struct regulator_linear_range bd718xx_1st_nodvs_buck_volts[] = {
+static const struct regulator_linear_range bd71847_buck3_volts[] = {
+	/* Ranges when VOLT_SEL bits are 00 */
 	REGULATOR_LINEAR_RANGE(700000, 0x00, 0x03, 100000),
 	REGULATOR_LINEAR_RANGE(1050000, 0x04, 0x05, 50000),
 	REGULATOR_LINEAR_RANGE(1200000, 0x06, 0x07, 150000),
+	/* Ranges when VOLT_SEL bits are 01 */
+	REGULATOR_LINEAR_RANGE(550000, 0x0, 0x7, 50000),
+	/* Ranges when VOLT_SEL bits are 11 */
+	REGULATOR_LINEAR_RANGE(675000, 0x0, 0x3, 100000),
+	REGULATOR_LINEAR_RANGE(1025000, 0x4, 0x5, 50000),
+	REGULATOR_LINEAR_RANGE(1175000, 0x6, 0x7, 150000),
+};
+
+static const unsigned int bd71847_buck3_volt_range_sel[] = {
+	0x0, 0x0, 0x0, 0x40, 0x80, 0x80, 0x80
 };
 
-static const struct regulator_linear_range bd71847_buck4_voltage_ranges[] = {
+static const struct regulator_linear_range bd71847_buck4_volts[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0x00, 0x03, 100000),
+	REGULATOR_LINEAR_RANGE(2600000, 0x00, 0x03, 100000),
 };
 
+static const unsigned int bd71847_buck4_volt_range_sel[] = { 0x0, 0x40 };
+
 /*
  * BUCK6
  * 3.0V to 3.3V (step 100mV)
  */
-static const struct regulator_linear_range bd71837_buck6_voltage_ranges[] = {
+static const struct regulator_linear_range bd71837_buck6_volts[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0x00, 0x03, 100000),
 };
 
@@ -190,8 +255,11 @@ static const struct regulator_linear_range bd718xx_4th_nodvs_buck_volts[] = {
  */
 static const struct regulator_linear_range bd718xx_ldo1_volts[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0x00, 0x03, 100000),
+	REGULATOR_LINEAR_RANGE(1600000, 0x00, 0x03, 100000),
 };
 
+static const unsigned int bd718xx_ldo1_volt_range_sel[] = { 0x0, 0x20 };
+
 /*
  * LDO2
  * 0.8 or 0.9V
@@ -220,10 +288,21 @@ static const struct regulator_linear_range bd718xx_ldo4_volts[] = {
  * LDO5 for BD71837
  * 1.8 to 3.3V (100mV step)
  */
-static const struct regulator_linear_range bd718xx_ldo5_volts[] = {
+static const struct regulator_linear_range bd71837_ldo5_volts[] = {
+	REGULATOR_LINEAR_RANGE(1800000, 0x00, 0x0F, 100000),
+};
+
+/*
+ * LDO5 for BD71837
+ * 1.8 to 3.3V (100mV step)
+ */
+static const struct regulator_linear_range bd71847_ldo5_volts[] = {
 	REGULATOR_LINEAR_RANGE(1800000, 0x00, 0x0F, 100000),
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x0F, 100000),
 };
 
+static const unsigned int bd71847_ldo5_volt_range_sel[] = { 0x0, 0x20 };
+
 /*
  * LDO6
  * 0.9 to 1.8V (100mV step)
@@ -332,14 +411,17 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("BUCK3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK3,
-			.ops = &bd718xx_buck_regulator_ops,
+			.ops = &bd718xx_pickable_range_buck_ops,
 			.type = REGULATOR_VOLTAGE,
-			.n_voltages = BD718XX_1ST_NODVS_BUCK_VOLTAGE_NUM,
-			.linear_ranges = bd718xx_1st_nodvs_buck_volts,
+			.n_voltages = BD71847_BUCK3_VOLTAGE_NUM,
+			.linear_ranges = bd71847_buck3_volts,
 			.n_linear_ranges =
-				ARRAY_SIZE(bd718xx_1st_nodvs_buck_volts),
+				ARRAY_SIZE(bd71847_buck3_volts),
 			.vsel_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
 			.vsel_mask = BD718XX_1ST_NODVS_BUCK_MASK,
+			.vsel_range_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
+			.vsel_range_mask = BD71847_BUCK3_RANGE_MASK,
+			.linear_range_selectors = bd71847_buck3_volt_range_sel,
 			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
@@ -356,15 +438,18 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("BUCK4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK4,
-			.ops = &bd718xx_buck_regulator_ops,
+			.ops = &bd718xx_pickable_range_buck_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71847_BUCK4_VOLTAGE_NUM,
-			.linear_ranges = bd71847_buck4_voltage_ranges,
+			.linear_ranges = bd71847_buck4_volts,
 			.n_linear_ranges =
-				ARRAY_SIZE(bd71847_buck4_voltage_ranges),
+				ARRAY_SIZE(bd71847_buck4_volts),
 			.enable_reg = BD718XX_REG_2ND_NODVS_BUCK_CTRL,
 			.vsel_reg = BD718XX_REG_2ND_NODVS_BUCK_VOLT,
 			.vsel_mask = BD71847_BUCK4_MASK,
+			.vsel_range_reg = BD718XX_REG_2ND_NODVS_BUCK_VOLT,
+			.vsel_range_mask = BD71847_BUCK4_RANGE_MASK,
+			.linear_range_selectors = bd71847_buck4_volt_range_sel,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
 		},
@@ -378,7 +463,7 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 		.desc = {
 			.name = "buck5",
 			.of_match = of_match_ptr("BUCK5"),
-				.regulators_node = of_match_ptr("regulators"),
+			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK5,
 			.ops = &bd718xx_buck_regulator_nolinear_ops,
 			.type = REGULATOR_VOLTAGE,
@@ -426,13 +511,16 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("LDO1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO1,
-			.ops = &bd718xx_ldo_regulator_ops,
+			.ops = &bd718xx_pickable_range_ldo_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO1_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo1_volts,
 			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo1_volts),
 			.vsel_reg = BD718XX_REG_LDO1_VOLT,
 			.vsel_mask = BD718XX_LDO1_MASK,
+			.vsel_range_reg = BD718XX_REG_LDO1_VOLT,
+			.vsel_range_mask = BD718XX_LDO1_RANGE_MASK,
+			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO1_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
 			.owner = THIS_MODULE,
@@ -517,13 +605,16 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO5,
-			.ops = &bd718xx_ldo_regulator_ops,
+			.ops = &bd718xx_pickable_range_ldo_ops,
 			.type = REGULATOR_VOLTAGE,
-			.n_voltages = BD718XX_LDO5_VOLTAGE_NUM,
-			.linear_ranges = bd718xx_ldo5_volts,
-			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo5_volts),
+			.n_voltages = BD71847_LDO5_VOLTAGE_NUM,
+			.linear_ranges = bd71847_ldo5_volts,
+			.n_linear_ranges = ARRAY_SIZE(bd71847_ldo5_volts),
 			.vsel_reg = BD718XX_REG_LDO5_VOLT,
 			.vsel_mask = BD71847_LDO5_MASK,
+			.vsel_range_reg = BD718XX_REG_LDO5_VOLT,
+			.vsel_range_mask = BD71847_LDO5_RANGE_MASK,
+			.linear_range_selectors = bd71847_ldo5_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO5_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
 			.owner = THIS_MODULE,
@@ -660,14 +751,17 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK5,
-			.ops = &bd718xx_buck_regulator_ops,
+			.ops = &bd718xx_pickable_range_buck_ops,
 			.type = REGULATOR_VOLTAGE,
-			.n_voltages = BD718XX_1ST_NODVS_BUCK_VOLTAGE_NUM,
-			.linear_ranges = bd718xx_1st_nodvs_buck_volts,
+			.n_voltages = BD71837_BUCK5_VOLTAGE_NUM,
+			.linear_ranges = bd71837_buck5_volts,
 			.n_linear_ranges =
-				ARRAY_SIZE(bd718xx_1st_nodvs_buck_volts),
+				ARRAY_SIZE(bd71837_buck5_volts),
 			.vsel_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
-			.vsel_mask = BD718XX_1ST_NODVS_BUCK_MASK,
+			.vsel_mask = BD71837_BUCK5_MASK,
+			.vsel_range_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
+			.vsel_range_mask = BD71837_BUCK5_RANGE_MASK,
+			.linear_range_selectors = bd71837_buck5_volt_range_sel,
 			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
@@ -687,9 +781,9 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.ops = &bd718xx_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_BUCK6_VOLTAGE_NUM,
-			.linear_ranges = bd71837_buck6_voltage_ranges,
+			.linear_ranges = bd71837_buck6_volts,
 			.n_linear_ranges =
-				ARRAY_SIZE(bd71837_buck6_voltage_ranges),
+				ARRAY_SIZE(bd71837_buck6_volts),
 			.vsel_reg = BD718XX_REG_2ND_NODVS_BUCK_VOLT,
 			.vsel_mask = BD71837_BUCK6_MASK,
 			.enable_reg = BD718XX_REG_2ND_NODVS_BUCK_CTRL,
@@ -754,13 +848,16 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO1,
-			.ops = &bd718xx_ldo_regulator_ops,
+			.ops = &bd718xx_pickable_range_ldo_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO1_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo1_volts,
 			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo1_volts),
 			.vsel_reg = BD718XX_REG_LDO1_VOLT,
 			.vsel_mask = BD718XX_LDO1_MASK,
+			.vsel_range_reg = BD718XX_REG_LDO1_VOLT,
+			.vsel_range_mask = BD718XX_LDO1_RANGE_MASK,
+			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO1_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
 			.owner = THIS_MODULE,
@@ -847,9 +944,9 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.id = BD718XX_LDO5,
 			.ops = &bd718xx_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
-			.n_voltages = BD718XX_LDO5_VOLTAGE_NUM,
-			.linear_ranges = bd718xx_ldo5_volts,
-			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo5_volts),
+			.n_voltages = BD71837_LDO5_VOLTAGE_NUM,
+			.linear_ranges = bd71837_ldo5_volts,
+			.n_linear_ranges = ARRAY_SIZE(bd71837_ldo5_volts),
 			/* LDO5 is supplied by buck6 */
 			.supply_name = "buck6",
 			.vsel_reg = BD718XX_REG_LDO5_VOLT,
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index d1730b97ba52..4cc617047d5f 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -7,13 +7,13 @@
 #include <linux/regmap.h>
 
 enum {
-	BD718XX_TYPE_BD71837,
+	BD718XX_TYPE_BD71837 = 0,
 	BD718XX_TYPE_BD71847,
 	BD718XX_TYPE_AMNT // Keep this as last item
 };
 
 enum {
-	BD718XX_BUCK1	=	0,
+	BD718XX_BUCK1 = 0,
 	BD718XX_BUCK2,
 	BD718XX_BUCK3,
 	BD718XX_BUCK4,
@@ -31,31 +31,27 @@ enum {
 	BD718XX_REGULATOR_MAX,
 };
 
-/* Common voltage configurations
- *
- * Note, we support only one range of voltages for each buck/LDO until we
- * get pickable ranges support. (See range selection bits for BUCK5 and
- * LDO1. On BD71847 also the second no DVS buck and LDO5)
- */
-
+/* Common voltage configurations */
 #define BD718XX_DVS_BUCK_VOLTAGE_NUM		0x3D
-#define BD718XX_1ST_NODVS_BUCK_VOLTAGE_NUM	0x08
-#define BD71837_4TH_NODVS_BUCK_VOLTAGE_NUM	0x3D
+#define BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM	0x3D
 
-#define BD718XX_LDO1_VOLTAGE_NUM	0x04
+#define BD718XX_LDO1_VOLTAGE_NUM	0x08
 #define BD718XX_LDO2_VOLTAGE_NUM	0x02
 #define BD718XX_LDO3_VOLTAGE_NUM	0x10
 #define BD718XX_LDO4_VOLTAGE_NUM	0x0A
-#define BD718XX_LDO5_VOLTAGE_NUM	0x10
 #define BD718XX_LDO6_VOLTAGE_NUM	0x0A
 
 /* BD71837 specific voltage configurations */
+#define BD71837_BUCK5_VOLTAGE_NUM	0x10
 #define BD71837_BUCK6_VOLTAGE_NUM	0x04
 #define BD71837_BUCK7_VOLTAGE_NUM	0x08
+#define BD71837_LDO5_VOLTAGE_NUM	0x10
 #define BD71837_LDO7_VOLTAGE_NUM	0x10
 
 /* BD71847 specific voltage configurations */
-#define BD71847_BUCK4_VOLTAGE_NUM	0x04
+#define BD71847_BUCK3_VOLTAGE_NUM	0x18
+#define BD71847_BUCK4_VOLTAGE_NUM	0x08
+#define BD71847_LDO5_VOLTAGE_NUM	0x20
 
 /* Registers specific to BD71837 */
 enum {
@@ -139,12 +135,20 @@ enum {
 #define DVS_BUCK_IDLE_MASK	0x3F
 
 #define BD718XX_1ST_NODVS_BUCK_MASK	0x07
-#define BD71847_BUCK4_MASK		0x03
-#define BD71837_BUCK6_MASK		0x03
 #define BD718XX_3RD_NODVS_BUCK_MASK	0x07
 #define BD718XX_4TH_NODVS_BUCK_MASK	0x3F
 
+#define BD71847_BUCK3_MASK		0x07
+#define BD71847_BUCK3_RANGE_MASK	0xC0
+#define BD71847_BUCK4_MASK		0x03
+#define BD71847_BUCK4_RANGE_MASK	0x40
+
+#define BD71837_BUCK5_MASK		0x07
+#define BD71837_BUCK5_RANGE_MASK	0x80
+#define BD71837_BUCK6_MASK		0x03
+
 #define BD718XX_LDO1_MASK		0x03
+#define BD718XX_LDO1_RANGE_MASK		0x20
 #define BD718XX_LDO2_MASK		0x20
 #define BD718XX_LDO3_MASK		0x0F
 #define BD718XX_LDO4_MASK		0x0F
@@ -152,10 +156,10 @@ enum {
 
 #define BD71837_LDO5_MASK		0x0F
 #define BD71847_LDO5_MASK		0x0F
+#define BD71847_LDO5_RANGE_MASK		0x20
 
 #define BD71837_LDO7_MASK		0x0F
 
-
 /* BD718XX Voltage monitoring masks */
 #define BD718XX_BUCK1_VRMON80           0x1
 #define BD718XX_BUCK1_VRMON130          0x2
-- 
2.14.3

