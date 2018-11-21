Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F723C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2073720684
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2073720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeKUUjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:39:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:14789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbeKUUjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:39:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 02:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="275727035"
Received: from btwcube1.sh.intel.com ([10.67.104.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2018 02:05:28 -0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com
Subject: [PATCH net-next v3 03/13] virtio_ring: put split ring functions together
Date:   Wed, 21 Nov 2018 18:03:20 +0800
Message-Id: <20181121100330.24846-4-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the xxx_split() functions together to make the
code more readable and avoid misuse after introducing
the packed ring. There is no functional change.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 587 ++++++++++++++++++++++---------------------
 1 file changed, 302 insertions(+), 285 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 29fab2fb39cb..7cd40a2a0d21 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -113,6 +113,11 @@ struct vring_virtqueue {
 	struct vring_desc_state desc_state[];
 };
 
+
+/*
+ * Helpers.
+ */
+
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
 /*
@@ -200,6 +205,20 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
 			      cpu_addr, size, direction);
 }
 
+static int vring_mapping_error(const struct vring_virtqueue *vq,
+			       dma_addr_t addr)
+{
+	if (!vring_use_dma_api(vq->vq.vdev))
+		return 0;
+
+	return dma_mapping_error(vring_dma_dev(vq), addr);
+}
+
+
+/*
+ * Split ring specific functions - *_split().
+ */
+
 static void vring_unmap_one_split(const struct vring_virtqueue *vq,
 				  struct vring_desc *desc)
 {
@@ -225,15 +244,6 @@ static void vring_unmap_one_split(const struct vring_virtqueue *vq,
 	}
 }
 
-static int vring_mapping_error(const struct vring_virtqueue *vq,
-			       dma_addr_t addr)
-{
-	if (!vring_use_dma_api(vq->vq.vdev))
-		return 0;
-
-	return dma_mapping_error(vring_dma_dev(vq), addr);
-}
-
 static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 					       unsigned int total_sg,
 					       gfp_t gfp)
@@ -435,121 +445,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return -EIO;
 }
 
-static inline int virtqueue_add(struct virtqueue *_vq,
-				struct scatterlist *sgs[],
-				unsigned int total_sg,
-				unsigned int out_sgs,
-				unsigned int in_sgs,
-				void *data,
-				void *ctx,
-				gfp_t gfp)
-{
-	return virtqueue_add_split(_vq, sgs, total_sg,
-				   out_sgs, in_sgs, data, ctx, gfp);
-}
-
-/**
- * virtqueue_add_sgs - expose buffers to other end
- * @vq: the struct virtqueue we're talking about.
- * @sgs: array of terminated scatterlists.
- * @out_num: the number of scatterlists readable by other side
- * @in_num: the number of scatterlists which are writable (after readable ones)
- * @data: the token identifying the buffer.
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
- */
-int virtqueue_add_sgs(struct virtqueue *_vq,
-		      struct scatterlist *sgs[],
-		      unsigned int out_sgs,
-		      unsigned int in_sgs,
-		      void *data,
-		      gfp_t gfp)
-{
-	unsigned int i, total_sg = 0;
-
-	/* Count them first. */
-	for (i = 0; i < out_sgs + in_sgs; i++) {
-		struct scatterlist *sg;
-		for (sg = sgs[i]; sg; sg = sg_next(sg))
-			total_sg++;
-	}
-	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
-			     data, NULL, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
-
-/**
- * virtqueue_add_outbuf - expose output buffers to other end
- * @vq: the struct virtqueue we're talking about.
- * @sg: scatterlist (must be well-formed and terminated!)
- * @num: the number of entries in @sg readable by other side
- * @data: the token identifying the buffer.
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
- */
-int virtqueue_add_outbuf(struct virtqueue *vq,
-			 struct scatterlist *sg, unsigned int num,
-			 void *data,
-			 gfp_t gfp)
-{
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
-
-/**
- * virtqueue_add_inbuf - expose input buffers to other end
- * @vq: the struct virtqueue we're talking about.
- * @sg: scatterlist (must be well-formed and terminated!)
- * @num: the number of entries in @sg writable by other side
- * @data: the token identifying the buffer.
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
- */
-int virtqueue_add_inbuf(struct virtqueue *vq,
-			struct scatterlist *sg, unsigned int num,
-			void *data,
-			gfp_t gfp)
-{
-	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
-
-/**
- * virtqueue_add_inbuf_ctx - expose input buffers to other end
- * @vq: the struct virtqueue we're talking about.
- * @sg: scatterlist (must be well-formed and terminated!)
- * @num: the number of entries in @sg writable by other side
- * @data: the token identifying the buffer.
- * @ctx: extra context for the token
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
- */
-int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
-			struct scatterlist *sg, unsigned int num,
-			void *data,
-			void *ctx,
-			gfp_t gfp)
-{
-	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
-
 static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -583,67 +478,6 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	return needs_kick;
 }
 
-/**
- * virtqueue_kick_prepare - first half of split virtqueue_kick call.
- * @vq: the struct virtqueue
- *
- * Instead of virtqueue_kick(), you can do:
- *	if (virtqueue_kick_prepare(vq))
- *		virtqueue_notify(vq);
- *
- * This is sometimes useful because the virtqueue_kick_prepare() needs
- * to be serialized, but the actual virtqueue_notify() call does not.
- */
-bool virtqueue_kick_prepare(struct virtqueue *_vq)
-{
-	return virtqueue_kick_prepare_split(_vq);
-}
-EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
-
-/**
- * virtqueue_notify - second half of split virtqueue_kick call.
- * @vq: the struct virtqueue
- *
- * This does not need to be serialized.
- *
- * Returns false if host notify failed or queue is broken, otherwise true.
- */
-bool virtqueue_notify(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	if (unlikely(vq->broken))
-		return false;
-
-	/* Prod other side to tell it about changes. */
-	if (!vq->notify(_vq)) {
-		vq->broken = true;
-		return false;
-	}
-	return true;
-}
-EXPORT_SYMBOL_GPL(virtqueue_notify);
-
-/**
- * virtqueue_kick - update after add_buf
- * @vq: the struct virtqueue
- *
- * After one or more virtqueue_add_* calls, invoke this to kick
- * the other side.
- *
- * Caller must ensure we don't call this with other virtqueue
- * operations at the same time (except where noted).
- *
- * Returns false if kick failed, otherwise true.
- */
-bool virtqueue_kick(struct virtqueue *vq)
-{
-	if (virtqueue_kick_prepare(vq))
-		return virtqueue_notify(vq);
-	return true;
-}
-EXPORT_SYMBOL_GPL(virtqueue_kick);
-
 static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 			     void **ctx)
 {
@@ -756,6 +590,288 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	return ret;
 }
 
+static void virtqueue_disable_cb_split(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
+		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
+	}
+}
+
+static unsigned virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 last_used_idx;
+
+	START_USE(vq);
+
+	/* We optimistically turn back on interrupts, then check if there was
+	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
+	 * either clear the flags bit or point the event index at the next
+	 * entry. Always do both to keep code simple. */
+	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
+		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
+	}
+	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, last_used_idx = vq->last_used_idx);
+	END_USE(vq);
+	return last_used_idx;
+}
+
+static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned last_used_idx)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
+			vq->vring.used->idx);
+}
+
+static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	u16 bufs;
+
+	START_USE(vq);
+
+	/* We optimistically turn back on interrupts, then check if there was
+	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
+	 * either clear the flags bit or point the event index at the next
+	 * entry. Always update the event index to keep code simple. */
+	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
+		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
+		if (!vq->event)
+			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
+	}
+	/* TODO: tune this threshold */
+	bufs = (u16)(vq->avail_idx_shadow - vq->last_used_idx) * 3 / 4;
+
+	virtio_store_mb(vq->weak_barriers,
+			&vring_used_event(&vq->vring),
+			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
+
+	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->vring.used->idx) - vq->last_used_idx) > bufs)) {
+		END_USE(vq);
+		return false;
+	}
+
+	END_USE(vq);
+	return true;
+}
+
+static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	unsigned int i;
+	void *buf;
+
+	START_USE(vq);
+
+	for (i = 0; i < vq->vring.num; i++) {
+		if (!vq->desc_state[i].data)
+			continue;
+		/* detach_buf_split clears data, so grab it now. */
+		buf = vq->desc_state[i].data;
+		detach_buf_split(vq, i, NULL);
+		vq->avail_idx_shadow--;
+		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
+		END_USE(vq);
+		return buf;
+	}
+	/* That should have freed everything. */
+	BUG_ON(vq->vq.num_free != vq->vring.num);
+
+	END_USE(vq);
+	return NULL;
+}
+
+
+/*
+ * Generic functions and exported symbols.
+ */
+
+static inline int virtqueue_add(struct virtqueue *_vq,
+				struct scatterlist *sgs[],
+				unsigned int total_sg,
+				unsigned int out_sgs,
+				unsigned int in_sgs,
+				void *data,
+				void *ctx,
+				gfp_t gfp)
+{
+	return virtqueue_add_split(_vq, sgs, total_sg,
+				   out_sgs, in_sgs, data, ctx, gfp);
+}
+
+/**
+ * virtqueue_add_sgs - expose buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sgs: array of terminated scatterlists.
+ * @out_num: the number of scatterlists readable by other side
+ * @in_num: the number of scatterlists which are writable (after readable ones)
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_sgs(struct virtqueue *_vq,
+		      struct scatterlist *sgs[],
+		      unsigned int out_sgs,
+		      unsigned int in_sgs,
+		      void *data,
+		      gfp_t gfp)
+{
+	unsigned int i, total_sg = 0;
+
+	/* Count them first. */
+	for (i = 0; i < out_sgs + in_sgs; i++) {
+		struct scatterlist *sg;
+
+		for (sg = sgs[i]; sg; sg = sg_next(sg))
+			total_sg++;
+	}
+	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
+			     data, NULL, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
+
+/**
+ * virtqueue_add_outbuf - expose output buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg readable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_outbuf(struct virtqueue *vq,
+			 struct scatterlist *sg, unsigned int num,
+			 void *data,
+			 gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
+
+/**
+ * virtqueue_add_inbuf - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf(struct virtqueue *vq,
+			struct scatterlist *sg, unsigned int num,
+			void *data,
+			gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
+
+/**
+ * virtqueue_add_inbuf_ctx - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @ctx: extra context for the token
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
+			struct scatterlist *sg, unsigned int num,
+			void *data,
+			void *ctx,
+			gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
+
+/**
+ * virtqueue_kick_prepare - first half of split virtqueue_kick call.
+ * @vq: the struct virtqueue
+ *
+ * Instead of virtqueue_kick(), you can do:
+ *	if (virtqueue_kick_prepare(vq))
+ *		virtqueue_notify(vq);
+ *
+ * This is sometimes useful because the virtqueue_kick_prepare() needs
+ * to be serialized, but the actual virtqueue_notify() call does not.
+ */
+bool virtqueue_kick_prepare(struct virtqueue *_vq)
+{
+	return virtqueue_kick_prepare_split(_vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
+
+/**
+ * virtqueue_notify - second half of split virtqueue_kick call.
+ * @vq: the struct virtqueue
+ *
+ * This does not need to be serialized.
+ *
+ * Returns false if host notify failed or queue is broken, otherwise true.
+ */
+bool virtqueue_notify(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (unlikely(vq->broken))
+		return false;
+
+	/* Prod other side to tell it about changes. */
+	if (!vq->notify(_vq)) {
+		vq->broken = true;
+		return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(virtqueue_notify);
+
+/**
+ * virtqueue_kick - update after add_buf
+ * @vq: the struct virtqueue
+ *
+ * After one or more virtqueue_add_* calls, invoke this to kick
+ * the other side.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ *
+ * Returns false if kick failed, otherwise true.
+ */
+bool virtqueue_kick(struct virtqueue *vq)
+{
+	if (virtqueue_kick_prepare(vq))
+		return virtqueue_notify(vq);
+	return true;
+}
+EXPORT_SYMBOL_GPL(virtqueue_kick);
+
 /**
  * virtqueue_get_buf - get the next used buffer
  * @vq: the struct virtqueue we're talking about.
@@ -785,17 +901,6 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf);
 
-static void virtqueue_disable_cb_split(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
-		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
-			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
-	}
-}
-
 /**
  * virtqueue_disable_cb - disable callbacks
  * @vq: the struct virtqueue we're talking about.
@@ -811,28 +916,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
-static unsigned virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 last_used_idx;
-
-	START_USE(vq);
-
-	/* We optimistically turn back on interrupts, then check if there was
-	 * more to do. */
-	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
-	 * either clear the flags bit or point the event index at the next
-	 * entry. Always do both to keep code simple. */
-	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
-		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
-			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
-	}
-	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, last_used_idx = vq->last_used_idx);
-	END_USE(vq);
-	return last_used_idx;
-}
-
 /**
  * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
  * @vq: the struct virtqueue we're talking about.
@@ -851,14 +934,6 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
-static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned last_used_idx)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
-			vq->vring.used->idx);
-}
-
 /**
  * virtqueue_poll - query pending used buffers
  * @vq: the struct virtqueue we're talking about.
@@ -891,43 +966,11 @@ EXPORT_SYMBOL_GPL(virtqueue_poll);
 bool virtqueue_enable_cb(struct virtqueue *_vq)
 {
 	unsigned last_used_idx = virtqueue_enable_cb_prepare(_vq);
+
 	return !virtqueue_poll(_vq, last_used_idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
 
-static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 bufs;
-
-	START_USE(vq);
-
-	/* We optimistically turn back on interrupts, then check if there was
-	 * more to do. */
-	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
-	 * either clear the flags bit or point the event index at the next
-	 * entry. Always update the event index to keep code simple. */
-	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
-		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
-			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
-	}
-	/* TODO: tune this threshold */
-	bufs = (u16)(vq->avail_idx_shadow - vq->last_used_idx) * 3 / 4;
-
-	virtio_store_mb(vq->weak_barriers,
-			&vring_used_event(&vq->vring),
-			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
-
-	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->vring.used->idx) - vq->last_used_idx) > bufs)) {
-		END_USE(vq);
-		return false;
-	}
-
-	END_USE(vq);
-	return true;
-}
-
 /**
  * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
  * @vq: the struct virtqueue we're talking about.
@@ -947,32 +990,6 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
 
-static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	unsigned int i;
-	void *buf;
-
-	START_USE(vq);
-
-	for (i = 0; i < vq->vring.num; i++) {
-		if (!vq->desc_state[i].data)
-			continue;
-		/* detach_buf_split clears data, so grab it now. */
-		buf = vq->desc_state[i].data;
-		detach_buf_split(vq, i, NULL);
-		vq->avail_idx_shadow--;
-		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
-		END_USE(vq);
-		return buf;
-	}
-	/* That should have freed everything. */
-	BUG_ON(vq->vq.num_free != vq->vring.num);
-
-	END_USE(vq);
-	return NULL;
-}
-
 /**
  * virtqueue_detach_unused_buf - detach first unused buffer
  * @vq: the struct virtqueue we're talking about.
-- 
2.14.5

