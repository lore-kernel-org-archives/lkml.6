Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937823AbeBUOil (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:38:41 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34722 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeBUOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:38:38 -0500
X-Google-Smtp-Source: AG47ELucGI3u3kwkiAVgAxa+oLi4+dtsAiKaPhWIHfOW3od/4OAaHKLgwajd+UPN4aqe+f6OXp3qpg==
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/msm: Don't subclass drm_atomic_state anymore
Date: Wed, 21 Feb 2018 09:37:24 -0500
Message-Id: <20180221143730.30285-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221143730.30285-1-robdclark@gmail.com>
References: <20180221143730.30285-1-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archit Taneja <architt@codeaurora.org>

With the addition of "private_objs" in drm_atomic_state, we no longer
need to subclass drm_atomic_state to store state of share resources
that don't perfectly fit within planes/crtc/connector state information.
We can now save this state within drm_atomic_state itself using
the private objects.

Remove the infrastructure that allowed subclassing of drm_atomic_state
in the driver.

Signed-off-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 46 --------------------------------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h | 22 ---------------
 drivers/gpu/drm/msm/msm_atomic.c         | 31 ---------------------
 drivers/gpu/drm/msm/msm_drv.c            |  3 ---
 drivers/gpu/drm/msm/msm_kms.h            | 14 ----------
 5 files changed, 116 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index a7e80ebf0207..da9c4a4eb050 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -70,42 +70,6 @@ static int mdp5_hw_init(struct msm_kms *kms)
 	return 0;
 }
 
-struct mdp5_state *mdp5_get_state(struct drm_atomic_state *s)
-{
-	struct msm_drm_private *priv = s->dev->dev_private;
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct msm_kms_state *state = to_kms_state(s);
-	struct mdp5_state *new_state;
-	int ret;
-
-	if (state->state)
-		return state->state;
-
-	ret = drm_modeset_lock(&mdp5_kms->state_lock, s->acquire_ctx);
-	if (ret)
-		return ERR_PTR(ret);
-
-	new_state = kmalloc(sizeof(*mdp5_kms->state), GFP_KERNEL);
-	if (!new_state)
-		return ERR_PTR(-ENOMEM);
-
-	/* Copy state: */
-	new_state->hwpipe = mdp5_kms->state->hwpipe;
-	new_state->hwmixer = mdp5_kms->state->hwmixer;
-	if (mdp5_kms->smp)
-		new_state->smp = mdp5_kms->state->smp;
-
-	state->state = new_state;
-
-	return new_state;
-}
-
-static void mdp5_swap_state(struct msm_kms *kms, struct drm_atomic_state *state)
-{
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
-	swap(to_kms_state(state)->state, mdp5_kms->state);
-}
-
 /* Global/shared object state funcs */
 
 /*
@@ -323,7 +287,6 @@ static const struct mdp_kms_funcs kms_funcs = {
 		.irq             = mdp5_irq,
 		.enable_vblank   = mdp5_enable_vblank,
 		.disable_vblank  = mdp5_disable_vblank,
-		.swap_state      = mdp5_swap_state,
 		.prepare_commit  = mdp5_prepare_commit,
 		.commit          = mdp5_commit,
 		.complete_commit = mdp5_complete_commit,
@@ -859,8 +822,6 @@ static void mdp5_destroy(struct platform_device *pdev)
 		pm_runtime_disable(&pdev->dev);
 
 	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
-
-	kfree(mdp5_kms->state);
 }
 
 static int construct_pipes(struct mdp5_kms *mdp5_kms, int cnt,
@@ -1013,13 +974,6 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	mdp5_kms->dev = dev;
 	mdp5_kms->pdev = pdev;
 
-	drm_modeset_lock_init(&mdp5_kms->state_lock);
-	mdp5_kms->state = kzalloc(sizeof(*mdp5_kms->state), GFP_KERNEL);
-	if (!mdp5_kms->state) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
 	ret = mdp5_global_obj_init(mdp5_kms);
 	if (ret)
 		goto fail;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
index 1c70aac20a98..a75fbd3aeaf7 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
@@ -30,8 +30,6 @@
 #include "mdp5_ctl.h"
 #include "mdp5_smp.h"
 
-struct mdp5_state;
-
 struct mdp5_kms {
 	struct mdp_kms base;
 
@@ -51,12 +49,6 @@ struct mdp5_kms {
 	struct mdp5_cfg_handler *cfg;
 	uint32_t caps;	/* MDP capabilities (MDP_CAP_XXX bits) */
 
-	/**
-	 * Global atomic state.  Do not access directly, use mdp5_get_state()
-	 */
-	struct mdp5_state *state;
-	struct drm_modeset_lock state_lock;
-
 	/*
 	 * Global private object state, Do not access directly, use
 	 * mdp5_global_get_state()
@@ -89,20 +81,6 @@ struct mdp5_kms {
 };
 #define to_mdp5_kms(x) container_of(x, struct mdp5_kms, base)
 
-/* Global atomic state for tracking resources that are shared across
- * multiple kms objects (planes/crtcs/etc).
- *
- * For atomic updates which require modifying global state,
- */
-struct mdp5_state {
-	struct mdp5_hw_pipe_state hwpipe;
-	struct mdp5_hw_mixer_state hwmixer;
-	struct mdp5_smp_state smp;
-};
-
-struct mdp5_state *__must_check
-mdp5_get_state(struct drm_atomic_state *s);
-
 /* Global private object state for tracking resources that are shared across
  * multiple kms objects (planes/crtcs/etc).
  */
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 9de579e0a1df..761d9bd65302 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -226,11 +226,7 @@ int msm_atomic_commit(struct drm_device *dev,
 	 * This is the point of no return - everything below never fails except
 	 * when the hw goes bonghits. Which means we can commit the new state on
 	 * the software side now.
-	 *
-	 * swap driver private state while still holding state_lock
 	 */
-	if (to_kms_state(state)->state)
-		priv->kms->funcs->swap_state(priv->kms, state);
 
 	/*
 	 * Everything below can be run asynchronously without the need to grab
@@ -264,30 +260,3 @@ int msm_atomic_commit(struct drm_device *dev,
 	drm_atomic_helper_cleanup_planes(dev, state);
 	return ret;
 }
-
-struct drm_atomic_state *msm_atomic_state_alloc(struct drm_device *dev)
-{
-	struct msm_kms_state *state = kzalloc(sizeof(*state), GFP_KERNEL);
-
-	if (!state || drm_atomic_state_init(dev, &state->base) < 0) {
-		kfree(state);
-		return NULL;
-	}
-
-	return &state->base;
-}
-
-void msm_atomic_state_clear(struct drm_atomic_state *s)
-{
-	struct msm_kms_state *state = to_kms_state(s);
-	drm_atomic_state_default_clear(&state->base);
-	kfree(state->state);
-	state->state = NULL;
-}
-
-void msm_atomic_state_free(struct drm_atomic_state *state)
-{
-	kfree(to_kms_state(state)->state);
-	drm_atomic_state_default_release(state);
-	kfree(state);
-}
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 65d3b0bb7c86..a631e94ca731 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -42,9 +42,6 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = msm_atomic_commit,
-	.atomic_state_alloc = msm_atomic_state_alloc,
-	.atomic_state_clear = msm_atomic_state_clear,
-	.atomic_state_free = msm_atomic_state_free,
 };
 
 #ifdef CONFIG_DRM_MSM_REGISTER_LOGGING
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index 7585a6b988c7..c776651eed08 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -40,8 +40,6 @@ struct msm_kms_funcs {
 	irqreturn_t (*irq)(struct msm_kms *kms);
 	int (*enable_vblank)(struct msm_kms *kms, struct drm_crtc *crtc);
 	void (*disable_vblank)(struct msm_kms *kms, struct drm_crtc *crtc);
-	/* swap global atomic state: */
-	void (*swap_state)(struct msm_kms *kms, struct drm_atomic_state *state);
 	/* modeset, bracketing atomic_commit(): */
 	void (*prepare_commit)(struct msm_kms *kms, struct drm_atomic_state *state);
 	void (*commit)(struct msm_kms *kms, struct drm_atomic_state *state);
@@ -78,18 +76,6 @@ struct msm_kms {
 	struct msm_gem_address_space *aspace;
 };
 
-/**
- * Subclass of drm_atomic_state, to allow kms backend to have driver
- * private global state.  The kms backend can do whatever it wants
- * with the ->state ptr.  On ->atomic_state_clear() the ->state ptr
- * is kfree'd and set back to NULL.
- */
-struct msm_kms_state {
-	struct drm_atomic_state base;
-	void *state;
-};
-#define to_kms_state(x) container_of(x, struct msm_kms_state, base)
-
 static inline void msm_kms_init(struct msm_kms *kms,
 		const struct msm_kms_funcs *funcs)
 {
-- 
2.14.3
