Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156472087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfAROxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:53:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48087 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfAROv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:51:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CFF2A22456; Fri, 18 Jan 2019 15:51:54 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 00E6920CCB;
        Fri, 18 Jan 2019 15:51:43 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH RESEND v5 12/23] drm/sun4i: frontend: Add support for tiled YUV input mode configuration
Date:   Fri, 18 Jan 2019 15:51:22 +0100
Message-Id: <20190118145133.21281-13-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the data input mode definitions for the tiled YUV mode,
that are used in the input mode helper if tiling is requested.

The modifier is passed to the helper from the framebuffer to determine
if tiling is requested.

Only semiplanar and planar YUV formats are supported for tiling mode.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 14 ++++++++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 6219f5d0dc53..e950370792ce 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -191,19 +191,23 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 
 static int
 sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
-					u32 *val)
+					uint64_t modifier, u32 *val)
 {
+	bool tiled = (modifier == DRM_FORMAT_MOD_ALLWINNER_TILED);
+
 	switch (format->num_planes) {
 	case 1:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
 		return 0;
 
 	case 2:
-		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
+		*val = tiled ? SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_SEMIPLANAR
+			     : SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
 		return 0;
 
 	case 3:
-		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
+		*val = tiled ? SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_PLANAR
+			     : SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
 		return 0;
 
 	default:
@@ -325,6 +329,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
 	const struct drm_format_info *format = fb->format;
+	uint64_t modifier = fb->modifier;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
 	unsigned int i;
@@ -337,7 +342,8 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 		return ret;
 	}
 
-	ret = sun4i_frontend_drm_format_to_input_mode(format, &in_mod_val);
+	ret = sun4i_frontend_drm_format_to_input_mode(format, modifier,
+						      &in_mod_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid input mode\n");
 		return ret;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index c62735c2dc4b..6c4d7797bb8a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -33,6 +33,8 @@
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR	(0 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR	(2 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_PLANAR	(4 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_SEMIPLANAR (6 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444	(0 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422	(1 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420	(2 << 4)
-- 
2.20.1

