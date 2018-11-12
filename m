Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901EBC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3522504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE3522504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeKMCqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:46:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55000 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMCqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:46:13 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8109:92c0:207d:68ed:6b77:5dd1:d3e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 229BA27E98D;
        Mon, 12 Nov 2018 16:52:08 +0000 (GMT)
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH v5 3/4] drm/virtio: add in/out fence support for explicit synchronization
Date:   Mon, 12 Nov 2018 17:51:56 +0100
Message-Id: <20181112165157.32765-4-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112165157.32765-1-robert.foss@collabora.com>
References: <20181112165157.32765-1-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the execbuf call receives an in-fence it will get the dma_fence
related to that fence fd and wait on it before submitting the draw call.

On the out-fence side we get fence returned by the submitted draw call
and attach it to a sync_file and send the sync_file fd to userspace. On
error -1 is returned to userspace.

VIRTGPU_EXECBUF_FENCE_FD_IN & VIRTGPU_EXECBUF_FENCE_FD_OUT
are supported at the simultaneously and can be flagged
for simultaneously.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---

Changes since v3:
 - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
 - Emil: Make sure to always call dma_fence_put()
 - Emil: Added r-b


 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 81 ++++++++++++++++++++------
 include/uapi/drm/virtgpu_drm.h         |  2 +-
 2 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d497835b0f5..340f2513d829 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -28,6 +28,7 @@
 #include <drm/drmP.h>
 #include <drm/virtgpu_drm.h>
 #include <drm/ttm/ttm_execbuf_util.h>
+#include <linux/sync_file.h>
 
 #include "virtgpu_drv.h"
 
@@ -105,7 +106,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
 	struct drm_gem_object *gobj;
-	struct virtio_gpu_fence *fence;
+	struct virtio_gpu_fence *out_fence;
 	struct virtio_gpu_object *qobj;
 	int ret;
 	uint32_t *bo_handles = NULL;
@@ -114,6 +115,9 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct ttm_validate_buffer *buflist = NULL;
 	int i;
 	struct ww_acquire_ctx ticket;
+	struct sync_file *sync_file;
+	int in_fence_fd = exbuf->fence_fd;
+	int out_fence_fd = -1;
 	void *buf;
 
 	if (vgdev->has_virgl_3d == false)
@@ -124,6 +128,33 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	exbuf->fence_fd = -1;
 
+	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
+		struct dma_fence *in_fence;
+
+		in_fence = sync_file_get_fence(in_fence_fd);
+
+		if (!in_fence)
+			return -EINVAL;
+
+		/*
+		 * Wait if the fence is from a foreign context, or if the fence
+		 * array contains any fence from a foreign context.
+		 */
+		ret = 0;
+		if (!dma_fence_match_context(in_fence, vgdev->fence_drv.context))
+			ret = dma_fence_wait(in_fence, true);
+
+		dma_fence_put(in_fence);
+		if (ret)
+			return ret;
+	}
+
+	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
+		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
+		if (out_fence_fd < 0)
+			return out_fence_fd;
+	}
+
 	INIT_LIST_HEAD(&validate_list);
 	if (exbuf->num_bo_handles) {
 
@@ -133,26 +164,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 					   sizeof(struct ttm_validate_buffer),
 					   GFP_KERNEL | __GFP_ZERO);
 		if (!bo_handles || !buflist) {
-			kvfree(bo_handles);
-			kvfree(buflist);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out_unused_fd;
 		}
 
 		user_bo_handles = (void __user *)(uintptr_t)exbuf->bo_handles;
 		if (copy_from_user(bo_handles, user_bo_handles,
 				   exbuf->num_bo_handles * sizeof(uint32_t))) {
 			ret = -EFAULT;
-			kvfree(bo_handles);
-			kvfree(buflist);
-			return ret;
+			goto out_unused_fd;
 		}
 
 		for (i = 0; i < exbuf->num_bo_handles; i++) {
 			gobj = drm_gem_object_lookup(drm_file, bo_handles[i]);
 			if (!gobj) {
-				kvfree(bo_handles);
-				kvfree(buflist);
-				return -ENOENT;
+				ret = -ENOENT;
+				goto out_unused_fd;
 			}
 
 			qobj = gem_to_virtio_gpu_obj(gobj);
@@ -161,6 +188,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 			list_add(&buflist[i].head, &validate_list);
 		}
 		kvfree(bo_handles);
+		bo_handles = NULL;
 	}
 
 	ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
@@ -174,28 +202,47 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		goto out_unresv;
 	}
 
-	fence = virtio_gpu_fence_alloc(vgdev);
-	if (!fence) {
-		kfree(buf);
+	out_fence = virtio_gpu_fence_alloc(vgdev);
+	if(!out_fence) {
 		ret = -ENOMEM;
-		goto out_unresv;
+		goto out_memdup;
+	}
+
+	if (out_fence_fd >= 0) {
+		sync_file = sync_file_create(&out_fence->f);
+		if (!sync_file) {
+			dma_fence_put(&out_fence->f);
+			ret = -ENOMEM;
+			goto out_memdup;
+		}
+
+		exbuf->fence_fd = out_fence_fd;
+		fd_install(out_fence_fd, sync_file->file);
 	}
+
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-			      vfpriv->ctx_id, &fence);
+			      vfpriv->ctx_id, &out_fence);
 
-	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
+	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
 
 	/* fence the command bo */
 	virtio_gpu_unref_list(&validate_list);
 	kvfree(buflist);
-	dma_fence_put(&fence->f);
 	return 0;
 
+out_memdup:
+	kfree(buf);
 out_unresv:
 	ttm_eu_backoff_reservation(&ticket, &validate_list);
 out_free:
 	virtio_gpu_unref_list(&validate_list);
+out_unused_fd:
+	kvfree(bo_handles);
 	kvfree(buflist);
+
+	if (out_fence_fd >= 0)
+		put_unused_fd(out_fence_fd);
+
 	return ret;
 }
 
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 91062f4ac7c5..f06a789f34cd 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -66,7 +66,7 @@ struct drm_virtgpu_execbuffer {
 	__u64 command; /* void* */
 	__u64 bo_handles;
 	__u32 num_bo_handles;
-	__s32 fence_fd;
+	__s32 fence_fd; /* in/out fence fd (see VIRTGPU_EXECBUF_FENCE_FD_IN/OUT) */
 };
 
 #define VIRTGPU_PARAM_3D_FEATURES 1 /* do we have 3D features in the hw */
-- 
2.17.1

