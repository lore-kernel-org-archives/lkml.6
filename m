Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F7C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E862087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546708847;
	bh=26j3vLyRnWlcPa68ItKr4F3mh6l3TJrDtxFSe0ghmSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PG5fgjjlQtn1wO23nveX8OQz0g7+tsm9onj20g19ySz0LbCE4Mp1h35TQtmri1IXt
	 sZTDHoGNQbIzg3SchrhKROxlX5eJ2DEl7dewgtKbmPBp7Gbhhk5HhLE7VsAA8BkISt
	 KWcP8/R4Rm2aj5qWCtVtuN5mxAP13+6Kym4jNbfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfAERUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAERUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:20:45 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E1E72085A;
        Sat,  5 Jan 2019 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546708843;
        bh=26j3vLyRnWlcPa68ItKr4F3mh6l3TJrDtxFSe0ghmSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mdrow8CFBtuLQ1bG6gNVgDF8WbJStF176fGwngoyCceT/uaIM1itCXB1a0Lhdy00V
         8DdHm2fhk5XGzHvRnTZvVKGFrWRIau9YmQNYCH5NKUlj7MSt/KwxxuZA3E3KHqDR7+
         neUDW24AUcvbd3ZKlmD7vj+bAZkeLu22BrCaE+l0=
Date:   Sat, 5 Jan 2019 17:20:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: Re: [PATCH] Staging: iio: adt7316: Add regmap support
Message-ID: <20190105172037.7cc5006b@archlinux>
In-Reply-To: <20181223140224.10958-1-shreeya.patel23498@gmail.com>
References: <20181223140224.10958-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Jeremy who is also working with this device.

On Sun, 23 Dec 2018 19:32:24 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Both i2c and spi drivers have functions for reading and writing
> to/from registers. Remove this redundant and common code by using
> regmap API.
> Also remove multi_read and multi_write functions from i2c
> and spi driver as they are not being used anywhere.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

I would have preferred an initial patch that removed the multi_read
and multi_write first as that would (I assume) be easily separated
from the 'major' change of moving to regmap.  I also suggest
another section to pull out to a precursor patch below.

The result looks fine to me.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 101 ++--------------
>  drivers/staging/iio/addac/adt7316-spi.c |  94 +++------------
>  drivers/staging/iio/addac/adt7316.c     | 147 ++++++++++++------------
>  drivers/staging/iio/addac/adt7316.h     |  15 +--
>  4 files changed, 103 insertions(+), 254 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index ac91163656b5..435b65845174 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -12,105 +12,28 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  
>  #include "adt7316.h"
>  
> -/*
> - * adt7316 register access by I2C
> - */
> -static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
> -{
> -	struct i2c_client *cl = client;
> -	int ret;
> -
> -	ret = i2c_smbus_write_byte(cl, reg);
> -	if (ret < 0) {
> -		dev_err(&cl->dev, "I2C fail to select reg\n");
> -		return ret;
> -	}
> -
> -	ret = i2c_smbus_read_byte(client);
> -
> -	if (!ret)
> -		return -EIO;
> -
> -	if (ret < 0) {
> -		dev_err(&cl->dev, "I2C read error\n");
> -		return ret;
> -	}
> -
> -	*data = ret;
> -
> -	return 0;
> -}
> -
> -static int adt7316_i2c_write(void *client, u8 reg, u8 data)
> -{
> -	struct i2c_client *cl = client;
> -	int ret = 0;
> -
> -	ret = i2c_smbus_write_byte_data(cl, reg, data);
> -	if (ret < 0)
> -		dev_err(&cl->dev, "I2C write error\n");
> -
> -	return ret;
> -}
> -
> -static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
> -{
> -	struct i2c_client *cl = client;
> -	int i, ret = 0;
> -
> -	if (count > ADT7316_REG_MAX_ADDR)
> -		count = ADT7316_REG_MAX_ADDR;
> -
> -	for (i = 0; i < count; i++) {
> -		ret = adt7316_i2c_read(cl, reg, &data[i]);
> -		if (ret < 0) {
> -			dev_err(&cl->dev, "I2C multi read error\n");
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
> -{
> -	struct i2c_client *cl = client;
> -	int i, ret = 0;
> -
> -	if (count > ADT7316_REG_MAX_ADDR)
> -		count = ADT7316_REG_MAX_ADDR;
> -
> -	for (i = 0; i < count; i++) {
> -		ret = adt7316_i2c_write(cl, reg, data[i]);
> -		if (ret < 0) {
> -			dev_err(&cl->dev, "I2C multi write error\n");
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * device probe and remove
>   */
> -
>  static int adt7316_i2c_probe(struct i2c_client *client,
>  			     const struct i2c_device_id *id)
>  {
> -	struct adt7316_bus bus = {
> -		.client = client,
> -		.irq = client->irq,
> -		.read = adt7316_i2c_read,
> -		.write = adt7316_i2c_write,
> -		.multi_read = adt7316_i2c_multi_read,
> -		.multi_write = adt7316_i2c_multi_write,
> -	};
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &adt7316_regmap_config);
> +
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
>  
> -	return adt7316_probe(&client->dev, &bus, id->name);
> +	return adt7316_probe(&client->dev, regmap, id ? id->name : NULL,
> +			     client->irq);
>  }
>  
>  static const struct i2c_device_id adt7316_i2c_id[] = {
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
> index e75827e326a6..9e3decb5cb77 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -11,79 +11,12 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> +#include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
>  #include "adt7316.h"
>  
>  #define ADT7316_SPI_MAX_FREQ_HZ		5000000
> -#define ADT7316_SPI_CMD_READ		0x91
> -#define ADT7316_SPI_CMD_WRITE		0x90
> -
> -/*
> - * adt7316 register access by SPI
> - */
> -
> -static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
> -{
> -	struct spi_device *spi_dev = client;
> -	u8 cmd[2];
> -	int ret = 0;
> -
> -	if (count > ADT7316_REG_MAX_ADDR)
> -		count = ADT7316_REG_MAX_ADDR;
> -
> -	cmd[0] = ADT7316_SPI_CMD_WRITE;
> -	cmd[1] = reg;
> -
> -	ret = spi_write(spi_dev, cmd, 2);
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI fail to select reg\n");
> -		return ret;
> -	}
> -
> -	cmd[0] = ADT7316_SPI_CMD_READ;
> -
> -	ret = spi_write_then_read(spi_dev, cmd, 1, data, count);
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI read data error\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int adt7316_spi_multi_write(void *client, u8 reg, u8 count, u8 *data)
> -{
> -	struct spi_device *spi_dev = client;
> -	u8 buf[ADT7316_REG_MAX_ADDR + 2];
> -	int i, ret = 0;
> -
> -	if (count > ADT7316_REG_MAX_ADDR)
> -		count = ADT7316_REG_MAX_ADDR;
> -
> -	buf[0] = ADT7316_SPI_CMD_WRITE;
> -	buf[1] = reg;
> -	for (i = 0; i < count; i++)
> -		buf[i + 2] = data[i];
> -
> -	ret = spi_write(spi_dev, buf, count + 2);
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI write error\n");
> -		return ret;
> -	}
> -
> -	return ret;
> -}
> -
> -static int adt7316_spi_read(void *client, u8 reg, u8 *data)
> -{
> -	return adt7316_spi_multi_read(client, reg, 1, data);
> -}
> -
> -static int adt7316_spi_write(void *client, u8 reg, u8 val)
> -{
> -	return adt7316_spi_multi_write(client, reg, 1, &val);
> -}
>  
>  /*
>   * device probe and remove
> @@ -91,14 +24,7 @@ static int adt7316_spi_write(void *client, u8 reg, u8 val)
>  
>  static int adt7316_spi_probe(struct spi_device *spi_dev)
>  {
> -	struct adt7316_bus bus = {
> -		.client = spi_dev,
> -		.irq = spi_dev->irq,
> -		.read = adt7316_spi_read,
> -		.write = adt7316_spi_write,
> -		.multi_read = adt7316_spi_multi_read,
> -		.multi_write = adt7316_spi_multi_write,
> -	};
> +	struct regmap *regmap;
>  
>  	/* don't exceed max specified SPI CLK frequency */
>  	if (spi_dev->max_speed_hz > ADT7316_SPI_MAX_FREQ_HZ) {
> @@ -107,12 +33,20 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
>  		return -EINVAL;
>  	}
>  
> +	regmap = devm_regmap_init_spi(spi_dev, &adt7316_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi_dev->dev, "Error initializing spi regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
>  	/* switch from default I2C protocol to SPI protocol */
> -	adt7316_spi_write(spi_dev, 0, 0);
> -	adt7316_spi_write(spi_dev, 0, 0);
> -	adt7316_spi_write(spi_dev, 0, 0);
> +	regmap_write(regmap, 0, 0);
> +	regmap_write(regmap, 0, 0);
> +	regmap_write(regmap, 0, 0);
>  
> -	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
> +	return adt7316_probe(&spi_dev->dev, regmap, spi_dev->modalias,
> +			     spi_dev->irq);
>  }
>  
>  static const struct spi_device_id adt7316_spi_id[] = {
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 1ca4ee0f30ee..be2330a42706 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -17,6 +17,7 @@
>  #include <linux/list.h>
>  #include <linux/i2c.h>
>  #include <linux/rtc.h>
> +#include <linux/regmap.h>
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> @@ -176,7 +177,7 @@
>   */
>  
>  struct adt7316_chip_info {
> -	struct adt7316_bus	bus;
> +	struct regmap *regmap;
>  	struct gpio_desc	*ldac_pin;
>  	u16			int_mask;	/* 0x2f */
>  	u8			config1;
> @@ -237,7 +238,7 @@ static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
>  	else
>  		config1 = chip->config1 & ~ADT7316_EN;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, config1);
>  	if (ret)
>  		return -EIO;
>  
> @@ -301,7 +302,7 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
>  	if (buf[0] == '1')
>  		config1 |= ADT7516_SEL_EX_TEMP;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, config1);
>  	if (ret)
>  		return -EIO;
>  
> @@ -342,7 +343,7 @@ static ssize_t adt7316_store_mode(struct device *dev,
>  	if (!memcmp(buf, "single_channel", 14))
>  		config2 |= ADT7316_AD_SINGLE_CH_MODE;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG2, config2);
>  	if (ret)
>  		return -EIO;
>  
> @@ -435,7 +436,7 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
>  
>  	config2 |= data;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG2, config2);
>  	if (ret)
>  		return -EIO;
>  
> @@ -495,7 +496,7 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
>  	if (buf[0] == '1')
>  		config2 |= ADT7316_DISABLE_AVERAGING;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG2, config2);
>  	if (ret)
>  		return -EIO;
>  
> @@ -534,7 +535,7 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
>  	if (buf[0] == '1')
>  		config2 |= ADT7316_EN_SMBUS_TIMEOUT;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG2, config2);
>  	if (ret)
>  		return -EIO;
>  
> @@ -572,7 +573,7 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
>  	if (buf[0] == '1')
>  		config1 |= ADT7316_PD;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, config1);
>  	if (ret)
>  		return -EIO;
>  
> @@ -610,7 +611,7 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
>  	if (buf[0] == '1')
>  		config3 |= ADT7316_ADCLK_22_5;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
>  	if (ret)
>  		return -EIO;
>  
> @@ -663,7 +664,7 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
>  		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
>  	}
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
>  	if (ret)
>  		return -EIO;
>  
> @@ -709,7 +710,7 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
>  	else
>  		config3 = chip->config3 | ADT7516_AIN_IN_VREF;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
>  	if (ret)
>  		return -EIO;
>  
> @@ -748,7 +749,7 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
>  	if (buf[0] == '1')
>  		config3 |= ADT7316_EN_IN_TEMP_PROP_DACA;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
>  	if (ret)
>  		return -EIO;
>  
> @@ -787,7 +788,7 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
>  	if (buf[0] == '1')
>  		config3 |= ADT7316_EN_EX_TEMP_PROP_DACB;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
>  	if (ret)
>  		return -EIO;
>  
> @@ -830,7 +831,7 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
>  	dac_config = chip->dac_config & (~ADT7316_DA_2VREF_CH_MASK);
>  	dac_config |= data;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> +	ret = regmap_write(chip->regmap, ADT7316_DAC_CONFIG, dac_config);
>  	if (ret)
>  		return -EIO;
>  
> @@ -890,7 +891,7 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
>  	dac_config = chip->dac_config & (~ADT7316_DA_EN_MODE_MASK);
>  	dac_config |= data;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> +	ret = regmap_write(chip->regmap, ADT7316_DAC_CONFIG, dac_config);
>  	if (ret)
>  		return -EIO;
>  
> @@ -945,8 +946,8 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
>  		ldac_config = chip->ldac_config & (~ADT7316_LDAC_EN_DA_MASK);
>  		ldac_config |= data;
>  
> -		ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
> -			ldac_config);
> +		ret = regmap_write(chip->regmap, ADT7316_LDAC_CONFIG,
> +				   ldac_config);
>  		if (ret)
>  			return -EIO;
>  	} else {
> @@ -993,7 +994,7 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
>  	if (buf[0] == '1')
>  		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> +	ret = regmap_write(chip->regmap, ADT7316_DAC_CONFIG, dac_config);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1038,7 +1039,7 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
>  	if (buf[0] == '1')
>  		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> +	ret = regmap_write(chip->regmap, ADT7316_DAC_CONFIG, dac_config);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1098,8 +1099,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
>  			ldac_config = chip->ldac_config | ADT7316_DAC_IN_VREF;
>  	}
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
> -			ldac_config);
> +	ret = regmap_write(chip->regmap, ADT7316_LDAC_CONFIG, ldac_config);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1117,7 +1117,7 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
>  		int channel, char *buf)
>  {
>  	u16 data;
> -	u8 msb, lsb;
> +	unsigned int msb, lsb;
>  	char sign = ' ';
>  	int ret;
>  
> @@ -1127,13 +1127,12 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
>  
>  	switch (channel) {
>  	case ADT7316_AD_SINGLE_CH_IN:
> -		ret = chip->bus.read(chip->bus.client,
> -			ADT7316_LSB_IN_TEMP_VDD, &lsb);
> +		ret = regmap_read(chip->regmap, ADT7316_LSB_IN_TEMP_VDD, &lsb);
>  		if (ret)
>  			return -EIO;
>  
> -		ret = chip->bus.read(chip->bus.client,
> -			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
> +		ret = regmap_read(chip->regmap,
> +				  ADT7316_AD_MSB_DATA_BASE + channel, &msb);
>  		if (ret)
>  			return -EIO;
>  
> @@ -1141,14 +1140,12 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
>  		data |= lsb & ADT7316_LSB_IN_TEMP_MASK;
>  		break;
>  	case ADT7316_AD_SINGLE_CH_VDD:
> -		ret = chip->bus.read(chip->bus.client,
> -			ADT7316_LSB_IN_TEMP_VDD, &lsb);
> +		ret = regmap_read(chip->regmap, ADT7316_LSB_IN_TEMP_VDD, &lsb);
>  		if (ret)
>  			return -EIO;
>  
> -		ret = chip->bus.read(chip->bus.client,
> -
> -			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
> +		ret = regmap_read(chip->regmap,
> +				  ADT7316_AD_MSB_DATA_BASE + channel, &msb);
>  		if (ret)
>  			return -EIO;
>  
> @@ -1156,13 +1153,12 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
>  		data |= (lsb & ADT7316_LSB_VDD_MASK) >> ADT7316_LSB_VDD_OFFSET;
>  		return sprintf(buf, "%d\n", data);
>  	default: /* ex_temp and ain */
> -		ret = chip->bus.read(chip->bus.client,
> -			ADT7316_LSB_EX_TEMP_AIN, &lsb);
> +		ret = regmap_read(chip->regmap, ADT7316_LSB_EX_TEMP_AIN, &lsb);
>  		if (ret)
>  			return -EIO;
>  
> -		ret = chip->bus.read(chip->bus.client,
> -			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
> +		ret = regmap_read(chip->regmap,
> +				  ADT7316_AD_MSB_DATA_BASE + channel, &msb);
>  		if (ret)
>  			return -EIO;
>  
> @@ -1262,10 +1258,10 @@ static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
>  		int offset_addr, char *buf)
>  {
>  	int data;
> -	u8 val;
> +	unsigned int val;
>  	int ret;
>  
> -	ret = chip->bus.read(chip->bus.client, offset_addr, &val);
> +	ret = regmap_read(chip->regmap, offset_addr, &val);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1292,7 +1288,7 @@ static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
>  
>  	val = (u8)data;
>  
> -	ret = chip->bus.write(chip->bus.client, offset_addr, val);
> +	ret = regmap_write(chip->regmap, offset_addr, val);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1409,7 +1405,7 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
>  		int channel, char *buf)
>  {
>  	u16 data;
> -	u8 msb, lsb, offset;
> +	unsigned int msb, lsb, offset;
>  	int ret;
>  
>  	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
> @@ -1422,14 +1418,14 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
>  	offset = chip->dac_bits - 8;
>  
>  	if (chip->dac_bits > 8) {
> -		ret = chip->bus.read(chip->bus.client,
> -			ADT7316_DA_DATA_BASE + channel * 2, &lsb);
> +		ret = regmap_read(chip->regmap,
> +				  ADT7316_DA_DATA_BASE + channel * 2, &lsb);
>  		if (ret)
>  			return -EIO;
>  	}
>  
> -	ret = chip->bus.read(chip->bus.client,
> -		ADT7316_DA_DATA_BASE + 1 + channel * 2, &msb);
> +	ret = regmap_read(chip->regmap, ADT7316_DA_DATA_BASE + 1 + channel * 2,
> +			  &msb);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1460,15 +1456,15 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
>  
>  	if (chip->dac_bits > 8) {
>  		lsb = data & (1 << offset);
> -		ret = chip->bus.write(chip->bus.client,
> -			ADT7316_DA_DATA_BASE + channel * 2, lsb);
> +		ret = regmap_write(chip->regmap,
> +				   ADT7316_DA_DATA_BASE + channel * 2, lsb);
>  		if (ret)
>  			return -EIO;
>  	}
>  
>  	msb = data >> offset;
> -	ret = chip->bus.write(chip->bus.client,
> -		ADT7316_DA_DATA_BASE + 1 + channel * 2, msb);
> +	ret = regmap_write(chip->regmap, ADT7316_DA_DATA_BASE + 1 + channel * 2,
> +			   msb);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1577,10 +1573,10 @@ static ssize_t adt7316_show_device_id(struct device *dev,
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	u8 id;
> +	unsigned int id;
>  	int ret;
>  
> -	ret = chip->bus.read(chip->bus.client, ADT7316_DEVICE_ID, &id);
> +	ret = regmap_read(chip->regmap, ADT7316_DEVICE_ID, &id);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1595,10 +1591,10 @@ static ssize_t adt7316_show_manufactorer_id(struct device *dev,
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	u8 id;
> +	unsigned int id;
>  	int ret;
>  
> -	ret = chip->bus.read(chip->bus.client, ADT7316_MANUFACTURE_ID, &id);
> +	ret = regmap_read(chip->regmap, ADT7316_MANUFACTURE_ID, &id);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1614,10 +1610,10 @@ static ssize_t adt7316_show_device_rev(struct device *dev,
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	u8 rev;
> +	unsigned int rev;
>  	int ret;
>  
> -	ret = chip->bus.read(chip->bus.client, ADT7316_DEVICE_REV, &rev);
> +	ret = regmap_read(chip->regmap, ADT7316_DEVICE_REV, &rev);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1632,10 +1628,10 @@ static ssize_t adt7316_show_bus_type(struct device *dev,
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	u8 stat;
> +	unsigned int stat;
>  	int ret;
>  
> -	ret = chip->bus.read(chip->bus.client, ADT7316_SPI_LOCK_STAT, &stat);
> +	ret = regmap_read(chip->regmap, ADT7316_SPI_LOCK_STAT, &stat);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1740,11 +1736,11 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct adt7316_chip_info *chip = iio_priv(indio_dev);
> -	u8 stat1, stat2;
> +	unsigned int stat1, stat2;
>  	int ret;
>  	s64 time;
>  
> -	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT1, &stat1);
> +	ret = regmap_read(chip->regmap, ADT7316_INT_STAT1, &stat1);
>  	if (!ret) {
>  		if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
>  			stat1 &= 0x1F;
> @@ -1793,7 +1789,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  							    IIO_EV_DIR_EITHER),
>  				       time);
>  		}
> -	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT2, &stat2);
> +	ret = regmap_read(chip->regmap, ADT7316_INT_STAT2, &stat2);
>  	if (!ret) {
>  		if (stat2 & ADT7316_INT_MASK2_VDD)
>  			iio_push_event(indio_dev,
> @@ -1807,12 +1803,12 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static int adt7316_setup_irq(struct iio_dev *indio_dev)
> +static int adt7316_setup_irq(struct iio_dev *indio_dev, int irq)
>  {
>  	struct adt7316_chip_info *chip = iio_priv(indio_dev);
>  	int irq_type, ret;
>  
> -	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
> +	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
>  
>  	switch (irq_type) {
>  	case IRQF_TRIGGER_HIGH:
> @@ -1828,13 +1824,12 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
>  		break;
>  	}
>  
> -	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
> +	ret = devm_request_threaded_irq(&indio_dev->dev, irq,
>  					NULL, adt7316_event_handler,
>  					irq_type | IRQF_ONESHOT,
>  					indio_dev->name, indio_dev);
>  	if (ret) {
> -		dev_err(&indio_dev->dev, "failed to request irq %d\n",
> -			chip->bus.irq);
> +		dev_err(&indio_dev->dev, "failed to request irq %d\n", irq);
>  		return ret;
>  	}
>  
> @@ -1880,7 +1875,7 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
>  	else
>  		mask = ADT7316_INT_MASK2_VDD;	/* disable vdd int */
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_INT_MASK2, mask);
> +	ret = regmap_write(chip->regmap, ADT7316_INT_MASK2, mask);
>  	if (!ret) {
>  		chip->int_mask &= ~ADT7316_VDD_INT_MASK;
>  		chip->int_mask |= data & ADT7316_VDD_INT_MASK;
> @@ -1894,7 +1889,7 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
>  			/* mask in reg is opposite, set 1 to disable */
>  			mask = (~data) & ADT7316_TEMP_AIN_INT_MASK;
>  	}
> -	ret = chip->bus.write(chip->bus.client, ADT7316_INT_MASK1, mask);
> +	ret = regmap_write(chip->regmap, ADT7316_INT_MASK1, mask);
>  
>  	chip->int_mask = mask;
>  
> @@ -1908,7 +1903,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	u8 val;
> +	unsigned int val;
>  	int data;
>  	int ret;
>  
> @@ -1916,7 +1911,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
>  		this_attr->address > ADT7316_EX_TEMP_LOW)
>  		return -EPERM;
>  
> -	ret = chip->bus.read(chip->bus.client, this_attr->address, &val);
> +	ret = regmap_read(chip->regmap, this_attr->address, &val);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1965,7 +1960,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
>  
>  	val = (u8)data;
>  
> -	ret = chip->bus.write(chip->bus.client, this_attr->address, val);
> +	ret = regmap_write(chip->regmap, this_attr->address, val);
>  	if (ret)
>  		return -EIO;
>  
> @@ -1996,7 +1991,7 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
>  	if (buf[0] == '1')
>  		config1 |= ADT7316_INT_EN;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, config1);
>  	if (ret)
>  		return -EIO;
>  
> @@ -2133,8 +2128,8 @@ static const struct iio_info adt7516_info = {
>  /*
>   * device probe and remove
>   */
> -int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> -		const char *name)
> +int adt7316_probe(struct device *dev, struct regmap *regmap, const char *name,
> +		  int irq)
>  {
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
> @@ -2147,7 +2142,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	/* this is only used for device removal purposes */
>  	dev_set_drvdata(dev, indio_dev);
>  
> -	chip->bus = *bus;
> +	chip->regmap = regmap;
>  
>  	if (name[4] == '3')
>  		chip->id = ID_ADT7316 + (name[6] - '6');
> @@ -2180,17 +2175,17 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	if (chip->bus.irq > 0) {
> -		ret = adt7316_setup_irq(indio_dev);
> +	if (irq > 0) {
> +		ret = adt7316_setup_irq(indio_dev, irq);

This may also have been clearer as a separate patch before the regmap
one that moved to passing in irq rather than getting it from the bus
route.  It is a necessary change to implement regmap but it can be
done separately before the regmap patch I think...

>  		if (ret)
>  			return ret;
>  	}
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, chip->config1);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, chip->config1);
>  	if (ret)
>  		return -EIO;
>  
> -	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, chip->config3);
> +	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, chip->config3);
>  	if (ret)
>  		return -EIO;
>  
> diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
> index fd7c5c92b599..2c72cf3f71cd 100644
> --- a/drivers/staging/iio/addac/adt7316.h
> +++ b/drivers/staging/iio/addac/adt7316.h
> @@ -11,16 +11,13 @@
>  
>  #include <linux/types.h>
>  #include <linux/pm.h>
> +#include <linux/regmap.h>
>  
>  #define ADT7316_REG_MAX_ADDR		0x3F
>  
> -struct adt7316_bus {
> -	void *client;
> -	int irq;
> -	int (*read)(void *client, u8 reg, u8 *data);
> -	int (*write)(void *client, u8 reg, u8 val);
> -	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
> -	int (*multi_write)(void *client, u8 first_reg, u8 count, u8 *data);
> +static const struct regmap_config adt7316_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 10,
>  };
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -29,7 +26,7 @@ extern const struct dev_pm_ops adt7316_pm_ops;
>  #else
>  #define ADT7316_PM_OPS NULL
>  #endif
> -int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> -		   const char *name);
> +int adt7316_probe(struct device *dev, struct regmap *regmap, const char *name,
> +		  int irq);
>  
>  #endif

