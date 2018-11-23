Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D67AC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6A020820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6A020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502804AbeKWUKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:31 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49418 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502727AbeKWUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7126220DF9; Fri, 23 Nov 2018 10:26:58 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 039B220E00;
        Fri, 23 Nov 2018 10:26:33 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 25/43] drm/sun4i: frontend: Apply format sub-sampling to CH1 dimensions
Date:   Fri, 23 Nov 2018 10:24:57 +0100
Message-Id: <20181123092515.2511-26-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frontend comes with two "channels", that can be configured
independently. When used in YUV mode, the first channel (CH0) represents
the luminance component while the second channel (CH1) represents the
chrominance. In RGB mode, both have to be configured the same way.

Use variables (with the YUV terminology) for each channel's
dimensions, calculating the chroma dimensions from the luma dimensions
and the sub-sampling factors from the format description.

Since the configured size only has pixel precision, the fractional
fixed-point part of the source size is dropped for both components to
ensure that the scaling factors are accurate.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 5626334c6e87..4700133b96e0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -276,16 +276,24 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 				 struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	uint32_t luma_width, luma_height;
+	uint32_t chroma_width, chroma_height;
 
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Frontend size W: %u H: %u\n",
 			 state->crtc_w, state->crtc_h);
+
+	luma_width = state->src_w >> 16;
+	luma_height = state->src_h >> 16;
+
+	chroma_width = DIV_ROUND_UP(luma_width, fb->format->hsub);
+	chroma_height = DIV_ROUND_UP(luma_height, fb->format->vsub);
+
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_INSIZE_REG,
-		     SUN4I_FRONTEND_INSIZE(state->src_h >> 16,
-					   state->src_w >> 16));
+		     SUN4I_FRONTEND_INSIZE(luma_height, luma_width));
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_INSIZE_REG,
-		     SUN4I_FRONTEND_INSIZE(state->src_h >> 16,
-					   state->src_w >> 16));
+		     SUN4I_FRONTEND_INSIZE(chroma_height, chroma_width));
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_OUTSIZE_REG,
 		     SUN4I_FRONTEND_OUTSIZE(state->crtc_h, state->crtc_w));
@@ -293,14 +301,14 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 		     SUN4I_FRONTEND_OUTSIZE(state->crtc_h, state->crtc_w));
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZFACT_REG,
-		     state->src_w / state->crtc_w);
+		     (luma_width << 16) / state->crtc_w);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZFACT_REG,
-		     state->src_w / state->crtc_w);
+		     (chroma_width << 16) / state->crtc_w);
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTFACT_REG,
-		     state->src_h / state->crtc_h);
+		     (luma_height << 16) / state->crtc_h);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTFACT_REG,
-		     state->src_h / state->crtc_h);
+		     (chroma_height << 16) / state->crtc_h);
 
 	regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
 			  SUN4I_FRONTEND_FRM_CTRL_REG_RDY,
-- 
2.19.1

