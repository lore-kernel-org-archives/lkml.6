Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbeETKuy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbeETKux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:50:53 -0400
Date: Sun, 20 May 2018 11:50:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio:dac:ad5686: Add
 AD5681R/AD5682R/AD5683/AD5683R support
Message-ID: <20180520115047.63bd60a2@archlinux>
In-Reply-To: <1526657014-28960-1-git-send-email-stefan.popa@analog.com>
References: <1526657014-28960-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 18:23:34 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The AD5681R/AD5682R/AD5683/AD5683R are a family of one channel DACs with
> 12-bit, 14-bit and 16-bit precision respectively. The devices have either
> no built-in reference, or built-in 2.5V reference.
> 
> These devices are similar to AD5691R/AD5692R/AD5693/AD5693R except
> with a few notable differences:
>  * they use the SPI interface instead of I2C
>  * in the write control register, DB18 and DB17 are used for setting the
>    power mode, while DB16 is the REF bit. This is why a new regmap type
>    was defined and checked accordingly.
>  * the shift register is 24 bits wide, the first four bits are the command
>    bits followed by the data bits. As the data comprises of 20-bit, 18-bit
>    or 16-bit input code, this means that 4 LSB bits are don't care. This is
>    why the data needs to be shifted on the left with four bits. Therefore,
>    AD5683_REGMAP is checked inside a switch case in the ad5686_spi_write()
>    function. On the other hand, similar devices such as AD5693R family,
>    have the 4 MSB command bits followed by 4 don't care bits.
> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5683R_5682R_5681R_5683.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

A comment inline about how to perhaps improve the future flexibility of
the driver if you are looking at adding new parts. 

Otherwise, looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Nothing changed, just to follow the patch set version.
> 
>  drivers/iio/dac/ad5686-spi.c | 42 ++++++++++++++++++++++++++++++++++--------
>  drivers/iio/dac/ad5686.c     | 32 ++++++++++++++++++++++++++++++++
>  drivers/iio/dac/ad5686.h     |  8 ++++++++
>  3 files changed, 74 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 6bb09e9..1df9143 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * AD5672R, AD5676, AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R
> + * AD5672R, AD5676, AD5676R, AD5681R, AD5682R, AD5683, AD5683R,
> + * AD5684, AD5684R, AD5685R, AD5686, AD5686R
>   * Digital to analog converters driver
>   *
>   * Copyright 2018 Analog Devices Inc.
> @@ -15,12 +16,27 @@ static int ad5686_spi_write(struct ad5686_state *st,
>  			    u8 cmd, u8 addr, u16 val)
>  {
>  	struct spi_device *spi = to_spi_device(st->dev);
> -
> -	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -				      AD5686_ADDR(addr) |
> -				      val);
> -
> -	return spi_write(spi, &st->data[0].d8[1], 3);
> +	u8 tx_len, *buf;
> +
> +	switch (st->chip_info->regmap_type) {
> +	case AD5683_REGMAP:
> +		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> +					      AD5683_DATA(val));
> +		buf = &st->data[0].d8[1];
> +		tx_len = 3;
> +		break;
> +	case AD5686_REGMAP:
> +		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> +					      AD5686_ADDR(addr) |
> +					      val);
> +		buf = &st->data[0].d8[1];
> +		tx_len = 3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return spi_write(spi, buf, tx_len);
>  }
>  
>  static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> @@ -37,9 +53,15 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  		},
>  	};
>  	struct spi_device *spi = to_spi_device(st->dev);
> +	u8 cmd = 0;
>  	int ret;
>  
> -	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
> +	if (st->chip_info->regmap_type == AD5686_REGMAP)
> +		cmd = AD5686_CMD_READBACK_ENABLE;
> +	else if (st->chip_info->regmap_type == AD5683_REGMAP)
> +		cmd = AD5686_CMD_READBACK_ENABLE_V2;
We are rapidly heading for the point where we should really be using
a lookup table for all these device type specific elements.

Something to think about if you add another one..

> +
> +	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
>  				      AD5686_ADDR(addr));
>  	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
>  
> @@ -67,6 +89,10 @@ static const struct spi_device_id ad5686_spi_id[] = {
>  	{"ad5672r", ID_AD5672R},
>  	{"ad5676", ID_AD5676},
>  	{"ad5676r", ID_AD5676R},
> +	{"ad5681r", ID_AD5681R},
> +	{"ad5682r", ID_AD5682R},
> +	{"ad5683", ID_AD5683},
> +	{"ad5683r", ID_AD5683R},
>  	{"ad5684", ID_AD5684},
>  	{"ad5684r", ID_AD5684R},
>  	{"ad5685", ID_AD5685R}, /* Does not exist */
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 1fc0c56..e136f0f 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -83,6 +83,10 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
>  
>  	switch (st->chip_info->regmap_type) {
> +	case AD5683_REGMAP:
> +		shift = 13;
> +		ref_bit_msk = AD5683_REF_BIT_MSK;
> +		break;
>  	case AD5686_REGMAP:
>  		shift = 0;
>  		ref_bit_msk = 0;
> @@ -256,6 +260,29 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  		.num_channels = 8,
>  		.regmap_type = AD5686_REGMAP,
>  	},
> +	[ID_AD5681R] = {
> +		.channels = ad5691r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5683_REGMAP,
> +	},
> +	[ID_AD5682R] = {
> +		.channels = ad5692r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5683_REGMAP,
> +	},
> +	[ID_AD5683] = {
> +		.channels = ad5693_channels,
> +		.num_channels = 1,
> +		.regmap_type = AD5683_REGMAP,
> +	},
> +	[ID_AD5683R] = {
> +		.channels = ad5693_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5683_REGMAP,
> +	},
>  	[ID_AD5684] = {
>  		.channels = ad5684_channels,
>  		.num_channels = 4,
> @@ -385,6 +412,11 @@ int ad5686_probe(struct device *dev,
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
>  	switch (st->chip_info->regmap_type) {
> +	case AD5683_REGMAP:
> +		cmd = AD5686_CMD_CONTROL_REG;
> +		ref_bit_msk = AD5683_REF_BIT_MSK;
> +		st->use_internal_vref = !voltage_uv;
> +		break;
>  	case AD5686_REGMAP:
>  		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
>  		ref_bit_msk = 0;
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 6c6879d..d05cda9 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -13,6 +13,7 @@
>  #include <linux/mutex.h>
>  #include <linux/kernel.h>
>  
> +#define AD5683_DATA(x)				((x) << 4)
>  #define AD5686_ADDR(x)				((x) << 16)
>  #define AD5686_CMD(x)				((x) << 20)
>  
> @@ -36,6 +37,8 @@
>  #define AD5686_LDAC_PWRDN_3STATE		0x3
>  
>  #define AD5686_CMD_CONTROL_REG			0x4
> +#define AD5686_CMD_READBACK_ENABLE_V2		0x5
> +#define AD5683_REF_BIT_MSK			BIT(12)
>  #define AD5693_REF_BIT_MSK			BIT(12)
>  
>  /**
> @@ -47,6 +50,10 @@ enum ad5686_supported_device_ids {
>  	ID_AD5675R,
>  	ID_AD5676,
>  	ID_AD5676R,
> +	ID_AD5681R,
> +	ID_AD5682R,
> +	ID_AD5683,
> +	ID_AD5683R,
>  	ID_AD5684,
>  	ID_AD5684R,
>  	ID_AD5685R,
> @@ -64,6 +71,7 @@ enum ad5686_supported_device_ids {
>  };
>  
>  enum ad5686_regmap_type {
> +	AD5683_REGMAP,
>  	AD5686_REGMAP,
>  	AD5693_REGMAP
>  };
