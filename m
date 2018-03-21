Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeCUPa5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:30:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47248 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeCUPas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the frontend and set interlace
Date: Wed, 21 Mar 2018 16:28:56 +0100
Message-Id: <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The YUV channel was only disabled in sun4i_backend_update_layer_formats,
which is not called when the frontend is selected.

Thus, creating a layer with a YUV format handled by the backend and then
switching to a format that requires the frontend would keep the YUV
channel enabled for the layer.

This explicitly disables the YUV channel for the layer when using the
frontend as well. It also sets the relevant interlace bit, which was
missing in the frontend path as well.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 17 ++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h |  3 ++-
 drivers/gpu/drm/sun4i/sun4i_layer.c   |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index e07a33adc51d..b98dafda52f8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -294,8 +294,10 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 }
 
 int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
-					int layer, uint32_t fmt)
+					int layer, struct drm_plane *plane,
+					uint32_t fmt)
 {
+	bool interlaced = false;
 	u32 val;
 	int ret;
 
@@ -305,11 +307,24 @@ int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
 		return ret;
 	}
 
+	/* Clear the YUV mode */
+	regmap_update_bits(backend->engine.regs,
+			   SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN, 0);
+
 	regmap_update_bits(backend->engine.regs,
 			   SUN4I_BACKEND_ATTCTL_REG0(layer),
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN);
 
+	if (plane->state->crtc)
+		interlaced = plane->state->crtc->state->adjusted_mode.flags
+			& DRM_MODE_FLAG_INTERLACE;
+
+	regmap_update_bits(backend->engine.regs, SUN4I_BACKEND_MODCTL_REG,
+			   SUN4I_BACKEND_MODCTL_ITLMOD_EN,
+			   interlaced ? SUN4I_BACKEND_MODCTL_ITLMOD_EN : 0);
+
 	regmap_update_bits(backend->engine.regs,
 			   SUN4I_BACKEND_ATTCTL_REG1(layer),
 			   SUN4I_BACKEND_ATTCTL_REG1_LAY_FBFMT, val);
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 7ae0f0ffec8c..cb6df2b690c0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -201,7 +201,8 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 				      int layer, struct drm_plane *plane);
 int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
-					int layer, uint32_t in_fmt);
+					int layer, struct drm_plane *plane,
+					uint32_t fmt);
 int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend,
 				    int layer, struct drm_plane *plane);
 void sun4i_backend_disable_layer_frontend(struct sun4i_backend *backend,
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 224bb1811e0a..eb93df445a10 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -101,7 +101,7 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 		sun4i_frontend_update_buffer(frontend, plane);
 		sun4i_frontend_update_formats(frontend, plane,
 					      DRM_FORMAT_ARGB8888);
-		sun4i_backend_update_layer_frontend(backend, layer->id,
+		sun4i_backend_update_layer_frontend(backend, layer->id, plane,
 						    DRM_FORMAT_ARGB8888);
 		sun4i_frontend_enable(frontend);
 	} else {
-- 
2.16.2
