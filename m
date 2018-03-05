Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeCEW2Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:28:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37964 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeCEW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:28:22 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 37/38] drm/rockchip: Disallow PSR for the whole atomic commit
Date: Mon,  5 Mar 2018 23:28:01 +0100
Message-Id: <20180305222802.6659-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222802.6659-1-enric.balletbo@collabora.com>
References: <20180305222802.6659-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

Currently PSR flush is triggered from CRTC's .atomic_begin() callback,
which is executed after modeset disables and enables and before plane
updates are committed. Since PSR flush and re-enable can be triggered
asynchronously by external sources (input event, delayed work), it can
race with hardware programming done in the aforementioned stages.

This patch blocks the PSR completely before hardware programming part
begins and unblock after it ends. This relies on reference counted PSR
disable introduced with previous patch.

Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 61 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  7 ----
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index e266539e04e5..d4f4118b482d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -167,8 +167,67 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	return ERR_PTR(ret);
 }
 
+static void
+rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	u32 encoder_mask = 0;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		encoder_mask |= crtc_state->encoder_mask;
+		encoder_mask |= crtc->state->encoder_mask;
+	}
+
+	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
+		rockchip_drm_psr_inhibit_get(encoder);
+}
+
+static void
+rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	u32 encoder_mask = 0;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		encoder_mask |= crtc_state->encoder_mask;
+		encoder_mask |= crtc->state->encoder_mask;
+	}
+
+	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
+		rockchip_drm_psr_inhibit_put(encoder);
+}
+
+static void
+rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
+{
+	struct drm_device *dev = old_state->dev;
+
+	rockchip_drm_psr_inhibit_get_state(old_state);
+
+	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+
+	drm_atomic_helper_commit_planes(dev, old_state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY);
+
+	rockchip_drm_psr_inhibit_put_state(old_state);
+
+	drm_atomic_helper_commit_hw_done(old_state);
+
+	drm_atomic_helper_wait_for_vblanks(dev, old_state);
+
+	drm_atomic_helper_cleanup_planes(dev, old_state);
+}
+
 static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
-	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+	.atomic_commit_tail = rockchip_atomic_helper_commit_tail_rpm,
 };
 
 static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 42562ab04bde..12ebaec740c6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1032,16 +1032,9 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 }
 
-static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
-				  struct drm_crtc_state *old_crtc_state)
-{
-	rockchip_drm_psr_flush(crtc);
-}
-
 static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
 	.mode_fixup = vop_crtc_mode_fixup,
 	.atomic_flush = vop_crtc_atomic_flush,
-	.atomic_begin = vop_crtc_atomic_begin,
 	.atomic_enable = vop_crtc_atomic_enable,
 	.atomic_disable = vop_crtc_atomic_disable,
 };
-- 
2.16.1
