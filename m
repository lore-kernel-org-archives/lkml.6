Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F54DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E216D20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E216D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeICPRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:17:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbeICPRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:17:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66C1940216E7;
        Mon,  3 Sep 2018 10:58:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABBBF63F31;
        Mon,  3 Sep 2018 10:58:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B219A17514; Mon,  3 Sep 2018 12:57:58 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] drm/virtio: fix DRM_FORMAT_* handling
Date:   Mon,  3 Sep 2018 12:57:56 +0200
Message-Id: <20180903105756.24912-6-kraxel@redhat.com>
In-Reply-To: <20180903105756.24912-1-kraxel@redhat.com>
References: <20180903105756.24912-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 03 Sep 2018 10:58:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 03 Sep 2018 10:58:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DRM_FORMAT_HOST_XRGB8888, so we are using the correct format code
on bigendian machines.  Also add DRIVER_PREFER_HOST_BYTE_ORDER driver
feature flag so drm_mode_addfb() asks for the correct format code.

Both DRM_FORMAT_* and VIRTIO_GPU_FORMAT_* are defined to be little
endian, so using a different mapping on bigendian machines is wrong.
It's there because of broken drm_mode_addfb() behavior.  So with
drm_mode_addfb() being fixed we can fix this too.

While wading through the code I've noticed we have a little issue in
virtio:  We attach a format to the bo when it is created
(DRM_IOCTL_MODE_CREATE_DUMB), not when we map it as framebuffer
(DRM_IOCTL_MODE_ADDFB).  Easy way out:  Support a single format only.
Pick DRM_FORMAT_HOST_XRGB8888, it is the only one actually used in
practice.  Drop unused mappings in virtio_gpu_translate_format().

With this patch applied both ADDFB and ADDFB2 ioctls work correctly in
the virtio-gpu.ko driver on big endian machines.  Without the patch only
ADDFB (which still seems to be used by the majority of userspace) works
correctly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c |  4 +++
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  4 ++-
 drivers/gpu/drm/virtio/virtgpu_fb.c      |  2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c     |  7 +++--
 drivers/gpu/drm/virtio/virtgpu_plane.c   | 54 ++------------------------------
 5 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 25503b9335..f6c4af1db4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -306,6 +306,10 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	struct virtio_gpu_framebuffer *virtio_gpu_fb;
 	int ret;
 
+	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888 &&
+	    mode_cmd->pixel_format != DRM_FORMAT_HOST_ARGB8888)
+		return ERR_PTR(-ENOENT);
+
 	/* lookup object associated with res handle */
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (!obj)
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index d9287c144f..4b28f41ac1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -114,7 +114,9 @@ static const struct file_operations virtio_gpu_driver_fops = {
 };
 
 static struct drm_driver driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_RENDER | DRIVER_ATOMIC,
+	.driver_features = (DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME |
+			    DRIVER_RENDER | DRIVER_ATOMIC |
+			    DRIVER_PREFER_HOST_BYTE_ORDER),
 	.load = virtio_gpu_driver_load,
 	.unload = virtio_gpu_driver_unload,
 	.open = virtio_gpu_driver_open,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index a121b1c795..9d87ebd645 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -233,7 +233,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
 	mode_cmd.pitches[0] = mode_cmd.width * 4;
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(32, 24);
+	mode_cmd.pixel_format = DRM_FORMAT_HOST_XRGB8888;
 
 	format = virtio_gpu_translate_format(mode_cmd.pixel_format);
 	if (format == 0)
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 0f2768eaca..82c817f37c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -90,7 +90,10 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	uint32_t resid;
 	uint32_t format;
 
-	pitch = args->width * ((args->bpp + 1) / 8);
+	if (args->bpp != 32)
+		return -EINVAL;
+
+	pitch = args->width * 4;
 	args->size = pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
@@ -99,7 +102,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	if (ret)
 		goto fail;
 
-	format = virtio_gpu_translate_format(DRM_FORMAT_XRGB8888);
+	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	virtio_gpu_resource_id_get(vgdev, &resid);
 	virtio_gpu_cmd_create_resource(vgdev, resid, format,
 				       args->width, args->height);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index dc5b5b2b7a..3221d50b9a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -28,22 +28,11 @@
 #include <drm/drm_atomic_helper.h>
 
 static const uint32_t virtio_gpu_formats[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_BGRX8888,
-	DRM_FORMAT_BGRA8888,
-	DRM_FORMAT_RGBX8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_HOST_XRGB8888,
 };
 
 static const uint32_t virtio_gpu_cursor_formats[] = {
-#ifdef __BIG_ENDIAN
-	DRM_FORMAT_BGRA8888,
-#else
-	DRM_FORMAT_ARGB8888,
-#endif
+	DRM_FORMAT_HOST_ARGB8888,
 };
 
 uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
@@ -51,32 +40,6 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	uint32_t format;
 
 	switch (drm_fourcc) {
-#ifdef __BIG_ENDIAN
-	case DRM_FORMAT_XRGB8888:
-		format = VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM;
-		break;
-	case DRM_FORMAT_ARGB8888:
-		format = VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
-		break;
-	case DRM_FORMAT_BGRX8888:
-		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
-		break;
-	case DRM_FORMAT_BGRA8888:
-		format = VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
-		break;
-	case DRM_FORMAT_RGBX8888:
-		format = VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM;
-		break;
-	case DRM_FORMAT_RGBA8888:
-		format = VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM;
-		break;
-	case DRM_FORMAT_XBGR8888:
-		format = VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM;
-		break;
-	case DRM_FORMAT_ABGR8888:
-		format = VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM;
-		break;
-#else
 	case DRM_FORMAT_XRGB8888:
 		format = VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
 		break;
@@ -89,19 +52,6 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	case DRM_FORMAT_BGRA8888:
 		format = VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
 		break;
-	case DRM_FORMAT_RGBX8888:
-		format = VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM;
-		break;
-	case DRM_FORMAT_RGBA8888:
-		format = VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM;
-		break;
-	case DRM_FORMAT_XBGR8888:
-		format = VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM;
-		break;
-	case DRM_FORMAT_ABGR8888:
-		format = VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM;
-		break;
-#endif
 	default:
 		/*
 		 * This should not happen, we handle everything listed
-- 
2.9.3

