Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F99C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626F4218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfBANGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:06:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:36176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727690AbfBANGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:06:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AAFEAD7B;
        Fri,  1 Feb 2019 13:06:08 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     oneukum@suse.com, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] usb: xhci: add Immediate Data Transfers support
Date:   Fri,  1 Feb 2019 14:06:02 +0100
Message-Id: <20190201130602.9171-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Immediate data transfers (IDT) allow the HCD to copy small chunks of
data (up to 8bits) directly into its output transfer TRBs. This avoids
the somewhat expensive DMA mappings that are performed by default on
most URBs submissions.

In the case an URB was suitable for IDT. The data is directly copied
into the "Data Buffer Pointer" region of the TRB and the IDT flag is
set. Instead of triggering memory accesses the HC will use the data
directly.

An additional URB flag was created to mark whenever the URB doesn't need
any DMA mapping. Ideally it would have been nice to use a private flag
as this is specific to XHCI. Yet it's not possible as the URB private
area is allocated only after the DMA mapping is done.

Isochronous transfers are not implemented so far as it's hard to find a
device that will send such small packets.

This was tested using USB/serial adapter and by controlling the leds on
an XBOX controller. There where no disruptions on the rest of USB
devices attached on the system.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/host/xhci-ring.c |  6 ++++++
 drivers/usb/host/xhci.c      | 37 ++++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h      |  2 ++
 include/linux/usb.h          |  2 ++
 4 files changed, 47 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 40fa25c4d041..dd9805fb0566 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3272,6 +3272,12 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			field |= TRB_IOC;
 			more_trbs_coming = false;
 			td->last_trb = ring->enqueue;
+
+			if (urb->transfer_flags & URB_NO_DMA_MAP) {
+				memcpy(&send_addr, urb->transfer_buffer,
+				       full_len);
+				field |= TRB_IDT;
+			}
 		}
 
 		/* Only set interrupt on short packet for IN endpoints */
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e65922608..ce3b6663f940 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1238,6 +1238,41 @@ EXPORT_SYMBOL_GPL(xhci_resume);
 
 /*-------------------------------------------------------------------------*/
 
+static void xhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
+{
+	if (urb->transfer_flags & URB_NO_DMA_MAP)
+		urb->transfer_flags &= ~URB_NO_DMA_MAP;
+	else
+		usb_hcd_unmap_urb_for_dma(hcd, urb);
+}
+
+static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+				gfp_t mem_flags)
+{
+	int maxp = usb_endpoint_maxp(&urb->ep->desc);
+	int len = urb->transfer_buffer_length;
+	int ret = 0;
+
+	/*
+	 * Checks if URB is suitable for Immediate Transfer (IDT): instead of
+	 * mapping the buffer for DMA and passing the address to the host
+	 * controller, we copy the actual data into the TRB address register.
+	 * This is limited to transfers up to 8 bytes.
+	 *
+	 * IDT is only supported for Bulk and Interrupt endpoints. Apart from
+	 * the size constraints special care is taken to avoid cases where
+	 * wMaxPacketSize is smaller than 8 bytes as it's not supported.
+	 */
+	if ((usb_endpoint_is_int_out(&urb->ep->desc) ||
+	    usb_endpoint_is_bulk_out(&urb->ep->desc)) &&
+	    maxp >= TRB_IDT_MAX_SIZE && len <= TRB_IDT_MAX_SIZE)
+		urb->transfer_flags |= URB_NO_DMA_MAP;
+	else
+		ret = usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
+
+	return ret;
+}
+
 /**
  * xhci_get_endpoint_index - Used for passing endpoint bitmasks between the core and
  * HCDs.  Find the index for an endpoint given its descriptor.  Use the return
@@ -5155,6 +5190,8 @@ static const struct hc_driver xhci_hc_driver = {
 	/*
 	 * managing i/o requests and associated device resources
 	 */
+	.map_urb_for_dma =      xhci_map_urb_for_dma,
+	.unmap_urb_for_dma =    xhci_unmap_urb_for_dma,
 	.urb_enqueue =		xhci_urb_enqueue,
 	.urb_dequeue =		xhci_urb_dequeue,
 	.alloc_dev =		xhci_alloc_dev,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 652dc36e3012..1b51999794b3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1295,6 +1295,8 @@ enum xhci_setup_dev {
 #define TRB_IOC			(1<<5)
 /* The buffer pointer contains immediate data */
 #define TRB_IDT			(1<<6)
+/* TDs smaller 64bits this might use immediate data */
+#define TRB_IDT_MAX_SIZE	8
 
 /* Block Event Interrupt */
 #define	TRB_BEI			(1<<9)
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 5e49e82c4368..1a6b2dfe7c72 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1331,6 +1331,8 @@ extern int usb_disabled(void);
 #define URB_SETUP_MAP_LOCAL	0x00200000	/* HCD-local setup packet */
 #define URB_DMA_SG_COMBINED	0x00400000	/* S-G entries were combined */
 #define URB_ALIGNED_TEMP_BUFFER	0x00800000	/* Temp buffer was alloc'd */
+#define URB_NO_DMA_MAP		0x01000000	/* Data directly transferred to
+						 * HC */
 
 struct usb_iso_packet_descriptor {
 	unsigned int offset;
-- 
2.20.1

