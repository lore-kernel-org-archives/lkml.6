Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E17C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB242087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfA3Jnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:43:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfA3Jnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:43:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E78E2CD7E4;
        Wed, 30 Jan 2019 09:43:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-190.ams2.redhat.com [10.36.117.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73CE5112C1A1;
        Wed, 30 Jan 2019 09:43:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B51E97704; Wed, 30 Jan 2019 10:43:39 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/6] drm/virtio: move virtio_gpu_cmd_create_resource call into virtio_gpu_object_create
Date:   Wed, 30 Jan 2019 10:43:38 +0100
Message-Id: <20190130094338.14203-7-kraxel@redhat.com>
In-Reply-To: <20190130094338.14203-1-kraxel@redhat.com>
References: <20190130094338.14203-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 30 Jan 2019 09:43:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifically call virtio_gpu_object_create() before ttm_bo_init(), so
the object is already created when ttm calls the
virtio_gpu_ttm_tt_bind() callback (which in turn calls
virtio_gpu_object_attach()).

With that in place virtio_gpu_object_attach() will never be called with
an object which is not yet created, so the extra
virtio_gpu_object_attach() calls done after
virtio_gpu_cmd_create_resource() is not needed any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 ++
 drivers/gpu/drm/virtio/virtgpu_gem.c    | 12 +-----------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 10 +---------
 drivers/gpu/drm/virtio/virtgpu_object.c | 10 ++++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  4 ++--
 5 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 3265e62725..52f3950f82 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -56,7 +56,9 @@ struct virtio_gpu_object_params {
 	uint32_t height;
 	unsigned long size;
 	bool pinned;
+	bool dumb;
 	/* 3d */
+	bool virgl;
 	uint32_t target;
 	uint32_t bind;
 	uint32_t depth;
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 3a63ffcd4b..b5d7df17ac 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -82,9 +82,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				struct drm_device *dev,
 				struct drm_mode_create_dumb *args)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_gem_object *gobj;
-	struct virtio_gpu_object *obj;
 	struct virtio_gpu_object_params params = { 0 };
 	int ret;
 	uint32_t pitch;
@@ -101,20 +99,12 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	params.width = args->width;
 	params.height = args->height;
 	params.size = args->size;
+	params.dumb = true;
 	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
 				    &args->handle);
 	if (ret)
 		goto fail;
 
-	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_cmd_create_resource(vgdev, obj, &params);
-
-	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
-	if (ret)
-		goto fail;
-
-	obj->dumb = true;
 	args->pitch = pitch;
 	return ret;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index da06ebbb3a..3a1c447098 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -300,6 +300,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	params.height = rc->height;
 	params.size = rc->size;
 	if (vgdev->has_virgl_3d) {
+		params.virgl = true;
 		params.target = rc->target;
 		params.bind = rc->bind;
 		params.depth = rc->depth;
@@ -317,15 +318,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
 
-	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj, &params);
-
-		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
-	} else {
-		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &params);
-		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
-	}
-
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
 		drm_gem_object_release(obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 62367e3f80..94da9e68d2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -106,9 +106,15 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 		kfree(bo);
 		return ret;
 	}
-	bo->dumb = false;
+	bo->dumb = params->dumb;
+
+	if (params->virgl) {
+		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params);
+	} else {
+		virtio_gpu_cmd_create_resource(vgdev, bo, params);
+	}
+
 	virtio_gpu_init_ttm_placement(bo, params->pinned);
-
 	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
 			  ttm_bo_type_device, &bo->placement, 0,
 			  true, acc_size, NULL, NULL,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index ca93ec6ca3..292663c192 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -932,8 +932,8 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 	struct scatterlist *sg;
 	int si, nents;
 
-	if (!obj->created)
-		return 0;
+	if (WARN_ON_ONCE(!obj->created))
+		return -EINVAL;
 
 	if (!obj->pages) {
 		int ret;
-- 
2.9.3

