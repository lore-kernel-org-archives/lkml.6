Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F385ECDE37
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D9B21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D9B21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJQVOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:14:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52871 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbeJQVOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:14:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AD9A4207C4; Wed, 17 Oct 2018 15:18:39 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id E3D9520712;
        Wed, 17 Oct 2018 15:18:28 +0200 (CEST)
Date:   Wed, 17 Oct 2018 15:18:29 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>, mshettel@codeaurora.org,
        swboyd@chromium.org
Subject: Re: [PATCH v8 00/10] Add the I3C subsystem
Message-ID: <20181017151829.470930a7@bbrezillon>
In-Reply-To: <CAK8P3a2C+FHiPnHKEAanhD=RpqDG1VywTEGhpdBvvKQ8zmwdUA@mail.gmail.com>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
        <CAK8P3a2C+FHiPnHKEAanhD=RpqDG1VywTEGhpdBvvKQ8zmwdUA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 8 Oct 2018 12:47:21 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Oct 3, 2018 at 3:22 PM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > Sorry for the huge delay between v7 and v8 despite the small amount of
> > things I was asked to fix/rework.
> >
> > This patch series is adding a new subsystem to support I3C devices.
> >
> > This is just adding support for basic features. Extra features will
> > be added afterwards.
> >
> > There are a few design choices that are worth mentioning because they
> > impact the way I3C device drivers can interact with their devices:
> >
> > - all functions used to send I3C/I2C frames must be called in
> >   non-atomic context. Mainly done this way to ease implementation, but
> >   this is still open to discussion. Please let me know if you think it's
> >   worth considering an asynchronous model here
> > - the I3C bus and I3C master controller are now tightly coupled even
> >   though they're still allocated separately. There's now a 1:1
> >   relationship between these objects, and the I3C master is no longer
> >   represented under the I3C bus object.
> >   Arnd, let me know if you had something different in mind, and I'll
> >   rework the implementation accordingly.  
> 
> I looked at the entire series again and I'm rather happy with how
> it turned out. I've commented on a tiny issue about the readsl()
> that should be easy to resolve one way or another, with that
> you can add my
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> There is one additional issue that we've talked about previously
> and that I'd like to hear about from GregKH or maybe other
> subsystem maintainers: In the current version, you have a single
> 'bus_type' object, and this is used to represent both a 'host' and
> a 'device'. I think we concluded that this is done in other
> subsystems as well, and that this is fitting here because a
> host (master device) can hand over being a master to another
> device (slave), which then becomes the host and sees this
> one as a slave. Also a lot of the sysfs attributes are the same
> because of this relationship.
> 
> It also means that you get a mix of things in sysfs:
> 
> /sys/devices/i3c/<bus>
> /sys/devices/i3c/<device>
> /sys/devices/i3c/<bus>/<device>
> 
> which is a bit like what we have on USB where we can have hub
> devices that are again parents of other USB devices, but I don't
> think we can have i3c hubs or multiplexers in the same way, so
> it's only a single level.
> 
> I'm ok with this model after our previous discussion and couldn't
> come up with a better one. If anyone else still sees it as
> problematic and has a better idea, please let us know now.

I know you're quite busy with the 4.19 release, but if you find a bit
of time, that'd be great to have your feedback on this.

Thanks,

Boris
