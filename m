Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2797ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C112086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C112086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeJSOXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:23:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbeJSOX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:23:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F833804E2;
        Fri, 19 Oct 2018 06:18:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-238.ams2.redhat.com [10.36.116.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C49C60851;
        Fri, 19 Oct 2018 06:18:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0C4BFB3D47; Fri, 19 Oct 2018 08:18:48 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/6] drm/virtio: drop resource_id argument.
Date:   Fri, 19 Oct 2018 08:18:46 +0200
Message-Id: <20181019061847.18958-6-kraxel@redhat.com>
In-Reply-To: <20181019061847.18958-1-kraxel@redhat.com>
References: <20181019061847.18958-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 19 Oct 2018 06:18:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We pass the obj anyway, so obj->hw_res_handle can be used instead
in virtio_gpu_object_attach() and virtio_gpu_cmd_create_resource().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 2 --
 drivers/gpu/drm/virtio/virtgpu_fb.c    | 4 ++--
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 4 ++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 6 +++---
 drivers/gpu/drm/virtio/virtgpu_ttm.c   | 3 +--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 7 ++-----
 6 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 5edc22d7a7..c6b0a938ba 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -265,7 +265,6 @@ void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
-				    uint32_t resource_id,
 				    uint32_t format,
 				    uint32_t width,
 				    uint32_t height);
@@ -287,7 +286,6 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 				uint32_t x, uint32_t y);
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
-			     uint32_t resource_id,
 			     struct virtio_gpu_fence **fence);
 void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
 			      struct virtio_gpu_object *obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index 800960bdd9..c22a8246b6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -232,7 +232,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 		return PTR_ERR(obj);
 
 	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
-	virtio_gpu_cmd_create_resource(vgdev, obj, obj->hw_res_handle, format,
+	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       mode_cmd.width, mode_cmd.height);
 
 	ret = virtio_gpu_object_kmap(obj);
@@ -242,7 +242,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	}
 
 	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, obj->hw_res_handle, NULL);
+	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
 	if (ret)
 		goto err_obj_attach;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 8d53451ec4..665d18a49d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -104,11 +104,11 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	obj = gem_to_virtio_gpu_obj(gobj);
 	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
-	virtio_gpu_cmd_create_resource(vgdev, obj, obj->hw_res_handle, format,
+	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       args->width, args->height);
 
 	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, obj->hw_res_handle, NULL);
+	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index ebb0920411..6179d93167 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -256,10 +256,10 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	virtio_gpu_resource_id_get(vgdev, &qobj->hw_res_handle);
 
 	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj, qobj->hw_res_handle, rc->format,
+		virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
 					       rc->width, rc->height);
 
-		ret = virtio_gpu_object_attach(vgdev, qobj, qobj->hw_res_handle, NULL);
+		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	} else {
 		/* use a gem reference since unref list undoes them */
 		drm_gem_object_get(&qobj->gem_base);
@@ -285,7 +285,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d, NULL);
-		ret = virtio_gpu_object_attach(vgdev, qobj, qobj->hw_res_handle, &fence);
+		ret = virtio_gpu_object_attach(vgdev, qobj, &fence);
 		if (ret) {
 			ttm_eu_backoff_reservation(&ticket, &validate_list);
 			goto fail_unref;
diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index e3152d45c5..cd63dffa6d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -347,8 +347,7 @@ static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
 
 	} else if (new_mem->placement & TTM_PL_FLAG_TT) {
 		if (bo->hw_res_handle) {
-			virtio_gpu_object_attach(vgdev, bo, bo->hw_res_handle,
-						 NULL);
+			virtio_gpu_object_attach(vgdev, bo, NULL);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 3b6904c5b3..ea3d13793d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -389,7 +389,6 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 /* create a basic resource */
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
-				    uint32_t resource_id,
 				    uint32_t format,
 				    uint32_t width,
 				    uint32_t height)
@@ -401,7 +400,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	cmd_p->format = cpu_to_le32(format);
 	cmd_p->width = cpu_to_le32(width);
 	cmd_p->height = cpu_to_le32(height);
@@ -865,7 +864,6 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
-			     uint32_t resource_id,
 			     struct virtio_gpu_fence **fence)
 {
 	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
@@ -909,10 +907,9 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 		ents[si].padding = 0;
 	}
 
-	virtio_gpu_cmd_resource_attach_backing(vgdev, resource_id,
+	virtio_gpu_cmd_resource_attach_backing(vgdev, obj->hw_res_handle,
 					       ents, nents,
 					       fence);
-	obj->hw_res_handle = resource_id;
 	return 0;
 }
 
-- 
2.9.3

