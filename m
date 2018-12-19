Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21879C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE872184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbeLSM16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:27:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbeLSM1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B4A480F6C;
        Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E40AE27CA3;
        Wed, 19 Dec 2018 12:27:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DC9F3751C; Wed, 19 Dec 2018 13:27:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/10] drm/virtio: params struct for virtio_gpu_cmd_create_resource()
Date:   Wed, 19 Dec 2018 13:27:04 +0100
Message-Id: <20181219122708.4586-7-kraxel@redhat.com>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add format, width and height to the virtio_gpu_object_params struct
and use the struct for virtio_gpu_cmd_create_resource().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  7 ++++---
 drivers/gpu/drm/virtio/virtgpu_gem.c   |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 10 ++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 8cff8a3f7c..8c65deadd0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -54,6 +54,9 @@
 int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev);
 
 struct virtio_gpu_object_params {
+	uint32_t format;
+	uint32_t width;
+	uint32_t height;
 	unsigned long size;
 	bool pinned;
 };
@@ -251,9 +254,7 @@ int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
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
index 384cd80bf3..eea6c6e8db 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -90,7 +90,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	};
 	int ret;
 	uint32_t pitch;
-	uint32_t format;
 
 	if (args->bpp != 32)
 		return -EINVAL;
@@ -99,16 +98,17 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	args->size = pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
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
index 65b4a54f10..33112c8495 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -304,6 +304,9 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	INIT_LIST_HEAD(&validate_list);
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
+	params.format = rc->format;
+	params.width = rc->width;
+	params.height = rc->height;
 	params.size = rc->size;
 
 	/* allocate a single page size object */
@@ -316,8 +319,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
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

