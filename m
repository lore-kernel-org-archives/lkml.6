Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6DCC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23242084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0JLT6A+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23242084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeI2Rin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeI2Rin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:38:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD7F02064D;
        Sat, 29 Sep 2018 11:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538219440;
        bh=le9kgxIvZA7WS6SwPIxaLfjKbBiCD7a1SLF8x+N+n7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0JLT6A+xYaIjNJUF0oeRiqJwV+vJUvB0/ddVDRYKPoNon8Qqg+KaniR8uGouBQCdr
         lBzvg7qj7MxYSPFzqxfd7gHR/dgWgM/i25j8ZjEdWfRlZx5jvLwNUY9AD3EKFqiNYB
         nfnSclrPrnCH6J3BJSgo/jqdH+trxColYvo63n0M=
Date:   Sat, 29 Sep 2018 12:10:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Song Qiang <songqiang1304521@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
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
Message-ID: <20180929121034.6c5e5826@archlinux>
In-Reply-To: <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
        <20180918082422.13050-2-songqiang1304521@gmail.com>
        <20180922160523.16b399fc@archlinux>
        <20180926224618.GA32126@bogus>
        <20180928093618.GA24536@Eros>
        <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 18:52:13 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, Sep 28, 2018 at 4:36 AM Song Qiang <songqiang1304521@gmail.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:  
> > > On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:  
> > > > On Tue, 18 Sep 2018 16:24:22 +0800
> > > > Song Qiang <songqiang1304521@gmail.com> wrote:
> > > >  
> > > > > The first version of this driver issues a measuring request and polling
> > > > > for a status register in the device for measuring completes.
> > > > > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > > > > indicate that new measurement is ready. This patch adds support for
> > > > > using this mechanisim to reduce cpu cost.
> > > > >
> > > > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>  
> > > > Hi Song.
> > > >
> > > > Looks correct in principal but a few things to tidy up before
> > > > this is ready to apply.
> > > >
> > > > Also we have an unrelated change in here to check the devices ID.
> > > > That should be in it's own patch.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan  
> > > > > ---
> > > > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-  
> > >
> > > This should have been split with the complete binding in one patch
> > > rather than piecemeal driver feature by feature.
> > >  
> >
> > Hi Rob,

Hi Rob, Song,

> >
> > A few days ago when I was submitting this driver, I didn't do it very
> > well, the function of this driver is limited. I added interrupt support
> > the next day after you acked my first patch. I thought it's not polite
> > to add something after someone acked that patch, so I send the interrupt
> > support as a second patch. The first patch is merged to togreg now, but
> > this doesn't. I don't know when can I add new functions to the code that
> > just merged to togreg branch, could you offer some suggestions?  
> 
> You just needed to state why you didn't add a ack. But really, just
> don't send things except as RFC until they are "done".

The RFC bit actually disagree on.  This driver could be considered 'done'
with just patch 1.  The driver worked, it was useful. When the early
versions of that patch came out Song had no idea how much work it would
be to add interrupt support.  As it turns out it was simple - it often isn't :(

> 
> What to do next depends on Jonathan and whether he wants a follow-up
> patch or he will drop the first one.

Yeah. I should have picked up on the binding in the second patch and merged
it.  I'd seen the first patch a few times before so was happy with it and
applied before actually looking at the second.

If they had come in separate series in my view the partial binding then
extend with 'optional' elements is fine.  The number of times I've discovered
issues with documentation of hardware that would have made any binding written
from the docs wrong is non trivial. So in my view it is always a gamble to
write bindings until you have tested they work.  I have not problem with
people who are confident and want to add them from the start though.

Obviously this only works for optional elements.

So follow up patch for 'optional' stuff is fine by me.  The only real
issue to my mind here is that they were in the same series, so we should
have seen a separate precursor patch giving the binding for all of it.

> 
> > > > >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> > > > >  2 files changed, 129 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > index ab9a9539fec4..40290f8dd70f 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > @@ -4,9 +4,21 @@ Required properties:
> > > > >   - compatible: must be "st,vl53l0x-i2c"  
> > >
> > > Is there more than one interface on this device, such as SPI? If not,
> > > then '-i2c' should be dropped.
> > >  
> >
> > Yes, there is a CCI(Camera Control Interface) for communication.  
> 
> Isn't CCI just a subset of I2C? I should clarify my question is
> whether there's more than 1 mutually exclusive control interface (as
> many devices have control and data interfaces) where you could have 2
> different drivers. A common example are devices with I2C and SPI
> interfaces.

Already fixed up when I applied the first patch.  I did more rework on
patch 1 than I'd normally do as I'd sent Song down a dead end with an
incorrect requested change so didn't want to waste more of his time
with a v7 of that patch.  This patch 2 was pretty much new so different
matter!

Thanks,

Jonathan

> 
> Rob

