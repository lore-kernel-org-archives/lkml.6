Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8218DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4709120820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4709120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407759AbeKWImj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:42:39 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:49120 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKWImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:42:38 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 22D7E300CF;
        Fri, 23 Nov 2018 00:01:15 +0200 (EET)
Date:   Fri, 23 Nov 2018 00:01:14 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, linux-omap@vger.kernel.org,
        rmk+kernel@armlinux.org.uk,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 22, 2018 at 10:31:31AM +0200, Peter Ujfalusi wrote:
> On 20/11/2018 23.04, Aaro Koskinen wrote:
> > On Tue, Nov 20, 2018 at 09:28:37AM +0200, Peter Ujfalusi wrote:
> >> On 19/11/2018 20.46, Aaro Koskinen wrote:
> >>> On Mon, Nov 19, 2018 at 12:40:40PM +0200, Peter Ujfalusi wrote:
> >>>> When the channel is configured for slave operation the LCH_TYPE needs to be
> >>>> set to LCh-P. For memcpy channels the LCH_TYPE must be set to LCh-2D.
> >>>>
> >>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>>
> >>> I don't have the documentation, but based on what omap_udc driver (still
> >>> using the legacy OMAP DMA API) does this seems to be correct.
> >>
> >> They are hard to fine, true. From the omap1710 TRM:
> >>
> >> Logical channel types (LCh types) supported are:
> >> - LCh-2D for nonsynchronized transfers (memory transfers, 1D and 2D)
> >> - LCh-P for synchronized transfers (mostly peripheral transfers)
> >> - LCh-PD similar to LCh-P but runs on a dedicated physical channel
> >> - LCh-G for graphical transfers/operations
> >> - LCh-D for display transfers
> > 
> > (I found a public document "OMAP5912 Multimedia Processor Direct
> > Memory Access (DMA) Support Reference Guide", documenting these; easy
> > to confuse with "OMAP5910 Dual-Core Processor System DMA Controller
> > Reference Guide".)
> > 
> >> Looking at other part it looks like hat LCH-2D channel mode can happily
> >> service a peripheral. LCH-P supports the same features as LCH-2D, but it
> >> lacks support for Single/Double-indexed addressing mode on the
> >> peripheral port side.
> >>
> >> So, this patch might not be needed at all. Can you test the omap_udc
> >> with s/OMAP_DMA_LCH_P/OMAP_DMA_LCH_2D
> >>
> >> If USB works, then we can just drop this patch.
> > 
> > Unfortunately omap_udc does not seem to work at all anymore with DMA on
> > my 770 setup. :-(
> > 
> > I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> > API were too annoying and flooding the console. And now that I tried
> > using DMA again with g_ether, it doesn't work anymore. The device get's
> > recognized on host side, but no traffic goes through. Switching back to
> > PIO makes it to work again.
> 
> After some tinkering I got omap_udc working with DMA (not DMAengine,
> yet) on 770 - using nfsroot. Configuring the channels to OMAP_DMA_LCH_2D
> works as expected.

Would be interesting to know how you got it working with DMA. Which
gadget driver were you using?

I bisected my issue, and got:

commit 387f869d2579e379ee343f5493dcd360be60f5c6 (refs/bisect/bad)
Author: Felipe Balbi <felipe.balbi@linux.intel.com>
Date:   Wed Mar 22 13:25:18 2017 +0200

    usb: gadget: u_ether: conditionally align transfer size

With that reverted, the DMA works OK (and I can also now confirm that
OMAP_DMA_LCH_2D works). I haven't yet checked if we actually need that
quirk in OMAP UDC, or if this is related to RMK's findings of potential
bugs in the driver. Anyway, there is clearly yet another regression.

A.
