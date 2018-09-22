Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9446CECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0157C214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="poFOwwLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0157C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeIVQHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbeIVQHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:07:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09AD2146E;
        Sat, 22 Sep 2018 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537611253;
        bh=UDBgXuPmKY57c6wTdEEQi6Uz90UmeaQC/fZ6fu7cF0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=poFOwwLHxSe810M9lqvfxxsm924zfpAMSolCwwzCA7O6lRnJf8eaBE3mY+Pwldlhq
         wVXL8VK6eaK5R5sgUOY7P6ccjFqVeZZ1HPodz+9NbVqial9P9IpZfhKkDP2kqcyjKI
         K7IKKtbIRpsx0DRq4K2naaUuEWoGZqHCl1F6JopA=
Date:   Sat, 22 Sep 2018 11:14:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180922111409.597126fd@archlinux>
In-Reply-To: <20180920131340.6699-1-songqiang1304521@gmail.com>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 21:13:40 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> PNI RM3100 magnetometer is a high resolution, large signal immunity
> magnetometer, composed of 3 single sensors and a processing chip.
> PNI is currently not in the vendors list, so this is also adding it.
> 
> Following functions are available:
>  - Single-shot measurement from
>    /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
>  - Triggerd buffer measurement.
>  - Both i2c and spi interface are supported.
>  - Both interrupt and polling measurement is supported, depands on if
>    the 'interrupts' in DT is declared.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Hi Song,

Great to have a driver for a pni device.  I hadn't come across them
before!

I'll try and avoid repeating Peter and Phil's comments on the basis
you probably have those covered by now.  I would have left this
for V2 before reviewing but not sure if I'll get to IIO stuff
during the coming week so better to get you some comments from me today.

Thanks,

Jonathan

> ---
>  .../bindings/iio/magnetometer/pni,rm3100.txt  |  57 +++
>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>  MAINTAINERS                                   |  10 +
>  drivers/iio/magnetometer/Kconfig              |  29 ++
>  drivers/iio/magnetometer/Makefile             |   4 +
>  drivers/iio/magnetometer/rm3100-core.c        | 399 ++++++++++++++++++
>  drivers/iio/magnetometer/rm3100-i2c.c         |  66 +++
>  drivers/iio/magnetometer/rm3100-spi.c         |  72 ++++
>  drivers/iio/magnetometer/rm3100.h             |  90 ++++
>  9 files changed, 728 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
>  create mode 100644 drivers/iio/magnetometer/rm3100-core.c
>  create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
>  create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
>  create mode 100644 drivers/iio/magnetometer/rm3100.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> new file mode 100644
> index 000000000000..d0d2063e943f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> @@ -0,0 +1,57 @@
> +* PNI RM3100 9-axis magnetometer sensor
> +
> +I2C Bus:
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100-i2c"
> +- reg : the I2C address of the magnetometer
> +
> +Optional properties:
> +
> +- interrupts: data ready (DRDY) from the chip.
> +  The interrupts can be triggered on rising edges.
> +
> +	Refer to interrupt-controller/interrupts.txt for generic
> +	interrupt client node bindings.
> +
> +- pinctrl-*: pinctrl setup for DRDY line.

I'm not a DT expert by any means, but I think the convention is
to not mention pinctrl in a given driver because otherwise
in theory we may need to mention it everywhere...

> +
> +Example:
> +
> +rm3100: rm3100@20 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rm3100_pins>;
> +
> +	compatible = "pni,rm3100-i2c";
> +	reg = <0x20>;
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> +};
> +
> +SPI Bus:
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100-spi"
> +- reg : address of sensor, usually 0 or 1.
> +
> +Optional properties:
> +
> +- interrupts: data ready (DRDY) from the chip.
> +  The interrupts can be triggered on rising edges.
> +
> +	Refer to interrupt-controller/interrupts.txt for generic
> +	interrupt client node bindings.
> +
> +- pinctrl-*: pinctrl setup for DRDY line, depands on archtechture.
> +
> +Example:
> +
> +rm3100: rm3100@0{
> +	compatible = "pni,rm3100-spi";
> +	reg = <0>;
> +
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 41f0b97eb933..5bf3395fe9ae 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -288,6 +288,7 @@ pine64	Pine64
>  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
>  plathome	Plat'Home Co., Ltd.
>  plda	PLDA
> +pni     PNI

Please break the whole binding out as a separate patch.  Ideally do this
vendor-prefixes.txt as a separate patch again.  This cuts down
on the amount of searching that the DT people have to do to find
the bits that they want to look at.

>  portwell	Portwell Inc.
>  poslab	Poslab Technology Co., Ltd.
>  powervr	PowerVR (deprecated, use img)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 967ce8cdd1cc..30ee8cf98312 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11393,6 +11393,16 @@ M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>  S:	Maintained
>  F:	drivers/pnp/
>  
> +PNI RM3100 IIO DRIVER
> +M:	Song Qiang <songqiang1304521@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/magnetometer/rm3100-core.c

rm3110* perhaps?

> +F:	drivers/iio/magnetometer/rm3100-i2c.c
> +F:	drivers/iio/magnetometer/rm3100-spi.c
> +F:	drivers/iio/magnetometer/rm3100.h
> +F:	Documentation/devicetree/bindings/iio/magnetometer/rm3100.txt
> +
>  POSIX CLOCKS and TIMERS
>  M:	Thomas Gleixner <tglx@linutronix.de>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index ed9d776d01af..f130b866a4fc 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -175,4 +175,33 @@ config SENSORS_HMC5843_SPI
>  	  - hmc5843_core (core functions)
>  	  - hmc5843_spi (support for HMC5983)
>  
> +config SENSORS_RM3100
> +	tristate
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +
> +config SENSORS_RM3100_I2C
> +	tristate "PNI RM3100 9-Axis Magnetometer (I2C)"
> +	depends on I2C
> +	select SENSORS_RM3100
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to add support for the PNI RM3100 9-Axis Magnetometer.
> +
> +	  This driver can also be compiled as a module.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called rm3100-i2c.
> +
> +config SENSORS_RM3100_SPI
> +	tristate "PNI RM3100 9-Axis Magnetometer (SPI)"
> +	depends on SPI_MASTER
> +	select SENSORS_RM3100
> +	select REGMAP_SPI
> +	help
> +	  Say Y here to add support for the PNI RM3100 9-Axis Magnetometer.
> +
> +	  This driver can also be compiled as a module.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called rm3100-spi.
> +
>  endmenu
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 664b2f866472..ba1bc34b82fa 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -24,3 +24,7 @@ obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
>  obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
>  obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
>  obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
> +
> +obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
> +obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
> +obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> new file mode 100644
> index 000000000000..55d515e0fe67
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PNI RM3100 9-axis geomagnetic sensor driver core.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + *
> + * User Manual available at
> + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> + *
> + * TODO: Scale channel, event generaton, pm.
> + */
> +

module.h should be included here not in the header (see below)

> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +
> +#include "rm3100.h"
> +
> +static const struct regmap_range rm3100_readable_ranges[] = {
> +		regmap_reg_range(RM_W_REG_START, RM_W_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_readable_table = {
> +		.yes_ranges = rm3100_readable_ranges,
> +		.n_yes_ranges = ARRAY_SIZE(rm3100_readable_ranges),
> +};
> +
> +static const struct regmap_range rm3100_writable_ranges[] = {
> +		regmap_reg_range(RM_R_REG_START, RM_R_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_writable_table = {
> +		.yes_ranges = rm3100_writable_ranges,
> +		.n_yes_ranges = ARRAY_SIZE(rm3100_writable_ranges),
> +};
> +
> +static const struct regmap_range rm3100_volatile_ranges[] = {
> +		regmap_reg_range(RM_V_REG_START, RM_V_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_volatile_table = {
> +		.yes_ranges = rm3100_volatile_ranges,
> +		.n_yes_ranges = ARRAY_SIZE(rm3100_volatile_ranges),
> +};
> +
> +static irqreturn_t rm3100_measurement_irq_handler(int irq, void *d)

Silly question: Does the chip have two interrupt lines?  (if so they
should be in the binding). If not, then this is the irq handler
for everything so why have the measurement in it's name?

> +{
> +	struct rm3100_data *data = d;
> +
> +	complete(&data->measuring_done);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rm3100_wait_measurement(struct rm3100_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	unsigned int val;
> +	u16 tries = 20;
> +	int ret;
> +
> +	/* A read cycle of 400kbits i2c bus is about 20us, plus the time
> +	 * used for schduling, a read cycle of fast mode of this device
> +	 * can reach 1.7ms, it may be possible for data arrives just
> +	 * after we check the RM_REG_STATUS. In this case, irq_handler is
> +	 * called before measuring_done is reinitialized, it will wait
> +	 * forever for a data that has already been ready.
> +	 * Reinitialize measuring_done before looking up makes sure we
> +	 * will always capture interrupt no matter when it happened.
> +	 */
> +	if (data->use_interrupt)
> +		reinit_completion(&data->measuring_done);
> +
> +	ret = regmap_read(regmap, RM_REG_STATUS, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((val & RM_STATUS_DRDY) != RM_STATUS_DRDY) {
> +		if (data->use_interrupt) {
> +			ret = wait_for_completion_timeout(&data->measuring_done,
> +				msecs_to_jiffies(data->conversion_time));
> +			if (!ret)
> +				return -ETIMEDOUT;
> +		} else {
> +			do {
> +				ret = regmap_read(regmap, RM_REG_STATUS, &val);
> +				if (ret < 0)
> +					return ret;
> +
> +				if (val & RM_STATUS_DRDY)
> +					break;
> +
> +				usleep_range(1000, 5000);
> +			} while (--tries);
> +			if (!tries)
> +				return -ETIMEDOUT;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	u8 buffer[3];
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = rm3100_wait_measurement(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret = regmap_bulk_read(regmap, RM_REG_MX2 + 3 * idx, buffer, 3);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = le32_to_cpu((buffer[0] << 16) + (buffer[1] << 8) + buffer[2]);
> +	*val = sign_extend32(*val, 23);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +#define RM_CHANNEL(axis, idx)					\
> +	{								\
> +		.type = IIO_MAGN,					\
> +		.modified = 1,						\
> +		.channel2 = IIO_MOD_##axis,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.scan_index = idx,					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 24,					\
> +			.storagebits = 32,				\
> +			.shift = 8,					\
> +			.endianness = IIO_LE,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec rm3100_channels[] = {
> +	RM_CHANNEL(X, 0),
> +	RM_CHANNEL(Y, 1),
> +	RM_CHANNEL(Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const unsigned long rm3100_scan_masks[] = {GENMASK(2, 0), 0};
> +
> +#define RM_SAMP_NUM	14
> +
> +/* Frequency : rm3100_samp_rates[][0].rm3100_samp_rates[][1]Hz.
> + * Time between reading: rm3100_sam_rates[][2]ms (The first on is actially 1.7).
> + */
> +static const int rm3100_samp_rates[RM_SAMP_NUM][3] = {
> +	{600, 0, 2}, {300, 0, 3}, {150, 0, 7}, {75, 0, 13}, {37, 0, 27},
> +	{18, 0, 55}, {9, 0, 110}, {4, 500000, 220}, {2, 300000, 440},
> +	{1, 200000, 800}, {0, 600000, 1600}, {0, 300000, 3300},
> +	{0, 15000, 6700},  {0, 75000, 13000}
> +};
> +
> +static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
> +{
> +	int ret;
> +	int tmp;
> +
> +	ret = regmap_read(data->regmap, RM_REG_TMRC, &tmp);
> +	if (ret < 0)
> +		return ret;
> +	*val = rm3100_samp_rates[tmp-RM_TMRC_OFFSET][0];
> +	*val2 = rm3100_samp_rates[tmp-RM_TMRC_OFFSET][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int rm3100_set_samp_freq(struct rm3100_data *data, int val, int val2)
> +{
> +	struct regmap *regmap = data->regmap;
> +	int cycle_count;
> +	int ret;
> +	int i;
> +
> +	/* All cycle count registers use the same value. */
> +	ret = regmap_read(regmap, RM_REG_CCXL, &cycle_count);
> +	if (cycle_count < 0)
> +		return cycle_count;
> +
> +	for (i = 0; i < RM_SAMP_NUM; i++) {
> +		if (val == rm3100_samp_rates[i][0] &&
> +			val2 == rm3100_samp_rates[i][1])
> +			break;
> +	}
> +
> +	if (i != RM_SAMP_NUM) {
> +		mutex_lock(&data->lock);
> +		ret = regmap_write(regmap, RM_REG_TMRC, i + RM_TMRC_OFFSET);
> +		if (ret < 0)

Peter raised this anyway but critical you unlock in these error paths.

> +			return ret;
> +
> +		/* Checking if cycle count registers need changing. */
> +		if (val == 600 && cycle_count == 200) {
> +			for (i = 0; i < 3; i++) {
> +				regmap_write(regmap, RM_REG_CCXL + 2 * i, 100);
> +				if (ret < 0)
> +					return ret;
> +			}
> +		} else if (val != 600 && cycle_count == 100) {
> +			for (i = 0; i < 3; i++) {
> +				regmap_write(regmap, RM_REG_CCXL + 2 * i, 200);
> +				if (ret < 0)
> +					return ret;
> +			}
> +		}
> +		/* Writing TMRC registers requires CMM reset. */
> +		ret = regmap_write(regmap, RM_REG_CMM, 0);
> +		if (ret < 0)
> +			return ret;
> +		ret = regmap_write(regmap, RM_REG_CMM, RM_CMM_PMX |
> +			RM_CMM_PMY | RM_CMM_PMZ | RM_CMM_START);

That is not nice line breaking...

> +		if (ret < 0)
> +			return ret;
> +		mutex_unlock(&data->lock);
> +
> +		data->conversion_time = rm3100_samp_rates[i][2] + 3000;
> +		return 0;
> +	}
> +	return -EINVAL;
Flip the logic here so 
if (i == RM_SAMP_NUM)
	return -EINVAL;

... cary on.

A;ways more natural to find errors on the indented path + it
drops your indent by one tab for most of the code.
> +}
> +
> +static int rm3100_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +		ret = rm3100_read_mag(data, chan->scan_index, val);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ret = rm3100_get_samp_freq(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int rm3100_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = rm3100_set_samp_freq(data, val, val2);
> +		if (ret < 0)
> +			return ret;
ids set_samp_freq ever returning greater than 0?

If not just return rm3100_set_samp_freq directly.

> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +}
> +
> +static const struct iio_info rm3100_info = {
> +	.read_raw = rm3100_read_raw,
> +	.write_raw = rm3100_write_raw,
> +};
> +
> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	u8 *buffer;
> +	int ret;
> +	int i;
> +
> +	buffer = devm_kzalloc(data->dev, indio_dev->scan_bytes, GFP_KERNEL);
That is 'interesting'.  You are leaking a buffer every time this reads..

> +	if (!buffer)
> +		goto done;
> +
> +	mutex_lock(&data->lock);
> +	ret = rm3100_wait_measurement(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		goto done;
> +	}
> +
> +	for (i = 0; i < 3; i++) {
> +		ret = regmap_bulk_read(regmap, RM_REG_MX2 + 3 * i,
> +				buffer + 4 * i, 3);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +			iio_get_time_ns(indio_dev));
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> +{
> +	struct iio_dev *indio_dev;
> +	struct rm3100_data *data;
> +	int tmp;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = "rm3100";
> +	indio_dev->info = &rm3100_info;
> +	indio_dev->channels = rm3100_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = rm3100_scan_masks;
> +
> +	if (!irq)
> +		data->use_interrupt = false;
> +	else {
> +		data->use_interrupt = true;
> +		ret = devm_request_irq(dev,
> +			irq,
> +			rm3100_measurement_irq_handler,
> +			IRQF_TRIGGER_RISING,
> +			indio_dev->name,
> +			data);
> +		if (ret < 0) {
> +			dev_err(dev,
> +			"request irq line failed.");
It could be diff being annoying but I'm guessing this isn't aligned
with the opening bracket.  Sometimes it's hard to do but when you
can do it easily please do as it helps readability.

> +			return -ret;
> +		}
> +		init_completion(&data->measuring_done);
> +	}
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					rm3100_trigger_handler, NULL);

devm_

Otherwise you don't clean this up properly.

> +	if (ret < 0)
> +		return ret;
> +
> +	/* 3sec more wait time. */
> +	ret = regmap_read(data->regmap, RM_REG_TMRC, &tmp);
> +	data->conversion_time = rm3100_samp_rates[tmp-RM_TMRC_OFFSET][2] + 3000;
> +
> +	/* Starting all channels' conversion. */
> +	ret = regmap_write(regmap, RM_REG_CMM,
> +		RM_CMM_PMX | RM_CMM_PMY | RM_CMM_PMZ | RM_CMM_START);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
Nope.  Can't do this without having a race condition.   You need
to ensure the userspace and in kernel interfaces are removed 'before'.
you do that RM_REG_CMM write in remove.

One option is to use devm_add_action to add a custom unwind function
to the automatic handling. The other is to not use devm for everything 
after the write above and do the device_unregister manually.

> +}
> +EXPORT_SYMBOL(rm3100_common_probe);
> +
> +int rm3100_common_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +
> +	regmap_write(regmap, RM_REG_CMM, 0x00);
> +
> +	return 0;
No real point in returning int if you are always going to put 0 in
in it.  Should probably check the regmap_write though and output
a log message if it fails (as no other way of telling).

> +}
> +EXPORT_SYMBOL(rm3100_common_remove);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magnetometer/rm3100-i2c.c
> new file mode 100644
> index 000000000000..b50dc5b1b30b
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-i2c.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for PNI RM3100 9-axis geomagnetic sensor a i2c bus.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + *
> + * User Manual available at
> + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> + *
> + * i2c slave address 0x20 + SA1 << 1 + SA0.
> + */
> +
> +#include <linux/i2c.h>
> +
> +#include "rm3100.h"
> +
> +static const struct regmap_config rm3100_regmap_config = {
> +		.reg_bits = 8,
This indenting seems an extra tab on conventional choice...
> +		.val_bits = 8,
> +
> +		.rd_table = &rm3100_readable_table,
> +		.wr_table = &rm3100_writable_table,
> +		.volatile_table = &rm3100_volatile_table,
> +
> +		.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int rm3100_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +		I2C_FUNC_SMBUS_READ_I2C_BLOCK | I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	regmap =  devm_regmap_init_i2c(client, &rm3100_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return rm3100_common_probe(&client->dev, regmap, client->irq);
> +}
> +
> +static int rm3100_remove(struct i2c_client *client)
> +{
> +	return rm3100_common_remove(&client->dev);
> +}
> +
> +static const struct of_device_id rm3100_dt_match[] = {
> +	{ .compatible = "pni,rm3100-i2c", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> +
> +static struct i2c_driver rm3100_driver = {
> +	.driver = {
> +		.name = "rm3100-i2c",
> +		.of_match_table = rm3100_dt_match,
> +	},
> +	.probe_new = rm3100_probe,
> +	.remove = rm3100_remove,
> +};
> +module_i2c_driver(rm3100_driver);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100-spi.c b/drivers/iio/magnetometer/rm3100-spi.c
> new file mode 100644
> index 000000000000..2c7dd9e3a1a2
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-spi.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for PNI RM3100 9-axis geomagnetic sensor a spi bus.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + *
> + * User Manual available at
> + * <https://www.pnicorp.com/download/rm3100-user-manual/>

Probably only worth mentioning the manual in the main file.

> + */
> +
> +#include <linux/spi/spi.h>
> +
> +#include "rm3100.h"
> +
> +static const struct regmap_config rm3100_regmap_config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +
> +		.rd_table = &rm3100_readable_table,
> +		.wr_table = &rm3100_writable_table,
> +		.volatile_table = &rm3100_volatile_table,
> +
> +		.read_flag_mask = 0x80,
> +
> +		.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int rm3100_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	/* Actually this device supports both mode 0 and mode 3. */
> +	spi->mode = SPI_MODE_0;
> +	/* data rates cannot exceeds 1Mbits. */
> +	spi->max_speed_hz = 1000000;
> +	spi->bits_per_word = 8;
> +	ret = spi_setup(spi);
> +	if (ret)
> +		return ret;
> +
> +	regmap =  devm_regmap_init_spi(spi, &rm3100_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return rm3100_common_probe(&spi->dev, regmap, spi->irq);
> +}
> +
> +static int rm3100_remove(struct spi_device *spi)
> +{
> +	return rm3100_common_remove(&spi->dev);
> +}
> +
> +static const struct of_device_id rm3100_dt_match[] = {
> +	{ .compatible = "pni,rm3100-spi", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> +
> +static struct spi_driver rm3100_driver = {
> +		.driver = {
> +				.name = "rm3100-spi",
> +				.of_match_table = rm3100_dt_match,

Indenting looks oddly deep...

> +		},
> +		.probe = rm3100_probe,
> +		.remove = rm3100_remove,
> +};
> +module_spi_driver(rm3100_driver);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer spi driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100.h b/drivers/iio/magnetometer/rm3100.h
> new file mode 100644
> index 000000000000..5e30bc0f5149
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Header file for PNI RM3100 driver
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + */
> +
> +#ifndef RM3100_CORE_H
> +#define RM3100_CORE_H
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>

What in here needs module.h?  Push that down into the
individual c files.  It's repetition but it si generally
good practice to include headers at as low a level as possible.

> +
> +#define RM_REG_REV_ID		0x36
I would prefer RM3100 as the prefix.
> +
> +/* Cycle Count Registers MSBs and LSBs. */
Could probably give these slightly more human readable names?
RM3100_REG_CC_X_MSB

Actually I doubt you use both of them in the driver anyway...
(just searched, nope you don't so drop the ones you don't
 use and then the MSB, LSB definition probably not necessary).

> +#define RM_REG_CCXM		0x04
> +#define RM_REG_CCXL		0x05
> +#define RM_REG_CCYM		0x06
> +#define RM_REG_CCYL		0x07
> +#define RM_REG_CCZM		0x08
> +#define RM_REG_CCZL		0x09
> +
> +/* Single Measurement Mode register. */
> +#define RM_REG_POLL		0x00
> +#define RM_POLL_PMX		BIT(4)
> +#define RM_POLL_PMY		BIT(5)
> +#define RM_POLL_PMZ		BIT(6)
> +
> +/* Continues Measurement Mode register. */
> +#define RM_REG_CMM		0x01
> +#define RM_CMM_START		BIT(0)
> +#define RM_CMM_DRDM		BIT(2)
> +#define RM_CMM_PMX		BIT(4)
> +#define RM_CMM_PMY		BIT(5)
> +#define RM_CMM_PMZ		BIT(6)
> +
> +/* TiMe Rate Configuration register. */
> +#define RM_REG_TMRC		0x0B
> +#define RM_TMRC_OFFSET		0x92
> +
> +/* Result Status register. */
> +#define RM_REG_STATUS		0x34
> +#define RM_STATUS_DRDY		BIT(7)
> +
> +/* Measurement result registers. */
> +#define RM_REG_MX2		0x24

You only use some of these. Not sure having defines for the
others is really helpful.

> +#define RM_REG_MX1		0x25
> +#define RM_REG_MX0		0x26
> +#define RM_REG_MY2		0x27
> +#define RM_REG_MY1		0x28
> +#define RM_REG_MY0		0x29
> +#define RM_REG_MZ2		0x2a
> +#define RM_REG_MZ1		0x2b
> +#define RM_REG_MZ0		0x2c
> +
> +#define RM_REG_HSHAKE		0x35
> +
> +#define RM_W_REG_START		RM_REG_POLL
> +#define RM_W_REG_END		RM_REG_REV_ID
> +#define RM_R_REG_START		RM_REG_POLL
> +#define RM_R_REG_END		RM_REG_HSHAKE
> +#define RM_V_REG_START		RM_REG_MX2
> +#define RM_V_REG_END		RM_REG_HSHAKE
> +
> +/* Built-In Self Test reigister. */
> +#define RM_REG_BIST		0x33
> +
> +struct rm3100_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct completion measuring_done;
> +	bool use_interrupt;
> +
> +	int conversion_time;
> +
> +	/* To protect consistency of every measurement and sampling

/*
 * To protect
 */
(common format to most of the kernel other than those 'crazy' :)
people in net and a few other corners.

> +	 * frequency change operations.
> +	 */
> +	struct mutex lock;
> +};
> +
> +extern const struct regmap_access_table rm3100_readable_table;
> +extern const struct regmap_access_table rm3100_writable_table;
> +extern const struct regmap_access_table rm3100_volatile_table;
> +
> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq);
> +int rm3100_common_remove(struct device *dev);
> +
> +#endif /* RM3100_CORE_H */

