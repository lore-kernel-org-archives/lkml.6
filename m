Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05533C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85F820684
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85F820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeKUUjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:39:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:14789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbeKUUjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:39:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 02:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="275727111"
Received: from btwcube1.sh.intel.com ([10.67.104.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2018 02:05:46 -0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com
Subject: [PATCH net-next v3 11/13] virtio_ring: leverage event idx in packed ring
Date:   Wed, 21 Nov 2018 18:03:28 +0800
Message-Id: <20181121100330.24846-12-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leverage the EVENT_IDX feature in packed ring to suppress
events when it's available.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 77 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b63eee2034e7..40e4d3798d16 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1222,7 +1222,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 flags;
+	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
 	bool needs_kick;
 	union {
 		struct {
@@ -1240,6 +1240,8 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	 */
 	virtio_mb(vq->weak_barriers);
 
+	old = vq->packed.next_avail_idx - vq->num_added;
+	new = vq->packed.next_avail_idx;
 	vq->num_added = 0;
 
 	snapshot.u32 = *(u32 *)vq->packed.vring.device;
@@ -1248,7 +1250,20 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	LAST_ADD_TIME_CHECK(vq);
 	LAST_ADD_TIME_INVALID(vq);
 
-	needs_kick = (flags != VRING_PACKED_EVENT_FLAG_DISABLE);
+	if (flags != VRING_PACKED_EVENT_FLAG_DESC) {
+		needs_kick = (flags != VRING_PACKED_EVENT_FLAG_DISABLE);
+		goto out;
+	}
+
+	off_wrap = le16_to_cpu(snapshot.off_wrap);
+
+	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
+	event_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+	if (wrap_counter != vq->packed.avail_wrap_counter)
+		event_idx -= vq->packed.vring.num;
+
+	needs_kick = vring_need_event(event_idx, new, old);
+out:
 	END_USE(vq);
 	return needs_kick;
 }
@@ -1365,6 +1380,18 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 		vq->packed.used_wrap_counter ^= 1;
 	}
 
+	/*
+	 * If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call.
+	 */
+	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
+		virtio_store_mb(vq->weak_barriers,
+				&vq->packed.vring.driver->off_wrap,
+				cpu_to_le16(vq->last_used_idx |
+					(vq->packed.used_wrap_counter <<
+					 VRING_PACKED_EVENT_F_WRAP_CTR)));
+
 	LAST_ADD_TIME_INVALID(vq);
 
 	END_USE(vq);
@@ -1393,8 +1420,22 @@ static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	 * more to do.
 	 */
 
+	if (vq->event) {
+		vq->packed.vring.driver->off_wrap =
+			cpu_to_le16(vq->last_used_idx |
+				(vq->packed.used_wrap_counter <<
+				 VRING_PACKED_EVENT_F_WRAP_CTR));
+		/*
+		 * We need to update event offset and event wrap
+		 * counter first before updating event flags.
+		 */
+		virtio_wmb(vq->weak_barriers);
+	}
+
 	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DISABLE) {
-		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_ENABLE;
+		vq->packed.event_flags_shadow = vq->event ?
+				VRING_PACKED_EVENT_FLAG_DESC :
+				VRING_PACKED_EVENT_FLAG_ENABLE;
 		vq->packed.vring.driver->flags =
 				cpu_to_le16(vq->packed.event_flags_shadow);
 	}
@@ -1420,6 +1461,7 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 used_idx, wrap_counter;
+	u16 bufs;
 
 	START_USE(vq);
 
@@ -1428,11 +1470,34 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	 * more to do.
 	 */
 
-	used_idx = vq->last_used_idx;
-	wrap_counter = vq->packed.used_wrap_counter;
+	if (vq->event) {
+		/* TODO: tune this threshold */
+		bufs = (vq->packed.vring.num - vq->vq.num_free) * 3 / 4;
+		wrap_counter = vq->packed.used_wrap_counter;
+
+		used_idx = vq->last_used_idx + bufs;
+		if (used_idx >= vq->packed.vring.num) {
+			used_idx -= vq->packed.vring.num;
+			wrap_counter ^= 1;
+		}
+
+		vq->packed.vring.driver->off_wrap = cpu_to_le16(used_idx |
+			(wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
+
+		/*
+		 * We need to update event offset and event wrap
+		 * counter first before updating event flags.
+		 */
+		virtio_wmb(vq->weak_barriers);
+	} else {
+		used_idx = vq->last_used_idx;
+		wrap_counter = vq->packed.used_wrap_counter;
+	}
 
 	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DISABLE) {
-		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_ENABLE;
+		vq->packed.event_flags_shadow = vq->event ?
+				VRING_PACKED_EVENT_FLAG_DESC :
+				VRING_PACKED_EVENT_FLAG_ENABLE;
 		vq->packed.vring.driver->flags =
 				cpu_to_le16(vq->packed.event_flags_shadow);
 	}
-- 
2.14.5

