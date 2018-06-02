Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeFBKMn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:12:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39119 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeFBKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:12:22 -0400
X-Google-Smtp-Source: ADUXVKJ8pZtmXZVM8a2lbubw55XTaBx3gFRlRBQP8Hot6X1ZPNQfxcgW9VGuId/7daZE09SJmXSfNw==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 06/10] mfd: da9063: Add custom regmap for DA9063L
Date: Sat,  2 Jun 2018 12:11:51 +0200
Message-Id: <20180602101155.26375-6-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the datasheet for DA9063L (2v1, 23-Mar-2017) lists the RTC register
block, the DA9063L does not have an RTC. Add custom regmap for DA9063L to
prevent access into that register block.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V3: New patch
---
 drivers/mfd/da9063-i2c.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 048ce55ebc5b..f0d92a37df6b 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -208,6 +208,93 @@ static const struct regmap_access_table da9063_bb_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(da9063_bb_volatile_ranges),
 };
 
+static const struct regmap_range da9063l_bb_readable_ranges[] = {
+	{
+		.range_min = DA9063_REG_PAGE_CON,
+		.range_max = DA9063_REG_MON_A10_RES,
+	}, {
+		.range_min = DA9063_REG_SEQ,
+		.range_max = DA9063_REG_ID_32_31,
+	}, {
+		.range_min = DA9063_REG_SEQ_A,
+		.range_max = DA9063_REG_AUTO3_LOW,
+	}, {
+		.range_min = DA9063_REG_T_OFFSET,
+		.range_max = DA9063_BB_REG_GP_ID_19,
+	}, {
+		.range_min = DA9063_REG_CHIP_ID,
+		.range_max = DA9063_REG_CHIP_VARIANT,
+	},
+};
+
+static const struct regmap_range da9063l_bb_writeable_ranges[] = {
+	{
+		.range_min = DA9063_REG_PAGE_CON,
+		.range_max = DA9063_REG_PAGE_CON,
+	}, {
+		.range_min = DA9063_REG_FAULT_LOG,
+		.range_max = DA9063_REG_VSYS_MON,
+	}, {
+		.range_min = DA9063_REG_SEQ,
+		.range_max = DA9063_REG_ID_32_31,
+	}, {
+		.range_min = DA9063_REG_SEQ_A,
+		.range_max = DA9063_REG_AUTO3_LOW,
+	}, {
+		.range_min = DA9063_REG_CONFIG_I,
+		.range_max = DA9063_BB_REG_MON_REG_4,
+	}, {
+		.range_min = DA9063_BB_REG_GP_ID_0,
+		.range_max = DA9063_BB_REG_GP_ID_19,
+	},
+};
+
+static const struct regmap_range da9063l_bb_volatile_ranges[] = {
+	{
+		.range_min = DA9063_REG_PAGE_CON,
+		.range_max = DA9063_REG_EVENT_D,
+	}, {
+		.range_min = DA9063_REG_CONTROL_A,
+		.range_max = DA9063_REG_CONTROL_B,
+	}, {
+		.range_min = DA9063_REG_CONTROL_E,
+		.range_max = DA9063_REG_CONTROL_F,
+	}, {
+		.range_min = DA9063_REG_BCORE2_CONT,
+		.range_max = DA9063_REG_LDO11_CONT,
+	}, {
+		.range_min = DA9063_REG_DVC_1,
+		.range_max = DA9063_REG_ADC_MAN,
+	}, {
+		.range_min = DA9063_REG_ADC_RES_L,
+		.range_max = DA9063_REG_MON_A10_RES,
+	}, {
+		.range_min = DA9063_REG_SEQ,
+		.range_max = DA9063_REG_SEQ,
+	}, {
+		.range_min = DA9063_REG_EN_32K,
+		.range_max = DA9063_REG_EN_32K,
+	}, {
+		.range_min = DA9063_BB_REG_MON_REG_5,
+		.range_max = DA9063_BB_REG_MON_REG_6,
+	},
+};
+
+static const struct regmap_access_table da9063l_bb_readable_table = {
+	.yes_ranges = da9063l_bb_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_readable_ranges),
+};
+
+static const struct regmap_access_table da9063l_bb_writeable_table = {
+	.yes_ranges = da9063l_bb_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_writeable_ranges),
+};
+
+static const struct regmap_access_table da9063l_bb_volatile_table = {
+	.yes_ranges = da9063l_bb_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_volatile_ranges),
+};
+
 static const struct regmap_range_cfg da9063_range_cfg[] = {
 	{
 		.range_min = DA9063_REG_PAGE_CON,
@@ -254,6 +341,10 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
 		da9063_regmap_config.wr_table = &da9063_ad_writeable_table;
 		da9063_regmap_config.volatile_table = &da9063_ad_volatile_table;
+	} else if (da9063->type == PMIC_TYPE_DA9063L) {
+		da9063_regmap_config.rd_table = &da9063l_bb_readable_table;
+		da9063_regmap_config.wr_table = &da9063l_bb_writeable_table;
+		da9063_regmap_config.volatile_table = &da9063l_bb_volatile_table;
 	} else {
 		da9063_regmap_config.rd_table = &da9063_bb_readable_table;
 		da9063_regmap_config.wr_table = &da9063_bb_writeable_table;
-- 
2.16.2
