Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B51C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771562064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771562064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbeJARJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:09:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbeJARJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:09:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50D3E309174E;
        Mon,  1 Oct 2018 10:32:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40BC12936C;
        Mon,  1 Oct 2018 10:32:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4032F9D388; Mon,  1 Oct 2018 12:32:24 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/8] drm/virtio: fix resource id handling
Date:   Mon,  1 Oct 2018 12:32:20 +0200
Message-Id: <20181001103222.11924-7-kraxel@redhat.com>
In-Reply-To: <20181001103222.11924-1-kraxel@redhat.com>
References: <20181001103222.11924-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 01 Oct 2018 10:32:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move virtio_gpu_resource_id_{get,put} to virtgpu_object.c and make them
static.  Allocate and free the id on creation and destroy, drop all
other calls.  That way objects have a valid handle for the whole
lifetime of the object.

Also fixes ids leaking.  Worst offender are dumb buffers, and I think
some error paths too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  3 ---
 drivers/gpu/drm/virtio/virtgpu_fb.c     |  1 -
 drivers/gpu/drm/virtio/virtgpu_gem.c    |  1 -
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  |  1 -
 drivers/gpu/drm/virtio/virtgpu_object.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 20 --------------------
 6 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 4a39877ce6..1c321e484d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -260,9 +260,6 @@ int virtio_gpu_surface_dirty(struct virtio_gpu_framebuffer *qfb,
 /* virtio vg */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
-void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-			       uint32_t *resid);
-void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    uint32_t format,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index c22a8246b6..fb1cc8b2f1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -231,7 +231,6 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
-	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
 	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       mode_cmd.width, mode_cmd.height);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 665d18a49d..f065863939 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -103,7 +103,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 
 	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
 	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       args->width, args->height);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index f9c55ecfca..681edd9c92 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -253,7 +253,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR(qobj))
 		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
-	virtio_gpu_resource_id_get(vgdev, &qobj->hw_res_handle);
 
 	if (!vgdev->has_virgl_3d) {
 		virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 6611c487d7..8bd1ebe13b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -25,6 +25,26 @@
 
 #include "virtgpu_drv.h"
 
+static void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
+				       uint32_t *resid)
+{
+	int handle;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&vgdev->resource_idr_lock);
+	handle = idr_alloc(&vgdev->resource_idr, NULL, 1, 0, GFP_NOWAIT);
+	spin_unlock(&vgdev->resource_idr_lock);
+	idr_preload_end();
+	*resid = handle;
+}
+
+static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
+{
+	spin_lock(&vgdev->resource_idr_lock);
+	idr_remove(&vgdev->resource_idr, id);
+	spin_unlock(&vgdev->resource_idr_lock);
+}
+
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct virtio_gpu_object *bo;
@@ -40,6 +60,7 @@ static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 	if (bo->vmap)
 		virtio_gpu_object_kunmap(bo);
 	drm_gem_object_release(&bo->gem_base);
+	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 	kfree(bo);
 }
 
@@ -81,9 +102,11 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	bo = kzalloc(sizeof(struct virtio_gpu_object), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
+	virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
 	size = roundup(size, PAGE_SIZE);
 	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, size);
 	if (ret != 0) {
+		virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 		kfree(bo);
 		return ret;
 	}
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 45da3c87b6..f6e875cdcd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -38,26 +38,6 @@
 			       + MAX_INLINE_CMD_SIZE		 \
 			       + MAX_INLINE_RESP_SIZE)
 
-void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-				uint32_t *resid)
-{
-	int handle;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&vgdev->resource_idr_lock);
-	handle = idr_alloc(&vgdev->resource_idr, NULL, 1, 0, GFP_NOWAIT);
-	spin_unlock(&vgdev->resource_idr_lock);
-	idr_preload_end();
-	*resid = handle;
-}
-
-void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
-{
-	spin_lock(&vgdev->resource_idr_lock);
-	idr_remove(&vgdev->resource_idr, id);
-	spin_unlock(&vgdev->resource_idr_lock);
-}
-
 void virtio_gpu_ctrl_ack(struct virtqueue *vq)
 {
 	struct drm_device *dev = vq->vdev->priv;
-- 
2.9.3

