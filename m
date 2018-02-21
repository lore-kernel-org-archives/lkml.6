Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937808AbeBUOia (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:38:30 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36587 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeBUOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:38:27 -0500
X-Google-Smtp-Source: AH8x2275HuStYhgw543NwNYgvIOe2+nfoXsZ3fV/U8ngbkPWzOdQEWKiWYVgfuERCzmnUDEl6FKd2Q==
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
Subject: [PATCH 3/4] drm/msm/mdp5: Use the new private_obj state
Date: Wed, 21 Feb 2018 09:37:23 -0500
Message-Id: <20180221143730.30285-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221143730.30285-1-robdclark@gmail.com>
References: <20180221143730.30285-1-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archit Taneja <architt@codeaurora.org>

This replaces the usage of the subclassed atomic state (mdp5_state)
with a private_obj state embedded within drm_atomic_state. The latter
method is the preferred approach, since it's simpler to implement
and less prone to errors.

The new API replaces the older and equivalent mdp5_state usage in the
following pattern:
- References to "mdp5_kms->state" (i.e, the old/existing state) is
  replaced with mdp5_get_existing_global_state(). In the atomic_check
  path, this should be called with the glob_state_lock drm_modeset_lock
  alredy taken.
- References to "mdp5_get_state()" are replaced with
  mdp5_get_global_state(). This acquires glob_state_lock and uses
  drm_atomic_get_private_obj_state() to create a new duplicated state.

Signed-off-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 10 ++++++++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c | 12 ++++++------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c  | 20 +++++++++++---------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c   | 17 ++++++++++++-----
 4 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 0f314c1f3e8a..a7e80ebf0207 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -183,11 +183,14 @@ static void mdp5_prepare_commit(struct msm_kms *kms, struct drm_atomic_state *st
 {
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
 	struct device *dev = &mdp5_kms->pdev->dev;
+	struct mdp5_global_state *global_state;
+
+	global_state = mdp5_get_existing_global_state(mdp5_kms);
 
 	pm_runtime_get_sync(dev);
 
 	if (mdp5_kms->smp)
-		mdp5_smp_prepare_commit(mdp5_kms->smp, &mdp5_kms->state->smp);
+		mdp5_smp_prepare_commit(mdp5_kms->smp, &global_state->smp);
 }
 
 static void mdp5_commit(struct msm_kms *kms, struct drm_atomic_state *state)
@@ -209,9 +212,12 @@ static void mdp5_complete_commit(struct msm_kms *kms, struct drm_atomic_state *s
 {
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
 	struct device *dev = &mdp5_kms->pdev->dev;
+	struct mdp5_global_state *global_state;
+
+	global_state = mdp5_get_existing_global_state(mdp5_kms);
 
 	if (mdp5_kms->smp)
-		mdp5_smp_complete_commit(mdp5_kms->smp, &mdp5_kms->state->smp);
+		mdp5_smp_complete_commit(mdp5_kms->smp, &global_state->smp);
 
 	pm_runtime_put_sync(dev);
 }
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
index 8a00991f03c7..113e6b569562 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
@@ -52,14 +52,14 @@ int mdp5_mixer_assign(struct drm_atomic_state *s, struct drm_crtc *crtc,
 {
 	struct msm_drm_private *priv = s->dev->dev_private;
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct mdp5_state *state = mdp5_get_state(s);
+	struct mdp5_global_state *global_state = mdp5_get_global_state(s);
 	struct mdp5_hw_mixer_state *new_state;
 	int i;
 
-	if (IS_ERR(state))
-		return PTR_ERR(state);
+	if (IS_ERR(global_state))
+		return PTR_ERR(global_state);
 
-	new_state = &state->hwmixer;
+	new_state = &global_state->hwmixer;
 
 	for (i = 0; i < mdp5_kms->num_hwmixers; i++) {
 		struct mdp5_hw_mixer *cur = mdp5_kms->hwmixers[i];
@@ -129,8 +129,8 @@ int mdp5_mixer_assign(struct drm_atomic_state *s, struct drm_crtc *crtc,
 
 void mdp5_mixer_release(struct drm_atomic_state *s, struct mdp5_hw_mixer *mixer)
 {
-	struct mdp5_state *state = mdp5_get_state(s);
-	struct mdp5_hw_mixer_state *new_state = &state->hwmixer;
+	struct mdp5_global_state *global_state = mdp5_get_global_state(s);
+	struct mdp5_hw_mixer_state *new_state = &global_state->hwmixer;
 
 	if (!mixer)
 		return;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
index ff52c49095f9..1ef26bc63163 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
@@ -24,17 +24,19 @@ int mdp5_pipe_assign(struct drm_atomic_state *s, struct drm_plane *plane,
 {
 	struct msm_drm_private *priv = s->dev->dev_private;
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct mdp5_state *state;
+	struct mdp5_global_state *new_global_state, *old_global_state;
 	struct mdp5_hw_pipe_state *old_state, *new_state;
 	int i, j;
 
-	state = mdp5_get_state(s);
-	if (IS_ERR(state))
-		return PTR_ERR(state);
+	new_global_state = mdp5_get_global_state(s);
+	if (IS_ERR(new_global_state))
+		return PTR_ERR(new_global_state);
 
-	/* grab old_state after mdp5_get_state(), since now we hold lock: */
-	old_state = &mdp5_kms->state->hwpipe;
-	new_state = &state->hwpipe;
+	/* grab old_state after mdp5_get_global_state(), since now we hold lock: */
+	old_global_state = mdp5_get_existing_global_state(mdp5_kms);
+
+	old_state = &old_global_state->hwpipe;
+	new_state = &new_global_state->hwpipe;
 
 	for (i = 0; i < mdp5_kms->num_hwpipes; i++) {
 		struct mdp5_hw_pipe *cur = mdp5_kms->hwpipes[i];
@@ -107,7 +109,7 @@ int mdp5_pipe_assign(struct drm_atomic_state *s, struct drm_plane *plane,
 		WARN_ON(r_hwpipe);
 
 		DBG("%s: alloc SMP blocks", (*hwpipe)->name);
-		ret = mdp5_smp_assign(mdp5_kms->smp, &state->smp,
+		ret = mdp5_smp_assign(mdp5_kms->smp, &new_global_state->smp,
 				(*hwpipe)->pipe, blkcfg);
 		if (ret)
 			return -ENOMEM;
@@ -132,7 +134,7 @@ void mdp5_pipe_release(struct drm_atomic_state *s, struct mdp5_hw_pipe *hwpipe)
 {
 	struct msm_drm_private *priv = s->dev->dev_private;
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct mdp5_state *state = mdp5_get_state(s);
+	struct mdp5_global_state *state = mdp5_get_global_state(s);
 	struct mdp5_hw_pipe_state *new_state = &state->hwpipe;
 
 	if (!hwpipe)
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index ae4983d9d0a5..1408eec75440 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -340,17 +340,20 @@ void mdp5_smp_dump(struct mdp5_smp *smp, struct drm_printer *p)
 	struct mdp5_kms *mdp5_kms = get_kms(smp);
 	struct mdp5_hw_pipe_state *hwpstate;
 	struct mdp5_smp_state *state;
+	struct mdp5_global_state *global_state;
 	int total = 0, i, j;
 
 	drm_printf(p, "name\tinuse\tplane\n");
 	drm_printf(p, "----\t-----\t-----\n");
 
 	if (drm_can_sleep())
-		drm_modeset_lock(&mdp5_kms->state_lock, NULL);
+		drm_modeset_lock(&mdp5_kms->glob_state.lock, NULL);
+
+	global_state = mdp5_get_existing_global_state(mdp5_kms);
 
 	/* grab these *after* we hold the state_lock */
-	hwpstate = &mdp5_kms->state->hwpipe;
-	state = &mdp5_kms->state->smp;
+	hwpstate = &global_state->hwpipe;
+	state = &global_state->smp;
 
 	for (i = 0; i < mdp5_kms->num_hwpipes; i++) {
 		struct mdp5_hw_pipe *hwpipe = mdp5_kms->hwpipes[i];
@@ -374,7 +377,7 @@ void mdp5_smp_dump(struct mdp5_smp *smp, struct drm_printer *p)
 			bitmap_weight(state->state, smp->blk_cnt));
 
 	if (drm_can_sleep())
-		drm_modeset_unlock(&mdp5_kms->state_lock);
+		drm_modeset_unlock(&mdp5_kms->glob_state.lock);
 }
 
 void mdp5_smp_destroy(struct mdp5_smp *smp)
@@ -384,7 +387,8 @@ void mdp5_smp_destroy(struct mdp5_smp *smp)
 
 struct mdp5_smp *mdp5_smp_init(struct mdp5_kms *mdp5_kms, const struct mdp5_smp_block *cfg)
 {
-	struct mdp5_smp_state *state = &mdp5_kms->state->smp;
+	struct mdp5_smp_state *state;
+	struct mdp5_global_state *global_state;
 	struct mdp5_smp *smp = NULL;
 	int ret;
 
@@ -398,6 +402,9 @@ struct mdp5_smp *mdp5_smp_init(struct mdp5_kms *mdp5_kms, const struct mdp5_smp_
 	smp->blk_cnt = cfg->mmb_count;
 	smp->blk_size = cfg->mmb_size;
 
+	global_state = mdp5_get_existing_global_state(mdp5_kms);
+	state = &global_state->smp;
+
 	/* statically tied MMBs cannot be re-allocated: */
 	bitmap_copy(state->state, cfg->reserved_state, smp->blk_cnt);
 	memcpy(smp->reserved, cfg->reserved, sizeof(smp->reserved));
-- 
2.14.3
