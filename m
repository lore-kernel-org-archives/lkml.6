Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbeCFN6r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:58:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35042 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753535AbeCFN5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:57:16 -0500
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 1/7] drm/sun4i: tcon: Add TRI finish interrupt for vblank
Date: Tue,  6 Mar 2018 14:55:58 +0100
Message-Id: <1903b01ae43dafc43a8d3cfb325ac1db6aed60f4.1520344489.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The "CPU" (or Intel 8080) interface uses a different interrupt called
TRI_FINISH (most likely TRI being for trigger) to notify the end of frames,
and hence the VBLANK period.

And that interrupt to the possible VBLANK interrupts source.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c |  9 ++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index b3960118deb9..7e5134bfb028 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -196,7 +196,8 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
 	DRM_DEBUG_DRIVER("%sabling VBLANK interrupt\n", enable ? "En" : "Dis");
 
 	mask = SUN4I_TCON_GINT0_VBLANK_ENABLE(0) |
-	       SUN4I_TCON_GINT0_VBLANK_ENABLE(1);
+		SUN4I_TCON_GINT0_VBLANK_ENABLE(1) |
+		SUN4I_TCON_GINT0_TCON0_TRI_FINISH_ENABLE;
 
 	if (enable)
 		val = mask;
@@ -548,7 +549,8 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 	regmap_read(tcon->regs, SUN4I_TCON_GINT0_REG, &status);
 
 	if (!(status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
-			SUN4I_TCON_GINT0_VBLANK_INT(1))))
+			SUN4I_TCON_GINT0_VBLANK_INT(1) |
+			SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT)))
 		return IRQ_NONE;
 
 	drm_crtc_handle_vblank(&scrtc->crtc);
@@ -557,7 +559,8 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 	/* Acknowledge the interrupt */
 	regmap_update_bits(tcon->regs, SUN4I_TCON_GINT0_REG,
 			   SUN4I_TCON_GINT0_VBLANK_INT(0) |
-			   SUN4I_TCON_GINT0_VBLANK_INT(1),
+			   SUN4I_TCON_GINT0_VBLANK_INT(1) |
+			   SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT,
 			   0);
 
 	return IRQ_HANDLED;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b761c7b823c5..067183076807 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -28,7 +28,11 @@
 
 #define SUN4I_TCON_GINT0_REG			0x4
 #define SUN4I_TCON_GINT0_VBLANK_ENABLE(pipe)		BIT(31 - (pipe))
+#define SUN4I_TCON_GINT0_TCON0_TRI_FINISH_ENABLE	BIT(27)
+#define SUN4I_TCON_GINT0_TCON0_TRI_COUNTER_ENABLE	BIT(26)
 #define SUN4I_TCON_GINT0_VBLANK_INT(pipe)		BIT(15 - (pipe))
+#define SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT		BIT(11)
+#define SUN4I_TCON_GINT0_TCON0_TRI_COUNTER_INT		BIT(10)
 
 #define SUN4I_TCON_GINT1_REG			0x8
 #define SUN4I_TCON_FRM_CTL_REG			0x10
-- 
git-series 0.9.1
