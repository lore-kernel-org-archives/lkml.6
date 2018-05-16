Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeEPIhn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:37:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:30627 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752443AbeEPIhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:37:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41347774"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [RFC v4 3/5] virtio_ring: add packed ring support
Date: Wed, 16 May 2018 16:37:35 +0800
Message-Id: <20180516083737.26504-4-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516083737.26504-1-tiwei.bie@intel.com>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the basic support (without EVENT_IDX)
for packed ring.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 491 ++++++++++++++++++++++++++++++++++-
 1 file changed, 481 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 62d7c407841a..c6c5deb0e3ae 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -58,7 +58,8 @@
 
 struct vring_desc_state {
 	void *data;			/* Data for callback. */
-	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	void *indir_desc;		/* Indirect descriptor, if any. */
+	int num;			/* Descriptor list length. */
 };
 
 struct vring_virtqueue {
@@ -116,6 +117,9 @@ struct vring_virtqueue {
 			/* Last written value to driver->flags in
 			 * guest byte order. */
 			u16 event_flags_shadow;
+
+			/* ID allocation. */
+			struct idr buffer_id;
 		};
 	};
 
@@ -142,6 +146,16 @@ struct vring_virtqueue {
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
+static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
+					  unsigned int total_sg)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	/* If the host supports indirect descriptor tables, and we have multiple
+	 * buffers, then go indirect. FIXME: tune this threshold */
+	return (vq->indirect && total_sg > 1 && vq->vq.num_free);
+}
+
 /*
  * Modern virtio devices have feature bits to specify whether they need a
  * quirk and bypass the IOMMU. If not there, just use the DMA API.
@@ -327,9 +341,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	head = vq->free_head;
 
-	/* If the host supports indirect descriptor tables, and we have multiple
-	 * buffers, then go indirect. FIXME: tune this threshold */
-	if (vq->indirect && total_sg > 1 && vq->vq.num_free)
+	if (virtqueue_use_indirect(_vq, total_sg))
 		desc = alloc_indirect_split(_vq, total_sg, gfp);
 	else {
 		desc = NULL;
@@ -741,6 +753,63 @@ static inline unsigned vring_size_packed(unsigned int num, unsigned long align)
 		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
 }
 
+static void vring_unmap_one_packed(const struct vring_virtqueue *vq,
+				   struct vring_packed_desc *desc)
+{
+	u16 flags;
+
+	if (!vring_use_dma_api(vq->vq.vdev))
+		return;
+
+	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
+
+	if (flags & VRING_DESC_F_INDIRECT) {
+		dma_unmap_single(vring_dma_dev(vq),
+				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
+				 virtio32_to_cpu(vq->vq.vdev, desc->len),
+				 (flags & VRING_DESC_F_WRITE) ?
+				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	} else {
+		dma_unmap_page(vring_dma_dev(vq),
+			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
+			       virtio32_to_cpu(vq->vq.vdev, desc->len),
+			       (flags & VRING_DESC_F_WRITE) ?
+			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	}
+}
+
+static struct vring_packed_desc *alloc_indirect_packed(struct virtqueue *_vq,
+						       unsigned int total_sg,
+						       gfp_t gfp)
+{
+	struct vring_packed_desc *desc;
+
+	/*
+	 * We require lowmem mappings for the descriptors because
+	 * otherwise virt_to_phys will give us bogus addresses in the
+	 * virtqueue.
+	 */
+	gfp &= ~__GFP_HIGHMEM;
+
+	desc = kmalloc(total_sg * sizeof(struct vring_packed_desc), gfp);
+
+	return desc;
+}
+
+static u16 alloc_id_packed(struct vring_virtqueue *vq)
+{
+	u16 id;
+
+	id = idr_alloc(&vq->buffer_id, NULL, 0, vq->vring_packed.num,
+		       GFP_KERNEL);
+	return id;
+}
+
+static void free_id_packed(struct vring_virtqueue *vq, u16 id)
+{
+	idr_remove(&vq->buffer_id, id);
+}
+
 static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       struct scatterlist *sgs[],
 				       unsigned int total_sg,
@@ -750,47 +819,446 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       void *ctx,
 				       gfp_t gfp)
 {
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_packed_desc *desc;
+	struct scatterlist *sg;
+	unsigned int i, n, descs_used, uninitialized_var(prev), err_idx;
+	__virtio16 uninitialized_var(head_flags), flags;
+	u16 head, wrap_counter, id;
+	bool indirect;
+
+	START_USE(vq);
+
+	BUG_ON(data == NULL);
+	BUG_ON(ctx && vq->indirect);
+
+	if (unlikely(vq->broken)) {
+		END_USE(vq);
+		return -EIO;
+	}
+
+#ifdef DEBUG
+	{
+		ktime_t now = ktime_get();
+
+		/* No kick or get, with .1 second between?  Warn. */
+		if (vq->last_add_time_valid)
+			WARN_ON(ktime_to_ms(ktime_sub(now, vq->last_add_time))
+					    > 100);
+		vq->last_add_time = now;
+		vq->last_add_time_valid = true;
+	}
+#endif
+
+	BUG_ON(total_sg == 0);
+
+	head = vq->next_avail_idx;
+	wrap_counter = vq->wrap_counter;
+
+	if (virtqueue_use_indirect(_vq, total_sg))
+		desc = alloc_indirect_packed(_vq, total_sg, gfp);
+	else {
+		desc = NULL;
+		WARN_ON_ONCE(total_sg > vq->vring_packed.num && !vq->indirect);
+	}
+
+	if (desc) {
+		/* Use a single buffer which doesn't continue */
+		indirect = true;
+		/* Set up rest to use this indirect table. */
+		i = 0;
+		descs_used = 1;
+	} else {
+		indirect = false;
+		desc = vq->vring_packed.desc;
+		i = head;
+		descs_used = total_sg;
+	}
+
+	if (vq->vq.num_free < descs_used) {
+		pr_debug("Can't add buf len %i - avail = %i\n",
+			 descs_used, vq->vq.num_free);
+		/* FIXME: for historical reasons, we force a notify here if
+		 * there are outgoing parts to the buffer.  Presumably the
+		 * host should service the ring ASAP. */
+		if (out_sgs)
+			vq->notify(&vq->vq);
+		if (indirect)
+			kfree(desc);
+		END_USE(vq);
+		return -ENOSPC;
+	}
+
+	id = alloc_id_packed(vq);
+
+	for (n = 0; n < out_sgs + in_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
+					       DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			if (vring_mapping_error(vq, addr))
+				goto unmap_release;
+
+			flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT |
+					(n < out_sgs ? 0 : VRING_DESC_F_WRITE) |
+					VRING_DESC_F_AVAIL(vq->wrap_counter) |
+					VRING_DESC_F_USED(!vq->wrap_counter));
+			if (!indirect && i == head)
+				head_flags = flags;
+			else
+				desc[i].flags = flags;
+
+			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
+			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
+			i++;
+			if (!indirect && i >= vq->vring_packed.num) {
+				i = 0;
+				vq->wrap_counter ^= 1;
+			}
+		}
+	}
+
+	prev = (i > 0 ? i : vq->vring_packed.num) - 1;
+	desc[prev].id = cpu_to_virtio16(_vq->vdev, id);
+
+	/* Last one doesn't continue. */
+	if (total_sg == 1)
+		head_flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
+	else
+		desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
+						~VRING_DESC_F_NEXT);
+
+	if (indirect) {
+		/* Now that the indirect table is filled in, map it. */
+		dma_addr_t addr = vring_map_single(
+			vq, desc, total_sg * sizeof(struct vring_packed_desc),
+			DMA_TO_DEVICE);
+		if (vring_mapping_error(vq, addr))
+			goto unmap_release;
+
+		head_flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT |
+					     VRING_DESC_F_AVAIL(wrap_counter) |
+					     VRING_DESC_F_USED(!wrap_counter));
+		vq->vring_packed.desc[head].addr = cpu_to_virtio64(_vq->vdev,
+								   addr);
+		vq->vring_packed.desc[head].len = cpu_to_virtio32(_vq->vdev,
+				total_sg * sizeof(struct vring_packed_desc));
+		vq->vring_packed.desc[head].id = cpu_to_virtio16(_vq->vdev, id);
+	}
+
+	/* We're using some buffers from the free list. */
+	vq->vq.num_free -= descs_used;
+
+	/* Update free pointer */
+	if (indirect) {
+		n = head + 1;
+		if (n >= vq->vring_packed.num) {
+			n = 0;
+			vq->wrap_counter ^= 1;
+		}
+		vq->next_avail_idx = n;
+	} else
+		vq->next_avail_idx = i;
+
+	/* Store token and indirect buffer state. */
+	vq->desc_state[id].num = descs_used;
+	vq->desc_state[id].data = data;
+	if (indirect)
+		vq->desc_state[id].indir_desc = desc;
+	else
+		vq->desc_state[id].indir_desc = ctx;
+
+	/* A driver MUST NOT make the first descriptor in the list
+	 * available before all subsequent descriptors comprising
+	 * the list are made available. */
+	virtio_wmb(vq->weak_barriers);
+	vq->vring_packed.desc[head].flags = head_flags;
+	vq->num_added += descs_used;
+
+	pr_debug("Added buffer head %i to %p\n", head, vq);
+	END_USE(vq);
+
+	return 0;
+
+unmap_release:
+	err_idx = i;
+	i = head;
+
+	for (n = 0; n < total_sg; n++) {
+		if (i == err_idx)
+			break;
+		vring_unmap_one_packed(vq, &desc[i]);
+		i++;
+		if (!indirect && i >= vq->vring_packed.num)
+			i = 0;
+	}
+
+	vq->wrap_counter = wrap_counter;
+
+	if (indirect)
+		kfree(desc);
+
+	free_id_packed(vq, id);
+
+	END_USE(vq);
 	return -EIO;
 }
 
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
-	return false;
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 flags;
+	bool needs_kick;
+	u32 snapshot;
+
+	START_USE(vq);
+	/* We need to expose the new flags value before checking notification
+	 * suppressions. */
+	virtio_mb(vq->weak_barriers);
+
+	snapshot = *(u32 *)vq->vring_packed.device;
+	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
+
+#ifdef DEBUG
+	if (vq->last_add_time_valid) {
+		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
+					      vq->last_add_time)) > 100);
+	}
+	vq->last_add_time_valid = false;
+#endif
+
+	needs_kick = (flags != VRING_EVENT_F_DISABLE);
+	END_USE(vq);
+	return needs_kick;
+}
+
+static void detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
+			      unsigned int id, void **ctx)
+{
+	struct vring_packed_desc *desc;
+	unsigned int i, j;
+
+	/* Clear data ptr. */
+	vq->desc_state[id].data = NULL;
+
+	i = head;
+
+	for (j = 0; j < vq->desc_state[id].num; j++) {
+		desc = &vq->vring_packed.desc[i];
+		vring_unmap_one_packed(vq, desc);
+		i++;
+		if (i >= vq->vring_packed.num)
+			i = 0;
+	}
+
+	vq->vq.num_free += vq->desc_state[id].num;
+
+	if (vq->indirect) {
+		u32 len;
+
+		/* Free the indirect table, if any, now that it's unmapped. */
+		desc = vq->desc_state[id].indir_desc;
+		if (!desc)
+			goto out;
+
+		len = virtio32_to_cpu(vq->vq.vdev,
+				      vq->vring_packed.desc[head].len);
+
+		for (j = 0; j < len / sizeof(struct vring_packed_desc); j++)
+			vring_unmap_one_packed(vq, &desc[j]);
+
+		kfree(desc);
+		vq->desc_state[id].indir_desc = NULL;
+	} else if (ctx) {
+		*ctx = vq->desc_state[id].indir_desc;
+	}
+
+out:
+	free_id_packed(vq, id);
 }
 
 static inline bool more_used_packed(const struct vring_virtqueue *vq)
 {
-	return false;
+	u16 last_used, flags;
+	bool avail, used;
+
+	if (vq->vq.num_free == vq->vring_packed.num)
+		return false;
+
+	last_used = vq->last_used_idx;
+	flags = virtio16_to_cpu(vq->vq.vdev,
+				vq->vring_packed.desc[last_used].flags);
+	avail = flags & VRING_DESC_F_AVAIL(1);
+	used = flags & VRING_DESC_F_USED(1);
+
+	return avail == used;
 }
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 					  unsigned int *len,
 					  void **ctx)
 {
-	return NULL;
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 last_used, id;
+	void *ret;
+
+	START_USE(vq);
+
+	if (unlikely(vq->broken)) {
+		END_USE(vq);
+		return NULL;
+	}
+
+	if (!more_used_packed(vq)) {
+		pr_debug("No more buffers in queue\n");
+		END_USE(vq);
+		return NULL;
+	}
+
+	/* Only get used elements after they have been exposed by host. */
+	virtio_rmb(vq->weak_barriers);
+
+	last_used = vq->last_used_idx;
+	id = virtio16_to_cpu(_vq->vdev, vq->vring_packed.desc[last_used].id);
+	*len = virtio32_to_cpu(_vq->vdev, vq->vring_packed.desc[last_used].len);
+
+	if (unlikely(id >= vq->vring_packed.num)) {
+		BAD_RING(vq, "id %u out of range\n", id);
+		return NULL;
+	}
+	if (unlikely(!vq->desc_state[id].data)) {
+		BAD_RING(vq, "id %u is not a head!\n", id);
+		return NULL;
+	}
+
+	vq->last_used_idx += vq->desc_state[id].num;
+	if (vq->last_used_idx >= vq->vring_packed.num)
+		vq->last_used_idx -= vq->vring_packed.num;
+
+	/* detach_buf_packed clears data, so grab it now. */
+	ret = vq->desc_state[id].data;
+	detach_buf_packed(vq, last_used, id, ctx);
+
+#ifdef DEBUG
+	vq->last_add_time_valid = false;
+#endif
+
+	END_USE(vq);
+	return ret;
 }
 
 static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 {
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (vq->event_flags_shadow != VRING_EVENT_F_DISABLE) {
+		vq->event_flags_shadow = VRING_EVENT_F_DISABLE;
+		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
+							vq->event_flags_shadow);
+	}
 }
 
 static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 {
-	return 0;
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	START_USE(vq);
+
+	/* We optimistically turn back on interrupts, then check if there was
+	 * more to do. */
+
+	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
+		virtio_wmb(vq->weak_barriers);
+		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
+		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
+							vq->event_flags_shadow);
+	}
+
+	END_USE(vq);
+	return vq->last_used_idx;
 }
 
 static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
 {
-	return false;
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	bool avail, used;
+	u16 flags;
+
+	virtio_mb(vq->weak_barriers);
+	flags = virtio16_to_cpu(vq->vq.vdev,
+			vq->vring_packed.desc[last_used_idx].flags);
+	avail = flags & VRING_DESC_F_AVAIL(1);
+	used = flags & VRING_DESC_F_USED(1);
+	return avail == used;
 }
 
 static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 {
-	return false;
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	START_USE(vq);
+
+	/* We optimistically turn back on interrupts, then check if there was
+	 * more to do. */
+
+	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
+		virtio_wmb(vq->weak_barriers);
+		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
+		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
+							vq->event_flags_shadow);
+	}
+
+	if (more_used_packed(vq)) {
+		END_USE(vq);
+		return false;
+	}
+
+	END_USE(vq);
+	return true;
 }
 
 static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 {
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 flags, head, id, i;
+	unsigned int len;
+	void *buf;
+
+	START_USE(vq);
+
+	/* Detach the used descriptors. */
+	if (more_used_packed(vq)) {
+		buf = virtqueue_get_buf_ctx_packed(_vq, &len, NULL);
+		END_USE(vq);
+		return buf;
+	}
+
+	/* Detach the available descriptors. */
+	for (i = vq->last_used_idx; i != vq->next_avail_idx;
+			i = (i + 1) % vq->vring_packed.num) {
+		flags = virtio16_to_cpu(vq->vq.vdev,
+				vq->vring_packed.desc[i].flags);
+		while (flags & VRING_DESC_F_NEXT) {
+			i = (i + 1) % vq->vring_packed.num;
+			flags = virtio16_to_cpu(vq->vq.vdev,
+					vq->vring_packed.desc[i].flags);
+		}
+		id = virtio16_to_cpu(_vq->vdev, vq->vring_packed.desc[i].id);
+		if (!vq->desc_state[id].data)
+			continue;
+
+		len = vq->desc_state[id].num - 1;
+		head = (i < len ? i + vq->vring_packed.num : i) - len;
+
+		/* detach_buf clears data, so grab it now. */
+		buf = vq->desc_state[id].data;
+		detach_buf_packed(vq, head, id, NULL);
+		END_USE(vq);
+		return buf;
+	}
+	/* That should have freed everything. */
+	BUG_ON(vq->vq.num_free != vq->vring_packed.num);
+
+	END_USE(vq);
 	return NULL;
 }
 
@@ -1198,6 +1666,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		vq->next_avail_idx = 0;
 		vq->wrap_counter = 1;
 		vq->event_flags_shadow = 0;
+		idr_init(&vq->buffer_id);
 	} else {
 		vq->vring = vring.vring_split;
 		vq->avail_flags_shadow = 0;
@@ -1384,6 +1853,8 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 					      (void *)vq->vring.desc,
 				 vq->queue_dma_addr);
 	}
+	if (vq->packed)
+		idr_destroy(&vq->buffer_id);
 	list_del(&_vq->list);
 	kfree(vq);
 }
-- 
2.17.0
