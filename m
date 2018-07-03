Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34F1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A8024B7B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A8024B7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeGCM6R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:58:17 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58670 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbeGCM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:58:15 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41Kkgm50sdz1qvVT;
        Tue,  3 Jul 2018 14:58:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41Kkgm3PQsz1qsdx;
        Tue,  3 Jul 2018 14:58:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id C6AxMKzis5KE; Tue,  3 Jul 2018 14:58:10 +0200 (CEST)
X-Auth-Info: qCNOE5scjVcYbVr9iX2W2317pzT+w4I+xgaB2oH8DZA=
Received: from antares.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  3 Jul 2018 14:58:10 +0200 (CEST)
Cc:     pn@denx.de, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com, wd@denx.de,
        sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v2 1/2] iio: light: Add support for vishay vcnl4035
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20180628123021.1628338-1-pn@denx.de>
 <20180629153802.1639514-1-pn@denx.de>
 <alpine.DEB.2.21.1806301131230.15970@vps.pmeerw.net>
From:   Parthiban Nallathambi <pn@denx.de>
Message-ID: <72632762-ebca-8fce-7291-458654b5ee4c@denx.de>
Date:   Tue, 3 Jul 2018 14:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806301131230.15970@vps.pmeerw.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Thanks for your comments. Will send v3 with comments fixed.

On 06/30/2018 11:51 AM, Peter Meerwald-Stadler wrote:
> 
>> Add support for VCNL4035, which is capable of Ambient light
>> sensing (ALS) and proximity function. This patch adds support
>> only for ALS function
> 
> comments below
> 
> a lot of effort is in getting a timestamp; is it worth it for ALS
> measurement? also the implementation is quite involved, what is the idea?

Initial idea was to include proximity function together with ALS and
hence the complexity.

Yes, timestamp is not required considering only ALS data. I have removed
it now. Will send the cleaned up patch in v3.

>   
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> ---
>>
>> Changelog since v1:
>>
>> 1. Fixed 0-day warning on le16_to_cpu usage
>> 2. Persistence value is directly mapped to datasheet's value to
>> avoid confusions of usage from sysfs
>> ---
>>   drivers/iio/light/Kconfig    |  12 +
>>   drivers/iio/light/Makefile   |   1 +
>>   drivers/iio/light/vcnl4035.c | 682 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 695 insertions(+)
>>   create mode 100644 drivers/iio/light/vcnl4035.c
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index c7ef8d1862d6..b7069a4c28a2 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -447,6 +447,18 @@ config VCNL4000
>>   	 To compile this driver as a module, choose M here: the
>>   	 module will be called vcnl4000.
>>   
>> +config VCNL4035
>> +	tristate "VCNL4035 combined ALS and proximity sensor"
>> +	select REGMAP_I2C
>> +	depends on I2C
>> +	help
>> +	 Say Y here if you want to build a driver for the Vishay VCNL4035,
>> +	 combined ambient light (ALS) and proximity sensor. Currently only ALS
>> +	 function is available.
>> +
>> +	 To compile this driver as a module, choose M here: the
>> +	 module will be called vcnl4035.
>> +
>>   config VEML6070
>>   	tristate "VEML6070 UV A light sensor"
>>   	depends on I2C
>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>> index 80943af5d627..dce98511a59b 100644
>> --- a/drivers/iio/light/Makefile
>> +++ b/drivers/iio/light/Makefile
>> @@ -44,6 +44,7 @@ obj-$(CONFIG_TSL2772)		+= tsl2772.o
>>   obj-$(CONFIG_TSL4531)		+= tsl4531.o
>>   obj-$(CONFIG_US5182D)		+= us5182d.o
>>   obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>> +obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
>>   obj-$(CONFIG_VEML6070)		+= veml6070.o
>>   obj-$(CONFIG_VL6180)		+= vl6180.o
>>   obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
>> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
>> new file mode 100644
>> index 000000000000..45eccb462ed0
>> --- /dev/null
>> +++ b/drivers/iio/light/vcnl4035.c
>> @@ -0,0 +1,682 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * VCNL4035 Ambient Light and Proximity Sensor - 7-bit I2C slave address 0x60
>> + *
>> + * Copyright (c) 2018, DENX Software Engineering GmbH
>> + * Author: Parthiban Nallathambi <pn@denx.de>
>> + *
>> + *
>> + * TODO: Proximity
>> + */
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +
>> +#define VCNL4035_DRV_NAME	"vcnl4035"
>> +#define VCNL4035_IRQ_NAME	"vcnl4035_event"
>> +#define VCNL4035_REGMAP_NAME	"vcnl4035_regmap"
>> +
>> +/* Device registers */
>> +#define VCNL4035_ALS_CONF	0x00
>> +#define VCNL4035_ALS_THDH	0x01
>> +#define VCNL4035_ALS_THDL	0x02
>> +#define VCNL4035_ALS_DATA	0x0B
>> +#define	VCNL4035_INT_FLAG	0x0D
> 
> there seems to be a tab before VCNL4035_INT_FLAG, should be space

Sure, thanks. Replace with space.

> 
>> +#define VCNL4035_DEV_ID		0x0E
>> +
>> +/* Register masks */
>> +#define VCNL4035_MODE_ALS_MASK		BIT(0)
>> +#define VCNL4035_MODE_ALS_INT_MASK	BIT(1)
>> +#define VCNL4035_ALS_IT_MASK		GENMASK(7, 5)
>> +#define VCNL4035_ALS_PERS_MASK		GENMASK(3, 2)
>> +#define VCNL4035_INT_ALS_IF_H_MASK	BIT(12)
>> +#define VCNL4035_INT_ALS_IF_L_MASK	BIT(13)
>> +
>> +/* Default values */
>> +#define VCNL4035_MODE_ALS_ENABLE	BIT(0)
>> +#define VCNL4035_MODE_ALS_DISABLE	0x00
>> +#define VCNL4035_MODE_ALS_INT_ENABLE	BIT(1)
>> +#define VCNL4035_MODE_ALS_INT_DISABLE	0x00
>> +#define VCNL4035_DEV_ID_VAL		0x80
>> +#define VCNL4035_ALS_IT_DEFAULT		0x01
>> +#define VCNL4035_ALS_PERS_DEFAULT	0x00
>> +#define VCNL4035_ALS_THDH_DEFAULT	5000
>> +#define VCNL4035_ALS_THDL_DEFAULT	100
>> +#define VCNL4035_SLEEP_DELAY_MS		2000
>> +
>> +struct vcnl4035_data {
>> +	struct i2c_client *client;
>> +	struct regmap *regmap;
>> +	/* protect device settings persistence, integration time, threshold */
>> +	struct mutex lock;
>> +	unsigned int als_it_val;
>> +	unsigned int als_persistence:4;
>> +	unsigned int als_thresh_low;
>> +	unsigned int als_thresh_high;
>> +	struct iio_trigger *drdy_trigger0;
>> +	s64 irq_timestamp;
>> +};
>> +
>> +static inline bool vcnl4035_is_triggered(struct vcnl4035_data *data)
>> +{
>> +	int ret;
>> +	int reg;
>> +
>> +	ret = regmap_read(data->regmap, VCNL4035_INT_FLAG, &reg);
>> +	if (ret < 0)
>> +		return false;
>> +	if (reg & (VCNL4035_INT_ALS_IF_H_MASK | VCNL4035_INT_ALS_IF_L_MASK))
>> +		return true;
>> +	else
>> +		return false;
>> +}
>> +
>> +static irqreturn_t vcnl4035_drdy_irq_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *indio_dev = private;
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +
>> +	data->irq_timestamp = iio_get_time_ns(indio_dev);
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static irqreturn_t vcnl4035_drdy_irq_thread(int irq, void *private)
>> +{
>> +	struct iio_dev *indio_dev = private;
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +
>> +	if (vcnl4035_is_triggered(data)) {
>> +		iio_trigger_poll_chained(data->drdy_trigger0);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	return IRQ_NONE;
>> +}
>> +
>> +/* Triggered buffer */
>> +static irqreturn_t vcnl4035_trigger_consumer_store_time(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +
>> +	if (!iio_trigger_using_own(indio_dev))
>> +		pf->timestamp = iio_get_time_ns(indio_dev);
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +	int als_data;
>> +	int ret;
>> +
>> +	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
>> +		pf->timestamp = data->irq_timestamp;
>> +		data->irq_timestamp = 0;
>> +	}
>> +
>> +	if (!pf->timestamp)
>> +		pf->timestamp = iio_get_time_ns(indio_dev);
>> +
>> +	mutex_lock(&data->lock);
> 
> what is the purpose of the lock?
> the comment in vcnl4035_data doesn't mention it either

Device parameters are proportional, so lock it introduced to protect
across scaling factor, integration time, so that raw read and INT read
process it with correct/new integration time and scaling factor.

But there isn't any need to protect the data read from the register. I
will remove this lock here.

> 
>> +	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &als_data);
>> +	mutex_unlock(&data->lock);
>> +	if (!ret)
>> +		iio_push_to_buffers_with_timestamp(indio_dev,
>> +						   &als_data,
> 
> als_data needs to be large enough to hold the timestamp, see documentation
> of iio_push_to_buffers_with_timestamp()

Timestamp is removed, so I have used iio_push_to_buffers to push the raw
ALS value.

> 
>> +						   pf->timestamp);
>> +	else
>> +		dev_err(&data->client->dev,
>> +			"Trigger consumer can't read from sensor.\n");
>> +	pf->timestamp = 0;
>> +
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int vcnl4035_als_drdy_set_state(struct iio_trigger *trigger,
>> +					bool enable_drdy)
>> +{
>> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trigger);
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +	int val = enable_drdy ? VCNL4035_MODE_ALS_INT_ENABLE :
>> +					VCNL4035_MODE_ALS_INT_DISABLE;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
>> +				 VCNL4035_MODE_ALS_INT_MASK,
>> +				 val);
>> +	if (ret)
>> +		dev_err(&data->client->dev, "%s failed\n", __func__);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct iio_trigger_ops vcnl4035_trigger_ops = {
>> +	.set_trigger_state = vcnl4035_als_drdy_set_state,
>> +};
>> +
>> +/*
>> + *	Device IT	INT Time(ms)	Scale (lux/step)
> 
> maybe space before (ms)?

Sure, thanks.

> 
>> + *	000		50		0.064
>> + *	001		100		0.032
>> + *	010		200		0.016
>> + *	100		400		0.008
>> + *	101 - 111	800		0.004
>> + * Values are proportial, so ALS INT is selected for input due to
> 
> proportional

Typo corrected.

> 
>> + * simplicity reason. Integration time value and scaling is
>> + * calculated based on device INT value
>> + *
>> + * Raw value needs to be scaled using ALS STEPS
> 
> steps

Fixed it, thanks.

> 
>> + *
>> + */
>> +static int vcnl4035_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan, int *val,
>> +			    int *val2, long mask)
>> +{
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +	int busy;
> 
> needed? can 'ret' be used?

busy is removed. ret is used and directly returned, thanks

> 
>> +	int raw_data;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		busy = iio_device_claim_direct_mode(indio_dev);
>> +		if (busy)
>> +			return -EBUSY;
>> +
>> +		ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &raw_data);
>> +		iio_device_release_direct_mode(indio_dev);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		*val = raw_data;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_INT_TIME:
>> +		mutex_lock(&data->lock);
>> +		*val = data->als_it_val * 100;
>> +		if (!*val)
> 
> maybe check data->als_it_val and then set *val accordingly as done below

Ok, default is updated to 50 and condition check done.

> 
>> +			*val = 50;
>> +		mutex_unlock(&data->lock);
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		mutex_lock(&data->lock);
>> +		*val = 64;
>> +		if (!data->als_it_val)
>> +			*val2 = 1000;
>> +		else
>> +			*val2 = data->als_it_val * 2 * 1000;
>> +		mutex_unlock(&data->lock);
>> +		return IIO_VAL_FRACTIONAL;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int vcnl4035_write_raw(struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan,
>> +				int val, int val2, long mask)
>> +{
>> +	int ret;
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_INT_TIME:
>> +		if (val <= 0 || val > 800)
>> +			return -EINVAL;
>> +		mutex_lock(&data->lock);
>> +		ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
>> +					 VCNL4035_ALS_IT_MASK,
>> +					 val / 100);
>> +		if (!ret)
>> +			data->als_it_val = val / 100;
>> +		mutex_unlock(&data->lock);
>> +		break;
> 
> return ret;
> directly here

Sure.

> 
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return ret;
>> +}
>> +
>> +/* No direct ABI for persistence and threshold, so eventing */
>> +static int vcnl4035_read_thresh(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir, enum iio_event_info info,
>> +		int *val, int *val2)
>> +{
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		switch (dir) {
>> +		case IIO_EV_DIR_RISING:
>> +			mutex_lock(&data->lock);
>> +			*val = data->als_thresh_high;
>> +			mutex_unlock(&data->lock);
>> +			break;
>> +		case IIO_EV_DIR_FALLING:
>> +			mutex_lock(&data->lock);
>> +			*val = data->als_thresh_low;
>> +			mutex_unlock(&data->lock);
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case IIO_EV_INFO_PERIOD:
>> +		mutex_lock(&data->lock);
>> +		*val = data->als_persistence;
>> +		mutex_unlock(&data->lock);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return IIO_VAL_INT;
> 
> move it up, instead of the
> break;

Sure.

> 
>> +}
>> +
>> +static int vcnl4035_write_thresh(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir, enum iio_event_info info, int val,
>> +		int val2)
>> +{
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		/* 16 bit threshold range */
>> +		if (val < 0 || val > 65535)
>> +			return -EINVAL;
>> +		if (dir == IIO_EV_DIR_RISING) {
>> +			if (val < data->als_thresh_low)
>> +				return -EINVAL;
>> +			mutex_lock(&data->lock);
>> +			ret = regmap_write(data->regmap, VCNL4035_ALS_THDH,
>> +					   val);
> 
> isn't the purpose of the lock to have
> data->als_thresh_high = val;
> in the same critical section?
> 
> here and similarly below

Yes, missed this sync. Will move this part inside lock.

> 
>> +			mutex_unlock(&data->lock);
>> +			if (ret)
>> +				return ret;
>> +			data->als_thresh_high = val;
>> +		} else {
>> +			if (val > data->als_thresh_high)
>> +				return -EINVAL;
>> +			mutex_lock(&data->lock);
>> +			ret = regmap_write(data->regmap, VCNL4035_ALS_THDL,
>> +					   val);
>> +			mutex_unlock(&data->lock);
>> +			if (ret)
>> +				return ret;
>> +			data->als_thresh_low = val;
>> +		}
>> +		break;
>> +	case IIO_EV_INFO_PERIOD:
>> +		/* allow only 1 2 4 8 as persistence value */
>> +		if (val < 0 || val > 8 || (__sw_hweight8(val) != 1))
> 
> parenthesis around last condition not needed

Sure, removed.

> 
>> +			return -EINVAL;
>> +		mutex_lock(&data->lock);
>> +		ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
>> +					 VCNL4035_ALS_PERS_MASK, val);
>> +		mutex_unlock(&data->lock);
>> +		if (ret)
>> +			return ret;
>> +		data->als_persistence = val;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static IIO_CONST_ATTR(als_available_integration_time, "50 100 200 400 800");
>> +static IIO_CONST_ATTR(als_available_persistence, "1 2 4 8");
>> +static IIO_CONST_ATTR(als_available_threshold_range, "0 65535");
>> +
>> +static struct attribute *vcnl4035_attributes[] = {
>> +	&iio_const_attr_als_available_integration_time.dev_attr.attr,
>> +	&iio_const_attr_als_available_threshold_range.dev_attr.attr,
>> +	&iio_const_attr_als_available_persistence.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group vcnl4035_attribute_group = {
>> +	.attrs = vcnl4035_attributes,
>> +};
>> +
>> +static const struct iio_info vcnl4035_info = {
>> +	.read_raw		= vcnl4035_read_raw,
>> +	.write_raw		= vcnl4035_write_raw,
>> +	.read_event_value	= vcnl4035_read_thresh,
>> +	.write_event_value	= vcnl4035_write_thresh,
>> +	.attrs			= &vcnl4035_attribute_group,
>> +};
>> +
>> +enum vcnl4035_scan_index_order {
>> +	VCNL4035_CHAN_INDEX_LIGHT,
>> +};
>> +
>> +static const unsigned long vcnl4035_available_scan_masks[] = {
>> +	BIT(VCNL4035_CHAN_INDEX_LIGHT), 0
> 
> I'd put 0 in a separate line so that it can be extended with a single line
> patch (extreme nitpick)

Sure, make sense when extending it for proximity.

> 
>> +};
>> +
>> +static const struct iio_event_spec vcnl4035_event_spec[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_RISING,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_FALLING,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_EITHER,
>> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
>> +	},
>> +};
>> +
>> +static const struct iio_chan_spec vcnl4035_channels[] = {
>> +	{
>> +		.type = IIO_INTENSITY,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				BIT(IIO_CHAN_INFO_INT_TIME) |
>> +				BIT(IIO_CHAN_INFO_SCALE),
>> +		.event_spec = vcnl4035_event_spec,
>> +		.num_event_specs = ARRAY_SIZE(vcnl4035_event_spec),
>> +		.scan_index = VCNL4035_CHAN_INDEX_LIGHT,
>> +		.scan_type = {
>> +			.sign = 'u',
>> +			.realbits = 16,
>> +			.storagebits = 16,
>> +			.endianness = IIO_LE,
>> +		},
>> +	},
>> +};
>> +
>> +static int vcnl4035_set_als_power_state(struct vcnl4035_data *data, u8 status)
>> +{
>> +	return regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
>> +					VCNL4035_MODE_ALS_MASK,
>> +					status);
>> +}
>> +
>> +static int vcnl4035_init(struct vcnl4035_data *data)
>> +{
>> +	int ret;
>> +	int id;
>> +
>> +	ret = regmap_read(data->regmap, VCNL4035_DEV_ID, &id);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Failed to read DEV_ID register\n");
>> +		return ret;
>> +	}
>> +
>> +	if (id != VCNL4035_DEV_ID_VAL) {
>> +		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
>> +			id, VCNL4035_DEV_ID_VAL);
>> +		return -ENODEV;
>> +	}
>> +
>> +#ifndef CONFIG_PM
>> +	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
>> +	if (ret < 0)
>> +		return ret;
>> +#endif
>> +	/* set default integration time - 100 ms for ALS */
>> +	ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
>> +				 VCNL4035_ALS_IT_MASK,
>> +				 VCNL4035_ALS_IT_DEFAULT);
>> +	if (ret) {
>> +		pr_err("regmap_update_bits default ALS IT returned %d\n", ret);
>> +		return ret;
>> +	}
>> +	data->als_it_val = VCNL4035_ALS_IT_DEFAULT;
>> +
>> +	/* set default persistence time - 1 for ALS */
>> +	ret = regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
>> +				 VCNL4035_ALS_PERS_MASK,
>> +				 VCNL4035_ALS_PERS_DEFAULT);
>> +	if (ret) {
>> +		pr_err("regmap_update_bits default PERS returned %d\n", ret);
>> +		return ret;
>> +	}
>> +	data->als_persistence = VCNL4035_ALS_PERS_DEFAULT;
>> +
>> +	/* set default HIGH threshold for ALS */
>> +	ret = regmap_write(data->regmap, VCNL4035_ALS_THDH,
>> +				VCNL4035_ALS_THDH_DEFAULT);
>> +	if (ret) {
>> +		pr_err("regmap_write default THDH returned %d\n", ret);
>> +		return ret;
>> +	}
>> +	data->als_thresh_high = VCNL4035_ALS_THDH_DEFAULT;
>> +
>> +	/* set default LOW threshold for ALS */
>> +	ret = regmap_write(data->regmap, VCNL4035_ALS_THDL,
>> +				VCNL4035_ALS_THDL_DEFAULT);
>> +	if (ret) {
>> +		pr_err("regmap_write default THDL returned %d\n", ret);
>> +		return ret;
>> +	}
>> +	data->als_thresh_low = VCNL4035_ALS_THDL_DEFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +static bool vcnl4035_is_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case VCNL4035_ALS_CONF:
>> +	case VCNL4035_DEV_ID:
>> +		return false;
>> +	default:
>> +		return true;
>> +	}
>> +}
>> +
>> +static const struct regmap_config vcnl4035_regmap_config = {
>> +	.name		= VCNL4035_REGMAP_NAME,
>> +	.reg_bits	= 8,
>> +	.val_bits	= 16,
>> +	.max_register	= VCNL4035_DEV_ID,
>> +	.cache_type	= REGCACHE_RBTREE,
>> +	.volatile_reg	= vcnl4035_is_volatile_reg,
>> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
>> +};
>> +
>> +static int vcnl4035_probe(struct i2c_client *client,
>> +				const struct i2c_device_id *id)
>> +{
>> +	struct vcnl4035_data *data;
>> +	struct iio_dev *indio_dev;
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &vcnl4035_regmap_config);
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(&client->dev, "regmap_init failed!\n");
>> +		return PTR_ERR(regmap);
>> +	}
>> +
>> +	data = iio_priv(indio_dev);
>> +	i2c_set_clientdata(client, indio_dev);
>> +	data->client = client;
>> +	data->regmap = regmap;
>> +	mutex_init(&data->lock);
>> +
>> +	indio_dev->dev.parent = &client->dev;
>> +	indio_dev->info = &vcnl4035_info;
>> +	indio_dev->name = VCNL4035_DRV_NAME;
>> +	indio_dev->channels = vcnl4035_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(vcnl4035_channels);
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	ret = vcnl4035_init(data);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "vcnl4035 chip init failed\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = pm_runtime_set_active(&client->dev);
>> +	if (ret < 0)
>> +		goto fail_poweroff;
>> +
>> +	pm_runtime_enable(&client->dev);
>> +	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4035_SLEEP_DELAY_MS);
>> +	pm_runtime_use_autosuspend(&client->dev);
>> +
>> +	if (client->irq) {
>> +		data->drdy_trigger0 = devm_iio_trigger_alloc(
>> +			indio_dev->dev.parent,
>> +			"%s-dev%d", indio_dev->name, indio_dev->id);
>> +		if (!data->drdy_trigger0) {
>> +			ret = -ENOMEM;
>> +			goto fail_pm_disable;
>> +		}
>> +		data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
>> +		data->drdy_trigger0->ops = &vcnl4035_trigger_ops;
>> +		indio_dev->available_scan_masks = vcnl4035_available_scan_masks;
>> +		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
>> +
>> +		/* IRQ to trigger mapping */
>> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
>> +			vcnl4035_drdy_irq_handler, vcnl4035_drdy_irq_thread,
>> +			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> +			VCNL4035_IRQ_NAME, indio_dev);
>> +		if (ret < 0) {
>> +			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
>> +				client->irq);
>> +			goto fail_pm_disable;
>> +			}
>> +
>> +		ret = devm_iio_trigger_register(indio_dev->dev.parent,
>> +						data->drdy_trigger0);
>> +		if (ret) {
>> +			dev_err(&client->dev, "iio trigger register failed\n");
>> +			goto fail_pm_disable;
>> +		}
>> +
>> +		/* Trigger setup */
>> +		ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent,
>> +			indio_dev,
>> +			vcnl4035_trigger_consumer_store_time,
>> +			vcnl4035_trigger_consumer_handler,
>> +			NULL);
>> +		if (ret < 0) {
>> +			dev_err(&client->dev, "iio triggered buffer setup failed\n");
>> +			goto fail_pm_disable;
>> +		}
>> +	}
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret)
>> +		goto fail_pm_disable;
>> +	dev_info(&client->dev, "%s Ambient light/proximity sensor\n",
> 
> no need for this logging

Sure, removed it.

> 
>> +						VCNL4035_DRV_NAME);
>> +	return 0;
>> +
>> +fail_pm_disable:
>> +	pm_runtime_disable(&client->dev);
>> +	pm_runtime_set_suspended(&client->dev);
>> +	pm_runtime_put_noidle(&client->dev);
>> +fail_poweroff:
>> +	return vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_DISABLE);
> 
> I think we want to return the 'ret' value indicating the original failure,
> not the return value of vcnl4035_set_als_power_state() which is likely success

Yes, will move the power state above and will return ret here. Thanks.

> 
>> +}
>> +
>> +static int vcnl4035_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	pm_runtime_disable(&client->dev);
>> +	pm_runtime_set_suspended(&client->dev);
>> +	pm_runtime_put_noidle(&client->dev);
>> +
>> +	return vcnl4035_set_als_power_state(iio_priv(indio_dev),
>> +					VCNL4035_MODE_ALS_DISABLE);
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int vcnl4035_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_DISABLE);
>> +	regcache_mark_dirty(data->regmap);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int vcnl4035_runtime_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct vcnl4035_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	regcache_sync(data->regmap);
>> +	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
>> +	if (ret < 0)
>> +		return ret;
>> +	/* wait for 1 ALS integration cycle */
>> +	msleep(data->als_it_val * 100);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops vcnl4035_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +				pm_runtime_force_resume)
>> +	SET_RUNTIME_PM_OPS(vcnl4035_runtime_suspend,
>> +			   vcnl4035_runtime_resume, NULL)
>> +};
>> +
>> +static const struct of_device_id vcnl4035_of_match[] = {
>> +	{ .compatible = "vishay,vcnl4035", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, vcnl4035_of_match);
>> +
>> +static const struct i2c_device_id vcnl4035_id[] = {
>> +	{ "vcnl4035", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
>> +
>> +static struct i2c_driver vcnl4035_driver = {
>> +	.driver = {
>> +		.name   = VCNL4035_DRV_NAME,
>> +		.pm	= &vcnl4035_pm_ops,
>> +		.of_match_table = of_match_ptr(vcnl4035_of_match),
>> +	},
>> +	.probe  = vcnl4035_probe,
>> +	.remove	= vcnl4035_remove,
>> +	.id_table = vcnl4035_id,
>> +};
>> +
>> +module_i2c_driver(vcnl4035_driver);
>> +
>> +MODULE_AUTHOR("Parthiban Nallathambi <pn@denx.de>");
>> +MODULE_DESCRIPTION("VCNL4035 Ambient Light Sensor driver");
>> +MODULE_LICENSE("GPL v2");
>>
> 

-- 
Thanks,
Parthiban Nallathambi

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
