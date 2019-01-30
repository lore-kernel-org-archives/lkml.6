Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C68C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD2520882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfA3Jnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:43:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730545AbfA3Jno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:43:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14BC57AE92;
        Wed, 30 Jan 2019 09:43:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-190.ams2.redhat.com [10.36.117.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC685D96F;
        Wed, 30 Jan 2019 09:43:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7B7417703; Wed, 30 Jan 2019 10:43:39 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/6] drm/virtio: drop fencing in virtio_gpu_resource_create_ioctl
Date:   Wed, 30 Jan 2019 10:43:37 +0100
Message-Id: <20190130094338.14203-6-kraxel@redhat.com>
In-Reply-To: <20190130094338.14203-1-kraxel@redhat.com>
References: <20190130094338.14203-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 30 Jan 2019 09:43:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to wait for completion here.

The host will process commands in submit order, so commands can
reference the new resource just fine even when queued up before
completion.

On the guest side there is no need to wait for completion too.  Which
btw is different from resource destroy, where we have to make sure the
host has seen the destroy and thus doesn't use it any more before
releasing the pages backing the resource.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 51 +---------------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 431e5d767e..da06ebbb3a 100644
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
 	struct virtio_gpu_object_params params = { 0 };
 
 	if (vgdev->has_virgl_3d == false) {
@@ -298,9 +294,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 	}
 
-	INIT_LIST_HEAD(&validate_list);
-	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
-
 	params.pinned = false,
 	params.format = rc->format;
 	params.width = rc->width;
@@ -329,62 +322,20 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
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

