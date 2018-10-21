Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1317ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D3720869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcg1hYH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D3720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeJUWMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 18:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbeJUWMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 18:12:50 -0400
Received: from archlinux (unknown [176.12.107.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601CB20843;
        Sun, 21 Oct 2018 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540130302;
        bh=gboBixKZUZeXBfso5iRqK7FWsBkf3neZlj66oD3dfRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rcg1hYH11IUqWWfhyb6z0HsXD/8B6Nz42M6Y3G+k8cvZIbqn/CnxAYyiNuPfPi8Bu
         jgBq5YdHALmsXXJkrRdPRkkPPx/1vAqTaFe6wqkryMu93whJ9KiZ/kkt1MuNBqT/7Z
         /HCf0vsNelDjOT7ZgeAT9oYMIHhd1pklnXCWluyk=
Date:   Sun, 21 Oct 2018 14:58:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: Add ad7124 support
Message-ID: <20181021145812.262d0ff1@archlinux>
In-Reply-To: <1539860693-3308-1-git-send-email-stefan.popa@analog.com>
References: <1539860693-3308-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 14:04:53 +0300
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
>=20
> Datasheets:
> Link: http://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7124-4.pdf
> Link: http://www.analog.com/media/en/technical-documentation/data-sheets/=
ad7124-8.pdf
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Hi Stefan,

Just a couple of small things from me. See inline.

Thanks,

Jonathan
> ---
>  MAINTAINERS              |   7 +
>  drivers/iio/adc/Kconfig  |  11 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7124.c | 655 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 674 insertions(+)
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
> index 0000000..c6d9798
> --- /dev/null
> +++ b/drivers/iio/adc/ad7124.c
> @@ -0,0 +1,655 @@
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
> +	.channel =3D 0,
> +	.address =3D 0,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_index =3D 0,

Given I would imagine this is always overwritten, probably
no point in setting it here.  Same with channel and address
above.

> +	.scan_type =3D {
> +		.sign =3D 'u',
> +		.realbits =3D 24,
> +		.storagebits =3D 32,
> +		.shift =3D 0,

A shift of 0 is a fairly obvious default and the c standard guarantees
the variable will be initialized.  Hence no need to set it here.

> +	},
> +};
> +
> +static struct ad7124_chip_info ad7124_chip_info_tbl[] =3D {
> +	[ID_AD7124_4] =3D {
> +		.num_inputs =3D 8,
> +	},
> +	[ID_AD7124_8] =3D {
> +		.num_inputs =3D 16,
> +	},
> +};
> +
> +static int ad7124_find_closest_match(const int *array,
> +				     unsigned int size, int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < size; i++) {
> +		if (val <=3D array[i])
> +			return i;
> +	}
> +
> +	return size - 1;
> +}
> +
> +static int ad7124_spi_write_mask(struct ad7124_state *st,
> +				 unsigned int addr,
> +				 unsigned long mask,
> +				 unsigned int val,
> +				 unsigned int bytes)
> +{
> +	unsigned int readval;
> +	int ret;
> +
> +	ret =3D ad_sd_read_reg(&st->sd, addr, bytes, &readval);
> +	if (ret < 0)
> +		return ret;
> +
> +	readval &=3D ~mask;
> +	readval |=3D val;
> +
> +	return ad_sd_write_reg(&st->sd, addr, bytes, readval);
> +}
> +
> +static int ad7124_set_mode(struct ad_sigma_delta *sd,
> +			   enum ad_sigma_delta_mode mode)
> +{
> +	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, sd);
> +
> +	st->adc_control &=3D ~AD7124_ADC_CTRL_MODE_MSK;
> +	st->adc_control |=3D AD7124_ADC_CTRL_MODE(mode);
> +
> +	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
> +}
> +
> +static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int ch=
annel)
> +{
> +	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, sd);
> +	unsigned int val;
> +
> +	val =3D st->channel_config[channel].ain | AD7124_CHANNEL_EN(1) |
> +	      AD7124_CHANNEL_SETUP(channel);
> +
> +	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(channel), 2, val);
> +}
> +
> +static const struct ad_sigma_delta_info ad7124_sigma_delta_info =3D {
> +	.set_channel =3D ad7124_set_channel,
> +	.set_mode =3D ad7124_set_mode,
> +	.has_registers =3D true,
> +	.addr_shift =3D 0,
> +	.read_mask =3D BIT(6),
> +	.data_reg =3D AD7124_DATA,
> +};
> +
> +static int ad7124_set_channel_odr(struct ad7124_state *st,
> +				  unsigned int channel,
> +				  unsigned int odr)
> +{
> +	unsigned int fclk, odr_sel_bits;
> +	int ret;
> +
> +	fclk =3D clk_get_rate(st->mclk);
> +	/*
> +	 * FS[10:0] =3D fCLK / (fADC x 32) where:
> +	 * fADC is the output data rate
> +	 * fCLK is the master clock frequency
> +	 * FS[10:0] are the bits in the filter register
> +	 * FS[10:0] can have a value from 1 to 2047
> +	 */
> +	odr_sel_bits =3D DIV_ROUND_CLOSEST(fclk, odr * 32);
> +	if (odr_sel_bits < 1)
> +		odr_sel_bits =3D 1;
> +	else if (odr_sel_bits > 2047)
> +		odr_sel_bits =3D 2047;
> +
> +	ret =3D ad7124_spi_write_mask(st, AD7124_FILTER(channel),
> +				    AD7124_FILTER_FS_MSK,
> +				    AD7124_FILTER_FS(odr_sel_bits), 3);
> +	if (ret < 0)
> +		return ret;
> +	/* fADC =3D fCLK / (FS[10:0] x 32) */
> +	st->channel_config[channel].odr =3D
> +		DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
> +
> +	return 0;
> +}
> +
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
> +		} else {
> +			*val =3D 0;
> +		}
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D st->channel_config[chan->address].odr;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7124_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad7124_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad7124_set_channel_odr(st, chan->address, val);

We should probably have a sanity check for val2 being zero given we
are just ignoring it...

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad7124_info =3D {
> +	.read_raw =3D ad7124_read_raw,
> +	.write_raw =3D ad7124_write_raw,
> +};
> +
> +static int ad7124_soft_reset(struct ad7124_state *st)
> +{
> +	unsigned int readval, timeout;
> +	int ret;
> +
> +	ret =3D ad_sd_reset(&st->sd, 64);
> +	if (ret < 0)
> +		return ret;
> +
> +	timeout =3D 100;
> +	do {
> +		ret =3D ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
> +			return 0;
> +
> +		/* The AD7124 requires typically 2ms to power up and settle */
> +		usleep_range(100, 2000);
> +	} while (--timeout);
> +
> +	dev_err(&st->sd.spi->dev, "Soft reset failed\n");
> +
> +	return -EIO;
> +}
> +
> +static int ad7124_init_channel_vref(struct ad7124_state *st,
> +				    unsigned int channel_number)
> +{
> +	unsigned int refsel =3D st->channel_config[channel_number].refsel;
> +
> +	switch (refsel) {
> +	case AD7124_REFIN1:
> +	case AD7124_REFIN2:
> +	case AD7124_AVDD_REF:
> +		if (IS_ERR(st->vref[refsel])) {
> +			dev_err(&st->sd.spi->dev,
> +				"Error, trying to use external voltage reference without a %s regula=
tor.",
> +				ad7124_ref_names[refsel]);
> +				return PTR_ERR(st->vref[refsel]);
> +		}
> +		st->channel_config[channel_number].vref_mv =3D
> +			regulator_get_voltage(st->vref[refsel]);
> +		/* Conversion from uV to mV */
> +		st->channel_config[channel_number].vref_mv /=3D 1000;
> +		break;
> +	case AD7124_INT_REF:
> +		st->channel_config[channel_number].vref_mv =3D 2500;
> +		break;
> +	default:
> +		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
> +					  struct device_node *np)
> +{
> +	struct ad7124_state *st =3D iio_priv(indio_dev);
> +	struct device_node *chan_node, *child;
> +	struct iio_chan_spec *chan;
> +	unsigned int ain[2], channel =3D 0, tmp;
> +	int ret, res;
> +
> +	chan_node =3D of_get_child_by_name(np, "adi,channels");
> +	if (!chan_node) {
> +		dev_err(indio_dev->dev.parent,
> +			"failed to find channels node\n");
> +		return -ENODEV;
> +	}
> +
> +	st->num_channels =3D of_get_available_child_count(chan_node);
> +	if (!st->num_channels) {
> +		dev_err(indio_dev->dev.parent, "no channel children\n");
> +		return -ENODEV;
> +	}
> +
> +	chan =3D devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> +			    sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	indio_dev->channels =3D chan;
> +	indio_dev->num_channels =3D st->num_channels;
> +
> +	for_each_available_child_of_node(chan_node, child) {
> +		ret =3D of_property_read_u32_array(child, "reg", ain, 2);
> +		if (ret)
> +			goto err;
> +
> +		ret =3D of_property_read_u32(child,
> +					   "adi,channel-number", &channel);
The line break here is a little odd.  I think the string should be on the l=
ine
above probably (nitpick of the day ;)

> +		if (ret)
> +			goto err;
> +
> +		if (ain[0] >=3D st->chip_info->num_inputs ||
> +		    ain[1] >=3D st->chip_info->num_inputs) {
> +			dev_err(indio_dev->dev.parent,
> +				"Input pin number out of range.\n");
> +			ret =3D -EINVAL;
> +			goto err;
> +		}
> +		st->channel_config[channel].ain =3D AD7124_CHANNEL_AINP(ain[0]) |
> +						  AD7124_CHANNEL_AINM(ain[1]);
> +		st->channel_config[channel].bipolar =3D
> +			of_property_read_bool(child, "adi,bipolar");
> +
> +		ret =3D of_property_read_u32(child, "adi,reference-select", &tmp);
> +		if (ret)
> +			st->channel_config[channel].refsel =3D AD7124_INT_REF;
> +		else
> +			st->channel_config[channel].refsel =3D tmp;
> +
> +		ret =3D of_property_read_u32(child, "adi,gain", &tmp);
> +		if (ret) {
> +			st->channel_config[channel].pga_bits =3D 0;
> +		} else {
> +			res =3D ad7124_find_closest_match(ad7124_gain,
> +						ARRAY_SIZE(ad7124_gain), tmp);
> +			st->channel_config[channel].pga_bits =3D res;
> +		}
> +
> +		ret =3D of_property_read_u32(child, "adi,odr-hz", &tmp);
> +		if (ret)
> +			/*
> +			 * 9 SPS is the minimum output data rate supported
> +			 * regardless of the selected power mode.
> +			 */
> +			st->channel_config[channel].odr =3D 9;
> +		else
> +			st->channel_config[channel].odr =3D tmp;
> +
> +		*chan =3D ad7124_channel_template;
> +		chan->address =3D channel;
> +		chan->scan_index =3D channel;
> +		chan->channel =3D ain[0];
> +		chan->channel2 =3D ain[1];
> +
> +		chan++;
> +	}
> +	of_node_put(chan_node);
> +
> +	return 0;
> +err:
> +	of_node_put(chan_node);
> +	of_node_put(child);
> +
> +	return ret;
> +}
> +
> +static int ad7124_setup(struct ad7124_state *st)
> +{
> +	unsigned int val, fclk, power_mode;
> +	int i, ret;
> +
> +	fclk =3D clk_get_rate(st->mclk);
> +	if (!fclk)
> +		return -EINVAL;
> +
> +	/* The power mode changes the master clock frequency */
> +	power_mode =3D ad7124_find_closest_match(ad7124_master_clk_freq_hz,
> +					ARRAY_SIZE(ad7124_master_clk_freq_hz),
> +					fclk);
> +	if (fclk !=3D ad7124_master_clk_freq_hz[power_mode]) {
> +		ret =3D clk_set_rate(st->mclk, fclk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Set the power mode */
> +	st->adc_control &=3D ~AD7124_ADC_CTRL_PWR_MSK;
> +	st->adc_control |=3D AD7124_ADC_CTRL_PWR(power_mode);
> +	ret =3D ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control=
);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 0; i < st->num_channels; i++) {
> +		val =3D st->channel_config[i].ain | AD7124_CHANNEL_SETUP(i);
> +		ret =3D ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D ad7124_init_channel_vref(st, i);
> +		if (ret < 0)
> +			return ret;
> +
> +		val =3D AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
> +		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
> +		      AD7124_CONFIG_PGA(st->channel_config[i].pga_bits);
> +		ret =3D ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D ad7124_set_channel_odr(st, i, st->channel_config[i].odr);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad7124_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id;
> +	struct ad7124_state *st;
> +	struct iio_dev *indio_dev;
> +	int i, ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	id =3D spi_get_device_id(spi);
> +	st->chip_info =3D &ad7124_chip_info_tbl[id->driver_data];
> +
> +	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->dev.parent =3D &spi->dev;
> +	indio_dev->name =3D spi_get_device_id(spi)->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ad7124_info;
> +
> +	ret =3D ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(st->vref); i++) {
> +		if (i !=3D AD7124_INT_REF)
> +			st->vref[i] =3D devm_regulator_get_optional(&spi->dev,
> +							ad7124_ref_names[i]);
The complexity of regulator_get_optional, is which cases actually mean there
hasn't been a regulator specified (which is fine) rather than it's not ready
or there has been an error getting the one that was specified.

So I 'believe' that you should only be continuing if you get -ENODEV.
Anything else and you should give up on the probe (perhaps to come
back later if it's a defer.


> +		if (IS_ERR_OR_NULL(st->vref[i]))
> +			continue;
> +
> +		ret =3D regulator_enable(st->vref[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	st->mclk =3D devm_clk_get(&spi->dev, "mclk");
> +	if (IS_ERR(st->mclk)) {
> +		ret =3D PTR_ERR(st->mclk);
> +		goto error_regulator_disable;
> +	}
> +
> +	ret =3D clk_prepare_enable(st->mclk);
> +	if (ret < 0)
> +		goto error_regulator_disable;
> +
> +	ret =3D ad7124_soft_reset(st);
> +	if (ret < 0)
> +		goto error_clk_disable_unprepare;
> +
> +	ret =3D ad7124_setup(st);
> +	if (ret < 0)
> +		goto error_clk_disable_unprepare;
> +
> +	ret =3D ad_sd_setup_buffer_and_trigger(indio_dev);
> +	if (ret < 0)
> +		goto error_clk_disable_unprepare;
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to register iio device\n");
> +		goto error_remove_trigger;
> +	}
> +
> +	return 0;
> +
> +error_remove_trigger:
> +	ad_sd_cleanup_buffer_and_trigger(indio_dev);
> +error_clk_disable_unprepare:
> +	clk_disable_unprepare(st->mclk);
> +error_regulator_disable:
> +	for (i =3D ARRAY_SIZE(st->vref) - 1; i >=3D 0; i--) {
> +		if (!IS_ERR_OR_NULL(st->vref[i]))
> +			regulator_disable(st->vref[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad7124_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> +	struct ad7124_state *st =3D iio_priv(indio_dev);
> +	int i;
> +
> +	iio_device_unregister(indio_dev);
> +	ad_sd_cleanup_buffer_and_trigger(indio_dev);
> +	clk_disable_unprepare(st->mclk);

I know it is probably fine, but I would definitely prefer the ordering
in here and the error paths in probe to be the same (and the reverse
of the probe order).  That puts clk_disable_unprepare before
ad_sd_cleanup_buffer_and_trigger.

> +
> +	for (i =3D ARRAY_SIZE(st->vref) - 1; i >=3D 0; i--) {
> +		if (!IS_ERR_OR_NULL(st->vref[i]))
> +			regulator_disable(st->vref[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id ad7124_id_table[] =3D {
> +	{ "ad7124-4", ID_AD7124_4 },
> +	{ "ad7124-8", ID_AD7124_8 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad7124_id_table);
> +
> +static const struct of_device_id ad7124_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7124-4" },
> +	{ .compatible =3D "adi,ad7124-8" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ad7124_of_match);
> +
> +static struct spi_driver ad71124_driver =3D {
> +	.driver =3D {
> +		.name =3D "ad7124",
> +		.of_match_table =3D ad7124_of_match,
> +	},
> +	.probe =3D ad7124_probe,
> +	.remove	=3D ad7124_remove,
> +	.id_table =3D ad7124_id_table,
> +};
> +module_spi_driver(ad71124_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7124 SPI driver");
> +MODULE_LICENSE("GPL");

