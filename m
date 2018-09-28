Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F322C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A61206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgdN6oFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A61206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeI2GSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbeI2GSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:18:34 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1817206B6;
        Fri, 28 Sep 2018 23:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538178746;
        bh=NNcSMbNweO7EpssOcZLVZT/m+fF9WWksGyYkkEvn98A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BgdN6oFpW3xvIgeraIGo13ygm3KLOkF1Ue6E/r75Aqubn0C9Fwutar+cMXtS/LepM
         p0U9Y6fQ7HZ9q/UG2AfX7We0d1npAWT3MDJ/IugLjd8EcknUOFZi9vD3Z8pmB6yR/w
         Pj4+uS0xe/OfJsar2ZmwTeyhcPsDCuSRybuAmM/w=
Received: by mail-qt1-f179.google.com with SMTP id z13-v6so8538014qts.5;
        Fri, 28 Sep 2018 16:52:25 -0700 (PDT)
X-Gm-Message-State: ABuFfoiVKYNdif5A7QIOOaz2LjfC+oVxMu5jok8ixes51zLYE2T2F+R1
        mL5FQtgooxCLJR3gbc9aactdmOFI71zvCYvAag==
X-Google-Smtp-Source: ACcGV6345Uffgku8+ez+1yCefTbOEYHtwnrI/ojhFSN26ST+JNlFEHjnGP/lDWshZKM+ImJSjYHTdNKv/zKYPyYtx1I=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr702816qtj.327.1538178745050;
 Fri, 28 Sep 2018 16:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180918082422.13050-2-songqiang1304521@gmail.com> <20180922160523.16b399fc@archlinux>
 <20180926224618.GA32126@bogus> <20180928093618.GA24536@Eros>
In-Reply-To: <20180928093618.GA24536@Eros>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 18:52:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
Message-ID: <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 4:36 AM Song Qiang <songqiang1304521@gmail.com> wrote:
>
> On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:
> > On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:
> > > On Tue, 18 Sep 2018 16:24:22 +0800
> > > Song Qiang <songqiang1304521@gmail.com> wrote:
> > >
> > > > The first version of this driver issues a measuring request and polling
> > > > for a status register in the device for measuring completes.
> > > > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > > > indicate that new measurement is ready. This patch adds support for
> > > > using this mechanisim to reduce cpu cost.
> > > >
> > > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> > > Hi Song.
> > >
> > > Looks correct in principal but a few things to tidy up before
> > > this is ready to apply.
> > >
> > > Also we have an unrelated change in here to check the devices ID.
> > > That should be in it's own patch.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > > > ---
> > > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-
> >
> > This should have been split with the complete binding in one patch
> > rather than piecemeal driver feature by feature.
> >
>
> Hi Rob,
>
> A few days ago when I was submitting this driver, I didn't do it very
> well, the function of this driver is limited. I added interrupt support
> the next day after you acked my first patch. I thought it's not polite
> to add something after someone acked that patch, so I send the interrupt
> support as a second patch. The first patch is merged to togreg now, but
> this doesn't. I don't know when can I add new functions to the code that
> just merged to togreg branch, could you offer some suggestions?

You just needed to state why you didn't add a ack. But really, just
don't send things except as RFC until they are "done".

What to do next depends on Jonathan and whether he wants a follow-up
patch or he will drop the first one.

> > > >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> > > >  2 files changed, 129 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > index ab9a9539fec4..40290f8dd70f 100644
> > > > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > @@ -4,9 +4,21 @@ Required properties:
> > > >   - compatible: must be "st,vl53l0x-i2c"
> >
> > Is there more than one interface on this device, such as SPI? If not,
> > then '-i2c' should be dropped.
> >
>
> Yes, there is a CCI(Camera Control Interface) for communication.

Isn't CCI just a subset of I2C? I should clarify my question is
whether there's more than 1 mutually exclusive control interface (as
many devices have control and data interfaces) where you could have 2
different drivers. A common example are devices with I2C and SPI
interfaces.

Rob
