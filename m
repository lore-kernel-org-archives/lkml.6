Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF60C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2477920877
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIW9I46b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2477920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeGVJEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 05:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbeGVJEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 05:04:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA612086A;
        Sun, 22 Jul 2018 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532246923;
        bh=HQNNpAlCu6GihY+nxPRJyruGYEzWzxLzz3CWFmhSd+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gIW9I46bv2P2U5mdpV0FVib+AfqqwV6E7DRX3TPeR5fJNppADcq9OoRWyattXejk4
         KnEzRgzYfLjzZpoaDZSdbx+yYrC8S8cLNAQPz1Up0kVtMQD/XYW1AvFRrQy+0UX8qO
         Vm7eU2RsbjybR3yNJgXVVJK4asF9o/iBkQUiOHQ0=
Date:   Sun, 22 Jul 2018 09:08:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: add support for mcp3911
Message-ID: <20180722090838.0080aaf5@archlinux>
In-Reply-To: <alpine.DEB.2.21.1807212259480.13457@vps.pmeerw.net>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
        <alpine.DEB.2.21.1807212259480.13457@vps.pmeerw.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 23:19:48 +0200 (CEST)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> Hello,
> 
> > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).  
> 
> some comments below...

+CC Mark for the unusual SPI addressing stuff.  I'm mostly interested in what
precedent there is for bindings etc.

>  
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Signed-off-by: Kent Gustavsson <kent@minoris.se>
> > ---
> >  drivers/iio/adc/Kconfig   |  10 ++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/mcp3911.c | 444 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 455 insertions(+)
> >  create mode 100644 drivers/iio/adc/mcp3911.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 15606f237480..f9a41fa96fcc 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -501,6 +501,16 @@ config MCP3422
> >  	  This driver can also be built as a module. If so, the module will be
> >  	  called mcp3422.
> >  
> > +config MCP3911
> > +	tristate "Microchip Technology MCP3911 driver"
> > +	depends on SPI
> > +	help
> > +	  Say yes here to build support for Microchip Technology's MCP3911
> > +	  analog to digital converter.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called mcp3911.
> > +
> >  config MEDIATEK_MT6577_AUXADC
> >          tristate "MediaTek AUXADC driver"
> >          depends on ARCH_MEDIATEK || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 28a9423997f3..3cfebfff7d26 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_MAX1363) += max1363.o
> >  obj-$(CONFIG_MAX9611) += max9611.o
> >  obj-$(CONFIG_MCP320X) += mcp320x.o
> >  obj-$(CONFIG_MCP3422) += mcp3422.o
> > +obj-$(CONFIG_MCP3911) += mcp3911.o
> >  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
> >  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
> >  obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
> > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > new file mode 100644
> > index 000000000000..be74cb15827b
> > --- /dev/null
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -0,0 +1,444 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Microchip MCP3911, Two-channel Analog Front End
> > + *
> > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> > + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
> > + *

No need for blank line here.

> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define MCP3911_REG_CHANNEL0		0x00
> > +#define MCP3911_REG_CHANNEL1		0x03
> > +#define MCP3911_REG_MOD			0x06
> > +#define MCP3911_REG_PHASE		0x07
> > +
> > +#define MCP3911_REG_GAIN		0x09
> > +#define MCP3911_GAIN_MASK(ch)		(0x7 << 3*ch)  
> 
> space around * operator, maybe parenthesis around variable, i.e
> (0x07 << (3 * (ch)))
> 
> > +#define MCP3911_GAIN_VAL(ch, val)	((val << 3*ch) & MCP3911_GAIN_MASK(ch))
> > +
> > +#define MCP3911_REG_STATUSCOM		0x0a
> > +#define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
> > +#define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
> > +#define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
> > +#define MCP3911_STATUSCOM_EN_GAINCAL	BIT(1)
> > +
> > +#define MCP3911_REG_CONFIG		0x0c
> > +#define MCP3911_CONFIG_CLKEXT		BIT(1)
> > +#define MCP3911_CONFIG_VREFEXT		BIT(2)
> > +
> > +#define MCP3911_REG_OFFCAL_CH0		0x0e
> > +#define MCP3911_REG_GAINCAL_CH0		0x11
> > +#define MCP3911_REG_OFFCAL_CH1		0x14
> > +#define MCP3911_REG_GAINCAL_CH1		0x17
> > +#define MCP3911_REG_VREFCAL		0x1a
> > +
> > +#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
> > +#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
> > +#define MCP3911_GAINCAL(x)		(MCP3911_REG_GAINCAL_CH0 + x * 6)
> > +  
> 
> delete newline
> 
> > +
> > +/* Internal voltage reference in uV */
> > +#define MCP3911_INT_VREF_UV		1200000
> > +
> > +#define REG_READ(reg, id)	(((reg << 1) | (id << 5) | (1 << 0)) & 0xff)
> > +#define REG_WRITE(reg, id)	(((reg << 1) | (id << 5) | (0 << 0)) & 0xff)  
> 
> MCP3911_ prefix please
> parenthesis around variables
> 
> > +
> > +#define MCP3911_NUM_CHANNELS		2
> > +
> > +
> > +struct mcp3911 {
> > +	struct spi_device *spi;
> > +	struct device_node *np;
> > +	struct mutex lock;
> > +
> > +	u32 gain[MCP3911_NUM_CHANNELS];
> > +	u32 width[MCP3911_NUM_CHANNELS];
> > +
> > +	u32 dev_addr;
> > +	bool vrefext;
> > +	struct regulator *vref;
> > +};
> > +
> > +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> > +{
> > +	int ret;
> > +
> > +	reg = REG_READ(reg, adc->dev_addr);
> > +	ret = spi_write_then_read(adc->spi, &reg, 1, val, len);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val <<= ((4-len)*8);  
> 
> space around - and * operator, here and elsewhere
> 
> shouldn't the endiness conversion happen before the value is shifted? 
> (here and below)?
> 
> > +	be32_to_cpus(val);
> > +	dev_dbg(&adc->spi->dev, "Reading 0x%x from register 0x%x\n", *val,
> > +			reg>>1);
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
> > +{
> > +	dev_dbg(&adc->spi->dev, "Writing 0x%x to register 0x%x\n", val, reg);
> > +
> > +	cpu_to_be32s(&val);
> > +	val >>= (3-len)*8;
Hmm. It might be worth considering regmap here to handle all this stuff for
you rather than re rolling the same stuff.

> > +	val |= REG_WRITE(reg, adc->dev_addr);
> > +
> > +	return spi_write(adc->spi, &val, len+1);
> > +}
> > +
> > +static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
> > +		u32 val, u8 len)
> > +{
> > +	u32 tmp;
> > +	int ret;
> > +
> > +	ret = mcp3911_read(adc, reg, &tmp, len);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val &= mask;
> > +	val |= tmp & ~mask;
> > +	return mcp3911_write(adc, reg, val, len);
> > +}
> > +
> > +static int mcp3911_get_hwgain(struct mcp3911 *adc, u8 channel, u32 *val)
> > +{
> > +	int ret = mcp3911_read(adc, MCP3911_REG_GAIN, val, 1);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val >>= channel*3;
> > +	*val &= 0x07;
> > +	*val = (1 << *val);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mcp3911_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *channel, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct mcp3911 *adc = iio_priv(indio_dev);
> > +	int ret = -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = mcp3911_read(adc,
> > +				MCP3911_CHANNEL(channel->channel), val, 3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		ret = mcp3911_read(adc,
> > +				MCP3911_OFFCAL(channel->channel), val, 3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > +		ret = mcp3911_get_hwgain(adc, channel->channel, val);

I'm not convinced it's useful to expose this as it right control for this
is scale.

> > +		if (ret)
> > +			goto out;
> > +
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (adc->vrefext) {
> > +			ret = regulator_get_voltage(adc->vref);
> > +			if (ret < 0) {
> > +				dev_err(indio_dev->dev.parent,
> > +					"failed to get vref voltage:%d\n", ret);  
> 
> start message consistently with upper/lowercase
> maybe space before :
> 
> > +				goto out;
> > +			}
> > +
> > +			*val = ret / 1000;
> > +		} else {
> > +			*val = MCP3911_INT_VREF_UV;
> > +		}
> > +
> > +		/* apply with gain value */
> > +		*val /= adc->gain[channel->channel];
> > +		*val2 = adc->width[channel->channel];
> > +
> > +		ret = IIO_VAL_FRACTIONAL_LOG2;
> > +		break;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *channel, int val,
> > +			    int val2, long mask)
> > +{
> > +	struct mcp3911 *adc = iio_priv(indio_dev);
> > +	int ret = -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_OFFSET:
> > +  
> 
> val2 should probably be zero and checked?
> 
> > +		/* Write offset */
> > +		ret = mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
> > +				3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		/* Enable offset*/
> > +		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
> > +				MCP3911_STATUSCOM_EN_OFFCAL,
> > +				MCP3911_STATUSCOM_EN_OFFCAL, 2);
> > +		if (ret)
> > +			goto out;

We go there anyway so why bother with the goto?

> > +
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:  

Default choice (by precedent) is to control variable gain
front ends via the scale parameter.   Hardware gain
is not meant to have any 'visible' impact on the output
value - most commonly used when the thing we are measuring
is not amplitude of anything.

> 
> val2?
> 
> > +		if (!is_power_of_2(val) && val <= 32) {  
> 
> the check looks suspicious, maybe || val > 32
> 
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		adc->gain[channel->channel] = val;
> > +
> > +		val = ilog2(val);
> > +		ret = mcp3911_update(adc, MCP3911_REG_GAIN,
> > +					MCP3911_GAIN_MASK(channel->channel),
> > +					MCP3911_GAIN_VAL(channel->channel,
> > +						val), 1);
> > +		break;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_chan_spec mcp3911_channels[] = {
> > +	{  
> 
> maybe use a MACRO(), e.g. MCP3911_CHANNEL(idx) ...
> 
> > +		.type = IIO_VOLTAGE,
> > +		.indexed = 1,
> > +		.channel = 0,
> > +		.address = MCP3911_REG_CHANNEL0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +			BIT(IIO_CHAN_INFO_OFFSET) |
> > +			BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +	},
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.indexed = 1,
> > +		.channel = 1,
> > +		.address = MCP3911_REG_CHANNEL1,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +			BIT(IIO_CHAN_INFO_OFFSET) |
> > +			BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +	},
> > +};
> > +
> > +static const struct iio_info mcp3911_info = {
> > +	.read_raw = mcp3911_read_raw,
> > +	.write_raw = mcp3911_write_raw,
> > +};
> > +
> > +static int mcp3911_config_of(struct mcp3911 *adc)
> > +{
> > +	u32 configreg;
> > +	u32 statuscomreg;
> > +	int ret;
> > +
> > +	of_property_read_u32(adc->np, "device-addr", &adc->dev_addr);
This is 'interesting' - I wonder if there is any precedence for it.

Mark,  
> > +	if (adc->dev_addr > 3) {
> > +		dev_err(&adc->spi->dev,
> > +				"invalid device address (%i). Must be in range 0-3.\n",
> > +				adc->dev_addr);
> > +		return -EINVAL;
> > +	}
> > +	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
> > +
> > +	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	adc->vrefext = of_property_read_bool(adc->np, "external-vref");

Why not just use the presence or lack of a regulator being supplied to indicate
this?  Use the regulator_get_optional functionality to avoid getting a stub
regulator if you need to know there isn't one there to connect.
Here you need the _optional form.

> > +	if (adc->vrefext) {
> > +		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
> > +		configreg |= MCP3911_CONFIG_VREFEXT;
> > +
> > +	} else {
> > +		dev_dbg(&adc->spi->dev, "use internal voltage reference (1.2V)\n");
> > +		configreg &= ~MCP3911_CONFIG_VREFEXT;
> > +	}
> > +
> > +	if (of_property_read_bool(adc->np, "external-clock")) {
> > +		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
> > +		configreg |= MCP3911_CONFIG_CLKEXT;
> > +	} else {
> > +		dev_dbg(&adc->spi->dev, "use crystal oscillator as clocksource\n");
> > +		configreg &= ~MCP3911_CONFIG_CLKEXT;
> > +	}

Sort of feels like this should be handled a bit like the regulator.
The kernel has bindings and software support for clocks. Would be nice
to use them.

> > +
> > +	ret =  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +
> > +	ret = mcp3911_read(adc, MCP3911_REG_STATUSCOM, &statuscomreg, 2);
> > +	if (ret)
> > +		return ret;
> > +  
> 
> no duplicate newlines (here and elsewhere)
> 
> > +
> > +	of_property_read_u32(adc->np, "ch0-width", &adc->width[0]);
> > +	switch (adc->width[0]) {
> > +	case 24:
> > +		statuscomreg &= ~MCP3911_STATUSCOM_CH0_24WIDTH;
> > +		dev_dbg(&adc->spi->dev, "set channel 0 into 24bit mode\n");
> > +		break;
> > +	case 16:
> > +		statuscomreg |= MCP3911_STATUSCOM_CH0_24WIDTH;
> > +		dev_dbg(&adc->spi->dev, "set channel 0 into 16bit mode\n");
> > +		break;
> > +	default:
> > +		adc->width[0] = 24;
> > +		dev_info(&adc->spi->dev, "invalid width for channel 0. Use 24bit.\n");
> > +		break;
> > +	}
This feels like something that isn't really a dt choice, as it's not down to
wiring but rather down to precision desired.

Now variable resolution isn't something IIO has traditionally dealt
with very well - particularly as it causes problems when we add in
buffered interfaces (as it changes the data layout etc).

> > +
> > +	of_property_read_u32(adc->np, "ch1-width", &adc->width[1]);
> > +	switch (adc->width[1]) {
> > +	case 24:
> > +		statuscomreg &= ~MCP3911_STATUSCOM_CH1_24WIDTH;
> > +		dev_dbg(&adc->spi->dev, "set channel 1 into 24bit mode\n");
> > +		break;
> > +	case 16:
> > +		statuscomreg |= MCP3911_STATUSCOM_CH1_24WIDTH;
> > +		dev_dbg(&adc->spi->dev, "set channel 1 into 16bit mode\n");
> > +		break;
> > +	default:
> > +		adc->width[1] = 24;
> > +		dev_info(&adc->spi->dev, "invalid width for channel 1. Use 24bit.\n");
> > +		break;
> > +	}
> > +
> > +	return mcp3911_write(adc, MCP3911_REG_STATUSCOM, statuscomreg, 2);
> > +}
> > +
> > +static int mcp3911_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct mcp3911 *adc;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	adc = iio_priv(indio_dev);
> > +	adc->spi = spi;
> > +	adc->np = spi->dev.of_node;

np is is rather unusual naming.  Why not of_node?
Also, why do we need to keep a copy of this?

> > +
> > +	ret = mcp3911_config_of(adc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (adc->vrefext) {
> > +		adc->vref = devm_regulator_get(&adc->spi->dev, "vref");

As I mention above, use devm_regulator_get_optional if you need
to be able to do something different dependent on whether the regulator
is actually there, if not just use devm_regulator_get and without
any if (adc->vrefext) and you'll get a 'fake' regulator which you can
enable and disable without it doing anything.

> > +		if (IS_ERR(adc->vref))
> > +			return PTR_ERR(adc->vref);
> > +
> > +		ret = regulator_enable(adc->vref);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	/* Store gain values to better calculate scale values */
> > +	mcp3911_get_hwgain(adc, 0, &adc->gain[0]);
> > +	mcp3911_get_hwgain(adc, 1, &adc->gain[1]);
> > +
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->dev.of_node = spi->dev.of_node;
> > +	indio_dev->name = spi_get_device_id(spi)->name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &mcp3911_info;
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	indio_dev->channels = mcp3911_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(mcp3911_channels);
> > +
> > +	mutex_init(&adc->lock);
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret)
> > +		goto reg_disable;
> > +
> > +	return ret;
> > +
> > +reg_disable:
> > +	if (adc->vref)
> > +		regulator_disable(adc->vref);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +	struct mcp3911 *adc = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	if (adc->vref)
> > +		regulator_disable(adc->vref);
> > +
> > +	return 0;
> > +}
> > +
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id mcp3911_dt_ids[] = {
> > +	{ .compatible = "microchip,mcp3911" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mcp3911_dt_ids);
> > +#endif
> > +
> > +static const struct spi_device_id mcp3911_id[] = {
> > +	{ "mcp3911", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, mcp3911_id);
> > +
> > +static struct spi_driver mcp3911_driver = {
> > +	.driver = {
> > +		.name = "mcp3911",
> > +		.of_match_table = of_match_ptr(mcp3911_dt_ids),
> > +	},
> > +	.probe = mcp3911_probe,
> > +	.remove = mcp3911_remove,
> > +	.id_table = mcp3911_id,
> > +};
> > +module_spi_driver(mcp3911_driver);
> > +
> > +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> > +MODULE_AUTHOR("Kent Gustavsson <kent@minoris.se>");
> > +MODULE_DESCRIPTION("Microchip Technology MCP3911");
> > +MODULE_LICENSE("GPL v2");
> >   
> 

