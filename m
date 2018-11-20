Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E3C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6755D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6755D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeKUHfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:35:15 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:39900 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeKUHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:35:15 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-71-135-nat.elisa-mobile.fi [85.76.71.135])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id E3D5930060;
        Tue, 20 Nov 2018 23:04:06 +0200 (EET)
Date:   Tue, 20 Nov 2018 23:04:06 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, linux-omap@vger.kernel.org,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 09:28:37AM +0200, Peter Ujfalusi wrote:
> On 19/11/2018 20.46, Aaro Koskinen wrote:
> > On Mon, Nov 19, 2018 at 12:40:40PM +0200, Peter Ujfalusi wrote:
> >> When the channel is configured for slave operation the LCH_TYPE needs to be
> >> set to LCh-P. For memcpy channels the LCH_TYPE must be set to LCh-2D.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > I don't have the documentation, but based on what omap_udc driver (still
> > using the legacy OMAP DMA API) does this seems to be correct.
> 
> They are hard to fine, true. From the omap1710 TRM:
> 
> Logical channel types (LCh types) supported are:
> - LCh-2D for nonsynchronized transfers (memory transfers, 1D and 2D)
> - LCh-P for synchronized transfers (mostly peripheral transfers)
> - LCh-PD similar to LCh-P but runs on a dedicated physical channel
> - LCh-G for graphical transfers/operations
> - LCh-D for display transfers

(I found a public document "OMAP5912 Multimedia Processor Direct
Memory Access (DMA) Support Reference Guide", documenting these; easy
to confuse with "OMAP5910 Dual-Core Processor System DMA Controller
Reference Guide".)

> Looking at other part it looks like hat LCH-2D channel mode can happily
> service a peripheral. LCH-P supports the same features as LCH-2D, but it
> lacks support for Single/Double-indexed addressing mode on the
> peripheral port side.
> 
> So, this patch might not be needed at all. Can you test the omap_udc
> with s/OMAP_DMA_LCH_P/OMAP_DMA_LCH_2D
> 
> If USB works, then we can just drop this patch.

Unfortunately omap_udc does not seem to work at all anymore with DMA on
my 770 setup. :-(

I had switched to PIO mode in 2015 since the WARNs about legacy DMA
API were too annoying and flooding the console. And now that I tried
using DMA again with g_ether, it doesn't work anymore. The device get's
recognized on host side, but no traffic goes through. Switching back to
PIO makes it to work again.

A.
