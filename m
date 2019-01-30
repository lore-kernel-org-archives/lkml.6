Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F5CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E004420882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfA3Jnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:43:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbfA3Jnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:43:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FA11132691;
        Wed, 30 Jan 2019 09:43:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-190.ams2.redhat.com [10.36.117.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 274AA5D985;
        Wed, 30 Jan 2019 09:43:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 37CCD7701; Wed, 30 Jan 2019 10:43:39 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] drm/virtio: params struct for virtio_gpu_cmd_create_resource()
Date:   Wed, 30 Jan 2019 10:43:35 +0100
Message-Id: <20190130094338.14203-4-kraxel@redhat.com>
In-Reply-To: <20190130094338.14203-1-kraxel@redhat.com>
References: <20190130094338.14203-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 30 Jan 2019 09:43:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add format, width and height fields to the virtio_gpu_object_params
struct.  With that in place we can use the parameter struct for
virtio_gpu_cmd_create_resource() calls too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  7 ++++---
 drivers/gpu/drm/virtio/virtgpu_gem.c   |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 10 ++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 40928980a2..a40215c10e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -51,6 +51,9 @@
 #define DRIVER_PATCHLEVEL 0
 
 struct virtio_gpu_object_params {
+	uint32_t format;
+	uint32_t width;
+	uint32_t height;
 	unsigned long size;
 	bool pinned;
 };
@@ -248,9 +251,7 @@ int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
-				    uint32_t format,
-				    uint32_t width,
-				    uint32_t height);
+				    struct virtio_gpu_object_params *params);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index b5f2d94ce5..3a63ffcd4b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -88,7 +88,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	struct virtio_gpu_object_params params = { 0 };
 	int ret;
 	uint32_t pitch;
-	uint32_t format;
 
 	if (args->bpp != 32)
 		return -EINVAL;
@@ -98,16 +97,17 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
 	params.pinned = false,
+	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
+	params.width = args->width;
+	params.height = args->height;
 	params.size = args->size;
 	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
 				    &args->handle);
 	if (ret)
 		goto fail;
 
-	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_cmd_create_resource(vgdev, obj, format,
-				       args->width, args->height);
+	virtio_gpu_cmd_create_resource(vgdev, obj, &params);
 
 	/* attach the object to the resource */
 	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index fa7b958ca2..84c2216fd4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -303,6 +303,9 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
 	params.pinned = false,
+	params.format = rc->format;
+	params.width = rc->width;
+	params.height = rc->height;
 	params.size = rc->size;
 
 	/* allocate a single page size object */
@@ -315,8 +318,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	obj = &qobj->gem_base;
 
 	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
-					       rc->width, rc->height);
+		virtio_gpu_cmd_create_resource(vgdev, qobj, &params);
 
 		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	} else {
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6bc2008b0d..363b8b8577 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -376,9 +376,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 /* create a basic resource */
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
-				    uint32_t format,
-				    uint32_t width,
-				    uint32_t height)
+				    struct virtio_gpu_object_params *params)
 {
 	struct virtio_gpu_resource_create_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -388,9 +386,9 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
-	cmd_p->format = cpu_to_le32(format);
-	cmd_p->width = cpu_to_le32(width);
-	cmd_p->height = cpu_to_le32(height);
+	cmd_p->format = cpu_to_le32(params->format);
+	cmd_p->width = cpu_to_le32(params->width);
+	cmd_p->height = cpu_to_le32(params->height);
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
-- 
2.9.3

