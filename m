Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeFEUjE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:39:04 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:59758
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751871AbeFEUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:00 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc: Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 3/8] Drivers: hv: vmbus: Add comments on ring buffer signaling
Date: Tue,  5 Jun 2018 13:37:51 -0700
Message-Id: <20180605203756.29809-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605203756.29809-1-kys@linuxonhyperv.com>
References: <20180605203536.29751-1-kys@linuxonhyperv.com>
 <20180605203756.29809-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGd+neOwEFaKqAdWVxKYp4Tu8rbXQAVFiKo+Swb3gGN5sJeitapD3vru+IEVFRDRQFaGMRuKbwBedN/dp23BWpXBWJZiUPVYG8mcUS0ska+aREtbePtk
 5haQWExr3eCljvPCGmkkA+klJ0cDciOtECD7ac8VJjTkHLuRMu+UiC8VVkuo7yJIq87wcMG0xuxw2GgniVmXF+5ImgGxhkRJnTcGW4fUr+TUz0Lqgz8dJ7qe
 Hmnl8IMkP+SoT/pp0I7dudnUcS3FtU6k+5aw5LEFTt5ObRWA+zaraPKVSWvXYTm/oBxVAZkZGj3nxnmiK5dVOEPS0Ro0wunnXHYHg81QjQteIObAmnubQ0fX
 wcxebKmJyiLxoshuVafjt6cFjrYDA5Z6PHwmt9/R2yA/L65OVxhmixY8uDn9QRruqLba65qDu0jqoD2Mu7OgoZWT9DQfcZTshWHKgzb4ZgFXbL/xmE74Qvhu
 /MFf658KPXRv+UhpFAt3AK+mGYadCHb0+gO8VWx2fZ/iGsdINON0VY2sOCTGJ5DoYOE9Sln2J5WTTXlt+gX289eWnlide6JOM5ImoA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

Add comments describing intricacies of Hyper-V ring buffer
signaling code.  This information is not in Hyper-V public
documents, so include here to capture the knowledge for
future coders.

There are no code changes in this commit.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/ring_buffer.c | 65 +++++++++++++++++++++++++++++++++-------
 include/linux/hyperv.h   | 31 ++++++++++++++-----
 2 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 8699bb969e7e..ce6ea6dad490 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -429,7 +429,24 @@ static u32 hv_pkt_iter_bytes_read(const struct hv_ring_buffer_info *rbi,
 }
 
 /*
- * Update host ring buffer after iterating over packets.
+ * Update host ring buffer after iterating over packets. If the host has
+ * stopped queuing new entries because it found the ring buffer full, and
+ * sufficient space is being freed up, signal the host. But be careful to
+ * only signal the host when necessary, both for performance reasons and
+ * because Hyper-V protects itself by throttling guests that signal
+ * inappropriately.
+ *
+ * Determining when to signal is tricky. There are three key data inputs
+ * that must be handled in this order to avoid race conditions:
+ *
+ * 1. Update the read_index
+ * 2. Read the pending_send_sz
+ * 3. Read the current write_index
+ *
+ * The interrupt_mask is not used to determine when to signal. The
+ * interrupt_mask is used only on the guest->host ring buffer when
+ * sending requests to the host. The host does not use it on the host->
+ * guest ring buffer to indicate whether it should be signaled.
  */
 void hv_pkt_iter_close(struct vmbus_channel *channel)
 {
@@ -445,22 +462,30 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	start_read_index = rbi->ring_buffer->read_index;
 	rbi->ring_buffer->read_index = rbi->priv_read_index;
 
+	/*
+	 * Older versions of Hyper-V (before WS2102 and Win8) do not
+	 * implement pending_send_sz and simply poll if the host->guest
+	 * ring buffer is full.  No signaling is needed or expected.
+	 */
 	if (!rbi->ring_buffer->feature_bits.feat_pending_send_sz)
 		return;
 
 	/*
 	 * Issue a full memory barrier before making the signaling decision.
-	 * Here is the reason for having this barrier:
-	 * If the reading of the pend_sz (in this function)
-	 * were to be reordered and read before we commit the new read
-	 * index (in the calling function)  we could
-	 * have a problem. If the host were to set the pending_sz after we
-	 * have sampled pending_sz and go to sleep before we commit the
+	 * If reading pending_send_sz were to be reordered and happen
+	 * before we commit the new read_index, a race could occur.  If the
+	 * host were to set the pending_send_sz after we have sampled
+	 * pending_send_sz, and the ring buffer blocks before we commit the
 	 * read index, we could miss sending the interrupt. Issue a full
 	 * memory barrier to address this.
 	 */
 	virt_mb();
 
+	/*
+	 * If the pending_send_sz is zero, then the ring buffer is not
+	 * blocked and there is no need to signal.  This is far by the
+	 * most common case, so exit quickly for best performance.
+	 */
 	pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
 	if (!pending_sz)
 		return;
@@ -474,14 +499,32 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	bytes_read = hv_pkt_iter_bytes_read(rbi, start_read_index);
 
 	/*
-	 * If there was space before we began iteration,
-	 * then host was not blocked.
+	 * We want to signal the host only if we're transitioning
+	 * from a "not enough free space" state to a "enough free
+	 * space" state.  For example, it's possible that this function
+	 * could run and free up enough space to signal the host, and then
+	 * run again and free up additional space before the host has a
+	 * chance to clear the pending_send_sz.  The 2nd invocation would
+	 * be a null transition from "enough free space" to "enough free
+	 * space", which doesn't warrant a signal.
+	 *
+	 * Exactly filling the ring buffer is treated as "not enough
+	 * space". The ring buffer always must have at least one byte
+	 * empty so the empty and full conditions are distinguishable.
+	 * hv_get_bytes_to_write() doesn't fully tell the truth in
+	 * this regard.
+	 *
+	 * So first check if we were in the "enough free space" state
+	 * before we began the iteration. If so, the host was not
+	 * blocked, and there's no need to signal.
 	 */
-
 	if (curr_write_sz - bytes_read > pending_sz)
 		return;
 
-	/* If pending write will not fit, don't give false hope. */
+	/*
+	 * Similarly, if the new state is "not enough space", then
+	 * there's no need to signal.
+	 */
 	if (curr_write_sz <= pending_sz)
 		return;
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 11b5612dc066..3265300b2b16 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -88,18 +88,33 @@ struct hv_ring_buffer {
 	u32 interrupt_mask;
 
 	/*
-	 * Win8 uses some of the reserved bits to implement
-	 * interrupt driven flow management. On the send side
-	 * we can request that the receiver interrupt the sender
-	 * when the ring transitions from being full to being able
-	 * to handle a message of size "pending_send_sz".
+	 * WS2012/Win8 and later versions of Hyper-V implement interrupt
+	 * driven flow management. The feature bit feat_pending_send_sz
+	 * is set by the host on the host->guest ring buffer, and by the
+	 * guest on the guest->host ring buffer.
 	 *
-	 * Add necessary state for this enhancement.
+	 * The meaning of the feature bit is a bit complex in that it has
+	 * semantics that apply to both ring buffers.  If the guest sets
+	 * the feature bit in the guest->host ring buffer, the guest is
+	 * telling the host that:
+	 * 1) It will set the pending_send_sz field in the guest->host ring
+	 *    buffer when it is waiting for space to become available, and
+	 * 2) It will read the pending_send_sz field in the host->guest
+	 *    ring buffer and interrupt the host when it frees enough space
+	 *
+	 * Similarly, if the host sets the feature bit in the host->guest
+	 * ring buffer, the host is telling the guest that:
+	 * 1) It will set the pending_send_sz field in the host->guest ring
+	 *    buffer when it is waiting for space to become available, and
+	 * 2) It will read the pending_send_sz field in the guest->host
+	 *    ring buffer and interrupt the guest when it frees enough space
+	 *
+	 * If either the guest or host does not set the feature bit that it
+	 * owns, that guest or host must do polling if it encounters a full
+	 * ring buffer, and not signal the other end with an interrupt.
 	 */
 	u32 pending_send_sz;
-
 	u32 reserved1[12];
-
 	union {
 		struct {
 			u32 feat_pending_send_sz:1;
-- 
2.17.1
