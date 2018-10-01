Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4064D2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4064D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeJARJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbeJARJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:09:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93088308AA14;
        Mon,  1 Oct 2018 10:32:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB3661001F41;
        Mon,  1 Oct 2018 10:32:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D63F99D365; Mon,  1 Oct 2018 12:32:24 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/8] drm/virtio: move objects to TTM_PL_TT after creation
Date:   Mon,  1 Oct 2018 12:32:22 +0200
Message-Id: <20181001103222.11924-9-kraxel@redhat.com>
In-Reply-To: <20181001103222.11924-1-kraxel@redhat.com>
References: <20181001103222.11924-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 01 Oct 2018 10:32:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize objects with TTM_PL_FLAG_SYSTEM placement, move them over to
TTM_PL_FLAG_TT after they are created (i.e. registered in the host).
That way the ttm backend will handle attach/detach just fine and we
don't need the extra virtio_gpu_object_attach() calls.

TODO: check ioctl fence.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  1 +
 drivers/gpu/drm/virtio/virtgpu_fb.c     |  5 ++---
 drivers/gpu/drm/virtio/virtgpu_gem.c    |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 13 +++++++++---
 drivers/gpu/drm/virtio/virtgpu_object.c | 35 ++++++++++++++++++++++++++++++++-
 5 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 1c321e484d..554d887c6d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -360,6 +360,7 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
 int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			     unsigned long size, bool kernel, bool pinned,
 			     struct virtio_gpu_object **bo_ptr);
+int virtio_gpu_object_move(struct virtio_gpu_object *vgbo);
 void virtio_gpu_object_kunmap(struct virtio_gpu_object *bo);
 int virtio_gpu_object_kmap(struct virtio_gpu_object *bo);
 int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index fb1cc8b2f1..4dd01520be 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -240,8 +240,8 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 		goto err_obj_vmap;
 	}
 
-	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
+	/* attach the object to the resource (via ttm backend) */
+	ret = virtio_gpu_object_move(obj);
 	if (ret)
 		goto err_obj_attach;
 
@@ -277,7 +277,6 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	return 0;
 
 err_fb_alloc:
-	virtio_gpu_object_detach(vgdev, obj);
 err_obj_attach:
 err_obj_vmap:
 	virtio_gpu_gem_free_object(&obj->gem_base);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index f065863939..e3f0c46cbf 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -106,8 +106,8 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       args->width, args->height);
 
-	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
+	/* attach the object to the resource (via ttm backend) */
+	ret = virtio_gpu_object_move(obj);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 681edd9c92..55baad8e90 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -258,7 +258,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
 					       rc->width, rc->height);
 
-		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
+		ret = virtio_gpu_object_move(qobj);
 	} else {
 		/* use a gem reference since unref list undoes them */
 		drm_gem_object_get(&qobj->gem_base);
@@ -285,12 +285,17 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
 		virtio_gpu_cmd_resource_create_3d(vgdev, &rc_3d, NULL);
 		qobj->created = true;
+#if 1
+		ret = virtio_gpu_object_move(qobj);
+		ttm_eu_backoff_reservation(&ticket, &validate_list);
+#else
 		ret = virtio_gpu_object_attach(vgdev, qobj, &fence);
 		if (ret) {
 			ttm_eu_backoff_reservation(&ticket, &validate_list);
 			goto fail_unref;
 		}
 		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
+#endif
 	}
 
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
@@ -299,7 +304,8 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		drm_gem_object_release(obj);
 		if (vgdev->has_virgl_3d) {
 			virtio_gpu_unref_list(&validate_list);
-			dma_fence_put(&fence->f);
+			if (fence)
+				dma_fence_put(&fence->f);
 		}
 		return ret;
 	}
@@ -310,7 +316,8 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
 	if (vgdev->has_virgl_3d) {
 		virtio_gpu_unref_list(&validate_list);
-		dma_fence_put(&fence->f);
+		if (fence)
+			dma_fence_put(&fence->f);
 	}
 	return 0;
 fail_unref:
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 8bd1ebe13b..0c2fc10859 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -75,12 +75,45 @@ static void virtio_gpu_init_ttm_placement(struct virtio_gpu_object *vgbo,
 	vgbo->placement_code.fpfn = 0;
 	vgbo->placement_code.lpfn = 0;
 	vgbo->placement_code.flags =
-		TTM_PL_MASK_CACHING | TTM_PL_FLAG_TT | pflag;
+		TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM | pflag;
 	vgbo->placement.num_placement = c;
 	vgbo->placement.num_busy_placement = c;
 
 }
 
+int virtio_gpu_object_move(struct virtio_gpu_object *vgbo)
+{
+	struct ttm_operation_ctx ctx = { true, true };
+	struct ttm_place placement_memtype = {
+		.fpfn = 0,
+		.lpfn = 0,
+		.flags = vgbo->placement_code.flags,
+	};
+	struct ttm_placement placement;
+	struct ttm_mem_reg new_reg = { 0 };
+	int ret;
+
+	placement_memtype.flags &= ~TTM_PL_MASK_MEM;
+	placement_memtype.flags |= TTM_PL_FLAG_TT;
+
+	placement.num_placement = placement.num_busy_placement = 1;
+	placement.placement = placement.busy_placement = &placement_memtype;
+
+	ret = ttm_bo_mem_space(&vgbo->tbo, &placement, &new_reg, &ctx);
+	if (ret) {
+		DRM_INFO("%s: ttm_bo_mem_space: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = ttm_bo_move_ttm(&vgbo->tbo, &ctx, &new_reg);
+	if (ret) {
+		DRM_INFO("%s: ttm_bo_move_ttm: %d\n", __func__, ret);
+		ttm_bo_mem_put(&vgbo->tbo, &new_reg);
+	}
+
+	return ret;
+}
+
 int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			     unsigned long size, bool kernel, bool pinned,
 			     struct virtio_gpu_object **bo_ptr)
-- 
2.9.3

