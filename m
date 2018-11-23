Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A46C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B7220863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B7220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502763AbeKWUK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49313 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390556AbeKWUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F288320DE1; Fri, 23 Nov 2018 10:26:57 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id DA7D820DE4;
        Fri, 23 Nov 2018 10:26:31 +0100 (CET)
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
Subject: [PATCH v2 17/43] drm/sun4i: frontend: Add helpers for input data mode and pixel sequence
Date:   Fri, 23 Nov 2018 10:24:49 +0100
Message-Id: <20181123092515.2511-18-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces new helpers for retrieving the input data mode and pixel
sequence register field values based on the DRM format instead of
hardcoding these. This makes it easier to add support for more formats.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 46 +++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index f54b1c4a9264..bb5977a466f3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -116,6 +116,30 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 	}
 }
 
+static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
+{
+	switch (fmt) {
+	case DRM_FORMAT_XRGB8888:
+		*val = 1;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
+{
+	switch (fmt) {
+	case DRM_FORMAT_XRGB8888:
+		*val = 1;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
@@ -149,17 +173,29 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	uint32_t format = fb->format->format;
 	u32 out_fmt_val;
-	u32 in_fmt_val;
+	u32 in_fmt_val, in_mod_val, in_ps_val;
 	int ret;
 
-	ret = sun4i_frontend_drm_format_to_input_fmt(fb->format->format,
-						     &in_fmt_val);
+	ret = sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid input format\n");
 		return ret;
 	}
 
+	ret = sun4i_frontend_drm_format_to_input_mode(format, &in_mod_val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid input mode\n");
+		return ret;
+	}
+
+	ret = sun4i_frontend_drm_format_to_input_sequence(format, &in_ps_val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid pixel sequence\n");
+		return ret;
+	}
+
 	ret = sun4i_frontend_drm_format_to_output_fmt(out_fmt, &out_fmt_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid output format\n");
@@ -182,9 +218,9 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 			   SUN4I_FRONTEND_BYPASS_CSC_EN);
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
-		     SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(1) |
+		     SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(in_mod_val) |
 		     SUN4I_FRONTEND_INPUT_FMT_DATA_FMT(in_fmt_val) |
-		     SUN4I_FRONTEND_INPUT_FMT_PS(1));
+		     SUN4I_FRONTEND_INPUT_FMT_PS(in_ps_val));
 
 	/*
 	 * TODO: It look like the A31 and A80 at least will need the
-- 
2.19.1

