Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001C0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B697E2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B697E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLDJTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:19:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48707 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbeLDJTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:19:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4CDCF207A8; Tue,  4 Dec 2018 10:19:48 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 92966207B0;
        Tue,  4 Dec 2018 10:19:37 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:19:37 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <vitor.soares@synopsys.com>, <pgaj@cadence.com>
Cc:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <peda@axentia.se>, <mshettel@codeaurora.org>,
        <swboyd@chromium.org>, <joao.pinto@synopsys.com>
Subject: Re: [PATCH] i3c: master: dw: split dw-i3c-master.c into master and
 bus specific parts
Message-ID: <20181204101937.60a3ce07@bbrezillon>
In-Reply-To: <623809f3-1d1f-a10c-783a-07b545c5955c@synopsys.com>
References: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
        <20181122210202.6af50fcc@bbrezillon>
        <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
        <20181123135004.7fd1cd58@bbrezillon>
        <83115f47-1326-cb33-a7dc-4bc8ff95befa@synopsys.com>
        <20181126133550.51469816@bbrezillon>
        <4e9c0461-02a3-80b2-c9b7-2e9ea9b38f8b@synopsys.com>
        <20181126195618.352eafb1@bbrezillon>
        <4c743a9a-d636-d34c-b7e3-913f18e6c754@synopsys.com>
        <20181126223334.08105d89@bbrezillon>
        <0912ea50-b365-d583-9d33-1dff236acbad@synopsys.com>
        <20181127133350.0361f998@bbrezillon>
        <623809f3-1d1f-a10c-783a-07b545c5955c@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 00:34:20 +0000
vitor <vitor.soares@synopsys.com> wrote:
  
> >>> What I call a slave controller would be something that lets you reply to
> >>> SDR/DDR transactions or fill a generic regmap that would be exposed to
> >>> other masters on the bus. This way we could implement generic slave
> >>> drivers in Linux (the same way we have gadget drivers). Anything else
> >>> is likely to be to specific to be exposed as a generic framework.  
> >> I would bet to do something like in i2c, we don't need the same level of
> >> complexity found in USB.  
> > Can you detail a bit more what you have in mind? I don't think we can
> > do like I2C, simply because we need to expose a valid DCR +
> > manuf-ID/PID so that other masters can bind the device to the
> > appropriate driver on their side. Plus, if we're about to expose
> > generic profiles, we likely don't want each I3C slave controller driver
> > to do that on its own.  
> 
> 
> I think this should be discuss in another thread. Do you agree?

If you want. Actually that's the most interesting part for me:
discussing how we want to support I3C slave controllers or mixed
master/slave controllers. All the driver split we're talking about
here is just bikeshedding.

> 
> 
> >>>> Taking the USB as exemple do you prefer a dwc folder on i3c root?  
> >>> Hm, not sure I like this idea either. So I see 2 options:
> >>>
> >>> 1/ put all controller drivers (both master and slave ones) in a common
> >>>      directory (drivers/i3c/controllers) as you suggest, and prefix them
> >>>      correctly (i3c-master-<ip>.c, i3c-slave-<ip>.c and i3c-dual-<ip>.c)  
> >> I agree with the controller folder but not with prefix. Please check
> >> what is already in the kernel.  
> > If we mix everything in the same subdir, I'd like to have an easy way
> > to quickly identify those that are slave controllers and those that are
> > master controllers. For the dual-role thing, maybe we can consider them
> > as master (ones with advances slave features).
> >
> > Would you be okay with drivers/i3c/controllers/{designware,dw}/..., so
> > that you can have all designware drivers (for both slave and master
> > blocks) in the same dir?  
> 
> 
> Yes, that was what I trying to tell you. For me this might be the best 
> option.

Ok.

> 
> I would like to avoid having dual role i3c driver in a master folder.

I don't see why. If the driver is simple enough to fit in one file,
there's no reason to create a new subdir. You think your DW IP is so
complex and configurable that it requires several source files, fine,
but please don't force others to do the same.

> 
> 
> > For those that are placed directly under drivers/i3c/controllers/...
> > (because they only have one .c file), I'd like to keep a standard
> > prefix.  
> 
> 
> I don't disagree, and for those that have more than one file they should 
> be in a folder, right?

Yes.

> 
> What prefix do you have in mind for those files inside a folder?

You mean, inside a sub-folder (drivers/i3c/controllers/{vendor}/)? It
depends what you do with those source files. If they are to be exposed
directly as modules, then they should be prefixed
(i3c-<role>-<vendor>.c). On the other hand, if you create a single
module out of several source files, source files don't need to be
prefixed, as long as the resulting module as a proper prefix.

> 
> 
> >> To be clear, the subsystem is nice and I working with daily. As I said
> >> this is something that I dealing now and I'm telling what I think that
> >> is not correct.
> >>  
> > Come on! All I've seen so far are complaints on tiny details, it
> > definitely doesn't prevent you from adding new features.
> >
> > Regards,
> >
> > Boris  
> 
> 
> No, it's not. But as you can see to slipt the driver in parts this 
> subject has some relevance.

I'm not saying the discussion is useless, just that it's happening way
too early compared to the other things we should work on. If you were
adding support for slaves, and were doing this split as part of this
patch series explaining that part of the code between slave and master
can be shared, then we wouldn't have this debate. But right now, you're
telling me that we need to split the DW driver to prepare for features
that have not even been discussed/proposed. That's what I'm complaining
about.
