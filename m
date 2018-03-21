Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeCUPaz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:30:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47240 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbeCUPas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:30:48 -0400
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 01/10] drm/sun4i: Disable frontend video channel before enabling a layer
Date: Wed, 21 Mar 2018 16:28:55 +0100
Message-Id: <20180321152904.22411-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a dedicated function for disabling the layer video channel
from the frontend to the backend. It is called automatically on an
atomic update, as to disable the frontend by default (it will be enabled
later on in the atomic update if necessary).

It fixes an issue when enabling a layer that uses the frontend (e.g. for
scaling) and then reusing the same layer without the frontend. Since the
video channel to the frontend was never disabled, the backend was still
trying to get data from there.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 8 ++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h | 2 ++
 drivers/gpu/drm/sun4i/sun4i_layer.c   | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 7e647044cbed..e07a33adc51d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -395,6 +395,14 @@ int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend, int layer,
 	return 0;
 }
 
+void sun4i_backend_disable_layer_frontend(struct sun4i_backend *backend,
+					  int layer)
+{
+	regmap_update_bits(backend->engine.regs,
+			   SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN, 0);
+}
+
 static bool sun4i_backend_plane_uses_scaler(struct drm_plane_state *state)
 {
 	u16 src_h = state->src_h >> 16;
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 316f2179e9e1..7ae0f0ffec8c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -204,5 +204,7 @@ int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
 					int layer, uint32_t in_fmt);
 int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend,
 				    int layer, struct drm_plane *plane);
+void sun4i_backend_disable_layer_frontend(struct sun4i_backend *backend,
+					  int layer);
 
 #endif /* _SUN4I_BACKEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 2949a3c912c1..224bb1811e0a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -93,6 +93,8 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 	struct sun4i_backend *backend = layer->backend;
 	struct sun4i_frontend *frontend = backend->frontend;
 
+	sun4i_backend_disable_layer_frontend(backend, layer->id);
+
 	if (layer_state->uses_frontend) {
 		sun4i_frontend_init(frontend);
 		sun4i_frontend_update_coord(frontend, plane);
-- 
2.16.2
