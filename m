Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B3C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307A1218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbfAaMq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:46:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39393 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733301AbfAaMqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:46:22 -0500
Received: by mail-qt1-f194.google.com with SMTP id u47so3252738qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=L8eYQ5hhgefqEk+G7G/K6cViDNiGVYa5I3lqc3l2fKo=;
        b=G9ggvzgvVRmknIZvbdIjfG7k5YRKpKEaQVAWOuqMrIQPF9LyhpebtMQ0dPOM6o++4h
         iNPtVjKA3nSKLPqgy2BqH9tt4onqgt+EezZU+3ZLG32fvvmt0xGv52K3FuC4tAMHwfBy
         PkqZKJf8Kwwbmw79vMoMEavaY9NXTOQ/YUCI+ykqyGrwG5ZDnUR8zkDgCsRDc1FpXcNo
         Eyvc7jLWZGM7KMn7aRsH5HOOpMKgojztBgwWBW9ZkLOqrH5+GNh6VYpUNVjqbE69njuJ
         0LSdI8+6pjuif7es+wewNnNp/ZhENRYT/qEKU5uCEUF9ZOGgjmWMbAN6W9FDsr/YcHFf
         7AVA==
X-Gm-Message-State: AJcUukcEK02zoFRtqIT/rwwr+w/e0/GpM33PCcpGMhQxBJr/E38gi/fd
        cOKe5ySypv+I4sHL3ZkEDkNZPucZ
X-Google-Smtp-Source: ALg8bN64WFSjsq/qY2vOIzrG4Stxph0C1vhkZYuvk4OnOyBhpDKh35j0iww5bxmf7GXtvWhXo39vGw==
X-Received: by 2002:aed:2217:: with SMTP id n23mr32811022qtc.288.1548938780741;
        Thu, 31 Jan 2019 04:46:20 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
        by smtp.gmail.com with ESMTPSA id m68sm4045377qte.49.2019.01.31.04.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:46:19 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 31 Jan 2019 10:46:13 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Tony Xie <tony.xie@rock-chips.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] regulator: rk808: Fix BUCK1/2 voltages on rk805
Date:   Thu, 31 Jan 2019 10:46:01 -0200
Message-Id: <20190131124601.29763-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK805 has the following voltage range for the BUCK1 and BUCK2 regulators:

From 0.7125V to 1.45V in 12.5mV steps, 1.8V, 2V, 2.2V and 2.3V

, which corresponds to the following values as per the RK805
datasheet:

000 000: 0.7125V
000 001: 0.725V
……
111 011: 1.45V
111 100: 1.8V
111 101: 2.0V
111 110: 2.2V
111 111: 2.3V

This means that the voltage range is not linear and so RK805 can not
reuse the same regulator_ops structure from RK808.

Fix it by creating a list with the correct supported voltage values
for RK805 BUCK1 and BUCK2 regulators.

Tested on a rv1108-elgin-r1 board that now correctly reports a BUCK2
voltage of 2.2V instead of the unsupported value of 1.4875V.

Fixes: c4e0d344c1f0 ("regulator: rk808: Add regulator driver for RK805")
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2:
- add fixes tag
- rebase on top of linux-next

 drivers/regulator/rk808-regulator.c | 53 ++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 08578f6d737d..79e79cdd503b 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -289,6 +289,21 @@ static int rk808_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  RK808_RAMP_RATE_MASK, ramp_value);
 }
 
+static int rk805_set_suspend_voltage(struct regulator_dev *rdev, int uv)
+{
+	unsigned int reg;
+	int sel = regulator_map_voltage_ascend(rdev, uv, uv);
+
+	if (sel < 0)
+		return -EINVAL;
+
+	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
+
+	return regmap_update_bits(rdev->regmap, reg,
+				  rdev->desc->vsel_mask,
+				  sel);
+}
+
 static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
@@ -384,6 +399,19 @@ static const struct regulator_ops rk805_switch_ops = {
 	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
+static struct regulator_ops rk805_buck1_2_ops = {
+		.list_voltage		= regulator_list_voltage_table,
+		.map_voltage		= regulator_map_voltage_ascend,
+		.get_voltage_sel        = regulator_get_voltage_sel_regmap,
+		.set_voltage_sel        = regulator_set_voltage_sel_regmap,
+		.enable                 = regulator_enable_regmap,
+		.disable                = regulator_disable_regmap,
+		.is_enabled             = regulator_is_enabled_regmap,
+		.set_suspend_voltage    = rk805_set_suspend_voltage,
+		.set_suspend_enable     = rk805_set_suspend_enable,
+		.set_suspend_disable    = rk805_set_suspend_disable,
+};
+
 static const struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -433,6 +461,17 @@ static const struct regulator_ops rk808_switch_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
+static const int rk805_buck_1_2_voltages[] = {
+	712500, 725000, 737500, 750000, 762500, 775000, 787500, 800000,
+	812500, 825000, 837500, 850000, 862500, 875000, 887500, 900000,
+	912500, 925000, 937500, 950000, 962500, 975000, 987500, 1000000,
+	1012500, 1025000, 1037500, 1050000, 1062500, 1075000, 1087500, 1100000,
+	1112500, 1125000, 1137500, 1150000, 1162500, 1175000, 1187500, 1200000,
+	1212500, 1225000, 1237500, 1250000, 1262500, 1275000, 1287500, 1300000,
+	1312500, 1325000, 1337500, 1350000, 1362500, 1375000, 1387500, 1400000,
+	1412500, 1425000, 1437500, 1450000, 1800000, 2000000, 2200000, 2300000,
+};
+
 static const struct regulator_desc rk805_reg[] = {
 	{
 		.name = "DCDC_REG1",
@@ -440,11 +479,10 @@ static const struct regulator_desc rk805_reg[] = {
 		.of_match = of_match_ptr("DCDC_REG1"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = RK805_ID_DCDC1,
-		.ops = &rk805_reg_ops,
+		.ops = &rk805_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
-		.min_uV = 712500,
-		.uV_step = 12500,
-		.n_voltages = 64,
+		.n_voltages = ARRAY_SIZE(rk805_buck_1_2_voltages),
+		.volt_table = rk805_buck_1_2_voltages,
 		.vsel_reg = RK805_BUCK1_ON_VSEL_REG,
 		.vsel_mask = RK818_BUCK_VSEL_MASK,
 		.enable_reg = RK805_DCDC_EN_REG,
@@ -456,11 +494,10 @@ static const struct regulator_desc rk805_reg[] = {
 		.of_match = of_match_ptr("DCDC_REG2"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = RK805_ID_DCDC2,
-		.ops = &rk805_reg_ops,
+		.ops = &rk805_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
-		.min_uV = 712500,
-		.uV_step = 12500,
-		.n_voltages = 64,
+		.n_voltages = ARRAY_SIZE(rk805_buck_1_2_voltages),
+		.volt_table = rk805_buck_1_2_voltages,
 		.vsel_reg = RK805_BUCK2_ON_VSEL_REG,
 		.vsel_mask = RK818_BUCK_VSEL_MASK,
 		.enable_reg = RK805_DCDC_EN_REG,
-- 
2.20.1

