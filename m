Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04501C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E7F217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyYNlfqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E7F217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeHDAOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbeHDAOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:14:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 233DD2178F;
        Fri,  3 Aug 2018 22:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533334589;
        bh=EM43g62YIjAowVQYNxYNmSnths41hw8fL1TmzohLfNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pyYNlfqaqgXgUFX/+u9Ir2b5CfDK203yTnDLR1MErP0SM13hHLNkhKXomRZ45Yrxc
         afveKQd1qH6wJ7WXJizCnrdTXCBW+aHHJX12NXhCMNqzueJDNhI0ld9pbecjlLphLv
         Laicn2FrGQJdpy1vtX9bohYRpqbHxjmwKHjBfKTQ=
Date:   Fri, 3 Aug 2018 23:16:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v3 1/2] iio: light: Add support for vishay vcnl4035
Message-ID: <20180803231624.1557825f@archlinux>
In-Reply-To: <9174e76f-f801-9ee7-33b9-8d1371cef75b@denx.de>
References: <20180629153802.1639514-1-pn@denx.de>
        <20180802095230.2049554-1-pn@denx.de>
        <20180802134946.00002037@huawei.com>
        <9174e76f-f801-9ee7-33b9-8d1371cef75b@denx.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 16:01:32 +0200
Parthiban Nallathambi <pn@denx.de> wrote:

> Hi Jonathan,
> 
> General query, for threshold events and persistence value (period) we
> don't have any direct MACROS similar to IIO_CONST_ATTR_INT_TIME_AVAIL
> as ABI to show the available/range of values.
> 
> For most light and proximity sensors, I could see this value of
> threshold configuration to limit the amount of interrupts. But there
> isn't direct way to show the available range for threshold or periods
> available in sysfs.
> 
> Can we consider presenting it as separate device attribute? Like,
> 
> For threshold:
> in_intensity_thresh_range_available
> in_proximity_thresh_range_available

It's an event attribute but I think you did that for later versions so
guess you already figured this out.

Don't worry about lack of macros, it is a bit random whether we bother
with them or do it long hand.

For normal attribute (not event ones) we can do it programatically but
I've not been enforcing this as the interface is a bit non obvious and
I promised to document it but still haven't done so.

I don't currently propose to add anything similar for event attributes
as there are far fewer of them, but we might eventually.

see get_available callbacks...

> 
> For period:
> in_device_persistence/period_available
> 
> 
> On 08/02/2018 02:49 PM, Jonathan Cameron wrote:
> > On Thu, 2 Aug 2018 11:52:29 +0200
> > Parthiban Nallathambi <pn@denx.de> wrote:
> >   
> >> Add support for VCNL4035, which is capable of Ambient light
> >> sensing (ALS) and proximity function. This patch adds support
> >> only for ALS function
> >>
> >> Signed-off-by: Parthiban Nallathambi <pn@denx.de>  
> > Hi Parthiban,
> > 
> > Please avoid replying to a previous thread when sending a new version.
> > It tends to lead to several things:
> > 
> > 1. Really deep threads that are very hard to follow.
> > 2. In some email clients, your email appears many pages back in the history.
> >   
> 
> Sure, will send as fresh v4 next.
> 
> > 
> > Anyhow...
> > 
> > I'm confused how the runtime pm in here is supposed to work. There seems to none
> > of the usual calls to turn the device on when needed.
> > 
> > I was expected a pm_runtime_get_sync or similar in the read_raw path.  
> 
> Yes, I missed it. Thanks, will add in v4.
> 
> > 
> > A few other bits and bobs inline.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> -------
> >>
> >> Changelog since v1:
> >>
> >> 1. Fixed 0-day warning on le16_to_cpu usage
> >> 2. Persistence value is directly mapped to datasheet's value to
> >> avoid confusions of usage from sysfs
> >>
> >> Changelog in v3:
> >> - Usage of lock is not needed, removed mutex locking
> >> - ALS threshold and persistence configuration available
> >> as events and threshold events are notified to userspace
> >> - Usage of devm_ is re-ordered and exit handling updated
> >> - Complexity in timestamp calculation is removed and used
> >> iio_get_time_ns
> >> ---
> >>   drivers/iio/light/Kconfig    |  12 +
> >>   drivers/iio/light/Makefile   |   1 +
> >>   drivers/iio/light/vcnl4035.c | 619 +++++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 632 insertions(+)
> >>   create mode 100644 drivers/iio/light/vcnl4035.c
> >>
> >> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> >> index c7ef8d1862d6..b7069a4c28a2 100644
> >> --- a/drivers/iio/light/Kconfig
> >> +++ b/drivers/iio/light/Kconfig
> >> @@ -447,6 +447,18 @@ config VCNL4000
> >>   	 To compile this driver as a module, choose M here: the
> >>   	 module will be called vcnl4000.
> >>   
> >> +config VCNL4035
> >> +	tristate "VCNL4035 combined ALS and proximity sensor"
> >> +	select REGMAP_I2C
> >> +	depends on I2C
> >> +	help
> >> +	 Say Y here if you want to build a driver for the Vishay VCNL4035,
> >> +	 combined ambient light (ALS) and proximity sensor. Currently only ALS
> >> +	 function is available.
> >> +
> >> +	 To compile this driver as a module, choose M here: the
> >> +	 module will be called vcnl4035.
> >> +
> >>   config VEML6070
> >>   	tristate "VEML6070 UV A light sensor"
> >>   	depends on I2C
> >> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> >> index 80943af5d627..dce98511a59b 100644
> >> --- a/drivers/iio/light/Makefile
> >> +++ b/drivers/iio/light/Makefile
> >> @@ -44,6 +44,7 @@ obj-$(CONFIG_TSL2772)		+= tsl2772.o
> >>   obj-$(CONFIG_TSL4531)		+= tsl4531.o
> >>   obj-$(CONFIG_US5182D)		+= us5182d.o
> >>   obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
> >> +obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
> >>   obj-$(CONFIG_VEML6070)		+= veml6070.o
> >>   obj-$(CONFIG_VL6180)		+= vl6180.o
> >>   obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
> >> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> >> new file mode 100644
> >> index 000000000000..d2b5ae32baa8
> >> --- /dev/null
> >> +++ b/drivers/iio/light/vcnl4035.c
> >> @@ -0,0 +1,619 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * VCNL4035 Ambient Light and Proximity Sensor - 7-bit I2C slave address 0x60
> >> + *
> >> + * Copyright (c) 2018, DENX Software Engineering GmbH
> >> + * Author: Parthiban Nallathambi <pn@denx.de>
> >> + *
> >> + *
> >> + * TODO: Proximity
> >> + */
> >> +#include <linux/module.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/bitops.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/pm_runtime.h>
> >> +
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> +#include <linux/iio/events.h>
> >> +#include <linux/iio/buffer.h>
> >> +#include <linux/iio/trigger.h>
> >> +#include <linux/iio/trigger_consumer.h>
> >> +#include <linux/iio/triggered_buffer.h>
> >> +
> >> +#define VCNL4035_DRV_NAME	"vcnl4035"
> >> +#define VCNL4035_IRQ_NAME	"vcnl4035_event"
> >> +#define VCNL4035_REGMAP_NAME	"vcnl4035_regmap"
> >> +
> >> +/* Device registers */
> >> +#define VCNL4035_ALS_CONF	0x00
> >> +#define VCNL4035_ALS_THDH	0x01
> >> +#define VCNL4035_ALS_THDL	0x02
> >> +#define VCNL4035_ALS_DATA	0x0B
> >> +#define VCNL4035_INT_FLAG	0x0D
> >> +#define VCNL4035_DEV_ID		0x0E
> >> +
> >> +/* Register masks */
> >> +#define VCNL4035_MODE_ALS_MASK		BIT(0)
> >> +#define VCNL4035_MODE_ALS_INT_MASK	BIT(1)
> >> +#define VCNL4035_ALS_IT_MASK		GENMASK(7, 5)
> >> +#define VCNL4035_ALS_PERS_MASK		GENMASK(3, 2)
> >> +#define VCNL4035_INT_ALS_IF_H_MASK	BIT(12)
> >> +#define VCNL4035_INT_ALS_IF_L_MASK	BIT(13)
> >> +
> >> +/* Default values */
> >> +#define VCNL4035_MODE_ALS_ENABLE	BIT(0)
> >> +#define VCNL4035_MODE_ALS_DISABLE	0x00
> >> +#define VCNL4035_MODE_ALS_INT_ENABLE	BIT(1)
> >> +#define VCNL4035_MODE_ALS_INT_DISABLE	0x00
> >> +#define VCNL4035_DEV_ID_VAL		0x80
> >> +#define VCNL4035_ALS_IT_DEFAULT		0x01
> >> +#define VCNL4035_ALS_PERS_DEFAULT	0x00
> >> +#define VCNL4035_ALS_THDH_DEFAULT	5000
> >> +#define VCNL4035_ALS_THDL_DEFAULT	100
> >> +#define VCNL4035_SLEEP_DELAY_MS		2000
> >> +
> >> +struct vcnl4035_data {
> >> +	struct i2c_client *client;
> >> +	struct regmap *regmap;
> >> +	unsigned int als_it_val;
> >> +	unsigned int als_persistence:4;
> >> +	unsigned int als_thresh_low;
> >> +	unsigned int als_thresh_high;
> >> +	struct iio_trigger *drdy_trigger0;
> >> +};
> >> +
> >> +static inline bool vcnl4035_is_triggered(struct vcnl4035_data *data)
> >> +{
> >> +	int ret;
> >> +	int reg;
> >> +
> >> +	ret = regmap_read(data->regmap, VCNL4035_INT_FLAG, &reg);
> >> +	if (ret < 0)
> >> +		return false;
> >> +	if (reg & (VCNL4035_INT_ALS_IF_H_MASK | VCNL4035_INT_ALS_IF_L_MASK))
> >> +		return true;
> >> +	else
> >> +		return false;
> >> +}
> >> +
> >> +static irqreturn_t vcnl4035_drdy_irq_thread(int irq, void *private)
> >> +{
> >> +	struct iio_dev *indio_dev = private;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	if (vcnl4035_is_triggered(data)) {
> >> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> >> +							0,
> >> +							IIO_EV_TYPE_THRESH,
> >> +							IIO_EV_DIR_EITHER),
> >> +				iio_get_time_ns(indio_dev));
> >> +		iio_trigger_poll_chained(data->drdy_trigger0);  
> > 
> > Hmm. So a single interrupt is used both as a trigger and as a threshold event.
> > A little unusual but fair enough.
> >   
> >> +		return IRQ_HANDLED;
> >> +	}
> >> +
> >> +	return IRQ_NONE;
> >> +}
> >> +
> >> +/* Triggered buffer */
> >> +static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +	u16 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)];
> >> +	int ret;
> >> +
> >> +	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
> >> +	if (!ret)
> >> +		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> >> +						iio_get_time_ns(indio_dev));
> >> +	else
> >> +		dev_err(&data->client->dev,
> >> +			"Trigger consumer can't read from sensor.\n");
> >> +	iio_trigger_notify_done(indio_dev->trig);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int vcnl4035_als_drdy_set_state(struct iio_trigger *trigger,
> >> +					bool enable_drdy)
> >> +{
> >> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trigger);
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +	int val = enable_drdy ? VCNL4035_MODE_ALS_INT_ENABLE :
> >> +					VCNL4035_MODE_ALS_INT_DISABLE;
> >> +
> >> +	return regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> >> +				 VCNL4035_MODE_ALS_INT_MASK,
> >> +				 val);
> >> +}
> >> +
> >> +static const struct iio_trigger_ops vcnl4035_trigger_ops = {
> >> +	.validate_device = iio_trigger_validate_own_device,
> >> +	.set_trigger_state = vcnl4035_als_drdy_set_state,
> >> +};
> >> +
> >> +/*
> >> + *	Device IT	INT Time (ms)	Scale (lux/step)
> >> + *	000		50		0.064
> >> + *	001		100		0.032
> >> + *	010		200		0.016
> >> + *	100		400		0.008
> >> + *	101 - 111	800		0.004
> >> + * Values are proportional, so ALS INT is selected for input due to
> >> + * simplicity reason. Integration time value and scaling is
> >> + * calculated based on device INT value
> >> + *
> >> + * Raw value needs to be scaled using ALS steps
> >> + *
> >> + */
> >> +static int vcnl4035_read_raw(struct iio_dev *indio_dev,
> >> +			    struct iio_chan_spec const *chan, int *val,
> >> +			    int *val2, long mask)
> >> +{
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +	int raw_data;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		ret = iio_device_claim_direct_mode(indio_dev);
> >> +		if (ret)
> >> +			return -ret;
> >> +
> >> +		ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &raw_data);
> >> +		iio_device_release_direct_mode(indio_dev);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +
> >> +		*val = raw_data;
> >> +		return IIO_VAL_INT;
> >> +	case IIO_CHAN_INFO_INT_TIME:
> >> +		*val = 50;
> >> +		if (!data->als_it_val)
> >> +			*val = data->als_it_val * 100;
> >> +		return IIO_VAL_INT;
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		*val = 64;
> >> +		if (!data->als_it_val)
> >> +			*val2 = 1000;
> >> +		else
> >> +			*val2 = data->als_it_val * 2 * 1000;
> >> +		return IIO_VAL_FRACTIONAL;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >> +static int vcnl4035_write_raw(struct iio_dev *indio_dev,
> >> +				struct iio_chan_spec const *chan,
> >> +				int val, int val2, long mask)
> >> +{
> >> +	int ret;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_INT_TIME:
> >> +		if (val <= 0 || val > 800)
> >> +			return -EINVAL;
> >> +		ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> >> +					 VCNL4035_ALS_IT_MASK,
> >> +					 val / 100);
> >> +		if (!ret)
> >> +			data->als_it_val = val / 100;
> >> +		return ret;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >> +/* No direct ABI for persistence and threshold, so eventing */
> >> +static int vcnl4035_read_thresh(struct iio_dev *indio_dev,
> >> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> >> +		enum iio_event_direction dir, enum iio_event_info info,
> >> +		int *val, int *val2)
> >> +{
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	switch (info) {
> >> +	case IIO_EV_INFO_VALUE:
> >> +		switch (dir) {
> >> +		case IIO_EV_DIR_RISING:
> >> +			*val = data->als_thresh_high;
> >> +			return IIO_VAL_INT;
> >> +		case IIO_EV_DIR_FALLING:
> >> +			*val = data->als_thresh_low;
> >> +			return IIO_VAL_INT;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +		break;
> >> +	case IIO_EV_INFO_PERIOD:
> >> +		*val = data->als_persistence;
> >> +		return IIO_VAL_INT;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +}
> >> +
> >> +static int vcnl4035_write_thresh(struct iio_dev *indio_dev,
> >> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> >> +		enum iio_event_direction dir, enum iio_event_info info, int val,
> >> +		int val2)
> >> +{
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	switch (info) {
> >> +	case IIO_EV_INFO_VALUE:
> >> +		/* 16 bit threshold range 0 - 65535 */
> >> +		if (val < 0 || val > 65535)
> >> +			return -EINVAL;
> >> +		if (dir == IIO_EV_DIR_RISING) {
> >> +			if (val < data->als_thresh_low)
> >> +				return -EINVAL;
> >> +			ret = regmap_write(data->regmap, VCNL4035_ALS_THDH,
> >> +					   val);
> >> +			if (!ret)
> >> +				data->als_thresh_high = val;
> >> +		} else {
> >> +			if (val > data->als_thresh_high)
> >> +				return -EINVAL;
> >> +			ret = regmap_write(data->regmap, VCNL4035_ALS_THDL,
> >> +					   val);
> >> +			if (!ret)
> >> +				data->als_thresh_low = val;
> >> +		}
> >> +		return ret;
> >> +	case IIO_EV_INFO_PERIOD:
> >> +		/* allow only 1 2 4 8 as persistence value */
> >> +		if (val < 0 || val > 8 || __sw_hweight8(val) != 1)
> >> +			return -EINVAL;
> >> +		ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> >> +					 VCNL4035_ALS_PERS_MASK, val);
> >> +		if (!ret)
> >> +			data->als_persistence = val;
> >> +		return ret;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >> +static IIO_CONST_ATTR_INT_TIME_AVAIL("50 100 200 400 800");
> >> +
> >> +static struct attribute *vcnl4035_attributes[] = {
> >> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> >> +	NULL,
> >> +};
> >> +
> >> +static const struct attribute_group vcnl4035_attribute_group = {
> >> +	.attrs = vcnl4035_attributes,
> >> +};
> >> +
> >> +static const struct iio_info vcnl4035_info = {
> >> +	.read_raw		= vcnl4035_read_raw,
> >> +	.write_raw		= vcnl4035_write_raw,
> >> +	.read_event_value	= vcnl4035_read_thresh,
> >> +	.write_event_value	= vcnl4035_write_thresh,
> >> +	.attrs			= &vcnl4035_attribute_group,
> >> +};
> >> +
> >> +enum vcnl4035_scan_index_order {
> >> +	VCNL4035_CHAN_INDEX_LIGHT,
> >> +};
> >> +
> >> +static const unsigned long vcnl4035_available_scan_masks[] = {
> >> +	BIT(VCNL4035_CHAN_INDEX_LIGHT),  
> > 
> > You only need to provide this if there restrictions on which channels can
> > be run together.  Here there do not seem to be (as there is only one channel)
> > so you don't need it.  
> 
> Same device supports proximity as well, so will extend it. Yes, this is
> not required until proximity comes in place. Will remove it now.
> 
> >   
> >> +	0
> >> +};
> >> +
> >> +static const struct iio_event_spec vcnl4035_event_spec[] = {
> >> +	{
> >> +		.type = IIO_EV_TYPE_THRESH,
> >> +		.dir = IIO_EV_DIR_RISING,
> >> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> >> +	}, {
> >> +		.type = IIO_EV_TYPE_THRESH,
> >> +		.dir = IIO_EV_DIR_FALLING,
> >> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> >> +	}, {
> >> +		.type = IIO_EV_TYPE_THRESH,
> >> +		.dir = IIO_EV_DIR_EITHER,
> >> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
> >> +	},
> >> +};
> >> +
> >> +static const struct iio_chan_spec vcnl4035_channels[] = {
> >> +	{
> >> +		.type = IIO_INTENSITY,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> >> +				BIT(IIO_CHAN_INFO_SCALE),
> >> +		.event_spec = vcnl4035_event_spec,
> >> +		.num_event_specs = ARRAY_SIZE(vcnl4035_event_spec),
> >> +		.scan_index = VCNL4035_CHAN_INDEX_LIGHT,
> >> +		.scan_type = {
> >> +			.sign = 'u',
> >> +			.realbits = 16,
> >> +			.storagebits = 16,
> >> +			.endianness = IIO_LE,
> >> +		},
> >> +	},
> >> +};
> >> +
> >> +static int vcnl4035_set_als_power_state(struct vcnl4035_data *data, u8 status)
> >> +{
> >> +	return regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> >> +					VCNL4035_MODE_ALS_MASK,
> >> +					status);
> >> +}
> >> +
> >> +static int vcnl4035_init(struct vcnl4035_data *data)
> >> +{
> >> +	int ret;
> >> +	int id;
> >> +
> >> +	ret = regmap_read(data->regmap, VCNL4035_DEV_ID, &id);
> >> +	if (ret < 0) {
> >> +		dev_err(&data->client->dev, "Failed to read DEV_ID register\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	if (id != VCNL4035_DEV_ID_VAL) {
> >> +		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
> >> +			id, VCNL4035_DEV_ID_VAL);
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +#ifndef CONFIG_PM
> >> +	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +#endif
> >> +	/* set default integration time - 100 ms for ALS */
> >> +	ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> >> +				 VCNL4035_ALS_IT_MASK,
> >> +				 VCNL4035_ALS_IT_DEFAULT);
> >> +	if (ret) {
> >> +		pr_err("regmap_update_bits default ALS IT returned %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +	data->als_it_val = VCNL4035_ALS_IT_DEFAULT;
> >> +
> >> +	/* set default persistence time - 1 for ALS */
> >> +	ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> >> +				 VCNL4035_ALS_PERS_MASK,
> >> +				 VCNL4035_ALS_PERS_DEFAULT);
> >> +	if (ret) {
> >> +		pr_err("regmap_update_bits default PERS returned %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +	data->als_persistence = VCNL4035_ALS_PERS_DEFAULT;
> >> +
> >> +	/* set default HIGH threshold for ALS */
> >> +	ret = regmap_write(data->regmap, VCNL4035_ALS_THDH,
> >> +				VCNL4035_ALS_THDH_DEFAULT);
> >> +	if (ret) {
> >> +		pr_err("regmap_write default THDH returned %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +	data->als_thresh_high = VCNL4035_ALS_THDH_DEFAULT;
> >> +
> >> +	/* set default LOW threshold for ALS */
> >> +	ret = regmap_write(data->regmap, VCNL4035_ALS_THDL,
> >> +				VCNL4035_ALS_THDL_DEFAULT);
> >> +	if (ret) {
> >> +		pr_err("regmap_write default THDL returned %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +	data->als_thresh_low = VCNL4035_ALS_THDL_DEFAULT;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static bool vcnl4035_is_volatile_reg(struct device *dev, unsigned int reg)
> >> +{
> >> +	switch (reg) {
> >> +	case VCNL4035_ALS_CONF:
> >> +	case VCNL4035_DEV_ID:
> >> +		return false;
> >> +	default:
> >> +		return true;
> >> +	}
> >> +}
> >> +
> >> +static const struct regmap_config vcnl4035_regmap_config = {
> >> +	.name		= VCNL4035_REGMAP_NAME,
> >> +	.reg_bits	= 8,
> >> +	.val_bits	= 16,
> >> +	.max_register	= VCNL4035_DEV_ID,
> >> +	.cache_type	= REGCACHE_RBTREE,
> >> +	.volatile_reg	= vcnl4035_is_volatile_reg,
> >> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> >> +};
> >> +
> >> +static int vcnl4035_probe(struct i2c_client *client,
> >> +				const struct i2c_device_id *id)
> >> +{
> >> +	struct vcnl4035_data *data;
> >> +	struct iio_dev *indio_dev;
> >> +	struct regmap *regmap;
> >> +	int ret;
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	regmap = devm_regmap_init_i2c(client, &vcnl4035_regmap_config);
> >> +	if (IS_ERR(regmap)) {
> >> +		dev_err(&client->dev, "regmap_init failed!\n");
> >> +		return PTR_ERR(regmap);
> >> +	}
> >> +
> >> +	data = iio_priv(indio_dev);
> >> +	i2c_set_clientdata(client, indio_dev);
> >> +	data->client = client;
> >> +	data->regmap = regmap;
> >> +
> >> +	indio_dev->dev.parent = &client->dev;
> >> +	indio_dev->info = &vcnl4035_info;
> >> +	indio_dev->name = VCNL4035_DRV_NAME;
> >> +	indio_dev->channels = vcnl4035_channels;
> >> +	indio_dev->num_channels = ARRAY_SIZE(vcnl4035_channels);
> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +
> >> +	ret = vcnl4035_init(data);
> >> +	if (ret < 0) {
> >> +		dev_err(&client->dev, "vcnl4035 chip init failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = pm_runtime_set_active(&client->dev);
> >> +	if (ret < 0)
> >> +		goto fail_poweroff;
> >> +
> >> +	pm_runtime_enable(&client->dev);
> >> +	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4035_SLEEP_DELAY_MS);
> >> +	pm_runtime_use_autosuspend(&client->dev);
> >> +
> >> +	if (client->irq) {
> >> +		data->drdy_trigger0 = devm_iio_trigger_alloc(
> >> +			indio_dev->dev.parent,
> >> +			"%s-dev%d", indio_dev->name, indio_dev->id);
> >> +		if (!data->drdy_trigger0) {
> >> +			ret = -ENOMEM;
> >> +			goto fail_pm_disable;
> >> +		}
> >> +		data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
> >> +		data->drdy_trigger0->ops = &vcnl4035_trigger_ops;
> >> +		indio_dev->available_scan_masks = vcnl4035_available_scan_masks;
> >> +		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
> >> +		ret = iio_trigger_register(data->drdy_trigger0);
> >> +		if (ret) {
> >> +			dev_err(&client->dev, "iio trigger register failed\n");
> >> +			goto fail_pm_disable;
> >> +		}
> >> +
> >> +		/* Trigger setup */
> >> +		ret = iio_triggered_buffer_setup(indio_dev, NULL,
> >> +					vcnl4035_trigger_consumer_handler,
> >> +					NULL);
> >> +		if (ret < 0) {
> >> +			dev_err(&client->dev, "iio triggered buffer setup failed\n");
> >> +			goto fail_buffer_clean;  
> > This flow doesn't look right.  iio_triggered_buffer_setup should be cleaning up
> > after itself if an error occurs within it.
> > 
> > As such you shouldn't be calling iio_triggered_buffer_cleanup.  
> 
> Will re-order this, if not with new goto label.
> 
> >   
> >> +		}
> >> +
> >> +		/* IRQ to trigger mapping */
> >> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> >> +			NULL, vcnl4035_drdy_irq_thread,
> >> +			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >> +			VCNL4035_IRQ_NAME, indio_dev);
> >> +		if (ret < 0) {
> >> +			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
> >> +				client->irq);
> >> +			goto fail_buffer_clean;
> >> +			}
> >> +	}
> >> +
> >> +	ret = iio_device_register(indio_dev);
> >> +	if (ret)
> >> +		goto fail_buffer_clean;
> >> +	return 0;
> >> +
> >> +fail_buffer_clean:
> >> +	iio_trigger_unregister(data->drdy_trigger0);  
> > This ordering should be the reverse of the above, so the trigger unregister
> > should be after the buffer_cleanup call.  
> 
> Sure, thanks.
> 
> >   
> >> +	iio_triggered_buffer_cleanup(indio_dev);
> >> +fail_pm_disable:
> >> +	pm_runtime_disable(&client->dev);
> >> +	pm_runtime_set_suspended(&client->dev);
> >> +	pm_runtime_put_noidle(&client->dev);
> >> +fail_poweroff:
> >> +	vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_DISABLE);
> >> +	return ret;
> >> +}
> >> +
> >> +static int vcnl4035_remove(struct i2c_client *client)
> >> +{
> >> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	iio_device_unregister(indio_dev);
> >> +	iio_trigger_unregister(data->drdy_trigger0);  
> > 
> > As with the error handling above, this is not in reverse order
> > of how it is setup in probe which fails the 'obviously correct' test.
> >   
> >> +	iio_triggered_buffer_cleanup(indio_dev);
> >> +
> >> +	pm_runtime_disable(&client->dev);
> >> +	pm_runtime_set_suspended(&client->dev);
> >> +	pm_runtime_put_noidle(&client->dev);
> >> +
> >> +	return vcnl4035_set_als_power_state(iio_priv(indio_dev),
> >> +					VCNL4035_MODE_ALS_DISABLE);
> >> +}
> >> +
> >> +#ifdef CONFIG_PM
> >> +static int vcnl4035_runtime_suspend(struct device *dev)
> >> +{
> >> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_DISABLE);
> >> +	regcache_mark_dirty(data->regmap);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int vcnl4035_runtime_resume(struct device *dev)
> >> +{
> >> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	regcache_sync(data->regmap);
> >> +	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +	/* wait for 1 ALS integration cycle */
> >> +	msleep(data->als_it_val * 100);
> >> +
> >> +	return 0;
> >> +}
> >> +#endif
> >> +
> >> +static const struct dev_pm_ops vcnl4035_pm_ops = {
> >> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> >> +				pm_runtime_force_resume)
> >> +	SET_RUNTIME_PM_OPS(vcnl4035_runtime_suspend,
> >> +			   vcnl4035_runtime_resume, NULL)
> >> +};
> >> +
> >> +static const struct of_device_id vcnl4035_of_match[] = {
> >> +	{ .compatible = "vishay,vcnl4035", },
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, vcnl4035_of_match);
> >> +
> >> +static const struct i2c_device_id vcnl4035_id[] = {
> >> +	{ "vcnl4035", 0 },
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
> >> +
> >> +static struct i2c_driver vcnl4035_driver = {
> >> +	.driver = {
> >> +		.name   = VCNL4035_DRV_NAME,
> >> +		.pm	= &vcnl4035_pm_ops,
> >> +		.of_match_table = of_match_ptr(vcnl4035_of_match),
> >> +	},
> >> +	.probe  = vcnl4035_probe,
> >> +	.remove	= vcnl4035_remove,
> >> +	.id_table = vcnl4035_id,
> >> +};
> >> +
> >> +module_i2c_driver(vcnl4035_driver);
> >> +
> >> +MODULE_AUTHOR("Parthiban Nallathambi <pn@denx.de>");
> >> +MODULE_DESCRIPTION("VCNL4035 Ambient Light Sensor driver");
> >> +MODULE_LICENSE("GPL v2");  
> > 
> >   
> 

