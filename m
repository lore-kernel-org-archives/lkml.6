Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBBAC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C0920663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfAUKob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:44:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbfAUKob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:44:31 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C4EF2060415CA24C152;
        Mon, 21 Jan 2019 18:44:28 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 21 Jan 2019
 18:44:26 +0800
Date:   Mon, 21 Jan 2019 10:44:17 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
CC:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: add driver support for MAX44009
Message-ID: <20190121104417.00003971@huawei.com>
In-Reply-To: <20190121063508.GA21651@bobby.localdomain>
References: <20190117065623.12169-1-bobbyeshleman@gmail.com>
        <20190119185319.4b20b939@archlinux>
        <alpine.DEB.2.21.1901192006390.30192@vps.pmeerw.net>
        <20190121063508.GA21651@bobby.localdomain>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2019 22:39:14 -0800
Robert Eshleman <bobbyeshleman@gmail.com> wrote:

> On Sat, Jan 19, 2019 at 08:41:46PM +0100, Peter Meerwald-Stadler wrote:
> 
> Hey Jonathon and Peter,
> 
> First, thank you for the constructive and in-depth feedback.
> 
> I have a question below regarding a section of code that will need to
> be protected against a race condition if future features are added.

Comments inline.  I would be paranoid now and add the lock.  Less likely
that we'll accidentally forget it at some later stage!


> 
> Mostly this email is just an ack that I've started working on the
> changes.
> 
> Thanks again,
> Robert
> 
> > On Sat, 19 Jan 2019, Jonathan Cameron wrote:
> > 
> > some more comments from my side below...
> >   
> > > On Wed, 16 Jan 2019 22:56:23 -0800
> > > Robert Eshleman <bobbyeshleman@gmail.com> wrote:
> > > 
> > > Hi Robert,
> > > 
> > > Note I review drivers backwards, so comments may make more sense that
> > > way around.
> > >   
> > > > The MAX44009 is a low-power ambient light sensor from Maxim Integrated.
> > > > It differs from the MAX44000 in that it doesn't have proximity sensing and that
> > > > it requires far less current (1 micro-amp vs 5 micro-amps). The register
> > > > mapping and feature set between the two are different enough to require a new
> > > > driver for the MAX44009.
> > > > 
> > > > Developed and tested with a BeagleBone Black and UDOO Neo (i.MX6SX)
> > > > 
> > > > Supported features:
> > > > 
> > > > * Rising and falling illuminance threshold
> > > >   events  
> > > 
> > > Not really on this one.  You support using them as a trigger, which
> > > is not how threshold events should be handled in IIO. Please
> > > report them as events.   This device doesn't seem  to have
> > > a trigger that can be used in general, so you shouldn't provide
> > > one.
> > > 
> > > Userspace can use the event to decide to do a read if it wants to
> > > follow the classic move the thresholds so as to detect big
> > > 'changes' in light intensity.
> > > 
> > > Various other comments inline.  Quite a bit of style cleanup
> > > needed as well, please check the kernel docs for coding style
> > > https://www.kernel.org/doc/Documentation/process/coding-style.rst
> > > 
> > > Also take a look at other IIO drivers for the bits that are
> > > noted in there as varying across the kernel.
> > > 
> > > Whilst there is quite a bit to work on in here yet, great to see
> > > support for this new part! Looking forward to v2.
> > > 
> > > Jonathan
> > >   
> 
> After seeing your notes and looking closer at how userspace leverages
> triggers, I can see now how it does not make sense to let this device
> supply one.  It is, as you mentioned, events that are the right fit
> for this device.
> 
Great.

..
> > >   
> > > > +		dev_err(&client->dev,
> > > > +			"failed to read reg 0x%0x, err: %d\n", reg, ret);
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +err:
> > > > +	mutex_unlock(&data->lock);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int max44009_write_reg(struct max44009_data *data, char reg, char buf)
> > > > +{
> > > > +	struct i2c_client *client = data->client;
> > > > +	int ret;
> > > > +
> > > > +	mutex_lock(&data->lock);  
> > > 
> > > What is this mutex protecting?
> > >   
> > > > +	ret = i2c_smbus_write_byte_data(client, reg, buf);
> > > > +	if (ret < 0) {  
> > > 
> > > returns 0 on success.  So do
> > > if (ret) as it'll prove simpler to follow for handling later.
> > >   
> > > > +		dev_err(&client->dev,
> > > > +			"failed to write reg 0x%0x, err: %d\n",
> > > > +			reg, ret);
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +err:
> > > > +	mutex_unlock(&data->lock);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int max44009_read_int_time(struct max44009_data *data)
> > > > +{
> > > > +	int ret = max44009_read_reg(data, MAX44009_REG_CFG);
> > > > +
> > > > +	if (ret < 0) {
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return max44009_int_time_ns_array[ret & MAX44009_INT_TIME_MASK];
> > > > +}
> > > > +
> > > > +static int max44009_write_raw(struct iio_dev *indio_dev,
> > > > +			      struct iio_chan_spec const *chan, int val,
> > > > +			      int val2, long mask)
> > > > +{
> > > > +	struct max44009_data *data = iio_priv(indio_dev);
> > > > +	int ret, int_time;
> > > > +	s64 ns;
> > > > +
> > > > +	if (mask == IIO_CHAN_INFO_INT_TIME && chan->type == IIO_LIGHT) {
> > > > +		ns = val * NSEC_PER_SEC + val2;
> > > > +		int_time = find_closest_descending(
> > > > +				ns,
> > > > +				max44009_int_time_ns_array,
> > > > +				ARRAY_SIZE(max44009_int_time_ns_array));
> > > > +  
> > 
> > a mutex might make sense here to protect the read/write combo
> >   
> 
> This device supports other configuration, via MAX44009_REG_CFG, that
> is not yet supported by this driver.  If those configurations are
> supported in the future, then there will be a race condition that
> leads to a failure to update the register with both configurations
> (the most recent write will win). Currently, this is the only section
> that modifies this register with a read/update/write. Should this be
> future-proofed now (with a mutex), or deferred to when/if those
> features are supported in the future?
> 
> As an aside, my current revision of this driver removed the
> unnecessary mutex locks, which led to not needing a mutex at all.

I would add them now.  It's far too likely they'll get forgotten at some
later stage.

> 
> > > > +		ret = max44009_read_reg(data, MAX44009_REG_CFG);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +
> > > > +		ret &= ~MAX44009_INT_TIME_MASK;
> > > > +		ret |= (int_time << MAX44009_INT_TIME_SHIFT);
> > > > +		ret |= MAX44009_MANUAL_MODE_MASK;
> > > > +
> > > > +		return max44009_write_reg(data, MAX44009_REG_CFG, ret);
> > > > +	}
> > > > +	return -EINVAL;
> > > > +}

> > > > +
> > > > +static const struct iio_trigger_ops max44009_trigger_ops = {
> > > > +	.set_trigger_state = max44009_set_trigger_state,
> > > > +};
> > > > +
> > > > +static irqreturn_t max44009_trigger_handler(int irq, void *p)
> > > > +{
> > > > +	struct iio_dev *indio_dev = p;
> > > > +	struct max44009_data *data = iio_priv(indio_dev);
> > > > +	int lux, upper, lower;
> > > > +	int ret;
> > > > +	enum iio_event_direction direction;
> > > > +
> > > > +	/* 32-bit for lux and 64-bit for timestamp */
> > > > +	u32 buf[3] = {0};  
> > > 
> > > Except the timestamp needs to be 64 bit aligned so this isn't big enough.
> > > All elements in IIO buffers are 'naturally' aligned. so 32 bit is
> > > aligned to 32 bits, 64 to 64 bits.
> > >   
> > > > +
> > > > +	ret = max44009_read_reg(data, MAX44009_REG_STATUS);
> > > > +	if (ret <= 0) {
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +	ret = max44009_read_reg(data, MAX44009_REG_ENABLE);
> > > > +	if (ret <= 0) {
> > > > +		goto err;
> > > > +	}  
> > > 
> > > If these reads are necessary, then add comments on why.
> > >   
> > > > +
> > > > +	/* Clear interrupt by disabling interrupt (see datasheet) */
> > > > +	ret = max44009_write_reg(data, MAX44009_REG_ENABLE, 0);
> > > > +	if (ret < 0) {
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +	lux = max44009_read_lux_raw(data);
> > > > +	if (lux < 0) {
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +	upper = max44009_read_reg(data, MAX44009_REG_UPPER_THR);
> > > > +	if (upper < 0) {
> > > > +		goto err;
> > > > +	}
> > > > +	upper = MAX44009_THRESHOLD(upper);
> > > > +
> > > > +	lower = max44009_read_reg(data, MAX44009_REG_LOWER_THR);
> > > > +	if (lower < 0) {
> > > > +		goto err;
> > > > +	}
> > > > +	lower = MAX44009_THRESHOLD(lower);
> > > > +
> > > > +	/* If lux is NOT out-of-bounds then the interrupt was not triggered
> > > > +	 * by this device  
> > > Multiline comment syntax in IIO (and most of the kernel) is
> > > /*
> > >  * If...
> > >  */
> > > 
> > > Do we support shared interrupt lines?  Doesn't look like it, which means
> > > it 'probably was' generate by this device, but we don't know why because the value
> > > has changed.
> > > 
> > > Returning IRQ_NONE is a bad idea unless we are pretty sure it is a spurious
> > > interrupt, or we have a shared interrupt line.  It will ultimately result
> > > in your interrupt being disable by the kernel and all activity breaking.
> > > 
> > > There is also a perfectly good register to tell use if we generated the interrupt.
> > > Read that one and use that, not this racey approach.
> > >   
> 
> That is very good to know how IRQ_NONE is handled in this context.
> After revisiting this function and better understanding events,
> it became clear that this function could basically be reduced down
> to a read of the status register and a call to iio_push_event.
> 

Sounds about right.

Jonathan

