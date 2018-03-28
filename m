Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753778AbeC1TIM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:08:12 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:45434 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbeC1TIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:08:10 -0400
X-Google-Smtp-Source: AIpwx4/D9WW/VY8xJBfRkqE6LSztx1ctkpZKEhjMxUw/NwAgm76AfdrehmBoLIA2wNyEfijmFheC3Q==
From: Sean Paul <seanpaul@chromium.org>
To: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, architt@codeaurora.org,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] drm/msm: Use drm_private_obj/state instead of subclassing
Date: Wed, 28 Mar 2018 15:06:47 -0400
Message-Id: <20180328190657.218661-2-seanpaul@chromium.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328190657.218661-1-seanpaul@chromium.org>
References: <20180328190657.218661-1-seanpaul@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have private state handled by the core, we can use those
instead of rolling our own swap_state for private data.

Originally posted here: https://patchwork.freedesktop.org/patch/211361/

Changes in v2:
 - Use state->state in disp duplicate_state callback (Jeykumar)
Changes in v3:
 - Update comment describing msm_kms_state (Jeykumar)
Changes in v4:
 - Rebased on msm-next
 - Don't always use private state from atomic state (Archit)
 - Renamed some of the state accessors
 - Tested on mdp5 db410c
Changes in v5:
 - None

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 77 ++++++++++---------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h   | 11 +--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c | 12 ++-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c  | 28 ++++---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c   | 19 +++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.h   |  4 +-
 drivers/gpu/drm/msm/msm_atomic.c           | 37 ---------
 drivers/gpu/drm/msm/msm_drv.c              | 87 +++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_drv.h              |  3 -
 drivers/gpu/drm/msm/msm_kms.h              | 21 ++++--
 10 files changed, 183 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 6d8e3a9a6fc0..366670043190 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -70,60 +70,62 @@ static int mdp5_hw_init(struct msm_kms *kms)
 	return 0;
 }
 
-struct mdp5_state *mdp5_get_state(struct drm_atomic_state *s)
+struct mdp5_state *mdp5_state_from_atomic(struct drm_atomic_state *state)
 {
-	struct msm_drm_private *priv = s->dev->dev_private;
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct msm_kms_state *state = to_kms_state(s);
-	struct mdp5_state *new_state;
-	int ret;
+	struct msm_kms_state *kms_state = msm_kms_state_from_atomic(state);
 
-	if (state->state)
-		return state->state;
+	if (IS_ERR_OR_NULL(kms_state))
+		return (struct mdp5_state *)kms_state; /* casting ERR_PTR */
 
-	ret = drm_modeset_lock(&mdp5_kms->state_lock, s->acquire_ctx);
-	if (ret)
-		return ERR_PTR(ret);
+	return kms_state->state;
+}
 
-	new_state = kmalloc(sizeof(*mdp5_kms->state), GFP_KERNEL);
-	if (!new_state)
-		return ERR_PTR(-ENOMEM);
+struct mdp5_state *mdp5_state_from_dev(struct drm_device *dev)
+{
+	struct msm_kms_state *kms_state = msm_kms_state_from_dev(dev);
 
-	/* Copy state: */
-	new_state->hwpipe = mdp5_kms->state->hwpipe;
-	new_state->hwmixer = mdp5_kms->state->hwmixer;
-	if (mdp5_kms->smp)
-		new_state->smp = mdp5_kms->state->smp;
+	if (IS_ERR_OR_NULL(kms_state))
+		return (struct mdp5_state *)kms_state; /* casting ERR_PTR */
 
-	state->state = new_state;
+	return kms_state->state;
+}
+
+static void *mdp5_duplicate_state(void *state)
+{
+	if (!state)
+		return kzalloc(sizeof(struct mdp5_state), GFP_KERNEL);
 
-	return new_state;
+	return kmemdup(state, sizeof(struct mdp5_state), GFP_KERNEL);
 }
 
-static void mdp5_swap_state(struct msm_kms *kms, struct drm_atomic_state *state)
+static void mdp5_destroy_state(void *state)
 {
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
-	swap(to_kms_state(state)->state, mdp5_kms->state);
+	struct mdp5_state *mdp_state = (struct mdp5_state *)state;
+	kfree(mdp_state);
 }
 
-static void mdp5_prepare_commit(struct msm_kms *kms, struct drm_atomic_state *state)
+static void mdp5_prepare_commit(struct msm_kms *kms,
+				struct drm_atomic_state *old_state)
 {
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
+	struct mdp5_state *mdp5_state = mdp5_state_from_dev(mdp5_kms->dev);
 	struct device *dev = &mdp5_kms->pdev->dev;
 
 	pm_runtime_get_sync(dev);
 
 	if (mdp5_kms->smp)
-		mdp5_smp_prepare_commit(mdp5_kms->smp, &mdp5_kms->state->smp);
+		mdp5_smp_prepare_commit(mdp5_kms->smp, &mdp5_state->smp);
 }
 
-static void mdp5_complete_commit(struct msm_kms *kms, struct drm_atomic_state *state)
+static void mdp5_complete_commit(struct msm_kms *kms,
+				 struct drm_atomic_state *old_state)
 {
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
+	struct mdp5_state *mdp5_state = mdp5_state_from_dev(mdp5_kms->dev);
 	struct device *dev = &mdp5_kms->pdev->dev;
 
 	if (mdp5_kms->smp)
-		mdp5_smp_complete_commit(mdp5_kms->smp, &mdp5_kms->state->smp);
+		mdp5_smp_complete_commit(mdp5_kms->smp, &mdp5_state->smp);
 
 	pm_runtime_put_sync(dev);
 }
@@ -229,7 +231,8 @@ static const struct mdp_kms_funcs kms_funcs = {
 		.irq             = mdp5_irq,
 		.enable_vblank   = mdp5_enable_vblank,
 		.disable_vblank  = mdp5_disable_vblank,
-		.swap_state      = mdp5_swap_state,
+		.duplicate_state = mdp5_duplicate_state,
+		.destroy_state	 = mdp5_destroy_state,
 		.prepare_commit  = mdp5_prepare_commit,
 		.complete_commit = mdp5_complete_commit,
 		.wait_for_crtc_commit_done = mdp5_wait_for_crtc_commit_done,
@@ -726,8 +729,6 @@ static void mdp5_destroy(struct platform_device *pdev)
 
 	if (mdp5_kms->rpm_enabled)
 		pm_runtime_disable(&pdev->dev);
-
-	kfree(mdp5_kms->state);
 }
 
 static int construct_pipes(struct mdp5_kms *mdp5_kms, int cnt,
@@ -859,7 +860,8 @@ static int interface_init(struct mdp5_kms *mdp5_kms)
 	return 0;
 }
 
-static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
+static int mdp5_init(struct platform_device *pdev, struct drm_device *dev,
+		     struct msm_kms_state *initial_state)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct mdp5_kms *mdp5_kms;
@@ -880,9 +882,8 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	mdp5_kms->dev = dev;
 	mdp5_kms->pdev = pdev;
 
-	drm_modeset_lock_init(&mdp5_kms->state_lock);
-	mdp5_kms->state = kzalloc(sizeof(*mdp5_kms->state), GFP_KERNEL);
-	if (!mdp5_kms->state) {
+	initial_state->state = mdp5_duplicate_state(NULL);
+	if (!initial_state->state) {
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -940,7 +941,8 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	 * this section initializes the SMP:
 	 */
 	if (mdp5_kms->caps & MDP_CAP_SMP) {
-		mdp5_kms->smp = mdp5_smp_init(mdp5_kms, &config->hw->smp);
+		mdp5_kms->smp = mdp5_smp_init(mdp5_kms, &config->hw->smp,
+					      initial_state->state);
 		if (IS_ERR(mdp5_kms->smp)) {
 			ret = PTR_ERR(mdp5_kms->smp);
 			mdp5_kms->smp = NULL;
@@ -980,10 +982,11 @@ static int mdp5_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *ddev = dev_get_drvdata(master);
 	struct platform_device *pdev = to_platform_device(dev);
+	struct msm_kms_state *initial_state = (struct msm_kms_state *)data;
 
 	DBG("");
 
-	return mdp5_init(pdev, ddev);
+	return mdp5_init(pdev, ddev, initial_state);
 }
 
 static void mdp5_unbind(struct device *dev, struct device *master,
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
index 425a03d213e5..e23117b82aad 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
@@ -28,8 +28,6 @@
 #include "mdp5_ctl.h"
 #include "mdp5_smp.h"
 
-struct mdp5_state;
-
 struct mdp5_kms {
 	struct mdp_kms base;
 
@@ -49,12 +47,6 @@ struct mdp5_kms {
 	struct mdp5_cfg_handler *cfg;
 	uint32_t caps;	/* MDP capabilities (MDP_CAP_XXX bits) */
 
-	/**
-	 * Global atomic state.  Do not access directly, use mdp5_get_state()
-	 */
-	struct mdp5_state *state;
-	struct drm_modeset_lock state_lock;
-
 	struct mdp5_smp *smp;
 	struct mdp5_ctl_manager *ctlm;
 
@@ -93,7 +85,8 @@ struct mdp5_state {
 };
 
 struct mdp5_state *__must_check
-mdp5_get_state(struct drm_atomic_state *s);
+mdp5_state_from_atomic(struct drm_atomic_state *s);
+struct mdp5_state *__must_check mdp5_state_from_dev(struct drm_device *dev);
 
 /* Atomic plane state.  Subclasses the base drm_plane_state in order to
  * track assigned hwpipe and hw specific state.
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
index 8a00991f03c7..fdd5e12a9d56 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
@@ -52,10 +52,11 @@ int mdp5_mixer_assign(struct drm_atomic_state *s, struct drm_crtc *crtc,
 {
 	struct msm_drm_private *priv = s->dev->dev_private;
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct mdp5_state *state = mdp5_get_state(s);
+	struct mdp5_state *state;
 	struct mdp5_hw_mixer_state *new_state;
 	int i;
 
+	state = mdp5_state_from_atomic(s);
 	if (IS_ERR(state))
 		return PTR_ERR(state);
 
@@ -129,12 +130,17 @@ int mdp5_mixer_assign(struct drm_atomic_state *s, struct drm_crtc *crtc,
 
 void mdp5_mixer_release(struct drm_atomic_state *s, struct mdp5_hw_mixer *mixer)
 {
-	struct mdp5_state *state = mdp5_get_state(s);
-	struct mdp5_hw_mixer_state *new_state = &state->hwmixer;
+	struct mdp5_state *state;
+	struct mdp5_hw_mixer_state *new_state;
 
 	if (!mixer)
 		return;
 
+	state = mdp5_state_from_atomic(s);
+	if (IS_ERR(state))
+		return;
+
+	new_state = &state->hwmixer;
 	if (WARN_ON(!new_state->hwmixer_to_crtc[mixer->idx]))
 		return;
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
index ff52c49095f9..dc66ab9fdd50 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
@@ -24,17 +24,20 @@ int mdp5_pipe_assign(struct drm_atomic_state *s, struct drm_plane *plane,
 {
 	struct msm_drm_private *priv = s->dev->dev_private;
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct mdp5_state *state;
+	struct mdp5_state *old_mdp5_state, *new_mdp5_state;
 	struct mdp5_hw_pipe_state *old_state, *new_state;
 	int i, j;
 
-	state = mdp5_get_state(s);
-	if (IS_ERR(state))
-		return PTR_ERR(state);
+	new_mdp5_state = mdp5_state_from_atomic(s);
+	if (IS_ERR(new_mdp5_state))
+		return PTR_ERR(new_mdp5_state);
 
-	/* grab old_state after mdp5_get_state(), since now we hold lock: */
-	old_state = &mdp5_kms->state->hwpipe;
-	new_state = &state->hwpipe;
+	old_mdp5_state = mdp5_state_from_dev(s->dev);
+	if (IS_ERR(old_mdp5_state))
+		return PTR_ERR(old_mdp5_state);
+
+	old_state = &old_mdp5_state->hwpipe;
+	new_state = &new_mdp5_state->hwpipe;
 
 	for (i = 0; i < mdp5_kms->num_hwpipes; i++) {
 		struct mdp5_hw_pipe *cur = mdp5_kms->hwpipes[i];
@@ -107,7 +110,7 @@ int mdp5_pipe_assign(struct drm_atomic_state *s, struct drm_plane *plane,
 		WARN_ON(r_hwpipe);
 
 		DBG("%s: alloc SMP blocks", (*hwpipe)->name);
-		ret = mdp5_smp_assign(mdp5_kms->smp, &state->smp,
+		ret = mdp5_smp_assign(mdp5_kms->smp, &new_mdp5_state->smp,
 				(*hwpipe)->pipe, blkcfg);
 		if (ret)
 			return -ENOMEM;
@@ -132,12 +135,17 @@ void mdp5_pipe_release(struct drm_atomic_state *s, struct mdp5_hw_pipe *hwpipe)
 {
 	struct msm_drm_private *priv = s->dev->dev_private;
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct mdp5_state *state = mdp5_get_state(s);
-	struct mdp5_hw_pipe_state *new_state = &state->hwpipe;
+	struct mdp5_state *state;
+	struct mdp5_hw_pipe_state *new_state;
 
 	if (!hwpipe)
 		return;
 
+	state = mdp5_state_from_atomic(s);
+	if (IS_ERR(state))
+		return;
+
+	new_state = &state->hwpipe;
 	if (WARN_ON(!new_state->hwpipe_to_plane[hwpipe->idx]))
 		return;
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index ae4983d9d0a5..918e4123e781 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -338,6 +338,7 @@ void mdp5_smp_complete_commit(struct mdp5_smp *smp, struct mdp5_smp_state *state
 void mdp5_smp_dump(struct mdp5_smp *smp, struct drm_printer *p)
 {
 	struct mdp5_kms *mdp5_kms = get_kms(smp);
+	struct mdp5_state *mdp5_state;
 	struct mdp5_hw_pipe_state *hwpstate;
 	struct mdp5_smp_state *state;
 	int total = 0, i, j;
@@ -346,11 +347,12 @@ void mdp5_smp_dump(struct mdp5_smp *smp, struct drm_printer *p)
 	drm_printf(p, "----\t-----\t-----\n");
 
 	if (drm_can_sleep())
-		drm_modeset_lock(&mdp5_kms->state_lock, NULL);
+		drm_modeset_lock_all(mdp5_kms->dev);
 
-	/* grab these *after* we hold the state_lock */
-	hwpstate = &mdp5_kms->state->hwpipe;
-	state = &mdp5_kms->state->smp;
+	/* grab these *after* we hold the modeset_lock */
+	mdp5_state = mdp5_state_from_dev(mdp5_kms->dev);
+	hwpstate = &mdp5_state->hwpipe;
+	state = &mdp5_state->smp;
 
 	for (i = 0; i < mdp5_kms->num_hwpipes; i++) {
 		struct mdp5_hw_pipe *hwpipe = mdp5_kms->hwpipes[i];
@@ -374,7 +376,7 @@ void mdp5_smp_dump(struct mdp5_smp *smp, struct drm_printer *p)
 			bitmap_weight(state->state, smp->blk_cnt));
 
 	if (drm_can_sleep())
-		drm_modeset_unlock(&mdp5_kms->state_lock);
+		drm_modeset_unlock_all(mdp5_kms->dev);
 }
 
 void mdp5_smp_destroy(struct mdp5_smp *smp)
@@ -382,12 +384,15 @@ void mdp5_smp_destroy(struct mdp5_smp *smp)
 	kfree(smp);
 }
 
-struct mdp5_smp *mdp5_smp_init(struct mdp5_kms *mdp5_kms, const struct mdp5_smp_block *cfg)
+struct mdp5_smp *mdp5_smp_init(struct mdp5_kms *mdp5_kms,
+			       const struct mdp5_smp_block *cfg,
+			       struct mdp5_state *mdp5_state)
 {
-	struct mdp5_smp_state *state = &mdp5_kms->state->smp;
+	struct mdp5_smp_state *state;
 	struct mdp5_smp *smp = NULL;
 	int ret;
 
+	state = &mdp5_state->smp;
 	smp = kzalloc(sizeof(*smp), GFP_KERNEL);
 	if (unlikely(!smp)) {
 		ret = -ENOMEM;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.h
index b41d0448fbe8..1bfa22b63a2d 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.h
@@ -69,6 +69,7 @@ struct mdp5_smp_state {
 };
 
 struct mdp5_kms;
+struct mdp5_state;
 struct mdp5_smp;
 
 /*
@@ -78,7 +79,8 @@ struct mdp5_smp;
  */
 
 struct mdp5_smp *mdp5_smp_init(struct mdp5_kms *mdp5_kms,
-		const struct mdp5_smp_block *cfg);
+		const struct mdp5_smp_block *cfg,
+		struct mdp5_state *mdp5_state);
 void  mdp5_smp_destroy(struct mdp5_smp *smp);
 
 void mdp5_smp_dump(struct mdp5_smp *smp, struct drm_printer *p);
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index bf5f8c39f34d..e792158676aa 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -220,16 +220,6 @@ int msm_atomic_commit(struct drm_device *dev,
 
 	BUG_ON(drm_atomic_helper_swap_state(state, false) < 0);
 
-	/*
-	 * This is the point of no return - everything below never fails except
-	 * when the hw goes bonghits. Which means we can commit the new state on
-	 * the software side now.
-	 *
-	 * swap driver private state while still holding state_lock
-	 */
-	if (to_kms_state(state)->state)
-		priv->kms->funcs->swap_state(priv->kms, state);
-
 	/*
 	 * Everything below can be run asynchronously without the need to grab
 	 * any modeset locks at all under one conditions: It must be guaranteed
@@ -262,30 +252,3 @@ int msm_atomic_commit(struct drm_device *dev,
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
index 30cd514d8f7c..7e8f640062ef 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -42,11 +42,79 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = msm_atomic_commit,
-	.atomic_state_alloc = msm_atomic_state_alloc,
-	.atomic_state_clear = msm_atomic_state_clear,
-	.atomic_state_free = msm_atomic_state_free,
 };
 
+static inline
+struct msm_kms *msm_kms_from_obj(struct drm_private_obj *obj)
+{
+	return container_of(obj, struct msm_kms, base);
+}
+
+static inline
+struct msm_kms_state *msm_kms_state_from_priv(struct drm_private_state *priv)
+{
+	return container_of(priv, struct msm_kms_state, base);
+}
+
+
+struct msm_kms_state *msm_kms_state_from_atomic(struct drm_atomic_state *state)
+{
+	struct msm_drm_private *priv = state->dev->dev_private;
+	struct drm_private_obj *obj = &priv->kms->base;
+	struct drm_private_state *priv_state;
+
+	priv_state = drm_atomic_get_private_obj_state(state, obj);
+	if (IS_ERR_OR_NULL(priv_state))
+		return (struct msm_kms_state *)state; /* casting ERR_PTR */
+
+	return msm_kms_state_from_priv(priv_state);
+}
+
+struct msm_kms_state *msm_kms_state_from_dev(struct drm_device *dev)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	struct drm_private_obj *obj = &priv->kms->base;
+	struct drm_private_state *priv_state = obj->state;
+
+	return msm_kms_state_from_priv(priv_state);
+}
+
+static struct drm_private_state *
+msm_kms_duplicate_state(struct drm_private_obj *obj)
+{
+	struct msm_kms *kms = msm_kms_from_obj(obj);
+	struct msm_kms_state *state = msm_kms_state_from_priv(obj->state);
+	struct msm_kms_state *new_state;
+
+	new_state = kzalloc(sizeof(*new_state), GFP_KERNEL);
+	if (!new_state)
+		return NULL;
+
+	if (kms->funcs->duplicate_state)
+		new_state->state = kms->funcs->duplicate_state(state->state);
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &new_state->base);
+
+	return &new_state->base;
+}
+
+static void msm_kms_destroy_state(struct drm_private_obj *obj,
+				  struct drm_private_state *priv_state)
+{
+	struct msm_kms *kms = msm_kms_from_obj(obj);
+	struct msm_kms_state *state = msm_kms_state_from_priv(priv_state);
+
+	if (kms->funcs->destroy_state)
+		kms->funcs->destroy_state(state->state);
+	kfree(state);
+}
+
+static const struct drm_private_state_funcs kms_state_funcs = {
+	.atomic_duplicate_state = msm_kms_duplicate_state,
+	.atomic_destroy_state = msm_kms_destroy_state,
+};
+
+
 #ifdef CONFIG_DRM_MSM_REGISTER_LOGGING
 static bool reglog = false;
 MODULE_PARM_DESC(reglog, "Enable register read/write logging");
@@ -245,6 +313,8 @@ static int msm_drm_uninit(struct device *dev)
 	flush_workqueue(priv->atomic_wq);
 	destroy_workqueue(priv->atomic_wq);
 
+	drm_atomic_private_obj_fini(&kms->base);
+
 	if (kms && kms->funcs)
 		kms->funcs->destroy(kms);
 
@@ -356,6 +426,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	struct drm_device *ddev;
 	struct msm_drm_private *priv;
 	struct msm_kms *kms;
+	struct msm_kms_state *initial_state;
 	int ret;
 
 	ddev = drm_dev_alloc(drv, dev);
@@ -364,6 +435,10 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 		return PTR_ERR(ddev);
 	}
 
+	initial_state = kzalloc(sizeof(*initial_state), GFP_KERNEL);
+	if (!initial_state)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, ddev);
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -394,7 +469,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	drm_mode_config_init(ddev);
 
 	/* Bind all our sub-components: */
-	ret = component_bind_all(dev, ddev);
+	ret = component_bind_all(dev, initial_state);
 	if (ret) {
 		msm_mdss_destroy(ddev);
 		kfree(priv);
@@ -433,6 +508,10 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 		goto fail;
 	}
 
+	drm_atomic_private_obj_init(&kms->base,
+				    &initial_state->base,
+				    &kms_state_funcs);
+
 	if (kms) {
 		ret = kms->funcs->hw_init(kms);
 		if (ret) {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 48ed5b9a8580..c5b8c989b859 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -162,9 +162,6 @@ struct msm_format {
 
 int msm_atomic_commit(struct drm_device *dev,
 		struct drm_atomic_state *state, bool nonblock);
-struct drm_atomic_state *msm_atomic_state_alloc(struct drm_device *dev);
-void msm_atomic_state_clear(struct drm_atomic_state *state);
-void msm_atomic_state_free(struct drm_atomic_state *state);
 
 void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma, struct sg_table *sgt);
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index 17d5824417ad..24d09fcebf16 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -42,6 +42,8 @@ struct msm_kms_funcs {
 	void (*disable_vblank)(struct msm_kms *kms, struct drm_crtc *crtc);
 	/* swap global atomic state: */
 	void (*swap_state)(struct msm_kms *kms, struct drm_atomic_state *state);
+	void *(*duplicate_state)(void *state);
+	void (*destroy_state)(void *state);
 	/* modeset, bracketing atomic_commit(): */
 	void (*prepare_commit)(struct msm_kms *kms, struct drm_atomic_state *state);
 	void (*complete_commit)(struct msm_kms *kms, struct drm_atomic_state *state);
@@ -68,6 +70,8 @@ struct msm_kms_funcs {
 };
 
 struct msm_kms {
+	struct drm_private_obj base;
+
 	const struct msm_kms_funcs *funcs;
 
 	/* irq number to be passed on to drm_irq_install */
@@ -78,16 +82,23 @@ struct msm_kms {
 };
 
 /**
- * Subclass of drm_atomic_state, to allow kms backend to have driver
+ * Subclass of drm_private_state, to allow kms backend to have driver
  * private global state.  The kms backend can do whatever it wants
- * with the ->state ptr.  On ->atomic_state_clear() the ->state ptr
- * is kfree'd and set back to NULL.
+ * with the ->state ptr.
  */
 struct msm_kms_state {
-	struct drm_atomic_state base;
+	struct drm_private_state base;
 	void *state;
 };
-#define to_kms_state(x) container_of(x, struct msm_kms_state, base)
+
+/**
+ * Extracts the msm_kms_state from either an atomic state, or the current
+ * device. One or the other might be desirable depending on whether you want the
+ * currently configured msm_kms_state (from_dev), or you would like the state
+ * which is about to be applied (from_atomic).
+ */
+struct msm_kms_state *msm_kms_state_from_dev(struct drm_device *dev);
+struct msm_kms_state *msm_kms_state_from_atomic(struct drm_atomic_state *state);
 
 static inline void msm_kms_init(struct msm_kms *kms,
 		const struct msm_kms_funcs *funcs)
-- 
Sean Paul, Software Engineer, Google / Chromium OS
