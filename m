Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755392AbeBOKTo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:19:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54576 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755267AbeBOKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:19:42 -0500
X-Google-Smtp-Source: AH8x2266K+vNSSYeORoz3Gj9BL6nNhPJsmA8/SAQy3ak8oziU85UOFGuBeaC4MuBei8MrGrUhMF6og==
From: Neil Armstrong <narmstrong@baylibre.com>
To: airlied@linux.ie
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Lazo <michal.lazo@gmail.com>
Subject: [PATCH] drm/meson: fix vsync buffer update
Date: Thu, 15 Feb 2018 11:19:36 +0100
Message-Id: <1518689976-23292-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plane buffer address/stride/height was incorrectly updated in the
plane_atomic_update operation instead of the vsync irq.
This patch delays this operation in the vsync irq along with the
other plane delayed setup.

This issue was masked using legacy framebuffer and X11 modesetting, but
is clearly visible using gbm rendering when buffer is submitted late after
vblank, like using software decoding and OpenGL rendering in Kodi.
With this patch, tearing and other artifacts disappears completely.

Cc: Michal Lazo <michal.lazo@gmail.com>
Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c  | 6 ++++++
 drivers/gpu/drm/meson/meson_drv.h   | 3 +++
 drivers/gpu/drm/meson/meson_plane.c | 7 +++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 5155f01..0552020 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -36,6 +36,7 @@
 #include "meson_venc.h"
 #include "meson_vpp.h"
 #include "meson_viu.h"
+#include "meson_canvas.h"
 #include "meson_registers.h"
 
 /* CRTC definition */
@@ -192,6 +193,11 @@ void meson_crtc_irq(struct meson_drm *priv)
 		} else
 			meson_vpp_disable_interlace_vscaler_osd1(priv);
 
+		meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
+			   priv->viu.osd1_addr, priv->viu.osd1_stride,
+			   priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
+			   MESON_CANVAS_BLKMODE_LINEAR);
+
 		/* Enable OSD1 */
 		writel_bits_relaxed(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
 				    priv->io_base + _REG(VPP_MISC));
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index 5e8b392..8450d6ac 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -43,6 +43,9 @@ struct meson_drm {
 		bool osd1_commit;
 		uint32_t osd1_ctrl_stat;
 		uint32_t osd1_blk0_cfg[5];
+		uint32_t osd1_addr;
+		uint32_t osd1_stride;
+		uint32_t osd1_height;
 	} viu;
 
 	struct {
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index d0a6ac8..27bd350 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -164,10 +164,9 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 	/* Update Canvas with buffer address */
 	gem = drm_fb_cma_get_gem_obj(fb, 0);
 
-	meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
-			   gem->paddr, fb->pitches[0],
-			   fb->height, MESON_CANVAS_WRAP_NONE,
-			   MESON_CANVAS_BLKMODE_LINEAR);
+	priv->viu.osd1_addr = gem->paddr;
+	priv->viu.osd1_stride = fb->pitches[0];
+	priv->viu.osd1_height = fb->height;
 
 	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
 }
-- 
2.7.4
