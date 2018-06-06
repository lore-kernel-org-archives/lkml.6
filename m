Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3CKDaSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E5E9607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeFFKAg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:00:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44981 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbeFFKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:33 -0400
X-Google-Smtp-Source: ADUXVKK53VzhL/rNFsYFrxAT7I5+UTaiRG4iFuVUyxZEMvqVcp4+pR+Nb2mzXZ5snnymg3nD3i7+/A==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 10/14] mfd: da9063: Add custom regmap for DA9063L
Date: Wed,  6 Jun 2018 11:59:59 +0200
Message-Id: <20180606100003.17067-10-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9063L does not have an RTC. Add custom regmap for DA9063L to
prevent access into that register block.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V3: New patch
V4: Drop mention of buggy datasheet in the commit message
V5: Use regmap_reg_range macro
---
 drivers/mfd/da9063-i2c.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 6fe9c3464b41..a449a9263dd7 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -118,6 +118,50 @@ static const struct regmap_access_table da9063_bb_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(da9063_bb_volatile_ranges),
 };
 
+static const struct regmap_range da9063l_bb_readable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_MON_A10_RES),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
+	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+};
+
+static const struct regmap_range da9063l_bb_writeable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_FAULT_LOG, DA9063_REG_VSYS_MON),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_CONFIG_I, DA9063_BB_REG_MON_REG_4),
+	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
+};
+
+static const struct regmap_range da9063l_bb_volatile_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
+	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
+	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
+	regmap_reg_range(DA9063_REG_BCORE2_CONT, DA9063_REG_LDO11_CONT),
+	regmap_reg_range(DA9063_REG_DVC_1, DA9063_REG_ADC_MAN),
+	regmap_reg_range(DA9063_REG_ADC_RES_L, DA9063_REG_MON_A10_RES),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
+	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
+	regmap_reg_range(DA9063_BB_REG_MON_REG_5, DA9063_BB_REG_MON_REG_6),
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
@@ -164,6 +208,10 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
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
