Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE3ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D582F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D582F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJZDMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:12:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeJZDLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:11:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: robertfoss)
        with ESMTPSA id 2685A279673
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH 3/5] drm/virtio: add in-fences support for explicit synchronization
Date:   Thu, 25 Oct 2018 20:37:37 +0200
Message-Id: <20181025183739.9375-4-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025183739.9375-1-robert.foss@collabora.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

When the execbuf call receives an in-fence it will get the dma_fence
related to that fence fd and wait on it before submitting the draw call.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
Suggested-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 43 ++++++++++++++++++++------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 1af289b28fc4..0368195966aa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -28,6 +28,7 @@
 #include <drm/drmP.h>
 #include <drm/virtgpu_drm.h>
 #include <drm/ttm/ttm_execbuf_util.h>
+#include <linux/sync_file.h>
 
 #include "virtgpu_drv.h"
 
@@ -114,6 +115,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct ttm_validate_buffer *buflist = NULL;
 	int i;
 	struct ww_acquire_ctx ticket;
+	struct dma_fence *in_fence = NULL;
+	int in_fence_fd = exbuf->fence_fd;
 	void *buf;
 
 	exbuf->fence_fd = -1;
@@ -124,6 +127,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
 		return -EINVAL;
 
+	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
+		in_fence = sync_file_get_fence(in_fence_fd);
+		if (!in_fence)
+			return -EINVAL;
+
+		/*
+		 * Wait if the fence is from a foreign context, or if the fence
+		 * array contains any fence from a foreign context.
+		 */
+		if (!dma_fence_match_context(in_fence, vgdev->fence_drv.context)) {
+			ret = dma_fence_wait(in_fence, true);
+			if (ret)
+				return ret;
+		}
+	}
+
 	INIT_LIST_HEAD(&validate_list);
 	if (exbuf->num_bo_handles) {
 
@@ -133,26 +152,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 					   sizeof(struct ttm_validate_buffer),
 					   GFP_KERNEL | __GFP_ZERO);
 		if (!bo_handles || !buflist) {
-			kvfree(bo_handles);
-			kvfree(buflist);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out_in_fence;
 		}
 
 		user_bo_handles = (void __user *)(uintptr_t)exbuf->bo_handles;
 		if (copy_from_user(bo_handles, user_bo_handles,
 				   exbuf->num_bo_handles * sizeof(uint32_t))) {
 			ret = -EFAULT;
-			kvfree(bo_handles);
-			kvfree(buflist);
-			return ret;
+			goto out_in_fence;
 		}
 
 		for (i = 0; i < exbuf->num_bo_handles; i++) {
 			gobj = drm_gem_object_lookup(drm_file, bo_handles[i]);
 			if (!gobj) {
-				kvfree(bo_handles);
-				kvfree(buflist);
-				return -ENOENT;
+				ret = -ENOENT;
+				goto out_in_fence;
 			}
 
 			qobj = gem_to_virtio_gpu_obj(gobj);
@@ -161,6 +176,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 			list_add(&buflist[i].head, &validate_list);
 		}
 		kvfree(bo_handles);
+		bo_handles = NULL;
 	}
 
 	ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
@@ -180,6 +196,12 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		ret = -ENOMEM;
 		goto out_unresv;
 	}
+
+	if (in_fence) {
+		dma_fence_put(in_fence);
+		in_fence = NULL;
+	}
+
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
 			      vfpriv->ctx_id, fence);
 
@@ -195,7 +217,10 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	ttm_eu_backoff_reservation(&ticket, &validate_list);
 out_free:
 	virtio_gpu_unref_list(&validate_list);
+out_in_fence:
+	kvfree(bo_handles);
 	kvfree(buflist);
+	dma_fence_put(in_fence);
 	return ret;
 }
 
-- 
2.17.1

