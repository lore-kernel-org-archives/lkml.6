Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1749BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F81820578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeLQXrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:47:35 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:55008 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLQXrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:47:35 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-70-99-nat.elisa-mobile.fi [85.76.70.99])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 6A6FC4003E;
        Tue, 18 Dec 2018 01:47:32 +0200 (EET)
Date:   Tue, 18 Dec 2018 01:47:32 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181217234731.GC7288@darkstar.musicnaut.iki.fi>
References: <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
 <20181124200942.GS6920@n2100.armlinux.org.uk>
 <20181125010717.GJ53235@atomide.com>
 <20181125111105.GT6920@n2100.armlinux.org.uk>
 <20181125165830.GC3416@darkstar.musicnaut.iki.fi>
 <20181125171428.GL53235@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125171428.GL53235@atomide.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 25, 2018 at 09:14:28AM -0800, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [181125 16:58]:
> > Below changes get traffic going with DMA & g_ether...
> 
> Oh cool, if you have dma and g_ether working, you should
> test it with a variable size ping test loop :) That should
> expose any issues within few minutes.

The ping test is working fine. Also setting MTU higher works fine.

I was also able to reduce the needed changes further, so only the below
are now needed for 15xx DMA.

The dma_dest_len() change I can understand.

But why the BURST_4 is not working in out direction?

--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -498,7 +498,7 @@ static u16 dma_dest_len(struct omap_ep *ep, dma_addr_t start)
 
 	end |= start & (0xffff << 16);
 	if (cpu_is_omap15xx())
-		end++;
+		end += sizeof(u16);
 	if (end < start)
 		end += 0x10000;
 	return end - start;
@@ -754,8 +754,9 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 				UDC_DATA_DMA,
 				0, 0);
 			/* EMIFF or SDRC */
-			omap_set_dma_dest_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
+			if (!cpu_is_omap15xx())
+				omap_set_dma_dest_burst_mode(ep->lch,
+							OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_dest_data_pack(ep->lch, 1);
 		}
 	}

A.
