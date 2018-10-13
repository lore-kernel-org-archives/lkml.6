Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73821C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062402087D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMwrKWer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062402087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeJMR4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbeJMR4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:56:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7DC2087D;
        Sat, 13 Oct 2018 10:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539425981;
        bh=Y04JirztzfJcEE2dR+T9Th7EqsFpPBy/oEVHpq0nCXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GMwrKWeropANGTi7phcZTMmlpj4RwOYKGLqtqLkbR033zQy6OWepqSiid34qCjIe8
         I9OZ/c/WcBLeNyaNnvKzhhVe5P638wjqE+wI3cDikOK840DPA3AH1FiIXcW0KL6O5f
         q/+QiflMJmlCcj0JbA3MPR0SVnwSi1fMdrlLd8UE=
Date:   Sat, 13 Oct 2018 11:19:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20181013111935.00a2e1af@archlinux>
In-Reply-To: <20181012073536.20339-4-songqiang1304521@gmail.com>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181012073536.20339-1-songqiang1304521@gmail.com>
        <20181012073536.20339-4-songqiang1304521@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 15:35:36 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> PNI RM3100 is a high resolution, large signal immunity magnetometer,
> composed of 3 single sensors and a processing chip with a MagI2C
> interface.
> 
> Following functions are available:
>  - Single-shot measurement from
>    /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
>  - Triggerd buffer measurement.
>  - DRDY pin for data ready trigger.
>  - Both i2c and spi interface are supported.
>  - Both interrupt and polling measurement is supported, depends on if
>    the 'interrupts' in DT is declared.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>

A few questions for you (getting very close to being good to go btw!)

Why do we have the 3second additional wait for conversions?  I know we
rarely wait that long, but still seems excessive.

Few more comments inline.

Thanks,

Jonathan


> ---
>  MAINTAINERS                            |   7 +
>  drivers/iio/magnetometer/Kconfig       |  29 ++
>  drivers/iio/magnetometer/Makefile      |   4 +
>  drivers/iio/magnetometer/rm3100-core.c | 627 +++++++++++++++++++++++++
>  drivers/iio/magnetometer/rm3100-i2c.c  |  58 +++
>  drivers/iio/magnetometer/rm3100-spi.c  |  64 +++
>  drivers/iio/magnetometer/rm3100.h      |  17 +
>  7 files changed, 806 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/rm3100-core.c
>  create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
>  create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
>  create mode 100644 drivers/iio/magnetometer/rm3100.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 967ce8cdd1cc..14eeeb072403 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11393,6 +11393,13 @@ M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>  S:	Maintained
>  F:	drivers/pnp/
>  
> +PNI RM3100 IIO DRIVER
> +M:	Song Qiang <songqiang1304521@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/magnetometer/rm3100*
> +F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> +
>  POSIX CLOCKS and TIMERS
>  M:	Thomas Gleixner <tglx@linutronix.de>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index ed9d776d01af..8a63cbbca4b7 100644
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
> +	tristate "PNI RM3100 3-Axis Magnetometer (I2C)"
> +	depends on I2C
> +	select SENSORS_RM3100
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to add support for the PNI RM3100 3-Axis Magnetometer.
> +
> +	  This driver can also be compiled as a module.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called rm3100-i2c.
> +
> +config SENSORS_RM3100_SPI
> +	tristate "PNI RM3100 3-Axis Magnetometer (SPI)"
> +	depends on SPI_MASTER
> +	select SENSORS_RM3100
> +	select REGMAP_SPI
> +	help
> +	  Say Y here to add support for the PNI RM3100 3-Axis Magnetometer.
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
> index 000000000000..d455982ce315
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -0,0 +1,627 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PNI RM3100 3-axis geomagnetic sensor driver core.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + *
> + * User Manual available at
> + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> + *
> + * TODO: event generation, pm.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#include "rm3100.h"
> +
> +/* Cycle Count Registers. */
> +#define RM3100_REG_CC_X			0x05
> +#define RM3100_REG_CC_Y			0x07
> +#define RM3100_REG_CC_Z			0x09
> +
> +/* Poll Measurement Mode register. */
> +#define RM3100_REG_POLL			0x00
> +#define		RM3100_POLL_X		BIT(4)
> +#define		RM3100_POLL_Y		BIT(5)
> +#define		RM3100_POLL_Z		BIT(6)
> +
> +/* Continuous Measurement Mode register. */
> +#define RM3100_REG_CMM			0x01
> +#define		RM3100_CMM_START	BIT(0)
> +#define		RM3100_CMM_X		BIT(4)
> +#define		RM3100_CMM_Y		BIT(5)
> +#define		RM3100_CMM_Z		BIT(6)
> +
> +/* TiMe Rate Configuration register. */
> +#define RM3100_REG_TMRC			0x0B
> +#define RM3100_TMRC_OFFSET		0x92
> +
> +/* Result Status register. */
> +#define RM3100_REG_STATUS		0x34
> +#define		RM3100_STATUS_DRDY	BIT(7)
> +
> +/* Measurement result registers. */
> +#define RM3100_REG_MX2			0x24
> +#define RM3100_REG_MY2			0x27
> +#define RM3100_REG_MZ2			0x2a
> +
> +#define RM3100_W_REG_START		RM3100_REG_POLL
> +#define RM3100_W_REG_END		RM3100_REG_TMRC
> +#define RM3100_R_REG_START		RM3100_REG_POLL
> +#define RM3100_R_REG_END		RM3100_REG_STATUS
> +#define RM3100_V_REG_START		RM3100_REG_POLL
> +#define RM3100_V_REG_END		RM3100_REG_STATUS
> +
> +/*
> + * This is computed by hand, is the sum of channel storage bits and padding
> + * bits, which is 4+4+4+12=24 in here.
> + */
> +#define RM3100_SCAN_BYTES		24
> +
> +struct rm3100_data {
> +	struct regmap *regmap;
> +	struct completion measuring_done;
> +	bool use_interrupt;
> +	int conversion_time;
> +	int cycle_count_index;
> +	u8 buffer[RM3100_SCAN_BYTES];
> +	struct iio_trigger *drdy_trig;
> +
> +	/*
> +	 * This lock is for protecting the consistency of series of i2c
> +	 * operations, that is, to make sure a measurement process will
> +	 * not be interrupted by a set frequency operation, which should
> +	 * be taken where a series of i2c operation starts, released where
> +	 * the operation ends.
> +	 */
> +	struct mutex lock;
> +};
> +
> +static const struct regmap_range rm3100_readable_ranges[] = {
> +	regmap_reg_range(RM3100_R_REG_START, RM3100_R_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_readable_table = {
> +	.yes_ranges = rm3100_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rm3100_readable_ranges),
> +};
> +EXPORT_SYMBOL_GPL(rm3100_readable_table);
> +
> +static const struct regmap_range rm3100_writable_ranges[] = {
> +	regmap_reg_range(RM3100_W_REG_START, RM3100_W_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_writable_table = {
> +	.yes_ranges = rm3100_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rm3100_writable_ranges),
> +};
> +EXPORT_SYMBOL_GPL(rm3100_writable_table);
> +
> +static const struct regmap_range rm3100_volatile_ranges[] = {
> +	regmap_reg_range(RM3100_V_REG_START, RM3100_V_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_volatile_table = {
> +	.yes_ranges = rm3100_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rm3100_volatile_ranges),
> +};
> +EXPORT_SYMBOL_GPL(rm3100_volatile_table);
> +
> +static irqreturn_t rm3100_thread_fn(int irq, void *d)
> +{
> +	struct iio_dev *indio_dev = d;
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +
> +	/*
> +	 * Write operation to any register or read operation
> +	 * to first byte of results will clear the interrupt.
> +	 */
> +	regmap_write(data->regmap, RM3100_REG_POLL, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rm3100_irq_handler(int irq, void *d)
> +{
> +	struct iio_dev *indio_dev = d;
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +
> +	switch (indio_dev->currentmode) {
> +	case INDIO_DIRECT_MODE:
> +		complete(&data->measuring_done);
> +		break;
> +	case INDIO_BUFFER_TRIGGERED:
> +		iio_trigger_poll(data->drdy_trig);
> +		break;
> +	/* Initializing state. */

This needs more info.  I can't immediately see how we would ever get here
without a spurious interrupt.

> +	case 0:
> +		break;
> +	default:
> +		dev_err(indio_dev->dev.parent,
> +			"device mode out of control, current mode: %d",
> +			indio_dev->currentmode);
> +	}
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static int rm3100_wait_measurement(struct rm3100_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	unsigned int val;
> +	int tries = 20;
> +	int ret;
> +
> +	/*
> +	 * A read cycle of 400kbits i2c bus is about 20us, plus the time
> +	 * used for scheduling, a read cycle of fast mode of this device
> +	 * can reach 1.7ms, it may be possible for data to arrive just
> +	 * after we check the RM3100_REG_STATUS. In this case, irq_handler is
> +	 * called before measuring_done is reinitialized, it will wait
> +	 * forever for data that has already been ready.
> +	 * Reinitialize measuring_done before looking up makes sure we
> +	 * will always capture interrupt no matter when it happens.
> +	 */
> +	if (data->use_interrupt)
> +		reinit_completion(&data->measuring_done);
> +
> +	ret = regmap_read(regmap, RM3100_REG_STATUS, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((val & RM3100_STATUS_DRDY) != RM3100_STATUS_DRDY) {
> +		if (data->use_interrupt) {
> +			ret = wait_for_completion_timeout(&data->measuring_done,
> +				msecs_to_jiffies(data->conversion_time));
> +			if (ret < 0)
> +				return -ETIMEDOUT;
> +		} else {
> +			do {
> +				usleep_range(1000, 5000);
> +
> +				ret = regmap_read(regmap, RM3100_REG_STATUS,
> +						  &val);
> +				if (ret < 0)
> +					return ret;
> +
> +				if (val & RM3100_STATUS_DRDY)
> +					break;
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
> +	ret = regmap_write(regmap, RM3100_REG_POLL, BIT(4 + idx));
> +	if (ret < 0)
> +		goto unlock_return;
> +
> +	ret = rm3100_wait_measurement(data);
> +	if (ret < 0)
> +		goto unlock_return;
> +
> +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3);
> +	if (ret < 0)
> +		goto unlock_return;
> +	mutex_unlock(&data->lock);
> +
> +	*val = sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
> +			     23);
> +
> +	return IIO_VAL_INT;
> +
> +unlock_return:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +#define RM3100_CHANNEL(axis, idx)					\
> +	{								\
> +		.type = IIO_MAGN,					\
> +		.modified = 1,						\
> +		.channel2 = IIO_MOD_##axis,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.scan_index = idx,					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 24,					\
> +			.storagebits = 32,				\
> +			.shift = 8,					\
> +			.endianness = IIO_BE,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec rm3100_channels[] = {
> +	RM3100_CHANNEL(X, 0),
> +	RM3100_CHANNEL(Y, 1),
> +	RM3100_CHANNEL(Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> +	"600 300 150 75 37 18 9 4.5 2.3 1.2 0.6 0.3 0.015 0.075"
> +);
> +
> +static struct attribute *rm3100_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group rm3100_attribute_group = {
> +	.attrs = rm3100_attributes,
> +};
> +
> +#define RM3100_SAMP_NUM			14
> +
> +/*
> + * Frequency : rm3100_samp_rates[][0].rm3100_samp_rates[][1]Hz.
> + * Time between reading: rm3100_sam_rates[][2]ms.
> + * The first one is actually 1.7ms.
> + */
> +static const int rm3100_samp_rates[RM3100_SAMP_NUM][3] = {
> +	{600, 0, 2}, {300, 0, 3}, {150, 0, 7}, {75, 0, 13}, {37, 0, 27},
> +	{18, 0, 55}, {9, 0, 110}, {4, 500000, 220}, {2, 300000, 440},
> +	{1, 200000, 800}, {0, 600000, 1600}, {0, 300000, 3300},
> +	{0, 15000, 6700},  {0, 75000, 13000}
> +};
> +
> +static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
> +{
> +	int ret;
> +	unsigned int tmp;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
> +	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int rm3100_set_cycle_count(struct rm3100_data *data, int val)
> +{
> +	int ret;
> +	u8 i;
> +
> +	for (i = 0; i < 3; i++) {
> +		ret = regmap_write(data->regmap, RM3100_REG_CC_X + 2 * i, val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	switch (val) {
> +	case 50:
> +		data->cycle_count_index = 0;

This feels like a level of indirection that doesn't add anything.
The index value is only used to allow us to read back the value
if read from sysfs.   Might as well just cache val directly rather
than jumping backwards and forwards.

> +		break;
> +	case 100:
> +		data->cycle_count_index = 1;
> +		break;
> +	/*
> +	 * This function will never be called by users' code, so here we
> +	 * assume that it will never get a wrong parameter.
> +	 */
> +	default:
> +		data->cycle_count_index = 2;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rm3100_set_samp_freq(struct rm3100_data *data, int val, int val2)
> +{
> +	struct regmap *regmap = data->regmap;
> +	unsigned int cycle_count;
> +	int ret;
> +	int i;
> +
> +	mutex_lock(&data->lock);
> +	/* All cycle count registers use the same value. */
> +	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
> +	if (ret < 0)
> +		goto unlock_return;
> +
> +	for (i = 0; i < RM3100_SAMP_NUM; i++) {
> +		if (val == rm3100_samp_rates[i][0] &&
> +		    val2 == rm3100_samp_rates[i][1])
> +			break;
> +	}
> +	if (i == RM3100_SAMP_NUM) {
> +		ret = -EINVAL;
> +		goto unlock_return;
> +	}
> +
> +	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
> +	if (ret < 0)
> +		goto unlock_return;
> +
> +	/* Checking if cycle count registers need changing. */
> +	if (val == 600 && cycle_count == 200) {
> +		ret = rm3100_set_cycle_count(data, 100);
> +		if (ret < 0)
> +			goto unlock_return;
> +	} else if (val != 600 && cycle_count == 100) {
> +		ret = rm3100_set_cycle_count(data, 200);
> +		if (ret < 0)
> +			goto unlock_return;
> +	}
> +
> +	/* Writing TMRC registers requires CMM reset. */
> +	ret = regmap_write(regmap, RM3100_REG_CMM, 0);
> +	if (ret < 0)
> +		goto unlock_return;
> +	ret = regmap_write(regmap, RM3100_REG_CMM,
> +		RM3100_CMM_X | RM3100_CMM_Y | RM3100_CMM_Z | RM3100_CMM_START);

This seems unlikely to be correct in general.  I 'think' we only want to
do restore this value to what it was previously set to rather than enable
continuous mode under all conditions.

> +	if (ret < 0)
> +		goto unlock_return;
> +	mutex_unlock(&data->lock);
> +
> +	data->conversion_time = rm3100_samp_rates[i][2] + 3000;
> +	return 0;
> +
> +unlock_return:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/*
> + * The scale of this sensor depends on the cycle count value, these three
> + * values are corresponding to the cycle count value 50, 100, 200.
> + * scale = output / gain * 10^4.
> + */
> +const static int rm3100_scale[] = {500, 263, 133};
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
> +
> +		ret = rm3100_read_mag(data, chan->scan_index, val);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = rm3100_scale[data->cycle_count_index];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return rm3100_get_samp_freq(data, val, val2);
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
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return rm3100_set_samp_freq(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +
Nitpick of the day: Blank line not useful here so get rid of it.

> +}
> +
> +static const struct iio_info rm3100_info = {
> +	.attrs = &rm3100_attribute_group,
> +	.read_raw = rm3100_read_raw,
> +	.write_raw = rm3100_write_raw,
> +};
> +
> +static int rm3100_buffer_preenable(struct iio_dev *iio_dev)
> +{
> +	struct rm3100_data *data = iio_priv(iio_dev);
> +
> +	/* Starting channels enabled. */
> +	return regmap_write(data->regmap, RM3100_REG_CMM,
> +		(*iio_dev->active_scan_mask & 0x7) << 4 | RM3100_CMM_START);

That shift left 4 is a magic value (as is the 0x7 mask) so probably should
be done with defines so we know they are just describing 'where' this
value goes.

> +}
> +
> +static int rm3100_buffer_postdisable(struct iio_dev *iio_dev)
> +{
> +	struct rm3100_data *data = iio_priv(iio_dev);
> +
> +	return regmap_write(data->regmap, RM3100_REG_CMM, 0);
> +}
> +
> +static const struct iio_buffer_setup_ops rm3100_buffer_ops = {
> +	.preenable = rm3100_buffer_preenable,
> +	.postenable = iio_triggered_buffer_postenable,
> +	.predisable = iio_triggered_buffer_predisable,
> +	.postdisable = rm3100_buffer_postdisable,
> +};
> +
> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	unsigned long scan_mask = *indio_dev->active_scan_mask;
> +	unsigned int mask_len = indio_dev->masklength;
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret, i, bit;
> +
> +	mutex_lock(&data->lock);
> +	switch (scan_mask) {
> +	case BIT(0) | BIT(1) | BIT(2):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
> +	case BIT(0) | BIT(1):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
> +	case BIT(1) | BIT(2):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
What about BIT(0) | BIT(2)?

Now you can do it like you have here and on that one corner case let the iio core
demux code take care of it, but then you will need to provide available_scan_masks
so the core knows it needs to handle this case.

> +	default:
> +		for_each_set_bit(bit, &scan_mask, mask_len) {
> +			ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
> +					       data->buffer + bit * 3, 3);
> +			if (ret < 0) {
> +				mutex_unlock(&data->lock);
> +				goto done;
> +			}
> +		}
> +		mutex_unlock(&data->lock);
> +	}
> +
> +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
> +	for (i = mask_len - 1; i > 0; i--)
> +		if (scan_mask | BIT(i))
> +			memcpy(data->buffer + i * 4, data->buffer + i * 3, 3);
> +
> +	/*
> +	 * Always using the same buffer so that we wouldn't need to set the
> +	 * paddings to 0 in case of leaking any data.
> +	 */
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +					   iio_get_time_ns(indio_dev));

Really minor point, but we are typically responding to a dataready trigger
here.  So the better timestamp would be one grabbed in the trigger and passed
down to here.
(under the condition it's our trigger which you'll find other drivers check
carefully).

Look for drivers using the iio_pollfunc_store function for examples.

> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void rm3100_remove(void *pdata)

I thought I mentioned this in the previous review.  The naming
was fine when it was being called as the opposite of probe, but
now we are calling it from a devm_action it would be more appropriate
to rename this function as something like, rm3100_stop_device...

The actual function is  a little odd now as it doesn't unwind
anything done in the probe but rather is a catch all for
a forced removal whilst the buffer is running.  In that particular
path we should have already had the big hammer call from
iio_device_unregister (via the devm_ path) call 
iio_disable_all_buffers.  That should end up calling your
post_disable which will have already written this register.

So the upshot is that with the refactoring of when we enable
the device to the buffer enable path, I don't think you need
this function any more.  There is nothing to clean up!

> +{
> +	struct rm3100_data *data = pdata;
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, RM3100_REG_CMM, 0x00);
> +	if (ret < 0)
> +		dev_err(dev, "failed to stop the device.\n");
> +}
> +
> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> +{
> +	struct iio_dev *indio_dev;
> +	struct rm3100_data *data;
> +	unsigned int tmp;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
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
> +
> +	if (!irq)
> +		data->use_interrupt = false;
> +	else {
> +		data->use_interrupt = true;
> +
> +		ret = devm_request_threaded_irq(dev,
> +						irq,
> +						rm3100_irq_handler,
> +						rm3100_thread_fn,
> +						IRQF_TRIGGER_HIGH |
> +						IRQF_ONESHOT,
> +						indio_dev->name,
> +						indio_dev);
> +		if (ret < 0) {
> +			dev_err(dev, "request irq line failed.\n");
> +			return ret;
> +		}
> +		init_completion(&data->measuring_done);
> +
> +		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
> +							 indio_dev->name,
> +							 indio_dev->id);
> +		if (!data->drdy_trig)
> +			return -ENOMEM;
> +
> +		data->drdy_trig->dev.parent = dev;
> +		ret = devm_iio_trigger_register(dev, data->drdy_trig);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      rm3100_trigger_handler,
> +					      &rm3100_buffer_ops);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
> +	if (ret < 0)
> +		return ret;
> +	/* Initializing max wait time, 3sec more wait time for conversion. */
> +	data->conversion_time =
> +		rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2] + 3000;
Yikes, somehow I'd missed this before.  3 Seconds?  That's huge.
Why is this device so very slow?

> +
> +	/* Cycle count values may not be what we want. */
> +	if ((tmp - RM3100_TMRC_OFFSET) == 0)
> +		rm3100_set_cycle_count(data, 100);
> +	else
> +		rm3100_set_cycle_count(data, 200);
> +
> +	ret = devm_add_action(dev, rm3100_remove, data);
> +	if (ret < 0) {
> +		rm3100_remove(data);
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(rm3100_common_probe);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magnetometer/rm3100-i2c.c
> new file mode 100644
> index 000000000000..8f02e0366886
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-i2c.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for PNI RM3100 3-axis geomagnetic sensor on a i2c bus.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + *
> + * i2c slave address: 0x20 + SA1 << 1 + SA0.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include "rm3100.h"
> +
> +static const struct regmap_config rm3100_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.rd_table = &rm3100_readable_table,
> +	.wr_table = &rm3100_writable_table,
> +	.volatile_table = &rm3100_volatile_table,
> +
> +	.cache_type = REGCACHE_RBTREE,
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
> +static const struct of_device_id rm3100_dt_match[] = {
> +	{ .compatible = "pni,rm3100", },
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
> +};
> +module_i2c_driver(rm3100_driver);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100-spi.c b/drivers/iio/magnetometer/rm3100-spi.c
> new file mode 100644
> index 000000000000..65d5eb9e4f5e
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-spi.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for PNI RM3100 3-axis geomagnetic sensor on a spi bus.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include "rm3100.h"
> +
> +static const struct regmap_config rm3100_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.rd_table = &rm3100_readable_table,
> +	.wr_table = &rm3100_writable_table,
> +	.volatile_table = &rm3100_volatile_table,
> +
> +	.read_flag_mask = 0x80,
> +
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int rm3100_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	/* Actually this device supports both mode 0 and mode 3. */
> +	spi->mode = SPI_MODE_0;
> +	/* Data rates cannot exceed 1Mbits. */
> +	spi->max_speed_hz = 1000000;
> +	spi->bits_per_word = 8;
> +	ret = spi_setup(spi);
> +	if (ret)
> +		return ret;
> +
> +	regmap = devm_regmap_init_spi(spi, &rm3100_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return rm3100_common_probe(&spi->dev, regmap, spi->irq);
> +}
> +
> +static const struct of_device_id rm3100_dt_match[] = {
> +	{ .compatible = "pni,rm3100", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> +
> +static struct spi_driver rm3100_driver = {
> +	.driver = {
> +		.name = "rm3100-spi",
> +		.of_match_table = rm3100_dt_match,
> +	},
> +	.probe = rm3100_probe,
> +};
> +module_spi_driver(rm3100_driver);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer spi driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100.h b/drivers/iio/magnetometer/rm3100.h
> new file mode 100644
> index 000000000000..c3508218bc77
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + */
> +
> +#ifndef RM3100_CORE_H
> +#define RM3100_CORE_H
> +
> +#include <linux/regmap.h>
> +
> +extern const struct regmap_access_table rm3100_readable_table;
> +extern const struct regmap_access_table rm3100_writable_table;
> +extern const struct regmap_access_table rm3100_volatile_table;
> +
> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq);
> +
> +#endif /* RM3100_CORE_H */

