Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83202C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581B22089F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581B22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeJARJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbeJARJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D15073091D55;
        Mon,  1 Oct 2018 10:32:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 160DE6E408;
        Mon,  1 Oct 2018 10:32:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 59A519D376; Mon,  1 Oct 2018 12:32:23 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/8] drm/virtio: drop resource_id argument from virtio_gpu_object_attach()
Date:   Mon,  1 Oct 2018 12:32:18 +0200
Message-Id: <20181001103222.11924-5-kraxel@redhat.com>
In-Reply-To: <20181001103222.11924-1-kraxel@redhat.com>
References: <20181001103222.11924-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 01 Oct 2018 10:32:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We pass the obj anyway, so obj->hw_res_handle can be used instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 1 -
 drivers/gpu/drm/virtio/virtgpu_fb.c    | 2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 ++--
 drivers/gpu/drm/virtio/virtgpu_ttm.c   | 3 +--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 4 +---
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d29f0c7c76..9b26e8ee84 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -285,7 +285,6 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 				uint32_t x, uint32_t y);
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
-			     uint32_t resource_id,
 			     struct virtio_gpu_fence **fence);
 void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
 			      struct virtio_gpu_object *obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index b1f37cba76..b16c62c4d8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -242,7 +242,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	}
 
 	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, obj->hw_res_handle, NULL);
+	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
 	if (ret)
 		goto err_obj_attach;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 2492f5a2e9..5450f7ab5b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -108,7 +108,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				       args->width, args->height);
 
 	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, obj->hw_res_handle, NULL);
+	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 4b76a0ec1a..44c9160c14 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -259,7 +259,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		virtio_gpu_cmd_create_resource(vgdev, qobj->hw_res_handle, rc->format,
 					       rc->width, rc->height);
 
-		ret = virtio_gpu_object_attach(vgdev, qobj, qobj->hw_res_handle, NULL);
+		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	} else {
 		/* use a gem reference since unref list undoes them */
 		drm_gem_object_get(&qobj->gem_base);
@@ -285,7 +285,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
 		virtio_gpu_cmd_resource_create_3d(vgdev, &rc_3d, NULL);
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
index 4e2e037aed..dd4464ccb1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -861,7 +861,6 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
-			     uint32_t resource_id,
 			     struct virtio_gpu_fence **fence)
 {
 	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
@@ -902,10 +901,9 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
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

