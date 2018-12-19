Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E53C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA3C204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeLSM10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:27:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbeLSM1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47FD4C052504;
        Wed, 19 Dec 2018 12:27:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFCD7608EE;
        Wed, 19 Dec 2018 12:27:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2E40B41C84; Wed, 19 Dec 2018 13:27:10 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/10] drm/virtio: drop fencing in virtio_gpu_resource_create_ioctl
Date:   Wed, 19 Dec 2018 13:27:06 +0100
Message-Id: <20181219122708.4586-9-kraxel@redhat.com>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 19 Dec 2018 12:27:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to wait for completion here.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 51 +---------------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 52d6ec2dde..65ac61f86a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -279,10 +279,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_object *qobj;
 	struct drm_gem_object *obj;
 	uint32_t handle = 0;
-	struct list_head validate_list;
-	struct ttm_validate_buffer mainbuf;
-	struct virtio_gpu_fence *fence = NULL;
-	struct ww_acquire_ctx ticket;
 	struct virtio_gpu_object_params params = {
 		.pinned = false,
 	};
@@ -300,9 +296,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 	}
 
-	INIT_LIST_HEAD(&validate_list);
-	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
-
 	params.format = rc->format;
 	params.width = rc->width;
 	params.height = rc->height;
@@ -330,62 +323,20 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
 		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	} else {
-		/* use a gem reference since unref list undoes them */
-		drm_gem_object_get(&qobj->gem_base);
-		mainbuf.bo = &qobj->tbo;
-		list_add(&mainbuf.head, &validate_list);
-
-		ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
-		if (ret) {
-			DRM_DEBUG("failed to validate\n");
-			goto fail_unref;
-		}
-
-		fence = virtio_gpu_fence_alloc(vgdev);
-		if (!fence) {
-			ret = -ENOMEM;
-			goto fail_backoff;
-		}
-
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &params);
-		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
-		if (ret) {
-			dma_fence_put(&fence->f);
-			goto fail_backoff;
-		}
-		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
+		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	}
 
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
-
 		drm_gem_object_release(obj);
-		if (vgdev->has_virgl_3d) {
-			virtio_gpu_unref_list(&validate_list);
-			dma_fence_put(&fence->f);
-		}
 		return ret;
 	}
 	drm_gem_object_put_unlocked(obj);
 
 	rc->res_handle = qobj->hw_res_handle; /* similiar to a VM address */
 	rc->bo_handle = handle;
-
-	if (vgdev->has_virgl_3d) {
-		virtio_gpu_unref_list(&validate_list);
-		dma_fence_put(&fence->f);
-	}
 	return 0;
-fail_backoff:
-	ttm_eu_backoff_reservation(&ticket, &validate_list);
-fail_unref:
-	if (vgdev->has_virgl_3d) {
-		virtio_gpu_unref_list(&validate_list);
-		dma_fence_put(&fence->f);
-	}
-//fail_obj:
-//	drm_gem_object_handle_unreference_unlocked(obj);
-	return ret;
 }
 
 static int virtio_gpu_resource_info_ioctl(struct drm_device *dev, void *data,
-- 
2.9.3

