Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034293AbeE1Krp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163272AbeE1Krj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Lazo <michal.lazo@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 103/496] drm/meson: fix vsync buffer update
Date: Mon, 28 May 2018 11:58:08 +0200
Message-Id: <20180528100324.186606161@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit e88230a3744a71a0b5ecfb45e08ddfe1c884e50d ]

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
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1518689976-23292-1-git-send-email-narmstrong@baylibre.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/meson/meson_crtc.c  |    6 ++++++
 drivers/gpu/drm/meson/meson_drv.h   |    3 +++
 drivers/gpu/drm/meson/meson_plane.c |    7 +++----
 3 files changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -36,6 +36,7 @@
 #include "meson_venc.h"
 #include "meson_vpp.h"
 #include "meson_viu.h"
+#include "meson_canvas.h"
 #include "meson_registers.h"
 
 /* CRTC definition */
@@ -192,6 +193,11 @@ void meson_crtc_irq(struct meson_drm *pr
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
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -164,10 +164,9 @@ static void meson_plane_atomic_update(st
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
