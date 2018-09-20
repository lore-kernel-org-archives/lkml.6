Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C73E2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C73E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbeITMLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:11:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57309 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725725AbeITMLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36C8485A05;
        Thu, 20 Sep 2018 06:29:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C0E07E4F6;
        Thu, 20 Sep 2018 06:29:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5B9FF41A63; Thu, 20 Sep 2018 08:29:35 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     jiandi@amd.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: pass virtio_gpu_object to virtio_gpu_cmd_transfer_to_host_{2d,3d}
Date:   Thu, 20 Sep 2018 08:29:23 +0200
Message-Id: <20180920062924.6514-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 20 Sep 2018 06:29:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass virtio_gpu_object down to virtio_gpu_cmd_transfer_to_host_2d and
virtio_gpu_cmd_transfer_to_host_3d functions, instead of passing just
the virtio resource handle.

This is needed to lookup the scatter list of the object, for dma sync.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_fb.c    |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_plane.c |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 20 ++++++++------------
 5 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index a2d79e18bd..253fcf018d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -270,7 +270,8 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
-					uint32_t resource_id, uint64_t offset,
+					struct virtio_gpu_object *bo,
+					uint64_t offset,
 					__le32 width, __le32 height,
 					__le32 x, __le32 y,
 					struct virtio_gpu_fence **fence);
@@ -316,7 +317,8 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 					  struct virtio_gpu_box *box,
 					  struct virtio_gpu_fence **fence);
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
-					uint32_t resource_id, uint32_t ctx_id,
+					struct virtio_gpu_object *bo,
+					uint32_t ctx_id,
 					uint64_t offset, uint32_t level,
 					struct virtio_gpu_box *box,
 					struct virtio_gpu_fence **fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index b9678c4082..3364b0970d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -95,7 +95,7 @@ static int virtio_gpu_dirty_update(struct virtio_gpu_framebuffer *fb,
 
 		offset = (y * fb->base.pitches[0]) + x * bpp;
 
-		virtio_gpu_cmd_transfer_to_host_2d(vgdev, obj->hw_res_handle,
+		virtio_gpu_cmd_transfer_to_host_2d(vgdev, obj,
 						   offset,
 						   cpu_to_le32(w),
 						   cpu_to_le32(h),
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 7bdf6f0e58..f16b875d6a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -429,11 +429,11 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 	convert_to_hw_box(&box, &args->box);
 	if (!vgdev->has_virgl_3d) {
 		virtio_gpu_cmd_transfer_to_host_2d
-			(vgdev, qobj->hw_res_handle, offset,
+			(vgdev, qobj, offset,
 			 box.w, box.h, box.x, box.y, NULL);
 	} else {
 		virtio_gpu_cmd_transfer_to_host_3d
-			(vgdev, qobj->hw_res_handle,
+			(vgdev, qobj,
 			 vfpriv ? vfpriv->ctx_id : 0, offset,
 			 args->level, &box, &fence);
 		reservation_object_add_excl_fence(qobj->tbo.resv,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 88f2fb8c61..682a977d68 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -158,7 +158,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		handle = bo->hw_res_handle;
 		if (bo->dumb) {
 			virtio_gpu_cmd_transfer_to_host_2d
-				(vgdev, handle, 0,
+				(vgdev, bo, 0,
 				 cpu_to_le32(plane->state->src_w >> 16),
 				 cpu_to_le32(plane->state->src_h >> 16),
 				 cpu_to_le32(plane->state->src_x >> 16),
@@ -217,7 +217,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	if (bo && bo->dumb && (plane->state->fb != old_state->fb)) {
 		/* new cursor -- update & wait */
 		virtio_gpu_cmd_transfer_to_host_2d
-			(vgdev, handle, 0,
+			(vgdev, bo, 0,
 			 cpu_to_le32(plane->state->crtc_w),
 			 cpu_to_le32(plane->state->crtc_h),
 			 0, 0, &fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index df32811f2c..4e2e037aed 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -483,28 +483,26 @@ void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 }
 
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
-					uint32_t resource_id, uint64_t offset,
+					struct virtio_gpu_object *bo,
+					uint64_t offset,
 					__le32 width, __le32 height,
 					__le32 x, __le32 y,
 					struct virtio_gpu_fence **fence)
 {
 	struct virtio_gpu_transfer_to_host_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
-	struct virtio_gpu_fbdev *vgfbdev = vgdev->vgfbdev;
-	struct virtio_gpu_framebuffer *fb = &vgfbdev->vgfb;
-	struct virtio_gpu_object *obj = gem_to_virtio_gpu_obj(fb->base.obj[0]);
 	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
 
 	if (use_dma_api)
 		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       obj->pages->sgl, obj->pages->nents,
+				       bo->pages->sgl, bo->pages->nents,
 				       DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	cmd_p->offset = cpu_to_le64(offset);
 	cmd_p->r.width = width;
 	cmd_p->r.height = height;
@@ -791,21 +789,19 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 }
 
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
-					uint32_t resource_id, uint32_t ctx_id,
+					struct virtio_gpu_object *bo,
+					uint32_t ctx_id,
 					uint64_t offset, uint32_t level,
 					struct virtio_gpu_box *box,
 					struct virtio_gpu_fence **fence)
 {
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
-	struct virtio_gpu_fbdev *vgfbdev = vgdev->vgfbdev;
-	struct virtio_gpu_framebuffer *fb = &vgfbdev->vgfb;
-	struct virtio_gpu_object *obj = gem_to_virtio_gpu_obj(fb->base.obj[0]);
 	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
 
 	if (use_dma_api)
 		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       obj->pages->sgl, obj->pages->nents,
+				       bo->pages->sgl, bo->pages->nents,
 				       DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
@@ -813,7 +809,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D);
 	cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	cmd_p->box = *box;
 	cmd_p->offset = cpu_to_le64(offset);
 	cmd_p->level = cpu_to_le32(level);
-- 
2.9.3

