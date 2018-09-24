Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B189ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030B121486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030B121486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbeIXSgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:36:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeIXSgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:36:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 712041092;
        Mon, 24 Sep 2018 12:34:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.18 113/235] xhci: Fix use after free for URB cancellation on a reallocated endpoint
Date:   Mon, 24 Sep 2018 13:51:39 +0200
Message-Id: <20180924113117.174484233@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 4937213ba7fafa13f30496b3965ffe93970d8b53 upstream.

Make sure the cancelled URB is on the current endpoint ring.

If the endpoint ring has been reallocated since the URB was enqueued
then the URB may contain TD and TRB pointers to a already freed ring.
In this the case return the URB without touching any of the freed ring
structure data.

Don't try to stop the ring. It would be useless.

This can occur if endpoint is not flushed before it is dropped and
re-added, which is the case in usb_set_interface() as xhci does
things in an odd order.

Cc: <stable@vger.kernel.org>
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -37,6 +37,21 @@ static unsigned long long quirks;
 module_param(quirks, ullong, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
+static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
+{
+	struct xhci_segment *seg = ring->first_seg;
+
+	if (!td || !td->start_seg)
+		return false;
+	do {
+		if (seg == td->start_seg)
+			return true;
+		seg = seg->next;
+	} while (seg && seg != ring->first_seg);
+
+	return false;
+}
+
 /* TODO: copied from ehci-hcd.c - can this be refactored? */
 /*
  * xhci_handshake - spin reading hc until handshake completes or fails
@@ -1571,6 +1586,21 @@ static int xhci_urb_dequeue(struct usb_h
 		goto done;
 	}
 
+	/*
+	 * check ring is not re-allocated since URB was enqueued. If it is, then
+	 * make sure none of the ring related pointers in this URB private data
+	 * are touched, such as td_list, otherwise we overwrite freed data
+	 */
+	if (!td_on_ring(&urb_priv->td[0], ep_ring)) {
+		xhci_err(xhci, "Canceled URB td not found on endpoint ring");
+		for (i = urb_priv->num_tds_done; i < urb_priv->num_tds; i++) {
+			td = &urb_priv->td[i];
+			if (!list_empty(&td->cancelled_td_list))
+				list_del_init(&td->cancelled_td_list);
+		}
+		goto err_giveback;
+	}
+
 	if (xhci->xhc_state & XHCI_STATE_HALTED) {
 		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
 				"HC halted, freeing TD manually.");


