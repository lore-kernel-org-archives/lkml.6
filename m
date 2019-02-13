Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D07EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA1C222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391380AbfBMJvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:51:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37626 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfBMJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:51:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id n23so1284576lfl.4;
        Wed, 13 Feb 2019 01:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8QODV3Zo5G0UHaKkkvM2YYWjf9XcnqkfiS8iSWquqk=;
        b=Q3etmhis6R+rpnv4TSEucuEgq7Jjy7FQqUA7m1WBNIv7aLx8N/L7mlsz0n9x5IB4ME
         vo3LtyDEUX5EGF+1oHtsIOWl52U8PKeYH7rGiN7OzzhfrdRRwD7VRRJIZsS4TsC15/SX
         Zes9JLCFmsgkObY9JaczSVuOqurs0QcHqzy+RV3QJuCQDEDsWd09b0+uzjo413vw8uqD
         gi1i4PgP+QdUB1if34bFb82SivQiAnUbZqEzCASdeexZtN5xvxkTpHH9PYlL8mDR/xM9
         5IB2IBW53v+Yr6qad1j1Ihcf+ixzXOcnNRzVRsLk/b3KkLCkU9OIyZhNUdqiAr1TODuw
         rF6w==
X-Gm-Message-State: AHQUAuYJdjamES2iK5hvS3K6Z52x8RkSd01lULkfqmiOUynj0JU8yubc
        uFLUPpjALdfAynrjr3bqeb1M5ixm
X-Google-Smtp-Source: AHgI3IbMNPVCGTOszwCAiofVNkOru4Qt5+POKQsnKyrY5H/WUXVnLWypog99OE0/iZXHUifZj+Fzeg==
X-Received: by 2002:a19:9508:: with SMTP id x8mr5242354lfd.112.1550051466261;
        Wed, 13 Feb 2019 01:51:06 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f10-v6sm3333996ljc.31.2019.02.13.01.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 01:51:05 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:50:49 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com,
        Robin Gong =?utf-8?B?4oCO?= <yibin.gong@nxp.com>,
        Elven Wang =?utf-8?B?4oCO?= <elven.wang@nxp.com>,
        Anson Huang =?utf-8?B?4oCO?= <anson.huang@nxp.com>
Subject: [PATCH v2 3/3] regulator: bd718x7: Support SNVS low power state
Message-ID: <f8955e8d9a1ae10e369f24e02fc80a7f9ddc6f68.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read ROHM BD71837 / BD71847 specific device tree bindings for
controlling the PMIC shutdown/reset states and voltages for
different HW states. The PMIC was designed to be used with NXP
i.MX8 SoC and it supports SNVS low power state which seems to
be typical for NXP i.MX SoCs. However, when SNVS is used we must
not allow SW to control enabling/disabling those regulators which
are crucial for system to boot as there is a HW limitation which
causes SW controlled regulators to be kept shut down after SNVS
reset.

Allow setting the SNVS to be used as reset target state and allow
marking those regulators which are critical for boot.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 201 +++++++++++++++++++++++++++++-----
 1 file changed, 176 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index ccea133778c8..e6f98fceded7 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -350,6 +350,135 @@ static const struct reg_init bd71837_ldo6_inits[] = {
 	},
 };
 
+#define NUM_DVS_BUCKS 4
+
+struct of_dvs_setting {
+	const char *prop;
+	unsigned int reg;
+};
+
+static int set_dvs_levels(const struct of_dvs_setting *dvs,
+			  struct device_node *np,
+			  const struct regulator_desc *desc,
+			  struct regmap *regmap)
+{
+	int ret, i;
+	unsigned int uv;
+
+	ret = of_property_read_u32(np, dvs->prop, &uv);
+	if (ret) {
+		if (ret != -EINVAL)
+			return ret;
+		return 0;
+	}
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = regmap_update_bits(regmap, dvs->reg,
+						 DVS_BUCK_RUN_MASK, i);
+			break;
+		}
+	}
+	return ret;
+}
+
+static int buck4_set_hw_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	int ret, i;
+	const struct of_dvs_setting dvs[] = {
+		{
+			.prop = "rohm,dvs-run-voltage",
+			.reg = BD71837_REG_BUCK4_VOLT_RUN,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
+		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+static int buck3_set_hw_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	int ret, i;
+	const struct of_dvs_setting dvs[] = {
+		{
+			.prop = "rohm,dvs-run-voltage",
+			.reg = BD71837_REG_BUCK3_VOLT_RUN,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
+		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int buck2_set_hw_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	int ret, i;
+	const struct of_dvs_setting dvs[] = {
+		{
+			.prop = "rohm,dvs-run-voltage",
+			.reg = BD718XX_REG_BUCK2_VOLT_RUN,
+		},
+		{
+			.prop = "rohm,dvs-idle-voltage",
+			.reg = BD718XX_REG_BUCK2_VOLT_IDLE,
+		},
+	};
+
+
+
+	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
+		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int buck1_set_hw_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	int ret, i;
+	const struct of_dvs_setting dvs[] = {
+		{
+			.prop = "rohm,dvs-run-voltage",
+			.reg = BD718XX_REG_BUCK1_VOLT_RUN,
+		},
+		{
+			.prop = "rohm,dvs-idle-voltage",
+			.reg = BD718XX_REG_BUCK1_VOLT_IDLE,
+		},
+		{
+			.prop = "rohm,dvs-suspend-voltage",
+			.reg = BD718XX_REG_BUCK1_VOLT_SUSP,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
+		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 static const struct bd718xx_regulator_data bd71847_regulators[] = {
 	{
 		.desc = {
@@ -368,6 +497,7 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck1_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD718XX_REG_BUCK1_CTRL,
@@ -391,6 +521,7 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck2_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD718XX_REG_BUCK2_CTRL,
@@ -662,6 +793,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck1_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD718XX_REG_BUCK1_CTRL,
@@ -685,6 +817,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck1_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD718XX_REG_BUCK2_CTRL,
@@ -708,6 +841,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD71837_REG_BUCK3_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck3_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD71837_REG_BUCK3_CTRL,
@@ -731,6 +865,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD71837_REG_BUCK4_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.owner = THIS_MODULE,
+			.of_parse_cb = buck4_set_hw_dvs_levels,
 		},
 		.init = {
 			.reg = BD71837_REG_BUCK4_CTRL,
@@ -1029,6 +1164,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 	};
 
 	int i, j, err;
+	bool use_snvs;
 
 	mfd = dev_get_drvdata(pdev->dev.parent);
 	if (!mfd) {
@@ -1055,27 +1191,28 @@ static int bd718xx_probe(struct platform_device *pdev)
 			BD718XX_REG_REGLOCK);
 	}
 
-	/* At poweroff transition PMIC HW disables EN bit for regulators but
-	 * leaves SEL bit untouched. So if state transition from POWEROFF
-	 * is done to SNVS - then all power rails controlled by SW (having
-	 * SEL bit set) stay disabled as EN is cleared. This may result boot
-	 * failure if any crucial systems are powered by these rails.
-	 *
+	use_snvs = of_property_read_bool(pdev->dev.parent->of_node,
+					 "rohm,reset-snvs-powered");
+
+	/*
 	 * Change the next stage from poweroff to be READY instead of SNVS
 	 * for all reset types because OTP loading at READY will clear SEL
 	 * bit allowing HW defaults for power rails to be used
 	 */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
-				 BD718XX_ON_REQ_POWEROFF_MASK |
-				 BD718XX_SWRESET_POWEROFF_MASK |
-				 BD718XX_WDOG_POWEROFF_MASK |
-				 BD718XX_KEY_L_POWEROFF_MASK,
-				 BD718XX_POWOFF_TO_RDY);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to change reset target\n");
-		goto err;
-	} else {
-		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
+	if (!use_snvs) {
+		err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
+					 BD718XX_ON_REQ_POWEROFF_MASK |
+					 BD718XX_SWRESET_POWEROFF_MASK |
+					 BD718XX_WDOG_POWEROFF_MASK |
+					 BD718XX_KEY_L_POWEROFF_MASK,
+					 BD718XX_POWOFF_TO_RDY);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to change reset target\n");
+			goto err;
+		} else {
+			dev_dbg(&pdev->dev,
+				"Changed all resets from SVNS to READY\n");
+		}
 	}
 
 	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
@@ -1098,19 +1235,33 @@ static int bd718xx_probe(struct platform_device *pdev)
 			err = PTR_ERR(rdev);
 			goto err;
 		}
-		/* Regulator register gets the regulator constraints and
+
+		/*
+		 * Regulator register gets the regulator constraints and
 		 * applies them (set_machine_constraints). This should have
 		 * turned the control register(s) to correct values and we
 		 * can now switch the control from PMIC state machine to the
 		 * register interface
+		 *
+		 * At poweroff transition PMIC HW disables EN bit for
+		 * regulators but leaves SEL bit untouched. So if state
+		 * transition from POWEROFF is done to SNVS - then all power
+		 * rails controlled by SW (having SEL bit set) stay disabled
+		 * as EN is cleared. This will result boot failure if any
+		 * crucial systems are powered by these rails. We don't
+		 * enable SW control for crucial regulators if snvs state is
+		 * used
 		 */
-		err = regmap_update_bits(mfd->regmap, r->init.reg,
-					 r->init.mask, r->init.val);
-		if (err) {
-			dev_err(&pdev->dev,
-				"Failed to write BUCK/LDO SEL bit for (%s)\n",
-				desc->name);
-			goto err;
+		if (!use_snvs || !rdev->constraints->always_on ||
+		    !rdev->constraints->boot_on) {
+			err = regmap_update_bits(mfd->regmap, r->init.reg,
+						 r->init.mask, r->init.val);
+			if (err) {
+				dev_err(&pdev->dev,
+					"Failed to take control for (%s)\n",
+					desc->name);
+				goto err;
+			}
 		}
 		for (j = 0; j < r->additional_init_amnt; j++) {
 			err = regmap_update_bits(mfd->regmap,
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
