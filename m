Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B65FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33761218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfBRGqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:46:54 -0500
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:29120
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbfBRGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:46:53 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2019 01:46:53 EST
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 69723204C2;
        Mon, 18 Feb 2019 06:37:39 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        felipe.balbi@linux.intel.com, a.seppala@gmail.com,
        dianders@chromium.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH] usb: dwc2: Fix DMA cache alignment issues
Date:   Mon, 18 Feb 2019 07:37:30 +0100
Message-Id: <20190218063730.26870-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insert a padding between data and the stored_xfer_buffer pointer to
ensure they are not on the same cache line.

Otherwise, the stored_xfer_buffer gets corrupted for IN URBs on
non-cache-coherent systems. (In my case: Lantiq xRX200 MIPS)

Fixes: 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in a more supported way")
Fixes: 56406e017a88 ("usb: dwc2: Fix DMA alignment to start at allocated boundary")
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/usb/dwc2/hcd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dd82fa516f3f..f3035dd4db25 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2664,8 +2664,10 @@ static void dwc2_free_dma_aligned_buffer(struct urb *urb)
 		return;
 
 	/* Restore urb->transfer_buffer from the end of the allocated area */
-	memcpy(&stored_xfer_buffer, urb->transfer_buffer +
-	       urb->transfer_buffer_length, sizeof(urb->transfer_buffer));
+	memcpy(&stored_xfer_buffer,
+	       PTR_ALIGN(urb->transfer_buffer + urb->transfer_buffer_length,
+			 dma_get_cache_alignment()),
+	       sizeof(urb->transfer_buffer));
 
 	if (usb_urb_dir_in(urb)) {
 		if (usb_pipeisoc(urb->pipe))
@@ -2697,6 +2699,7 @@ static int dwc2_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
 	 * DMA
 	 */
 	kmalloc_size = urb->transfer_buffer_length +
+		(dma_get_cache_alignment() - 1) +
 		sizeof(urb->transfer_buffer);
 
 	kmalloc_ptr = kmalloc(kmalloc_size, mem_flags);
@@ -2707,7 +2710,8 @@ static int dwc2_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
 	 * Position value of original urb->transfer_buffer pointer to the end
 	 * of allocation for later referencing
 	 */
-	memcpy(kmalloc_ptr + urb->transfer_buffer_length,
+	memcpy(PTR_ALIGN(kmalloc_ptr + urb->transfer_buffer_length,
+			 dma_get_cache_alignment()),
 	       &urb->transfer_buffer, sizeof(urb->transfer_buffer));
 
 	if (usb_urb_dir_out(urb))
-- 
2.11.0

