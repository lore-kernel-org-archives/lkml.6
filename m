Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E15FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E0C20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E0C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeKYL5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 06:57:08 -0500
Received: from muru.com ([72.249.23.125]:54962 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbeKYL5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 06:57:07 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F14558087;
        Sun, 25 Nov 2018 01:07:21 +0000 (UTC)
Date:   Sat, 24 Nov 2018 17:07:17 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181125010717.GJ53235@atomide.com>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
 <20181124200942.GS6920@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124200942.GS6920@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [181124 20:10]:
> On Fri, Nov 23, 2018 at 08:52:15PM +0200, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Fri, Nov 23, 2018 at 02:35:04PM +0200, Peter Ujfalusi wrote:
> > > On 22/11/2018 17.12, Russell King - ARM Linux wrote:
> > > > I'm also not sure about this:
> > > > 
> > > >         if (cpu_is_omap15xx())
> > > >                 end++;
> > > > 
> > > > in dma_dest_len() - is that missing from the omap-dma driver?  It looks
> > > > like a work-around for some problem on OMAP15xx, but I can't make sense
> > > > about why it's in the UDC driver rather than the legacy DMA driver.
> > > 
> > > afaik no other legacy drivers were doing similar thing, this must be
> > > something which is needed for the omap_udc driver to fix up something?
> > 
> > Here's the patch that added it: https://marc.info/?l=linux-omap&m=119634396324221&w=2
> > 
> > "Make DMA-OUT behave on the 1510 ... the 1510 CPC register was just
> > off-by-one with respect to the 1611 CDAC"
> 
> ... which suggests that's a problem with the CPC register itself, and
> we should fix that in the DMAengine driver rather than the USB gadget
> driver.
> 
> Tony, any input on this?

Yeah that sounds like some hardware work-around for 15xx as described
in the DMA_DEST_LAST macro reading CSAC on 15xx instead of CDAC. Seems
like it should be done in the dmaengine driver.. My guess is that other
dma users never needed to read CSAC register?

Regards,

Tony
