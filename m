Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79892C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC9220672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC9220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeLEKxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:53:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbeLEKxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:53:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81B1C804F2;
        Wed,  5 Dec 2018 10:53:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77D6582EDE;
        Wed,  5 Dec 2018 10:53:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 39E9E9D2E; Wed,  5 Dec 2018 11:53:18 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/virtio: drop virtio_gpu_fence_cleanup()
Date:   Wed,  5 Dec 2018 11:53:17 +0100
Message-Id: <20181205105317.15138-4-kraxel@redhat.com>
In-Reply-To: <20181205105317.15138-1-kraxel@redhat.com>
References: <20181205105317.15138-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 05 Dec 2018 10:53:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just call drm_fence_put directly instead.
Also set vgfb->fence to NULL after dropping the reference.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 1 -
 drivers/gpu/drm/virtio/virtgpu_fence.c | 8 --------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c | 6 ++++--
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 1deb41d42e..551860497f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -351,7 +351,6 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
 /* virtio_gpu_fence.c */
 struct virtio_gpu_fence *virtio_gpu_fence_alloc(
 	struct virtio_gpu_device *vgdev);
-void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence);
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 4d6826b278..21bd4c4a32 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -81,14 +81,6 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
 	return fence;
 }
 
-void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence)
-{
-	if (!fence)
-		return;
-
-	dma_fence_put(&fence->f);
-}
-
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence)
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 161b80fee4..14ce8188c0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -351,7 +351,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d);
 		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
 		if (ret) {
-			virtio_gpu_fence_cleanup(fence);
+			dma_fence_put(&fence->f);
 			goto fail_backoff;
 		}
 		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 548265b8e8..024c2aa0c9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -169,8 +169,10 @@ static void virtio_gpu_cursor_cleanup_fb(struct drm_plane *plane,
 		return;
 
 	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
-	if (vgfb->fence)
-		virtio_gpu_fence_cleanup(vgfb->fence);
+	if (vgfb->fence) {
+		dma_fence_put(&vgfb->fence->f);
+		vgfb->fence = NULL;
+	}
 }
 
 static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
-- 
2.9.3

