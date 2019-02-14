Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BA2222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="YEZYwWID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392698AbfBNPAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:00:51 -0500
Received: from node.akkea.ca ([192.155.83.177]:54554 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388581AbfBNPAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:00:51 -0500
Received: by node.akkea.ca (Postfix, from userid 33)
        id 602E14E204B; Thu, 14 Feb 2019 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1550156450; bh=94QpRbGQr+IPYdI7OBBOThMIf8AUFrHQYw0bYT9El5c=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=YEZYwWIDFcQAZa3PfS3PBE0dHZwsVFQzZFKdQmjLOpPhcX0FBCbTMLXnJ8De5dg/E
         r6bM+TyDYz/eFWqxpHlKURViN4G7vyFO15HlXtbTe1Yv4HAnbpYra3MOVBvFwRgdNq
         1OUsZUmfWpCuip9NJnIKTt0N22eccAV0vq39QaPM=
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v3 3/3] regulator: bd718x7: Support SNVS low power state
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Feb 2019 07:00:50 -0800
From:   Angus Ainslie <angus@akkea.ca>
Cc:     mazzisaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        linux-kernel-owner@vger.kernel.org
In-Reply-To: <7da51300c04027a25c9a7dc093d0eb844c923427.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <7da51300c04027a25c9a7dc093d0eb844c923427.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <a8187d6c859a925530c6411ba1f5fbfa@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-14 01:39, Matti Vaittinen wrote:
> read ROHM BD71837 / BD71847 specific device tree bindings for
> controlling the PMIC shutdown/reset states and voltages for
> different HW states. The PMIC was designed to be used with NXP
> i.MX8 SoC and it supports SNVS low power state which seems to
> be typical for NXP i.MX SoCs. However, when SNVS is used we must
> not allow SW to control enabling/disabling those regulators which
> are crucial for system to boot as there is a HW limitation which
> causes SW controlled regulators to be kept shut down after SNVS
> reset.
> 
> Allow setting the SNVS to be used as reset target state and allow
> marking those regulators which are critical for boot.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>

> ---
> 
> Angus, I would be grateful if you have a chance to test this
> on your system :)
> 
>  drivers/regulator/bd718x7-regulator.c | 201 
> +++++++++++++++++++++++++++++-----
>  1 file changed, 176 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/regulator/bd718x7-regulator.c
> b/drivers/regulator/bd718x7-regulator.c
> index ccea133778c8..b2191be49670 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -350,6 +350,135 @@ static const struct reg_init bd71837_ldo6_inits[] 
> = {
>  	},
>  };
> 
> +#define NUM_DVS_BUCKS 4
> +
> +struct of_dvs_setting {
> +	const char *prop;
> +	unsigned int reg;
> +};
> +
> +static int set_dvs_levels(const struct of_dvs_setting *dvs,
> +			  struct device_node *np,
> +			  const struct regulator_desc *desc,
> +			  struct regmap *regmap)
> +{
> +	int ret, i;
> +	unsigned int uv;
> +
> +	ret = of_property_read_u32(np, dvs->prop, &uv);
> +	if (ret) {
> +		if (ret != -EINVAL)
> +			return ret;
> +		return 0;
> +	}
> +
> +	for (i = 0; i < desc->n_voltages; i++) {
> +		ret = regulator_desc_list_voltage_linear_range(desc, i);
> +		if (ret < 0)
> +			continue;
> +		if (ret == uv) {
> +			i <<= ffs(desc->vsel_mask) - 1;
> +			ret = regmap_update_bits(regmap, dvs->reg,
> +						 DVS_BUCK_RUN_MASK, i);
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int buck4_set_hw_dvs_levels(struct device_node *np,
> +			    const struct regulator_desc *desc,
> +			    struct regulator_config *cfg)
> +{
> +	int ret, i;
> +	const struct of_dvs_setting dvs[] = {
> +		{
> +			.prop = "rohm,dvs-run-voltage",
> +			.reg = BD71837_REG_BUCK4_VOLT_RUN,
> +		},
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
> +		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +static int buck3_set_hw_dvs_levels(struct device_node *np,
> +			    const struct regulator_desc *desc,
> +			    struct regulator_config *cfg)
> +{
> +	int ret, i;
> +	const struct of_dvs_setting dvs[] = {
> +		{
> +			.prop = "rohm,dvs-run-voltage",
> +			.reg = BD71837_REG_BUCK3_VOLT_RUN,
> +		},
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
> +		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +
> +static int buck2_set_hw_dvs_levels(struct device_node *np,
> +			    const struct regulator_desc *desc,
> +			    struct regulator_config *cfg)
> +{
> +	int ret, i;
> +	const struct of_dvs_setting dvs[] = {
> +		{
> +			.prop = "rohm,dvs-run-voltage",
> +			.reg = BD718XX_REG_BUCK2_VOLT_RUN,
> +		},
> +		{
> +			.prop = "rohm,dvs-idle-voltage",
> +			.reg = BD718XX_REG_BUCK2_VOLT_IDLE,
> +		},
> +	};
> +
> +
> +
> +	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
> +		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +
> +static int buck1_set_hw_dvs_levels(struct device_node *np,
> +			    const struct regulator_desc *desc,
> +			    struct regulator_config *cfg)
> +{
> +	int ret, i;
> +	const struct of_dvs_setting dvs[] = {
> +		{
> +			.prop = "rohm,dvs-run-voltage",
> +			.reg = BD718XX_REG_BUCK1_VOLT_RUN,
> +		},
> +		{
> +			.prop = "rohm,dvs-idle-voltage",
> +			.reg = BD718XX_REG_BUCK1_VOLT_IDLE,
> +		},
> +		{
> +			.prop = "rohm,dvs-suspend-voltage",
> +			.reg = BD718XX_REG_BUCK1_VOLT_SUSP,
> +		},
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(dvs); i++) {
> +		ret = set_dvs_levels(&dvs[i], np, desc, cfg->regmap);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +
>  static const struct bd718xx_regulator_data bd71847_regulators[] = {
>  	{
>  		.desc = {
> @@ -368,6 +497,7 @@ static const struct bd718xx_regulator_data
> bd71847_regulators[] = {
>  			.enable_reg = BD718XX_REG_BUCK1_CTRL,
>  			.enable_mask = BD718XX_BUCK_EN,
>  			.owner = THIS_MODULE,
> +			.of_parse_cb = buck1_set_hw_dvs_levels,
>  		},
>  		.init = {
>  			.reg = BD718XX_REG_BUCK1_CTRL,
> @@ -391,6 +521,7 @@ static const struct bd718xx_regulator_data
> bd71847_regulators[] = {
>  			.enable_reg = BD718XX_REG_BUCK2_CTRL,
>  			.enable_mask = BD718XX_BUCK_EN,
>  			.owner = THIS_MODULE,
> +			.of_parse_cb = buck2_set_hw_dvs_levels,
>  		},
>  		.init = {
>  			.reg = BD718XX_REG_BUCK2_CTRL,
> @@ -662,6 +793,7 @@ static const struct bd718xx_regulator_data
> bd71837_regulators[] = {
>  			.enable_reg = BD718XX_REG_BUCK1_CTRL,
>  			.enable_mask = BD718XX_BUCK_EN,
>  			.owner = THIS_MODULE,
> +			.of_parse_cb = buck1_set_hw_dvs_levels,
>  		},
>  		.init = {
>  			.reg = BD718XX_REG_BUCK1_CTRL,
> @@ -685,6 +817,7 @@ static const struct bd718xx_regulator_data
> bd71837_regulators[] = {
>  			.enable_reg = BD718XX_REG_BUCK2_CTRL,
>  			.enable_mask = BD718XX_BUCK_EN,
>  			.owner = THIS_MODULE,
> +			.of_parse_cb = buck2_set_hw_dvs_levels,
>  		},
>  		.init = {
>  			.reg = BD718XX_REG_BUCK2_CTRL,
> @@ -708,6 +841,7 @@ static const struct bd718xx_regulator_data
> bd71837_regulators[] = {
>  			.enable_reg = BD71837_REG_BUCK3_CTRL,
>  			.enable_mask = BD718XX_BUCK_EN,
>  			.owner = THIS_MODULE,
> +			.of_parse_cb = buck3_set_hw_dvs_levels,
>  		},
>  		.init = {
>  			.reg = BD71837_REG_BUCK3_CTRL,
> @@ -731,6 +865,7 @@ static const struct bd718xx_regulator_data
> bd71837_regulators[] = {
>  			.enable_reg = BD71837_REG_BUCK4_CTRL,
>  			.enable_mask = BD718XX_BUCK_EN,
>  			.owner = THIS_MODULE,
> +			.of_parse_cb = buck4_set_hw_dvs_levels,
>  		},
>  		.init = {
>  			.reg = BD71837_REG_BUCK4_CTRL,
> @@ -1029,6 +1164,7 @@ static int bd718xx_probe(struct platform_device 
> *pdev)
>  	};
> 
>  	int i, j, err;
> +	bool use_snvs;
> 
>  	mfd = dev_get_drvdata(pdev->dev.parent);
>  	if (!mfd) {
> @@ -1055,27 +1191,28 @@ static int bd718xx_probe(struct platform_device 
> *pdev)
>  			BD718XX_REG_REGLOCK);
>  	}
> 
> -	/* At poweroff transition PMIC HW disables EN bit for regulators but
> -	 * leaves SEL bit untouched. So if state transition from POWEROFF
> -	 * is done to SNVS - then all power rails controlled by SW (having
> -	 * SEL bit set) stay disabled as EN is cleared. This may result boot
> -	 * failure if any crucial systems are powered by these rails.
> -	 *
> +	use_snvs = of_property_read_bool(pdev->dev.parent->of_node,
> +					 "rohm,reset-snvs-powered");
> +
> +	/*
>  	 * Change the next stage from poweroff to be READY instead of SNVS
>  	 * for all reset types because OTP loading at READY will clear SEL
>  	 * bit allowing HW defaults for power rails to be used
>  	 */
> -	err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
> -				 BD718XX_ON_REQ_POWEROFF_MASK |
> -				 BD718XX_SWRESET_POWEROFF_MASK |
> -				 BD718XX_WDOG_POWEROFF_MASK |
> -				 BD718XX_KEY_L_POWEROFF_MASK,
> -				 BD718XX_POWOFF_TO_RDY);
> -	if (err) {
> -		dev_err(&pdev->dev, "Failed to change reset target\n");
> -		goto err;
> -	} else {
> -		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
> +	if (!use_snvs) {
> +		err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
> +					 BD718XX_ON_REQ_POWEROFF_MASK |
> +					 BD718XX_SWRESET_POWEROFF_MASK |
> +					 BD718XX_WDOG_POWEROFF_MASK |
> +					 BD718XX_KEY_L_POWEROFF_MASK,
> +					 BD718XX_POWOFF_TO_RDY);
> +		if (err) {
> +			dev_err(&pdev->dev, "Failed to change reset target\n");
> +			goto err;
> +		} else {
> +			dev_dbg(&pdev->dev,
> +				"Changed all resets from SVNS to READY\n");
> +		}
>  	}
> 
>  	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
> @@ -1098,19 +1235,33 @@ static int bd718xx_probe(struct platform_device 
> *pdev)
>  			err = PTR_ERR(rdev);
>  			goto err;
>  		}
> -		/* Regulator register gets the regulator constraints and
> +
> +		/*
> +		 * Regulator register gets the regulator constraints and
>  		 * applies them (set_machine_constraints). This should have
>  		 * turned the control register(s) to correct values and we
>  		 * can now switch the control from PMIC state machine to the
>  		 * register interface
> +		 *
> +		 * At poweroff transition PMIC HW disables EN bit for
> +		 * regulators but leaves SEL bit untouched. So if state
> +		 * transition from POWEROFF is done to SNVS - then all power
> +		 * rails controlled by SW (having SEL bit set) stay disabled
> +		 * as EN is cleared. This will result boot failure if any
> +		 * crucial systems are powered by these rails. We don't
> +		 * enable SW control for crucial regulators if snvs state is
> +		 * used
>  		 */
> -		err = regmap_update_bits(mfd->regmap, r->init.reg,
> -					 r->init.mask, r->init.val);
> -		if (err) {
> -			dev_err(&pdev->dev,
> -				"Failed to write BUCK/LDO SEL bit for (%s)\n",
> -				desc->name);
> -			goto err;
> +		if (!use_snvs || !rdev->constraints->always_on ||
> +		    !rdev->constraints->boot_on) {
> +			err = regmap_update_bits(mfd->regmap, r->init.reg,
> +						 r->init.mask, r->init.val);
> +			if (err) {
> +				dev_err(&pdev->dev,
> +					"Failed to take control for (%s)\n",
> +					desc->name);
> +				goto err;
> +			}
>  		}
>  		for (j = 0; j < r->additional_init_amnt; j++) {
>  			err = regmap_update_bits(mfd->regmap,
> --
> 2.14.3

