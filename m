Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeC1TI5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:08:57 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44756 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbeC1TIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:08:54 -0400
X-Google-Smtp-Source: AIpwx48JxPmSehRXhX3vn18b8IFLRzhoB9daiZJVbZIUquofkiFuF6UuWw9zJn9B7+nd+zwko7GoAA==
From: Sean Paul <seanpaul@chromium.org>
To: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, architt@codeaurora.org,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] drm/msm: Remove msm_commit/worker, use atomic helper commit
Date: Wed, 28 Mar 2018 15:06:51 -0400
Message-Id: <20180328190657.218661-6-seanpaul@chromium.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328190657.218661-1-seanpaul@chromium.org>
References: <20180328190657.218661-1-seanpaul@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving further towards switching fully to the the atomic helpers, this
patch removes the hand-rolled worker nonblock commit code and uses the
atomic helpers commit_work model.

Changes in v2:
- Remove commit_destroy()
- Shuffle order of commit_tail calls to further serialize commits
- Use stall in swap_state to avoid abandoned events on disable

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/msm/msm_atomic.c | 153 +++++++++----------------------
 drivers/gpu/drm/msm/msm_drv.c    |   1 -
 drivers/gpu/drm/msm/msm_drv.h    |   4 -
 3 files changed, 42 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 671a18ee977d..52249565cc03 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -20,66 +20,6 @@
 #include "msm_gem.h"
 #include "msm_fence.h"
 
-struct msm_commit {
-	struct drm_device *dev;
-	struct drm_atomic_state *state;
-	struct work_struct work;
-	uint32_t crtc_mask;
-};
-
-static void commit_worker(struct work_struct *work);
-
-/* block until specified crtcs are no longer pending update, and
- * atomically mark them as pending update
- */
-static int start_atomic(struct msm_drm_private *priv, uint32_t crtc_mask)
-{
-	int ret;
-
-	spin_lock(&priv->pending_crtcs_event.lock);
-	ret = wait_event_interruptible_locked(priv->pending_crtcs_event,
-			!(priv->pending_crtcs & crtc_mask));
-	if (ret == 0) {
-		DBG("start: %08x", crtc_mask);
-		priv->pending_crtcs |= crtc_mask;
-	}
-	spin_unlock(&priv->pending_crtcs_event.lock);
-
-	return ret;
-}
-
-/* clear specified crtcs (no longer pending update)
- */
-static void end_atomic(struct msm_drm_private *priv, uint32_t crtc_mask)
-{
-	spin_lock(&priv->pending_crtcs_event.lock);
-	DBG("end: %08x", crtc_mask);
-	priv->pending_crtcs &= ~crtc_mask;
-	wake_up_all_locked(&priv->pending_crtcs_event);
-	spin_unlock(&priv->pending_crtcs_event.lock);
-}
-
-static struct msm_commit *commit_init(struct drm_atomic_state *state)
-{
-	struct msm_commit *c = kzalloc(sizeof(*c), GFP_KERNEL);
-
-	if (!c)
-		return NULL;
-
-	c->dev = state->dev;
-	c->state = state;
-
-	INIT_WORK(&c->work, commit_worker);
-
-	return c;
-}
-
-static void commit_destroy(struct msm_commit *c)
-{
-	end_atomic(c->dev->dev_private, c->crtc_mask);
-	kfree(c);
-}
-
 static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
 		struct drm_atomic_state *old_state)
 {
@@ -126,31 +66,37 @@ static void msm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	msm_atomic_wait_for_commit_done(dev, state);
 
-	drm_atomic_helper_cleanup_planes(dev, state);
-
 	kms->funcs->complete_commit(kms, state);
+
+	drm_atomic_helper_wait_for_vblanks(dev, state);
+
+	drm_atomic_helper_commit_hw_done(state);
+
+	drm_atomic_helper_cleanup_planes(dev, state);
 }
 
 /* The (potentially) asynchronous part of the commit.  At this point
  * nothing can fail short of armageddon.
  */
-static void complete_commit(struct msm_commit *c)
+static void commit_tail(struct drm_atomic_state *state)
 {
-	struct drm_atomic_state *state = c->state;
-	struct drm_device *dev = state->dev;
+	drm_atomic_helper_wait_for_fences(state->dev, state, false);
 
-	drm_atomic_helper_wait_for_fences(dev, state, false);
+	drm_atomic_helper_wait_for_dependencies(state);
 
 	msm_atomic_commit_tail(state);
 
-	drm_atomic_state_put(state);
+	drm_atomic_helper_commit_cleanup_done(state);
 
-	commit_destroy(c);
+	drm_atomic_state_put(state);
 }
 
-static void commit_worker(struct work_struct *work)
+static void commit_work(struct work_struct *work)
 {
-	complete_commit(container_of(work, struct msm_commit, work));
+	struct drm_atomic_state *state = container_of(work,
+						      struct drm_atomic_state,
+						      commit_work);
+	commit_tail(state);
 }
 
 /**
@@ -169,17 +115,12 @@ int msm_atomic_commit(struct drm_device *dev,
 		struct drm_atomic_state *state, bool nonblock)
 {
 	struct msm_drm_private *priv = dev->dev_private;
-	struct msm_commit *c;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	int i, ret;
 
-	ret = drm_atomic_helper_prepare_planes(dev, state);
-	if (ret)
-		return ret;
-
 	/*
 	 * Note that plane->atomic_async_check() should fail if we need
 	 * to re-assign hwpipe or anything that touches global atomic
@@ -187,45 +128,39 @@ int msm_atomic_commit(struct drm_device *dev,
 	 * cases.
 	 */
 	if (state->async_update) {
+		ret = drm_atomic_helper_prepare_planes(dev, state);
+		if (ret)
+			return ret;
+
 		drm_atomic_helper_async_commit(dev, state);
 		drm_atomic_helper_cleanup_planes(dev, state);
 		return 0;
 	}
 
-	c = commit_init(state);
-	if (!c) {
-		ret = -ENOMEM;
-		goto error;
-	}
+	ret = drm_atomic_helper_setup_commit(state, nonblock);
+	if (ret)
+		return ret;
 
-	/*
-	 * Figure out what crtcs we have:
-	 */
-	for_each_new_crtc_in_state(state, crtc, crtc_state, i)
-		c->crtc_mask |= drm_crtc_mask(crtc);
+	INIT_WORK(&state->commit_work, commit_work);
 
-	/*
-	 * Figure out what fence to wait for:
-	 */
-	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
-		if ((new_plane_state->fb != old_plane_state->fb) && new_plane_state->fb) {
-			struct drm_gem_object *obj = msm_framebuffer_bo(new_plane_state->fb, 0);
-			struct msm_gem_object *msm_obj = to_msm_bo(obj);
-			struct dma_fence *fence = reservation_object_get_excl_rcu(msm_obj->resv);
-
-			drm_atomic_set_fence_for_plane(new_plane_state, fence);
-		}
+	ret = drm_atomic_helper_prepare_planes(dev, state);
+	if (ret)
+		return ret;
+
+	if (!nonblock) {
+		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
+		if (ret)
+			goto error;
 	}
 
 	/*
-	 * Wait for pending updates on any of the same crtc's and then
-	 * mark our set of crtc's as busy:
+	 * This is the point of no return - everything below never fails except
+	 * when the hw goes bonghits. Which means we can commit the new state on
+	 * the software side now.
+	 *
+	 * swap driver private state while still holding state_lock
 	 */
-	ret = start_atomic(dev->dev_private, c->crtc_mask);
-	if (ret)
-		goto err_free;
-
-	BUG_ON(drm_atomic_helper_swap_state(state, false) < 0);
+	BUG_ON(drm_atomic_helper_swap_state(state, true) < 0);
 
 	/*
 	 * Everything below can be run asynchronously without the need to grab
@@ -244,17 +179,13 @@ int msm_atomic_commit(struct drm_device *dev,
 	 */
 
 	drm_atomic_state_get(state);
-	if (nonblock) {
-		queue_work(priv->atomic_wq, &c->work);
-		return 0;
-	}
-
-	complete_commit(c);
+	if (nonblock)
+		queue_work(system_unbound_wq, &state->commit_work);
+	else
+		commit_tail(state);
 
 	return 0;
 
-err_free:
-	kfree(c);
 error:
 	drm_atomic_helper_cleanup_planes(dev, state);
 	return ret;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 7e8f640062ef..d1a45a68c287 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -459,7 +459,6 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 
 	priv->wq = alloc_ordered_workqueue("msm", 0);
 	priv->atomic_wq = alloc_ordered_workqueue("msm:atomic", 0);
-	init_waitqueue_head(&priv->pending_crtcs_event);
 
 	INIT_LIST_HEAD(&priv->inactive_list);
 	INIT_LIST_HEAD(&priv->vblank_ctrl.event_list);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index c5b8c989b859..b89fa5186eb8 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -117,10 +117,6 @@ struct msm_drm_private {
 	struct workqueue_struct *wq;
 	struct workqueue_struct *atomic_wq;
 
-	/* crtcs pending async atomic updates: */
-	uint32_t pending_crtcs;
-	wait_queue_head_t pending_crtcs_event;
-
 	unsigned int num_planes;
 	struct drm_plane *planes[16];
 
-- 
Sean Paul, Software Engineer, Google / Chromium OS
