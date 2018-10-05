Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33506C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFD321473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="bt9x33rX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFD321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJFB2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:28:49 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:50402 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbeJFB2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:28:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 971FB1F955;
        Fri,  5 Oct 2018 20:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-language:content-transfer-encoding:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:subject:subject:received
        :received; s=dkim; t=1538764128; x=1541356129; bh=TvgjAF8wHE4+YV
        6mTw/HC0WOt0jcRw0Sak/PQnVv80U=; b=bt9x33rXWUHc5HA5dm3ZJN0Zu1UI3N
        5EE04rAkeDCUI7uN6PUW6hX1JJCRC9WTtG85GbeV57XZZU4CNiZA9/G6ZuEDikkY
        5yeykFcmPOsOkTwDmme+wp2swjQ4ZUVecMGDECHjx/sqw6UefzDX9B5Ul7X1CaFV
        yMUP2ypoNKP6Szt20Q160km0nvYu6sg2r4i68JRTrWw9wag84FK9gjZSGLpEgHRJ
        SbtgBKKiWQ72+w8fHu0ZCXmPUsMHqQJ7ugYsQlVOiPLNroFCfDTLzZpp0liIYK5O
        vpLWiZPpCM3Q9adNMubhA91zCCFzLXcLxOGKD/Waor7yY60kBVCvUP0XBz2ZczaM
        enmIeJltCUKefROoIJtAViq9OkRCIXsAxe9Rh5cBNXJYWi+xq+lf++QL1oseI4fG
        zZvn7DYmKsjoE1NUFjDJHCvhtNYllbTRfS+I+ubz8DBCj2pkz5Wt6kGHpV4qiomW
        BW7593ukNea+JgxAoooWnoRbIUZ1eKxa7AJ3lumI3/lkwjtvPApbBYcJCFMuPSkM
        eFKw/r10l4HV6GKzyTrCd4KEP3gOuHFlu8OpsXx8SjslsvoTK1v1Wg4lvRzZ7F51
        hqp/eVn3DRHKz9BabVTDpTIJHCv9ePq4Bw4iRURajPUpNQ92VFPaZtc60h3B1lJm
        MltVPCSFa+nsY=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hn9unTCiP1fz; Fri,  5 Oct 2018 20:28:48 +0200 (CEST)
Received: from [IPv6:2001:998:13:e1::139] (unknown [IPv6:2001:998:13:e1::139])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 6925A1F984;
        Fri,  5 Oct 2018 20:28:47 +0200 (CEST)
Subject: Re: [PATCH 4/4] power: supply: add AXP803/AXP813 AC and battery power
 supply support
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181004193410.7265-5-oskari@lemmela.net>
 <20181005082913.b5pwqa7loyoms2wm@qschulz>
From:   =?UTF-8?Q?Oskari_Lemmel=c3=a4?= <oskari@lemmela.net>
Message-ID: <ccec9405-fd05-e390-f803-f6594d90d824@lemmela.net>
Date:   Fri, 5 Oct 2018 21:28:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005082913.b5pwqa7loyoms2wm@qschulz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 05.10.2018 11:29, Quentin Schulz wrote:
> Hi Oskari,
>
> On Thu, Oct 04, 2018 at 10:34:10PM +0300, Oskari Lemmela wrote:
>> AXP803 PMIC is register compatible with AXP813.
>>
>> Added support for AXP803/AXP813 AC power supply.
>> AXP8x3 is capable to limit input current and minimum input voltage.
>> Both of these register values are writeable.
>>
>> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
>> ---
>>  drivers/iio/adc/axp20x_adc.c           |   1 +
>>  drivers/mfd/axp20x.c                   |  22 ++-
>>  drivers/pinctrl/pinctrl-axp209.c       |   1 +
>>  drivers/power/supply/axp20x_ac_power.c | 194 +++++++++++++++++++++++++
>>  drivers/power/supply/axp20x_battery.c  |   3 +
>>  include/linux/mfd/axp20x.h             |   1 +
>>  6 files changed, 221 insertions(+), 1 deletion(-)
>>
> We usually want one commit per logical change. e.g. here, we would want
> *at least* one commit for the ADC, one for the MFD, one for the pinctrl,
> one for the battery, one for the AC.
This was my very first kernel patch. I was thinking based on git log that
I should split commits even more. Now I know and do this in next versions.
>> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
>> index 5be789269353..f919a16a8533 100644
>> --- a/drivers/iio/adc/axp20x_adc.c
>> +++ b/drivers/iio/adc/axp20x_adc.c
>> @@ -641,6 +641,7 @@ static const struct axp_data axp813_data = {
>>  static const struct of_device_id axp20x_adc_of_match[] = {
>>  	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
>>  	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
>> +	{ .compatible = "x-powers,axp803-adc", .data = (void *)&axp813_data, },
>>  	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
>>  	{ /* sentinel */ }
>>  };
> Then it means AXP813 and AXP803 ADCs are identical. Use the compatible
> of the AXP813, no need to add a compatible for each and every PMIC's ADC
> that'll be compatible with one that already exists.
Understood. I suppose if some feature doesn't work for both models then
we have to do new compatible?
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 0be511dd93d0..c540f17549d5 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
>>  		.name			= "axp221-pek",
>>  		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>>  		.resources		= axp803_pek_resources,
>> +	}, {
>> +		.name			= "axp20x-regulator"
>> +	}, {
>> +		.name			= "axp20x-gpio",
>> +		.of_compatible		= "x-powers,axp803-gpio",
>> +	}, {
>> +		.name			= "axp813-adc",
>> +		.of_compatible		= "x-powers,axp803-adc",
>> +	}, {
>> +		.name		= "axp20x-battery-power-supply",
>> +		.of_compatible	= "x-powers,axp803-battery-power-supply",
>> +	}, {
>> +		.name		= "axp20x-ac-power-supply",
>> +		.of_compatible	= "x-powers,axp803-ac-power-supply",
>> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>> +		.resources	= axp20x_ac_power_supply_resources,
>>  	},
>> -	{	.name			= "axp20x-regulator" },
>>  };
>>  
>>  static const struct mfd_cell axp806_self_working_cells[] = {
>> @@ -778,6 +793,11 @@ static const struct mfd_cell axp813_cells[] = {
>>  	}, {
>>  		.name		= "axp20x-battery-power-supply",
>>  		.of_compatible	= "x-powers,axp813-battery-power-supply",
>> +	}, {
>> +		.name		= "axp20x-ac-power-supply",
>> +		.of_compatible	= "x-powers,axp813-ac-power-supply",
>> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>> +		.resources	= axp20x_ac_power_supply_resources,
>>  	},
>>  };
>>  
>> diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
>> index afd0b533c40a..21859579e0a2 100644
>> --- a/drivers/pinctrl/pinctrl-axp209.c
>> +++ b/drivers/pinctrl/pinctrl-axp209.c
>> @@ -387,6 +387,7 @@ static int axp20x_build_funcs_groups(struct platform_device *pdev)
>>  
>>  static const struct of_device_id axp20x_pctl_match[] = {
>>  	{ .compatible = "x-powers,axp209-gpio", .data = &axp20x_data, },
>> +	{ .compatible = "x-powers,axp803-gpio", .data = &axp813_data, },
>>  	{ .compatible = "x-powers,axp813-gpio", .data = &axp813_data, },
>>  	{ }
>>  };
> Same here. No need for a new compatible.
>
>> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
>> index 0771f951b11f..3247efb81cd1 100644
>> --- a/drivers/power/supply/axp20x_ac_power.c
>> +++ b/drivers/power/supply/axp20x_ac_power.c
>> @@ -27,6 +27,23 @@
>>  #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
>>  #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
>>  
>> +#define AXP8X3_PWR_ACIN_VHOLD		GENMASK(5, 3)
> I would add _MASK at the end to be extra explicit.
Good idea. I'll change that in both places.
>> +#define AXP8X3_PWR_ACIN_VHOLD_4_0V	(0 << 3)
>> +#define AXP8X3_PWR_ACIN_VHOLD_4_1V	(1 << 3)
>> +#define AXP8X3_PWR_ACIN_VHOLD_4_2V	(2 << 3)
>> +#define AXP8X3_PWR_ACIN_VHOLD_4_3V	(3 << 3)
>> +#define AXP8X3_PWR_ACIN_VHOLD_4_4V	(4 << 3)
>> +#define AXP8X3_PWR_ACIN_VHOLD_4_5V	(5 << 3)
>> +#define AXP8X3_PWR_ACIN_VHOLD_4_6V	(6 << 3)
>> +#define AXP8X3_PWR_ACIN_VHOLD_4_7V	(7 << 3)
> You could define a macro for that, e.g.:
> #define AXP8X3_PWR_ACIN_VHOLD_mV_reg(x)	((((x) - 4000) / 100) << 3)
> #define AXP8X3_PWR_ACIN_VHOLD_reg_mV(x)	(((x) >> 3) * 100 + 4000)
>
>> +#define AXP8X3_PWR_ACIN_CURR_LIMIT	GENMASK(2, 0)
> I would add _MASK at the end to be extra explicit.
>
>> +#define AXP8X3_PWR_ACIN_CURR_1_5A	0
>> +#define AXP8X3_PWR_ACIN_CURR_2_0A	1
>> +#define AXP8X3_PWR_ACIN_CURR_2_5A	2
>> +#define AXP8X3_PWR_ACIN_CURR_3_0A	3
>> +#define AXP8X3_PWR_ACIN_CURR_3_5A	4
>> +#define AXP8X3_PWR_ACIN_CURR_4_0A	5
>> +
> #define AXP8X3_PWR_ACIN_CURR_mA_reg(x)	(((x) / 500) - 3)
> #define AXP8X3_PWR_ACIN_CURR_reg_mA(x)	(((x) + 3 ) * 500)
>
> They are not very pretty macro names but I'll let you figure out one
> that are easier to understand :)
>
> Also, you might want to use µA/µV so that it returns directly the value
> wanted by the power-supply subsystem.
Thanks. This way code will be much more compact. I'll try think
better macro names.
>>  #define DRVNAME "axp20x-ac-power-supply"
>>  
>>  struct axp20x_ac_power {
>> @@ -102,6 +119,72 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
>>  
>>  		return 0;
>>  
>> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
>> +		ret = regmap_read(power->regmap, AXP803_ACIN_PATH_CTRL, &reg);
>> +		if (ret)
>> +			return ret;
>> +
> val->intval = AXP8X3_PWR_ACIN_VHOLD_reg_mV(reg & AXP8X3_PWR_ACIN_VHOLD) * 1000;
>
> return 0;
>
>> +		switch (reg & AXP8X3_PWR_ACIN_VHOLD) {
>> +		case AXP8X3_PWR_ACIN_VHOLD_4_0V:
>> +			val->intval = 4000000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_VHOLD_4_1V:
>> +			val->intval = 4100000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_VHOLD_4_2V:
>> +			val->intval = 4200000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_VHOLD_4_3V:
>> +			val->intval = 4300000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_VHOLD_4_4V:
>> +			val->intval = 4400000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_VHOLD_4_5V:
>> +			val->intval = 4500000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_VHOLD_4_6V:
>> +			val->intval = 4600000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_VHOLD_4_7V:
>> +			val->intval = 4700000;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +		return 0;
>> +
>> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +		ret = regmap_read(power->regmap, AXP803_ACIN_PATH_CTRL, &reg);
>> +		if (ret)
>> +			return ret;
>> +
> val->intval = AXP8X3_PWR_ACIN_CURR_reg_mA(reg & AXP8X3_PWR_ACIN_CURR_LIMIT) * 1000;
>
> return 0;
>
>> +		switch (reg & AXP8X3_PWR_ACIN_CURR_LIMIT) {
>> +		case AXP8X3_PWR_ACIN_CURR_1_5A:
>> +			val->intval = 1500000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_CURR_2_0A:
>> +			val->intval = 2000000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_CURR_2_5A:
>> +			val->intval = 2500000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_CURR_3_0A:
>> +			val->intval = 3000000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_CURR_3_5A:
>> +			val->intval = 3500000;
>> +			break;
>> +		case AXP8X3_PWR_ACIN_CURR_4_0A:
>> +			val->intval = 4000000;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +		return 0;
>> +
>>  	default:
>>  		return -EINVAL;
>>  	}
>> @@ -109,6 +192,88 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
>>  	return -EINVAL;
>>  }
>>  
>> +static int axp20x_ac_power_set_property(struct power_supply *psy,
>> +					enum power_supply_property psp,
>> +					const union power_supply_propval *val)
>> +{
>> +	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
>> +	int setval;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
>> +		switch (val->intval) {
>> +		case 4000000:
>> +			setval = AXP8X3_PWR_ACIN_VHOLD_4_0V;
>> +			break;
>> +		case 4100000:
>> +			setval = AXP8X3_PWR_ACIN_VHOLD_4_1V;
>> +			break;
>> +		case 4200000:
>> +			setval = AXP8X3_PWR_ACIN_VHOLD_4_2V;
>> +			break;
>> +		case 4300000:
>> +			setval = AXP8X3_PWR_ACIN_VHOLD_4_3V;
>> +			break;
>> +		case 4400000:
>> +			setval = AXP8X3_PWR_ACIN_VHOLD_4_4V;
>> +			break;
>> +		case 4500000:
>> +			setval = AXP8X3_PWR_ACIN_VHOLD_4_5V;
>> +			break;
>> +		case 4600000:
>> +			setval = AXP8X3_PWR_ACIN_VHOLD_4_6V;
>> +			break;
>> +		case 4700000:
>> +			setval = AXP8X3_PWR_ACIN_VHOLD_4_7V;
>> +			break;
>> +
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
>> +					  AXP8X3_PWR_ACIN_VHOLD, setval);
>> +
> return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
> 			  AXP8X3_PWR_ACIN_VHOLD,
> 			  AXP8X3_PWR_ACIN_VHOLD_mV_reg(val->intval / 1000));
>
>> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +
>> +		switch (val->intval) {
>> +		case 1500000:
>> +			setval = AXP8X3_PWR_ACIN_CURR_1_5A;
>> +			break;
>> +		case 2000000:
>> +			setval = AXP8X3_PWR_ACIN_CURR_2_0A;
>> +			break;
>> +		case 2500000:
>> +			setval = AXP8X3_PWR_ACIN_CURR_2_5A;
>> +			break;
>> +		case 3000000:
>> +			setval = AXP8X3_PWR_ACIN_CURR_3_0A;
>> +			break;
>> +		case 3500000:
>> +			setval = AXP8X3_PWR_ACIN_CURR_3_5A;
>> +			break;
>> +		case 4000000:
>> +			setval = AXP8X3_PWR_ACIN_CURR_4_0A;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
>> +					  AXP8X3_PWR_ACIN_CURR_LIMIT, setval);
> return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
> 			  AXP8X3_PWR_ACIN_CURR_LIMIT,
> 			  AXP8X3_PWR_ACIN_CURR_LIMIT_mA_reg(val->intval / 1000));
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int axp20x_ac_power_prop_writeable(struct power_supply *psy,
>> +					  enum power_supply_property psp)
>> +{
>> +	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
>> +	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
>> +}
>> +
>>  static enum power_supply_property axp20x_ac_power_properties[] = {
>>  	POWER_SUPPLY_PROP_HEALTH,
>>  	POWER_SUPPLY_PROP_PRESENT,
>> @@ -123,6 +288,14 @@ static enum power_supply_property axp22x_ac_power_properties[] = {
>>  	POWER_SUPPLY_PROP_ONLINE,
>>  };
>>  
>> +static enum power_supply_property axp8x3_ac_power_properties[] = {
> I'll let Maxime or Chen-Yu confirm but I think we use the name of the
> first PMIC in the family, so it would be axp813_ac_power_properties
> even if it applies to multiple variants of the PMIC.
Makes sense. I'll replace all axp803,axp8x3 strings with axp813 ones.
>> +	POWER_SUPPLY_PROP_HEALTH,
>> +	POWER_SUPPLY_PROP_PRESENT,
>> +	POWER_SUPPLY_PROP_ONLINE,
>> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
>> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>> +};
>> +
>>  static const struct power_supply_desc axp20x_ac_power_desc = {
>>  	.name = "axp20x-ac",
>>  	.type = POWER_SUPPLY_TYPE_MAINS,
>> @@ -139,6 +312,16 @@ static const struct power_supply_desc axp22x_ac_power_desc = {
>>  	.get_property = axp20x_ac_power_get_property,
>>  };
>>  
>> +static const struct power_supply_desc axp8x3_ac_power_desc = {
>> +	.name = "axp8x3-ac",
>> +	.type = POWER_SUPPLY_TYPE_MAINS,
>> +	.properties = axp8x3_ac_power_properties,
>> +	.num_properties = ARRAY_SIZE(axp8x3_ac_power_properties),
> Naming convention here for the above.
>
>> +	.property_is_writeable = axp20x_ac_power_prop_writeable,
> I think we would want axp813_ac_power_prop_writeable if it's applicable
> only for the AXP813 and not the AXP20X.
Noted.
>> +	.get_property = axp20x_ac_power_get_property,
>> +	.set_property = axp20x_ac_power_set_property,
>> +};
>> +
>>  struct axp_data {
>>  	const struct power_supply_desc	*power_desc;
>>  	bool				acin_adc;
>> @@ -154,6 +337,11 @@ static const struct axp_data axp22x_data = {
>>  	.acin_adc = false,
>>  };
>>  
>> +static const struct axp_data axp8x3_data = {
>> +	.power_desc = &axp8x3_ac_power_desc,
>> +	.acin_adc = false,
>> +};
>> +
>>  static int axp20x_ac_power_probe(struct platform_device *pdev)
>>  {
>>  	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>> @@ -234,6 +422,12 @@ static const struct of_device_id axp20x_ac_power_match[] = {
>>  	}, {
>>  		.compatible = "x-powers,axp221-ac-power-supply",
>>  		.data = &axp22x_data,
>> +	}, {
>> +		.compatible = "x-powers,axp803-ac-power-supply",
>> +		.data = &axp8x3_data,
>> +	}, {
>> +		.compatible = "x-powers,axp813-ac-power-supply",
>> +		.data = &axp8x3_data,
> So AXP813 and AXP803 AC drivers are identical, use the same compatible,
> no need to add two.
>
>>  	}, { /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
>> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
>> index e84b6e4da14a..932027f4a993 100644
>> --- a/drivers/power/supply/axp20x_battery.c
>> +++ b/drivers/power/supply/axp20x_battery.c
>> @@ -537,6 +537,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
>>  	}, {
>>  		.compatible = "x-powers,axp221-battery-power-supply",
>>  		.data = (void *)&axp221_data,
>> +	}, {
>> +		.compatible = "x-powers,axp803-battery-power-supply",
>> +		.data = (void *)&axp813_data,
> Ditto.
>
>>  	}, {
>>  		.compatible = "x-powers,axp813-battery-power-supply",
>>  		.data = (void *)&axp813_data,
>> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
>> index 517e60eecbcb..23d58e243d01 100644
>> --- a/include/linux/mfd/axp20x.h
>> +++ b/include/linux/mfd/axp20x.h
>> @@ -266,6 +266,7 @@ enum axp20x_variants {
>>  #define AXP288_RT_BATT_V_H		0xa0
>>  #define AXP288_RT_BATT_V_L		0xa1
>>  
>> +#define AXP803_ACIN_PATH_CTRL		0x3a
>>  #define AXP813_ADC_RATE			0x85
>>  
> Basically, the only changes you need to keep are those in
> drivers/power/supply/axp20x_ac_power.c and include/linux/mfd/axp20x.h.
>
> Thanks,
> Quentin
I'll refactor code and commits based on these comments.

Thanks,
Oskari
