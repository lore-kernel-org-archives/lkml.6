Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeFEHlO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:41:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:14303 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbeFEHlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:41:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,478,1520924400";
   d="scan'208";a="56617086"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [RFC v6 4/5] virtio_ring: add event idx support in packed ring
Date: Tue,  5 Jun 2018 15:40:45 +0800
Message-Id: <20180605074046.20709-5-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605074046.20709-1-tiwei.bie@intel.com>
References: <20180605074046.20709-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the EVENT_IDX support in packed ring.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 74 ++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 983ce5ffda1b..aefd7ac40928 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1048,7 +1048,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 flags;
+	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
 	bool needs_kick;
 	u32 snapshot;
 
@@ -1057,9 +1057,19 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	 * suppressions. */
 	virtio_mb(vq->weak_barriers);
 
+	old = vq->next_avail_idx - vq->num_added;
+	new = vq->next_avail_idx;
+	vq->num_added = 0;
+
 	snapshot = *(u32 *)vq->vring_packed.device;
+	off_wrap = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot & 0xffff));
 	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
 
+	wrap_counter = off_wrap >> 15;
+	event_idx = off_wrap & ~(1<<15);
+	if (wrap_counter != vq->avail_wrap_counter)
+		event_idx -= vq->vring_packed.num;
+
 #ifdef DEBUG
 	if (vq->last_add_time_valid) {
 		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
@@ -1068,7 +1078,10 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	vq->last_add_time_valid = false;
 #endif
 
-	needs_kick = (flags != VRING_EVENT_F_DISABLE);
+	if (flags == VRING_EVENT_F_DESC)
+		needs_kick = vring_need_event(event_idx, new, old);
+	else
+		needs_kick = (flags != VRING_EVENT_F_DISABLE);
 	END_USE(vq);
 	return needs_kick;
 }
@@ -1177,6 +1190,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	ret = vq->desc_state_packed[id].data;
 	detach_buf_packed(vq, id, ctx);
 
+	/* If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call. */
+	if (vq->event_flags_shadow == VRING_EVENT_F_DESC)
+		virtio_store_mb(vq->weak_barriers,
+				&vq->vring_packed.driver->off_wrap,
+				cpu_to_virtio16(_vq->vdev, vq->last_used_idx |
+					((u16)vq->used_wrap_counter << 15)));
+
 #ifdef DEBUG
 	vq->last_add_time_valid = false;
 #endif
@@ -1204,9 +1226,20 @@ static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
+	 * either clear the flags bit or point the event index at the next
+	 * entry. Always update the event index to keep code simple. */
+
+	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
+			vq->last_used_idx |
+			((u16)vq->used_wrap_counter << 15));
 
 	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
-		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
+		/* We need to update event offset and event wrap
+		 * counter first before updating event flags. */
+		virtio_wmb(vq->weak_barriers);
+		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
+						     VRING_EVENT_F_ENABLE;
 		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
 							vq->event_flags_shadow);
 	}
@@ -1232,21 +1265,48 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
 static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 bufs, used_idx, wrap_counter;
 
 	START_USE(vq);
 
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
+	 * either clear the flags bit or point the event index at the next
+	 * entry. Always update the event index to keep code simple. */
+
+	/* TODO: tune this threshold */
+	if (vq->next_avail_idx < vq->last_used_idx)
+		bufs = (vq->vring_packed.num + vq->next_avail_idx -
+				vq->last_used_idx) * 3 / 4;
+	else
+		bufs = (vq->next_avail_idx - vq->last_used_idx) * 3 / 4;
+
+	wrap_counter = vq->used_wrap_counter;
+
+	used_idx = vq->last_used_idx + bufs;
+	if (used_idx >= vq->vring_packed.num) {
+		used_idx -= vq->vring_packed.num;
+		wrap_counter ^= 1;
+	}
+
+	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
+			used_idx | (wrap_counter << 15));
 
 	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
-		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
+		/* We need to update event offset and event wrap
+		 * counter first before updating event flags. */
+		virtio_wmb(vq->weak_barriers);
+		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
+						     VRING_EVENT_F_ENABLE;
 		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
 							vq->event_flags_shadow);
-		/* We need to enable interrupts first before re-checking
-		 * for more used buffers. */
-		virtio_mb(vq->weak_barriers);
 	}
 
+	/* We need to update event suppression structure first
+	 * before re-checking for more used buffers. */
+	virtio_mb(vq->weak_barriers);
+
 	if (more_used_packed(vq)) {
 		END_USE(vq);
 		return false;
-- 
2.17.0
