Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDDBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E0C2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="seUU0+8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfAKFcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:32:10 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:56794 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfAKFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:32:09 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C6BFB547;
        Fri, 11 Jan 2019 06:32:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547184727;
        bh=zZWhcZaFDqdCn/J3pF4ZQ+Rvq6k8QPOcP6iSqJktypA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=seUU0+8iipVNF9wvBD2ofs6QORnbDde3doduSZiMeGXws9nF6PnvAzHMbSt6fKfYk
         2Pz6M/fJrQdDF/U7xXP7T4kVJrsWcJZDb1v8HDKoZ0m1LaNI/Z5GZiR7ZSATzmldMG
         j638sq/Ad3hBy9A3ivsfsPq4YVdwo60ftatmX+c0=
Date:   Fri, 11 Jan 2019 00:31:59 -0500
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Bin Liu <b-liu@ti.com>, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com, drinkcat@chromium.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: musb: fix short isoc packets with
 inventra dma
Message-ID: <20190111053159.GA32268@localhost.localdomain>
References: <20190109071009.27625-1-paul.elder@ideasonboard.com>
 <20190109150215.GJ25910@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109150215.GJ25910@uda0271908>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Wed, Jan 09, 2019 at 09:02:15AM -0600, Bin Liu wrote:
> Hi Paul,
> 
> On Wed, Jan 09, 2019 at 02:10:09AM -0500, Paul Elder wrote:
> > Handling short packets (length < max packet size) in the Inventra DMA
> > engine in the MUSB driver causes the MUSB DMA controller to hang. An
> > example of a problem that is caused by this problem is when streaming
> > video out of a UVC gadget, only the first video frame is transferred.
> > 
> > For short packets (mode-0 or mode-1 DMA), MUSB_TXCSR_TXPKTRDY must be
> > set manually by the driver. This was previously done in musb_g_tx
> > (musb_gadget.c), but incorrectly (all csr flags were cleared, and only
> > MUSB_TXCSR_MODE and MUSB_TXCSR_TXPKTRDY were set). Fixing that problem
> > allows some requests to be transferred correctly, but multiple requests
> > were often put together in one USB packet, and caused problems if the
> > packet size was not a multiple of 4. Instead, set MUSB_TXCSR_TXPKTRDY
> > in dma_controller_irq (musbhsdma.c), just like host mode transfers.
> > 
> > This topic was originally tackled by Nicolas Boichat [0] [1] and is
> > discussed further at [2] as part of his GSoC project [3].
> > 
> > [0] https://groups.google.com/forum/?hl=en#!topic/beagleboard-gsoc/k8Azwfp75CU
> > [1] https://gitorious.org/beagleboard-usbsniffer/beagleboard-usbsniffer-kernel/commit/b0be3b6cc195ba732189b04f1d43ec843c3e54c9?p=beagleboard-usbsniffer:beagleboard-usbsniffer-kernel.git;a=patch;h=b0be3b6cc195ba732189b04f1d43ec843c3e54c9
> > [2] http://beagleboard-usbsniffer.blogspot.com/2010/07/musb-isochronous-transfers-fixed.html
> > [3] http://elinux.org/BeagleBoard/GSoC/USBSniffer
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > ---
> > Changes in v2:
> > 
> > - no more flushing FIFO
> > - greatly simplified short packet if guard in musb_g_tx, and removed
> >   unnecessary variables
> > - minor indentation and wording changes
> > 
> >  drivers/usb/musb/musb_gadget.c | 19 +++++--------------
> >  drivers/usb/musb/musbhsdma.c   | 21 +++++++++++----------
> >  2 files changed, 16 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> > index eae8b1b1b45b..496643f54faa 100644
> > --- a/drivers/usb/musb/musb_gadget.c
> > +++ b/drivers/usb/musb/musb_gadget.c
> > @@ -452,13 +452,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
> >  	}
> >  
> >  	if (request) {
> > -		u8	is_dma = 0;
> > -		bool	short_packet = false;
> >  
> >  		trace_musb_req_tx(req);
> >  
> >  		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
> > -			is_dma = 1;
> >  			csr |= MUSB_TXCSR_P_WZC_BITS;
> >  			csr &= ~(MUSB_TXCSR_DMAENAB | MUSB_TXCSR_P_UNDERRUN |
> >  				 MUSB_TXCSR_TXPKTRDY | MUSB_TXCSR_AUTOSET);
> > @@ -476,16 +473,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
> >  		 */
> >  		if ((request->zero && request->length)
> >  			&& (request->length % musb_ep->packet_sz == 0)
> > -			&& (request->actual == request->length))
> > -				short_packet = true;
> > +			&& (request->actual == request->length)) {
> >  
> > -		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb)) &&
> > -			(is_dma && (!dma->desired_mode ||
> > -				(request->actual &
> > -					(musb_ep->packet_sz - 1)))))
> > -				short_packet = true;
> > -
> > -		if (short_packet) {
> >  			/*
> >  			 * On DMA completion, FIFO may not be
> >  			 * available yet...
> > @@ -493,8 +482,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
> >  			if (csr & MUSB_TXCSR_TXPKTRDY)
> >  				return;
> >  
> > -			musb_writew(epio, MUSB_TXCSR, MUSB_TXCSR_MODE
> > -					| MUSB_TXCSR_TXPKTRDY);
> > +			musb_dbg(musb, "sending short pkt (zero=%d, length=%d, actual=%d, dma->desired_mode=%d)\n",
> > +				 request->zero, request->length, request->actual,
> > +				 dma->desired_mode);
> > +			musb_writew(epio, MUSB_TXCSR, csr | MUSB_TXCSR_TXPKTRDY);
> 
> Sorry I didn't catch this in the last review, but this change seems not
> required, isn't it? In the first version of the patch, the code is
> 'returned' in the 'if (musb_dma_inventra())' branch above, doesn't reach
> here.

Do you mean change compared to the last version of the patch, or this
last chunk of the diff?

I guess I did also remove the return when I removed the 'if
(musb_dma_inventra())' block that had the FLUSHFIFIO, but when I tested
it it still worked. In fact, I reverted this last diff chunk and it
still worked.


Paul
