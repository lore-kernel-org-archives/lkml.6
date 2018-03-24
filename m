Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELu5nbFjzI/4NStz+Pz09IYj9PEwwDbJ8KacY5InU6LpPMYR/zeh6B60qTYTpxeKQpgKXLca
ARC-Seal: i=1; a=rsa-sha256; t=1521900226; cv=none;
        d=google.com; s=arc-20160816;
        b=caX6+JdjCd4WumIxyR89TFV6khzRTnZEPmMtgnEWBSDWy1KYVmnxfmmNQdz8jAm1TE
         AdDZGC6ozQuwpJKmfD83RYOl8okmOC0BLHEcfuu//RrvAUBisA2LzISI7mcMKoeHPBxB
         xcc9KdCR63Yr57rbZS01S1ZzentE+0BJF/fS9criStVEbv4OKjnDpuxhSjSchHsUyUGK
         KU8qWyglGHZaDzdcjW6CjRw/fv6cVbDoFb8bx/rcak0k7ZVaNAipyVz/MEDMrF+skJyl
         UKipV5hlAc5beprORWDw+tadTw8gmX7uVhs6AfN9non/j0QSLMffLEmdFmtBjI60rX/L
         Mf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=+8i1nCMACQoHvc3vd4azIFJ0Ux7ln3BLs4Jr4usE1VM=;
        b=CA7WLi1eyXsd7YkIYOhsyIUnS9+gVNE+8FzsWcMumZN/r+SndP+8GQ15i5KLxK9HOk
         VH7Hj66H7XYBZr5RH4zEgpsrK5BSoHSR1ZwPKYIDZuLt0BkwOHGBypQSOf4DWAnS1M9K
         O6pMY0JFargpF495huUeZjLD7VGNyAlIWZNSI7JkLhduwJ5f21q4lysLiqHfToWWIzPv
         U9dUSCgaevzCCnGpObS96cUDTCAUvpK+Hp6APdVI3nM3cQBchnPMnMA4d35M7Lgyks2S
         YmKhlJybqd+90rG0f+vSN9OtvLqnNoQgJJ5FZSkbM/XP9s8+RklMqn1SRIYnasEBdctf
         mNpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7DA2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 14:03:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: wrapper: unit-converter: new driver
Message-ID: <20180324140339.4ec66792@archlinux>
In-Reply-To: <20180319170246.26830-4-peda@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
	<20180319170246.26830-4-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386357743794195?=
X-GMAIL-MSGID: =?utf-8?q?1595828051351786719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Mar 2018 18:02:46 +0100
Peter Rosin <peda@axentia.se> wrote:

> If an ADC channel measures the midpoint of a voltage divider, the
> interesting voltage is often the voltage over the full resistance.
> E.g. if the full voltage it too big for the ADC to handle.
> Likewise, if an ADC channel measures the voltage across a resistor,
> the interesting value is often the current through the resistor.
> 
> This driver solves both problems by allowing to linearly scale a channel
> and by allowing changes to the type of the channel. Or both.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
A few comments inline, but basically the code looks fine, just questions
around naming and bindings to answer.

Thanks,

Jonathan

> ---
>  MAINTAINERS                              |   1 +
>  drivers/iio/wrapper/Kconfig              |   9 ++
>  drivers/iio/wrapper/Makefile             |   1 +
>  drivers/iio/wrapper/iio-unit-converter.c | 268 +++++++++++++++++++++++++++++++
>  4 files changed, 279 insertions(+)
>  create mode 100644 drivers/iio/wrapper/iio-unit-converter.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5dd555c7b1b0..b879289f1318 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6889,6 +6889,7 @@ M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> +F:	drivers/iio/wrapper/iio-unit-converter.c
>  
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
> diff --git a/drivers/iio/wrapper/Kconfig b/drivers/iio/wrapper/Kconfig
> index f27de347c9b3..16554479264a 100644
> --- a/drivers/iio/wrapper/Kconfig
> +++ b/drivers/iio/wrapper/Kconfig
> @@ -15,4 +15,13 @@ config IIO_MUX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called iio-mux.
>  
> +config IIO_UNIT_CONVERTER
> +	tristate "IIO unit converter"
> +	depends on OF || COMPILE_TEST
> +	help
> +	  Say yes here to build support for the IIO unit converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called iio-unit-converter.
> +
>  endmenu
> diff --git a/drivers/iio/wrapper/Makefile b/drivers/iio/wrapper/Makefile
> index 53a7b78734e3..1b9db53bd420 100644
> --- a/drivers/iio/wrapper/Makefile
> +++ b/drivers/iio/wrapper/Makefile
> @@ -4,3 +4,4 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_IIO_MUX) += iio-mux.o
> +obj-$(CONFIG_IIO_UNIT_CONVERTER) += iio-unit-converter.o
> diff --git a/drivers/iio/wrapper/iio-unit-converter.c b/drivers/iio/wrapper/iio-unit-converter.c
> new file mode 100644
> index 000000000000..53c126f39e4e
> --- /dev/null
> +++ b/drivers/iio/wrapper/iio-unit-converter.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO unit converter
> + *
> + * Copyright (C) 2018 Axentia Technologies AB
> + *
> + * Author: Peter Rosin <peda@axentia.se>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +struct unit_converter {
> +	struct iio_channel *parent;
> +	struct iio_dev *indio_dev;
> +	struct iio_chan_spec chan;
> +	struct iio_chan_spec_ext_info *ext_info;
> +	s32 numerator;
> +	s32 denominator;
> +};
> +
> +static int unit_converter_read_raw(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, long mask)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +	unsigned long long tmp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return iio_read_channel_raw(uc->parent, val);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_read_channel_scale(uc->parent, val, val2);
> +		switch (ret) {
> +		case IIO_VAL_FRACTIONAL:
> +			*val *= uc->numerator;
> +			*val2 *= uc->denominator;
> +			return ret;
> +		case IIO_VAL_INT:
> +			*val *= uc->numerator;
> +			if (uc->denominator == 1)
> +				return ret;
> +			*val2 = uc->denominator;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp = *val * 1000000000LL;
> +			do_div(tmp, uc->denominator);
> +			tmp *= uc->numerator;
> +			do_div(tmp, 1000000000LL);
> +			*val = tmp;
> +			return ret;
> +		}
> +		return -EOPNOTSUPP;
Slightly clearer and less likely to give warningss from static checkers
if you put that return in a default:

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int unit_converter_read_avail(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     const int **vals, int *type, int *length,
> +				     long mask)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*type = IIO_VAL_INT;
> +		return iio_read_avail_channel_raw(uc->parent, vals, length);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int unit_converter_write_raw(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    int val, int val2, long mask)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return iio_write_channel_raw(uc->parent, val);
Talk me through the logic of having this...  Supporting a DAC?
Bindings don't talk about that possibility...

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info unit_converter_info = {
> +	.read_raw = unit_converter_read_raw,
> +	.read_avail = unit_converter_read_avail,
> +	.write_raw = unit_converter_write_raw,
> +};
> +
> +static ssize_t unit_converter_read_ext_info(struct iio_dev *indio_dev,
> +					    uintptr_t private,
> +					    struct iio_chan_spec const *chan,
> +					    char *buf)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +
> +	return iio_read_channel_ext_info(uc->parent,
> +					 uc->ext_info[private].name,
> +					 buf);
> +}
> +
> +static ssize_t unit_converter_write_ext_info(struct iio_dev *indio_dev,
> +					     uintptr_t private,
> +					     struct iio_chan_spec const *chan,
> +					     const char *buf, size_t len)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +
> +	return iio_write_channel_ext_info(uc->parent,
> +					  uc->ext_info[private].name,
> +					  buf, len);
> +}
> +
> +static int unit_converter_configure_channel(struct device *dev,
> +					    struct unit_converter *uc,
> +					    enum iio_chan_type type)
> +{
> +	struct iio_chan_spec *chan = &uc->chan;
> +	struct iio_chan_spec const *pchan = uc->parent->channel;
> +	int ret;
> +
> +	chan->indexed = 1;
> +	chan->output = pchan->output;
> +	chan->ext_info = uc->ext_info;
> +
> +	if (type == -1) {
> +		ret = iio_get_channel_type(uc->parent, &type);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get parent channel type\n");
> +			return ret;
> +		}
> +	}
> +	chan->type = type;
> +
> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
if the parent doesn't support RAW, is there a lot of point in carrying on?

> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> +
> +	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
> +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> +
> +	chan->channel = 0;
> +
> +	return 0;
> +}
> +
> +static int unit_converter_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct iio_channel *parent;
> +	struct unit_converter *uc;
> +	const char *type_name;
> +	enum iio_chan_type type = -1; /* default to same as parent */
> +	int sizeof_ext_info;
> +	int sizeof_priv;
> +	int i;
> +	int ret;
> +
> +	if (!device_property_read_string(dev, "type", &type_name)) {
> +		if (!strcmp(type_name, "voltage"))
> +			type = IIO_VOLTAGE;
> +		else if (!strcmp(type_name, "current"))
> +			type = IIO_CURRENT;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	parent = devm_iio_channel_get(dev, "parent");
> +	if (IS_ERR(parent)) {
> +		if (PTR_ERR(parent) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get parent channel\n");
> +		return PTR_ERR(parent);
> +	}
> +
> +	sizeof_ext_info = iio_get_channel_ext_info_count(parent);
> +	if (sizeof_ext_info) {
> +		sizeof_ext_info += 1; /* one extra entry for the sentinel */
> +		sizeof_ext_info *= sizeof(*uc->ext_info);
> +	}
> +
> +	sizeof_priv = sizeof(*uc) + sizeof_ext_info;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof_priv);
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	uc = iio_priv(indio_dev);
> +
> +	uc->numerator = 1;
> +	uc->denominator = 1;
> +	device_property_read_u32(dev, "numerator", &uc->numerator);
> +	device_property_read_u32(dev, "denominator", &uc->denominator);
> +	if (!uc->numerator || !uc->denominator) {
> +		dev_err(dev, "invalid scaling factor.\n");
> +		return -EINVAL;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	uc->parent = parent;
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &unit_converter_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &uc->chan;
> +	indio_dev->num_channels = 1;
> +	if (sizeof_ext_info) {
> +		uc->ext_info = devm_kmemdup(dev,
> +					    parent->channel->ext_info,
> +					    sizeof_ext_info, GFP_KERNEL);
> +		if (!uc->ext_info)
> +			return -ENOMEM;
> +
> +		for (i = 0; uc->ext_info[i].name; ++i) {
> +			if (parent->channel->ext_info[i].read)
> +				uc->ext_info[i].read = unit_converter_read_ext_info;
> +			if (parent->channel->ext_info[i].write)
> +				uc->ext_info[i].write = unit_converter_write_ext_info;
> +			uc->ext_info[i].private = i;
> +		}
> +	}
> +
> +	ret = unit_converter_configure_channel(dev, uc, type);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register iio device\n");
> +		return ret;
> +	}
Drop the return out of the brackets and get rid of return 0 below.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id unit_converter_match[] = {
> +	{ .compatible = "io-channel-unit-converter" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, unit_converter_match);
> +
> +static struct platform_driver unit_converter_driver = {
> +	.probe = unit_converter_probe,
> +	.driver = {
> +		.name = "iio-unit-converter",
> +		.of_match_table = unit_converter_match,
> +	},
> +};
> +module_platform_driver(unit_converter_driver);
> +
> +MODULE_DESCRIPTION("IIO unit converter driver");
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> +MODULE_LICENSE("GPL v2");
