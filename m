Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeA3Ual (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:30:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeA3UaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:30:07 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 42/43] drm/rockchip: Disallow PSR for the whole atomic commit
Date: Tue, 30 Jan 2018 21:29:12 +0100
Message-Id: <20180130202913.28724-43-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
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
index 4abb9d72d814..8c11a4dc436e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1041,16 +1041,9 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
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
2.14.1
