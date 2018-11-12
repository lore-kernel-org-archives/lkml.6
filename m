Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C1C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281D122419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281D122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbeKMCqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:46:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54988 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeKMCqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:46:12 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8109:92c0:207d:68ed:6b77:5dd1:d3e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A5E9F27E98C;
        Mon, 12 Nov 2018 16:52:07 +0000 (GMT)
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH v5 2/4] drm/virtio: add uapi for in and out explicit fences
Date:   Mon, 12 Nov 2018 17:51:55 +0100
Message-Id: <20181112165157.32765-3-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112165157.32765-1-robert.foss@collabora.com>
References: <20181112165157.32765-1-robert.foss@collabora.com>
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
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---

Changes since v4:
 - Emil/Gerd: Improved commit message and fence_fd comment

Changes since v3:
 - Emil: Move fence_fd assignment to after sanity checks
 - Emil: Added r-b


 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
 include/uapi/drm/virtgpu_drm.h         | 13 ++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d69fc356df0a..3d497835b0f5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -119,6 +119,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	if (vgdev->has_virgl_3d == false)
 		return -ENOSYS;
 
+	if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
+		return -EINVAL;
+
+	exbuf->fence_fd = -1;
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

