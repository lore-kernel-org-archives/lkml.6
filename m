Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0593C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8072E20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896776;
	bh=TXGHrX6YVAg7Bpb23v0zji9biDaqRZYxvlrSujoBUGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTk3XXkMm2yPFzPY3aTh5R+QTnGl3lczzZ+C7xmWEKTSlcikkwQpNk5uJUIaw6J44
	 l7xC5xQ4NfEc09Uwe70KaNcPUBI5Z2tWDYZI99eQbGGr82w6M2dKYfY71oFxdD/ICJ
	 nviW0s4lfpp9e0gOdVO23loefFNKXiXZAOg3bOdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbfBKOwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388524AbfBKOwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F95920844;
        Mon, 11 Feb 2019 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896770;
        bh=TXGHrX6YVAg7Bpb23v0zji9biDaqRZYxvlrSujoBUGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2N5cpXMCVM3BK+2BzZTs7EGwbBP4E9wtT3VdTf6ucHIjqvf2ZeR0sTMpKIBRH2AzW
         Ki8vLc74JV48XJrJg+3inpEDC7JBFUO5z3UWUSleFaw9ETrnveQCCF6nbtIw16pXqs
         SiW6oTB4X2URXWiwGa/QtCN8EHIOkShfRnwmr5ME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Elder <paul.elder@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.19 296/313] usb: gadget: musb: fix short isoc packets with inventra dma
Date:   Mon, 11 Feb 2019 15:19:36 +0100
Message-Id: <20190211141912.756089922@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Elder <paul.elder@ideasonboard.com>

commit c418fd6c01fbc5516a2cd1eaf1df1ec86869028a upstream.

Handling short packets (length < max packet size) in the Inventra DMA
engine in the MUSB driver causes the MUSB DMA controller to hang. An
example of a problem that is caused by this problem is when streaming
video out of a UVC gadget, only the first video frame is transferred.

For short packets (mode-0 or mode-1 DMA), MUSB_TXCSR_TXPKTRDY must be
set manually by the driver. This was previously done in musb_g_tx
(musb_gadget.c), but incorrectly (all csr flags were cleared, and only
MUSB_TXCSR_MODE and MUSB_TXCSR_TXPKTRDY were set). Fixing that problem
allows some requests to be transferred correctly, but multiple requests
were often put together in one USB packet, and caused problems if the
packet size was not a multiple of 4. Instead, set MUSB_TXCSR_TXPKTRDY
in dma_controller_irq (musbhsdma.c), just like host mode transfers.

This topic was originally tackled by Nicolas Boichat [0] [1] and is
discussed further at [2] as part of his GSoC project [3].

[0] https://groups.google.com/forum/?hl=en#!topic/beagleboard-gsoc/k8Azwfp75CU
[1] https://gitorious.org/beagleboard-usbsniffer/beagleboard-usbsniffer-kernel/commit/b0be3b6cc195ba732189b04f1d43ec843c3e54c9?p=beagleboard-usbsniffer:beagleboard-usbsniffer-kernel.git;a=patch;h=b0be3b6cc195ba732189b04f1d43ec843c3e54c9
[2] http://beagleboard-usbsniffer.blogspot.com/2010/07/musb-isochronous-transfers-fixed.html
[3] http://elinux.org/BeagleBoard/GSoC/USBSniffer

Fixes: 550a7375fe72 ("USB: Add MUSB and TUSB support")
Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_gadget.c |   13 +------------
 drivers/usb/musb/musbhsdma.c   |   21 +++++++++++----------
 2 files changed, 12 insertions(+), 22 deletions(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -452,13 +452,10 @@ void musb_g_tx(struct musb *musb, u8 epn
 	}
 
 	if (request) {
-		u8	is_dma = 0;
-		bool	short_packet = false;
 
 		trace_musb_req_tx(req);
 
 		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
-			is_dma = 1;
 			csr |= MUSB_TXCSR_P_WZC_BITS;
 			csr &= ~(MUSB_TXCSR_DMAENAB | MUSB_TXCSR_P_UNDERRUN |
 				 MUSB_TXCSR_TXPKTRDY | MUSB_TXCSR_AUTOSET);
@@ -476,16 +473,8 @@ void musb_g_tx(struct musb *musb, u8 epn
 		 */
 		if ((request->zero && request->length)
 			&& (request->length % musb_ep->packet_sz == 0)
-			&& (request->actual == request->length))
-				short_packet = true;
+			&& (request->actual == request->length)) {
 
-		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb)) &&
-			(is_dma && (!dma->desired_mode ||
-				(request->actual &
-					(musb_ep->packet_sz - 1)))))
-				short_packet = true;
-
-		if (short_packet) {
 			/*
 			 * On DMA completion, FIFO may not be
 			 * available yet...
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -346,12 +346,10 @@ static irqreturn_t dma_controller_irq(in
 				channel->status = MUSB_DMA_STATUS_FREE;
 
 				/* completed */
-				if ((devctl & MUSB_DEVCTL_HM)
-					&& (musb_channel->transmit)
-					&& ((channel->desired_mode == 0)
-					    || (channel->actual_len &
-					    (musb_channel->max_packet_sz - 1)))
-				    ) {
+				if (musb_channel->transmit &&
+					(!channel->desired_mode ||
+					(channel->actual_len %
+					    musb_channel->max_packet_sz))) {
 					u8  epnum  = musb_channel->epnum;
 					int offset = musb->io.ep_offset(epnum,
 								    MUSB_TXCSR);
@@ -363,11 +361,14 @@ static irqreturn_t dma_controller_irq(in
 					 */
 					musb_ep_select(mbase, epnum);
 					txcsr = musb_readw(mbase, offset);
-					txcsr &= ~(MUSB_TXCSR_DMAENAB
+					if (channel->desired_mode == 1) {
+						txcsr &= ~(MUSB_TXCSR_DMAENAB
 							| MUSB_TXCSR_AUTOSET);
-					musb_writew(mbase, offset, txcsr);
-					/* Send out the packet */
-					txcsr &= ~MUSB_TXCSR_DMAMODE;
+						musb_writew(mbase, offset, txcsr);
+						/* Send out the packet */
+						txcsr &= ~MUSB_TXCSR_DMAMODE;
+						txcsr |= MUSB_TXCSR_DMAENAB;
+					}
 					txcsr |=  MUSB_TXCSR_TXPKTRDY;
 					musb_writew(mbase, offset, txcsr);
 				}


