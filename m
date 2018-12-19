Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C80DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D792184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeLSM1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:27:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbeLSM1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D522383F4C;
        Wed, 19 Dec 2018 12:27:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65BDE17D09;
        Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 61988422F6; Wed, 19 Dec 2018 13:27:10 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/10] drm/virtio: move virtio_gpu_cmd_create_resource call into virtio_gpu_object_create
Date:   Wed, 19 Dec 2018 13:27:07 +0100
Message-Id: <20181219122708.4586-10-kraxel@redhat.com>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 19 Dec 2018 12:27:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifically call virtio_gpu_object_create() before ttm_bo_init().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 ++
 drivers/gpu/drm/virtio/virtgpu_gem.c    |  3 +--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 10 ++--------
 drivers/gpu/drm/virtio/virtgpu_object.c | 10 ++++++++--
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f9959306ae..f50ca81132 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -59,7 +59,9 @@ struct virtio_gpu_object_params {
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
index eea6c6e8db..ca84990382 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -102,20 +102,19 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	params.width = args->width;
 	params.height = args->height;
 	params.size = args->size;
+	params.dumb = true;
 	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
 				    &args->handle);
 	if (ret)
 		goto fail;
 
 	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_cmd_create_resource(vgdev, obj, &params);
 
 	/* attach the object to the resource */
 	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
 	if (ret)
 		goto fail;
 
-	obj->dumb = true;
 	args->pitch = pitch;
 	return ret;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 65ac61f86a..e5bd1fed56 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -301,6 +301,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	params.height = rc->height;
 	params.size = rc->size;
 	if (vgdev->has_virgl_3d) {
+		params.virgl = true;
 		params.target = rc->target;
 		params.bind = rc->bind;
 		params.depth = rc->depth;
@@ -318,14 +319,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
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
+	ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
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
-- 
2.9.3

