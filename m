Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72777ECDE48
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46271208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46271208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJZDLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:11:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43632 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeJZDLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:11:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: robertfoss)
        with ESMTPSA id 9B3BF27A4BE
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH 4/5] drm/virtio: add out-fences support for explicit synchronization
Date:   Thu, 25 Oct 2018 20:37:38 +0200
Message-Id: <20181025183739.9375-5-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025183739.9375-1-robert.foss@collabora.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

On the out-fence side we get fence returned by the submitted draw call
and attach it to a sync_file and send the sync_file fd to userspace. On
error -1 is returned to userspace.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
Suggested-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 50 +++++++++++++++++++-------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 0368195966aa..32e714a1c753 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -106,7 +106,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
 	struct drm_gem_object *gobj;
-	struct virtio_gpu_fence *fence;
+	struct virtio_gpu_fence *out_fence;
 	struct virtio_gpu_object *qobj;
 	int ret;
 	uint32_t *bo_handles = NULL;
@@ -116,7 +116,9 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	int i;
 	struct ww_acquire_ctx ticket;
 	struct dma_fence *in_fence = NULL;
+	struct sync_file *sync_file;
 	int in_fence_fd = exbuf->fence_fd;
+	int out_fence_fd = -1;
 	void *buf;
 
 	exbuf->fence_fd = -1;
@@ -143,6 +145,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
+		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
+		if (out_fence_fd < 0) {
+			ret = out_fence_fd;
+			goto out_in_fence;
+		}
+	}
+
 	INIT_LIST_HEAD(&validate_list);
 	if (exbuf->num_bo_handles) {
 
@@ -153,21 +163,21 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 					   GFP_KERNEL | __GFP_ZERO);
 		if (!bo_handles || !buflist) {
 			ret = -ENOMEM;
-			goto out_in_fence;
+			goto out_unused_fd;
 		}
 
 		user_bo_handles = (void __user *)(uintptr_t)exbuf->bo_handles;
 		if (copy_from_user(bo_handles, user_bo_handles,
 				   exbuf->num_bo_handles * sizeof(uint32_t))) {
 			ret = -EFAULT;
-			goto out_in_fence;
+			goto out_unused_fd;
 		}
 
 		for (i = 0; i < exbuf->num_bo_handles; i++) {
 			gobj = drm_gem_object_lookup(drm_file, bo_handles[i]);
 			if (!gobj) {
 				ret = -ENOENT;
-				goto out_in_fence;
+				goto out_unused_fd;
 			}
 
 			qobj = gem_to_virtio_gpu_obj(gobj);
@@ -190,11 +200,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
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
 
 	if (in_fence) {
@@ -203,23 +224,28 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	}
 
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-			      vfpriv->ctx_id, fence);
+			      vfpriv->ctx_id, out_fence);
 
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
-out_in_fence:
+out_unused_fd:
 	kvfree(bo_handles);
 	kvfree(buflist);
+
+	if (out_fence_fd >= 0)
+		put_unused_fd(out_fence_fd);
+out_in_fence:
 	dma_fence_put(in_fence);
 	return ret;
 }
-- 
2.17.1

