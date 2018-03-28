Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeC1TJE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:09:04 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:43302 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753901AbeC1TJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:09:00 -0400
X-Google-Smtp-Source: AIpwx4+NmzQ66+XY07/b0tcOeq8HP8vsrUB5hd2phuSAYLVKVQ6W+omvGfbmomOjMqmS8p0wtgx/+w==
From: Sean Paul <seanpaul@chromium.org>
To: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, architt@codeaurora.org,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] drm/msm: Switch to atomic_helper_commit()
Date: Wed, 28 Mar 2018 15:06:52 -0400
Message-Id: <20180328190657.218661-7-seanpaul@chromium.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328190657.218661-1-seanpaul@chromium.org>
References: <20180328190657.218661-1-seanpaul@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all of the msm-specific goo is tucked safely away we can switch
over to using the atomic helper commit directly. \o/

Changes in v2:
- None

Cc: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/msm/msm_atomic.c | 120 +------------------------------
 drivers/gpu/drm/msm/msm_drv.c    |   7 +-
 drivers/gpu/drm/msm/msm_drv.h    |   3 +-
 3 files changed, 8 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 52249565cc03..d593ac3de1df 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -17,8 +17,6 @@
 
 #include "msm_drv.h"
 #include "msm_kms.h"
-#include "msm_gem.h"
-#include "msm_fence.h"
 
 static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
 		struct drm_atomic_state *old_state)
@@ -37,7 +35,7 @@ static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
 	}
 }
 
-static void msm_atomic_commit_tail(struct drm_atomic_state *state)
+void msm_atomic_commit_tail(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
 	struct msm_drm_private *priv = dev->dev_private;
@@ -74,119 +72,3 @@ static void msm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 }
-
-/* The (potentially) asynchronous part of the commit.  At this point
- * nothing can fail short of armageddon.
- */
-static void commit_tail(struct drm_atomic_state *state)
-{
-	drm_atomic_helper_wait_for_fences(state->dev, state, false);
-
-	drm_atomic_helper_wait_for_dependencies(state);
-
-	msm_atomic_commit_tail(state);
-
-	drm_atomic_helper_commit_cleanup_done(state);
-
-	drm_atomic_state_put(state);
-}
-
-static void commit_work(struct work_struct *work)
-{
-	struct drm_atomic_state *state = container_of(work,
-						      struct drm_atomic_state,
-						      commit_work);
-	commit_tail(state);
-}
-
-/**
- * drm_atomic_helper_commit - commit validated state object
- * @dev: DRM device
- * @state: the driver state object
- * @nonblock: nonblocking commit
- *
- * This function commits a with drm_atomic_helper_check() pre-validated state
- * object. This can still fail when e.g. the framebuffer reservation fails.
- *
- * RETURNS
- * Zero for success or -errno.
- */
-int msm_atomic_commit(struct drm_device *dev,
-		struct drm_atomic_state *state, bool nonblock)
-{
-	struct msm_drm_private *priv = dev->dev_private;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *crtc_state;
-	struct drm_plane *plane;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
-	int i, ret;
-
-	/*
-	 * Note that plane->atomic_async_check() should fail if we need
-	 * to re-assign hwpipe or anything that touches global atomic
-	 * state, so we'll never go down the async update path in those
-	 * cases.
-	 */
-	if (state->async_update) {
-		ret = drm_atomic_helper_prepare_planes(dev, state);
-		if (ret)
-			return ret;
-
-		drm_atomic_helper_async_commit(dev, state);
-		drm_atomic_helper_cleanup_planes(dev, state);
-		return 0;
-	}
-
-	ret = drm_atomic_helper_setup_commit(state, nonblock);
-	if (ret)
-		return ret;
-
-	INIT_WORK(&state->commit_work, commit_work);
-
-	ret = drm_atomic_helper_prepare_planes(dev, state);
-	if (ret)
-		return ret;
-
-	if (!nonblock) {
-		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
-		if (ret)
-			goto error;
-	}
-
-	/*
-	 * This is the point of no return - everything below never fails except
-	 * when the hw goes bonghits. Which means we can commit the new state on
-	 * the software side now.
-	 *
-	 * swap driver private state while still holding state_lock
-	 */
-	BUG_ON(drm_atomic_helper_swap_state(state, true) < 0);
-
-	/*
-	 * Everything below can be run asynchronously without the need to grab
-	 * any modeset locks at all under one conditions: It must be guaranteed
-	 * that the asynchronous work has either been cancelled (if the driver
-	 * supports it, which at least requires that the framebuffers get
-	 * cleaned up with drm_atomic_helper_cleanup_planes()) or completed
-	 * before the new state gets committed on the software side with
-	 * drm_atomic_helper_swap_state().
-	 *
-	 * This scheme allows new atomic state updates to be prepared and
-	 * checked in parallel to the asynchronous completion of the previous
-	 * update. Which is important since compositors need to figure out the
-	 * composition of the next frame right after having submitted the
-	 * current layout.
-	 */
-
-	drm_atomic_state_get(state);
-	if (nonblock)
-		queue_work(system_unbound_wq, &state->commit_work);
-	else
-		commit_tail(state);
-
-	return 0;
-
-error:
-	drm_atomic_helper_cleanup_planes(dev, state);
-	return ret;
-}
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index d1a45a68c287..eb5569d4dd57 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -41,7 +41,11 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = msm_framebuffer_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
 	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = msm_atomic_commit,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
+	.atomic_commit_tail = msm_atomic_commit_tail,
 };
 
 static inline
@@ -520,6 +524,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	}
 
 	ddev->mode_config.funcs = &mode_config_funcs;
+	ddev->mode_config.helper_private = &mode_config_helper_funcs;
 
 	ret = drm_vblank_init(ddev, priv->num_crtcs);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index b89fa5186eb8..3e89d7eac02f 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -156,8 +156,7 @@ struct msm_format {
 	uint32_t pixel_format;
 };
 
-int msm_atomic_commit(struct drm_device *dev,
-		struct drm_atomic_state *state, bool nonblock);
+void msm_atomic_commit_tail(struct drm_atomic_state *state);
 
 void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma, struct sg_table *sgt);
-- 
Sean Paul, Software Engineer, Google / Chromium OS
