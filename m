Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C581C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A4B2147E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUJGhW0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A4B2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeHSTu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbeHSTu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:50:57 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F202064A;
        Sun, 19 Aug 2018 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534696734;
        bh=qKJ7hAr7gvU/wY7YFKnjeT3X4yW2TFVaqM3AySplmFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kUJGhW0rnUdMW4osnC2pvaY0Krg7MWLVkZRDa0LFNXsh2X7N5wYPcmT2/JJ39ddSD
         Wgh/MBQkTPxtXmX9Pw6hxb9xtp7Axyf1l8jM79KCJdnxmsEKzsZQ3G6Kwkb13MiyeF
         2AwA6grgs2G3H9WScwaMmroBw5c+00BUOX+YR93c=
Date:   Sun, 19 Aug 2018 17:38:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: dac: add support for ltc166x
Message-ID: <20180819173850.3d55ea7e@archlinux>
In-Reply-To: <20180811200226.28776-1-marcus.folkesson@gmail.com>
References: <20180811200226.28776-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 22:02:24 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter
> (DAC) with eight individual channels.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

So first rule we try to stick to that this breaks is never use wild cards
in drivers.  You probably wouldn't believe how often this has gone wrong with
a manufacturer deciding to use other values that wild card covers...

Please pick a part and name everything after that.  Either one is fine.

A few really minor things inline.  Nice little driver.

Thanks,

Jonathan


> ---
>  drivers/iio/dac/Kconfig   |  10 ++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/ltc166x.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/iio/dac/ltc166x.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 76db0768e454..04cfa6bb9dc1 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -120,6 +120,16 @@ config AD5624R_SPI
>  	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
>  	  AD5664R converters (DAC). This driver uses the common SPI interface.
>  
> +config LTC166X
> +	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Linear Technology
> +	  LTC1660 and LTC1665 Digital to Analog Converters.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ltc166x.
> +
>  config LTC2632
>  	tristate "Linear Technology LTC2632-12/10/8 DAC spi driver"
>  	depends on SPI
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 81e710ed7491..380749c87c26 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_CIO_DAC) += cio-dac.o
>  obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
>  obj-$(CONFIG_DS4424) += ds4424.o
>  obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
> +obj-$(CONFIG_LTC166X) += ltc166x.o
>  obj-$(CONFIG_LTC2632) += ltc2632.o
>  obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
> diff --git a/drivers/iio/dac/ltc166x.c b/drivers/iio/dac/ltc166x.c
> new file mode 100644
> index 000000000000..0031f2b50f14
> --- /dev/null
> +++ b/drivers/iio/dac/ltc166x.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Linear Technology LTC1665/LTC1660, 8 channels DAC
> + *
> + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> + */
> +#include <linux/bitops.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#define LTC166X_REG_WAKE	0x0
> +#define LTC166X_REG_DAC_A	0x1
> +#define LTC166X_REG_DAC_B	0x2
> +#define LTC166X_REG_DAC_C	0x3
> +#define LTC166X_REG_DAC_D	0x4
> +#define LTC166X_REG_DAC_E	0x5
> +#define LTC166X_REG_DAC_F	0x6
> +#define LTC166X_REG_DAC_G	0x7
> +#define LTC166X_REG_DAC_H	0x8
> +#define LTC166X_REG_SLEEP	0xe
> +
> +#define LTC166X_NUM_CHANNELS	8
> +
> +static const struct regmap_config ltc166x_regmap_config = {
> +	.reg_bits = 4,
> +	.val_bits = 12,
> +};
> +
> +enum ltc166x_supported_device_ids {
> +	ID_LTC1660,
> +	ID_LTC1665,
> +};
> +
> +struct ltc166x_priv {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	struct regulator *vref_reg;
> +	unsigned int value[LTC166X_NUM_CHANNELS];
> +	unsigned int vref_mv;
> +};
> +
> +static int ltc166x_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan,
> +		int *val,
> +		int *val2,
> +		long mask)
> +{
> +	struct ltc166x_priv *priv = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = priv->value[chan->channel];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = priv->vref_mv;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc166x_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan,
> +		int val,
> +		int val2,
> +		long mask)
> +{
> +	struct ltc166x_priv *priv = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		if (val > GENMASK(chan->scan_type.realbits-1, 0))
> +			return -EINVAL;

nothing makes val positive..  Also spaces around the '-'.


> +		priv->value[chan->channel] = val;
> +		val <<= chan->scan_type.shift;
> +		return regmap_write(priv->regmap, chan->channel, val);

Given that this could fail, usual convention is set the cached value
priv->value[] only after we know the write succeeded.  

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define LTC166X_CHAN(chan, bits) {			\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.output = 1,					\
> +	.channel = chan,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.scan_type = {					\
> +		.sign = 'u',				\

Supplying this for a DAC is unusual given scan_type only becomes relevant
(in the IIO core) when we have buffers involved.  For output devices
we don't currently have buffered support.

Hmm. You are using it as a convenient stashing location though so perhaps
fair enough.. You could only specify the realbits and shift, but that seems
a bit odd so perhaps best to leave this as it is.


> +		.realbits = (bits),			\
> +		.storagebits = 16,			\
> +		.shift = 12 - (bits),			\
> +	},						\
> +}
> +
> +#define  LTC166X_OCTAL_CHANNELS(bits) {			\
> +		LTC166X_CHAN(LTC166X_REG_DAC_A, bits),	\
> +		LTC166X_CHAN(LTC166X_REG_DAC_B, bits),	\
> +		LTC166X_CHAN(LTC166X_REG_DAC_C, bits),	\
> +		LTC166X_CHAN(LTC166X_REG_DAC_D, bits),	\
> +		LTC166X_CHAN(LTC166X_REG_DAC_E, bits),	\
> +		LTC166X_CHAN(LTC166X_REG_DAC_F, bits),	\
> +		LTC166X_CHAN(LTC166X_REG_DAC_G, bits),	\
> +		LTC166X_CHAN(LTC166X_REG_DAC_H, bits),	\
> +}
> +
> +static const struct iio_chan_spec ltc166x_channels[][LTC166X_NUM_CHANNELS] = {
> +	[ID_LTC1660] = LTC166X_OCTAL_CHANNELS(10),
> +	[ID_LTC1665] = LTC166X_OCTAL_CHANNELS(8),
> +};
> +
> +static const struct iio_info ltc166x_info = {
> +	.read_raw = &ltc166x_read_raw,
> +	.write_raw = &ltc166x_write_raw,
> +};
> +
> +static int __maybe_unused ltc166x_suspend(struct device *dev)
> +{
> +	struct ltc166x_priv *priv = iio_priv(spi_get_drvdata(
> +						to_spi_device(dev)));
> +	return regmap_write(priv->regmap, LTC166X_REG_SLEEP, 0x00);
> +}
> +
> +static int __maybe_unused ltc166x_resume(struct device *dev)
> +{
> +	struct ltc166x_priv *priv = iio_priv(spi_get_drvdata(
> +						to_spi_device(dev)));
> +	return regmap_write(priv->regmap, LTC166X_REG_WAKE, 0x00);
> +}
> +static SIMPLE_DEV_PM_OPS(ltc166x_pm_ops, ltc166x_suspend, ltc166x_resume);
> +
> +static int ltc166x_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ltc166x_priv *priv;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->regmap = devm_regmap_init_spi(spi, &ltc166x_regmap_config);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(&spi->dev, "failed to register spi regmap %ld\n",
> +			PTR_ERR(priv->regmap));
> +		return PTR_ERR(priv->regmap);
> +	}
> +
> +	priv->vref_reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(priv->vref_reg)) {
> +		dev_err(&spi->dev, "vref regulator not specified\n");
> +		return PTR_ERR(priv->vref_reg);
> +	}
> +
> +	ret = regulator_enable(priv->vref_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to enable vref regulator: %d\n",
> +				ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_get_voltage(priv->vref_reg);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "failed to read vref regulator: %d\n",
> +				ret);
> +		goto error_disable_reg;
> +	}
> +	priv->vref_mv = ret / 1000;

It is admittedly fairly unlikely that someone might share this regulator
across multiple devices, but in theory this might change.

So I'd slightly prefer this read being done where we actually need
the answer, so in the read_raw callback.

Lots of drivers do it in the wrong place and given how unlikely such
as setup is, I'm not that fussy about it.  However as you need to respin
anyway for the naming, we might as well make this perfect.

> +
> +	priv->spi = spi;
> +	spi_set_drvdata(spi, indio_dev);
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &ltc166x_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ltc166x_channels[id->driver_data];
> +	indio_dev->num_channels = LTC166X_NUM_CHANNELS;
> +	indio_dev->name = id->name;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to register iio device: %d\n",
> +				ret);
> +		goto error_disable_reg;
> +	}
> +
> +	return 0;
> +
> +error_disable_reg:
> +	regulator_disable(priv->vref_reg);
> +
> +	return ret;
> +}
> +
> +static int ltc166x_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ltc166x_priv *priv = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(priv->vref_reg);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ltc166x_dt_ids[] = {
> +	{ .compatible = "lltc,ltc1660", .data = (void *)ID_LTC1660 },
> +	{ .compatible = "lltc,ltc1665", .data = (void *)ID_LTC1665 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ltc166x_dt_ids);
> +
> +static const struct spi_device_id ltc166x_id[] = {
> +	{"ltc1660", ID_LTC1660},
> +	{"ltc1665", ID_LTC1665},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(spi, ltc166x_id);
> +
> +static struct spi_driver ltc166x_driver = {
> +	.driver = {
> +		.name = "ltc166x",
> +		.of_match_table = ltc166x_dt_ids,
> +		.pm = &ltc166x_pm_ops,
> +	},
> +	.probe	= ltc166x_probe,
> +	.remove = ltc166x_remove,
> +	.id_table = ltc166x_id,
> +};
> +module_spi_driver(ltc166x_driver);
> +
> +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> +MODULE_DESCRIPTION("Linear Technology LTC166X DAC");
> +MODULE_LICENSE("GPL v2");

