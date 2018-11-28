Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6FDC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC89320989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC89320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeK2CMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:12:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeK2CMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:12:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F055D3974;
        Wed, 28 Nov 2018 15:10:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7B7B1948E;
        Wed, 28 Nov 2018 15:10:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 14BD95E4E6; Wed, 28 Nov 2018 16:10:22 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     robert.foss@collabora.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/virtio: fence: pass plain pointer
Date:   Wed, 28 Nov 2018 16:10:20 +0100
Message-Id: <20181128151021.29565-2-kraxel@redhat.com>
In-Reply-To: <20181128151021.29565-1-kraxel@redhat.com>
References: <20181128151021.29565-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 28 Nov 2018 15:10:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit "9fdd90c0f4 drm/virtio: add virtio_gpu_alloc_fence()"
fences are not allocated any more by virtio_gpu_fence_emit().  So there
is no need to pass down a reference to the fence pointer, a plain
pointer is enough now.

Convert virtio_gpu_fence_emit() and callers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 14 +++++++-------
 drivers/gpu/drm/virtio/virtgpu_fence.c | 10 +++++-----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_plane.c |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 20 ++++++++++----------
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 7bec6e3688..d6cc1a92ca 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -273,7 +273,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint64_t offset,
 					__le32 width, __le32 height,
 					__le32 x, __le32 y,
-					struct virtio_gpu_fence **fence);
+					struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id,
 				   uint32_t x, uint32_t y,
@@ -284,7 +284,7 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 				uint32_t x, uint32_t y);
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
-			     struct virtio_gpu_fence **fence);
+			     struct virtio_gpu_fence *fence);
 void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
 			      struct virtio_gpu_object *obj);
 int virtio_gpu_attach_status_page(struct virtio_gpu_device *vgdev);
@@ -309,23 +309,23 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 					    uint32_t resource_id);
 void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   void *data, uint32_t data_size,
-			   uint32_t ctx_id, struct virtio_gpu_fence **fence);
+			   uint32_t ctx_id, struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 					  uint32_t resource_id, uint32_t ctx_id,
 					  uint64_t offset, uint32_t level,
 					  struct virtio_gpu_box *box,
-					  struct virtio_gpu_fence **fence);
+					  struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 					struct virtio_gpu_object *bo,
 					uint32_t ctx_id,
 					uint64_t offset, uint32_t level,
 					struct virtio_gpu_box *box,
-					struct virtio_gpu_fence **fence);
+					struct virtio_gpu_fence *fence);
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence **fence);
+				  struct virtio_gpu_fence *fence);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_fence_ack(struct virtqueue *vq);
@@ -358,7 +358,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(
 void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence);
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
-			  struct virtio_gpu_fence **fence);
+			  struct virtio_gpu_fence *fence);
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
 				    u64 last_seq);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 6b5d92215c..4d6826b278 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -91,19 +91,19 @@ void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence)
 
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
-			  struct virtio_gpu_fence **fence)
+			  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
 	unsigned long irq_flags;
 
 	spin_lock_irqsave(&drv->lock, irq_flags);
-	(*fence)->seq = ++drv->sync_seq;
-	dma_fence_get(&(*fence)->f);
-	list_add_tail(&(*fence)->node, &drv->fences);
+	fence->seq = ++drv->sync_seq;
+	dma_fence_get(&fence->f);
+	list_add_tail(&fence->node, &drv->fences);
 	spin_unlock_irqrestore(&drv->lock, irq_flags);
 
 	cmd_hdr->flags |= cpu_to_le32(VIRTIO_GPU_FLAG_FENCE);
-	cmd_hdr->fence_id = cpu_to_le64((*fence)->seq);
+	cmd_hdr->fence_id = cpu_to_le64(fence->seq);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 340f2513d8..e9cdb4c7f6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -221,7 +221,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	}
 
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-			      vfpriv->ctx_id, &out_fence);
+			      vfpriv->ctx_id, out_fence);
 
 	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
 
@@ -349,7 +349,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		}
 
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d, NULL);
-		ret = virtio_gpu_object_attach(vgdev, qobj, &fence);
+		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
 		if (ret) {
 			virtio_gpu_fence_cleanup(fence);
 			goto fail_backoff;
@@ -450,7 +450,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 	virtio_gpu_cmd_transfer_from_host_3d
 		(vgdev, qobj->hw_res_handle,
 		 vfpriv->ctx_id, offset, args->level,
-		 &box, &fence);
+		 &box, fence);
 	reservation_object_add_excl_fence(qobj->tbo.resv,
 					  &fence->f);
 
@@ -504,7 +504,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 		virtio_gpu_cmd_transfer_to_host_3d
 			(vgdev, qobj,
 			 vfpriv ? vfpriv->ctx_id : 0, offset,
-			 args->level, &box, &fence);
+			 args->level, &box, fence);
 		reservation_object_add_excl_fence(qobj->tbo.resv,
 						  &fence->f);
 		dma_fence_put(&fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index b84ac8c258..ead5c53d4e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -204,7 +204,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 			(vgdev, bo, 0,
 			 cpu_to_le32(plane->state->crtc_w),
 			 cpu_to_le32(plane->state->crtc_h),
-			 0, 0, &vgfb->fence);
+			 0, 0, vgfb->fence);
 		ret = virtio_gpu_object_reserve(bo, false);
 		if (!ret) {
 			reservation_object_add_excl_fence(bo->tbo.resv,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 2c6764f08f..97038662b9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -298,7 +298,7 @@ static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					       struct virtio_gpu_vbuffer *vbuf,
 					       struct virtio_gpu_ctrl_hdr *hdr,
-					       struct virtio_gpu_fence **fence)
+					       struct virtio_gpu_fence *fence)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
 	int rc;
@@ -405,7 +405,7 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 
 static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
 						  uint32_t resource_id,
-						  struct virtio_gpu_fence **fence)
+						  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_detach_backing *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -467,7 +467,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint64_t offset,
 					__le32 width, __le32 height,
 					__le32 x, __le32 y,
-					struct virtio_gpu_fence **fence)
+					struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_to_host_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -497,7 +497,7 @@ virtio_gpu_cmd_resource_attach_backing(struct virtio_gpu_device *vgdev,
 				       uint32_t resource_id,
 				       struct virtio_gpu_mem_entry *ents,
 				       uint32_t nents,
-				       struct virtio_gpu_fence **fence)
+				       struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_attach_backing *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -821,7 +821,7 @@ void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence **fence)
+				  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -842,7 +842,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 					uint32_t ctx_id,
 					uint64_t offset, uint32_t level,
 					struct virtio_gpu_box *box,
-					struct virtio_gpu_fence **fence)
+					struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -870,7 +870,7 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 					  uint32_t resource_id, uint32_t ctx_id,
 					  uint64_t offset, uint32_t level,
 					  struct virtio_gpu_box *box,
-					  struct virtio_gpu_fence **fence)
+					  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -890,7 +890,7 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 
 void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   void *data, uint32_t data_size,
-			   uint32_t ctx_id, struct virtio_gpu_fence **fence)
+			   uint32_t ctx_id, struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_cmd_submit *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -910,7 +910,7 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
-			     struct virtio_gpu_fence **fence)
+			     struct virtio_gpu_fence *fence)
 {
 	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
 	struct virtio_gpu_mem_entry *ents;
@@ -967,7 +967,7 @@ void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
 	if (use_dma_api && obj->mapped) {
 		struct virtio_gpu_fence *fence = virtio_gpu_fence_alloc(vgdev);
 		/* detach backing and wait for the host process it ... */
-		virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, &fence);
+		virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, fence);
 		dma_fence_wait(&fence->f, true);
 		dma_fence_put(&fence->f);
 
-- 
2.9.3

