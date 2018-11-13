Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F842C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68C0223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bltMFgXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68C0223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbeKMRXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:23:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37325 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbeKMRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:23:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id o15-v6so12019705wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 23:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pP+gvH/dcVu1N21gJxkOJkpSMhZxeANXWMhLbS6RhmY=;
        b=bltMFgXcNLS5QEo1n1gQUzBHJrxabg38meHB55yL3k5TxTDiHrO6Q956rOqYa3GQxO
         eu6qy0w2MZGXmMMUvHB4Ze8bftodYYyvmoriQR/QjZHPYQ8DZrcJcW4AiI2cljN+o+1a
         ktSN6DEREp/cm2XWxAoYnXe0TRe2pSDvcJozs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pP+gvH/dcVu1N21gJxkOJkpSMhZxeANXWMhLbS6RhmY=;
        b=GMpp/eJRNDTFZNz6HdXaMuRFnHiuDhJLm2ULCc7FvkLHJkkwAzDAVx1wMpUX+XCswc
         XUIT3d4mgY1Di6id6/yrxzJ199xManEiVwMDTPhMThv3oMNr1ZPIPxBTSGjAbvxcNf7q
         ooSzHewuajyv4Q9KZYc8mwZCBqfX6tjwss+Es3HAxNAccinXG005BjzZD//izB0ecteh
         NQ3s2J/Gf/mmEB1FCJdLedwcajs5uyBTDpP0izR2y8CBTn3VlAz3tduZJ2d0Hsg2CKuy
         5cEAxf5TaFF/RPmLQs86b01wdoJ4NJ+Eo/Ghg4ma1RYOo97Pg6Io70N3El73o0Rv8VUK
         iuLw==
X-Gm-Message-State: AGRZ1gK6LCbmAndlcDtiToFCU2ZefZioZcVPdSz0q9m2T/LepHX9BhNj
        fa6B0XHeUwad3YtrwkiPLWEKSg==
X-Google-Smtp-Source: AJdET5eRnVAu7OL31EUA8kqtkhLYih7+zvg8ngMVMDq/i5E3uw8E2sr6ddImCMAPc1QF3hmZ/oTpuw==
X-Received: by 2002:adf:b315:: with SMTP id j21-v6mr3819740wrd.46.1542094002780;
        Mon, 12 Nov 2018 23:26:42 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id b5-v6sm13310803wma.17.2018.11.12.23.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 23:26:42 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:26:40 +0000
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
Subject: Re: [PATCH v6 2/6] mfd: rk808: Add RK817 and RK809 support
Message-ID: <20181113072640.GA29388@dell>
References: <1540894081-31270-1-git-send-email-tony.xie@rock-chips.com>
 <1540894081-31270-3-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540894081-31270-3-git-send-email-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018, Tony Xie wrote:

> The rk809 and rk817 are a Power Management IC (PMIC) for multimedia

"RK809 and RK817"

> and handheld devices. It contains the following components:

s/It contains/They contain/

>   - Regulators
>   - RTC
>   - Clocking
> 
> Both RK809 and RK817 chips are using a similar register map,
> so we can reuse the RTC and Clocking and regulators functionality.

By is "Clocking" capitalised, but "regulators" is not?

> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/mfd/Kconfig       |   6 +-
>  drivers/mfd/rk808.c       | 225 +++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/rk808.h | 172 +++++++++++++++++++++++++++++++++++
>  3 files changed, 386 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5..f8b1922 100644
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
> +	  If you say yes here you get support for the RK805, RK808, RK809,
> +	  RK817 and RK818 Power Management chips.
>  	  This driver provides common support for accessing the device
>  	  through I2C interface. The device supports multiple sub-devices
>  	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 216fbf6..9da1035 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -27,6 +27,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> +#include <linux/syscore_ops.h>
>  
>  struct rk808_reg_data {
>  	int addr;
> @@ -62,6 +63,29 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
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

This last line does not read well.

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
> @@ -86,6 +110,14 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
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
> @@ -94,6 +126,13 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
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

Consider converting these to DEFINE_RES_IRQ_NAMED()

>  static struct resource rk805_key_resources[] = {
>  	{
>  		.start  = RK805_IRQ_PWRON_FALL,
> @@ -107,6 +146,19 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
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
> @@ -132,6 +184,21 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
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
> @@ -167,6 +234,13 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
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
> @@ -332,6 +406,33 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>  	},
>  };
>  
> +static const struct regmap_irq rk817_irqs[RK817_IRQ_END] = {
> +	REGMAP_IRQ_REG_LINE(0, 8),
> +	REGMAP_IRQ_REG_LINE(1, 8),
> +	REGMAP_IRQ_REG_LINE(2, 8),
> +	REGMAP_IRQ_REG_LINE(3, 8),
> +	REGMAP_IRQ_REG_LINE(4, 8),
> +	REGMAP_IRQ_REG_LINE(5, 8),
> +	REGMAP_IRQ_REG_LINE(6, 8),
> +	REGMAP_IRQ_REG_LINE(7, 8),
> +	REGMAP_IRQ_REG_LINE(8, 8),
> +	REGMAP_IRQ_REG_LINE(9, 8),
> +	REGMAP_IRQ_REG_LINE(10, 8),
> +	REGMAP_IRQ_REG_LINE(11, 8),
> +	REGMAP_IRQ_REG_LINE(12, 8),
> +	REGMAP_IRQ_REG_LINE(13, 8),
> +	REGMAP_IRQ_REG_LINE(14, 8),
> +	REGMAP_IRQ_REG_LINE(15, 8),
> +	REGMAP_IRQ_REG_LINE(16, 8),
> +	REGMAP_IRQ_REG_LINE(17, 8),
> +	REGMAP_IRQ_REG_LINE(18, 8),
> +	REGMAP_IRQ_REG_LINE(19, 8),
> +	REGMAP_IRQ_REG_LINE(20, 8),
> +	REGMAP_IRQ_REG_LINE(21, 8),
> +	REGMAP_IRQ_REG_LINE(22, 8),
> +	REGMAP_IRQ_REG_LINE(23, 8)
> +};
> +
>  static struct regmap_irq_chip rk805_irq_chip = {
>  	.name = "rk805",
>  	.irqs = rk805_irqs,
> @@ -355,6 +456,18 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
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
> @@ -376,7 +489,7 @@ static void rk805_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk805, so do nothing here\n");
> +			 "cannot get the driver data of RK808!\n");

This message should be more generic.

Something the use will care about.

Why is it not possible to obtain the driver data?

Also, is this really a warning, or is this scenario valid?

>  		return;
>  	}
>  
> @@ -394,7 +507,7 @@ static void rk808_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk808, so do nothing here\n");
> +			 "cannot get the driver data of RK808!\n");

As above.

>  		return;
>  	}
>  
> @@ -412,7 +525,7 @@ static void rk818_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk818, so do nothing here\n");
> +			 "cannot get the driver data of RK808!\n");

As above.

>  		return;
>  	}
>  
> @@ -423,9 +536,39 @@ static void rk818_device_shutdown(void)
>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>  }
>  
> +static void rk8xx_syscore_shutdown(void)
> +{
> +	int ret;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);

Nit: reverse these 2 entries please.

> +	if (!rk808) {
> +		dev_warn(&rk808_i2c_client->dev,
> +			 "cannot get the driver data of RK808!\n");

As above.

> +		return;
> +	}
> +
> +	if (system_state == SYSTEM_POWER_OFF &&
> +	    (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
> +		ret = regmap_update_bits(rk808->regmap,
> +					 RK817_SYS_CFG(3),
> +					 RK817_SLPPIN_FUNC_MSK,
> +					 SLPPIN_DN_FUN);
> +		if (ret) {
> +			dev_warn(&rk808_i2c_client->dev,
> +				 "the reset pin cannot switch to power down function\n");

This line looks over-sized.  Did you run scripts/checkpatch.pl?

> +		}
> +	}
> +}
> +
> +static struct syscore_ops rk808_syscore_ops = {
> +	.shutdown = rk8xx_syscore_shutdown,
> +};
> +
>  static const struct of_device_id rk808_of_match[] = {
>  	{ .compatible = "rockchip,rk805" },
>  	{ .compatible = "rockchip,rk808" },
> +	{ .compatible = "rockchip,rk809" },
> +	{ .compatible = "rockchip,rk817" },
>  	{ .compatible = "rockchip,rk818" },
>  	{ },
>  };
> @@ -438,10 +581,11 @@ static int rk808_probe(struct i2c_client *client,
>  	struct rk808 *rk808;
>  	const struct rk808_reg_data *pre_init_reg;
>  	const struct mfd_cell *cells;
> -	void (*pm_pwroff_fn)(void);
> +	void (*pm_pwroff_fn)(void) = NULL;
>  	int nr_pre_init_regs;
>  	int nr_cells;
>  	int pm_off = 0, msb, lsb;
> +	unsigned char pmic_id_msb, pmic_id_lsb;
>  	int ret;
>  	int i;
>  
> @@ -449,15 +593,24 @@ static int rk808_probe(struct i2c_client *client,
>  	if (!rk808)
>  		return -ENOMEM;
>  
> +	if (of_device_is_compatible(np, "rockchip,rk817") ||
> +	    of_device_is_compatible(np, "rockchip,rk809")) {
> +		pmic_id_msb = RK817_ID_MSB;
> +		pmic_id_lsb = RK817_ID_LSB;
> +	} else {
> +		pmic_id_msb = RK808_ID_MSB;
> +		pmic_id_lsb = RK808_ID_LSB;
> +	}
> +
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
> @@ -495,6 +648,16 @@ static int rk808_probe(struct i2c_client *client,
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
> +		register_syscore_ops(&rk808_syscore_ops);
> +		break;
>  	default:
>  		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
>  			rk808->variant);
> @@ -568,22 +731,56 @@ static int rk808_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static const struct i2c_device_id rk808_ids[] = {
> -	{ "rk805" },
> -	{ "rk808" },
> -	{ "rk818" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(i2c, rk808_ids);
> +static int rk8xx_suspend(struct device *dev)
> +{
> +	int ret = 0;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);

Nit: reverse these 2 entries please.

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

Remove this line.

> +static int rk8xx_resume(struct device *dev)
> +{
> +	int ret = 0;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);

Nit: reverse these 2 entries please.

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

Remove this line.

> +SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
>  
>  static struct i2c_driver rk808_i2c_driver = {
>  	.driver = {
>  		.name = "rk808",
>  		.of_match_table = rk808_of_match,
> +		.pm = &rk8xx_pm_ops,
>  	},
>  	.probe    = rk808_probe,
>  	.remove   = rk808_remove,
> -	.id_table = rk808_ids,

The removal of the ID table should be done in a separate patch.

>  };
>  
>  module_i2c_driver(rk808_i2c_driver);
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

What is 8?  Perhaps it should be defined?

> +#define RK817_IRQ_PLUG_OUT		(8 + 1)
> +#define RK817_IRQ_CHRG_TERM		(8 + 2)
> +#define RK817_IRQ_CHRG_TIME		(8 + 3)
> +#define RK817_IRQ_CHRG_TS		(8 + 4)
> +#define RK817_IRQ_USB_OV		(8 + 5)
> +#define RK817_IRQ_CHRG_IN_CLMP		(8 + 6)
> +#define RK817_IRQ_BAT_DIS_ILIM		(8 + 7)
> +#define RK817_IRQ_GATE_GPIO		(16 + 0)

What is 16?  Perhaps it should be defined?

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

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
