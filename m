Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C15C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A6120833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIkHV7ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A6120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeKCWVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 18:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbeKCWVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 18:21:25 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485C72082E;
        Sat,  3 Nov 2018 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541250607;
        bh=qYWeBBSNSFi8I0xiPqecoCq/ioxKgVZXmGF1ZX04tPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dIkHV7igkoVH+TnCYcmA+zfybz2i97rkmdtEOEhGtShiA/1KUfGBs74ruWByNjhLz
         wqMHfgowNlbMATlzEhniFej+uP5yzcaXJ+WJQ86sA7h/R4yK5fNICR56z4H348l+Pg
         nSjDy+uBm1dUmJ9kmhdRoC4C3/KQzRwePDGfodUU=
Date:   Sat, 3 Nov 2018 13:10:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Message-ID: <20181103131002.7956a08b@archlinux>
In-Reply-To: <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
        <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 15:20:55 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2018-11-01 at 11:43 -0300, Renato Lui Geh wrote:
> > The ad7780 driver previously did not read the correct device output, as
> > it read an outdated value set at initialization. It now updates its
> > voltage on read.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> > Changes in v3:
> > 	- removed initialization (int voltage_uv = 0)
> > 	- returns error when voltage_uv is null
> > 
> >  drivers/staging/iio/adc/ad7780.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index 91e016d534ed..f2a11e9424cd 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -87,12 +87,16 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
> >  			   long m)
> >  {
> >  	struct ad7780_state *st = iio_priv(indio_dev);
> > +	int voltage_uv;
> >  
> >  	switch (m) {
> >  	case IIO_CHAN_INFO_RAW:
> >  		return ad_sigma_delta_single_conversion(indio_dev, chan,
> > val);
> >  	case IIO_CHAN_INFO_SCALE:
> > -		*val = st->int_vref_mv * st->gain;
> > +		voltage_uv = regulator_get_voltage(st->reg);
> > +		if (!voltage_uv)  
> 
> This looks wrong.
> I admit this was done in the same way in the probe function, but that looks
> a bit wrong as well.
> 
> Typically, the return value of `regulator_get_voltage()` would get checked
> with:
> 
> ret = regulator_get_voltage(st->reg);
> if (ret < 0)
>    return ret;
> *val = ret / 1000;
> 
> So, negative values are errors and zero & positive values are valid voltage
> values.
This one is a stylistic choice for readability. I ever so slightly
prefer how Alex has it but don't care enough that I'd have commented on it ;)

However, nice to tidy up as you'll be respinning patch 3 anyway!

Thanks,

Jonathan

> 
> > +			return -EINVAL;
> > +		*val = (voltage_uv / 1000) * st->gain;
> >  		*val2 = chan->scan_type.realbits - 1;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	case IIO_CHAN_INFO_OFFSET:  

