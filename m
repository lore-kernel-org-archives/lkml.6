Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A035D21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm5QRCXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A035D21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeKKWCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbeKKWCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:02:30 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90509208A3;
        Sun, 11 Nov 2018 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541938444;
        bh=4ZAszjG6jyrRLC/CcqO0zZc+kWq5roH2vkA/wEfCAnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cm5QRCXJEdjufpJ23U123I9sMeDFASsO391qHzNWC+JbwDMtnc8ZSkKVAQ9GxRLdR
         7uMdaTfRHKTyNs/ryCYWxeStv1KfP8WVjmbjUMMhyxkdDeWf/3ki4aNmyvVNCm+bN4
         prCUy3seW2ZxqZL83u3QAPvDgflpIz3KlKR1gyXY=
Date:   Sun, 11 Nov 2018 12:13:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] iio: adc: Add ad7124 support
Message-ID: <20181111121359.0e946523@archlinux>
In-Reply-To: <1541778106-7740-1-git-send-email-stefan.popa@analog.com>
References: <1541778106-7740-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 17:41:46 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The ad7124-4 and ad7124-8 are a family of 4 and 8 channel sigma-delta ADCs
> with 24-bit precision and reference.
>=20
> Three power modes are available which in turn affect the output data rate:
>  * Full power: 9.38 SPS to 19,200 SPS
>  * Mid power: 2.34 SPS to 4800 SPS
>  * Low power: 1.17 SPS to 2400 SPS
>=20
> The ad7124-4 can be configured to have four differential inputs, while
> ad7124-8 can have 8. Moreover, ad7124 also supports per channel
> configuration. Each configuration consists of gain, reference source,
> output data rate and bipolar/unipolar configuration.

One question around the offset.
Voltage =3D (raw value + offset) * scale.
So I think the offset should simply be half the raw value range, not depend=
ent
on the current gain?

Perhaps I'm missing something.

The other thing that I think needs to be dropped is the use of hardware gai=
n.
It was never intended for this use case and means we effectively have two
interfaces for the same thing.  Scale and hardwaregain.

Otherwise, looking very nice.

Jonathan

>=20
> Datasheets:
> Link: http://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7124-4.pdf
> Link: http://www.analog.com/media/en/technical-documentation/data-sheets/=
ad7124-8.pdf
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- Nothing changed.
> Changes in v3:
> 	- Removed channel, address, scan_index and shift fields from
> 	  ad7124_channel_template.
> 	- Added a sanity check for val2 in ad7124_write_raw().
> 	- Used the "reg" property to get the channel address and "adi,diff-chann=
els"
> 	  for the differential pins. The "adi,channel-number" property was remov=
ed.
> 	- When calling regulator_get_optional, the probe is given up in case of =
error,
> 	  but continues in case of -ENODEV.
> 	- clk_disable_unprepare() is called before ad_sd_cleanup_buffer_and_trig=
ger
> 	  in ad7124_remove().
> Changes in v4:
> 	- Added the .shift and .endianness fields as part of the ad7124_channel_=
template.
> 	- Made the gain configurable from the user space.
> 	- Removed the odr_hz and gain properties from the DT.
> 	- Used the bipolar and diff-channels properties defined in the new adc.t=
xt doc.
> 	- Misc style fixes.
>=20
>  MAINTAINERS              |   7 +
>  drivers/iio/adc/Kconfig  |  11 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7124.c | 676 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 695 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7124.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f642044..3a1bfcb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -839,6 +839,13 @@ S:	Supported
>  F:	drivers/iio/dac/ad5758.c
>  F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
> =20
> +ANALOG DEVICES INC AD7124 DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/adc/ad7124.c
> +
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a52fea8..148a10f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -10,6 +10,17 @@ config AD_SIGMA_DELTA
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> =20
> +config AD7124
> +	tristate "Analog Devices AD7124 and similar sigma-delta ADCs driver"
> +	depends on SPI_MASTER
> +	select AD_SIGMA_DELTA
> +	help
> +	  Say yes here to build support for Analog Devices AD7124-4 and AD7124-8
> +	  SPI analog to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7124.
> +
>  config AD7266
>  	tristate "Analog Devices AD7265/AD7266 ADC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a6e6a0b..76168b2 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -5,6 +5,7 @@
> =20
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> +obj-$(CONFIG_AD7124) +=3D ad7124.o
>  obj-$(CONFIG_AD7266) +=3D ad7266.o
>  obj-$(CONFIG_AD7291) +=3D ad7291.o
>  obj-$(CONFIG_AD7298) +=3D ad7298.o
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> new file mode 100644
> index 0000000..64d2aa7
> --- /dev/null
> +++ b/drivers/iio/adc/ad7124.c
> @@ -0,0 +1,676 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD7124 SPI ADC driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +#include <linux/iio/sysfs.h>
> +
> +/* AD7124 registers */
> +#define AD7124_COMMS			0x00
> +#define AD7124_STATUS			0x00
> +#define AD7124_ADC_CONTROL		0x01
> +#define AD7124_DATA			0x02
> +#define AD7124_IO_CONTROL_1		0x03
> +#define AD7124_IO_CONTROL_2		0x04
> +#define AD7124_ID			0x05
> +#define AD7124_ERROR			0x06
> +#define AD7124_ERROR_EN		0x07
> +#define AD7124_MCLK_COUNT		0x08
> +#define AD7124_CHANNEL(x)		(0x09 + (x))
> +#define AD7124_CONFIG(x)		(0x19 + (x))
> +#define AD7124_FILTER(x)		(0x21 + (x))
> +#define AD7124_OFFSET(x)		(0x29 + (x))
> +#define AD7124_GAIN(x)			(0x31 + (x))
> +
> +/* AD7124_STATUS */
> +#define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
> +
> +/* AD7124_ADC_CONTROL */
> +#define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
> +#define AD7124_ADC_CTRL_PWR(x)		FIELD_PREP(AD7124_ADC_CTRL_PWR_MSK, x)
> +#define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
> +#define AD7124_ADC_CTRL_MODE(x)	FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
> +
> +/* AD7124_CHANNEL_X */
> +#define AD7124_CHANNEL_EN_MSK		BIT(15)
> +#define AD7124_CHANNEL_EN(x)		FIELD_PREP(AD7124_CHANNEL_EN_MSK, x)
> +#define AD7124_CHANNEL_SETUP_MSK	GENMASK(14, 12)
> +#define AD7124_CHANNEL_SETUP(x)	FIELD_PREP(AD7124_CHANNEL_SETUP_MSK, x)
> +#define AD7124_CHANNEL_AINP_MSK	GENMASK(9, 5)
> +#define AD7124_CHANNEL_AINP(x)		FIELD_PREP(AD7124_CHANNEL_AINP_MSK, x)
> +#define AD7124_CHANNEL_AINM_MSK	GENMASK(4, 0)
> +#define AD7124_CHANNEL_AINM(x)		FIELD_PREP(AD7124_CHANNEL_AINM_MSK, x)
> +
> +/* AD7124_CONFIG_X */
> +#define AD7124_CONFIG_BIPOLAR_MSK	BIT(11)
> +#define AD7124_CONFIG_BIPOLAR(x)	FIELD_PREP(AD7124_CONFIG_BIPOLAR_MSK, x)
> +#define AD7124_CONFIG_REF_SEL_MSK	GENMASK(4, 3)
> +#define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
> +#define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
> +#define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
> +
> +/* AD7124_FILTER_X */
> +#define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
> +#define AD7124_FILTER_FS(x)		FIELD_PREP(AD7124_FILTER_FS_MSK, x)
> +
> +enum ad7124_ids {
> +	ID_AD7124_4,
> +	ID_AD7124_8,
> +};
> +
> +enum ad7124_ref_sel {
> +	AD7124_REFIN1,
> +	AD7124_REFIN2,
> +	AD7124_INT_REF,
> +	AD7124_AVDD_REF,
> +};
> +
> +enum ad7124_power_mode {
> +	AD7124_LOW_POWER,
> +	AD7124_MID_POWER,
> +	AD7124_FULL_POWER,
> +};
> +
> +static const unsigned int ad7124_gain[8] =3D {
> +	1, 2, 4, 8, 16, 32, 64, 128
> +};
> +
> +static const int ad7124_master_clk_freq_hz[3] =3D {
> +	[AD7124_LOW_POWER] =3D 76800,
> +	[AD7124_MID_POWER] =3D 153600,
> +	[AD7124_FULL_POWER] =3D 614400,
> +};
> +
> +static const char * const ad7124_ref_names[] =3D {
> +	[AD7124_REFIN1] =3D "refin1",
> +	[AD7124_REFIN2] =3D "refin2",
> +	[AD7124_INT_REF] =3D "int",
> +	[AD7124_AVDD_REF] =3D "avdd",
> +};
> +
> +struct ad7124_chip_info {
> +	unsigned int num_inputs;
> +};
> +
> +struct ad7124_channel_config {
> +	enum ad7124_ref_sel refsel;
> +	bool bipolar;
> +	unsigned int ain;
> +	unsigned int vref_mv;
> +	unsigned int pga_bits;
> +	unsigned int odr;
> +};
> +
> +struct ad7124_state {
> +	const struct ad7124_chip_info *chip_info;
> +	struct ad_sigma_delta sd;
> +	struct ad7124_channel_config channel_config[4];
> +	struct regulator *vref[4];
> +	struct clk *mclk;
> +	unsigned int adc_control;
> +	unsigned int num_channels;
> +};
> +
> +static const struct iio_chan_spec ad7124_channel_template =3D {
> +	.type =3D IIO_VOLTAGE,
> +	.indexed =3D 1,
> +	.differential =3D 1,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> +	.scan_type =3D {
> +		.sign =3D 'u',
> +		.realbits =3D 24,
> +		.storagebits =3D 32,
> +		.shift =3D 8,
> +		.endianness =3D IIO_BE,
> +	},
> +};

...
> +static int ad7124_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad7124_state *st =3D iio_priv(indio_dev);
> +	int idx, ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* After the conversion is performed, disable the channel */
> +		ret =3D ad_sd_write_reg(&st->sd,
> +				      AD7124_CHANNEL(chan->address), 2,
> +				      st->channel_config[chan->address].ain |
> +				      AD7124_CHANNEL_EN(0));
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		idx =3D st->channel_config[chan->address].pga_bits;
> +		*val =3D st->channel_config[chan->address].vref_mv /
> +			ad7124_gain[idx];

Given the gains are all a power of 2.  You 'could' apply them to
*val2 instead?  Might give better precision. I haven't checked!

> +		if (st->channel_config[chan->address].bipolar)
> +			*val2 =3D chan->scan_type.realbits - 1;
> +		else
> +			*val2 =3D chan->scan_type.realbits;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (st->channel_config[chan->address].bipolar) {
> +			/* Code =3D 2^(n =E2=88=92 1) =C3=97 ((Ain =C3=97 Gain / Vref) + 1) */
> +			idx =3D st->channel_config[chan->address].pga_bits;
> +			*val =3D -(st->channel_config[chan->address].vref_mv /
> +				 ad7124_gain[idx]);
This one surprised me.  Offset is applied before gain and I think this part
is symmetric when bipolar, so I think should just be based on the raw adc
counts as half the full range?

> +		} else {
> +			*val =3D 0;
> +		}
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D st->channel_config[chan->address].odr;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		idx =3D st->channel_config[chan->address].pga_bits;
> +		*val =3D ad7124_gain[idx];
Hmm. Normally hardwaregain is reserved for those cases where scale
doesn't work.  Scale is definitely the preferred option and it'll
take a pretty persuasive argument to convince me otherwise.

Normally hardware gain is when it is is actually effecting the
measurement (so things like light intensity for time of flight
sensors).

> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...
