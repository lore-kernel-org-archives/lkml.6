Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09269C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64FF2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeLSM2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:28:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbeLSM1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9446980F7B;
        Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E141E27C5F;
        Wed, 19 Dec 2018 12:27:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A4DFF7708; Wed, 19 Dec 2018 13:27:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/10] drm/virtio: use struct to pass params to virtio_gpu_object_create()
Date:   Wed, 19 Dec 2018 13:27:03 +0100
Message-Id: <20181219122708.4586-6-kraxel@redhat.com>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create virtio_gpu_object_params, use that to pass object parameters to
virtio_gpu_object_create.  Also drop unused "kernel" parameter (unused,
always false).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    | 15 ++++++++++-----
 drivers/gpu/drm/virtio/virtgpu_gem.c    | 18 +++++++++++-------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 12 +++++++-----
 drivers/gpu/drm/virtio/virtgpu_object.c | 22 +++++++++-------------
 4 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index bfb31fc3d0..8cff8a3f7c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -53,6 +53,11 @@
 /* virtgpu_drm_bus.c */
 int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev);
 
+struct virtio_gpu_object_params {
+	unsigned long size;
+	bool pinned;
+};
+
 struct virtio_gpu_object {
 	struct drm_gem_object gem_base;
 	uint32_t hw_res_handle;
@@ -220,16 +225,16 @@ int virtio_gpu_gem_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_gem_fini(struct virtio_gpu_device *vgdev);
 int virtio_gpu_gem_create(struct drm_file *file,
 			  struct drm_device *dev,
-			  uint64_t size,
+			  struct virtio_gpu_object_params *params,
 			  struct drm_gem_object **obj_p,
 			  uint32_t *handle_p);
 int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 			       struct drm_file *file);
 void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 				 struct drm_file *file);
-struct virtio_gpu_object *virtio_gpu_alloc_object(struct drm_device *dev,
-						  size_t size, bool kernel,
-						  bool pinned);
+struct virtio_gpu_object*
+virtio_gpu_alloc_object(struct drm_device *dev,
+			struct virtio_gpu_object_params *params);
 int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				struct drm_device *dev,
 				struct drm_mode_create_dumb *args);
@@ -345,7 +350,7 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
 
 /* virtio_gpu_object */
 int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
-			     unsigned long size, bool kernel, bool pinned,
+			     struct virtio_gpu_object_params *params,
 			     struct virtio_gpu_object **bo_ptr);
 void virtio_gpu_object_kunmap(struct virtio_gpu_object *bo);
 int virtio_gpu_object_kmap(struct virtio_gpu_object *bo);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index f065863939..384cd80bf3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -34,15 +34,15 @@ void virtio_gpu_gem_free_object(struct drm_gem_object *gem_obj)
 		virtio_gpu_object_unref(&obj);
 }
 
-struct virtio_gpu_object *virtio_gpu_alloc_object(struct drm_device *dev,
-						  size_t size, bool kernel,
-						  bool pinned)
+struct virtio_gpu_object*
+virtio_gpu_alloc_object(struct drm_device *dev,
+			struct virtio_gpu_object_params *params)
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_object *obj;
 	int ret;
 
-	ret = virtio_gpu_object_create(vgdev, size, kernel, pinned, &obj);
+	ret = virtio_gpu_object_create(vgdev, params, &obj);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -51,7 +51,7 @@ struct virtio_gpu_object *virtio_gpu_alloc_object(struct drm_device *dev,
 
 int virtio_gpu_gem_create(struct drm_file *file,
 			  struct drm_device *dev,
-			  uint64_t size,
+			  struct virtio_gpu_object_params *params,
 			  struct drm_gem_object **obj_p,
 			  uint32_t *handle_p)
 {
@@ -59,7 +59,7 @@ int virtio_gpu_gem_create(struct drm_file *file,
 	int ret;
 	u32 handle;
 
-	obj = virtio_gpu_alloc_object(dev, size, false, false);
+	obj = virtio_gpu_alloc_object(dev, params);
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
@@ -85,6 +85,9 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_gem_object *gobj;
 	struct virtio_gpu_object *obj;
+	struct virtio_gpu_object_params params = {
+		.pinned = false,
+	};
 	int ret;
 	uint32_t pitch;
 	uint32_t format;
@@ -96,7 +99,8 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	args->size = pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
-	ret = virtio_gpu_gem_create(file_priv, dev, args->size, &gobj,
+	params.size = args->size;
+	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
 				    &args->handle);
 	if (ret)
 		goto fail;
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 14ce8188c0..65b4a54f10 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -279,12 +279,14 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_object *qobj;
 	struct drm_gem_object *obj;
 	uint32_t handle = 0;
-	uint32_t size;
 	struct list_head validate_list;
 	struct ttm_validate_buffer mainbuf;
 	struct virtio_gpu_fence *fence = NULL;
 	struct ww_acquire_ctx ticket;
 	struct virtio_gpu_resource_create_3d rc_3d;
+	struct virtio_gpu_object_params params = {
+		.pinned = false,
+	};
 
 	if (vgdev->has_virgl_3d == false) {
 		if (rc->depth > 1)
@@ -302,13 +304,13 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	INIT_LIST_HEAD(&validate_list);
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
-	size = rc->size;
+	params.size = rc->size;
 
 	/* allocate a single page size object */
-	if (size == 0)
-		size = PAGE_SIZE;
+	if (params.size == 0)
+		params.size = PAGE_SIZE;
 
-	qobj = virtio_gpu_alloc_object(dev, size, false, false);
+	qobj = virtio_gpu_alloc_object(dev, &params);
 	if (IS_ERR(qobj))
 		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index f39a183d59..62367e3f80 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -79,21 +79,16 @@ static void virtio_gpu_init_ttm_placement(struct virtio_gpu_object *vgbo,
 }
 
 int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
-			     unsigned long size, bool kernel, bool pinned,
+			     struct virtio_gpu_object_params *params,
 			     struct virtio_gpu_object **bo_ptr)
 {
 	struct virtio_gpu_object *bo;
-	enum ttm_bo_type type;
 	size_t acc_size;
 	int ret;
 
-	if (kernel)
-		type = ttm_bo_type_kernel;
-	else
-		type = ttm_bo_type_device;
 	*bo_ptr = NULL;
 
-	acc_size = ttm_bo_dma_acc_size(&vgdev->mman.bdev, size,
+	acc_size = ttm_bo_dma_acc_size(&vgdev->mman.bdev, params->size,
 				       sizeof(struct virtio_gpu_object));
 
 	bo = kzalloc(sizeof(struct virtio_gpu_object), GFP_KERNEL);
@@ -104,19 +99,20 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 		kfree(bo);
 		return ret;
 	}
-	size = roundup(size, PAGE_SIZE);
-	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, size);
+	params->size = roundup(params->size, PAGE_SIZE);
+	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, params->size);
 	if (ret != 0) {
 		virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 		kfree(bo);
 		return ret;
 	}
 	bo->dumb = false;
-	virtio_gpu_init_ttm_placement(bo, pinned);
+	virtio_gpu_init_ttm_placement(bo, params->pinned);
 
-	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, size, type,
-			  &bo->placement, 0, !kernel, acc_size,
-			  NULL, NULL, &virtio_gpu_ttm_bo_destroy);
+	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
+			  ttm_bo_type_device, &bo->placement, 0,
+			  true, acc_size, NULL, NULL,
+			  &virtio_gpu_ttm_bo_destroy);
 	/* ttm_bo_init failure will call the destroy */
 	if (ret != 0)
 		return ret;
-- 
2.9.3

