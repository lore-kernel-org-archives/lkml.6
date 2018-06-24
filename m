Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA024C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FA324EC8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FA324EC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeFXMCc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:02:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52303 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbeFXMC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:02:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A33C520734; Sun, 24 Jun 2018 14:02:26 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D6DFF206A0;
        Sun, 24 Jun 2018 14:02:15 +0200 (CEST)
Date:   Sun, 24 Jun 2018 14:02:10 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180624140210.03416dea@bbrezillon>
In-Reply-To: <d6e37e99-d0d1-bd59-c1be-f462d3086a40@axentia.se>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-2-boris.brezillon@bootlin.com>
        <ed1add9b-ba21-d3d3-64c4-44d18af3d133@axentia.se>
        <20180623121705.1d618c5d@bbrezillon>
        <d6e37e99-d0d1-bd59-c1be-f462d3086a40@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 23:40:36 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-06-23 12:17, Boris Brezillon wrote:
> > Hi Peter,
> > 
> > On Fri, 22 Jun 2018 23:35:34 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> On 2018-06-22 12:49, Boris Brezillon wrote:  
> >>> Add core infrastructure to support I3C in Linux and document it.
> >>>
> >>> This infrastructure is not complete yet and will be extended over
> >>> time.
> >>>
> >>> There are a few design choices that are worth mentioning because they
> >>> impact the way I3C device drivers can interact with their devices:
> >>>
> >>> - all functions used to send I3C/I2C frames must be called in
> >>>   non-atomic context. Mainly done this way to ease implementation, but
> >>>   this is still open to discussion. Please let me know if you think
> >>>   it's worth considering an asynchronous model here
> >>> - the bus element is a separate object and is not implicitly described
> >>>   by the master (as done in I2C). The reason is that I want to be able
> >>>   to handle multiple master connected to the same bus and visible to
> >>>   Linux.
> >>>   In this situation, we should only have one instance of the device and
> >>>   not one per master, and sharing the bus object would be part of the
> >>>   solution to gracefully handle this case.
> >>>   I'm not sure we will ever need to deal with multiple masters
> >>>   controlling the same bus and exposed under Linux, but separating the
> >>>   bus and master concept is pretty easy, hence the decision to do it
> >>>   like that.
> >>>   The other benefit of separating the bus and master concepts is that
> >>>   master devices appear under the bus directory in sysfs.    
> >>
> >> Are bus multiplexers relevant to I3C?  
> > 
> > Not yet, but who knows.
> >   
> >> The locking needed for handling
> >> muxes for I2C is, well, convoluted...  
> > 
> > Do you remember what was the problem?
> > 
> > Anyway, I'd really like to have basic support upstreamed before we
> > start considering advanced use cases that do not exist yet. Don't get
> > me wrong, I'm not against having the multiplexer/locking discussion,
> > but it should not block inclusion of the I3C subsystem.  
> 
> I'm trying to avoid the unfortunate situation in I2C where there
> are two slightly incompatible locking schemes for muxes. There's
> probably nothing to worry about until the first I3C mux is added
> though. But since I2C devices are supposedly compatible with I3C
> that might be the case from day one?

The I²C backward compatibility is implemented in a pretty simple way, so
I don't think you'll have problems coming from the I3C part on this
(unless it needs special hooks in i2c_adapter to work properly). This
being said, if the I2C framework is already not able to properly
handle the cases you describe below, the I3C layer won't solve
that :-P. 

> 
> ---
> 
> If I read your code right, I3C client drivers will typically call
> i3c_device_do_priv_xfer (instead of i2c_transfer/i2c_smbus_xfer)
> and i3c_device_do_prov_xfer will grab the i3c_bus_normaluse_lock
> during the transfer. This seems equivalent to normal use in
> I2C with i2c_transfer/i2c_smbus_xfer.

Note that the bus lock is a read/write lock which is mostly taken in
read mode (AKA normaluse mode). The only situation where it's taken in
write mode (AKA maintenance mode) is when a bus maintenance operation is
done. In this case, we need to block all future transfers, because
maintenance operations might change dynamic device addresses, which
would make future transfers irrelevant if they were queued before the
maintenance operation is finished. 

The bus lock does not guarantee proper serialization of bus accesses.
This task is left to the controller drivers, since this is what they
tend to optimize (by queuing transfers at the HW level).

> 
> When muxes are thrown into the mix, you find yourself needing to
> do more than the "real" transfer with some lock held. In I2C there
> is an unlocked __i2c_transfer, and locking/unlocking is exposed.
> Muxes typically grab the lock, set the mux in the appropriate
> position, do an unlocked __i2c_transfer, optionally sets the mux
> in some default position and then lets go of the lock. See e.g.
> i2c/muxes/i2c-mux-pca954x.c
> 
> However, that is the simple case. There are also muxes that are
> controlled with GPIO pins, and that gets hairy if the GPIO pins
> are controlled from the same I2C bus that is muxed. The GPIO
> driver would have to know that some GPIO pins need to use unlocked
> I2C transfers for that to work with the above locking scheme. And
> no GPIO driver does not want to know about that at all. I.e. you
> have two fundamentally different requirement depending on if the
> GPIO pins controlling the mux are controlled using the muxed bus
> or if the pins are controlled in some completely unrelated way.
> The latter case is probably the normal case, with the GPIO mux
> controlled directly from some SoC pins. In the latter case you
> also want to prevent any transfer on the bus while the GPIO pins
> for the mux are changing, i.e. the total opposite of the former
> case. It gets really really hairy if you have multiple levels
> of muxes...
> 
> There are a some old drivers (e.g. i2c/busses/i2c-amd756-s4882.c)
> that handles this by simply bypassing the GPIO subsystem, but
> that is not really an option if some pins are used to mux the
> I2C bus while some pins are used for other things.

I see.

> 
> I don't know if this affects I3C before muxes are added, but I
> suspect muxes will happen sooner rather than later, since the
> spec mentions that the bus only support 11 devices maximum. 11
> don't seem like a lot, and it seems likely that there will be
> a need to have more devices somehow...

I can't tell, and that's the whole problem here. How can you design a
solution for something that does not exist yet? Fixing the I2C muxing
logic, if it needs to be, is something I can understand. But how can you
envision what I3C muxes (if they ever exist) will look like?

> 
> But just maybe, in order to not run into the above situation, it
> needs to be handled right from the start with preparatory and
> cleanup stages of each transfers, or something?

How about applying this approach to I2C first and see how it flies.
Changing the I3C framework afterwards (when I3C muxes come in)
shouldn't be that complicated.
