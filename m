Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8644FECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324C4214FF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JClK3Sq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324C4214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeIYCH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeIYCH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:07:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE4320C0A;
        Mon, 24 Sep 2018 20:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537819446;
        bh=Ii299tzluJFnnJ3bh/D0Z9/U/hwg/08rK4VGYZarcNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JClK3Sq3wMC0tYtmV9YDn9RzM+e4zm8EI3PlFhHE4/0M6k5Y9ozanwdB7lVx1+u8c
         IEhzRd3iJWHE+8XfwfG5IfMe4Kn5kpTTK1ypd4ebo8W7OMF+xaBb4pSNlAB/pQ7ZE7
         b6VBr8a40eiO0D1fNSDDu8aayUicLnwcByLQWsu0=
Date:   Mon, 24 Sep 2018 21:04:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180924210403.674f87ab@archlinux>
In-Reply-To: <20180923151722.GA17711@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
        <20180922111409.597126fd@archlinux>
        <20180923151722.GA17711@Eros>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2018 23:17:22 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Sat, Sep 22, 2018 at 11:14:09AM +0100, Jonathan Cameron wrote:
> > On Thu, 20 Sep 2018 21:13:40 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> >   
> 
> ...
> 
> > > +const struct regmap_access_table rm3100_volatile_table = {
> > > +		.yes_ranges = rm3100_volatile_ranges,
> > > +		.n_yes_ranges = ARRAY_SIZE(rm3100_volatile_ranges),
> > > +};
> > > +
> > > +static irqreturn_t rm3100_measurement_irq_handler(int irq, void *d)  
> > 
> > Silly question: Does the chip have two interrupt lines?  (if so they
> > should be in the binding). If not, then this is the irq handler
> > for everything so why have the measurement in it's name?
> >   
> 
> Hi Jonathan
Hi Song.

> 
> Ah, always some other things need to care, I didn't put enough focus on
> this naming and thought it looks like ok. So I should throw these
> unnecessary information in names away!
> 
> > > +{
> > > +	struct rm3100_data *data = d;
> > > +
> > > +	complete(&data->measuring_done);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}  
> 
> ... 
> 
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	/* 3sec more wait time. */
> > > +	ret = regmap_read(data->regmap, RM_REG_TMRC, &tmp);
> > > +	data->conversion_time = rm3100_samp_rates[tmp-RM_TMRC_OFFSET][2] + 3000;
> > > +
> > > +	/* Starting all channels' conversion. */
> > > +	ret = regmap_write(regmap, RM_REG_CMM,
> > > +		RM_CMM_PMX | RM_CMM_PMY | RM_CMM_PMZ | RM_CMM_START);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return devm_iio_device_register(dev, indio_dev);  
> > Nope.  Can't do this without having a race condition.   You need
> > to ensure the userspace and in kernel interfaces are removed 'before'.
> > you do that RM_REG_CMM write in remove.
> > 
> > One option is to use devm_add_action to add a custom unwind function
> > to the automatic handling. The other is to not use devm for everything 
> > after the write above and do the device_unregister manually.
> >   
> 
> I've already handled some of those problems, and most of them are not a 
> big deal, except this one and the locking problems, about how should I 
> deal with locks properly. I'm already reading the lockdep conventions and
> some articles about it.
> Autobuilder are complaining about my locks, seems like a mess it is!

I suspect it's mostly about error paths with no unlocks in them.
At least to my eye there isn't any complex locking needed in here.

> 
> > > +}
> > > +EXPORT_SYMBOL(rm3100_common_probe);
> > > +
> > > +int rm3100_common_remove(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > +	struct rm3100_data *data = iio_priv(indio_dev);
> > > +	struct regmap *regmap = data->regmap;
> > > +
> > > +	regmap_write(regmap, RM_REG_CMM, 0x00);
> > > +
> > > +	return 0;  
> > No real point in returning int if you are always going to put 0 in
> > in it.  Should probably check the regmap_write though and output
> > a log message if it fails (as no other way of telling).
> >   
> > > +}
> > > +EXPORT_SYMBOL(rm3100_common_remove);
> > > +  
> 
> ...
> 
> > > +struct rm3100_data {
> > > +	struct device *dev;
> > > +	struct regmap *regmap;
> > > +	struct completion measuring_done;
> > > +	bool use_interrupt;
> > > +
> > > +	int conversion_time;
> > > +
> > > +	/* To protect consistency of every measurement and sampling  
> > 
> > /*
> >  * To protect
> >  */
> > (common format to most of the kernel other than those 'crazy' :)
> > people in net and a few other corners.
> >   
> 
> Actually, I've been wondering why the perl scripts didn't find this out,
> and not only this one, many other problems like too many indents, 
> parameters in open brackets are not aligned can be detected.
> I don't know perl, but this has drawn my attention. Is there any
> particular reason these problems still can not be detected? or I think
> we can work some patch out! Make reviewing code like mine easier!

Unfortunately there are enough corners of the kernel with different
formats, and legacy code that predates there being any conventions at
all, that checkpatch tends to be 'relaxed' on this stuff these days.

> 
> yours,
> Song Qiang
> 
> > > +	 * frequency change operations.
> > > +	 */
> > > +	struct mutex lock;
> > > +};
> > > +
> > > +extern const struct regmap_access_table rm3100_readable_table;
> > > +extern const struct regmap_access_table rm3100_writable_table;
> > > +extern const struct regmap_access_table rm3100_volatile_table;
> > > +
> > > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq);
> > > +int rm3100_common_remove(struct device *dev);
> > > +
> > > +#endif /* RM3100_CORE_H */  
> >   

