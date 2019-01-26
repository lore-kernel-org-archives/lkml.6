Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E34C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8A921906
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548536576;
	bh=nztaeP0B3uv2G2Tew9utMMFnCp3CnqDG59NXFesvElA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AUTgWZ2EM6UZrAkAPE9ofIagsNRRBZLrKe2adNvF5ngr47EYcvBXaH7bEOcswbda5
	 kwz6SM+XHFvhbrIPSMEmUOO6cMkC4juw3SCn+5PKkQvIlPuUMEwwKHuvAPgz1dfeAl
	 mljIcdgsvkg+GWJgQizgAUl6vs5nAeEmOCA2wnAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAZVCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:02:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfAZVCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:02:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2539E21903;
        Sat, 26 Jan 2019 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548536572;
        bh=nztaeP0B3uv2G2Tew9utMMFnCp3CnqDG59NXFesvElA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=byKpORoGjiCydnMrjZYZyfkLYPNWjR2JbTkZnY/d2U+LUqRFf+vkmJWyEcX7UsugT
         kp5+80xlxX3z/YHrsFO9Y9dGI0QmS7O33A1/0MdMX1FtMzODimtKvAkSo1EYsLHbaG
         B56g+8GSYPfDOLj1k5/azJCMn3g4RnUKp0o9VMr0=
Date:   Sat, 26 Jan 2019 21:02:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Add driver support for MAX44009 light sensor
Message-ID: <20190126210247.0a7f4809@archlinux>
In-Reply-To: <3de73cb366285113e0e7c2e1938d15b7c3981891.1548529751.git.bobbyeshleman@gmail.com>
References: <3de73cb366285113e0e7c2e1938d15b7c3981891.1548529751.git.bobbyeshleman@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2019 11:15:17 -0800
Robert Eshleman <bobbyeshleman@gmail.com> wrote:

> The MAX44009 is a low-power ambient light sensor from Maxim
> Integrated. It differs from the MAX44000 in that it doesn't have
> proximity sensing and that it requires far less current (1 micro-amp
> vs 5 micro-amps). The register mapping and feature set between the
> two are different enough to require a new driver for the MAX44009.
> 
> Developed and tested with a BeagleBone Black and UDOO Neo (i.MX6SX)
> 
> Supported features:
> 
> * Reading lux (processed value)
> 
> * Rising and falling illuminance threshold
>   events
> 
> * Configuring integration time
> 
> https://datasheets.maximintegrated.com/en/ds/MAX44009.pdf
> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>

Looking pretty good.  A few last minor things inline.

thanks,

Jonathan

> ---
> Changes to v2:
> - Remove unnecessary mutex locking
> - Remove unnecessary triggered buffer support
> - Remove unnecessary wrapper functions for smbus reads and writes
> - Remove scale avail support
> - Use constant scale to provide processed values instead of raw
> - Remove IRQ_NONE return for non-shared IRQ
> - Style cleanup
> 
>  drivers/iio/light/Kconfig    |  10 +
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/max44009.c | 540 +++++++++++++++++++++++++++++++++++
>  3 files changed, 551 insertions(+)
>  create mode 100644 drivers/iio/light/max44009.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 36f458433480..5190eacfeb0a 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -299,6 +299,16 @@ config MAX44000
>  	 To compile this driver as a module, choose M here:
>  	 the module will be called max44000.
>  
> +config MAX44009
> +	tristate "MAX44009 Ambient Light Sensor"
> +	depends on I2C
> +	help
> +	 Say Y here if you want to build support for Maxim Integrated's
> +	 MAX44009 ambient light sensor device.
> +
> +	 To compile this driver as a module, choose M here:
> +	 the module will be called max44009.
> +
>  config OPT3001
>  	tristate "Texas Instruments OPT3001 Light Sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 286bf3975372..e40794fbb435 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_LTR501)		+= ltr501.o
>  obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
>  obj-$(CONFIG_MAX44000)		+= max44000.o
> +obj-$(CONFIG_MAX44009)		+= max44009.o
>  obj-$(CONFIG_OPT3001)		+= opt3001.o
>  obj-$(CONFIG_PA12203001)	+= pa12203001.o
>  obj-$(CONFIG_RPR0521)		+= rpr0521.o
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> new file mode 100644
> index 000000000000..5294df629ec1
> --- /dev/null
> +++ b/drivers/iio/light/max44009.c
> @@ -0,0 +1,540 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * max44009.c - Support for MAX44009 Ambient Light Sensor
> + *
> + * Copyright (c) 2019 Robert Eshleman <bobbyeshleman@gmail.com>
> + *
> + * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX44009.pdf
> + *
> + * TODO: Support continuous mode and configuring from manual mode to
> + * 	 automatic mode.
> + *
> + * Default I2C address: 0x4a
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/bits.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/util_macros.h>
> +
> +#define MAX44009_DRV_NAME "max44009"
> +
> +/* Registers in datasheet order */
> +#define MAX44009_REG_INT_STATUS 0x0
> +#define MAX44009_REG_INT_EN 0x1
> +#define MAX44009_REG_CFG 0x2
> +#define MAX44009_REG_LUX_HI 0x3
> +#define MAX44009_REG_LUX_LO 0x4
> +#define MAX44009_REG_UPPER_THR 0x5
> +#define MAX44009_REG_LOWER_THR 0x6
> +#define MAX44009_REG_THR_TIMER 0x7
> +
> +#define MAX44009_CFG_TIM_MASK GENMASK(2, 0)
> +#define MAX44009_CFG_MAN_MODE_MASK BIT(6)
> +
> +/* The maximum raw rising threshold for the max44009 */
> +#define MAX44009_MAXIMUM_THRESHOLD 7520256
> +
> +#define MAX44009_THRESH_EXP_MASK (0xf << 4)
> +#define MAX44009_THRESH_EXP_RSHIFT 4
> +#define MAX44009_THRESH_MANT_LSHIFT 4
> +#define MAX44009_THRESH_MANT_MASK 0xf
> +
> +#define MAX44009_UPPER_THR_MINIMUM 15
> +
> +/* The max44009 always scales raw readings by 0.045 and is non-configurable */
> +#define MAX44009_SCALE_NUMERATOR 45
> +#define MAX44009_SCALE_DENOMINATOR 1000
> +
> +/* The fixed-point fractional multiplier for de-scaling threshold values */
> +#define MAX44009_FRACT_MULT 1000000
> +
> +static const u32 max44009_int_time_ns_array[] = {
> +	800000000,
> +	400000000,
> +	200000000,
> +	100000000,
> +	50000000, /* Manual mode only */
> +	25000000, /* Manual mode only */
> +	12500000, /* Manual mode only */
> +	6250000,  /* Manual mode only */
> +};
> +
> +static const char max44009_int_time_str[] =
> +	"0.8 "
> +	"0.4 "
> +	"0.2 "
> +	"0.1 "
> +	"0.05 "
> +	"0.025 "
> +	"0.0125 "
> +	"0.00625";
> +
> +struct max44009_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +};
> +
> +static const struct iio_event_spec max44009_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec max44009_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +		.event_spec = max44009_event_spec,
> +		.num_event_specs = ARRAY_SIZE(max44009_event_spec),
> +	},
> +};
> +
> +static int max44009_read_int_time(struct max44009_data *data)
> +{
> +
> +	int ret = i2c_smbus_read_byte_data(data->client, MAX44009_REG_CFG);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return max44009_int_time_ns_array[ret & MAX44009_CFG_TIM_MASK];
> +}
> +
> +static int max44009_write_int_time(struct max44009_data *data, int val, int val2)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret, int_time, config;
> +	s64 ns;
> +
> +	ns = val * NSEC_PER_SEC + val2;
> +	int_time = find_closest_descending(
> +			ns,
> +			max44009_int_time_ns_array,
> +			ARRAY_SIZE(max44009_int_time_ns_array));
> +
> +	ret = i2c_smbus_read_byte_data(client, MAX44009_REG_CFG);
> +	if (ret < 0)
> +		return ret;
> +
> +	config = ret;
> +	config &= int_time | ~MAX44009_CFG_TIM_MASK;

Given int_time came from an array we control in the driver, is there
a reason to bother with the mask?

> +
> +	/* To set the integration time, the device must also be in manual mode. */
> +	config |= MAX44009_CFG_MAN_MODE_MASK;
> +
> +	return i2c_smbus_write_byte_data(client, MAX44009_REG_CFG, config);
> +}
> +
> +static int max44009_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct max44009_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask == IIO_CHAN_INFO_INT_TIME && chan->type == IIO_LIGHT) {
> +		mutex_lock(&data->lock);
> +		ret = max44009_write_int_time(data, val, val2);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int max44009_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static int max44009_lux_raw(u8 hi, u8 lo)
> +{
> +	int mantissa;
> +	int exponent;
> +
> +	/*
> +	 * The mantissa consists of the low nibble of the Lux High Byte
> +	 * and the low nibble of the Lux Low Byte.
> +	 */
> +	mantissa = (hi & 0xf) << 4;
> +	mantissa |= lo & 0xf;
I'd roll those two into one line.  The separation doesn't help readability.
> +
> +	/* The exponent byte is just the upper nibble of the Lux High Byte */
> +	exponent = (hi >> 4) & 0xf;
> +
> +	/* 
> +	 * The exponent value is base 2 to the power of the raw exponent byte.
> +	 */
> +	exponent = 1 << exponent;
> +
> +	return exponent * mantissa;
> +}
> +
> +#define MAX44009_READ_LUX_XFER_LEN (4)
> +
> +static int max44009_read_lux_raw(struct max44009_data *data)
> +{
> +	int ret;
> +	u8 hireg = MAX44009_REG_LUX_HI;
> +	u8 loreg = MAX44009_REG_LUX_HI;
This seems odd...   Not LO?
Definitely needs a comment if there is a reason why not.

> +	u8 lo = 0;
> +	u8 hi = 0;
> +
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = data->client->addr,
> +			.flags = 0,
> +			.len = sizeof(hireg),
> +			.buf = &hireg,
> +		},
> +		{
> +			.addr = data->client->addr,
> +			.flags = I2C_M_RD,
> +			.len = sizeof(hi),
> +			.buf = &hi,
> +		},
> +		{
> +			.addr = data->client->addr,
> +			.flags = 0,
> +			.len = sizeof(loreg),
> +			.buf = &loreg,
> +		},
> +		{
> +			.addr = data->client->addr,
> +			.flags = I2C_M_RD,
> +			.len = sizeof(lo),
> +			.buf = &lo,
> +		}
> +	};
> +
> +	/*
> +	 * Use i2c_transfer instead of smbus read because i2c_transfer
> +	 * does NOT use a stop bit between address write and data read.
> +	 * Using a stop bit causes disjoint upper/lower byte reads and
> +	 * reduces accuracy.
> +	 */
> +	ret = i2c_transfer(data->client->adapter, msgs, MAX44009_READ_LUX_XFER_LEN);
> +	if (ret != MAX44009_READ_LUX_XFER_LEN)
> +		return -EIO;
> +
> +	return max44009_lux_raw(hi, lo);
> +}
> +
> +static int max44009_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct max44009_data *data = iio_priv(indio_dev);
> +	int lux_raw;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = max44009_read_lux_raw(data);
> +			if (ret < 0)
> +				return ret;
> +			lux_raw = ret;
> +
> +			*val = lux_raw * MAX44009_SCALE_NUMERATOR;
> +			*val2 = MAX44009_SCALE_DENOMINATOR;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_INT_TIME:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = max44009_read_int_time(data);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val2 = ret;
> +			*val = 0;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static IIO_CONST_ATTR(illuminance_integration_time_available,
> +		      max44009_int_time_str);
> +
> +static struct attribute *max44009_attributes[] = {
> +	&iio_const_attr_illuminance_integration_time_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group max44009_attribute_group = {
> +	.attrs = max44009_attributes,
> +};
> +
> +static int max44009_threshold_byte_from_fraction(int integral, int fractional)
> +{
> +	int mantissa, exp;
> +
> +	if ((integral <= 0 && fractional <= 0) ||
> +	     integral > MAX44009_MAXIMUM_THRESHOLD ||
> +	     (integral == MAX44009_MAXIMUM_THRESHOLD && fractional != 0))
> +		return -EINVAL;
> +
> +	/* Reverse scaling of fixed-point integral */
> +	mantissa = integral * MAX44009_SCALE_DENOMINATOR;
> +	mantissa /= MAX44009_SCALE_NUMERATOR;
> +
> +	/* Reverse scaling of fixed-point fractional */
> +	mantissa += fractional / MAX44009_FRACT_MULT *
> +		    (MAX44009_SCALE_DENOMINATOR / MAX44009_SCALE_NUMERATOR);
> +
> +	for (exp = 0; mantissa > 0xff; exp++)
> +		mantissa >>= 1;
> +
> +	mantissa >>= 4;
> +	mantissa &= 0xf;
> +	exp <<= 4;
> +
> +	return exp | mantissa;
> +}
> +
> +static int max44009_get_thr_reg(enum iio_event_direction dir)
> +{
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		return MAX44009_REG_UPPER_THR;
> +	case IIO_EV_DIR_FALLING:
> +		return MAX44009_REG_LOWER_THR;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max44009_write_event_value(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      enum iio_event_info info,
> +				      int val, int val2)
> +{
> +	struct max44009_data *data = iio_priv(indio_dev);
> +	int reg, threshold;
> +
> +	if (info != IIO_EV_INFO_VALUE || chan->type != IIO_LIGHT)
> +		return -EINVAL;
> +
> +	threshold = max44009_threshold_byte_from_fraction(val, val2);
> +	if (threshold < 0)
> +		return threshold;
> +
> +	reg = max44009_get_thr_reg(dir);
> +	if (reg < 0)
> +		return reg;
> +
> +	return i2c_smbus_write_byte_data(data->client, reg, threshold);
> +}
> +
> +static int max44009_read_threshold(struct iio_dev *indio_dev, enum iio_event_direction dir)
> +{
> +	struct max44009_data *data = iio_priv(indio_dev);
> +	int byte, reg;
> +	int mantissa, exponent;
> +
> +	reg = max44009_get_thr_reg(dir);
> +	if (reg < 0)
> +		return reg;
> +
> +	byte = i2c_smbus_read_byte_data(data->client, reg);
> +	if (byte < 0)
> +		return byte;
> +
> +	mantissa = byte & MAX44009_THRESH_MANT_MASK;
> +	mantissa <<= MAX44009_THRESH_MANT_LSHIFT;
> +
> +	/* 
> +	 * To get the upper threshold, always adds the minimum upper threshold value
> +	 * to the shifted byte value (see datasheet).
> +	 */
> +	if (dir == IIO_EV_DIR_RISING)
> +		mantissa += MAX44009_UPPER_THR_MINIMUM;
> +
> +	/* Exponent is base 2 to the power of the threshold exponent byte value */
> +	exponent = 1 << ((byte & MAX44009_THRESH_EXP_MASK) >> MAX44009_THRESH_EXP_RSHIFT);
> +
> +	return exponent * mantissa;
> +}
> +
> +static int max44009_read_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int *val, int *val2)
> +{
> +	int ret;
> +	int threshold;
> +
> +	if (chan->type != IIO_LIGHT || type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	ret = max44009_read_threshold(indio_dev, dir);
> +	if (ret < 0)
> +		return ret;
> +	threshold = ret;
> +
> +	*val = threshold * MAX44009_SCALE_NUMERATOR;
> +	*val2 = MAX44009_SCALE_DENOMINATOR;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int max44009_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	struct max44009_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_LIGHT || type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, MAX44009_REG_INT_EN, state);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Set device to trigger interrupt immediately upon exceeding
> +	 * the threshold limit.
> +	 */
> +	return i2c_smbus_write_byte_data(data->client, MAX44009_REG_THR_TIMER, 0);
> +}
> +
> +static int max44009_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct max44009_data *data = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_LIGHT || type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	return i2c_smbus_read_byte_data(data->client, MAX44009_REG_INT_EN);
> +}
> +
> +static const struct iio_info max44009_info = {
> +	.read_raw = max44009_read_raw,
> +	.write_raw = max44009_write_raw,
> +	.write_raw_get_fmt = max44009_write_raw_get_fmt,
> +	.read_event_value = max44009_read_event_value,
> +	.read_event_config = max44009_read_event_config,
> +	.write_event_value = max44009_write_event_value,
> +	.write_event_config = max44009_write_event_config,
> +	.attrs = &max44009_attribute_group,
> +};
> +
> +static irqreturn_t max44009_threaded_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct max44009_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	iio_push_event(indio_dev,
> +		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +					    IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> +		       iio_get_time_ns(indio_dev));
> +
> +	ret = i2c_smbus_read_byte_data(data->client, MAX44009_REG_INT_STATUS);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "failed to clear interrupt\n");
> +

Hmm. Given there is a status register we should probably read it and only
return handled if the status bit is actually set.  There is no need to
block shared interrupt handling if we don't need to.  This isn't a high
speed device, so the bus traffic delay probably doesn't matter (do say
if it does for some reason for you).

> +	return IRQ_HANDLED;
> +}
> +
> +static int max44009_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct max44009_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
nitpick if we go for a v3.  A blank line here helps readability a bit.

> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &max44009_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = MAX44009_DRV_NAME;
> +	indio_dev->channels = max44009_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max44009_channels);
> +	mutex_init(&data->lock);
> +
> +	/* Clear any stale interrupt bit */
> +	ret = i2c_smbus_read_byte_data(client, MAX44009_REG_CFG);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL,
> +						max44009_threaded_irq_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"max44009_event",
> +						indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id max44009_id[] = {
> +	{ "max44009", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max44009_id);
> +
> +static struct i2c_driver max44009_driver = {
> +	.driver = {
> +		.name = MAX44009_DRV_NAME,
> +	},
> +	.probe = max44009_probe,
> +	.id_table = max44009_id,
> +};
> +module_i2c_driver(max44009_driver);
> +
> +static const struct of_device_id max44009_of_match[] = {
> +	{ .compatible = "maxim,max44009" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max44009_of_match);
> +
> +MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");

