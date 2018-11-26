Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB901C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFBA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFBA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeK0I3T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:29:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43355 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbeK0I3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:29:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C2E56207AD; Mon, 26 Nov 2018 22:33:48 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1D2FC20736;
        Mon, 26 Nov 2018 22:33:38 +0100 (CET)
Date:   Mon, 26 Nov 2018 22:33:34 +0100
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
Message-ID: <20181126223334.08105d89@bbrezillon>
In-Reply-To: <4c743a9a-d636-d34c-b7e3-913f18e6c754@synopsys.com>
References: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
        <20181122210202.6af50fcc@bbrezillon>
        <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
        <20181123135004.7fd1cd58@bbrezillon>
        <83115f47-1326-cb33-a7dc-4bc8ff95befa@synopsys.com>
        <20181126133550.51469816@bbrezillon>
        <4e9c0461-02a3-80b2-c9b7-2e9ea9b38f8b@synopsys.com>
        <20181126195618.352eafb1@bbrezillon>
        <4c743a9a-d636-d34c-b7e3-913f18e6c754@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 20:11:39 +0000
vitor <vitor.soares@synopsys.com> wrote:

> >>> I prefer that we keep the driver as is until we actually need to split
> >>> things up.  
> >> This is already done and will benefit everyone:
> >>
> >>       - for me is better do it now than the secondary master and slave
> >> development.  
> > Sorry, I don't get that one.  
> 
> 
> I already share my plan with you. See the structure above.

My point is, I don't get the relationship between your patch and
secondary-master/slave-mode support.

> >>>> This topic rise another one related with the master folder. I understand
> >>>> that now the subsystem doesn't have slave support but the name is
> >>>> limited. Isn't better to have something like controller or busses? What
> >>>> do you have in mind for the slave?  
> >>> drivers/i3c/slave/... for slave drivers and drivers/i3c/slave.c for the
> >>> framework, just like we have drivers/i3c/master/ for master controller
> >>> drivers and drivers/i3c/master.c.  
> >> I have to disagree here. I don't see any place on the kernel with
> >> .../master/ and ../slave/ folders and it is very likely that both rules
> >> will have some common code.  
> > I see at least one that uses this model: the USB framework
> > (drivers/usb/gadget/ for device controllers and drivers/usb/host/ for
> > host controllers). Given that I3C is closer to USB than I2C I initially
> > decided to keep this separation. Maybe I'm wrong, but I'd like to
> > understand why you think it's not appropriate.  
> 
> 
> You can say there some features from USB in I3C but cannot compare USB 
> vs I3C since they are in different championships.

I maintain that functionally, I3C is closer to USB than I2C. That does
not mean that it's competing with USB performance-wise, it just means
that the SW stack is likely to resemble the USB one (probably a bit
simpler, at least at the beginning). 

> 
> The aim of I3C is to fill the gaps discovery on I2C over the years but 
> still keeping its simplicity not to go to the complexity of USB.

Look at the bus discovery mechanism, the notion of DCR (close to the
concept of USB class), or the fact that each dev has a unique
manufacturer+PID pair (which resemble the product/vendor ID concept)
that allows us to easily bind a dev to a driver without requiring a
static description.

> 
> 
> I'm not sure but I think that a controller cannot change between gadget 
> to host in USB in runtime.

That's called USB OTG. Okay, to be fair, it's not exactly the same, and
the mastership handover in I3C is probably more complex than what we
have with USB OTG (I'm not a USB expert, so I might be wrong here).

> Even so, this kind of behavior is more likely 
> to have in an I3C bus.

Maybe.

> 
> 
> >  
> >> With this structure the user will have the code spread in /master and
> >> /slave folders...  
> > Not sure who you call "user" here, but yes, master controller and slave
> > controller drivers would be placed in different dirs.
> >  
> >>
> >> I would like you consider to change the folder name and the names rules
> >> to something like in i2c.  
> > Why? And more importantly, why is this coming up now? You've been
> > reviewing the framework since the beginning, and never complained about
> > the subdirs/files organization so far.  
> 
> 
> Sorry for that and don't take me wrong... maybe I should rise this 
> question early but this only came up now when I started splitting and 
> thinking where to put what is for master for slave, what is common and 
> the thing of putting everything of controller in a folder.

So you have such a dual-role controller? I mean, Cadence IP has a dummy
GPIO mode in its Master IP when is operating in slave mode (secondary
master, or main master after it's released the bus), but I'm not sure
this was designed for anything else but testing.

What I call a slave controller would be something that lets you reply to
SDR/DDR transactions or fill a generic regmap that would be exposed to
other masters on the bus. This way we could implement generic slave
drivers in Linux (the same way we have gadget drivers). Anything else
is likely to be to specific to be exposed as a generic framework.

> 
> 
> Taking the USB as exemple do you prefer a dwc folder on i3c root?

Hm, not sure I like this idea either. So I see 2 options:

1/ put all controller drivers (both master and slave ones) in a common
   directory (drivers/i3c/controllers) as you suggest, and prefix them
   correctly (i3c-master-<ip>.c, i3c-slave-<ip>.c and i3c-dual-<ip>.c)
2/ place them in separate directories: drivers/i3c/{master,slave,dual}

I'm fine either way.

> 
> 
> >
> > I'm okay changing it, but I want to understand why the proposed
> > separation is not good.  
> 
> 
> I already tell you my use case and as I said maybe someone can advise :)
> 

I think I understand your concerns now, but only because you started to
mention a few things that were not clearly stated before (at least, I
didn't understand it this way), like the fact that your controller (and
probably others too) supports dual-role, or the fact that you plan to
expose your IP through the PCI bus.
