Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179DE21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfBSQ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:29:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:57650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbfBSQ3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:29:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26FE5B129;
        Tue, 19 Feb 2019 16:29:51 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     felipe.balbi@linux.intel.com, oneukum@suse.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: add Immediate Data Transfer support
Date:   Tue, 19 Feb 2019 17:29:45 +0100
Message-Id: <20190219162945.22889-1-nsaenzjulienne@suse.de>
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

The implementation could cover all kind of output endpoints. Yet
Isochronous endpoints are bypassed as I was unable to find one that
matched IDT's constraints. As we try to bypass the default DMA mappings
on URB buffers we'd need to find a Isochronous device with an
urb->transfer_buffer_length <= 8 bytes.

The implementation takes into account that the 8 byte buffers provided
by the URB will never cross a 64KB boundary.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/host/xhci-ring.c | 12 ++++++++++++
 drivers/usb/host/xhci.c      | 16 ++++++++++++++++
 drivers/usb/host/xhci.h      | 17 +++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 40fa25c4d041..997edc908a0d 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3272,6 +3272,12 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
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
 
 		/* Only set interrupt on short packet for IN endpoints */
@@ -3411,6 +3417,12 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
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
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e65922608..f04ad2290884 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1238,6 +1238,21 @@ EXPORT_SYMBOL_GPL(xhci_resume);
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * Bypass the DMA mapping if URB is suitable for Immediate Transfer (IDT),
+ * we'll copy the actual data into the TRB address register. This is limited to
+ * transfers up to 8 bytes on output endpoints of any kind with wMaxPacketSize
+ * >= 8 bytes. If suitable for IDT only one Transfer TRB per TD is allowed.
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
index 652dc36e3012..7dc6d2197641 100644
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
@@ -2141,6 +2143,21 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
 					urb->stream_id);
 }
 
+/*
+ * TODO: As per spec Isochronous IDT transmissions are supported. We bypass
+ * them anyways as we where unable to find a device that matches the
+ * constraints.
+ */
+static inline bool xhci_urb_suitable_for_idt(struct urb *urb)
+{
+	if (!usb_endpoint_xfer_isoc(&urb->ep->desc) && usb_urb_dir_out(urb) &&
+	    usb_endpoint_maxp(&urb->ep->desc) >= TRB_IDT_MAX_SIZE &&
+	    urb->transfer_buffer_length <= TRB_IDT_MAX_SIZE)
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

