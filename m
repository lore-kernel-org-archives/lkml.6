Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A1C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F32084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5j63Ych"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4F32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeI2SNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbeI2SNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:13:23 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7442206B8;
        Sat, 29 Sep 2018 11:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538221513;
        bh=PYEgyaINQZLvkJ411MEwh6Cskqs542aLiikcne9rNW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5j63YchuKsPrie8LDWCV+0wo8deAnxZdTlQxqV+PijsP8/sancxyP299p1AqcBxB
         b73nSnTMw3czvLwMBfuRNWgh5tEtkEgbQ3M9TcIAPWHwFrSrgn/rIiIrLyqlqxOXne
         goXoE32Ye9eE2yilGc/NB158qYx0RUwoO2vixM7I=
Date:   Sat, 29 Sep 2018 12:45:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, preid@electromag.com.au,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20180929124508.4eb5edd8@archlinux>
In-Reply-To: <20180926013353.GA6152@Eros>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20180925031724.21399-2-songqiang1304521@gmail.com>
        <20180925143054.00007fcb@huawei.com>
        <20180926013353.GA6152@Eros>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 09:33:53 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Tue, Sep 25, 2018 at 02:30:54PM +0100, Jonathan Cameron wrote:
> > On Tue, 25 Sep 2018 11:17:24 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> >   
> > > PNI RM3100 is a high resolution, large signal immunity magnetometer,
> > > composed of 3 single sensors and a processing chip with MagI2C Interface.
> > > 
> > > Following functions are available:
> > > - Single-shot measurement from
> > >   /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
> > > - Triggerd buffer measurement.
> > > - Both i2c and spi interface are supported.
> > > - Both interrupt and polling measurement is supported, depands on if
> > >   the 'interrupts' in DT is declared.
> > > 
> > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>  
> > Various minor comments inline.  Definitely heading in the right direction.
> > 
> > Good work.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> ...
> 
> > > +static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
> > > +{
> > > +	int ret;
> > > +	int tmp;
> > > +
> > > +	mutex_lock(&data->lock);
> > > +	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> > > +	mutex_unlock(&data->lock);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
> > > +	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
> > > +
> > > +	return IIO_VAL_INT_PLUS_MICRO;
> > > +}
> > > +
> > > +static int rm3100_set_cycle_count(struct rm3100_data *data, int val)
> > > +{
> > > +	int ret;
> > > +	u8 i;
> > > +
> > > +	for (i = 0; i < 3; i++) {
> > > +		ret = regmap_write(data->regmap, RM3100_REG_CC_X + 2 * i, 100);  
> > 
> > Does this write it to the same value irrespective of the value of val?
> > Seems odd.
> >   
> Hi Jonathan,
> 
> Sometimes I see these mistakes I couldn't stop laughing at my stupiness.
> Should be val, my mistake submitting without a throughout functional
> check, I think I'll write a script to prevent this from happening again.
Not to worry, we all do it :)  I had a good half day this week failing to
spot a really dumb buffer overrun (was evil as it was actually writing
a copy to memory that by coincidence was always just before where it
was being copied from so looked like a shift in the second array - hence
hours of looking in completely the wrong place).  

Sadly, for an individual developer tests always tend to be a bit adhoc
and sometimes we simply forget one!

> 
> > > +		if (ret < 0)
> > > +			return ret;
> > > +	}
> > > +	if (val == 50)  
> > 
> > Switch would be nicer.  Also why have all other values call back to
> > 2 rather than generating an error?
> >   
> I could have given it an error path, but I checked the code, 'val' in
> this function is always given by my code. I think this leads no
> possibility for val to go wrong. Do I still need an error path in this
> circumstance?

With a switch you will to make the static checkers happy.  Put
a comment in there saying it won't happen.

> 
> > > +		data->cycle_count_index = 0;
> > > +	else if (val == 100)
> > > +		data->cycle_count_index = 1;
> > > +	else
> > > +		data->cycle_count_index = 2;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int rm3100_set_samp_freq(struct rm3100_data *data, int val, int val2)
> > > +{
> > > +	struct regmap *regmap = data->regmap;
> > > +	int cycle_count;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	mutex_lock(&data->lock);  
> > 
> > Why are you taking this lock? It's not well documented what it protects
> > so it's not clear in this path why it is taken.
> > (hint add a comment to the definition of the lock to make it clear!)
> > - note I'm not saying it shouldn't be taken here, just that there is no
> > comment to justify it..
> >   
> When I was considering the lock, I read Robert Love's 'Linux Kernel
> Development', whose chapter 9 talks about how to understand the lock.
> It was talking about protecting data, but in here, my purpose is to
> protect the i2c execution consistency. I think it may be possible that
> one person is extracting the data while another person is planning set
> the frequency. Setting the frequency within queuing data will causing
> CMM(Continuous Measurement Mode) register reset, breaking the measurement
> process. That's why I added lock to callbacks where a i2c sequence can
> happen. I referred code from hmc5843, which did the similar lock stuff,
> am I understanding about lock right?

The use of lock is fine.  Just needs documenting in the driver so that
other people can follow your logic in the future!
All locks should have a clear definition of purpose and scope.

> 
> > > +	/* All cycle count registers use the same value. */
> > > +	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
> > > +	if (ret < 0)
> > > +		goto unlock_return;
> > > +
> > > +	for (i = 0; i < RM3100_SAMP_NUM; i++) {
> > > +		if (val == rm3100_samp_rates[i][0] &&
> > > +		    val2 == rm3100_samp_rates[i][1])
> > > +			break;
> > > +	}
> > > +	if (i == RM3100_SAMP_NUM) {
> > > +		ret = -EINVAL;
> > > +		goto unlock_return;
> > > +	}
> > > +
> > > +	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
> > > +	if (ret < 0)
> > > +		goto unlock_return;  
> 
> ...
> 
> > > +	if (ret < 0)
> > > +		goto done;
> > > +
> > > +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
> > > +	for (i = 0; i < 3; i++)
> > > +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);  
> > 
> > Firstly X doesn't need copying.
> > Secondly the copy of Y actually overwrites the value of Z
> > XXXYYYZZZxxx
> > XXXxYYYZZxxx
> > XXXxYYYxYZZx
> > 
> > I think...
> >   
> They are in different memories, buffer is a temporary memory for data
> reading out, data->buffer is for pushing to the userspace.

Yes. Stupid misread from me! Sorry about that.

> 
> > > +
> > > +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > > +			iio_get_time_ns(indio_dev));  
> > 
> > Align with opening bracket. 
> >   
> > > +
> > > +done:
> > > +	iio_trigger_notify_done(indio_dev->trig);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static void rm3100_remove(void *dh)
> > > +{
> > > +	struct rm3100_data *data = (struct rm3100_data *)dh;
> > > +	int ret;
> > > +
> > > +	ret = regmap_write(data->regmap, RM3100_REG_CMM, 0x00);
> > > +	if (ret < 0)
> > > +		dev_err(data->dev, "failed to stop device.\n");
> > > +}
> > > +
> > > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> > > +{
> > > +	struct iio_dev *indio_dev;
> > > +	struct rm3100_data *data;
> > > +	int tmp;
> > > +	int ret;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	data = iio_priv(indio_dev);
> > > +	data->dev = dev;
> > > +	data->regmap = regmap;
> > > +	data->buffer = devm_kzalloc(dev, RM3100_SCAN_BYTES, GFP_KERNEL);
> > > +	if (!data->buffer)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&data->lock);
> > > +
> > > +	indio_dev->dev.parent = dev;
> > > +	indio_dev->name = "rm3100";
> > > +	indio_dev->info = &rm3100_info;
> > > +	indio_dev->channels = rm3100_channels;
> > > +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +	indio_dev->available_scan_masks = rm3100_scan_masks;
> > > +
> > > +	if (!irq)
> > > +		data->use_interrupt = false;
> > > +	else {
> > > +		data->use_interrupt = true;
> > > +		ret = devm_request_irq(dev,
> > > +				       irq,
> > > +				       rm3100_irq_handler,
> > > +				       IRQF_TRIGGER_RISING,
> > > +				       indio_dev->name,
> > > +				       data);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "request irq line failed.\n");
> > > +			return ret;
> > > +		}
> > > +		init_completion(&data->measuring_done);
> > > +	}
> > > +
> > > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > +					      rm3100_trigger_handler, NULL);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	/* 3sec more wait time. */  
> > 
> > I have no idea what this comment is referring to..
> > Not seeing any waiting here...
> >   
> The thing is, measurement time of this sensor span from ~1.7ms to ~13
> seconds. I'll need a wait time for *_wait_measurement(), and I use
> measurement time + 3 seconds for waiting time. This is an initialization.
> Usage of this is in *_wait_measurement.

The wait comment is fine, but why here? It seemed to be floating on it's
own.

> 
> yours,
> Song Qiang
> 
> > > +	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	data->conversion_time =
> > > +		rm3100_samp_rates[tmp-RM3100_TMRC_OFFSET][2] + 3000;  
> > 
> > spacing around -  
> > Please check this throughout.  
> 
> ...

