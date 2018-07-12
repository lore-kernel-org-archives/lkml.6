Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92E9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AE8208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AE8208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbeGLLMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:12:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33597 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeGLLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:53 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdZMy-00068a-Rr; Thu, 12 Jul 2018 13:02:44 +0200
Received: from mfe by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdZMy-00014e-2H; Thu, 12 Jul 2018 13:02:44 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: pfuze100: add support to en-/disable switch regulators
Date:   Thu, 12 Jul 2018 13:02:40 +0200
Message-Id: <20180712110240.3006-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712110240.3006-1-m.felsch@pengutronix.de>
References: <20180712110240.3006-1-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enable/disable support for switch regulators on pfuze100.

Based on commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for
switch") which is reverted due to boot regressions by commit 464a5686e6c9
("regulator: Revert "regulator: pfuze100: add enable/disable for switch"").
Disabling the switch regulators will only be done if the user specifies
"pfuze-disable-sw" in its device tree to keep backward compatibility with
current dtb's [1]. Otherwise the regulators are marked as 'disabled', but
the driver keeps them on. So it's more like a simulated disable.

[1] https://patchwork.kernel.org/patch/10490381/

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

---
Changes since https://patchwork.kernel.org/patch/10405723/
  - Use DT property to keep backward compatibility
  - Use the default register val 0x8 as enable_val

 drivers/regulator/pfuze100-regulator.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index cde6eda1d283..2f5f3eb43e42 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include <linux/regmap.h>
 
+#define PFUZE_FLAG_DISABLE_SW	BIT(1)
+
 #define PFUZE_NUMREGS		128
 #define PFUZE100_VOL_OFFSET	0
 #define PFUZE100_STANDBY_OFFSET	1
@@ -54,6 +56,7 @@ struct pfuze_regulator {
 
 struct pfuze_chip {
 	int	chip_id;
+	int     flags;
 	struct regmap *regmap;
 	struct device *dev;
 	struct pfuze_regulator regulator_descs[PFUZE100_MAX_REGULATOR];
@@ -106,6 +109,18 @@ static const struct of_device_id pfuze_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, pfuze_dt_ids);
 
+static int pfuze100_disable(struct regulator_dev *rdev)
+{
+	struct pfuze_chip *pfuze100 = rdev_get_drvdata(rdev);
+
+	/*
+	 * Only disable the regulator if the user really wants it, else simulate
+	 * a disabled regulator but leave the regulator on.
+	 */
+	return (pfuze100->flags & PFUZE_FLAG_DISABLE_SW) ?
+		regulator_disable_regmap(rdev) : 0;
+}
+
 static int pfuze100_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 {
 	struct pfuze_chip *pfuze100 = rdev_get_drvdata(rdev);
@@ -163,6 +178,9 @@ static const struct regulator_ops pfuze100_fixed_regulator_ops = {
 };
 
 static const struct regulator_ops pfuze100_sw_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = pfuze100_disable,
+	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -209,6 +227,11 @@ static const struct regulator_ops pfuze100_swb_regulator_ops = {
 			.uV_step = (step),	\
 			.vsel_reg = (base) + PFUZE100_VOL_OFFSET,	\
 			.vsel_mask = 0x3f,	\
+			.enable_reg = (base) + PFUZE100_MODE_OFFSET,	\
+			.enable_val = 0x8,	\
+			.disable_val = 0x0,	\
+			.enable_mask = 0xf,	\
+			.enable_time = 500,	\
 		},	\
 		.stby_reg = (base) + PFUZE100_STANDBY_OFFSET,	\
 		.stby_mask = 0x3f,	\
@@ -471,6 +494,9 @@ static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
 	if (!np)
 		return -EINVAL;
 
+	if (of_property_read_bool(np, "pfuze-disable-sw"))
+		chip->flags |= PFUZE_FLAG_DISABLE_SW;
+
 	parent = of_get_child_by_name(np, "regulators");
 	if (!parent) {
 		dev_err(dev, "regulators node not found\n");
-- 
2.18.0

