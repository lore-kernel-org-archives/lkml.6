Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350E3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03962086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03962086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeKZDuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:50:03 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:54022 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKZDuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:50:02 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-80-180-nat.elisa-mobile.fi [85.76.80.180])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 49A6940073;
        Sun, 25 Nov 2018 18:58:31 +0200 (EET)
Date:   Sun, 25 Nov 2018 18:58:31 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181125165830.GC3416@darkstar.musicnaut.iki.fi>
References: <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
 <20181124200942.GS6920@n2100.armlinux.org.uk>
 <20181125010717.GJ53235@atomide.com>
 <20181125111105.GT6920@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125111105.GT6920@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 25, 2018 at 11:11:05AM +0000, Russell King - ARM Linux wrote:
> I think we're better off leaving omap-udc well alone, and if it's
> now broken with DMA, then that's unfortunate - it would require
> someone with the hardware to diagnose the problem and fix it.  I
> think trying to convert it to dmaengine would be risking way more
> problems than its worth.

Well, there's also an option to use dmaengine only for 16xx at the
beginning.

My current guess is that 15xx DMA has been broken at least since
65111084c63d ("USB: more omap_udc updates (dma and omap1710)").

There are two changes in that patch that broke it:

"use 16 bit DMA access" ==> CPC off-by-one becomes now off-by-two...?

"allow burst/pack for memory access" ==> no idea why

Below changes get traffic going with DMA & g_ether...

A.

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index fcf13ef33b31..8094a0380057 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -498,7 +498,7 @@ static u16 dma_dest_len(struct omap_ep *ep, dma_addr_t start)
 
 	end |= start & (0xffff << 16);
 	if (cpu_is_omap15xx())
-		end++;
+		end += 2;
 	if (end < start)
 		end += 0x10000;
 	return end - start;
@@ -730,10 +730,12 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 			ep->ep.name, dma_error, ep, &ep->lch);
 		if (status == 0) {
 			omap_writew(reg, UDC_TXDMA_CFG);
-			/* EMIFF or SDRC */
-			omap_set_dma_src_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
-			omap_set_dma_src_data_pack(ep->lch, 1);
+			if (!cpu_is_omap15xx()) {
+				/* EMIFF or SDRC */
+				omap_set_dma_src_burst_mode(ep->lch,
+							OMAP_DMA_DATA_BURST_4);
+				omap_set_dma_src_data_pack(ep->lch, 1);
+			}
 			/* TIPB */
 			omap_set_dma_dest_params(ep->lch,
 				OMAP_DMA_PORT_TIPB,
@@ -753,10 +755,12 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 				OMAP_DMA_AMODE_CONSTANT,
 				UDC_DATA_DMA,
 				0, 0);
-			/* EMIFF or SDRC */
-			omap_set_dma_dest_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
-			omap_set_dma_dest_data_pack(ep->lch, 1);
+			if (!cpu_is_omap15xx()) {
+				/* EMIFF or SDRC */
+				omap_set_dma_dest_burst_mode(ep->lch,
+							OMAP_DMA_DATA_BURST_4);
+				omap_set_dma_dest_data_pack(ep->lch, 1);
+			}
 		}
 	}
 	if (status)
