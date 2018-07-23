Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A836ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF6320779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF6320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbeGWIrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:47:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36985 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbeGWIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:47:55 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fhVZT-0007uo-Mf; Mon, 23 Jul 2018 09:47:55 +0200
Received: from mfe by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <mfe@pengutronix.de>)
        id 1fhVZS-0007lf-JV; Mon, 23 Jul 2018 09:47:54 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     fabio.estevam@nxp.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] regulator: pfuze100: add support to en-/disable switch regulators
Date:   Mon, 23 Jul 2018 09:47:47 +0200
Message-Id: <20180723074747.9328-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723074747.9328-1-m.felsch@pengutronix.de>
References: <20180723074747.9328-1-m.felsch@pengutronix.de>
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
"fsl,pfuze-support-disable-sw" in its device tree to keep backward
compatibility with current dtb's [1].

[1] https://patchwork.kernel.org/patch/10490381/

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

---
Changes in V3:
  - Change dt binding, add -sw suffix

Changes in v2:
  - Don't trick the framework, use a seperate ops struct
    to register the correct callbacks.
  - Set the desc en/disable_val and enable_time only if it necessary
  - Change the dt property binding

Changes since https://patchwork.kernel.org/patch/10405723/
  - Use DT property to keep backward compatibility
  - Use the default register val 0x8 as enable_val

 drivers/regulator/pfuze100-regulator.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index cde6eda1d283..31c3a236120a 100644
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
@@ -50,10 +52,12 @@ struct pfuze_regulator {
 	struct regulator_desc desc;
 	unsigned char stby_reg;
 	unsigned char stby_mask;
+	bool sw_reg;
 };
 
 struct pfuze_chip {
 	int	chip_id;
+	int     flags;
 	struct regmap *regmap;
 	struct device *dev;
 	struct pfuze_regulator regulator_descs[PFUZE100_MAX_REGULATOR];
@@ -170,6 +174,17 @@ static const struct regulator_ops pfuze100_sw_regulator_ops = {
 	.set_ramp_delay = pfuze100_set_ramp_delay,
 };
 
+static const struct regulator_ops pfuze100_sw_disable_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = pfuze100_set_ramp_delay,
+};
+
 static const struct regulator_ops pfuze100_swb_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -209,9 +224,12 @@ static const struct regulator_ops pfuze100_swb_regulator_ops = {
 			.uV_step = (step),	\
 			.vsel_reg = (base) + PFUZE100_VOL_OFFSET,	\
 			.vsel_mask = 0x3f,	\
+			.enable_reg = (base) + PFUZE100_MODE_OFFSET,	\
+			.enable_mask = 0xf,	\
 		},	\
 		.stby_reg = (base) + PFUZE100_STANDBY_OFFSET,	\
 		.stby_mask = 0x3f,	\
+		.sw_reg = true,		\
 	}
 
 #define PFUZE100_SWB_REG(_chip, _name, base, mask, voltages)	\
@@ -471,6 +489,9 @@ static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
 	if (!np)
 		return -EINVAL;
 
+	if (of_property_read_bool(np, "fsl,pfuze-support-disable-sw"))
+		chip->flags |= PFUZE_FLAG_DISABLE_SW;
+
 	parent = of_get_child_by_name(np, "regulators");
 	if (!parent) {
 		dev_err(dev, "regulators node not found\n");
@@ -703,6 +724,21 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 			}
 		}
 
+		/*
+		 * Allow SW regulators to turn off. Checking it trough a flag is
+		 * a workaround to keep the backward compatibility with existing
+		 * old dtb's which may relay on the fact that we didn't disable
+		 * the switched regulator till yet.
+		 */
+		if (pfuze_chip->flags & PFUZE_FLAG_DISABLE_SW) {
+			if (pfuze_chip->regulator_descs[i].sw_reg) {
+				desc->ops = &pfuze100_sw_disable_regulator_ops;
+				desc->enable_val = 0x8;
+				desc->disable_val = 0x0;
+				desc->enable_time = 500;
+			}
+		}
+
 		config.dev = &client->dev;
 		config.init_data = init_data;
 		config.driver_data = pfuze_chip;
-- 
2.18.0

