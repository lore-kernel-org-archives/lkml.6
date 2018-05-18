Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeEROYv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:24:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751405AbeEROYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:24:48 -0400
Date: Fri, 18 May 2018 15:24:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Stefan Popa <stefan.popa@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R
 support
Message-ID: <20180518152438.00007f80@huawei.com>
In-Reply-To: <1526652994-23401-1-git-send-email-stefan.popa@analog.com>
References: <1526652994-23401-1-git-send-email-stefan.popa@analog.com>
Organization: Huawei
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.48.115]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 17:16:34 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The AD5691R/AD5692R/AD5693/AD5693R are a family of one channel DACs with
> 12-bit, 14-bit and 16-bit precision respectively. The devices have either
> no built-in reference, or built-in 2.5V reference.
> 
> These devices are pretty similar to AD5671R/AD5675R and
> AD5694/AD5694R/AD5695R/AD5696/AD5696R, except that they have one channel.
> Another difference is that they use a write control register(addr 0x04) for
> setting the power down modes and the internal reference instead of separate
> registers for each function.
> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5693R_5692R_5691R_5693.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

A few really quick comments inline.

> ---
>  drivers/iio/dac/ad5686.c     | 88 +++++++++++++++++++++++++++++++++++++++++---
>  drivers/iio/dac/ad5686.h     | 16 ++++++++
>  drivers/iio/dac/ad5696-i2c.c |  7 +++-
>  3 files changed, 104 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 89c5f08..be803e8 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -70,6 +70,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	bool readin;
>  	int ret;
>  	struct ad5686_state *st = iio_priv(indio_dev);
> +	unsigned int val, ref_bit_msk = 0;
> +	u8 shift = 0;
>  
>  	ret = strtobool(buf, &readin);
>  	if (ret)
> @@ -80,9 +82,22 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	else
>  		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
>  
> -	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0,
> -			st->pwr_down_mask & st->pwr_down_mode);
> +	switch (st->chip_info->regmap_type) {
> +	case AD5686_REGMAP:
> +		shift = 0;
> +		ref_bit_msk = 0;
you initialize to these values above. Any reason to set them again here?

Actually I'd prefer you didn't set them above and only set them here as
then it is obvious what they are set to the for the two different cases.

> +		break;
> +	case AD5693_REGMAP:
> +		shift = 13;
> +		ref_bit_msk = AD5693_REF_BIT_MSK;
> +		break;
default: 
	some sort of error response.  We'll get compile warnings on this otherwise.

> +	}
>  
> +	val = ((st->pwr_down_mask & st->pwr_down_mode) << shift);
> +	if (!st->use_internal_vref)
> +		val |= ref_bit_msk;
> +
> +	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0, val);
>  
>  	return ret ? ret : len;
>  }
> @@ -175,6 +190,11 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
>  		.ext_info = ad5686_ext_info,			\
>  }
>  
> +#define DECLARE_AD5693_CHANNELS(name, bits, _shift)		\
> +static struct iio_chan_spec name[] = {				\
> +		AD5868_CHANNEL(0, 0, bits, _shift),		\
> +}
> +
>  #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
>  static struct iio_chan_spec name[] = {				\
>  		AD5868_CHANNEL(0, 1, bits, _shift),		\
> @@ -200,72 +220,112 @@ DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
>  DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
>  DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
>  DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
> +DECLARE_AD5693_CHANNELS(ad5693_channels, 16, 0);
> +DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
> +DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
>  
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  	[ID_AD5671R] = {
>  		.channels = ad5672_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 8,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5672R] = {
>  		.channels = ad5672_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 8,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5675R] = {
>  		.channels = ad5676_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 8,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5676] = {
>  		.channels = ad5676_channels,
>  		.num_channels = 8,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5676R] = {
>  		.channels = ad5676_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 8,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5684] = {
>  		.channels = ad5684_channels,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5684R] = {
>  		.channels = ad5684_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5685R] = {
>  		.channels = ad5685r_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5686] = {
>  		.channels = ad5686_channels,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5686R] = {
>  		.channels = ad5686_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
> +	},
> +	[ID_AD5691R] = {
> +		.channels = ad5691r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5693_REGMAP,
> +	},
> +	[ID_AD5692R] = {
> +		.channels = ad5692r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5693_REGMAP,
> +	},
> +	[ID_AD5693] = {
> +		.channels = ad5693_channels,
> +		.num_channels = 1,
> +		.regmap_type = AD5693_REGMAP,
> +	},
> +	[ID_AD5693R] = {
> +		.channels = ad5693_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5693_REGMAP,
>  	},
>  	[ID_AD5694] = {
>  		.channels = ad5684_channels,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5694R] = {
>  		.channels = ad5684_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5696] = {
>  		.channels = ad5686_channels,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  	[ID_AD5696R] = {
>  		.channels = ad5686_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 4,
> +		.regmap_type = AD5686_REGMAP,
>  	},
>  };
>  
> @@ -276,7 +336,9 @@ int ad5686_probe(struct device *dev,
>  {
>  	struct ad5686_state *st;
>  	struct iio_dev *indio_dev;
> -	int ret, voltage_uv = 0;
> +	unsigned int val, ref_bit_msk = 0;
> +	u8 cmd = 0;
> +	int ret, i, voltage_uv = 0;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (indio_dev == NULL)
> @@ -310,7 +372,8 @@ int ad5686_probe(struct device *dev,
>  		st->vref_mv = st->chip_info->int_vref_mv;
>  
>  	/* Set all the power down mode for all channels to 1K pulldown */
> -	st->pwr_down_mode = 0x55;
> +	for (i = 0; i < st->chip_info->num_channels; i++)
> +		st->pwr_down_mode |= (0x01 << (i * 2));
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->name = name;
> @@ -319,8 +382,21 @@ int ad5686_probe(struct device *dev,
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> -	ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP,
> -			0, !!voltage_uv);
> +	switch (st->chip_info->regmap_type) {
> +	case AD5686_REGMAP:
> +		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
> +		ref_bit_msk = 0;

Again you have a default setting above...

> +		break;
> +	case AD5693_REGMAP:
> +		cmd = AD5686_CMD_CONTROL_REG;
> +		ref_bit_msk = AD5693_REF_BIT_MSK;
> +		st->use_internal_vref = !voltage_uv;
> +		break;
> +	}
> +
> +	val = (voltage_uv | ref_bit_msk);
> +
> +	ret = st->write(st, cmd, 0, !!val);
>  	if (ret)
>  		goto error_disable_reg;
>  
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 05f0ce9..6c6879d 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -35,6 +35,9 @@
>  #define AD5686_LDAC_PWRDN_100K			0x2
>  #define AD5686_LDAC_PWRDN_3STATE		0x3
>  
> +#define AD5686_CMD_CONTROL_REG			0x4
> +#define AD5693_REF_BIT_MSK			BIT(12)
> +
>  /**
>   * ad5686_supported_device_ids:
>   */
> @@ -49,6 +52,10 @@ enum ad5686_supported_device_ids {
>  	ID_AD5685R,
>  	ID_AD5686,
>  	ID_AD5686R,
> +	ID_AD5691R,
> +	ID_AD5692R,
> +	ID_AD5693,
> +	ID_AD5693R,
>  	ID_AD5694,
>  	ID_AD5694R,
>  	ID_AD5695R,
> @@ -56,6 +63,11 @@ enum ad5686_supported_device_ids {
>  	ID_AD5696R,
>  };
>  
> +enum ad5686_regmap_type {
> +	AD5686_REGMAP,
> +	AD5693_REGMAP
> +};
> +
>  struct ad5686_state;
>  
>  typedef int (*ad5686_write_func)(struct ad5686_state *st,
> @@ -68,12 +80,14 @@ typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
>   * @int_vref_mv:	AD5620/40/60: the internal reference voltage
>   * @num_channels:	number of channels
>   * @channel:		channel specification
> + * @regmap_type:	register map layout variant
>   */
>  
>  struct ad5686_chip_info {
>  	u16				int_vref_mv;
>  	unsigned int			num_channels;
>  	struct iio_chan_spec		*channels;
> +	enum ad5686_regmap_type		regmap_type;
>  };
>  
>  /**
> @@ -84,6 +98,7 @@ struct ad5686_chip_info {
>   * @vref_mv:		actual reference voltage used
>   * @pwr_down_mask:	power down mask
>   * @pwr_down_mode:	current power down mode
> + * @use_internal_vref:	set to true if the internal reference voltage is used
>   * @data:		spi transfer buffers
>   */
>  
> @@ -96,6 +111,7 @@ struct ad5686_state {
>  	unsigned int			pwr_down_mode;
>  	ad5686_write_func		write;
>  	ad5686_read_func		read;
> +	bool				use_internal_vref;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index 275e032..d18735d 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * AD5671R, AD5675R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
> + * AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R,
> + * AD5694, AD5694R, AD5695R, AD5696, AD5696R
>   * Digital to analog converters driver
>   *
>   * Copyright 2018 Analog Devices Inc.
> @@ -72,6 +73,10 @@ static int ad5686_i2c_remove(struct i2c_client *i2c)
>  static const struct i2c_device_id ad5686_i2c_id[] = {
>  	{"ad5671r", ID_AD5671R},
>  	{"ad5675r", ID_AD5675R},
> +	{"ad5691r", ID_AD5691R},
> +	{"ad5692r", ID_AD5692R},
> +	{"ad5693", ID_AD5693},
> +	{"ad5693r", ID_AD5693R},
>  	{"ad5694", ID_AD5694},
>  	{"ad5694r", ID_AD5694R},
>  	{"ad5695r", ID_AD5695R},
