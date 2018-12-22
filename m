Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE75C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD9E2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545501805;
	bh=QTU7DbAMAk+C7LilXz27oiXjcUUysO0UUf2o21ePPXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Om2Dxml84gmOj+HwgBaKlahMHdIJwJI5/2OR9wASE7S5rLY56bcLP6++xxQkQNghq
	 Ea2VuKmHtu5mMigbT/1DP0dFVmmXLUKOe25BarwTr3dZAcOdY+vmnJMi/pWQYQvpnB
	 GlvUFGVQrjHfRRH+Pcc2ll1cIWtAeiHy2P7NTPSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390527AbeLVSDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387990AbeLVSDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:03:24 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C67420874;
        Sat, 22 Dec 2018 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545501802;
        bh=QTU7DbAMAk+C7LilXz27oiXjcUUysO0UUf2o21ePPXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LRbpFtncNfbFHbQ1nOC5H0bbu4RBMRcKuohxlsi3qYTbRLSOCY0EdHIgJokyiKppR
         W0D+Cz0o2zrgPzUm6RnYPhvrm/DYmRmJzXEfYMjzTrmpdHFguMPqKgN9wloUs+KtbV
         g1nDmwPy3NzYsyEkgKYnAmApG/985cofr3bgWook=
Date:   Sat, 22 Dec 2018 18:03:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] staging: iio: adt7316: fix dac_bits assignment
Message-ID: <20181222180310.4ad9a1c6@archlinux>
In-Reply-To: <20181217213059.GA11856@r2700x.localdomain>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-4-jeremyfertic@gmail.com>
        <20181216113756.70d76d0a@archlinux>
        <20181217213059.GA11856@r2700x.localdomain>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 14:30:59 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> On Sun, Dec 16, 2018 at 11:37:56AM +0000, Jonathan Cameron wrote:
> > On Tue, 11 Dec 2018 17:54:55 -0700
> > Jeremy Fertic <jeremyfertic@gmail.com> wrote:
> >   
> > > The only assignment to dac_bits is in adt7316_store_da_high_resolution().
> > > This function enables or disables 10 bit dac resolution for the adt7316/7
> > > and adt7516/7 when they're set to output voltage proportional to
> > > temperature. Remove these assignments since they're unnecessary for the
> > > dac high resolution functionality.
> > > 
> > > Instead, assign a value to dac_bits in adt7316_probe() since the number
> > > of dac bits might be needed as soon as the device is registered and
> > > available to userspace.
> > > 
> > > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>  
> > 
> > I'm a little confused as it seems to me that in the orignal code
> > if we were setting high resolution 'off' we would fall back to 8
> > bits for either type of device.  Now you just have a check on the
> > device type?
> > 
> > The result will be that we read more bytes than we want to
> > in show_DAC.
> > 
> > I'd need a pretty strong argument to persuade me it is worth
> > supporting the 8 bit mode at all btw on devices that will go
> > higher.  It adds interface complexity and the number of usecases
> > where the saving in bus traffic is worthwhile are probably fairly
> > few!
> > 
> > Jonathan  
> 
> Thanks for the feedback Jonathan, and sorry for the confusion on this one.
> My commit message should have been clearer. This is not a general purpose
> option to change the dac resolution. It is specific to an optional feature
> where one or two of the four dacs can be set to output voltage proportional
> to temperature. If the user chooses to set dac a and/or dac b to ouput
> voltage proportional to temperature, this da_high_resolution attribute can
> optionally be enabled to use 10 bit resolution rather than the default 8
> bits. It is only available on the 10 and 12 bit dac devices. If the user
> attempts to read or write dacs a or b under these settings, the driver's
> current behaviour is to return an error. The dacs c and d continue to
> operate normally under these conditions.
> 
> With the above in mind, dac_bits should have never been assigned to in this
> da_high_resolution attribute. Before this patch, if the user didn't write
> to this optional attribute, dac_bits would be 0 since it was never assigned
> to anywhere else. This would result in incorrect calculations in show_DAC
> and store_DAC.
> 
Good explanation.  Send me a v2 with that in the description.

Thanks,

Jonathan

> Jeremy
> 
> > > ---
> > >  drivers/staging/iio/addac/adt7316.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > > index e5e1f9d6357f..a9990e7f2a4d 100644
> > > --- a/drivers/staging/iio/addac/adt7316.c
> > > +++ b/drivers/staging/iio/addac/adt7316.c
> > > @@ -651,17 +651,10 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
> > >  	u8 config3;
> > >  	int ret;
> > >  
> > > -	chip->dac_bits = 8;
> > > -
> > > -	if (buf[0] == '1') {
> > > +	if (buf[0] == '1')
> > >  		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
> > > -		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> > > -			chip->dac_bits = 12;
> > > -		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> > > -			chip->dac_bits = 10;
> > > -	} else {
> > > +	else
> > >  		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
> > > -	}
> > >  
> > >  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> > >  	if (ret)
> > > @@ -2123,6 +2116,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> > >  	else
> > >  		return -ENODEV;
> > >  
> > > +	if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> > > +		chip->dac_bits = 12;
> > > +	else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> > > +		chip->dac_bits = 10;
> > > +	else
> > > +		chip->dac_bits = 8;
> > > +
> > >  	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac", GPIOD_OUT_LOW);
> > >  	if (IS_ERR(chip->ldac_pin)) {
> > >  		ret = PTR_ERR(chip->ldac_pin);  
> >   

