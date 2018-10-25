Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E404ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E84220665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E84220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJZDLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:11:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJZDLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:11:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: robertfoss)
        with ESMTPSA id A76482756E8
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
Date:   Thu, 25 Oct 2018 20:37:36 +0200
Message-Id: <20181025183739.9375-3-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025183739.9375-1-robert.foss@collabora.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new field called fence_fd that will be used by userspace to send
in-fences to the kernel and receive out-fences created by the kernel.

This uapi enables virtio to take advantage of explicit synchronization of
dma-bufs.

There are two new flags:

* VIRTGPU_EXECBUF_FENCE_FD_IN to be used when passing an in-fence fd.
* VIRTGPU_EXECBUF_FENCE_FD_OUT to be used when requesting an out-fence fd

The execbuffer IOCTL is now read-write to allow the userspace to read the
out-fence.

On error -1 should be returned in the fence_fd field.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
---
Changes since v2:
 - Since exbuf-flags is a new flag, check that unsupported
   flags aren't set.

 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
 include/uapi/drm/virtgpu_drm.h         | 13 ++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d01a9ed100d1..1af289b28fc4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -116,9 +116,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct ww_acquire_ctx ticket;
 	void *buf;
 
+	exbuf->fence_fd = -1;
+
 	if (vgdev->has_virgl_3d == false)
 		return -ENOSYS;
 
+	if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&validate_list);
 	if (exbuf->num_bo_handles) {
 
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 9a781f0611df..91062f4ac7c5 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -47,6 +47,13 @@ extern "C" {
 #define DRM_VIRTGPU_WAIT     0x08
 #define DRM_VIRTGPU_GET_CAPS  0x09
 
+#define VIRTGPU_EXECBUF_FENCE_FD_IN	0x01
+#define VIRTGPU_EXECBUF_FENCE_FD_OUT	0x02
+#define VIRTGPU_EXECBUF_FLAGS  (\
+		VIRTGPU_EXECBUF_FENCE_FD_IN |\
+		VIRTGPU_EXECBUF_FENCE_FD_OUT |\
+		0)
+
 struct drm_virtgpu_map {
 	__u64 offset; /* use for mmap system call */
 	__u32 handle;
@@ -54,12 +61,12 @@ struct drm_virtgpu_map {
 };
 
 struct drm_virtgpu_execbuffer {
-	__u32		flags;		/* for future use */
+	__u32 flags;
 	__u32 size;
 	__u64 command; /* void* */
 	__u64 bo_handles;
 	__u32 num_bo_handles;
-	__u32 pad;
+	__s32 fence_fd;
 };
 
 #define VIRTGPU_PARAM_3D_FEATURES 1 /* do we have 3D features in the hw */
@@ -137,7 +144,7 @@ struct drm_virtgpu_get_caps {
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_MAP, struct drm_virtgpu_map)
 
 #define DRM_IOCTL_VIRTGPU_EXECBUFFER \
-	DRM_IOW(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
 		struct drm_virtgpu_execbuffer)
 
 #define DRM_IOCTL_VIRTGPU_GETPARAM \
-- 
2.17.1

