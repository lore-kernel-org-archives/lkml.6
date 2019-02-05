Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41495C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175D12083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfBET5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:57:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:53764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbfBET5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:57:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13FEDAC17;
        Tue,  5 Feb 2019 19:57:05 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     felipe.balbi@linux.intel.com, oneukum@suse.com,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2] usb: xhci: add Immediate Data Transfer support
Date:   Tue,  5 Feb 2019 20:56:47 +0100
Message-Id: <20190205195647.29258-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Immediate data transfers (IDT) allow the HCD to copy small chunks of
data (up to 8bytes) directly into its output transfer TRBs. This avoids
the somewhat expensive DMA mappings that are performed by default on
most URBs submissions.

In the case an URB was suitable for IDT. The data is directly copied
into the "Data Buffer Pointer" region of the TRB and the IDT flag is
set. Instead of triggering memory accesses the HC will use the data
directly.

The implementation covers all kind of output endpoints. All have been
tested successfully with multiple devices except for isochronous ones. I
can't seem to find a device that'll perform transfers with such small
packet sizes.

The implementation takes into account that the 8 byte buffers provided
by the URB will never cross a 64KB boundary.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
Chages since first RFC:
  - Got rid of URB flag
  - Implement feature for Control transfers
  - Implement feature for Isoc transfers

 drivers/usb/host/xhci-ring.c | 20 ++++++++++++++++++++
 drivers/usb/host/xhci.c      | 16 ++++++++++++++++
 drivers/usb/host/xhci.h      | 12 ++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 40fa25c4d041..a4efbe62a1a3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3272,8 +3272,15 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			field |= TRB_IOC;
 			more_trbs_coming = false;
 			td->last_trb = ring->enqueue;
+
+			if (xhci_urb_suitable_for_idt(urb)) {
+				memcpy(&send_addr, urb->transfer_buffer,
+				       trb_buff_len);
+				field |= TRB_IDT;
+			}
 		}
 
+
 		/* Only set interrupt on short packet for IN endpoints */
 		if (usb_urb_dir_in(urb))
 			field |= TRB_ISP;
@@ -3411,6 +3418,12 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	if (urb->transfer_buffer_length > 0) {
 		u32 length_field, remainder;
 
+		if (xhci_urb_suitable_for_idt(urb)) {
+			memcpy(&urb->transfer_dma, urb->transfer_buffer,
+			       urb->transfer_buffer_length);
+			field |= TRB_IDT;
+		}
+
 		remainder = xhci_td_remainder(xhci, 0,
 				urb->transfer_buffer_length,
 				urb->transfer_buffer_length,
@@ -3420,6 +3433,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 				TRB_INTR_TARGET(0);
 		if (setup->bRequestType & USB_DIR_IN)
 			field |= TRB_DIR_IN;
+
 		queue_trb(xhci, ep_ring, true,
 				lower_32_bits(urb->transfer_dma),
 				upper_32_bits(urb->transfer_dma),
@@ -3710,6 +3724,12 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			if (trb_buff_len > td_remain_len)
 				trb_buff_len = td_remain_len;
 
+			if (xhci_urb_suitable_for_idt(urb)) {
+				memcpy(&addr, urb->transfer_buffer,
+				       trb_buff_len);
+				field |= TRB_IDT;
+			}
+
 			/* Set the TRB length, TD size, & interrupter fields. */
 			remainder = xhci_td_remainder(xhci, running_total,
 						   trb_buff_len, td_len,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e65922608..dec62f7f5dc8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1238,6 +1238,21 @@ EXPORT_SYMBOL_GPL(xhci_resume);
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * Bypass the DMA mapping if URB is suitable for Immediate Transfer (IDT),
+ * we'll copy the actual data into the TRB address register. This is limited to
+ * transfers up to 8 bytes on output endpoints of any kind with wMaxPacketSize
+ * >= 8 bytes.
+ */
+static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+				gfp_t mem_flags)
+{
+	if (xhci_urb_suitable_for_idt(urb))
+		return 0;
+
+	return usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
+}
+
 /**
  * xhci_get_endpoint_index - Used for passing endpoint bitmasks between the core and
  * HCDs.  Find the index for an endpoint given its descriptor.  Use the return
@@ -5155,6 +5170,7 @@ static const struct hc_driver xhci_hc_driver = {
 	/*
 	 * managing i/o requests and associated device resources
 	 */
+	.map_urb_for_dma =      xhci_map_urb_for_dma,
 	.urb_enqueue =		xhci_urb_enqueue,
 	.urb_dequeue =		xhci_urb_dequeue,
 	.alloc_dev =		xhci_alloc_dev,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 652dc36e3012..9d77b0901ab7 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1295,6 +1295,8 @@ enum xhci_setup_dev {
 #define TRB_IOC			(1<<5)
 /* The buffer pointer contains immediate data */
 #define TRB_IDT			(1<<6)
+/* TDs smaller than this might use IDT */
+#define TRB_IDT_MAX_SIZE	8
 
 /* Block Event Interrupt */
 #define	TRB_BEI			(1<<9)
@@ -2141,6 +2143,16 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
 					urb->stream_id);
 }
 
+static inline bool xhci_urb_suitable_for_idt(struct urb *urb)
+{
+	if (usb_endpoint_maxp(&urb->ep->desc) >= TRB_IDT_MAX_SIZE &&
+	    urb->transfer_buffer_length <= TRB_IDT_MAX_SIZE &&
+	    usb_urb_dir_out(urb))
+		return true;
+
+	return false;
+}
+
 static inline char *xhci_slot_state_string(u32 state)
 {
 	switch (state) {
-- 
2.20.1

