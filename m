Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F909C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F18C20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vk/X7srB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F18C20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeIKQqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:46:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37397 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeIKQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:46:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so640823wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hrJKL1wQs1fjbtygpB7udJOGAaD8J9J8ONcuZZG87ZA=;
        b=Vk/X7srB6hknpRlINeiy60VmiXtRzWG7+ZdDHDkeoflABsvjyC41AqSohr6l2Nh5w3
         IPk1K+gRREmYp8w7u0wRULSREW9bjCCRIIFH4kiDThho9BddB1dy0xaVemsjnBcNO6uy
         4YNn8/83sNP/kBlS5MpqpEHlI3Z2mzFC4oHEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hrJKL1wQs1fjbtygpB7udJOGAaD8J9J8ONcuZZG87ZA=;
        b=Xt80LjTjXcFW6tUkYTuSCq53wKPadTL4uIA1LyoA/lIO9ldqttoeXpw2JXQWJ3zWeG
         wUSFyHUlRVKVoKuPACKoMT4xhbph0o3L8X+OQD/NZBviNa4nM0jmk/D1/MPEIiGhH8qG
         DCj3xZySRXZrUqOs/+N4PU+Om2FrEe9KmaQSkVGC6IWYJda1fv++jty2SGjlicr99dUG
         yVZnN55Mf/7p6DrnwJfV+UI2/2E5CPgmjcABjf4xBvm/OBYHLYTx4mONVom6N3k0lOb0
         ll0ZDIhsZ2Y5Jmn/AKHBbH5UEA/IKErv94lN3ZsUiYZ2Rndf/Tnlx5PLfDsh/tjLcehq
         pZJA==
X-Gm-Message-State: APzg51A5UmsTdOHl0QpSAmwnpRqv6OMqg0q42UISnvHDe3PGbaRAqJ6y
        55Uz+Lh4UHO4W0FmlpTUQEw6jA==
X-Google-Smtp-Source: ANB0Vda6HJloaOH0WvNkrokX8b6FSZnjzu7a+2AZsPHj+g97TeqbRmCjEv/gaH4hUciTUO8zpiSa0Q==
X-Received: by 2002:a1c:1584:: with SMTP id 126-v6mr1119834wmv.24.1536666455623;
        Tue, 11 Sep 2018 04:47:35 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id y17-v6sm21638362wrh.49.2018.09.11.04.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 04:47:34 -0700 (PDT)
Date:   Tue, 11 Sep 2018 12:47:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 1/5] mfd: rk808: Add RK817 and RK809 support
Message-ID: <20180911114732.GL4185@dell>
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081441-20718-2-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535081441-20718-2-git-send-email-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018, Tony Xie wrote:

>     The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>     and handheld devices. It contains the following components:
> 
>         - Regulators
>         - RTC
>         - Clocking
> 
>     Both RK809 and RK817 chips are using a similar register map,
>     so we can reuse the RTC and Clocking and regulators functionality.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>  drivers/mfd/Kconfig       |   6 +-
>  drivers/mfd/rk808.c       | 218 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++++
>  kernel/reboot.c           |   1 +
>  4 files changed, 391 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5..84f2f22 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -967,14 +967,14 @@ config MFD_RC5T583
>  	  different functionality of the device.
>  
>  config MFD_RK808
> -	tristate "Rockchip RK805/RK808/RK818 Power Management Chip"
> +	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power Management Chip"
>  	depends on I2C && OF
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
>  	help
> -	  If you say yes here you get support for the RK805, RK808 and RK818
> -	  Power Management chips.
> +	  If you say yes here you get support for the RK805, RK809 and RK817,
> +	  RK808 and RK818 Power Management chips.

Any reason why you've taken these out of order?

>  	  This driver provides common support for accessing the device
>  	  through I2C interface. The device supports multiple sub-devices
>  	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 216fbf6..62e2fe1 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -62,6 +62,29 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  	return false;
>  }
>  
> +static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * Notes:
> +	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
> +	 *   we don't use that feature.  It's better to cache.
> +	 * - It's unlikely we care that RK808_DEVCTRL_REG is volatile since
> +	 *   bits are cleared in case when we shutoff anyway, but better safe.
> +	 */
> +
> +	switch (reg) {
> +	case RK817_SECONDS_REG ... RK817_WEEKS_REG:
> +	case RK817_RTC_STATUS_REG:
> +	case RK817_INT_STS_REG0:
> +	case RK817_INT_STS_REG1:
> +	case RK817_INT_STS_REG2:
> +	case RK817_SYS_STS:
> +		return true;
> +	}
> +
> +	return true;
> +}
> +
>  static const struct regmap_config rk818_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -86,6 +109,14 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  	.volatile_reg = rk808_is_volatile_reg,
>  };
>  
> +static const struct regmap_config rk817_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RK817_GPIO_INT_CFG,
> +	.cache_type = REGCACHE_NONE,
> +	.volatile_reg = rk817_is_volatile_reg,
> +};
> +
>  static struct resource rtc_resources[] = {
>  	{
>  		.start  = RK808_IRQ_RTC_ALARM,
> @@ -94,6 +125,13 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  	}
>  };
>  
> +static struct resource rk817_rtc_resources[] = {
> +	{
> +		.start  = RK817_IRQ_RTC_ALARM,
> +		.end    = RK817_IRQ_RTC_ALARM,
> +		.flags  = IORESOURCE_IRQ,
> +	}
> +};
>  static struct resource rk805_key_resources[] = {
>  	{
>  		.start  = RK805_IRQ_PWRON_FALL,
> @@ -107,6 +145,19 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  	}
>  };
>  
> +static struct resource rk817_pwrkey_resources[] = {
> +	{
> +		.start  = RK817_IRQ_PWRON_RISE,
> +		.end    = RK817_IRQ_PWRON_RISE,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start  = RK817_IRQ_PWRON_FALL,
> +		.end    = RK817_IRQ_PWRON_FALL,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
>  static const struct mfd_cell rk805s[] = {
>  	{ .name = "rk808-clkout", },
>  	{ .name = "rk808-regulator", },
> @@ -132,6 +183,21 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  	},
>  };
>  
> +static const struct mfd_cell rk817s[] = {
> +	{ .name = "rk808-clkout",},
> +	{ .name = "rk808-regulator",},
> +	{
> +		.name = "rk8xx-pwrkey",
> +		.num_resources = ARRAY_SIZE(rk817_pwrkey_resources),
> +		.resources = &rk817_pwrkey_resources[0],
> +	},
> +	{
> +		.name = "rk808-rtc",
> +		.num_resources = ARRAY_SIZE(rk817_rtc_resources),
> +		.resources = &rk817_rtc_resources[0],
> +	},
> +};
> +
>  static const struct mfd_cell rk818s[] = {
>  	{ .name = "rk808-clkout", },
>  	{ .name = "rk808-regulator", },
> @@ -167,6 +233,13 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  						    VB_LO_SEL_3500MV },
>  };
>  
> +static const struct rk808_reg_data rk817_pre_init_reg[] = {
> +	{RK817_RTC_CTRL_REG, RTC_STOP, RTC_STOP},
> +	{RK817_GPIO_INT_CFG, RK817_INT_POL_MSK, RK817_INT_POL_H},
> +	{RK817_SYS_CFG(1), RK817_HOTDIE_TEMP_MSK | RK817_TSD_TEMP_MSK,
> +					   RK817_HOTDIE_105 | RK817_TSD_140},
> +};
> +
>  static const struct rk808_reg_data rk818_pre_init_reg[] = {
>  	/* improve efficiency */
>  	{ RK818_BUCK2_CONFIG_REG, BUCK2_RATE_MASK,  BUCK_ILMIN_250MA },
> @@ -332,6 +405,39 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  	},
>  };
>  
> +#define REGMAP_IRQ_M(_id) \
> +	[_id] = {				\
> +		.mask = BIT(((_id) % 8)),	\
> +		.reg_offset = ((_id) / 8),	\
> +	}

If this is helpful for you, it will be helpful for others.

Please submit this to the Regmap subsystem.

See: include/linux/regmap.h

> +static const struct regmap_irq rk817_irqs[RK817_IRQ_END] = {
> +	REGMAP_IRQ_M(0),
> +	REGMAP_IRQ_M(1),
> +	REGMAP_IRQ_M(2),
> +	REGMAP_IRQ_M(3),
> +	REGMAP_IRQ_M(4),
> +	REGMAP_IRQ_M(5),
> +	REGMAP_IRQ_M(6),
> +	REGMAP_IRQ_M(7),
> +	REGMAP_IRQ_M(8),
> +	REGMAP_IRQ_M(9),
> +	REGMAP_IRQ_M(10),
> +	REGMAP_IRQ_M(11),
> +	REGMAP_IRQ_M(12),
> +	REGMAP_IRQ_M(13),
> +	REGMAP_IRQ_M(14),
> +	REGMAP_IRQ_M(15),
> +	REGMAP_IRQ_M(16),
> +	REGMAP_IRQ_M(17),
> +	REGMAP_IRQ_M(18),
> +	REGMAP_IRQ_M(19),
> +	REGMAP_IRQ_M(20),
> +	REGMAP_IRQ_M(21),
> +	REGMAP_IRQ_M(22),
> +	REGMAP_IRQ_M(23)
> +};
> +
>  static struct regmap_irq_chip rk805_irq_chip = {
>  	.name = "rk805",
>  	.irqs = rk805_irqs,
> @@ -355,6 +461,18 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  	.init_ack_masked = true,
>  };
>  
> +static struct regmap_irq_chip rk817_irq_chip = {
> +	.name = "rk817",
> +	.irqs = rk817_irqs,
> +	.num_irqs = ARRAY_SIZE(rk817_irqs),
> +	.num_regs = 3,
> +	.irq_reg_stride = 2,
> +	.status_base = RK817_INT_STS_REG0,
> +	.mask_base = RK817_INT_STS_MSK_REG0,
> +	.ack_base = RK817_INT_STS_REG0,
> +	.init_ack_masked = true,
> +};
> +
>  static const struct regmap_irq_chip rk818_irq_chip = {
>  	.name = "rk818",
>  	.irqs = rk818_irqs,
> @@ -423,9 +541,39 @@ static void rk818_device_shutdown(void)
>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>  }
>  
> +static void rk8xx_device_shutdown_prepare(void)
> +{
> +	int ret;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +
> +	if (!rk808) {
> +		dev_warn(&rk808_i2c_client->dev,
> +			 "have no rk808, so do nothing here\n");

This isn't a good warning to an end user.

Where is "here"?

Please provide something a little more forthcoming/descriptive.

> +		return;
> +	}
> +
> +	switch (rk808->variant) {
> +	case RK809_ID:
> +	case RK817_ID:
> +		ret = regmap_update_bits(rk808->regmap,
> +					 RK817_SYS_CFG(3),
> +					 RK817_SLPPIN_FUNC_MSK,
> +					 SLPPIN_DN_FUN);
> +		if (ret) {
> +			dev_warn(&rk808_i2c_client->dev,
> +				 "switch pin func to power down error!\n");

Again, what does this mean to an end user?  Probably very little.

> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static const struct of_device_id rk808_of_match[] = {
>  	{ .compatible = "rockchip,rk805" },
>  	{ .compatible = "rockchip,rk808" },
> +	{ .compatible = "rockchip,rk809" },
> +	{ .compatible = "rockchip,rk817" },
>  	{ .compatible = "rockchip,rk818" },
>  	{ },
>  };
> @@ -438,10 +586,11 @@ static int rk808_probe(struct i2c_client *client,
>  	struct rk808 *rk808;
>  	const struct rk808_reg_data *pre_init_reg;
>  	const struct mfd_cell *cells;
> -	void (*pm_pwroff_fn)(void);
> +	void (*pm_pwroff_fn)(void) = NULL;
>  	int nr_pre_init_regs;
>  	int nr_cells;
>  	int pm_off = 0, msb, lsb;
> +	unsigned char pmic_id_msb = RK808_ID_MSB, pmic_id_lsb = RK808_ID_LSB;

Please place these on separate lines.

>  	int ret;
>  	int i;
>  
> @@ -449,15 +598,20 @@ static int rk808_probe(struct i2c_client *client,
>  	if (!rk808)
>  		return -ENOMEM;
>  
> +	if (of_device_is_compatible(np, "rockchip,rk817") ||
> +	    of_device_is_compatible(np, "rockchip,rk809")) {
> +		pmic_id_msb = RK817_ID_MSB;
> +		pmic_id_lsb = RK817_ID_LSB;
> +	}

Rather than pre-assign default values at declaration, I think it would
be cleaner to have an else here.

>  	/* Read chip variant */
> -	msb = i2c_smbus_read_byte_data(client, RK808_ID_MSB);
> +	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
>  	if (msb < 0) {
>  		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
>  			RK808_ID_MSB);
>  		return msb;
>  	}
>  
> -	lsb = i2c_smbus_read_byte_data(client, RK808_ID_LSB);
> +	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
>  	if (lsb < 0) {
>  		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
>  			RK808_ID_LSB);
> @@ -495,6 +649,16 @@ static int rk808_probe(struct i2c_client *client,
>  		nr_cells = ARRAY_SIZE(rk818s);
>  		pm_pwroff_fn = rk818_device_shutdown;
>  		break;
> +	case RK809_ID:
> +	case RK817_ID:
> +		rk808->regmap_cfg = &rk817_regmap_config;
> +		rk808->regmap_irq_chip = &rk817_irq_chip;
> +		pre_init_reg = rk817_pre_init_reg;
> +		nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
> +		cells = rk817s;
> +		nr_cells = ARRAY_SIZE(rk817s);
> +		pm_power_off_prepare = rk8xx_device_shutdown_prepare;
> +		break;
>  	default:
>  		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
>  			rk808->variant);
> @@ -568,9 +732,56 @@ static int rk808_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int rk8xx_suspend(struct device *dev)
> +{
> +	int ret = 0;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +
> +	switch (rk808->variant) {
> +	case RK809_ID:
> +	case RK817_ID:
> +		ret = regmap_update_bits(rk808->regmap,
> +					 RK817_SYS_CFG(3),
> +					 RK817_SLPPIN_FUNC_MSK,
> +					 SLPPIN_SLP_FUN);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int rk8xx_resume(struct device *dev)
> +{
> +	int ret = 0;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +
> +	switch (rk808->variant) {
> +	case RK809_ID:
> +	case RK817_ID:
> +		ret = regmap_update_bits(rk808->regmap,
> +					 RK817_SYS_CFG(3),
> +					 RK817_SLPPIN_FUNC_MSK,
> +					 SLPPIN_NULL_FUN);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops rk8xx_pm_ops = {
> +	.suspend = rk8xx_suspend,
> +	.resume =  rk8xx_resume,
> +};

Looks like you want SIMPLE_DEV_PM_OPS() here.

>  static const struct i2c_device_id rk808_ids[] = {
>  	{ "rk805" },
>  	{ "rk808" },
> +	{ "rk809" },
> +	{ "rk817" },
>  	{ "rk818" },
>  	{ },
>  };

I don't think this table is required anymore.

Try removing it.

> @@ -580,6 +791,7 @@ static int rk808_remove(struct i2c_client *client)
>  	.driver = {
>  		.name = "rk808",
>  		.of_match_table = rk808_of_match,
> +		.pm = &rk8xx_pm_ops,
>  	},
>  	.probe    = rk808_probe,
>  	.remove   = rk808_remove,
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index d315659..b973b0a 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -382,6 +382,7 @@ enum rk805_reg {
>  #define SWITCH1_EN	BIT(5)
>  #define DEV_OFF_RST	BIT(3)
>  #define DEV_OFF		BIT(0)
> +#define RTC_STOP	BIT(0)
>  
>  #define VB_LO_ACT		BIT(4)
>  #define VB_LO_SEL_3500MV	(7 << 0)
> @@ -396,6 +397,175 @@ enum rk805_reg {
>  #define SLEEP_FUN			(0x1 << 2)
>  #define RK8XX_ID_MSK			0xfff0
>  #define FPWM_MODE			BIT(7)
> +enum rk817_reg_id {
> +	RK817_ID_DCDC1 = 0,
> +	RK817_ID_DCDC2,
> +	RK817_ID_DCDC3,
> +	RK817_ID_DCDC4,
> +	RK817_ID_LDO1,
> +	RK817_ID_LDO2,
> +	RK817_ID_LDO3,
> +	RK817_ID_LDO4,
> +	RK817_ID_LDO5,
> +	RK817_ID_LDO6,
> +	RK817_ID_LDO7,
> +	RK817_ID_LDO8,
> +	RK817_ID_LDO9,
> +	RK817_ID_BOOST,
> +	RK817_ID_BOOST_OTG_SW,
> +	RK817_NUM_REGULATORS
> +};
> +
> +enum rk809_reg_id {
> +	RK809_ID_DCDC5 = RK817_ID_BOOST,
> +	RK809_ID_SW1,
> +	RK809_ID_SW2,
> +	RK809_NUM_REGULATORS
> +};
> +
> +#define RK817_SECONDS_REG		0x00
> +#define RK817_MINUTES_REG		0x01
> +#define RK817_HOURS_REG			0x02
> +#define RK817_DAYS_REG			0x03
> +#define RK817_MONTHS_REG		0x04
> +#define RK817_YEARS_REG			0x05
> +#define RK817_WEEKS_REG			0x06
> +#define RK817_ALARM_SECONDS_REG		0x07
> +#define RK817_ALARM_MINUTES_REG		0x08
> +#define RK817_ALARM_HOURS_REG		0x09
> +#define RK817_ALARM_DAYS_REG		0x0a
> +#define RK817_ALARM_MONTHS_REG		0x0b
> +#define RK817_ALARM_YEARS_REG		0x0c
> +#define RK817_RTC_CTRL_REG		0xd
> +#define RK817_RTC_STATUS_REG		0xe
> +#define RK817_RTC_INT_REG		0xf
> +#define RK817_RTC_COMP_LSB_REG		0x10
> +#define RK817_RTC_COMP_MSB_REG		0x11
> +
> +#define RK817_POWER_EN_REG(i)		(0xb1 + (i))
> +#define RK817_POWER_SLP_EN_REG(i)	(0xb5 + (i))
> +
> +#define RK817_POWER_CONFIG		(0xb9)
> +
> +#define RK817_BUCK_CONFIG_REG(i)	(0xba + (i) * 3)
> +
> +#define RK817_BUCK1_ON_VSEL_REG		0xBB
> +#define RK817_BUCK1_SLP_VSEL_REG	0xBC
> +
> +#define RK817_BUCK2_CONFIG_REG		0xBD
> +#define RK817_BUCK2_ON_VSEL_REG		0xBE
> +#define RK817_BUCK2_SLP_VSEL_REG	0xBF
> +
> +#define RK817_BUCK3_CONFIG_REG		0xC0
> +#define RK817_BUCK3_ON_VSEL_REG		0xC1
> +#define RK817_BUCK3_SLP_VSEL_REG	0xC2
> +
> +#define RK817_BUCK4_CONFIG_REG		0xC3
> +#define RK817_BUCK4_ON_VSEL_REG		0xC4
> +#define RK817_BUCK4_SLP_VSEL_REG	0xC5
> +
> +#define RK817_LDO_ON_VSEL_REG(idx)	(0xcc + (idx) * 2)
> +#define RK817_BOOST_OTG_CFG		(0xde)
> +
> +#define RK817_ID_MSB			0xed
> +#define RK817_ID_LSB			0xee
> +
> +#define RK817_SYS_STS			0xf0
> +#define RK817_SYS_CFG(i)		(0xf1 + (i))
> +
> +#define RK817_ON_SOURCE_REG		0xf5
> +#define RK817_OFF_SOURCE_REG		0xf6
> +
> +/* INTERRUPT REGISTER */
> +#define RK817_INT_STS_REG0		0xf8
> +#define RK817_INT_STS_MSK_REG0		0xf9
> +#define RK817_INT_STS_REG1		0xfa
> +#define RK817_INT_STS_MSK_REG1		0xfb
> +#define RK817_INT_STS_REG2		0xfc
> +#define RK817_INT_STS_MSK_REG2		0xfd
> +#define RK817_GPIO_INT_CFG		0xfe
> +
> +/* IRQ Definitions */
> +#define RK817_IRQ_PWRON_FALL		0
> +#define RK817_IRQ_PWRON_RISE		1
> +#define RK817_IRQ_PWRON			2
> +#define RK817_IRQ_PWMON_LP		3
> +#define RK817_IRQ_HOTDIE		4
> +#define RK817_IRQ_RTC_ALARM		5
> +#define RK817_IRQ_RTC_PERIOD		6
> +#define RK817_IRQ_VB_LO			7
> +#define RK817_IRQ_PLUG_IN		(8 + 0)
> +#define RK817_IRQ_PLUG_OUT		(8 + 1)
> +#define RK817_IRQ_CHRG_TERM		(8 + 2)
> +#define RK817_IRQ_CHRG_TIME		(8 + 3)
> +#define RK817_IRQ_CHRG_TS		(8 + 4)
> +#define RK817_IRQ_USB_OV		(8 + 5)
> +#define RK817_IRQ_CHRG_IN_CLMP		(8 + 6)
> +#define RK817_IRQ_BAT_DIS_ILIM		(8 + 7)
> +#define RK817_IRQ_GATE_GPIO		(16 + 0)
> +#define RK817_IRQ_TS_GPIO		(16 + 1)
> +#define RK817_IRQ_CODEC_PD		(16 + 2)
> +#define RK817_IRQ_CODEC_PO		(16 + 3)
> +#define RK817_IRQ_CLASSD_MUTE_DONE	(16 + 4)
> +#define RK817_IRQ_CLASSD_OCP		(16 + 5)
> +#define RK817_IRQ_BAT_OVP		(16 + 6)
> +#define RK817_IRQ_CHRG_BAT_HI		(16 + 7)
> +#define RK817_IRQ_END			(RK817_IRQ_CHRG_BAT_HI + 1)
> +
> +/*
> + * rtc_ctrl 0xd
> + * same as 808, except bit4
> + */
> +#define RK817_RTC_CTRL_RSV4		BIT(4)
> +
> +/* power config 0xb9 */
> +#define RK817_BUCK3_FB_RES_MSK		BIT(6)
> +#define RK817_BUCK3_FB_RES_INTER	BIT(6)
> +#define RK817_BUCK3_FB_RES_EXT		0
> +
> +/* buck config 0xba */
> +#define RK817_RAMP_RATE_OFFSET		6
> +#define RK817_RAMP_RATE_MASK		(0x3 << RK817_RAMP_RATE_OFFSET)
> +#define RK817_RAMP_RATE_3MV_PER_US	(0x0 << RK817_RAMP_RATE_OFFSET)
> +#define RK817_RAMP_RATE_6_3MV_PER_US	(0x1 << RK817_RAMP_RATE_OFFSET)
> +#define RK817_RAMP_RATE_12_5MV_PER_US	(0x2 << RK817_RAMP_RATE_OFFSET)
> +#define RK817_RAMP_RATE_25MV_PER_US	(0x3 << RK817_RAMP_RATE_OFFSET)
> +
> +/* sys_cfg1 0xf2 */
> +#define RK817_HOTDIE_TEMP_MSK		(0x3 << 4)
> +#define RK817_HOTDIE_85			(0x0 << 4)
> +#define RK817_HOTDIE_95			(0x1 << 4)
> +#define RK817_HOTDIE_105		(0x2 << 4)
> +#define RK817_HOTDIE_115		(0x3 << 4)
> +
> +#define RK817_TSD_TEMP_MSK		BIT(6)
> +#define RK817_TSD_140			0
> +#define RK817_TSD_160			BIT(6)
> +
> +#define RK817_CLK32KOUT2_EN		BIT(7)
> +
> +/* sys_cfg3 0xf4 */
> +#define RK817_SLPPIN_FUNC_MSK		(0x3 << 3)
> +#define SLPPIN_NULL_FUN			(0x0 << 3)
> +#define SLPPIN_SLP_FUN			(0x1 << 3)
> +#define SLPPIN_DN_FUN			(0x2 << 3)
> +#define SLPPIN_RST_FUN			(0x3 << 3)
> +
> +#define RK817_RST_FUNC_MSK		(0x3 << 6)
> +#define RK817_RST_FUNC_SFT		(6)
> +#define RK817_RST_FUNC_CNT		(3)
> +#define RK817_RST_FUNC_DEV		(0) /* reset the dev */
> +#define RK817_RST_FUNC_REG		(0x1 << 6) /* reset the reg only */
> +
> +#define RK817_SLPPOL_MSK		BIT(5)
> +#define RK817_SLPPOL_H			BIT(5)
> +#define RK817_SLPPOL_L			(0)
> +
> +/* gpio&int 0xfe */
> +#define RK817_INT_POL_MSK		BIT(1)
> +#define RK817_INT_POL_H			BIT(1)
> +#define RK817_INT_POL_L			0
> +#define RK809_BUCK5_CONFIG(i)		(RK817_BOOST_OTG_CFG + (i) * 1)
>  
>  enum {
>  	BUCK_ILMIN_50MA,
> @@ -443,6 +613,8 @@ enum {
>  enum {
>  	RK805_ID = 0x8050,
>  	RK808_ID = 0x0000,
> +	RK809_ID = 0x8090,
> +	RK817_ID = 0x8170,
>  	RK818_ID = 0x8181,
>  };
>  
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e4ced88..83810d7 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -49,6 +49,7 @@
>   */
>  
>  void (*pm_power_off_prepare)(void);
> +EXPORT_SYMBOL_GPL(pm_power_off_prepare);

Why do you need this where no other driver in the kernel does?

>  /**
>   *	emergency_restart - reboot the system

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
