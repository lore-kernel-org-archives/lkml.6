Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB046C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EE3206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V+4jgxEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfAIPCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:02:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50384 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731686AbfAIPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:02:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x09F2FMT022547;
        Wed, 9 Jan 2019 09:02:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547046135;
        bh=tjIam1Hh0q2N2IHJsaY/bqc93Ln54cvop9DBrAyB7A8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=V+4jgxEu01BAn230NWrG3OCD5IgaEKZa6J/QWr4Xe2QksmluiP27yLcHsE4D5esyw
         xcWd3eEmCHHwKxoxEaQLGK3/BraGwWLiSI/WOf3BAF44VvcwO1HfGVr+oP/UcGkW8L
         itet87LicAfuowtvXaY3gRpp5groevJlT5QnCeVo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x09F2F9a050773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 09:02:15 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 09:02:15 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 09:02:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x09F2F2D000548;
        Wed, 9 Jan 2019 09:02:15 -0600
Date:   Wed, 9 Jan 2019 09:02:15 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
CC:     <laurent.pinchart@ideasonboard.com>,
        <kieran.bingham@ideasonboard.com>, <drinkcat@chromium.org>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: musb: fix short isoc packets with
 inventra dma
Message-ID: <20190109150215.GJ25910@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        drinkcat@chromium.org, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190109071009.27625-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190109071009.27625-1-paul.elder@ideasonboard.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Jan 09, 2019 at 02:10:09AM -0500, Paul Elder wrote:
> Handling short packets (length < max packet size) in the Inventra DMA
> engine in the MUSB driver causes the MUSB DMA controller to hang. An
> example of a problem that is caused by this problem is when streaming
> video out of a UVC gadget, only the first video frame is transferred.
> 
> For short packets (mode-0 or mode-1 DMA), MUSB_TXCSR_TXPKTRDY must be
> set manually by the driver. This was previously done in musb_g_tx
> (musb_gadget.c), but incorrectly (all csr flags were cleared, and only
> MUSB_TXCSR_MODE and MUSB_TXCSR_TXPKTRDY were set). Fixing that problem
> allows some requests to be transferred correctly, but multiple requests
> were often put together in one USB packet, and caused problems if the
> packet size was not a multiple of 4. Instead, set MUSB_TXCSR_TXPKTRDY
> in dma_controller_irq (musbhsdma.c), just like host mode transfers.
> 
> This topic was originally tackled by Nicolas Boichat [0] [1] and is
> discussed further at [2] as part of his GSoC project [3].
> 
> [0] https://groups.google.com/forum/?hl=en#!topic/beagleboard-gsoc/k8Azwfp75CU
> [1] https://gitorious.org/beagleboard-usbsniffer/beagleboard-usbsniffer-kernel/commit/b0be3b6cc195ba732189b04f1d43ec843c3e54c9?p=beagleboard-usbsniffer:beagleboard-usbsniffer-kernel.git;a=patch;h=b0be3b6cc195ba732189b04f1d43ec843c3e54c9
> [2] http://beagleboard-usbsniffer.blogspot.com/2010/07/musb-isochronous-transfers-fixed.html
> [3] http://elinux.org/BeagleBoard/GSoC/USBSniffer
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
> Changes in v2:
> 
> - no more flushing FIFO
> - greatly simplified short packet if guard in musb_g_tx, and removed
>   unnecessary variables
> - minor indentation and wording changes
> 
>  drivers/usb/musb/musb_gadget.c | 19 +++++--------------
>  drivers/usb/musb/musbhsdma.c   | 21 +++++++++++----------
>  2 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index eae8b1b1b45b..496643f54faa 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -452,13 +452,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  	}
>  
>  	if (request) {
> -		u8	is_dma = 0;
> -		bool	short_packet = false;
>  
>  		trace_musb_req_tx(req);
>  
>  		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
> -			is_dma = 1;
>  			csr |= MUSB_TXCSR_P_WZC_BITS;
>  			csr &= ~(MUSB_TXCSR_DMAENAB | MUSB_TXCSR_P_UNDERRUN |
>  				 MUSB_TXCSR_TXPKTRDY | MUSB_TXCSR_AUTOSET);
> @@ -476,16 +473,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  		 */
>  		if ((request->zero && request->length)
>  			&& (request->length % musb_ep->packet_sz == 0)
> -			&& (request->actual == request->length))
> -				short_packet = true;
> +			&& (request->actual == request->length)) {
>  
> -		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb)) &&
> -			(is_dma && (!dma->desired_mode ||
> -				(request->actual &
> -					(musb_ep->packet_sz - 1)))))
> -				short_packet = true;
> -
> -		if (short_packet) {
>  			/*
>  			 * On DMA completion, FIFO may not be
>  			 * available yet...
> @@ -493,8 +482,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  			if (csr & MUSB_TXCSR_TXPKTRDY)
>  				return;
>  
> -			musb_writew(epio, MUSB_TXCSR, MUSB_TXCSR_MODE
> -					| MUSB_TXCSR_TXPKTRDY);
> +			musb_dbg(musb, "sending short pkt (zero=%d, length=%d, actual=%d, dma->desired_mode=%d)\n",
> +				 request->zero, request->length, request->actual,
> +				 dma->desired_mode);
> +			musb_writew(epio, MUSB_TXCSR, csr | MUSB_TXCSR_TXPKTRDY);

Sorry I didn't catch this in the last review, but this change seems not
required, isn't it? In the first version of the patch, the code is
'returned' in the 'if (musb_dma_inventra())' branch above, doesn't reach
here.

Regards,
-Bin.
