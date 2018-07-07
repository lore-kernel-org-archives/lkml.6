Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F56C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3827621568
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1QH0uox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3827621568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeGGQXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753572AbeGGQXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:23:13 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 018292154D;
        Sat,  7 Jul 2018 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530980592;
        bh=BPe7tdDtIzmOwtQj4QoU/+N0X+Xb7616xXOmij60G94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1QH0uoxszOf80EhngY3kTVH+wMWeowewzFvQ3EtlGSe9ULPITymQnY86wYLhK7Sl
         B+xDGD1wqiOBhz/me4uxRa6MvZQUgDMxrk2Gi045vvU4R30fCEvVG/v9qCQSXO71/X
         qEtyBH1fFkADNJ54yZinfeD4cpzh5EoPgwp6jf0k=
Date:   Sat, 7 Jul 2018 17:23:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH 1/2] iio: light: Add support for vishay vcnl4035
Message-ID: <20180707172306.7a4a9d55@archlinux>
In-Reply-To: <03abc2a3-82dd-c2fd-bbae-adc320319428@denx.de>
References: <20180628123021.1628338-1-pn@denx.de>
        <20180629185950.00005c54@huawei.com>
        <03abc2a3-82dd-c2fd-bbae-adc320319428@denx.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 15:35:05 +0200
Parthiban Nallathambi <pn@denx.de> wrote:

> Hello Jonathan,
Hi Parthiban,

Comments inline.
...
> >> +static irqreturn_t vcnl4035_drdy_irq_handler(int irq, void *private)
> >> +{
> >> +	struct iio_dev *indio_dev = private;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	data->irq_timestamp = iio_get_time_ns(indio_dev);  
> > 
> > This all seems a bit more complex that I'd expect.
> > I would like some comments on why it is so complex..
> > 
> > Only reason I can come up with quickly is to handle shared interrupts?
> > But if that is the case you'll sometimes get the wrong timestamp here.
> > 
> > Otherwise, right now we only have one cause of interrupts and
> > might as well just set pf->timestamp directly here.
> >   
> 
> Based on Peter's comments, timestamp is ignored as the driver only
> supports ALS measurement. So I will remove this part of handling and
> will have only bottom half checking the INT flag and trigger the
> consumer, thanks.
> 
> >> +	return IRQ_WAKE_THREAD;
> >> +}
> >> +
> >> +static irqreturn_t vcnl4035_drdy_irq_thread(int irq, void *private)
> >> +{
> >> +	struct iio_dev *indio_dev = private;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	if (vcnl4035_is_triggered(data)) {
> >> +		iio_trigger_poll_chained(data->drdy_trigger0);
> >> +		return IRQ_HANDLED;
> >> +	}
> >> +
> >> +	return IRQ_NONE;
> >> +}
> >> +
> >> +/* Triggered buffer */
> >> +static irqreturn_t vcnl4035_trigger_consumer_store_time(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +
> >> +	if (!iio_trigger_using_own(indio_dev))
> >> +		pf->timestamp = iio_get_time_ns(indio_dev);
> >> +
> >> +	return IRQ_WAKE_THREAD;
> >> +}
> >> +
> >> +static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +	int als_data;
> >> +	int ret;
> >> +
> >> +	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
> >> +		pf->timestamp = data->irq_timestamp;
> >> +		data->irq_timestamp = 0;  
> > 
> > If we get here and the path was anything other than via our top half
> > handler that set this then something odd is going on.  
> 
> As mentioned above, timestamp is removed.
> 
> >   
> >> +	}
> >> +
> >> +	if (!pf->timestamp)
> >> +		pf->timestamp = iio_get_time_ns(indio_dev);  
> > 
> > Hmm. Why would we hit here when using our own trigger?  If not make this
> > a simple else and it will be less confusing.  
> 
> As mentioned above, timestamp is removed.
> 
> >   
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &als_data);
> >> +	mutex_unlock(&data->lock);
> >> +	if (!ret) {
> >> +		als_data = le16_to_cpu(als_data);  
> > As the autobuilder pointed out, use a local variable of the correct
> > endianess.  
> 
> Fixed it in v2 already. Will remove the timestamp part and use
> iio_push_to_buffers in v3, thanks.
> 

I'll look at v3 later. I'm not totally sure why supporting ALS only
means we shouldn't have a timestamp - perhaps the code will make it clear!

...
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
> >> +			mutex_lock(&data->lock);
> >> +			*val = data->als_thresh_high;
> >> +			mutex_unlock(&data->lock);
> >> +			break;
> >> +		case IIO_EV_DIR_FALLING:
> >> +			mutex_lock(&data->lock);
> >> +			*val = data->als_thresh_low;
> >> +			mutex_unlock(&data->lock);
> >> +			break;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +		break;
> >> +	case IIO_EV_INFO_PERIOD:
> >> +		mutex_lock(&data->lock);
> >> +		*val = data->als_persistence;
> >> +		mutex_unlock(&data->lock);  
> > 
> > Given mutex is taken in all paths, why not take it outside
> > the switch?  Mind you I'm not totally sure why we need to take
> > the lock at all.  We don't take it whilst setting these values.  
> 
> Lock is introduced to protect the device parameters as both integration
> time and scaling factor is proportionally calculated. This makes raw
> read and INT read sync with the new/latest updated value of device.

All we ensure here is that we don't get a transient value.  It's still
possible for the read raw or interrupt to occur on either side
of this.  I'm not seeing how the lock is preventing us getting an
incorrect state (i.e. a different one from what we are expecting)?

All of these assignments are single value that will be atomic anyway.
You'll only see one value or the other when reading - never a mixture
of the two!
> 
> I will move the locking outside the switch.
> 
> > 
...
> >> +static IIO_CONST_ATTR(als_available_integration_time, "50 100 200 400 800");
> >> +/* device ALS persistence 1 2 4 8 mapped to users 0 1 2 3 */
> >> +static IIO_CONST_ATTR(als_available_persistence, "0 1 2 3");
> >> +static IIO_CONST_ATTR(als_available_threshold_range, "0 65535");
> >> +
> >> +static struct attribute *vcnl4035_attributes[] = {
> >> +	&iio_const_attr_als_available_integration_time.dev_attr.attr,  
> > 
> > These don't comply with the abi which has available at the end not the start.  
> 
> Sorry, so this needs to be moved to begining or start of the file.
Sorry, I was unclear.  The issue is that _available is always a postfix.

So even if we accept the rest of the naming it should be
als_persistence_available etc.

Note these are non standard abi however..

> 
> >   
> >> +	&iio_const_attr_als_available_threshold_range.dev_attr.attr,  
> > 
> > I'm not even sure what these two are...
> > 
> > All new ABI or ABI that is currently specific to too narrow a range of
> > parts must be documented in /Documentation/ABI/testing/sysfs-bus-iio-*  
> 
> Threshold range: Defines the lower and upper threshold ALS value. This
> internally used by the device before triggering the interrupt i.e,
> interrupt will be triggered only of the ALS values falls below or above
> the threshold range here.

So in reality this device is generate threshold events, we are just using
them to indicate new data ready?   Please handle as explicit events
in IIO.  If you want to also use them as a trigger, then that can be
done by basically disabling the events if the trigger is enabled and
the other way around.

> 
> Persistence value: How many intergration cycle the ALS values stays
> lower or uppers then the threshold value.

This is very much an event property.  See the existing ABI defined
for those.  It might need extending, I haven't checked.

> 
> Should I need to include a new ABI to handle this case or introduce a
> driver specific sysfs entry to control theses values is fine.

It depends.  The vast majority of the time, for something fairly generic
we want to bring it into the main ABI.  That makes it useful for generic
userspace code.   Just occasionally we'll have something so far from
standard that generic code is never going to use it (often around wierd
calibration requirements) so in those cases, just a properly defined
(documented) sysfs interface is fine.

> 
> I have seen your comments about TSL2591 in the ML. So adding a new ABI
> for the time PERIOD (in different form - persistence) does not make
> sense. But this value lowers the amount of interrupt which is generated
> by the device.

This depends on whether you are intending it to be a 'data ready trigger'
in which case what you are actually controlling is the effective sampling
rate (so present it as that) or you are intending it as a threshold
interrupt control, in which case present it as a control on the generated
event, not the data capture itself.
> 
> >   
> >> +	&iio_const_attr_als_available_persistence.dev_attr.attr,
> >> +	NULL,
> >> +};
> >> +
...
