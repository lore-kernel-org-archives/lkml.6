Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C134222419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134222419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeKMCqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:46:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54976 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeKMCqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:46:12 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8109:92c0:207d:68ed:6b77:5dd1:d3e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3617327E986;
        Mon, 12 Nov 2018 16:52:07 +0000 (GMT)
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH v5 1/4] drm/virtio: add virtio_gpu_alloc_fence()
Date:   Mon, 12 Nov 2018 17:51:54 +0100
Message-Id: <20181112165157.32765-2-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112165157.32765-1-robert.foss@collabora.com>
References: <20181112165157.32765-1-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor fence creation, add fences to relevant GPU
operations and add cursor helper functions.

This removes the potential for allocation failures from the
cmd_submit and atomic_commit paths.
Now a fence will be allocated first and only after that
will we proceed with the rest of the execution.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
Suggested-by: Rob Herring <robh@kernel.org>
---

Changes since v3:
 - Gerd: Clarified and extended commit message
 - Emil: Fixed whitespace issue
 - Emil: Changed label name from fail_fence to fail_backoff
 - Emil: Remove special case for !fence->drv in virtio_gpu_fence_cleanup()

 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 +++
 drivers/gpu/drm/virtio/virtgpu_fence.c | 29 ++++++++++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 30 +++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_plane.c | 46 +++++++++++++++++++++++---
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  2 +-
 5 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 6474e83cbf3d..acd130c58e33 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -131,6 +131,7 @@ struct virtio_gpu_framebuffer {
 	int x1, y1, x2, y2; /* dirty rect */
 	spinlock_t dirty_lock;
 	uint32_t hw_res_handle;
+	struct virtio_gpu_fence *fence;
 };
 #define to_virtio_gpu_framebuffer(x) \
 	container_of(x, struct virtio_gpu_framebuffer, base)
@@ -349,6 +350,9 @@ void virtio_gpu_ttm_fini(struct virtio_gpu_device *vgdev);
 int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
 
 /* virtio_gpu_fence.c */
+struct virtio_gpu_fence *virtio_gpu_fence_alloc(
+	struct virtio_gpu_device *vgdev);
+void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence);
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence **fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 00c742a441bf..6b5d92215cfb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -67,6 +67,28 @@ static const struct dma_fence_ops virtio_fence_ops = {
 	.timeline_value_str  = virtio_timeline_value_str,
 };
 
+struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
+{
+	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
+	struct virtio_gpu_fence *fence = kzalloc(sizeof(struct virtio_gpu_fence),
+							GFP_ATOMIC);
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
+	dma_fence_put(&fence->f);
+}
+
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence **fence)
@@ -74,15 +96,8 @@ int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
 	unsigned long irq_flags;
 
-	*fence = kmalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
-	if ((*fence) == NULL)
-		return -ENOMEM;
-
 	spin_lock_irqsave(&drv->lock, irq_flags);
-	(*fence)->drv = drv;
 	(*fence)->seq = ++drv->sync_seq;
-	dma_fence_init(&(*fence)->f, &virtio_fence_ops, &drv->lock,
-		       drv->context, (*fence)->seq);
 	dma_fence_get(&(*fence)->f);
 	list_add_tail(&(*fence)->node, &drv->fences);
 	spin_unlock_irqrestore(&drv->lock, irq_flags);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index bc5afa4f906e..d69fc356df0a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -168,6 +168,13 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
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
 			      vfpriv->ctx_id, &fence);
 
@@ -283,11 +290,17 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.nr_samples = cpu_to_le32(rc->nr_samples);
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
+		fence = virtio_gpu_fence_alloc(vgdev);
+		if (!fence) {
+			ret = -ENOMEM;
+			goto fail_backoff;
+		}
+
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d, NULL);
 		ret = virtio_gpu_object_attach(vgdev, qobj, &fence);
 		if (ret) {
-			ttm_eu_backoff_reservation(&ticket, &validate_list);
-			goto fail_unref;
+			virtio_gpu_fence_cleanup(fence);
+			goto fail_backoff;
 		}
 		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
 	}
@@ -312,6 +325,8 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		dma_fence_put(&fence->f);
 	}
 	return 0;
+fail_backoff:
+	ttm_eu_backoff_reservation(&ticket, &validate_list);
 fail_unref:
 	if (vgdev->has_virgl_3d) {
 		virtio_gpu_unref_list(&validate_list);
@@ -374,6 +389,12 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
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
@@ -423,6 +444,11 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 			(vgdev, qobj, offset,
 			 box.w, box.h, box.x, box.y, NULL);
 	} else {
+		fence = virtio_gpu_fence_alloc(vgdev);
+		if (!fence) {
+			ret = -ENOMEM;
+			goto out_unres;
+		}
 		virtio_gpu_cmd_transfer_to_host_3d
 			(vgdev, qobj,
 			 vfpriv ? vfpriv->ctx_id : 0, offset,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a9f4ae7d4483..b84ac8c25856 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -137,6 +137,41 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
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
@@ -144,7 +179,6 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
-	struct virtio_gpu_fence *fence = NULL;
 	struct virtio_gpu_object *bo = NULL;
 	uint32_t handle;
 	int ret = 0;
@@ -170,13 +204,13 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 			(vgdev, bo, 0,
 			 cpu_to_le32(plane->state->crtc_w),
 			 cpu_to_le32(plane->state->crtc_h),
-			 0, 0, &fence);
+			 0, 0, &vgfb->fence);
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
@@ -218,6 +252,8 @@ static const struct drm_plane_helper_funcs virtio_gpu_primary_helper_funcs = {
 };
 
 static const struct drm_plane_helper_funcs virtio_gpu_cursor_helper_funcs = {
+	.prepare_fb		= virtio_gpu_cursor_prepare_fb,
+	.cleanup_fb		= virtio_gpu_cursor_cleanup_fb,
 	.atomic_check		= virtio_gpu_plane_atomic_check,
 	.atomic_update		= virtio_gpu_cursor_plane_update,
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 51bef1775e47..93f2c3a51ee8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -896,9 +896,9 @@ void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
 			      struct virtio_gpu_object *obj)
 {
 	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
-	struct virtio_gpu_fence *fence;
 
 	if (use_dma_api && obj->mapped) {
+		struct virtio_gpu_fence *fence = virtio_gpu_fence_alloc(vgdev);
 		/* detach backing and wait for the host process it ... */
 		virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, &fence);
 		dma_fence_wait(&fence->f, true);
-- 
2.17.1

