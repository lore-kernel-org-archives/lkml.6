Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeEPIjz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:39:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:30628 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752449AbeEPIhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:37:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41347781"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [RFC v4 4/5] virtio_ring: add event idx support in packed ring
Date: Wed, 16 May 2018 16:37:36 +0800
Message-Id: <20180516083737.26504-5-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516083737.26504-1-tiwei.bie@intel.com>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the event idx support in
packed ring.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 75 +++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c6c5deb0e3ae..de3839f3621a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1006,7 +1006,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 flags;
+	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
 	bool needs_kick;
 	u32 snapshot;
 
@@ -1015,9 +1015,19 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
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
+	if (wrap_counter != vq->wrap_counter)
+		event_idx -= vq->vring_packed.num;
+
 #ifdef DEBUG
 	if (vq->last_add_time_valid) {
 		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
@@ -1026,7 +1036,10 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
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
@@ -1098,7 +1111,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 					  void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 last_used, id;
+	u16 wrap_counter, last_used, id;
 	void *ret;
 
 	START_USE(vq);
@@ -1138,6 +1151,19 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	ret = vq->desc_state[id].data;
 	detach_buf_packed(vq, last_used, id, ctx);
 
+	wrap_counter = vq->wrap_counter;
+	if (vq->last_used_idx > vq->next_avail_idx)
+		wrap_counter ^= 1;
+
+	/* If we expect an interrupt for the next entry, tell host
+	 * by writing event index and flush out the write before
+	 * the read in the next get_buf call. */
+	if (vq->event_flags_shadow == VRING_EVENT_F_DESC)
+		virtio_store_mb(vq->weak_barriers,
+				&vq->vring_packed.driver->off_wrap,
+				cpu_to_virtio16(_vq->vdev, vq->last_used_idx |
+						(wrap_counter << 15)));
+
 #ifdef DEBUG
 	vq->last_add_time_valid = false;
 #endif
@@ -1160,15 +1186,27 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 wrap_counter;
 
 	START_USE(vq);
 
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
+	 * either clear the flags bit or point the event index at the next
+	 * entry. Always update the event index to keep code simple. */
+
+	wrap_counter = vq->wrap_counter;
+	if (vq->last_used_idx > vq->next_avail_idx)
+		wrap_counter ^= 1;
+
+	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
+			vq->last_used_idx | (wrap_counter << 15));
 
 	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
 		virtio_wmb(vq->weak_barriers);
-		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
+		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
+						     VRING_EVENT_F_ENABLE;
 		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
 							vq->event_flags_shadow);
 	}
@@ -1194,15 +1232,40 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
 static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 bufs, used_idx, wrap_counter;
 
 	START_USE(vq);
 
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
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
+	wrap_counter = vq->wrap_counter;
+	if (vq->last_used_idx > vq->next_avail_idx)
+		wrap_counter ^= 1;
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
 		virtio_wmb(vq->weak_barriers);
-		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
+		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
+						     VRING_EVENT_F_ENABLE;
 		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
 							vq->event_flags_shadow);
 	}
@@ -1869,8 +1932,10 @@ void vring_transport_features(struct virtio_device *vdev)
 		switch (i) {
 		case VIRTIO_RING_F_INDIRECT_DESC:
 			break;
+#if 0
 		case VIRTIO_RING_F_EVENT_IDX:
 			break;
+#endif
 		case VIRTIO_F_VERSION_1:
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
-- 
2.17.0
