Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED35BECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DB821525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DB821525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbeITPKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:10:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54855 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732041AbeITPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:10:05 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g2vF4-00061j-7M; Thu, 20 Sep 2018 11:27:22 +0200
Message-ID: <1537435641.4156.1.camel@pengutronix.de>
Subject: Re: [PATCH/RFC v4 1/2] reset: Add support for dedicated reset
 controls
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 Sep 2018 11:27:21 +0200
In-Reply-To: <CAMuHMdWSO6JcBRmmpwCPz0u-85ZC3ffZkNbdd8DjokJT2opAtw@mail.gmail.com>
References: <20180917163955.19023-1-geert+renesas@glider.be>
         <20180917163955.19023-2-geert+renesas@glider.be>
         <1537369098.6816.6.camel@pengutronix.de>
         <CAMuHMdWSO6JcBRmmpwCPz0u-85ZC3ffZkNbdd8DjokJT2opAtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, 2018-09-19 at 17:24 +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 19, 2018 at 4:58 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
[...]
> > I consider requesting exclusive access to a shared reset line a misuse
> > of the API. Are there such cases? Can they be fixed?
> 
> I guess there are plenty.

I did a cursory search for drivers that request exclusive reset controls
for resets that have multiple phandle references in the corresponding
DT. So far I have found none.

> Whether a line is shared or dedicated depends on SoC integration.
>
> The issue is that a driver requesting exclusive access has no way to know
> if the reset line is dedicated to its device or not. If no other
> driver requested the reset control (most drivers don't use reset
> controls), it will succeed.

True. It would be great to have a way to make sure an exclusive request
for a shared reset line never succeeds.

> > > Sometimes a driver needs to reset a specific hardware block, and be 100%
> > > sure it has no impact on other hardware blocks.  This is e.g. the case
> > > for virtualization with device pass-through, where the host wants to
> > > reset any exported device before and after exporting it for use by the
> > > guest, for isolation.
> > > 
> > > Hence a new flag for dedicated resets is added to the internal methods,
> > > with a new public reset_control_get_dedicated() method, to obtain an
> > > exclusive handle to a reset that is dedicated to one specific hardware
> > > block.
> > 
> > I'm not sure a new flag is necessary, this is what exclusive resets
> > should be.
> 
> So perhaps the check should be done for the existing exclusive resets
> instead, without adding a new flag?

That would be my preference, if possible.

> > Also I fear there will be confusion about the difference between
> > exclusive (refering to the reset control) and dedicated (refering to
> > the reset line) reset controls.
> 
> Indeed, exclusive has multiple meanings here:
>   1. Exclusive vs. shared access to the reset control,
>   2. Reset line is dedicated to a single device, or shared with multiple
>      devices.

2. is the more important factor, and that's what I have in mind when
talking about exclusive vs. shared resets. Admittedly, the kernel doc
comments only mention 1.

> If we can simplify (exclusive == dedicated, 1.shared == 2.shared), life
> can become simpler.

Well, it still has to be possible for drivers to request 1.shared
control over a dedicated reset line, just because the same driver may
work on multiple SoCs, only some of which have that reset line 2.shared.
But if we could make sure that exclusive requests are only possible for
dedicated reset lines, I'd be happier.

> > >   - I think __device_reset() should call __reset_control_get() with
> > >     dedicated=true.  However, that will impact existing users,
> > 
> > Which ones? And how?
> 
> I didn't actually check which drivers.
> If a reset is not dedicated, device_reset{,_optional}() will suddenly
> start to fail if
> a reset turns out to be not dedicated.
> Well, currently the device will be reset multiple times, so people would
> already have noticed...

Exactly. Naive exclusive control, as currently implemented, is bound to
fail if the reset line is shared. I am not aware of any cases where this
currently happens.
Of course there could always be those fragile cases where something just
works by accident and lucky timing.

[...]
> > I want to hear the device tree maintainers' opinion about this.
> > I'd very much like to have such a check for exclusive resets, but my
> > understanding is that we are not allowed to make the assumption that
> > other nodes' "reset" properties follow the common reset signal device
> > tree bindings.
> > 
> > Maybe this is something that should be checked in a device tree
> > validation step?
> 
> We already have SoCs where reset lines are shared among multiple on-chip
> devices. So dtc validation won't work, and a runtime check is needed.

Right, the dtb would have to be validated against driver code to get the
information whether a given phandle might be requested exclusively at
some point.

It would be better if this could be checked at runtime.

regards
Philipp
