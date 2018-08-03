Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFF4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFAC217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Faqtio/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFAC217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeHCWcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbeHCWcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:32:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A152178D;
        Fri,  3 Aug 2018 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533328490;
        bh=XCqlmmLyxDa5tnlatIxPtVGzvaIaTA+H3tDV1eJBr7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Faqtio/iQJFULqiF8Ji2kgoYytm8e/p/op1DD3VLGBJ9kwdiWkxESTxvfIEfITwjM
         /T28EjdGdplDIgZx8xVNHZXM6Jus0wuDNGf17QJTgZISsf4Ywk1QBhb8FtX9n0lPnI
         pM9WBK9lQ6NlYRY2BcbRozpV3IeYF+GTli/OamGU=
Date:   Fri, 3 Aug 2018 21:34:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Parthiban Nallathambi <pn@denx.de>, knaack.h@gmx.de,
        lars@metafoo.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com, wd@denx.de,
        sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v4 1/3] iio: Add modifier for white light
Message-ID: <20180803213443.3f82ebc8@archlinux>
In-Reply-To: <alpine.DEB.2.21.1808031323150.13492@vps.pmeerw.net>
References: <20180802182729.2061830-1-pn@denx.de>
        <alpine.DEB.2.21.1808022117460.25216@vps.pmeerw.net>
        <fb30878f-0163-306a-e933-d9fecc996acb@denx.de>
        <alpine.DEB.2.21.1808031323150.13492@vps.pmeerw.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 13:38:17 +0200 (CEST)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> Hello,
> 
> > > it is not clear to me why 'white' is needed;
> > > isn't that the default, i.e. unfiltered light?  
> > 
> > Yes, it is. But devices like vcnl4035 veml7700, White LED data one
> > register and all other sources of light (like fluorescent,
> > incandescent ,sunlight) in separate register.
> > 
> > So in such cases this WHITE modifier is needed. Should it needs to
> > come under IIO_MOD_LIGHT_CLEAR?  
This wins the aware for odd.  The sensor is drawn as only have two
sensing elements, one for Ambient light sensing and one for proximity.

A particular award should be given for using a different axis for
the white channel in which normalized output is decimal vs all the
others where it is a percentage ;)

Looking closely at those graphs I think this is actually a standard
sensor combination job.

So 'white' is what we have always called _both in that it reads
both visible and infrared. The other sensor is infrared.

Ambient is illuminance not intensity (approximate human eye response).

The only dubious bit about this is that I can see how they managed
to cancel out some of the signal around 700nm as there is nothing
much on the infrared and lots on the white.

Alternative is that they actually have a filter that really approximates
the human eye and the white channel is the sum of the other two?



> 
> it is a mess already :), there is 
> _intensity
> _intensity_ir
> _intensity_both
> _intensity_uv
> _intensity_red
> _intensity_green
> _intensity_blue
> _intensity_clear
> 
> I think that ir, uv, red, green, blue are filters for particular ranges 
> of the spectrum

That is the intent certainly.

> 
> _intensity_clear might be unfiltered and _intensity might relate to the 
> human eye photopic curve, I think the proposed white might be the same as 
> clear?
> 
> 'both' means ir + _intensity (not clearly specified)

Yup, that's the power of initial assumptions.  There was a time when
the only light sensors you tended to get were ir and both ir and visible.
Visible was obtained by taking one from the other.

One of those things we'd change if doing it again but it's a bit late
now..

Jonathan


> 
> regards, p.
> 
> > > > +KernelVersion:	4.18
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Modifier white indicates that measurements contain white LED
> > > > +		component.
> > > > +
> > > >   What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
> > > >   What:
> > > > /sys/.../iio:deviceX/in_intensity_green_integration_time
> > > >   What:
> > > > /sys/.../iio:deviceX/in_intensity_blue_integration_time
> > > > diff --git a/drivers/iio/industrialio-core.c
> > > > b/drivers/iio/industrialio-core.c
> > > > index 19bdf3d2962a..cb939b9fad16 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c
> > > > @@ -108,6 +108,7 @@ static const char * const iio_modifier_names[] = {
> > > >   	[IIO_MOD_LIGHT_GREEN] = "green",
> > > >   	[IIO_MOD_LIGHT_BLUE] = "blue",
> > > >   	[IIO_MOD_LIGHT_UV] = "uv",
> > > > +	[IIO_MOD_LIGHT_WHITE] = "white",
> > > >   	[IIO_MOD_QUATERNION] = "quaternion",
> > > >   	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> > > >   	[IIO_MOD_TEMP_OBJECT] = "object",
> > > > diff --git a/include/uapi/linux/iio/types.h
> > > > b/include/uapi/linux/iio/types.h
> > > > index 4213cdf88e3c..de87a6c7e6de 100644
> > > > --- a/include/uapi/linux/iio/types.h
> > > > +++ b/include/uapi/linux/iio/types.h
> > > > @@ -84,6 +84,7 @@ enum iio_modifier {
> > > >   	IIO_MOD_CO2,
> > > >   	IIO_MOD_VOC,
> > > >   	IIO_MOD_LIGHT_UV,
> > > > +	IIO_MOD_LIGHT_WHITE,
> > > >   };
> > > >     enum iio_event_type {
> > > > diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> > > > index b61245e1181d..a2f9c62a79dd 100644
> > > > --- a/tools/iio/iio_event_monitor.c
> > > > +++ b/tools/iio/iio_event_monitor.c
> > > > @@ -96,6 +96,7 @@ static const char * const iio_modifier_names[] = {
> > > >   	[IIO_MOD_LIGHT_GREEN] = "green",
> > > >   	[IIO_MOD_LIGHT_BLUE] = "blue",
> > > >   	[IIO_MOD_LIGHT_UV] = "uv",
> > > > +	[IIO_MOD_LIGHT_WHITE] = "white",
> > > >   	[IIO_MOD_QUATERNION] = "quaternion",
> > > >   	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> > > >   	[IIO_MOD_TEMP_OBJECT] = "object",
> > > > @@ -178,6 +179,7 @@ static bool event_is_known(struct iio_event_data
> > > > *event)
> > > >   	case IIO_MOD_LIGHT_GREEN:
> > > >   	case IIO_MOD_LIGHT_BLUE:
> > > >   	case IIO_MOD_LIGHT_UV:
> > > > +	case IIO_MOD_LIGHT_WHITE:
> > > >   	case IIO_MOD_QUATERNION:
> > > >   	case IIO_MOD_TEMP_AMBIENT:
> > > >   	case IIO_MOD_TEMP_OBJECT:
> > > >   
> > >   
> > 
> >   
> 

