Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66922145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/JA73Hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66922145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJBBYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeJBBYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:24:00 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F1582089A;
        Mon,  1 Oct 2018 18:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538419491;
        bh=cxIPItc7WijlpuE8OxbUbJb59DitvuwOdEuJEyzORV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C/JA73HsDwhl0q6iZeWZy3WhxU3v5CPnufQz3EFFBvQMjVIwLEontn79F9eCJ5qAO
         D50wjqDYAGpr3PIuL290/L/Dy6hmHxPLPrQtxGdXIGIpHbQiecnl3r4OnI034i5tGW
         2YoPgacfU92L2eJxHtg5ZHWYU+ZpD7N8nEThTwuM=
Date:   Mon, 1 Oct 2018 19:44:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
Message-ID: <20181001194446.2b613a69@archlinux>
In-Reply-To: <20181001035739.GA17143@Eros>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
        <20180918082422.13050-2-songqiang1304521@gmail.com>
        <20180922160523.16b399fc@archlinux>
        <20180926224618.GA32126@bogus>
        <20180928093618.GA24536@Eros>
        <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
        <20181001035739.GA17143@Eros>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018 11:58:14 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Fri, Sep 28, 2018 at 06:52:13PM -0500, Rob Herring wrote:
> > On Fri, Sep 28, 2018 at 4:36 AM Song Qiang <songqiang1304521@gmail.com> wrote:  
> > >
> > > On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:  
> > > > On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:  
> > > > > On Tue, 18 Sep 2018 16:24:22 +0800
> > > > > Song Qiang <songqiang1304521@gmail.com> wrote:
> > > > >  
> > > > > > The first version of this driver issues a measuring request and polling
> > > > > > for a status register in the device for measuring completes.
> > > > > > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > > > > > indicate that new measurement is ready. This patch adds support for
> > > > > > using this mechanisim to reduce cpu cost.
> > > > > >
> > > > > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>  
> > > > > Hi Song.
> > > > >
> > > > > Looks correct in principal but a few things to tidy up before
> > > > > this is ready to apply.
> > > > >
> > > > > Also we have an unrelated change in here to check the devices ID.
> > > > > That should be in it's own patch.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Jonathan  
> > > > > > ---
> > > > > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-  
> > > >
> > > > This should have been split with the complete binding in one patch
> > > > rather than piecemeal driver feature by feature.
> > > >  
> > >
> > > Hi Rob,
> > >
> > > A few days ago when I was submitting this driver, I didn't do it very
> > > well, the function of this driver is limited. I added interrupt support
> > > the next day after you acked my first patch. I thought it's not polite
> > > to add something after someone acked that patch, so I send the interrupt
> > > support as a second patch. The first patch is merged to togreg now, but
> > > this doesn't. I don't know when can I add new functions to the code that
> > > just merged to togreg branch, could you offer some suggestions?  
> > 
> > You just needed to state why you didn't add a ack. But really, just
> > don't send things except as RFC until they are "done".
> > 
> > What to do next depends on Jonathan and whether he wants a follow-up
> > patch or he will drop the first one.
> >   
> > > > > >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> > > > > >  2 files changed, 129 insertions(+), 20 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > > index ab9a9539fec4..40290f8dd70f 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > > @@ -4,9 +4,21 @@ Required properties:
> > > > > >   - compatible: must be "st,vl53l0x-i2c"  
> > > >
> > > > Is there more than one interface on this device, such as SPI? If not,
> > > > then '-i2c' should be dropped.
> > > >  
> > >
> > > Yes, there is a CCI(Camera Control Interface) for communication.  
> > 
> > Isn't CCI just a subset of I2C? I should clarify my question is
> > whether there's more than 1 mutually exclusive control interface (as
> > many devices have control and data interfaces) where you could have 2
> > different drivers. A common example are devices with I2C and SPI
> > interfaces.
> > 
> > Rob  
> 
> Hi Rob, Jonathan,
> 
> I don't know things about CCI very well, and google also tells me little
> about it. Actually, I found it difficult to find a standard definition
> about it. Then I dug into vl53l0x's API source code, and what I can
> tell is when we use these two interfaces, the whole programming
> framework is different, even though the pysical bus of them are likely
> to be the same. 
> Source code of CCI uses a 'msm_camera_i2c_fn_t' struct and a
> 'v4l2_file_operations' as hardware interfaces for controlling device,
> while the i2c one just uses generic i2c bus interfaces.
> 
> This explanation is for why the file name still contains '-i2c'.
> 
File names are easy to change in future compared to device tree bindings
(which may be fixed for ever in an embedded platform).

So this isn't a problem at all.

Thanks,

Jonathan

> yours,
> Song Qiang

