Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2ADC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE0B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfBLOTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:19:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36231 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfBLOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:19:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so2376005ljk.3;
        Tue, 12 Feb 2019 06:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i+dRJdqTYAgo4Zhg2hj95X9eZ1rAqfbZpEUC1Q+pVWU=;
        b=j6zCqmYOQ4TjM+6sHxHfeBTbjBEUPSClEWmuyOQWNdsDz1I8ehJqdebCrREzehyK/s
         Ki3VcXXS3T2oH1SMKnWcs5jLRgI3GiImeZHRCPoOa2MqEK5rICfVdqPQOFZmV5MIIsyw
         6wD47aZiD7vegVyGejzoRTiKbnGkuN36ylCnzgqaE8hjwaDiKfAXDm72xtMKpnzFVK4x
         iYeRg3Ds7HTU6i9NZw2Fkd55GfL/nHoVCJlg8J68YoksRS3F5bW7gqK1nK7KE/0IhG5a
         tr7L7z7Ld8sPKptk2Wtp1RSt9zxWwZDwhvpN4kYnWOCzcuhdifM68sKJRUu9ZN+PWrTF
         JdaQ==
X-Gm-Message-State: AHQUAubz28R9PvvHMa3XheXxXwHXiGrUCPDeYQKQh+06rqXlGdBb5/j4
        ZQ8tNryHdOBrBQ0vkdRmezY=
X-Google-Smtp-Source: AHgI3IYW7hSNVhxq/Kj52U94P05OVgTwak5h/B8mpWbaRgj6EpRQkXh/dntNmYhZID6RT8TRHdMTcA==
X-Received: by 2002:a2e:999a:: with SMTP id w26-v6mr2446096lji.169.1549981185921;
        Tue, 12 Feb 2019 06:19:45 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v29-v6sm2700982ljd.44.2019.02.12.06.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 06:19:45 -0800 (PST)
Date:   Tue, 12 Feb 2019 16:19:38 +0200
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
Subject: [RFC PATCH v1 3/3] regulator: bd718x7: Support SNVS low power state
Message-ID: <06c2f2f730b07caeb1f2fb86be60c02b21d7bea9.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
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

Please not apply as such. This is compile-tested only and sent
for collecting feedback. If idea is Ok I will do proper testing
and send a non RFC patch.

 drivers/regulator/bd718x7-regulator.c | 135 ++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index ccea133778c8..327ef9223cb0 100644
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
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
