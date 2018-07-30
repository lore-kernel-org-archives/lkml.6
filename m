Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5A0C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696FB20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk9sDPU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696FB20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeG3Uo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbeG3Uo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:44:26 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7270F20890;
        Mon, 30 Jul 2018 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532977681;
        bh=Rh3GtZxmrGywSwj+Ws42OjUqNO922zLabASd4DUjDfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hk9sDPU4rYnFQu1Zpl2GbR0vdarqTij0WaIzaHj011o7N8/jc69b8yt4rkctRS2Jr
         sq7RTZYdNPggJQNVbpHFeibNzWkmB42roFOZ5Nt2bVdG3auTpgvgrlWuJoUAenxjM3
         TQWbP6PUieRWRZpbaf2gio4OCH1PbW/HiqfQuQEU=
Date:   Mon, 30 Jul 2018 20:07:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: ad5770r: Add AD5770R support
Message-ID: <20180730200411.7496064f@archlinux>
In-Reply-To: <20180730140205.4972-1-mircea.caprioru@analog.com>
References: <20180730140205.4972-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 17:02:05 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> The AD5770R is a 6-channel, 14-bit resolution, low noise, programmable
> current output digital-to-analog converter (DAC) for photonics control
> applications.
> 
> It contains five 14-bit resolution current sourcing DAC channels and one
> 14-bit resolution current sourcing/sinking DAC channel.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
I'm not sure I've completely avoiding repetition but I tried ;)
+ naturally Andy got some things I missed!

Additional comments from me.

Mostly fine, but a few bits and bobs to clean up.  I'm guessing this
is a bit special purpose given I couldn't find a datasheet and those really
random looking current ranges!

Jonathan

p.s. Your CC list was a bit bonkers in terms of number of people and
who some of them were.  Please try to limit it to people you know
are likely to be interested and had curate any script outputs.

There were a few on their I don't know, so I may have removed someone
you deliberately added.  If so sorry about that!

> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/dac/Kconfig   |  10 +
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/ad5770r.c | 548 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 560 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5770r.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c2626079592..c9168ae18f0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -762,6 +762,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	Documentation/devicetree/bindings/iio/dac/ad5770r.txt
> +F:	drivers/iio/dac/ad5770r.c
>  
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 25bed2d7d2b9..798db486c333 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -171,6 +171,16 @@ config AD5764
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5764.
>  
> +config AD5770R
> +	tristate "Analog Devices AD5770R IDAC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Analog Devices AD5770R Digital to
> +	  Analog Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5770r.
> +
>  config AD5791
>  	tristate "Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC SPI driver"
>  	depends on SPI
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 603587cc2f07..0a38690bbd2b 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_AD5593R) += ad5593r.o
>  obj-$(CONFIG_AD5755) += ad5755.o
>  obj-$(CONFIG_AD5761) += ad5761.o
>  obj-$(CONFIG_AD5764) += ad5764.o
> +obj-$(CONFIG_AD5770R) += ad5770r.o
>  obj-$(CONFIG_AD5791) += ad5791.o
>  obj-$(CONFIG_AD5686) += ad5686.o
>  obj-$(CONFIG_AD7303) += ad7303.o
> diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> new file mode 100644
> index 000000000000..9d3db3b25335
> --- /dev/null
> +++ b/drivers/iio/dac/ad5770r.c
> @@ -0,0 +1,548 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD5770R Digital to analog converters driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/delay.h>
> +#include <linux/property.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* SPI configuration registers */
> +#define AD5770R_INTERFACE_CONFIG_A	0x00
> +
> +/* AD5770R configuration registers */
> +#define AD5770R_CHANNEL_CONFIG		0x14
> +#define AD5770R_OUTPUT_RANGE(ch)	(0x15 + (ch))
> +#define AD5770R_REFERENCE		0x1B
> +#define AD5770R_DAC_LSB(ch)		(0x26 + 2 * (ch))
> +#define AD5770R_DAC_MSB(ch)		(0x27 + 2 * (ch))
> +#define AD5770R_CH_SELECT		0x34
> +#define AD5770R_CH_ENABLE		0x44
> +
> +/* AD5770R_INTERFACE_CONFIG_A */
> +#define AD5770R_ITF_CFG_A_SW_RESET(x)		(((x) & 0x1) | 0x80)
> +
> +/* AD5770R_CHANNEL_CONFIG */
> +#define AD5770R_CFG_CH0_SINK_EN(x)		(((x) & 0x1) << 7)
> +#define AD5770R_CFG_SHUTDOWN_B(x, ch)		(((x) & 0x1) << (ch))
> +
> +/* AD5770R_OUTPUT_RANGE */
> +#define AD5770R_RANGE_OUTPUT_SCALING(x)		(((x) & 0x3F) << 2)
> +#define AD5770R_RANGE_MODE(x)			((x) & 0x03)
> +
> +/* AD5770R_REFERENCE */
> +#define AD5770R_REF_RESISTOR_SEL(x)		(((x) & 0x1) << 2)
> +#define AD5770R_REF_SEL(x)			(((x) & 0x3) << 0)

The outer brackets don't add anything much in all these cases.

> +
> +/* AD5770R_CH_ENABLE */
> +#define AD5770R_CH_SET(x, channel)		(((x) & 0x1) << (channel))
> +
> +#define AD5770R_MAX_CHANNELS	6
> +#define AD5770R_MAX_CH_MODES	14
> +#define AD5770R_LOW_VREF	1250
> +#define AD5770R_HIGH_VREF	2500
> +
> +enum ad5770r_ch {
> +	AD5770R_CH0 = 0,

As enums go this, one does seem a little unnecessary. Just use the
numbers directly.

> +	AD5770R_CH1,
> +	AD5770R_CH2,
> +	AD5770R_CH3,
> +	AD5770R_CH4,
> +	AD5770R_CH5
> +};
> +
> +enum ad5770r_ch0_modes {
> +	AD5770R_CH0_0_300 = 0,
> +	AD5770R_CH0_NEG_60_0,
> +	AD5770R_CH0_NEG_60_300
> +};
> +
> +enum ad5770r_ch1_modes {
> +	AD5770R_CH1_0_140_LOW_HEAD = 1,
> +	AD5770R_CH1_0_140_LOW_NOISE,
> +	AD5770R_CH1_0_250
> +};
> +
> +enum ad5770r_ch2_5_modes {
> +	AD5770R_CH_LOW_RANGE = 0,
> +	AD5770R_CH_HIGH_RANGE
> +};
> +
> +enum ad5770r_ref_v {
> +	AD5770R_EXT_2_5_V = 0,
> +	AD5770R_INT_1_25_V_OUT_ON,
> +	AD5770R_EXT_1_25_V,
> +	AD5770R_INT_1_25_V_OUT_OFF
> +};
> +
> +struct ad5770r_out_range {
> +	unsigned char	out_scale;
> +	unsigned char	out_range_mode;

u8 as these aren't characters, they just happen to be 8 bits.

> +};
> +
> +/**
> + * struct ad5770R_state - driver instance specific data
> + * @spi			spi_device

Some missing colons.  Run kernel-doc scripts against it to check the
formatting is correct.

> + * @regmap:		regmap
> + * @regulator		fixed regulator for reference configuration
> + * @gpio_reset		gpio descriptor
> + * @output_mode		array contains channels output ranges
> + * @vref		reference value
> + * @internal_ref	internal reference flag
> + * @ch_pwr_down		powerdown flags
> + */
> +struct ad5770r_state {
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +	struct regulator		*vref_reg;
> +	struct gpio_desc		*gpio_reset;
> +	struct ad5770r_out_range	output_mode[AD5770R_MAX_CHANNELS];
> +	int				vref;
> +	bool				internal_ref;
> +	bool				ch_pwr_down[AD5770R_MAX_CHANNELS];
> +};
> +
> +static const struct regmap_config ad5770r_spi_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(7),
> +};
> +
> +struct ad5770r_output_modes {
> +	enum ad5770r_ch ch;
> +	unsigned char mode;
> +	int min;
> +	int max;
> +};
> +
> +static struct ad5770r_output_modes ad5770r_rng_tbl[] = {
> +	{ AD5770R_CH0, AD5770R_CH0_0_300, 0, 300 },
> +	{ AD5770R_CH0, AD5770R_CH0_NEG_60_0, -60, 0 },
> +	{ AD5770R_CH0, AD5770R_CH0_NEG_60_300, -60, 300 },
> +	{ AD5770R_CH1, AD5770R_CH1_0_140_LOW_HEAD, 0, 140 },
> +	{ AD5770R_CH1, AD5770R_CH1_0_140_LOW_NOISE, 0, 140 },
> +	{ AD5770R_CH1, AD5770R_CH1_0_250, 0, 250 },
> +	{ AD5770R_CH2, AD5770R_CH_LOW_RANGE, 0, 55 },
> +	{ AD5770R_CH2, AD5770R_CH_HIGH_RANGE, 0, 150 },
> +	{ AD5770R_CH3, AD5770R_CH_LOW_RANGE, 0, 45 },
> +	{ AD5770R_CH3, AD5770R_CH_HIGH_RANGE, 0, 100 },
> +	{ AD5770R_CH4, AD5770R_CH_LOW_RANGE, 0, 45 },
> +	{ AD5770R_CH4, AD5770R_CH_HIGH_RANGE, 0, 100 },
> +	{ AD5770R_CH5, AD5770R_CH_LOW_RANGE, 0, 45 },
> +	{ AD5770R_CH5, AD5770R_CH_HIGH_RANGE, 0, 100 },
> +};
> +
> +static int ad5770r_set_output_mode(struct ad5770r_state *st,
> +				   const struct ad5770r_out_range *out_mode,
> +				   enum ad5770r_ch channel)
> +{
> +	unsigned int regval;
> +
> +	regval = AD5770R_RANGE_OUTPUT_SCALING(out_mode->out_scale) |
> +		 AD5770R_RANGE_MODE(out_mode->out_range_mode);
> +
> +	return regmap_write(st->regmap,
> +			    AD5770R_OUTPUT_RANGE(channel), regval);
> +}
> +
> +static int ad5770r_set_reference(struct ad5770r_state *st)
> +{
> +	unsigned int regval = 0;
> +
> +	if (st->internal_ref) {
> +		regval = AD5770R_REF_RESISTOR_SEL(0) |
> +			 AD5770R_REF_SEL(AD5770R_INT_1_25_V_OUT_OFF);
> +	} else {
> +		switch (st->vref) {
> +		case AD5770R_LOW_VREF:
> +			regval |= AD5770R_REF_SEL(AD5770R_EXT_1_25_V);
> +			break;
> +		case AD5770R_HIGH_VREF:
This is unusual. Please give comments on what is going on.

I thought vref would be a voltage but it seems you are sort of clamping
it without actually doing so..

> +			regval |= AD5770R_REF_SEL(AD5770R_EXT_2_5_V);
> +			break;
> +		default:
> +			regval = AD5770R_REF_RESISTOR_SEL(st->internal_ref) |
> +				 AD5770R_REF_SEL(AD5770R_INT_1_25_V_OUT_OFF);
> +			break;
> +		}
> +	}
> +
> +	return regmap_write(st->regmap, AD5770R_REFERENCE, regval);
> +}
> +
> +static int ad5770r_soft_reset(struct ad5770r_state *st)
> +{
> +	return regmap_write(st->regmap, AD5770R_INTERFACE_CONFIG_A,
> +			    AD5770R_ITF_CFG_A_SW_RESET(1));
> +}
> +
> +static int ad5770r_reset(struct ad5770r_state *st)
> +{
> +	if (st->gpio_reset) {
> +		gpiod_set_value(st->gpio_reset, 0);
> +		udelay(100);
> +		gpiod_set_value(st->gpio_reset, 1);
> +	} else {
> +		/* Perform a software reset */
> +		return ad5770r_soft_reset(st);
> +	}
> +
> +	/* data must not be written during reset timeframe */
> +	mdelay(1); /* TODO update with value from datasheet once available */
> +
> +	return 0;
> +}
> +
> +static int ad5770r_get_range(struct ad5770r_state *st,
> +			     enum ad5770r_ch ch, int *min, int *max)
> +{
> +	int i;
> +	unsigned char tbl_ch, tbl_mode, out_range;
> +
> +	out_range = st->output_mode[ch].out_range_mode;
> +
> +	for (i = 0; i < AD5770R_MAX_CH_MODES; i++) {
> +		tbl_ch = ad5770r_rng_tbl[i].ch;
> +		tbl_mode = ad5770r_rng_tbl[i].mode;
> +		if (tbl_ch == ch && tbl_mode == out_range) {
> +			*min = ad5770r_rng_tbl[i].min;
> +			*max = ad5770r_rng_tbl[i].max;

blank line here preferred.

> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5770r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct ad5770r_state *st = iio_priv(indio_dev);
> +	int max, min, ret;
> +	unsigned char buf[2];
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_bulk_read(st->regmap,
> +				       chan->address,
> +				       buf, 2);
> +		if (ret)
> +			return 0;
> +		*val = ((u16)buf[0] << 6) + (buf[1] >> 2);

Hmm. That's a slightly shifted endian conversion. So
perhaps neater as (and I may have this wrong)
le16_to_cpu(buf16) >> 2;
where buf16 is a local __le16 variable.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = ad5770r_get_range(st, chan->channel, &min, &max);
> +		if (ret < 0)
> +			return ret;
> +		if (min < 0)
> +			min = 0;
> +		*val = max - min;

This needs some explanation.  Why are none of the 14 bits used for
the negative part?

> +		*val2 = 14;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5770r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long info)
> +{
> +	struct ad5770r_state *st = iio_priv(indio_dev);
> +	unsigned char buf[2];
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		buf[0] = ((u16)val >> 6) & 0xFF;
> +		buf[1] = (val & 0x3F) << 2;
> +		return regmap_bulk_write(st->regmap, chan->address,
> +					 buf, ARRAY_SIZE(buf));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5770r_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int writeval,
> +			      unsigned int *readval)
> +{
> +	struct ad5770r_state *st = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +	else
> +		return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static const struct iio_info ad5770r_info = {
> +	.read_raw = ad5770r_read_raw,
> +	.write_raw = ad5770r_write_raw,
> +	.debugfs_reg_access = &ad5770r_reg_access,
> +};
> +
> +static int ad5770r_store_output_range(struct ad5770r_state *st,
> +				      int min, int max, int index)
> +{
> +	int i;
> +
> +	for (i = 0; i < AD5770R_MAX_CH_MODES; i++) {
> +		if (ad5770r_rng_tbl[i].ch != index)
> +			continue;
> +		if (ad5770r_rng_tbl[i].min != min ||
> +		    ad5770r_rng_tbl[i].max != max)
> +			continue;
> +		st->output_mode[index].out_range_mode = ad5770r_rng_tbl[i].mode;

blank line here slightly aids readability (very slightly!)

> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t ad5770r_read_dac_powerdown(struct iio_dev *indio_dev,
> +		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct ad5770r_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->ch_pwr_down[chan->channel]);
> +}
> +
> +static ssize_t ad5770r_write_dac_powerdown(struct iio_dev *indio_dev,
> +		uintptr_t private, const struct iio_chan_spec *chan,
> +		const char *buf, size_t len)
> +{
> +	struct ad5770r_state *st = iio_priv(indio_dev);
> +	unsigned int regval;
> +	bool readin;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &readin);
> +	if (ret)
> +		return ret;
> +
> +	readin = !readin;
> +
> +	regval = AD5770R_CFG_SHUTDOWN_B(readin, chan->channel);
This is an odd mixture of using local variables and not.  I would
have variables for regval and the mask.  Then just do the regmap_update_bits
outside the if statement.

> +	if (chan->channel == AD5770R_CH0 &&
> +	    st->output_mode[AD5770R_CH0].out_range_mode > AD5770R_CH0_0_300) {
> +		regval |= AD5770R_CFG_CH0_SINK_EN(readin);
> +		ret = regmap_update_bits(st->regmap, AD5770R_CHANNEL_CONFIG,
> +					 BIT(chan->channel) + BIT(7), regval);
> +	} else {
> +		ret = regmap_update_bits(st->regmap, AD5770R_CHANNEL_CONFIG,
> +					 BIT(chan->channel), regval);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	regval = AD5770R_CH_SET(readin, chan->channel);
> +	ret = regmap_update_bits(st->regmap, AD5770R_CH_ENABLE,
> +				 BIT(chan->channel), regval);
> +	if (ret)
> +		return ret;
> +
> +	st->ch_pwr_down[chan->channel] = !readin;
> +

How did you get here with ret set?
 
return len;

> +	return ret ? ret : len;
> +}
> +
> +static const struct iio_chan_spec_ext_info ad5770r_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = ad5770r_read_dac_powerdown,
> +		.write = ad5770r_write_dac_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{ },
> +};
> +
> +#define AD5770R_IDAC_CHANNEL(index, reg) {			\
> +	.type = IIO_CURRENT,					\
> +	.address = reg,						\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.output = 1,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			BIT(IIO_CHAN_INFO_SCALE),		\
> +	.ext_info = ad5770r_ext_info,				\
> +}
> +
> +static const struct iio_chan_spec ad5770r_channels[] = {
> +	AD5770R_IDAC_CHANNEL(0, AD5770R_DAC_MSB(0)),
> +	AD5770R_IDAC_CHANNEL(1, AD5770R_DAC_MSB(1)),
> +	AD5770R_IDAC_CHANNEL(2, AD5770R_DAC_MSB(2)),
> +	AD5770R_IDAC_CHANNEL(3, AD5770R_DAC_MSB(3)),
> +	AD5770R_IDAC_CHANNEL(4, AD5770R_DAC_MSB(4)),
> +	AD5770R_IDAC_CHANNEL(5, AD5770R_DAC_MSB(5)),
> +};
> +
> +static int ad5770r_channel_config(struct ad5770r_state *st)
> +{
> +	int ret, tmp[2], min, max, i;
> +	unsigned int num;
> +	struct fwnode_handle *child;
> +	bool ch_config[AD5770R_MAX_CHANNELS] = {0};
> +
> +	device_for_each_child_node(&st->spi->dev, child) {
> +		ret = fwnode_property_read_u32(child, "num", &num);
> +		if (ret)
> +			return ret;
> +		if (num > AD5770R_MAX_CHANNELS)
> +			return -EINVAL;
> +
> +		ret = fwnode_property_read_u32_array(child,
> +						     "adi,range-microamp",
> +						     tmp, 2);
> +		if (ret)
> +			return ret;
> +
> +		min = tmp[0] / 1000;
> +		max = tmp[1] / 1000;
> +		ret = ad5770r_store_output_range(st, min, max, num);
> +		if (ret)
> +			return ret;
> +
> +		ch_config[num] = true;
> +	}
> +
> +	for (i = 0; i < AD5770R_MAX_CHANNELS; i++)
> +		if (!ch_config[i])
> +			return -EINVAL;
> +
> +	return ret;
> +}
> +
> +static int ad5770r_init(struct ad5770r_state *st)
> +{
> +	int ret, i;
> +
> +	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> +			 GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->gpio_reset))
> +		return PTR_ERR(st->gpio_reset);
> +
> +	/* Perform a reset */
> +	ret = ad5770r_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Set output range */
> +	ret = ad5770r_channel_config(st);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < AD5770R_MAX_CHANNELS; i++) {
> +		ret = ad5770r_set_output_mode(st,
> +					      &st->output_mode[i], i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ad5770r_set_reference(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Set outputs off */
> +	ret = regmap_write(st->regmap, AD5770R_CHANNEL_CONFIG, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD5770R_CH_ENABLE, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < AD5770R_MAX_CHANNELS; i++)
> +		st->ch_pwr_down[i] = true;
> +
> +	return ret;
> +}
> +
> +static int ad5770r_probe(struct spi_device *spi)
> +{
> +	struct ad5770r_state *st;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st->spi = spi;
> +
> +	regmap = devm_regmap_init_spi(spi, &ad5770r_spi_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +	st->regmap = regmap;
> +
> +	st->vref_reg = devm_regulator_get(&spi->dev, "vref");
> +	if (!IS_ERR(st->vref_reg)) {
> +		ret = regulator_enable(st->vref_reg);

You don't ever seem to disable this regulator in the error paths or
the remove.  If you want to use devm_ managed code
the use the devm_ action stuff to make sure this is disabled
in the right sequence.

I think, if this is a regulator that actually has an enable, the result
of this is you will leave it on when removing rather than disabling it
if there are no other users.

> +		if (ret)
> +			dev_err(&spi->dev, "Failed to enable vref regulators: %d\n",
> +				ret);
> +
> +		ret = regulator_get_voltage(st->vref_reg);
> +		if (ret < 0) {

That's not right.  If the regulator is effectively optional, use
the regulator_get_optional above rather than noticing only here.

> +			st->vref = AD5770R_LOW_VREF;
> +			st->internal_ref = true;
> +		} else {
> +			st->vref = ret / 1000;
> +		}
> +	} else {
> +		st->vref = AD5770R_LOW_VREF;
> +		st->internal_ref = true;
> +	}
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->info = &ad5770r_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad5770r_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad5770r_channels);
> +
> +	ret = ad5770r_init(st);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "AD5770R init failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&st->spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad5770r_id[] = {
> +	{ "ad5770r", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad5770r_id);
> +
> +static struct spi_driver ad5770r_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +	.probe = ad5770r_probe,
> +	.id_table = ad5770r_id,
> +};
> +
> +module_spi_driver(ad5770r_driver);
> +
> +MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5770R IDAC");
> +MODULE_LICENSE("GPL v2");

