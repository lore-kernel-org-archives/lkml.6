Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D265C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020082084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPuOojDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020082084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeI2SFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbeI2SFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:05:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5EF206B8;
        Sat, 29 Sep 2018 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538221062;
        bh=XFhPAzbBQxdU3L8+HUhfCAhaniTdPUbJrpmk+89kzVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sPuOojDfbgEtQUsjtI9z+iO1v3vR+F558YQ+4KTmS5uSMK/QXMKkA5cXu9yV+s6Hr
         wySwnWfQB9LEMxqNYz6ofk1QK4+r1eX+KrMUDJmGxZp6kwtr93NQV9kLQfSGpoQMnF
         RsolveOR3Tyii7Ko5XjmYYjCwbI6x3Ck/HT+3YPs=
Date:   Sat, 29 Sep 2018 12:37:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Phil Reid <preid@electromag.com.au>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20180929123737.03b0b1a0@archlinux>
In-Reply-To: <20180926080752.GA12183@Eros>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20180925031724.21399-2-songqiang1304521@gmail.com>
        <20180925143054.00007fcb@huawei.com>
        <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
        <20180926014951.GA7094@Eros>
        <4de691f2-dbc9-6124-efa6-66f2dd7e0f2b@electromag.com.au>
        <20180926080752.GA12183@Eros>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 16:09:45 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Wed, Sep 26, 2018 at 10:30:34AM +0800, Phil Reid wrote:
> > On 26/09/2018 9:49 AM, Song Qiang wrote:  
> > > On Tue, Sep 25, 2018 at 10:36:54PM +0800, Phil Reid wrote:  
> > > > On 25/09/2018 9:30 PM, Jonathan Cameron wrote:  
> > > > > > +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> > > > > > +{
> > > > > > +	struct iio_poll_func *pf = p;
> > > > > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > > > > +	struct rm3100_data *data = iio_priv(indio_dev);
> > > > > > +	struct regmap *regmap = data->regmap;
> > > > > > +	u8 buffer[9];
> > > > > > +	int ret;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	mutex_lock(&data->lock);
> > > > > > +	ret = rm3100_wait_measurement(data);
> > > > > > +	if (ret < 0) {
> > > > > > +		mutex_unlock(&data->lock);
> > > > > > +		goto done;
> > > > > > +	}
> > > > > > +
> > > > > > +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, sizeof(buffer));
> > > > > > +	mutex_unlock(&data->lock);
> > > > > > +	if (ret < 0)
> > > > > > +		goto done;
> > > > > > +
> > > > > > +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
> > > > > > +	for (i = 0; i < 3; i++)
> > > > > > +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);  
> > > > > Firstly X doesn't need copying.
> > > > > Secondly the copy of Y actually overwrites the value of Z
> > > > > XXXYYYZZZxxx
> > > > > XXXxYYYZZxxx
> > > > > XXXxYYYxYZZx
> > > > > 
> > > > > I think...
> > > > >   
> > > > > > +
> > > > > > +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > > > > > +			iio_get_time_ns(indio_dev));  
> > > > 
> > > > memcpy target is a different buffer so should be ok.
> > > > 
> > > > But that raises the question of does it need to be?
> > > > 'buffer' could be 12 bytes long and just shuffle Z then Y.
> > > > Do the unused bytes need to be zeroed? or does libiio mask them anyway?
> > > > 
> > > > 
> > > > 
> > > > -- 
> > > > Regards
> > > > Phil Reid  
> > > 
> > > Hi Phil,
> > > 
> > > This is interesting, last patch I submitted uses three transactions and
> > > shuffles X, Y and Z respectively. You said it should be better to use one
> > > transactions, I thought it makes point, and one transaction may reduce
> > > IO pressure of the i2c bus. :)
> > > And that's not necessary for unused bytes to be zero. I'm not familiar
> > > with libiio, actually just been studying it, can't say anything about
> > > it.
> > > 
> > > yours,
> > > Song Qiang
> > > 
> > >   
> > G'day Song,
> > 
> > yes the one transaction suggestion was to reduce pressure on the bus.
> > I think also with 3 calls you can up up with other devices taking over
> > the i2c / spi bus in between.
> > 
> > We've got a devkit for this part, but haven't got to wiring it up to our system as yet.
> > We're looking at using the i2c interface which could push things at max samplerate, so yes I'm
> > keen to see bus pressure reduced as much as possible.
> > 
> > I was thinking something like the following:
> > 
> > u8 buffer[12];
> > regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, 9);
> > 
> > buffer[10] = buffer[8]; // or memcpy or some other fancy shuffle code.
> > buffer[9]  = buffer[7];
> > buffer[8]  = buffer[6];
> > 
> > buffer[6]  = buffer[5];
> > buffer[5]  = buffer[4];
> > buffer[4]  = buffer[3];
> > 
> > iio_push_to_buffers_with_timestamp(indio_dev, buffer, iio_get_time_ns(indio_dev));
> > 
> > but I'm unsure if this would be needed:
> > buffer[7] = 0
> > buffer[3] = 0
> > 
> > What you've got does the job I think.
> > 
> > I haven't dug into the datasheet in great detail, and my iio knownledge is limited.
> > Are you sure the RM3100_CHANNEL scantype endianness is IIO_LE.
> > rm3100_read_mag looks to be doing big endian conversion and the datasheet agrees with that.
> > 
> > 
> > -- 
> > Regards
> > Phil Reid
> >   
> 
> Hi Phil,
> 
> You're absolutely right!
> This should be big endian, I think I probably just want something there
> when I was writing this code, planned to change it later, but apparently
> I've forgotten it...
> 
> AFAIK, filling places we do not need with 0 is not needed, we just
> extract valid data from valid bit field(24 here).
Indeed it isn't.  We need to be careful not to leak any data (for
kernel security reasons), but it's fine if it just has some other
data from the sensor in it.
> 
> Both one transaction and three transactions way have their point, but
> this is a OS, probably the spiltted one is better, I need some real
> thinking about this...
> 
> I could have use the same buffer to read from the sensor and send it to
> userspace like this:
> 
> int i = 0;
> ret = regmap_bulk_read(regmap, RM3100_REG_MX2, 9);
> if(ret)
> 	...
> /* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. */
> for (i = 0; i < 2; i++)
> 	memcpy(buffer + (2 - i) * 4, buffer + (2 - i) * 3), 3);
> 
> This code snippet will use the same buffer, actually that's what I was
> using the first time. Jonathan must thinks so, from what he commented,
> he assumed I was using the same buffer, also what you want.

Gah. Good point!  Two things called buffer and I failed to notice they
were different. :(

> But I changed this due to Peter's comment, maybe not a big deal, he
> suggests to use sizeof(buffer), this makes me use an additional size 9
> buffer. I thought this doesn't matter too much, just some additional
> space from the stack, but now I think maybe less memory using would be
> better...
> After all, this length 9 seems like never shouldn't be changed...

Agreed. Here in place is simple, avoids memory usage and also one of the
copies.

Jonathan

> 
> yours,
> Song Qiang
> 

