Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E41C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F88F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="I/59pRb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F88F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeLNAZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:25:49 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35772 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeLNAZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 19:25:48 -0500
Received: from garnet.amanokami.net (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8644549;
        Fri, 14 Dec 2018 01:25:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1544747146;
        bh=RHra2dvkbgQrF23ySZU7xAniPVwkrf3oLDpGv+LMtME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/59pRb0zGP7d6/XK/pNgHH0JziM8zUt99uHlyAX6sPzsV4Lw3LRpQLAZz9ux9lyP
         70Gin3pBNxQXXrecA4a6vb70ANLbZPyKnB8NxWcr6nxcKt3OoP5r0OAuno4ItOmBSS
         ojeSAbLH4fJgDeDBqPsjnoTiZwC0Q2W4+OFIgqtg=
Date:   Thu, 13 Dec 2018 19:25:38 -0500
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Nicolas Boichat <drinkcat@chromium.org>, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org, balbi@ti.com
Subject: Re: [PATCH] usb: gadget: musb: fix short isoc packets with inventra
 dma for pandaboard es
Message-ID: <20181214002538.GA7477@garnet.amanokami.net>
References: <20181009063220.13745-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009063220.13745-1-paul.elder@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 02:32:20AM -0400, Paul Elder wrote:
> Handling short packets (length < max packet size) in the Inventra DMA
> engine in the MUSB driver causes the MUSB DMA controller to hang. An
> example of a problem that is caused by this problem is when streaming
> video out of a UVC gadget, only the first video frame is transferred.
> 
> For short packets (mode-0 or mode-1 DMA), MUSB_TXCSR_TXPKTRDY must be
> set manually by the driver. This was previously done in musb_g_tx
> (musb_gadget.c), but incorrectly (all csr flags were cleared, and only
> MUSB_TXCSR_MODE and MUSB_TXCSR_TXPKTRDY). Fixing that problem allows
> some requests to be transferred correctly, but multiple requests were
> often put together in one USB packet, and caused problems if the packet
> size was not a multiple of 4.
> 
> Instead, MUSB_TXCSR_TXPKTRDY is set in dma_controller_irq (musbhsdma.c),
> just like host mode transfers, then musb_g_tx forces the packet to be
> flushed, by setting MUSB_TXCSR_FLUSHFIFO.
> 
> This topic was originally tackled by Nicolas Boichat [0] [1] and is discussed
> further at [2] as part of his GSoC project [3].
> 
> [0] https://groups.google.com/forum/?hl=en#!topic/beagleboard-gsoc/k8Azwfp75CU
> [1] https://gitorious.org/beagleboard-usbsniffer/beagleboard-usbsniffer-kernel/commit/b0be3b6cc195ba732189b04f1d43ec843c3e54c9?p=beagleboard-usbsniffer:beagleboard-usbsniffer-kernel.git;a=patch;h=b0be3b6cc195ba732189b04f1d43ec843c3e54c9
> [2] http://beagleboard-usbsniffer.blogspot.com/2010/07/musb-isochronous-transfers-fixed.html
> [3] http://elinux.org/BeagleBoard/GSoC/USBSniffer
> 
> I have forward-ported this patch from 2.6.34 to 4.19-rc1.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>

Hello all,

ping

I was wondering if any of you had a chance to take a look at this yet.

Thanks,

Paul

> ---
>  drivers/usb/musb/musb_gadget.c | 21 ++++++++++++++-------
>  drivers/usb/musb/musbhsdma.c   | 21 +++++++++++----------
>  2 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index eae8b1b1b45b..d3f33f449445 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -479,11 +479,16 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  			&& (request->actual == request->length))
>  				short_packet = true;
>  
> -		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb)) &&
> -			(is_dma && (!dma->desired_mode ||
> -				(request->actual &
> -					(musb_ep->packet_sz - 1)))))
> -				short_packet = true;
> +		if (is_dma && (musb_dma_inventra(musb) || musb_dma_ux500(musb))) {
> +			if (!dma->desired_mode ||
> +					request->actual % musb_ep->packet_sz) {
> +				musb_dbg(musb, "%s Flushing (FIFO) EP : KPB\n",
> +						musb_ep->end_point.name);
> +				musb_writew(epio, MUSB_TXCSR,
> +						csr | MUSB_TXCSR_FLUSHFIFO);
> +				return;
> +			}
> +		}
>  
>  		if (short_packet) {
>  			/*
> @@ -493,8 +498,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  			if (csr & MUSB_TXCSR_TXPKTRDY)
>  				return;
>  
> -			musb_writew(epio, MUSB_TXCSR, MUSB_TXCSR_MODE
> -					| MUSB_TXCSR_TXPKTRDY);
> +			musb_dbg(musb, "sending zero pkt (zero=%d, length=%d, actual=%d, dma->desired_mode=%d)\n",
> +				 request->zero, request->length, request->actual,
> +				 dma->desired_mode);
> +			musb_writew(epio, MUSB_TXCSR, csr | MUSB_TXCSR_TXPKTRDY);
>  			request->zero = 0;
>  		}
>  
> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index a688f7f87829..e514d4700a6b 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -346,12 +346,10 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
>  				channel->status = MUSB_DMA_STATUS_FREE;
>  
>  				/* completed */
> -				if ((devctl & MUSB_DEVCTL_HM)
> -					&& (musb_channel->transmit)
> -					&& ((channel->desired_mode == 0)
> -					    || (channel->actual_len &
> -					    (musb_channel->max_packet_sz - 1)))
> -				    ) {
> +				if (musb_channel->transmit &&
> +				    (!channel->desired_mode ||
> +				     (channel->actual_len %
> +				      musb_channel->max_packet_sz))) {
>  					u8  epnum  = musb_channel->epnum;
>  					int offset = musb->io.ep_offset(epnum,
>  								    MUSB_TXCSR);
> @@ -363,11 +361,14 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
>  					 */
>  					musb_ep_select(mbase, epnum);
>  					txcsr = musb_readw(mbase, offset);
> -					txcsr &= ~(MUSB_TXCSR_DMAENAB
> +					if (channel->desired_mode == 1) {
> +						txcsr &= ~(MUSB_TXCSR_DMAENAB
>  							| MUSB_TXCSR_AUTOSET);
> -					musb_writew(mbase, offset, txcsr);
> -					/* Send out the packet */
> -					txcsr &= ~MUSB_TXCSR_DMAMODE;
> +						musb_writew(mbase, offset, txcsr);
> +						/* Send out the packet */
> +						txcsr &= ~MUSB_TXCSR_DMAMODE;
> +						txcsr |= MUSB_TXCSR_DMAENAB;
> +					}
>  					txcsr |=  MUSB_TXCSR_TXPKTRDY;
>  					musb_writew(mbase, offset, txcsr);
>  				}
> -- 
> 2.18.0
> 
