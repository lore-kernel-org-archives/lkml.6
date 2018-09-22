Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA56AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF192146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF192146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIVQB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:01:57 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39396 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeIVQB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:01:57 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 609EF9E7848;
        Sat, 22 Sep 2018 11:08:51 +0100 (BST)
Date:   Sat, 22 Sep 2018 11:08:50 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>, lars@metafoo.de,
        knaack.h@gmx.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180922110850.43487d23@archlinux>
In-Reply-To: <20180922104244.651c802d@archlinux>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
        <alpine.DEB.2.21.1809201522370.1482@vps.pmeerw.net>
        <20180920180511.GA18559@Eros>
        <20180922104244.651c802d@archlinux>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018 10:42:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> A few follow ups to the discussion here from me..
> 
> Note it's helpful to crop and email and no one really minds if you
> just act on their review without acknowledging it (so cut the
> bits you fully agree with out too - saves on scrolling / reading time ;)
> 
> A catch all, "Agree with everything else and will fix for v2" covers
> everything you don't want to discuss further.
> (not that I'm great at doing this either :(
> ...
> > > > diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> > > > new file mode 100644
> > > > index 000000000000..55d515e0fe67
> > > > --- /dev/null
> > > > +++ b/drivers/iio/magnetometer/rm3100-core.c
> > > > @@ -0,0 +1,399 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * PNI RM3100 9-axis geomagnetic sensor driver core.
> > > > + *
> > > > + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> > > > + *
> > > > + * User Manual available at
> > > > + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> > > > + *
> > > > + * TODO: Scale channel, event generaton, pm.    
> > > 
> > > at least read support for _SCALE is mandatory, IMHO
> > >     
> > 
> > Okay, I'll add it in next version.
> >   
> Just for the record, it's only mandatory in cases where
> it is known (you'd be amazed how often we only know the value is monotonic)
> 
> Now as you put it in the todo list, it's presumably known here
> hence Peter's comment :)
> 
> (just avoiding setting precedence)
> 
> 
> 
> ...
> > > > +static const struct regmap_range rm3100_readable_ranges[] = {
> > > > +		regmap_reg_range(RM_W_REG_START, RM_W_REG_END),
> > > > +};
> > > > +
> > > > +const struct regmap_access_table rm3100_readable_table = {    
> > > 
> > > static
> > >     
> > 
> > I was planning to let rm3100-i2c.c and rm3100-spi.c to share these 6
> > structures, because the only different configuration of regmap between
> > these two files lies in 'struct regmap_config'. To achieve this, I have
> > to expose these 3 structures to be referenced in rm3100-i2c.c and
> > rm3100-spi.c
> > Since *_common_probe() and *_common_remove() are exposed, I thought it
> > was fine to expose these structures to reduce redundant code, is this
> > prohibited?  
> Nope, but are you doing it in this patch? + you need to export the
> symbols if you are going to do that otherwise modular builds
> will fail to probe (and possibly build - I can't recall and am too
> lazy to check this morning - not enough coffee yet!)
> 
> ..
> > > > +	*val = le32_to_cpu((buffer[0] << 16) + (buffer[1] << 8) + buffer[2]);    
> > > 
> > > no need for le32_to_cpu() 
> > >     
> > 
> > I think I didn't fully understand this, I'll look into it.
> >   
> 
> To point you in the right direction here.   When you explicitly pull out
> individual bytes like you are doing here, you are getting them in a particular
> endian order.   Shifts and adding (though normally convention is | when doing
> this) are done in machine endianness, hence the *val is already in the
> endian type of your cpu.
> 
> > > > +	*val = sign_extend32(*val, 23);
> > > > +
> > > > +	return IIO_VAL_INT;
> > > > +}
> > > > +
> > > > +#define RM_CHANNEL(axis, idx)					\    
> > > 
> > > use RM3100_ prefix please
> > >     
> > 
> > In the last driver I wrote, name of registers are so long that I have to
> > suppress them as possible as I can, it seems like this one doesn't need
> > to. :)
> >   
> > > > +	{								\
> > > > +		.type = IIO_MAGN,					\
> > > > +		.modified = 1,						\
> > > > +		.channel2 = IIO_MOD_##axis,				\
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > > > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> > > > +		.scan_index = idx,					\
> > > > +		.scan_type = {						\
> > > > +			.sign = 's',					\
> > > > +			.realbits = 24,					\
> > > > +			.storagebits = 32,				\
> > > > +			.shift = 8,					\
> > > > +			.endianness = IIO_LE,				\
> > > > +		},							\
> > > > +	}
> > > > +
> > > > +static const struct iio_chan_spec rm3100_channels[] = {
> > > > +	RM_CHANNEL(X, 0),
> > > > +	RM_CHANNEL(Y, 1),
> > > > +	RM_CHANNEL(Z, 2),
> > > > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> > > > +};
> > > > +
> > > > +static const unsigned long rm3100_scan_masks[] = {GENMASK(2, 0), 0};
> > > > +
> > > > +#define RM_SAMP_NUM	14    
> > > 
> > > prefix
> > >     
> > > > +
> > > > +/* Frequency : rm3100_samp_rates[][0].rm3100_samp_rates[][1]Hz.
> > > > + * Time between reading: rm3100_sam_rates[][2]ms (The first on is actially 1.7).    
> > > 
> > > one
> > > actually
> > > 1.7 what unit?
> > >     
> > 
> > It's in milliseconds. These time values are used for lookup so I do not
> > need to compute time between conversion from measurement frequency, and
> > they are used for wait time, I thought a little longer is better.
> > I think the comment above this structure isn't very clear, I'll find a
> > better way to explain it.  
> Please also use kernel standard comment syntax
> 
> /*
>  * Frequency...
>  */
> 
> >   
> ...
> > > > +	if (i != RM_SAMP_NUM) {
> > > > +		mutex_lock(&data->lock);
> > > > +		ret = regmap_write(regmap, RM_REG_TMRC, i + RM_TMRC_OFFSET);
> > > > +		if (ret < 0)    
> > > 
> > > unlock?
> > >     
> > 
> > These actions are for changing the sampling frequency. This device
> > cannot start conversion if CMM register is not reset after reading from
> > CCX/CCY/CCZ registers. So I unlock it later since conversion should have
> > already been stopped and other threads should not access the bus.  
> Hmm.  If you are holding the lock across function calls you need
> to look at lockdep annotations. 
> 
> Also, I suspect something is wrong here as you are unlocking in
> the good path but not the bad one which seems unlikely to be 
> as intended...
> 
> >   
> > > > +			return ret;
> > > > +
> > > > +		/* Checking if cycle count registers need changing. */
> > > > +		if (val == 600 && cycle_count == 200) {
> > > > +			for (i = 0; i < 3; i++) {
> > > > +				regmap_write(regmap, RM_REG_CCXL + 2 * i, 100);
> > > > +				if (ret < 0)    
> > > 
> > > unlock?
> > >     
> > > > +					return ret;
> > > > +			}
> > > > +		} else if (val != 600 && cycle_count == 100) {
> > > > +			for (i = 0; i < 3; i++) {
> > > > +				regmap_write(regmap, RM_REG_CCXL + 2 * i, 200);
> > > > +				if (ret < 0)    
> > > 
> > > unlock?
> > >     
> > > > +					return ret;
> > > > +			}
> > > > +		}
> > > > +		/* Writing TMRC registers requires CMM reset. */
> > > > +		ret = regmap_write(regmap, RM_REG_CMM, 0);
> > > > +		if (ret < 0)    
> > > 
> > > unlock?
> > >     
> > > > +			return ret;
> > > > +		ret = regmap_write(regmap, RM_REG_CMM, RM_CMM_PMX |
> > > > +			RM_CMM_PMY | RM_CMM_PMZ | RM_CMM_START);
> > > > +		if (ret < 0)    
> > > 
> > > unlock?
> > >     
> > > > +			return ret;
> > > > +		mutex_unlock(&data->lock);
> > > > +
> > > > +		data->conversion_time = rm3100_samp_rates[i][2] + 3000;
> > > > +		return 0;
> > > > +	}
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > > +static int rm3100_read_raw(struct iio_dev *indio_dev,
> > > > +			   const struct iio_chan_spec *chan,
> > > > +			   int *val, int *val2, long mask)
> > > > +{
> > > > +	struct rm3100_data *data = iio_priv(indio_dev);
> > > > +	int ret;
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		ret = iio_device_claim_direct_mode(indio_dev);
> > > > +		if (ret < 0)    
> > > 
> > > release_direct_mode() here?
> > >     
> > 
> > Oh..yes!  
> 
> This should have stopped you reading more than once so I'm surprised
> this slipped through.  I guess the usual last minute change problem ;)
> (we all do it however much we know we should retest properly)
Ah. Just realised. Error path :)

> 
> Jonathan

