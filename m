Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596D62082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JyK6avjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfAPACB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:02:01 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:49448 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfAPACB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:02:01 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F25CE530;
        Wed, 16 Jan 2019 01:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547596919;
        bh=sg4t8JOjyLOwJH2mu0Q5VtvgoxoNuNHPOUq7xguwWug=;
        h=From:To:Cc:Subject:Date:From;
        b=JyK6avjqQHpHBBcI46E/FkKs3dFHAGs8rgAkA/O51mfk+MU1w6bFjeMa5ALs4D5Sc
         vhTiOCVQK3MchOIw5rpGktlTgTwjd9dNe6yyc1rYRyuffEn8fE5OQrcaaxmrnNtJf1
         9uLwPPbPuSV5+3BUEAiRP280z79xnTWcJvQxnVfA=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        b-liu@ti.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, drinkcat@chromium.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: gadget: musb: fix short isoc packets with inventra dma
Date:   Tue, 15 Jan 2019 19:01:45 -0500
Message-Id: <20190116000145.5816-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
Changes in v3:

- remove unnecessary chunk for sending short packet

Changes in v2:

- no more flushing FIFO
- greatly simplified short packet if guard in musb_g_tx, and removed
  unnecessary variables
- minor indentation and wording changes
 drivers/usb/musb/musb_gadget.c | 13 +------------
 drivers/usb/musb/musbhsdma.c   | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index eae8b1b1b45b..ffe462a657b1 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -452,13 +452,10 @@ void musb_g_tx(struct musb *musb, u8 epnum)
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
@@ -476,16 +473,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
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
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index a688f7f87829..5fc6825745f2 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -346,12 +346,10 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
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
@@ -363,11 +361,14 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
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
-- 
2.20.1

