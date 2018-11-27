Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0027FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FC7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FC7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeK0Xbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:31:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39148 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeK0Xbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:31:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4876D20D29; Tue, 27 Nov 2018 13:34:03 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7696A206A1;
        Tue, 27 Nov 2018 13:33:52 +0100 (CET)
Date:   Tue, 27 Nov 2018 13:33:50 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <vitor.soares@synopsys.com>
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
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <mshettel@codeaurora.org>, <swboyd@chromium.org>,
        <joao.pinto@synopsys.com>
Subject: Re: [PATCH] i3c: master: dw: split dw-i3c-master.c into master and
 bus specific parts
Message-ID: <20181127133350.0361f998@bbrezillon>
In-Reply-To: <0912ea50-b365-d583-9d33-1dff236acbad@synopsys.com>
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
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

On Tue, 27 Nov 2018 11:50:53 +0000
vitor <vitor.soares@synopsys.com> wrote:

> Hi Boris
> 
> On 26/11/18 21:33, Boris Brezillon wrote:
> > On Mon, 26 Nov 2018 20:11:39 +0000
> > vitor <vitor.soares@synopsys.com> wrote:
> >
> > Look at the bus discovery mechanism, the notion of DCR (close to the
> > concept of USB class), or the fact that each dev has a unique
> > manufacturer+PID pair (which resemble the product/vendor ID concept)
> > that allows us to easily bind a dev to a driver without requiring a
> > static description.  
> 
> 
> The major feature close to USB is this one and it can be found in others 
> protocols (standardization process).
> 
> Just to close this topic I3C vs USB, IMO it's wrong to pass the message 
> that the I3C is closer to USB than I2C even more because I3C support the 
> I2C on the fly.

I think you didn't read my reply carefully. I'm not saying I3C == USB,
I'm just saying that the way you interact with an I3C from a SW PoV is
not at all the same as you would do for an I2C device. Do you deny that?

> 
> 
> >  
> >>
> >> I'm not sure but I think that a controller cannot change between gadget
> >> to host in USB in runtime.  
> > That's called USB OTG. Okay, to be fair, it's not exactly the same, and
> > the mastership handover in I3C is probably more complex than what we
> > have with USB OTG (I'm not a USB expert, so I might be wrong here).
> >  
> >> Even so, this kind of behavior is more likely
> >> to have in an I3C bus.  
> > Maybe.  
> 
> 
> Sorry, with the proliferation of sensors I cannot see a multi master 
> sensor network based on USB.

Looks like there's a misunderstanding here. The question is not whether
I3C will replace I2C or USB, of course it's meant to overcome the
limitations of I2C. I'm just pointing out that, if we have to expose
I3C devices, we should look at what other discoverable buses do (PCI,
USB, ...), not what I2C does.

> 
> 
> >> Sorry for that and don't take me wrong... maybe I should rise this
> >> question early but this only came up now when I started splitting and
> >> thinking where to put what is for master for slave, what is common and
> >> the thing of putting everything of controller in a folder.  
> > So you have such a dual-role controller?  
> 
> 
> Yes, we already talked about secondary master support.

There's a difference between a secondary master that waits for its time
to become the currrent master, and a secondary master that provides I3C
device features when it's acting as a slave (sensor, GPIO
controller, ...). So far we focused on supporting the former. If
there's a need for the latter, then we should start thinking about the
slave framework...

> 
> 
> > What I call a slave controller would be something that lets you reply to
> > SDR/DDR transactions or fill a generic regmap that would be exposed to
> > other masters on the bus. This way we could implement generic slave
> > drivers in Linux (the same way we have gadget drivers). Anything else
> > is likely to be to specific to be exposed as a generic framework.  
> 
> 
> I would bet to do something like in i2c, we don't need the same level of 
> complexity found in USB.

Can you detail a bit more what you have in mind? I don't think we can
do like I2C, simply because we need to expose a valid DCR +
manuf-ID/PID so that other masters can bind the device to the
appropriate driver on their side. Plus, if we're about to expose
generic profiles, we likely don't want each I3C slave controller driver
to do that on its own.

> 
> 
> >>
> >> Taking the USB as exemple do you prefer a dwc folder on i3c root?  
> > Hm, not sure I like this idea either. So I see 2 options:
> >
> > 1/ put all controller drivers (both master and slave ones) in a common
> >     directory (drivers/i3c/controllers) as you suggest, and prefix them
> >     correctly (i3c-master-<ip>.c, i3c-slave-<ip>.c and i3c-dual-<ip>.c)  
> 
> 
> I agree with the controller folder but not with prefix. Please check 
> what is already in the kernel.

If we mix everything in the same subdir, I'd like to have an easy way
to quickly identify those that are slave controllers and those that are
master controllers. For the dual-role thing, maybe we can consider them
as master (ones with advances slave features).

Would you be okay with drivers/i3c/controllers/{designware,dw}/..., so
that you can have all designware drivers (for both slave and master
blocks) in the same dir?

For those that are placed directly under drivers/i3c/controllers/...
(because they only have one .c file), I'd like to keep a standard
prefix.

> 
> 
> > 2/ place them in separate directories: drivers/i3c/{master,slave,dual}
> >
> > I'm fine either way.  
> 
> 
> In this case and taking what is already in the kernel it will be 
> drivers/i3c/{master, slave, dwc, other with the same architecture as dwc}.

And again, I'm questioning the necessity of per-IP directories at the
root level. I'm not against per-IP directories, as long as they are
classified like other HW blocks: drivers/i3c/{master,slave}/<ip>/...

> 
> 
> >>> I'm okay changing it, but I want to understand why the proposed
> >>> separation is not good.  
> >>
> >> I already tell you my use case and as I said maybe someone can advise :)
> >>  
> > I think I understand your concerns now, but only because you started to
> > mention a few things that were not clearly stated before (at least, I
> > didn't understand it this way), like the fact that your controller (and
> > probably others too) supports dual-role, or the fact that you plan to
> > expose your IP through the PCI bus.  
> 
> 
> I miss to mention PCI but since the beginning refer the slave and the 
> common part.
> 
> Splitting the driver is something that soon or later I will have to do. 
> If you prefer later I'm ok with that.
> 
> 
> I think this discussion is starting to be counterproductive with arguing 
> of both parts.

No it's not vain, it's how we do discuss things in the community. I'm
not saying I'm always right, but I need to understand the problems
you're trying to solve to take a decision, and I don't think you
initially gave all the details I needed to understand your PoV. That's
a bit clearer now, even if I still disagree on a few aspects.

> Unfortunately I don't see anyone given their inputs too.

They will come.

> 
> To be clear, the subsystem is nice and I working with daily. As I said 
> this is something that I dealing now and I'm telling what I think that 
> is not correct.
> 

Come on! All I've seen so far are complaints on tiny details, it
definitely doesn't prevent you from adding new features.

Regards,

Boris
