Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937718AbeBUOiK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:38:10 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44269 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeBUOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:38:07 -0500
X-Google-Smtp-Source: AH8x226KvrD9in6a88pXHiSujj3ao4MhjmwS2EeKkpPEdGcOm7JmcruwHDbVy2CNLwTS033cc6K6KQ==
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sean Paul <seanpaul@chromium.org>, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/msm/mdp5: Add global state as a private atomic object
Date: Wed, 21 Feb 2018 09:37:22 -0500
Message-Id: <20180221143730.30285-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221143730.30285-1-robdclark@gmail.com>
References: <20180221143730.30285-1-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archit Taneja <architt@codeaurora.org>

Global shared resources (hwpipes, hwmixers and SMP) for MDP5 are
implemented as a part of atomic state by subclassing drm_atomic_state.

The preferred approach is to use the drm_private_obj infrastructure
available in the atomic core.

mdp5_global_state is introduced as a drm atomic private object. The two
funcs mdp5_get_global_state() and mdp5_get_existing_global_state() are
the two variants that will be used to access mdp5_global_state.

This will replace the existing mdp5_state struct (which subclasses
drm_atomic_state) and the funcs around it. These will be removed later
once we mdp5_global_state is put to use everywhere.

Signed-off-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 79 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h | 24 ++++++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 7ad0560dbc9f..0f314c1f3e8a 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -106,6 +106,79 @@ static void mdp5_swap_state(struct msm_kms *kms, struct drm_atomic_state *state)
 	swap(to_kms_state(state)->state, mdp5_kms->state);
 }
 
+/* Global/shared object state funcs */
+
+/*
+ * This is a helper that returns the private state currently in operation.
+ * Note that this would return the "old_state" if called in the atomic check
+ * path, and the "new_state" after the atomic swap has been done.
+ */
+struct mdp5_global_state *
+mdp5_get_existing_global_state(struct mdp5_kms *mdp5_kms)
+{
+	return to_mdp5_global_state(mdp5_kms->glob_state.state);
+}
+
+/*
+ * This acquires the modeset lock set aside for global state, creates
+ * a new duplicated private object state.
+ */
+struct mdp5_global_state *mdp5_get_global_state(struct drm_atomic_state *s)
+{
+	struct msm_drm_private *priv = s->dev->dev_private;
+	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
+	struct drm_private_state *priv_state;
+
+	priv_state = drm_atomic_get_private_obj_state(s, &mdp5_kms->glob_state);
+	if (IS_ERR(priv_state))
+		return ERR_CAST(priv_state);
+
+	return to_mdp5_global_state(priv_state);
+}
+
+static struct drm_private_state *
+mdp5_global_duplicate_state(struct drm_private_obj *obj)
+{
+	struct mdp5_global_state *state;
+
+	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
+
+	return &state->base;
+}
+
+static void mdp5_global_destroy_state(struct drm_private_obj *obj,
+				      struct drm_private_state *state)
+{
+	struct mdp5_global_state *mdp5_state = to_mdp5_global_state(state);
+
+	kfree(mdp5_state);
+}
+
+static const struct drm_private_state_funcs mdp5_global_state_funcs = {
+	.atomic_duplicate_state = mdp5_global_duplicate_state,
+	.atomic_destroy_state = mdp5_global_destroy_state,
+};
+
+static int mdp5_global_obj_init(struct mdp5_kms *mdp5_kms)
+{
+	struct mdp5_global_state *state;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	state->mdp5_kms = mdp5_kms;
+
+	drm_atomic_private_obj_init(&mdp5_kms->glob_state,
+				    &state->base,
+				    &mdp5_global_state_funcs);
+	return 0;
+}
+
 static void mdp5_prepare_commit(struct msm_kms *kms, struct drm_atomic_state *state)
 {
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
@@ -779,6 +852,8 @@ static void mdp5_destroy(struct platform_device *pdev)
 	if (mdp5_kms->rpm_enabled)
 		pm_runtime_disable(&pdev->dev);
 
+	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
+
 	kfree(mdp5_kms->state);
 }
 
@@ -939,6 +1014,10 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 		goto fail;
 	}
 
+	ret = mdp5_global_obj_init(mdp5_kms);
+	if (ret)
+		goto fail;
+
 	mdp5_kms->mmio = msm_ioremap(pdev, "mdp_phys", "MDP5");
 	if (IS_ERR(mdp5_kms->mmio)) {
 		ret = PTR_ERR(mdp5_kms->mmio);
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
index 312e6a47dff8..1c70aac20a98 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
@@ -57,6 +57,12 @@ struct mdp5_kms {
 	struct mdp5_state *state;
 	struct drm_modeset_lock state_lock;
 
+	/*
+	 * Global private object state, Do not access directly, use
+	 * mdp5_global_get_state()
+	 */
+	struct drm_private_obj glob_state;
+
 	struct mdp5_smp *smp;
 	struct mdp5_ctl_manager *ctlm;
 
@@ -97,6 +103,24 @@ struct mdp5_state {
 struct mdp5_state *__must_check
 mdp5_get_state(struct drm_atomic_state *s);
 
+/* Global private object state for tracking resources that are shared across
+ * multiple kms objects (planes/crtcs/etc).
+ */
+#define to_mdp5_global_state(x) container_of(x, struct mdp5_global_state, base)
+struct mdp5_global_state {
+	struct drm_private_state base;
+
+	struct drm_atomic_state *state;
+	struct mdp5_kms *mdp5_kms;
+
+	struct mdp5_hw_pipe_state hwpipe;
+	struct mdp5_hw_mixer_state hwmixer;
+	struct mdp5_smp_state smp;
+};
+
+struct mdp5_global_state * mdp5_get_existing_global_state(struct mdp5_kms *mdp5_kms);
+struct mdp5_global_state *__must_check mdp5_get_global_state(struct drm_atomic_state *s);
+
 /* Atomic plane state.  Subclasses the base drm_plane_state in order to
  * track assigned hwpipe and hw specific state.
  */
-- 
2.14.3
