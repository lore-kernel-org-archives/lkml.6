Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbeFETMg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:12:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeFETMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:12:35 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v6 1/2] drm/i915: update cursors asynchronously through atomic
Date: Tue,  5 Jun 2018 21:12:25 +0200
Message-Id: <20180605191226.32310-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

Add support to async updates of cursors by using the new atomic
interface for that. Basically what this commit does is do what
intel_legacy_cursor_update() did but through atomic.

Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
This is another attempt to land the patches to update cursors
asynchronously through atomic for the i915 driver. Last version was sent
some time ago [1], so these series are rebased on top of current mainline
and also solves some issues found. The patches were tested by running the
igt test and check there is no regressions (kms_cursor_legacy and
kms_atomic plane_cursor_legacy)

Waiting for your feedback,
 Enric

[1] https://lists.freedesktop.org/archives/dri-devel/2017-September/152141.html

Changes in v6:
- Rework the intel_plane_atomic_async_update due driver changed from
  last time.
- Removed the mutex_lock/unlock as causes a deadlock.

Changes in v5:
- Call drm_atomic_helper_async_check() from the check hook

Changes in v4:
- Set correct vma to new state for cleanup
- Move size checks back to drivers (Ville Syrjälä)

Changes in v3:
- Move fb setting to core and use new state (Eric Anholt)

 drivers/gpu/drm/i915/intel_atomic_plane.c |  69 ++++++++++
 drivers/gpu/drm/i915/intel_display.c      | 154 +++-------------------
 2 files changed, 87 insertions(+), 136 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_atomic_plane.c b/drivers/gpu/drm/i915/intel_atomic_plane.c
index 7481ce85746b..7a58909900ed 100644
--- a/drivers/gpu/drm/i915/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/intel_atomic_plane.c
@@ -248,11 +248,80 @@ static void intel_plane_atomic_update(struct drm_plane *plane,
 	}
 }
 
+static int intel_plane_atomic_async_check(struct drm_plane *plane,
+					  struct drm_plane_state *state)
+{
+	struct drm_crtc_state *crtc_state;
+
+	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+		return -EINVAL;
+
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
+							state->crtc);
+	if (WARN_ON(!crtc_state))
+		return -EINVAL;
+
+	/*
+	 * When crtc is inactive or there is a modeset pending,
+	 * wait for it to complete in the slowpath
+	 */
+	if (!crtc_state->active || to_intel_crtc_state(crtc_state)->update_pipe)
+		return -EINVAL;
+
+	/*
+	 * If any parameters change that may affect watermarks,
+	 * take the slowpath. Only changing fb or position should be
+	 * in the fastpath.
+	 */
+	if (plane->state->crtc != state->crtc ||
+	    plane->state->src_w != state->src_w ||
+	    plane->state->src_h != state->src_h ||
+	    plane->state->crtc_w != state->crtc_w ||
+	    plane->state->crtc_h != state->crtc_h ||
+	    !plane->state->fb != !state->fb)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void intel_plane_atomic_async_update(struct drm_plane *plane,
+					    struct drm_plane_state *new_state)
+{
+	struct intel_plane *intel_plane = to_intel_plane(plane);
+	struct drm_crtc *crtc = plane->state->crtc;
+	struct drm_framebuffer *old_fb;
+
+	old_fb = plane->state->fb;
+
+	i915_gem_track_fb(intel_fb_obj(old_fb), intel_fb_obj(new_state->fb),
+			  intel_plane->frontbuffer_bit);
+
+	plane->state->src_x = new_state->src_x;
+	plane->state->src_y = new_state->src_y;
+	plane->state->crtc_x = new_state->crtc_x;
+	plane->state->crtc_y = new_state->crtc_y;
+	plane->state->fb = new_state->fb;
+
+	new_state->fb = old_fb;
+
+	if (plane->state->visible) {
+		trace_intel_update_plane(plane, to_intel_crtc(crtc));
+		intel_plane->update_plane(intel_plane,
+					  to_intel_crtc_state(crtc->state),
+					  to_intel_plane_state(plane->state));
+	} else {
+		trace_intel_disable_plane(plane, to_intel_crtc(crtc));
+		intel_plane->disable_plane(intel_plane, to_intel_crtc(crtc));
+	}
+}
+
 const struct drm_plane_helper_funcs intel_plane_helper_funcs = {
 	.prepare_fb = intel_prepare_plane_fb,
 	.cleanup_fb = intel_cleanup_plane_fb,
 	.atomic_check = intel_plane_atomic_check,
 	.atomic_update = intel_plane_atomic_update,
+	.atomic_async_check = intel_plane_atomic_async_check,
+	.atomic_async_update = intel_plane_atomic_async_update,
 };
 
 /**
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 56004ffbd8bb..b14d39e2d1f0 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -12106,6 +12106,9 @@ static int intel_atomic_check(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	if (state->legacy_cursor_update)
+		state->async_update = !drm_atomic_helper_async_check(dev,
+								     state);
 	intel_fbc_choose_crtc(dev_priv, intel_state);
 	return calc_watermark_data(state);
 }
@@ -12510,38 +12513,27 @@ static int intel_atomic_commit(struct drm_device *dev,
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	int ret = 0;
 
-	drm_atomic_state_get(state);
-	i915_sw_fence_init(&intel_state->commit_ready,
-			   intel_atomic_commit_ready);
-
 	/*
-	 * The intel_legacy_cursor_update() fast path takes care
+	 * The atomic async update fast path takes care
 	 * of avoiding the vblank waits for simple cursor
 	 * movement and flips. For cursor on/off and size changes,
 	 * we want to perform the vblank waits so that watermark
 	 * updates happen during the correct frames. Gen9+ have
 	 * double buffered watermarks and so shouldn't need this.
-	 *
-	 * Unset state->legacy_cursor_update before the call to
-	 * drm_atomic_helper_setup_commit() because otherwise
-	 * drm_atomic_helper_wait_for_flip_done() is a noop and
-	 * we get FIFO underruns because we didn't wait
-	 * for vblank.
-	 *
-	 * FIXME doing watermarks and fb cleanup from a vblank worker
-	 * (assuming we had any) would solve these problems.
 	 */
-	if (INTEL_GEN(dev_priv) < 9 && state->legacy_cursor_update) {
-		struct intel_crtc_state *new_crtc_state;
-		struct intel_crtc *crtc;
-		int i;
+	if (state->async_update) {
+		ret = drm_atomic_helper_prepare_planes(dev, state);
+		if (ret)
+			return ret;
 
-		for_each_new_intel_crtc_in_state(intel_state, crtc, new_crtc_state, i)
-			if (new_crtc_state->wm.need_postvbl_update ||
-			    new_crtc_state->update_wm_post)
-				state->legacy_cursor_update = false;
+		drm_atomic_helper_async_commit(dev, state);
+		return 0;
 	}
 
+	drm_atomic_state_get(state);
+	i915_sw_fence_init(&intel_state->commit_ready,
+			   intel_atomic_commit_ready);
+
 	ret = intel_atomic_prepare_commit(dev, state);
 	if (ret) {
 		DRM_DEBUG_ATOMIC("Preparing state failed with %i\n", ret);
@@ -12721,6 +12713,9 @@ intel_prepare_plane_fb(struct drm_plane *plane,
 	struct drm_i915_gem_object *old_obj = intel_fb_obj(plane->state->fb);
 	int ret;
 
+	if (new_state->state->async_update)
+		return 0;
+
 	if (old_obj) {
 		struct drm_crtc_state *crtc_state =
 			drm_atomic_get_existing_crtc_state(new_state->state,
@@ -13087,121 +13082,8 @@ static struct drm_plane_funcs intel_plane_funcs = {
 	.format_mod_supported = intel_primary_plane_format_mod_supported,
 };
 
-static int
-intel_legacy_cursor_update(struct drm_plane *plane,
-			   struct drm_crtc *crtc,
-			   struct drm_framebuffer *fb,
-			   int crtc_x, int crtc_y,
-			   unsigned int crtc_w, unsigned int crtc_h,
-			   uint32_t src_x, uint32_t src_y,
-			   uint32_t src_w, uint32_t src_h,
-			   struct drm_modeset_acquire_ctx *ctx)
-{
-	struct drm_i915_private *dev_priv = to_i915(crtc->dev);
-	int ret;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
-	struct intel_plane *intel_plane = to_intel_plane(plane);
-	struct drm_framebuffer *old_fb;
-	struct drm_crtc_state *crtc_state = crtc->state;
-
-	/*
-	 * When crtc is inactive or there is a modeset pending,
-	 * wait for it to complete in the slowpath
-	 */
-	if (!crtc_state->active || needs_modeset(crtc_state) ||
-	    to_intel_crtc_state(crtc_state)->update_pipe)
-		goto slow;
-
-	old_plane_state = plane->state;
-	/*
-	 * Don't do an async update if there is an outstanding commit modifying
-	 * the plane.  This prevents our async update's changes from getting
-	 * overridden by a previous synchronous update's state.
-	 */
-	if (old_plane_state->commit &&
-	    !try_wait_for_completion(&old_plane_state->commit->hw_done))
-		goto slow;
-
-	/*
-	 * If any parameters change that may affect watermarks,
-	 * take the slowpath. Only changing fb or position should be
-	 * in the fastpath.
-	 */
-	if (old_plane_state->crtc != crtc ||
-	    old_plane_state->src_w != src_w ||
-	    old_plane_state->src_h != src_h ||
-	    old_plane_state->crtc_w != crtc_w ||
-	    old_plane_state->crtc_h != crtc_h ||
-	    !old_plane_state->fb != !fb)
-		goto slow;
-
-	new_plane_state = intel_plane_duplicate_state(plane);
-	if (!new_plane_state)
-		return -ENOMEM;
-
-	drm_atomic_set_fb_for_plane(new_plane_state, fb);
-
-	new_plane_state->src_x = src_x;
-	new_plane_state->src_y = src_y;
-	new_plane_state->src_w = src_w;
-	new_plane_state->src_h = src_h;
-	new_plane_state->crtc_x = crtc_x;
-	new_plane_state->crtc_y = crtc_y;
-	new_plane_state->crtc_w = crtc_w;
-	new_plane_state->crtc_h = crtc_h;
-
-	ret = intel_plane_atomic_check_with_state(to_intel_crtc_state(crtc->state),
-						  to_intel_crtc_state(crtc->state), /* FIXME need a new crtc state? */
-						  to_intel_plane_state(plane->state),
-						  to_intel_plane_state(new_plane_state));
-	if (ret)
-		goto out_free;
-
-	ret = mutex_lock_interruptible(&dev_priv->drm.struct_mutex);
-	if (ret)
-		goto out_free;
-
-	ret = intel_plane_pin_fb(to_intel_plane_state(new_plane_state));
-	if (ret)
-		goto out_unlock;
-
-	old_fb = old_plane_state->fb;
-
-	i915_gem_track_fb(intel_fb_obj(old_fb), intel_fb_obj(fb),
-			  intel_plane->frontbuffer_bit);
-
-	/* Swap plane state */
-	plane->state = new_plane_state;
-
-	if (plane->state->visible) {
-		trace_intel_update_plane(plane, to_intel_crtc(crtc));
-		intel_plane->update_plane(intel_plane,
-					  to_intel_crtc_state(crtc->state),
-					  to_intel_plane_state(plane->state));
-	} else {
-		trace_intel_disable_plane(plane, to_intel_crtc(crtc));
-		intel_plane->disable_plane(intel_plane, to_intel_crtc(crtc));
-	}
-
-	intel_plane_unpin_fb(to_intel_plane_state(old_plane_state));
-
-out_unlock:
-	mutex_unlock(&dev_priv->drm.struct_mutex);
-out_free:
-	if (ret)
-		intel_plane_destroy_state(plane, new_plane_state);
-	else
-		intel_plane_destroy_state(plane, old_plane_state);
-	return ret;
-
-slow:
-	return drm_atomic_helper_update_plane(plane, crtc, fb,
-					      crtc_x, crtc_y, crtc_w, crtc_h,
-					      src_x, src_y, src_w, src_h, ctx);
-}
-
 static const struct drm_plane_funcs intel_cursor_plane_funcs = {
-	.update_plane = intel_legacy_cursor_update,
+	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
 	.atomic_get_property = intel_plane_atomic_get_property,
-- 
2.17.1
