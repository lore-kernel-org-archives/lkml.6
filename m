Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161742AbeE1Kd3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161696AbeE1KdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:33:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 159/329] virtio-gpu: fix ioctl and expose the fixed status to userspace.
Date: Mon, 28 May 2018 12:01:28 +0200
Message-Id: <20180528100255.712266101@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit 9a191b114906457c4b2494c474f58ae4142d4e67 ]

This exposes to mesa that it can use the fixed ioctl for querying
later cap sets, cap set 1 is forever frozen in time.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20180221015003.22884-1-airlied@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |   17 +++++++++++------
 include/uapi/drm/virtgpu_drm.h         |    1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -194,6 +194,9 @@ static int virtio_gpu_getparam_ioctl(str
 	case VIRTGPU_PARAM_3D_FEATURES:
 		value = vgdev->has_virgl_3d == true ? 1 : 0;
 		break;
+	case VIRTGPU_PARAM_CAPSET_QUERY_FIX:
+		value = 1;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -469,7 +472,7 @@ static int virtio_gpu_get_caps_ioctl(str
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_get_caps *args = data;
-	int size;
+	unsigned size, host_caps_size;
 	int i;
 	int found_valid = -1;
 	int ret;
@@ -478,6 +481,10 @@ static int virtio_gpu_get_caps_ioctl(str
 	if (vgdev->num_capsets == 0)
 		return -ENOSYS;
 
+	/* don't allow userspace to pass 0 */
+	if (args->size == 0)
+		return -EINVAL;
+
 	spin_lock(&vgdev->display_info_lock);
 	for (i = 0; i < vgdev->num_capsets; i++) {
 		if (vgdev->capsets[i].id == args->cap_set_id) {
@@ -493,11 +500,9 @@ static int virtio_gpu_get_caps_ioctl(str
 		return -EINVAL;
 	}
 
-	size = vgdev->capsets[found_valid].max_size;
-	if (args->size > size) {
-		spin_unlock(&vgdev->display_info_lock);
-		return -EINVAL;
-	}
+	host_caps_size = vgdev->capsets[found_valid].max_size;
+	/* only copy to user the minimum of the host caps size or the guest caps size */
+	size = min(args->size, host_caps_size);
 
 	list_for_each_entry(cache_ent, &vgdev->cap_cache, head) {
 		if (cache_ent->id == args->cap_set_id &&
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -63,6 +63,7 @@ struct drm_virtgpu_execbuffer {
 };
 
 #define VIRTGPU_PARAM_3D_FEATURES 1 /* do we have 3D features in the hw */
+#define VIRTGPU_PARAM_CAPSET_QUERY_FIX 2 /* do we have the capset fix */
 
 struct drm_virtgpu_getparam {
 	__u64 param;
