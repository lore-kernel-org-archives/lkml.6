Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F09C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764A520A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764A520A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHXP5b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:57:31 -0400
Received: from mail.x-arc.de ([217.6.246.34]:44350 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeHXP5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:57:30 -0400
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by root.phytec.de (Postfix) with ESMTP id F0D1FA00603;
        Fri, 24 Aug 2018 14:23:36 +0200 (CEST)
Received: from [172.16.23.157] ([172.16.23.157])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2018082414230016-796419 ;
          Fri, 24 Aug 2018 14:23:00 +0200 
Subject: Re: [PATCH v3 2/5] regulator: rk808: add RK809 and RK817 support.
To:     Tony Xie <tony.xie@rock-chips.com>, heiko@sntech.de
Cc:     mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, huangtao@rock-chips.com,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, xsf@rock-chips.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        chenjh@rock-chips.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081441-20718-3-git-send-email-tony.xie@rock-chips.com>
From:   Wadim Egorov <w.egorov@phytec.de>
Message-ID: <2f99d1c5-1e96-9a55-ae4f-260451a5915d@phytec.de>
Date:   Fri, 24 Aug 2018 14:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <1535081441-20718-3-git-send-email-tony.xie@rock-chips.com>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 24.08.2018 14:23:00,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 24.08.2018 14:23:00
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

I have a few points regarding the various Rockchip PMIC variants and
it's handling in this driver.

Am 24.08.18 um 05:30 schrieb Tony Xie:
>     Add support for the rk809 and rk817 regulator driver.
>     Their specifications are as follows：
>     1、The RK809 and RK809 consist of 5 DCDCs, 9 LDOs
>        and have the same registers for these components except dcdc5.
>     2、The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
>     3、The RK817 has one switch but The Rk809 has two.
>
>     The output voltages are configurable and are meant to supply power
>     to the main processor and other components.
>
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>  drivers/regulator/Kconfig           |   4 +-
>  drivers/regulator/rk808-regulator.c | 639 +++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/rk808.h           |   3 +
>  3 files changed, 641 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 5dbccf5..27ff89f 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -716,11 +716,11 @@ config REGULATOR_RC5T583
>  	  outputs which can be controlled by i2c communication.
>  
>  config REGULATOR_RK808
> -	tristate "Rockchip RK805/RK808/RK818 Power regulators"
> +	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power regulators"
>  	depends on MFD_RK808
>  	help
>  	  Select this option to enable the power regulator of ROCKCHIP
> -	  PMIC RK805,RK808 and RK818.
> +	  PMIC RK805,RK809&RK817,RK808 and RK818.
>  	  This driver supports the control of different power rails of device
>  	  through regulator interface. The device supports multiple DCDC/LDO
>  	  outputs which can be controlled by i2c communication.
> diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
> index 213b687..4aa2df6 100644
> --- a/drivers/regulator/rk808-regulator.c
> +++ b/drivers/regulator/rk808-regulator.c
> @@ -36,6 +36,12 @@
>  #define RK808_BUCK4_VSEL_MASK	0xf
>  #define RK808_LDO_VSEL_MASK	0x1f
>  
> +#define RK809_BUCK5_VSEL_MASK		0x7
> +
> +#define RK817_LDO_VSEL_MASK		0x7f
> +#define RK817_BOOST_VSEL_MASK		0x7
> +#define RK817_BUCK_VSEL_MASK		0x7f
> +
>  #define RK818_BUCK_VSEL_MASK		0x3f
>  #define RK818_BUCK4_VSEL_MASK		0x1f
>  #define RK818_LDO_VSEL_MASK		0x1f
> @@ -65,6 +71,9 @@
>  /* max steps for increase voltage of Buck1/2, equal 100mv*/
>  #define MAX_STEPS_ONE_TIME 8
>  
> +#define ENABLE_MASK(id)			(BIT(id) | BIT(4 + (id)))
> +#define DISABLE_VAL(id)			(BIT(4 + (id)))
> +
>  #define RK805_DESC(_id, _match, _supply, _min, _max, _step, _vreg,      \
>  	_vmask, _ereg, _emask, _etime)                                  \
>  	[_id] = {                                                       \
> @@ -86,6 +95,70 @@
>  		.ops            = &rk805_reg_ops,                       \
>  	}
>  
> +#define RK817_DESC(_id, _match, _supply, _min, _max, _step, _vreg,	\
> +	_vmask, _ereg, _emask, _enval, _disval, _etime)		\
> +	{							\
> +		.name		= (_match),				\
> +		.supply_name	= (_supply),				\
> +		.of_match	= of_match_ptr(_match),			\
> +		.regulators_node = of_match_ptr("regulators"),		\
> +		.type		= REGULATOR_VOLTAGE,			\
> +		.id		= (_id),				\
> +		.n_voltages	= (((_max) - (_min)) / (_step) + 1),	\
> +		.owner		= THIS_MODULE,				\
> +		.min_uV		= (_min) * 1000,			\
> +		.uV_step	= (_step) * 1000,			\
> +		.vsel_reg	= (_vreg),				\
> +		.vsel_mask	= (_vmask),				\
> +		.enable_reg	= (_ereg),				\
> +		.enable_mask	= (_emask),				\
> +		.enable_val     = (_enval),				\
> +		.disable_val     = (_disval),				\
> +		.enable_time	= (_etime),				\
> +		.ops		= &rk817_reg_ops,			\
> +	}

There is already a RK805_DESC and RK8XX_DESC which looking very similar.
So instead of creating a new RK817_DESC, you can also reuse the
RK8XX_DESC by extending it with a an ops parameter. I think you can
refactor the RK8XX_DESC in a way it will be usable for most of your PMICs.
It also looks like you can remove the _enval and _disval parameters
since _enval and _emask is always the same.


> +
> +#define RK817_BOOST_DESC(_id, _match, _supply, _min, _max, _step, _vreg,\
> +	_vmask, _ereg, _emask, _enval, _disval, _etime, m_drop)		\
> +	{							\
> +		.name		= (_match),				\
> +		.supply_name	= (_supply),				\
> +		.of_match	= of_match_ptr(_match),			\
> +		.regulators_node = of_match_ptr("regulators"),		\
> +		.type		= REGULATOR_VOLTAGE,			\
> +		.id		= (_id),				\
> +		.n_voltages	= (((_max) - (_min)) / (_step) + 1),	\
> +		.owner		= THIS_MODULE,				\
> +		.min_uV		= (_min) * 1000,			\
> +		.uV_step	= (_step) * 1000,			\
> +		.vsel_reg	= (_vreg),				\
> +		.vsel_mask	= (_vmask),				\
> +		.enable_reg	= (_ereg),				\
> +		.enable_mask	= (_emask),				\
> +		.enable_val     = (_enval),				\
> +		.disable_val     = (_disval),				\
> +		.enable_time	= (_etime),				\
> +		.min_dropout_uV = (m_drop) * 1000,			\
> +		.ops		= &rk817_boost_ops,			\
> +	}
> +
> +#define RK817_DESC_SWITCH(_id, _match, _supply, _ereg, _emask,\
> +	_enval, _disval)		\
> +	{							\
> +		.name		= (_match),				\
> +		.supply_name	= (_supply),				\
> +		.of_match	= of_match_ptr(_match),			\
> +		.regulators_node = of_match_ptr("regulators"),		\
> +		.type		= REGULATOR_VOLTAGE,			\
> +		.id		= (_id),				\
> +		.enable_reg	= (_ereg),				\
> +		.enable_mask	= (_emask),				\
> +		.enable_val     = (_enval),				\
> +		.disable_val     = (_disval),				\
> +		.owner		= THIS_MODULE,				\
> +		.ops		= &rk817_switch_ops			\
> +	}

Same thing applies to the RK817_DESC_SWITCH.

Regards,
Wadim


> +
>  #define RK8XX_DESC(_id, _match, _supply, _min, _max, _step, _vreg,	\
>  	_vmask, _ereg, _emask, _etime)					\
>  	[_id] = {							\
> @@ -121,7 +194,6 @@
>  		.ops		= &rk808_switch_ops			\
>  	}
>  
> -
>  struct rk808_regulator_data {
>  	struct gpio_desc *dvs_gpio[2];
>  };
> @@ -138,6 +210,51 @@ struct rk808_regulator_data {
>  	REGULATOR_LINEAR_RANGE(2500000, 15, 15, 0),
>  };
>  
> +#define RK809_BUCK5_SEL_CNT		(8)
> +
> +static const struct regulator_linear_range rk809_buck5_voltage_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(1500000, 0, 0, 0),
> +	REGULATOR_LINEAR_RANGE(1800000, 1, 3, 200000),
> +	REGULATOR_LINEAR_RANGE(2800000, 4, 5, 200000),
> +	REGULATOR_LINEAR_RANGE(3300000, 6, 7, 300000),
> +};
> +
> +#define RK817_BUCK1_MIN0 500000
> +#define RK817_BUCK1_MAX0 1500000
> +
> +#define RK817_BUCK1_MIN1 1600000
> +#define RK817_BUCK1_MAX1 2400000
> +
> +#define RK817_BUCK3_MAX1 3400000
> +
> +#define RK817_BUCK1_STP0 12500
> +#define RK817_BUCK1_STP1 100000
> +
> +#define RK817_BUCK1_SEL0 ((RK817_BUCK1_MAX0 - RK817_BUCK1_MIN0) /\
> +						  RK817_BUCK1_STP0)
> +#define RK817_BUCK1_SEL1 ((RK817_BUCK1_MAX1 - RK817_BUCK1_MIN1) /\
> +						  RK817_BUCK1_STP1)
> +
> +#define RK817_BUCK3_SEL1 ((RK817_BUCK3_MAX1 - RK817_BUCK1_MIN1) /\
> +						  RK817_BUCK1_STP1)
> +
> +#define RK817_BUCK1_SEL_CNT (RK817_BUCK1_SEL0 + RK817_BUCK1_SEL1 + 1)
> +#define RK817_BUCK3_SEL_CNT (RK817_BUCK1_SEL0 + RK817_BUCK3_SEL1 + 1)
> +
> +static const struct regulator_linear_range rk817_buck1_voltage_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(RK817_BUCK1_MIN0, 0,
> +			       RK817_BUCK1_SEL0, RK817_BUCK1_STP0),
> +	REGULATOR_LINEAR_RANGE(RK817_BUCK1_MIN1, RK817_BUCK1_SEL0 + 1,
> +			       RK817_BUCK1_SEL_CNT, RK817_BUCK1_STP1),
> +};
> +
> +static const struct regulator_linear_range rk817_buck3_voltage_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(RK817_BUCK1_MIN0, 0,
> +			       RK817_BUCK1_SEL0, RK817_BUCK1_STP0),
> +	REGULATOR_LINEAR_RANGE(RK817_BUCK1_MIN1, RK817_BUCK1_SEL0 + 1,
> +			       RK817_BUCK3_SEL_CNT, RK817_BUCK1_STP1),
> +};
> +
>  static int rk808_buck1_2_get_voltage_sel_regmap(struct regulator_dev *rdev)
>  {
>  	struct rk808_regulator_data *pdata = rdev_get_drvdata(rdev);
> @@ -281,14 +398,45 @@ static int rk808_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
>  	case 6001 ... 10000:
>  		break;
>  	default:
> -		pr_warn("%s ramp_delay: %d not supported, setting 10000\n",
> -			rdev->desc->name, ramp_delay);
> +		dev_warn(&rdev->dev,
> +			 "%s ramp_delay: %d not supported, setting 10000\n",
> +			 rdev->desc->name, ramp_delay);
>  	}
>  
>  	return regmap_update_bits(rdev->regmap, reg,
>  				  RK808_RAMP_RATE_MASK, ramp_value);
>  }
>  
> +/*
> + * RK817 RK809
> + */
> +static int rk817_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> +{
> +	unsigned int ramp_value = RK817_RAMP_RATE_25MV_PER_US;
> +	unsigned int reg = RK817_BUCK_CONFIG_REG(rdev_get_id(rdev));
> +
> +	switch (ramp_delay) {
> +	case 0 ... 3000:
> +		ramp_value = RK817_RAMP_RATE_3MV_PER_US;
> +		break;
> +	case 3001 ... 6300:
> +		ramp_value = RK817_RAMP_RATE_6_3MV_PER_US;
> +		break;
> +	case 6301 ... 12500:
> +		ramp_value = RK817_RAMP_RATE_12_5MV_PER_US;
> +		break;
> +	case 12501 ... 25000:
> +		break;
> +	default:
> +		dev_warn(&rdev->dev,
> +			 "%s ramp_delay: %d not supported, setting 10000\n",
> +			 rdev->desc->name, ramp_delay);
> +	}
> +
> +	return regmap_update_bits(rdev->regmap, reg,
> +				  RK817_RAMP_RATE_MASK, ramp_value);
> +}
> +
>  static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
>  {
>  	unsigned int reg;
> @@ -304,6 +452,29 @@ static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
>  				  sel);
>  }
>  
> +static int rk817_check_suspend_voltage(int id)
> +{
> +	if (id >= RK817_ID_DCDC1 && id <= RK817_ID_LDO9)
> +		return 0;
> +	return -1;
> +}
> +
> +static int rk817_set_suspend_voltage(struct regulator_dev *rdev, int uv)
> +{
> +	unsigned int reg;
> +	int id = rdev_get_id(rdev);
> +	int sel = regulator_map_voltage_linear(rdev, uv, uv);
> +	/* only ldo1~ldo9 */
> +	if (sel < 0 || rk817_check_suspend_voltage(id))
> +		return -EINVAL;
> +
> +	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
> +
> +	return regmap_update_bits(rdev->regmap, reg,
> +				  rdev->desc->vsel_mask,
> +				  sel);
> +}
> +
>  static int rk808_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
>  {
>  	unsigned int reg;
> @@ -363,6 +534,129 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
>  				  rdev->desc->enable_mask);
>  }
>  
> +static int rk817_set_suspend_enable_ctrl(struct regulator_dev *rdev,
> +					 unsigned int en)
> +{
> +	unsigned int reg;
> +	int id = rdev_get_id(rdev);
> +	unsigned int id_slp, msk, val;
> +
> +	if (id >= RK817_ID_DCDC1 && id <= RK817_ID_DCDC4)
> +		id_slp = id;
> +	else if (id >= RK817_ID_LDO1 && id <= RK817_ID_LDO8)
> +		id_slp = 8 + (id - RK817_ID_LDO1);
> +	else if (id >= RK817_ID_LDO9 && id <= RK809_ID_SW2)
> +		id_slp = 4 + (id - RK817_ID_LDO9);
> +	else
> +		return -EINVAL;
> +
> +	reg = RK817_POWER_SLP_EN_REG(id_slp / 8);
> +
> +	msk = BIT(id_slp % 8);
> +	if (en)
> +		val = msk;
> +	else
> +		val = 0;
> +
> +	return regmap_update_bits(rdev->regmap, reg, msk, val);
> +}
> +
> +static int rk817_set_suspend_enable(struct regulator_dev *rdev)
> +{
> +	return rk817_set_suspend_enable_ctrl(rdev, 1);
> +}
> +
> +static int rk817_set_suspend_disable(struct regulator_dev *rdev)
> +{
> +	return rk817_set_suspend_enable_ctrl(rdev, 0);
> +}
> +
> +static int rk8xx_set_suspend_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	unsigned int reg;
> +
> +	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
> +
> +	switch (mode) {
> +	case REGULATOR_MODE_FAST:
> +		return regmap_update_bits(rdev->regmap, reg,
> +					  PWM_MODE_MSK, FPWM_MODE);
> +	case REGULATOR_MODE_NORMAL:
> +		return regmap_update_bits(rdev->regmap, reg,
> +					  PWM_MODE_MSK, AUTO_PWM_MODE);
> +	default:
> +		dev_err(&rdev->dev, "do not support this mode\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rk8xx_set_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	switch (mode) {
> +	case REGULATOR_MODE_FAST:
> +		return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
> +					  PWM_MODE_MSK, FPWM_MODE);
> +	case REGULATOR_MODE_NORMAL:
> +		return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
> +					  PWM_MODE_MSK, AUTO_PWM_MODE);
> +	default:
> +		dev_err(&rdev->dev, "do not support this mode\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned int rk8xx_get_mode(struct regulator_dev *rdev)
> +{
> +	unsigned int val;
> +	int err;
> +
> +	err = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
> +	if (err)
> +		return err;
> +
> +	if (val & FPWM_MODE)
> +		return REGULATOR_MODE_FAST;
> +	else
> +		return REGULATOR_MODE_NORMAL;
> +}
> +
> +static int rk8xx_is_enabled_wmsk_regmap(struct regulator_dev *rdev)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(rdev->regmap, rdev->desc->enable_reg, &val);
> +	if (ret != 0)
> +		return ret;
> +
> +	/* add write mask bit */
> +	val |= (rdev->desc->enable_mask & 0xf0);
> +	val &= rdev->desc->enable_mask;
> +
> +	if (rdev->desc->enable_is_inverted) {
> +		if (rdev->desc->enable_val)
> +			return val != rdev->desc->enable_val;
> +		return (val == 0);
> +	}
> +	if (rdev->desc->enable_val)
> +		return val == rdev->desc->enable_val;
> +	return val != 0;
> +}
> +
> +static unsigned int rk8xx_regulator_of_map_mode(unsigned int mode)
> +{
> +	if (mode == 1)
> +		return REGULATOR_MODE_FAST;
> +	if (mode == 2)
> +		return REGULATOR_MODE_NORMAL;
> +
> +	return -EINVAL;
> +}
> +
>  static struct regulator_ops rk805_reg_ops = {
>  		.list_voltage           = regulator_list_voltage_linear,
>  		.map_voltage            = regulator_map_voltage_linear,
> @@ -433,6 +727,71 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
>  	.set_suspend_disable	= rk808_set_suspend_disable,
>  };
>  
> +static struct regulator_ops rk809_buck5_ops_range = {
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.map_voltage		= regulator_map_voltage_linear_range,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
> +	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
> +	.set_suspend_enable	= rk817_set_suspend_enable,
> +	.set_suspend_disable	= rk817_set_suspend_disable,
> +};
> +
> +static struct regulator_ops rk817_reg_ops = {
> +	.list_voltage		= regulator_list_voltage_linear,
> +	.map_voltage		= regulator_map_voltage_linear,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
> +	.set_suspend_voltage	= rk817_set_suspend_voltage,
> +	.set_suspend_enable	= rk817_set_suspend_enable,
> +	.set_suspend_disable	= rk817_set_suspend_disable,
> +};
> +
> +static struct regulator_ops rk817_boost_ops = {
> +	.list_voltage		= regulator_list_voltage_linear,
> +	.map_voltage		= regulator_map_voltage_linear,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
> +	.set_suspend_enable	= rk817_set_suspend_enable,
> +	.set_suspend_disable	= rk817_set_suspend_disable,
> +};
> +
> +static struct regulator_ops rk817_buck_ops_range = {
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.map_voltage		= regulator_map_voltage_linear_range,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
> +	.set_mode		= rk8xx_set_mode,
> +	.get_mode		= rk8xx_get_mode,
> +	.set_suspend_mode	= rk8xx_set_suspend_mode,
> +	.set_ramp_delay		= rk817_set_ramp_delay,
> +	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
> +	.set_suspend_enable	= rk817_set_suspend_enable,
> +	.set_suspend_disable	= rk817_set_suspend_disable,
> +};
> +
> +static struct regulator_ops rk817_switch_ops = {
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= regulator_is_enabled_regmap,
> +	.set_suspend_enable	= rk817_set_suspend_enable,
> +	.set_suspend_disable	= rk817_set_suspend_disable,
> +};
> +
>  static const struct regulator_desc rk805_reg[] = {
>  	{
>  		.name = "DCDC_REG1",
> @@ -589,6 +948,271 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
>  		RK808_DCDC_EN_REG, BIT(6)),
>  };
>  
> +static const struct regulator_desc rk809_reg[] = {
> +	{
> +		.name = "DCDC_REG1",
> +		.supply_name = "vcc1",
> +		.of_match = of_match_ptr("DCDC_REG1"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK817_ID_DCDC1,
> +		.ops = &rk817_buck_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK817_BUCK1_SEL_CNT + 1,
> +		.linear_ranges = rk817_buck1_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
> +		.vsel_reg = RK817_BUCK1_ON_VSEL_REG,
> +		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(0),
> +		.enable_mask = ENABLE_MASK(RK817_ID_DCDC1),
> +		.enable_val = ENABLE_MASK(RK817_ID_DCDC1),
> +		.disable_val = DISABLE_VAL(RK817_ID_DCDC1),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	}, {
> +		.name = "DCDC_REG2",
> +		.supply_name = "vcc2",
> +		.of_match = of_match_ptr("DCDC_REG2"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK817_ID_DCDC2,
> +		.ops = &rk817_buck_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK817_BUCK1_SEL_CNT + 1,
> +		.linear_ranges = rk817_buck1_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
> +		.vsel_reg = RK817_BUCK2_ON_VSEL_REG,
> +		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(0),
> +		.enable_mask = ENABLE_MASK(RK817_ID_DCDC2),
> +		.enable_val = ENABLE_MASK(RK817_ID_DCDC2),
> +		.disable_val = DISABLE_VAL(RK817_ID_DCDC2),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	}, {
> +		.name = "DCDC_REG3",
> +		.supply_name = "vcc3",
> +		.of_match = of_match_ptr("DCDC_REG3"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK817_ID_DCDC3,
> +		.ops = &rk817_buck_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK817_BUCK1_SEL_CNT + 1,
> +		.linear_ranges = rk817_buck1_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
> +		.vsel_reg = RK817_BUCK3_ON_VSEL_REG,
> +		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(0),
> +		.enable_mask = ENABLE_MASK(RK817_ID_DCDC3),
> +		.enable_val = ENABLE_MASK(RK817_ID_DCDC3),
> +		.disable_val = DISABLE_VAL(RK817_ID_DCDC3),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	}, {
> +		.name = "DCDC_REG4",
> +		.supply_name = "vcc4",
> +		.of_match = of_match_ptr("DCDC_REG4"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK817_ID_DCDC4,
> +		.ops = &rk817_buck_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK817_BUCK3_SEL_CNT + 1,
> +		.linear_ranges = rk817_buck3_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk817_buck3_voltage_ranges),
> +		.vsel_reg = RK817_BUCK4_ON_VSEL_REG,
> +		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(0),
> +		.enable_mask = ENABLE_MASK(RK817_ID_DCDC4),
> +		.enable_val = ENABLE_MASK(RK817_ID_DCDC4),
> +		.disable_val = DISABLE_VAL(RK817_ID_DCDC4),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	},
> +	{
> +		.name = "DCDC_REG5",
> +		.supply_name = "vcc9",
> +		.of_match = of_match_ptr("DCDC_REG5"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK809_ID_DCDC5,
> +		.ops = &rk809_buck5_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK809_BUCK5_SEL_CNT,
> +		.linear_ranges = rk809_buck5_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk809_buck5_voltage_ranges),
> +		.vsel_reg = RK809_BUCK5_CONFIG(0),
> +		.vsel_mask = RK809_BUCK5_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(3),
> +		.enable_mask = ENABLE_MASK(1),
> +		.enable_val = ENABLE_MASK(1),
> +		.disable_val = DISABLE_VAL(1),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	},
> +	RK817_DESC(RK817_ID_LDO1, "LDO_REG1", "vcc5", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(0), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(1), ENABLE_MASK(0), ENABLE_MASK(0),
> +		   DISABLE_VAL(0), 400),
> +	RK817_DESC(RK817_ID_LDO2, "LDO_REG2", "vcc5", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(1), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(1), ENABLE_MASK(1), ENABLE_MASK(1),
> +		   DISABLE_VAL(1), 400),
> +	RK817_DESC(RK817_ID_LDO3, "LDO_REG3", "vcc5", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(2), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(1), ENABLE_MASK(2), ENABLE_MASK(2),
> +		   DISABLE_VAL(2), 400),
> +	RK817_DESC(RK817_ID_LDO4, "LDO_REG4", "vcc6", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(3), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(1), ENABLE_MASK(3), ENABLE_MASK(3),
> +		   DISABLE_VAL(3), 400),
> +	RK817_DESC(RK817_ID_LDO5, "LDO_REG5", "vcc6", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(4), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(2), ENABLE_MASK(0), ENABLE_MASK(0),
> +		   DISABLE_VAL(0), 400),
> +	RK817_DESC(RK817_ID_LDO6, "LDO_REG6", "vcc6", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(5), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(2), ENABLE_MASK(1), ENABLE_MASK(1),
> +		   DISABLE_VAL(1), 400),
> +	RK817_DESC(RK817_ID_LDO7, "LDO_REG7", "vcc7", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(6), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(2), ENABLE_MASK(2), ENABLE_MASK(2),
> +		   DISABLE_VAL(2), 400),
> +	RK817_DESC(RK817_ID_LDO8, "LDO_REG8", "vcc7", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(7), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(2), ENABLE_MASK(3), ENABLE_MASK(3),
> +		   DISABLE_VAL(3), 400),
> +	RK817_DESC(RK817_ID_LDO9, "LDO_REG9", "vcc7", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(8), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(3), ENABLE_MASK(0), ENABLE_MASK(0),
> +		   DISABLE_VAL(0), 400),
> +	RK817_DESC_SWITCH(RK809_ID_SW1, "SWITCH_REG1", "vcc9",
> +			  RK817_POWER_EN_REG(3), ENABLE_MASK(2),
> +			  ENABLE_MASK(2), DISABLE_VAL(2)),
> +	RK817_DESC_SWITCH(RK809_ID_SW2, "SWITCH_REG2", "vcc8",
> +			  RK817_POWER_EN_REG(3), ENABLE_MASK(3),
> +			  ENABLE_MASK(3), DISABLE_VAL(3)),
> +};
> +
> +static const struct regulator_desc rk817_reg[] = {
> +	{
> +		.name = "DCDC_REG1",
> +		.supply_name = "vcc1",
> +		.of_match = of_match_ptr("DCDC_REG1"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK817_ID_DCDC1,
> +		.ops = &rk817_buck_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK817_BUCK1_SEL_CNT + 1,
> +		.linear_ranges = rk817_buck1_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
> +		.vsel_reg = RK817_BUCK1_ON_VSEL_REG,
> +		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(0),
> +		.enable_mask = ENABLE_MASK(RK817_ID_DCDC1),
> +		.enable_val = ENABLE_MASK(RK817_ID_DCDC1),
> +		.disable_val = DISABLE_VAL(RK817_ID_DCDC1),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	}, {
> +		.name = "DCDC_REG2",
> +		.supply_name = "vcc2",
> +		.of_match = of_match_ptr("DCDC_REG2"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK817_ID_DCDC2,
> +		.ops = &rk817_buck_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK817_BUCK1_SEL_CNT + 1,
> +		.linear_ranges = rk817_buck1_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
> +		.vsel_reg = RK817_BUCK2_ON_VSEL_REG,
> +		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(0),
> +		.enable_mask = ENABLE_MASK(RK817_ID_DCDC2),
> +		.enable_val = ENABLE_MASK(RK817_ID_DCDC2),
> +		.disable_val = DISABLE_VAL(RK817_ID_DCDC2),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	}, {
> +		.name = "DCDC_REG3",
> +		.supply_name = "vcc3",
> +		.of_match = of_match_ptr("DCDC_REG3"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK817_ID_DCDC3,
> +		.ops = &rk817_buck_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK817_BUCK1_SEL_CNT + 1,
> +		.linear_ranges = rk817_buck1_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
> +		.vsel_reg = RK817_BUCK3_ON_VSEL_REG,
> +		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(0),
> +		.enable_mask = ENABLE_MASK(RK817_ID_DCDC3),
> +		.enable_val = ENABLE_MASK(RK817_ID_DCDC3),
> +		.disable_val = DISABLE_VAL(RK817_ID_DCDC3),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	}, {
> +		.name = "DCDC_REG4",
> +		.supply_name = "vcc4",
> +		.of_match = of_match_ptr("DCDC_REG4"),
> +		.regulators_node = of_match_ptr("regulators"),
> +		.id = RK817_ID_DCDC4,
> +		.ops = &rk817_buck_ops_range,
> +		.type = REGULATOR_VOLTAGE,
> +		.n_voltages = RK817_BUCK3_SEL_CNT + 1,
> +		.linear_ranges = rk817_buck3_voltage_ranges,
> +		.n_linear_ranges = ARRAY_SIZE(rk817_buck3_voltage_ranges),
> +		.vsel_reg = RK817_BUCK4_ON_VSEL_REG,
> +		.vsel_mask = RK817_BUCK_VSEL_MASK,
> +		.enable_reg = RK817_POWER_EN_REG(0),
> +		.enable_mask = ENABLE_MASK(RK817_ID_DCDC4),
> +		.enable_val = ENABLE_MASK(RK817_ID_DCDC4),
> +		.disable_val = DISABLE_VAL(RK817_ID_DCDC4),
> +		.of_map_mode = rk8xx_regulator_of_map_mode,
> +		.owner = THIS_MODULE,
> +	},
> +	RK817_DESC(RK817_ID_LDO1, "LDO_REG1", "vcc5", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(0), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(1), ENABLE_MASK(0), ENABLE_MASK(0),
> +		   DISABLE_VAL(0), 400),
> +	RK817_DESC(RK817_ID_LDO2, "LDO_REG2", "vcc5", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(1), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(1), ENABLE_MASK(1), ENABLE_MASK(1),
> +		   DISABLE_VAL(1), 400),
> +	RK817_DESC(RK817_ID_LDO3, "LDO_REG3", "vcc5", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(2), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(1), ENABLE_MASK(2), ENABLE_MASK(2),
> +		   DISABLE_VAL(2), 400),
> +	RK817_DESC(RK817_ID_LDO4, "LDO_REG4", "vcc6", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(3), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(1), ENABLE_MASK(3), ENABLE_MASK(3),
> +		   DISABLE_VAL(3), 400),
> +	RK817_DESC(RK817_ID_LDO5, "LDO_REG5", "vcc6", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(4), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(2), ENABLE_MASK(0), ENABLE_MASK(0),
> +		   DISABLE_VAL(0), 400),
> +	RK817_DESC(RK817_ID_LDO6, "LDO_REG6", "vcc6", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(5), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(2), ENABLE_MASK(1), ENABLE_MASK(1),
> +		   DISABLE_VAL(1), 400),
> +	RK817_DESC(RK817_ID_LDO7, "LDO_REG7", "vcc7", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(6), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(2), ENABLE_MASK(2), ENABLE_MASK(2),
> +		   DISABLE_VAL(2), 400),
> +	RK817_DESC(RK817_ID_LDO8, "LDO_REG8", "vcc7", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(7), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(2), ENABLE_MASK(3), ENABLE_MASK(3),
> +		   DISABLE_VAL(3), 400),
> +	RK817_DESC(RK817_ID_LDO9, "LDO_REG9", "vcc7", 600, 3400, 25,
> +		   RK817_LDO_ON_VSEL_REG(8), RK817_LDO_VSEL_MASK,
> +		   RK817_POWER_EN_REG(3), ENABLE_MASK(0), ENABLE_MASK(0),
> +		   DISABLE_VAL(0), 400),
> +	RK817_BOOST_DESC(RK817_ID_BOOST, "BOOST", "vcc8", 4700, 5400, 100,
> +			 RK817_BOOST_OTG_CFG, RK817_BOOST_VSEL_MASK,
> +			 RK817_POWER_EN_REG(3), ENABLE_MASK(1), ENABLE_MASK(1),
> +		   DISABLE_VAL(1), 400, 3500 - 5400),
> +	RK817_DESC_SWITCH(RK817_ID_BOOST_OTG_SW, "OTG_SWITCH", "vcc9",
> +			  RK817_POWER_EN_REG(3), ENABLE_MASK(2),
> +			  ENABLE_MASK(2), DISABLE_VAL(2)),
> +};
> +
>  static const struct regulator_desc rk818_reg[] = {
>  	{
>  		.name = "DCDC_REG1",
> @@ -759,6 +1383,14 @@ static int rk808_regulator_probe(struct platform_device *pdev)
>  		regulators = rk808_reg;
>  		nregulators = RK808_NUM_REGULATORS;
>  		break;
> +	case RK809_ID:
> +		regulators = rk809_reg;
> +		nregulators = RK809_NUM_REGULATORS;
> +		break;
> +	case RK817_ID:
> +		regulators = rk817_reg;
> +		nregulators = RK817_NUM_REGULATORS;
> +		break;
>  	case RK818_ID:
>  		regulators = rk818_reg;
>  		nregulators = RK818_NUM_REGULATORS;
> @@ -797,6 +1429,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
>  module_platform_driver(rk808_regulator_driver);
>  
>  MODULE_DESCRIPTION("regulator driver for the RK808/RK818 series PMICs");
> +MODULE_AUTHOR("Tony xie <tony.xie@rock-chips.com>");
>  MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
>  MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
>  MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index b973b0a..b4ce2373 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -396,7 +396,10 @@ enum rk805_reg {
>  #define SHUTDOWN_FUN			(0x2 << 2)
>  #define SLEEP_FUN			(0x1 << 2)
>  #define RK8XX_ID_MSK			0xfff0
> +#define PWM_MODE_MSK			BIT(7)
>  #define FPWM_MODE			BIT(7)
> +#define AUTO_PWM_MODE			0
> +
>  enum rk817_reg_id {
>  	RK817_ID_DCDC1 = 0,
>  	RK817_ID_DCDC2,
