Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756256AbeEAR6t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:58:49 -0400
Received: from anholt.net ([50.246.234.109]:47624 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756032AbeEAR6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:58:48 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] v3d: fixup for submit alignment and check for zero flags in other ioctls.
Date: Tue,  1 May 2018 10:58:45 -0700
Message-Id: <20180501175845.14837-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430181058.30181-3-eric@anholt.net>
References: <20180430181058.30181-3-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---

airlied + danvet: this is the last change I think we need before I can
merge v3d with your acks.  Sending as a diff so you don't have to look
at the whole thing again.  Look good?

 drivers/gpu/drm/v3d/v3d_bo.c  | 10 ++++++++++
 drivers/gpu/drm/v3d/v3d_gem.c |  5 +++++
 include/uapi/drm/v3d_drm.h    |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 2be4e8b71604..7b1e2a549a71 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -325,6 +325,11 @@ int v3d_create_bo_ioctl(struct drm_device *dev, void *data,
 	struct v3d_bo *bo = NULL;
 	int ret;
 
+	if (args->flags != 0) {
+		DRM_INFO("unknown create_bo flags: %d\n", args->flags);
+		return -EINVAL;
+	}
+
 	bo = v3d_bo_create(dev, file_priv, PAGE_ALIGN(args->size));
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
@@ -344,6 +349,11 @@ int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
 	struct drm_gem_object *gem_obj;
 	int ret;
 
+	if (args->flags != 0) {
+		DRM_INFO("unknown mmap_bo flags: %d\n", args->flags);
+		return -EINVAL;
+	}
+
 	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
 	if (!gem_obj) {
 		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index fa39a1e35263..b513f9189caf 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -503,6 +503,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	struct drm_syncobj *sync_out;
 	int ret = 0;
 
+	if (args->pad != 0) {
+		DRM_INFO("pad must be zero: %d\n", args->pad);
+		return -EINVAL;
+	}
+
 	exec = kcalloc(1, sizeof(*exec), GFP_KERNEL);
 	if (!exec)
 		return -ENOMEM;
diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index 201a07645bdd..7b6627783608 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -101,6 +101,9 @@ struct drm_v3d_submit_cl {
 
 	/* Number of BO handles passed in (size is that times 4). */
 	__u32 bo_handle_count;
+
+	/* Pad, must be zero-filled. */
+	__u32 pad;
 };
 
 /**
-- 
2.17.0
