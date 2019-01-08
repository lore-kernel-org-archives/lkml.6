Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15787C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84262087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gGoBdg86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfAHQMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:12:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52508 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAHQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:12:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x08GBwTI079295;
        Tue, 8 Jan 2019 10:11:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546963918;
        bh=rKQnSW7ZzrZTTxzuXMWIGAb7uYwEBw1CAcCAW6NsKgw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gGoBdg86VZUQgZwKguc6+vpmXZYIgeqAAsUtzoKKj9uX8uiwu2JkMi2NpdyzCtvjU
         /NEBVZR3urjLJv98ar5YfupRYsQKrPnzjSgWnUPuw2IehjBEvoiJLozPeECvJxmHC+
         b/w9owmYxAaFUEJ+Omg8t5O2S81L9WC3kLgpeaTE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x08GBwXS103842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 10:11:58 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 8
 Jan 2019 10:11:58 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 8 Jan 2019 10:11:57 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x08GBwhC011146;
        Tue, 8 Jan 2019 10:11:58 -0600
Date:   Tue, 8 Jan 2019 10:11:58 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
CC:     <laurent.pinchart@ideasonboard.com>,
        <kieran.bingham@ideasonboard.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
Subject: Re: [PATCH] usb: gadget: musb: fix short isoc packets with inventra
 dma for pandaboard es
Message-ID: <20190108161158.GH25910@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        Nicolas Boichat <drinkcat@chromium.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org
References: <20181009063220.13745-1-paul.elder@ideasonboard.com>
 <20190107191137.GA25910@uda0271908>
 <20190108044524.GA31873@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190108044524.GA31873@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:45:24PM -0500, Paul Elder wrote:
> Hi Bin,
> 
> On Mon, Jan 07, 2019 at 01:11:57PM -0600, Bin Liu wrote:
> > Hi Paul,
> > 
> > Sorry for the delay on reviewing it.
> 
> Thanks for the review.
> 
> > For the subject, can you please use
> > 
> > 	usb: musb: gadget: fix short isoc packets with inventra dma
> 
> ack
> 
> > On Tue, Oct 09, 2018 at 02:32:20AM -0400, Paul Elder wrote:
> > > Handling short packets (length < max packet size) in the Inventra DMA
> > > engine in the MUSB driver causes the MUSB DMA controller to hang. An
> > > example of a problem that is caused by this problem is when streaming
> > > video out of a UVC gadget, only the first video frame is transferred.
> > > 
> > > For short packets (mode-0 or mode-1 DMA), MUSB_TXCSR_TXPKTRDY must be
> > > set manually by the driver. This was previously done in musb_g_tx
> > > (musb_gadget.c), but incorrectly (all csr flags were cleared, and only
> > > MUSB_TXCSR_MODE and MUSB_TXCSR_TXPKTRDY). Fixing that problem allows
> > > some requests to be transferred correctly, but multiple requests were
> > > often put together in one USB packet, and caused problems if the packet
> > > size was not a multiple of 4.
> > > 
> > > Instead, MUSB_TXCSR_TXPKTRDY is set in dma_controller_irq (musbhsdma.c),
> > > just like host mode transfers, then musb_g_tx forces the packet to be
> > > flushed, by setting MUSB_TXCSR_FLUSHFIFO.

This should be reworded, since we don't set MUSB_TXCSR_FLUSHFIFO in the
code.

> > > 
> > > This topic was originally tackled by Nicolas Boichat [0] [1] and is discussed
> > 
> > this line is longer than 75 chars.
> 
> ack
> 
> > > further at [2] as part of his GSoC project [3].
> > > 
> > > [0] https://groups.google.com/forum/?hl=en#!topic/beagleboard-gsoc/k8Azwfp75CU
> > > [1] https://gitorious.org/beagleboard-usbsniffer/beagleboard-usbsniffer-kernel/commit/b0be3b6cc195ba732189b04f1d43ec843c3e54c9?p=beagleboard-usbsniffer:beagleboard-usbsniffer-kernel.git;a=patch;h=b0be3b6cc195ba732189b04f1d43ec843c3e54c9
> > > [2] http://beagleboard-usbsniffer.blogspot.com/2010/07/musb-isochronous-transfers-fixed.html
> > > [3] http://elinux.org/BeagleBoard/GSoC/USBSniffer
> > > 
> > > I have forward-ported this patch from 2.6.34 to 4.19-rc1.
> > 
> > this line is irrelevant to the commit message, please move it down to
> > under '---'.
> 
> ack
> 
> > > 
> > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > ---
> > >  drivers/usb/musb/musb_gadget.c | 21 ++++++++++++++-------
> > >  drivers/usb/musb/musbhsdma.c   | 21 +++++++++++----------
> > >  2 files changed, 25 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> > > index eae8b1b1b45b..d3f33f449445 100644
> > > --- a/drivers/usb/musb/musb_gadget.c
> > > +++ b/drivers/usb/musb/musb_gadget.c
> > > @@ -479,11 +479,16 @@ void musb_g_tx(struct musb *musb, u8 epnum)
> > >  			&& (request->actual == request->length))
> > >  				short_packet = true;
> > >  
> > > -		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb)) &&
> > > -			(is_dma && (!dma->desired_mode ||
> > > -				(request->actual &
> > > -					(musb_ep->packet_sz - 1)))))
> > > -				short_packet = true;
> > > +		if (is_dma && (musb_dma_inventra(musb) || musb_dma_ux500(musb))) {
> > 
> > more than 80 chars.
> >
> > > +			if (!dma->desired_mode ||
> > 
> > I understand you forward-port Nicolas' patch, but do you have a specific
> > readon to re-write this 'if' condition? I'd like to see minimum code
> > change in bug fixes,
> >
> > > +					request->actual % musb_ep->packet_sz) {
> > 
> > but I like this version though, easier to read.
> > 
> > > +				musb_dbg(musb, "%s Flushing (FIFO) EP : KPB\n",
> > 
> > what is 'KPB'? the message could be more meaningful?
> > 
> > > +						musb_ep->end_point.name);
> > > +				musb_writew(epio, MUSB_TXCSR,
> > > +						csr | MUSB_TXCSR_FLUSHFIFO);
> > 
> > What if without this line? The short packet doesn't send out?  setting
> > TXSCR_TXPKTRDY in the dma driver is not sufficient?  TXSCR_FLUSHFIFO is
> > only used for aborting cases.
> 
> I just tested this and you are right, it does work without this line.
> Since this is the only significant line in this very complex if block,
> I'll just remove this entire block too.
> 
> > > +				return;
> > > +			}
> > > +		}
> > >  
> > >  		if (short_packet) {
> > >  			/*
> > > @@ -493,8 +498,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
> > >  			if (csr & MUSB_TXCSR_TXPKTRDY)
> > >  				return;
> > >  
> > > -			musb_writew(epio, MUSB_TXCSR, MUSB_TXCSR_MODE
> > > -					| MUSB_TXCSR_TXPKTRDY);
> > > +			musb_dbg(musb, "sending zero pkt (zero=%d, length=%d, actual=%d, dma->desired_mode=%d)\n",

actually this is not a 'zero' packet, it is a short packet.

> > > +				 request->zero, request->length, request->actual,
> > 
> > more than 80 chars.
> 
> The format string or the parameters?

Never mind. I meant the parameters, but it is only 1 char longer, just
leave it like this.

> 
> > 
> > > +				 dma->desired_mode);
> > > +			musb_writew(epio, MUSB_TXCSR, csr | MUSB_TXCSR_TXPKTRDY);
> > 
> > more than 80 chars.
> 
> It's only by 1 character. Should I still put the last argument on a new
> line?

same here, never mind my comment.

> 
> > 
> > >  			request->zero = 0;
> > >  		}
> > >  
> > > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > > index a688f7f87829..e514d4700a6b 100644
> > > --- a/drivers/usb/musb/musbhsdma.c
> > > +++ b/drivers/usb/musb/musbhsdma.c
> > > @@ -346,12 +346,10 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
> > >  				channel->status = MUSB_DMA_STATUS_FREE;
> > >  
> > >  				/* completed */
> > > -				if ((devctl & MUSB_DEVCTL_HM)
> > > -					&& (musb_channel->transmit)
> > > -					&& ((channel->desired_mode == 0)
> > > -					    || (channel->actual_len &
> > > -					    (musb_channel->max_packet_sz - 1)))
> > > -				    ) {
> > > +				if (musb_channel->transmit &&
> > > +				    (!channel->desired_mode ||
> > > +				     (channel->actual_len %
> > > +				      musb_channel->max_packet_sz))) {
> > 
> > improper indentation.
> 
> ack. You don't think this is more readable than if everything was lined
> up?

The original version has 4-chars indentation, I think it is clearer.

> 
> > >  					u8  epnum  = musb_channel->epnum;
> > >  					int offset = musb->io.ep_offset(epnum,
> > >  								    MUSB_TXCSR);
> > > @@ -363,11 +361,14 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
> > >  					 */
> > >  					musb_ep_select(mbase, epnum);
> > >  					txcsr = musb_readw(mbase, offset);
> > > -					txcsr &= ~(MUSB_TXCSR_DMAENAB
> > > +					if (channel->desired_mode == 1) {
> > > +						txcsr &= ~(MUSB_TXCSR_DMAENAB
> > >  							| MUSB_TXCSR_AUTOSET);
> > > -					musb_writew(mbase, offset, txcsr);
> > > -					/* Send out the packet */
> > > -					txcsr &= ~MUSB_TXCSR_DMAMODE;
> > > +						musb_writew(mbase, offset, txcsr);
> > 
> > more than 80 chars.
> 
> This is also only by 2 characters; do you still want just the last
> argument on a new line?

never mind my comment.

Regards,
-Bin.
