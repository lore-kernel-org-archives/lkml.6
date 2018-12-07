Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E2C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC2A20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC2A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLGIvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:51:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:1705 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeLGIvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:51:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 00:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="96888358"
Received: from btwcube1.sh.intel.com ([10.67.104.173])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2018 00:51:04 -0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com
Subject: [RFC 3/3] virtio_ring: use new vring flags
Date:   Fri,  7 Dec 2018 16:48:42 +0800
Message-Id: <20181207084842.13133-4-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207084842.13133-1-tiwei.bie@intel.com>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the _SPLIT_ and _PACKED_ variants of vring flags
in split ring and packed ring respectively.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 100 +++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cd7e755484e3..2806f69c6c9f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -371,17 +371,17 @@ static void vring_unmap_one_split(const struct vring_virtqueue *vq,
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
-	if (flags & VRING_DESC_F_INDIRECT) {
+	if (flags & BIT(VRING_SPLIT_DESC_F_INDIRECT)) {
 		dma_unmap_single(vring_dma_dev(vq),
 				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
 				 virtio32_to_cpu(vq->vq.vdev, desc->len),
-				 (flags & VRING_DESC_F_WRITE) ?
+				 (flags & BIT(VRING_SPLIT_DESC_F_WRITE)) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
 		dma_unmap_page(vring_dma_dev(vq),
 			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
 			       virtio32_to_cpu(vq->vq.vdev, desc->len),
-			       (flags & VRING_DESC_F_WRITE) ?
+			       (flags & BIT(VRING_SPLIT_DESC_F_WRITE)) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
 }
@@ -481,7 +481,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			if (vring_mapping_error(vq, addr))
 				goto unmap_release;
 
-			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT);
+			desc[i].flags = cpu_to_virtio16(_vq->vdev,
+						BIT(VRING_SPLIT_DESC_F_NEXT));
 			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
 			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
 			prev = i;
@@ -494,7 +495,9 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			if (vring_mapping_error(vq, addr))
 				goto unmap_release;
 
-			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
+			desc[i].flags = cpu_to_virtio16(_vq->vdev,
+						BIT(VRING_SPLIT_DESC_F_NEXT) |
+						BIT(VRING_SPLIT_DESC_F_WRITE));
 			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
 			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
 			prev = i;
@@ -502,7 +505,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		}
 	}
 	/* Last one doesn't continue. */
-	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
+	desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
+				(u16)~BIT(VRING_SPLIT_DESC_F_NEXT));
 
 	if (indirect) {
 		/* Now that the indirect table is filled in, map it. */
@@ -513,7 +517,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			goto unmap_release;
 
 		vq->split.vring.desc[head].flags = cpu_to_virtio16(_vq->vdev,
-				VRING_DESC_F_INDIRECT);
+				BIT(VRING_SPLIT_DESC_F_INDIRECT));
 		vq->split.vring.desc[head].addr = cpu_to_virtio64(_vq->vdev,
 				addr);
 
@@ -603,8 +607,8 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 					      new, old);
 	} else {
 		needs_kick = !(vq->split.vring.used->flags &
-					cpu_to_virtio16(_vq->vdev,
-						VRING_USED_F_NO_NOTIFY));
+				cpu_to_virtio16(_vq->vdev,
+					BIT(VRING_SPLIT_USED_F_NO_NOTIFY)));
 	}
 	END_USE(vq);
 	return needs_kick;
@@ -614,7 +618,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 			     void **ctx)
 {
 	unsigned int i, j;
-	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev,
+				BIT(VRING_SPLIT_DESC_F_NEXT));
 
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
@@ -649,7 +654,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				vq->split.vring.desc[head].len);
 
 		BUG_ON(!(vq->split.vring.desc[head].flags &
-			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
+			 cpu_to_virtio16(vq->vq.vdev,
+				 BIT(VRING_SPLIT_DESC_F_INDIRECT))));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
 		for (j = 0; j < len / sizeof(struct vring_desc); j++)
@@ -715,7 +721,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
-	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
+	if (!(vq->split.avail_flags_shadow &
+			BIT(VRING_SPLIT_AVAIL_F_NO_INTERRUPT)))
 		virtio_store_mb(vq->weak_barriers,
 				&vring_used_event(&vq->split.vring),
 				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
@@ -730,8 +737,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
-		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+	if (!(vq->split.avail_flags_shadow &
+			BIT(VRING_SPLIT_AVAIL_F_NO_INTERRUPT))) {
+		vq->split.avail_flags_shadow |=
+			BIT(VRING_SPLIT_AVAIL_F_NO_INTERRUPT);
 		if (!vq->event)
 			vq->split.vring.avail->flags =
 				cpu_to_virtio16(_vq->vdev,
@@ -751,8 +760,10 @@ static unsigned virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
 	 * entry. Always do both to keep code simple. */
-	if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
-		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
+	if (vq->split.avail_flags_shadow &
+			BIT(VRING_SPLIT_AVAIL_F_NO_INTERRUPT)) {
+		vq->split.avail_flags_shadow &=
+			~BIT(VRING_SPLIT_AVAIL_F_NO_INTERRUPT);
 		if (!vq->event)
 			vq->split.vring.avail->flags =
 				cpu_to_virtio16(_vq->vdev,
@@ -784,8 +795,10 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
 	 * entry. Always update the event index to keep code simple. */
-	if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
-		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
+	if (vq->split.avail_flags_shadow &
+			BIT(VRING_SPLIT_AVAIL_F_NO_INTERRUPT)) {
+		vq->split.avail_flags_shadow &=
+			~BIT(VRING_SPLIT_AVAIL_F_NO_INTERRUPT);
 		if (!vq->event)
 			vq->split.vring.avail->flags =
 				cpu_to_virtio16(_vq->vdev,
@@ -912,15 +925,15 @@ static void vring_unmap_state_packed(const struct vring_virtqueue *vq,
 
 	flags = state->flags;
 
-	if (flags & VRING_DESC_F_INDIRECT) {
+	if (flags & BIT(VRING_PACKED_DESC_F_INDIRECT)) {
 		dma_unmap_single(vring_dma_dev(vq),
 				 state->addr, state->len,
-				 (flags & VRING_DESC_F_WRITE) ?
+				 (flags & BIT(VRING_PACKED_DESC_F_WRITE)) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
 		dma_unmap_page(vring_dma_dev(vq),
 			       state->addr, state->len,
-			       (flags & VRING_DESC_F_WRITE) ?
+			       (flags & BIT(VRING_PACKED_DESC_F_WRITE)) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
 }
@@ -935,17 +948,17 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 
 	flags = le16_to_cpu(desc->flags);
 
-	if (flags & VRING_DESC_F_INDIRECT) {
+	if (flags & BIT(VRING_PACKED_DESC_F_INDIRECT)) {
 		dma_unmap_single(vring_dma_dev(vq),
 				 le64_to_cpu(desc->addr),
 				 le32_to_cpu(desc->len),
-				 (flags & VRING_DESC_F_WRITE) ?
+				 (flags & BIT(VRING_PACKED_DESC_F_WRITE)) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
 		dma_unmap_page(vring_dma_dev(vq),
 			       le64_to_cpu(desc->addr),
 			       le32_to_cpu(desc->len),
-			       (flags & VRING_DESC_F_WRITE) ?
+			       (flags & BIT(VRING_PACKED_DESC_F_WRITE)) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
 }
@@ -1002,7 +1015,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				goto unmap_release;
 
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
-						0 : VRING_DESC_F_WRITE);
+					0 : BIT(VRING_PACKED_DESC_F_WRITE));
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(sg->length);
 			i++;
@@ -1025,8 +1038,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		vq->packed.desc_extra[id].addr = addr;
 		vq->packed.desc_extra[id].len = total_sg *
 				sizeof(struct vring_packed_desc);
-		vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
-						  vq->packed.avail_used_flags;
+		vq->packed.desc_extra[id].flags =
+				BIT(VRING_PACKED_DESC_F_INDIRECT) |
+				vq->packed.avail_used_flags;
 	}
 
 	/*
@@ -1035,8 +1049,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	 * the list are made available.
 	 */
 	virtio_wmb(vq->weak_barriers);
-	vq->packed.vring.desc[head].flags = cpu_to_le16(VRING_DESC_F_INDIRECT |
-						vq->packed.avail_used_flags);
+	vq->packed.vring.desc[head].flags =
+		cpu_to_le16(BIT(VRING_PACKED_DESC_F_INDIRECT) |
+			    vq->packed.avail_used_flags);
 
 	/* We're using some buffers from the free list. */
 	vq->vq.num_free -= 1;
@@ -1047,8 +1062,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		n = 0;
 		vq->packed.avail_wrap_counter ^= 1;
 		vq->packed.avail_used_flags ^=
-				1 << VRING_PACKED_DESC_F_AVAIL |
-				1 << VRING_PACKED_DESC_F_USED;
+				BIT(VRING_PACKED_DESC_F_AVAIL) |
+				BIT(VRING_PACKED_DESC_F_USED);
 	}
 	vq->packed.next_avail_idx = n;
 	vq->free_head = vq->packed.desc_state[id].next;
@@ -1141,8 +1156,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				goto unmap_release;
 
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
-				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
-				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
+				    (++c == total_sg ? 0 :
+					BIT(VRING_PACKED_DESC_F_NEXT)) |
+				    (n < out_sgs ? 0 :
+					BIT(VRING_PACKED_DESC_F_WRITE)));
 			if (i == head)
 				head_flags = flags;
 			else
@@ -1164,8 +1181,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			if ((unlikely(++i >= vq->packed.vring.num))) {
 				i = 0;
 				vq->packed.avail_used_flags ^=
-					1 << VRING_PACKED_DESC_F_AVAIL |
-					1 << VRING_PACKED_DESC_F_USED;
+					BIT(VRING_PACKED_DESC_F_AVAIL) |
+					BIT(VRING_PACKED_DESC_F_USED);
 			}
 		}
 	}
@@ -1258,7 +1275,7 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	off_wrap = le16_to_cpu(snapshot.off_wrap);
 
 	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
-	event_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+	event_idx = off_wrap & ~BIT(VRING_PACKED_EVENT_F_WRAP_CTR);
 	if (wrap_counter != vq->packed.avail_wrap_counter)
 		event_idx -= vq->packed.vring.num;
 
@@ -1321,8 +1338,8 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	u16 flags;
 
 	flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
-	avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
-	used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
+	avail = !!(flags & BIT(VRING_PACKED_DESC_F_AVAIL));
+	used = !!(flags & BIT(VRING_PACKED_DESC_F_USED));
 
 	return avail == used && used == used_wrap_counter;
 }
@@ -1452,7 +1469,7 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
 	u16 used_idx;
 
 	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
-	used_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+	used_idx = off_wrap & ~BIT(VRING_PACKED_EVENT_F_WRAP_CTR);
 
 	return is_used_desc_packed(vq, used_idx, wrap_counter);
 }
@@ -1625,7 +1642,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed.avail_wrap_counter = 1;
 	vq->packed.used_wrap_counter = 1;
 	vq->packed.event_flags_shadow = 0;
-	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
+	vq->packed.avail_used_flags = BIT(VRING_PACKED_DESC_F_AVAIL);
 
 	vq->packed.desc_state = kmalloc_array(num,
 			sizeof(struct vring_desc_state_packed),
@@ -2088,7 +2105,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
-		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+		vq->split.avail_flags_shadow |=
+			BIT(VRING_SPLIT_AVAIL_F_NO_INTERRUPT);
 		if (!vq->event)
 			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
 					vq->split.avail_flags_shadow);
-- 
2.17.1

