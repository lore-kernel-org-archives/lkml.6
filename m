Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BA6C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760BD206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760BD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLDOXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:23:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbeLDOXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1CE1E20E81; Tue,  4 Dec 2018 15:23:18 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8565520DC9;
        Tue,  4 Dec 2018 15:22:41 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 11/21] drm/sun4i: frontend: Add support for tiled YUV input mode configuration
Date:   Tue,  4 Dec 2018 15:22:08 +0100
Message-Id: <20181204142218.16284-12-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
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
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 14 ++++++++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 8e6e1f2d1a18..3dcb05147e41 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -190,19 +190,23 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 
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
@@ -324,6 +328,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
 	const struct drm_format_info *format = fb->format;
+	uint64_t modifier = fb->modifier;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
 	unsigned int i;
@@ -336,7 +341,8 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 		return ret;
 	}
 
-	ret = sun4i_frontend_drm_format_to_input_mode(format, &in_mod_val);
+	ret = sun4i_frontend_drm_format_to_input_mode(format, modifier,
+						      &in_mod_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid input mode\n");
 		return ret;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index b209eacdf8c2..ae53ee644694 100644
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
2.19.2

