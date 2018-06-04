Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeFDTom (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:44:42 -0400
Received: from anholt.net ([50.246.234.109]:59046 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeFDTok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:44:40 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Kevin Quigley <kevin@kquigley.co.uk>,
        James Hughes <james.hughes@raspberrypi.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH] drm/vc4: Enable the DSI module and link before other enables.
Date: Mon,  4 Jun 2018 12:44:37 -0700
Message-Id: <20180604194437.13790-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want the DSI PHY to be enabled and the DSI module clocked before a
panel or bridge's prepare() function, since most DSI panel drivers
with a prepare() hook are doing DCS transactions inside of them.

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Kevin Quigley <kevin@kquigley.co.uk>
Cc: James Hughes <james.hughes@raspberrypi.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
---

I'm not sure it makes sense to enable CRTCs before encoders on vc4 at
all.  Why start scanning pixels before the encoder is ready to hear
about VSTART?  However, this patch will hopefully unblock people
trying to attach other panels to rpi

 drivers/gpu/drm/vc4/vc4_drv.h |  1 +
 drivers/gpu/drm/vc4/vc4_dsi.c |  3 +--
 drivers/gpu/drm/vc4/vc4_kms.c | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 554a4e810d5b..e7d7bfc75acd 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -711,6 +711,7 @@ int vc4_dpi_debugfs_regs(struct seq_file *m, void *unused);
 /* vc4_dsi.c */
 extern struct platform_driver vc4_dsi_driver;
 int vc4_dsi_debugfs_regs(struct seq_file *m, void *unused);
+void vc4_dsi_prepare(struct drm_encoder *encoder);
 
 /* vc4_fence.c */
 extern const struct dma_fence_ops vc4_fence_ops;
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 8aa897835118..88471731e066 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -875,7 +875,7 @@ static bool vc4_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
 	return true;
 }
 
-static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
+void vc4_dsi_prepare(struct drm_encoder *encoder)
 {
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct vc4_dsi_encoder *vc4_encoder = to_vc4_dsi_encoder(encoder);
@@ -1345,7 +1345,6 @@ static const struct mipi_dsi_host_ops vc4_dsi_host_ops = {
 
 static const struct drm_encoder_helper_funcs vc4_dsi_encoder_helper_funcs = {
 	.disable = vc4_dsi_encoder_disable,
-	.enable = vc4_dsi_encoder_enable,
 	.mode_fixup = vc4_dsi_encoder_mode_fixup,
 };
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 8a411e5f8776..7e9b52ba3448 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -140,6 +140,9 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct drm_connector *connector;
+	struct drm_connector_state *new_conn_state;
+	int i;
 
 	drm_atomic_helper_wait_for_fences(dev, state, false);
 
@@ -151,6 +154,28 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 
 	drm_atomic_helper_commit_planes(dev, state, 0);
 
+	/* Enable DSI link. */
+	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
+		struct drm_encoder *encoder;
+		struct vc4_encoder *vc4_encoder;
+
+		if (!new_conn_state->best_encoder)
+			continue;
+
+		if (!new_conn_state->crtc->state->active ||
+		    !drm_atomic_crtc_needs_modeset(new_conn_state->crtc->state))
+			continue;
+
+		(void)connector;
+		encoder = new_conn_state->best_encoder;
+		vc4_encoder = to_vc4_encoder(encoder);
+
+		if (vc4_encoder->type == VC4_ENCODER_TYPE_DSI0 ||
+		    vc4_encoder->type == VC4_ENCODER_TYPE_DSI1) {
+			vc4_dsi_prepare(encoder);
+		}
+	}
+
 	drm_atomic_helper_commit_modeset_enables(dev, state);
 
 	/* Make sure that drm_atomic_helper_wait_for_vblanks()
-- 
2.17.0
