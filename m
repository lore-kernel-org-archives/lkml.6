Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FDFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A3420665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A3420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJZDLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:11:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43592 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJZDLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:11:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: robertfoss)
        with ESMTPSA id 2A0382756E1
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH 1/5] drm/virtio: add virtio_gpu_alloc_fence()
Date:   Thu, 25 Oct 2018 20:37:35 +0200
Message-Id: <20181025183739.9375-2-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025183739.9375-1-robert.foss@collabora.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

Refactor fence creation to remove the potential allocation failure from
the cmd_submit and atomic_commit paths. Now the fence should be allocated
first and just after we should proceed with the rest of the execution.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
Suggested-by: Rob Herring <robh@kernel.org>
---
Changes since v2:
 - Forward ported to upstream/master (4.20)

 drivers/gpu/drm/virtio/virtgpu_drv.h   | 18 ++++++----
 drivers/gpu/drm/virtio/virtgpu_fence.c | 41 ++++++++++++++++-------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 38 +++++++++++++++++----
 drivers/gpu/drm/virtio/virtgpu_plane.c | 46 +++++++++++++++++++++++---
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 16 ++++-----
 5 files changed, 121 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 65605e207bbe..e8d2a67d8049 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -127,6 +127,7 @@ struct virtio_gpu_framebuffer {
 	int x1, y1, x2, y2; /* dirty rect */
 	spinlock_t dirty_lock;
 	uint32_t hw_res_handle;
+	struct virtio_gpu_fence *fence;
 };
 #define to_virtio_gpu_framebuffer(x) \
 	container_of(x, struct virtio_gpu_framebuffer, base)
@@ -263,7 +264,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint32_t resource_id, uint64_t offset,
 					__le32 width, __le32 height,
 					__le32 x, __le32 y,
-					struct virtio_gpu_fence **fence);
+					struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id,
 				   uint32_t x, uint32_t y,
@@ -275,7 +276,7 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
 			     uint32_t resource_id,
-			     struct virtio_gpu_fence **fence);
+			     struct virtio_gpu_fence *fence);
 int virtio_gpu_attach_status_page(struct virtio_gpu_device *vgdev);
 int virtio_gpu_detach_status_page(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
@@ -299,21 +300,21 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
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
 					uint32_t resource_id, uint32_t ctx_id,
 					uint64_t offset, uint32_t level,
 					struct virtio_gpu_box *box,
-					struct virtio_gpu_fence **fence);
+					struct virtio_gpu_fence *fence);
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence **fence);
+				  struct virtio_gpu_fence *fence);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_fence_ack(struct virtqueue *vq);
@@ -341,9 +342,12 @@ void virtio_gpu_ttm_fini(struct virtio_gpu_device *vgdev);
 int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
 
 /* virtio_gpu_fence.c */
+struct virtio_gpu_fence *virtio_gpu_fence_alloc(
+	struct virtio_gpu_device *vgdev);
+void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence);
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
-			  struct virtio_gpu_fence **fence);
+			  struct virtio_gpu_fence *fence);
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
 				    u64 last_seq);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 00c742a441bf..73f5afc37a32 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -67,28 +67,45 @@ static const struct dma_fence_ops virtio_fence_ops = {
 	.timeline_value_str  = virtio_timeline_value_str,
 };
 
+struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
+{
+	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
+	struct virtio_gpu_fence *fence = kzalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
+	if (!fence)
+		return fence;
+
+	fence->drv = drv;
+	dma_fence_init(&fence->f, &virtio_fence_ops, &drv->lock, drv->context, 0);
+
+	return fence;
+}
+
+void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence)
+{
+	if (!fence)
+		return;
+
+	if (fence->drv)
+		dma_fence_put(&fence->f);
+	else
+		kfree(fence);
+}
+
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
-			  struct virtio_gpu_fence **fence)
+			  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
 	unsigned long irq_flags;
 
-	*fence = kmalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
-	if ((*fence) == NULL)
-		return -ENOMEM;
-
 	spin_lock_irqsave(&drv->lock, irq_flags);
-	(*fence)->drv = drv;
-	(*fence)->seq = ++drv->sync_seq;
-	dma_fence_init(&(*fence)->f, &virtio_fence_ops, &drv->lock,
-		       drv->context, (*fence)->seq);
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
index 7bdf6f0e58a5..d01a9ed100d1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -168,8 +168,15 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		ret = PTR_ERR(buf);
 		goto out_unresv;
 	}
+
+	fence = virtio_gpu_fence_alloc(vgdev);
+	if (!fence) {
+		kfree(buf);
+		ret = -ENOMEM;
+		goto out_unresv;
+	}
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-			      vfpriv->ctx_id, &fence);
+			      vfpriv->ctx_id, fence);
 
 	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
 
@@ -288,11 +295,17 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.nr_samples = cpu_to_le32(rc->nr_samples);
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
+		fence = virtio_gpu_fence_alloc(vgdev);
+		if (!fence) {
+			ret = -ENOMEM;
+			goto fail_fence;
+		}
+
 		virtio_gpu_cmd_resource_create_3d(vgdev, &rc_3d, NULL);
-		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, &fence);
+		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, fence);
 		if (ret) {
-			ttm_eu_backoff_reservation(&ticket, &validate_list);
-			goto fail_unref;
+			virtio_gpu_fence_cleanup(fence);
+			goto fail_fence;
 		}
 		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
 	}
@@ -319,6 +332,8 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		dma_fence_put(&fence->f);
 	}
 	return 0;
+fail_fence:
+ttm_eu_backoff_reservation(&ticket, &validate_list);
 fail_unref:
 	if (vgdev->has_virgl_3d) {
 		virtio_gpu_unref_list(&validate_list);
@@ -383,10 +398,16 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 		goto out_unres;
 
 	convert_to_hw_box(&box, &args->box);
+
+	fence = virtio_gpu_fence_alloc(vgdev);
+	if (!fence) {
+		ret = -ENOMEM;
+		goto out_unres;
+	}
 	virtio_gpu_cmd_transfer_from_host_3d
 		(vgdev, qobj->hw_res_handle,
 		 vfpriv->ctx_id, offset, args->level,
-		 &box, &fence);
+		 &box, fence);
 	reservation_object_add_excl_fence(qobj->tbo.resv,
 					  &fence->f);
 
@@ -432,10 +453,15 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 			(vgdev, qobj->hw_res_handle, offset,
 			 box.w, box.h, box.x, box.y, NULL);
 	} else {
+		fence = virtio_gpu_fence_alloc(vgdev);
+		if (!fence) {
+			ret = -ENOMEM;
+			goto out_unres;
+		}
 		virtio_gpu_cmd_transfer_to_host_3d
 			(vgdev, qobj->hw_res_handle,
 			 vfpriv ? vfpriv->ctx_id : 0, offset,
-			 args->level, &box, &fence);
+			 args->level, &box, fence);
 		reservation_object_add_excl_fence(qobj->tbo.resv,
 						  &fence->f);
 		dma_fence_put(&fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index dc5b5b2b7aab..7f06c2a0a428 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -187,6 +187,41 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 				      plane->state->src_h >> 16);
 }
 
+static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
+					struct drm_plane_state *new_state)
+{
+	struct drm_device *dev = plane->dev;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_object *bo;
+
+	if (!new_state->fb)
+		return 0;
+
+	vgfb = to_virtio_gpu_framebuffer(new_state->fb);
+	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+	if (bo && bo->dumb && (plane->state->fb != new_state->fb)) {
+		vgfb->fence = virtio_gpu_fence_alloc(vgdev);
+		if (!vgfb->fence)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void virtio_gpu_cursor_cleanup_fb(struct drm_plane *plane,
+					 struct drm_plane_state *old_state)
+{
+	struct virtio_gpu_framebuffer *vgfb;
+
+	if (!plane->state->fb)
+		return;
+
+	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+	if (vgfb->fence)
+		virtio_gpu_fence_cleanup(vgfb->fence);
+}
+
 static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 					   struct drm_plane_state *old_state)
 {
@@ -194,7 +229,6 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
-	struct virtio_gpu_fence *fence = NULL;
 	struct virtio_gpu_object *bo = NULL;
 	uint32_t handle;
 	int ret = 0;
@@ -220,13 +254,13 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 			(vgdev, handle, 0,
 			 cpu_to_le32(plane->state->crtc_w),
 			 cpu_to_le32(plane->state->crtc_h),
-			 0, 0, &fence);
+			 0, 0, vgfb->fence);
 		ret = virtio_gpu_object_reserve(bo, false);
 		if (!ret) {
 			reservation_object_add_excl_fence(bo->tbo.resv,
-							  &fence->f);
-			dma_fence_put(&fence->f);
-			fence = NULL;
+							  &vgfb->fence->f);
+			dma_fence_put(&vgfb->fence->f);
+			vgfb->fence = NULL;
 			virtio_gpu_object_unreserve(bo);
 			virtio_gpu_object_wait(bo, false);
 		}
@@ -268,6 +302,8 @@ static const struct drm_plane_helper_funcs virtio_gpu_primary_helper_funcs = {
 };
 
 static const struct drm_plane_helper_funcs virtio_gpu_cursor_helper_funcs = {
+	.prepare_fb		= virtio_gpu_cursor_prepare_fb,
+	.cleanup_fb		= virtio_gpu_cursor_cleanup_fb,
 	.atomic_check		= virtio_gpu_plane_atomic_check,
 	.atomic_update		= virtio_gpu_cursor_plane_update,
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 020070d483d3..93593c496fdb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -319,7 +319,7 @@ static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					       struct virtio_gpu_vbuffer *vbuf,
 					       struct virtio_gpu_ctrl_hdr *hdr,
-					       struct virtio_gpu_fence **fence)
+					       struct virtio_gpu_fence *fence)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
 	int rc;
@@ -485,7 +485,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint32_t resource_id, uint64_t offset,
 					__le32 width, __le32 height,
 					__le32 x, __le32 y,
-					struct virtio_gpu_fence **fence)
+					struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_to_host_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -509,7 +509,7 @@ virtio_gpu_cmd_resource_attach_backing(struct virtio_gpu_device *vgdev,
 				       uint32_t resource_id,
 				       struct virtio_gpu_mem_entry *ents,
 				       uint32_t nents,
-				       struct virtio_gpu_fence **fence)
+				       struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_attach_backing *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -764,7 +764,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence **fence)
+				  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -783,7 +783,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 					uint32_t resource_id, uint32_t ctx_id,
 					uint64_t offset, uint32_t level,
 					struct virtio_gpu_box *box,
-					struct virtio_gpu_fence **fence)
+					struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -805,7 +805,7 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 					  uint32_t resource_id, uint32_t ctx_id,
 					  uint64_t offset, uint32_t level,
 					  struct virtio_gpu_box *box,
-					  struct virtio_gpu_fence **fence)
+					  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -825,7 +825,7 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 
 void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   void *data, uint32_t data_size,
-			   uint32_t ctx_id, struct virtio_gpu_fence **fence)
+			   uint32_t ctx_id, struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_cmd_submit *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -846,7 +846,7 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
 			     uint32_t resource_id,
-			     struct virtio_gpu_fence **fence)
+			     struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_mem_entry *ents;
 	struct scatterlist *sg;
-- 
2.17.1

