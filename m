Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889B420820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889B420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394065AbeKWUM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:12:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49432 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408929AbeKWUK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0215720F10; Fri, 23 Nov 2018 10:26:59 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id E1C8C20EB8;
        Fri, 23 Nov 2018 10:26:35 +0100 (CET)
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
Subject: [PATCH v2 32/43] drm/sun4i: Pass modifier to backend and frontend format support helpers
Date:   Fri, 23 Nov 2018 10:25:04 +0100
Message-Id: <20181123092515.2511-33-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare the introduction of tiled mode support, pass the framebuffer
format modifier to the helpers dealing with format support.

Since only linear mode is supported for now, add corresponding checks in
each helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 10 +++++++---
 drivers/gpu/drm/sun4i/sun4i_backend.h  |  2 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c |  5 ++++-
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 986bdb64521c..bbadc2ab9f4d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -175,10 +175,13 @@ static const uint32_t sun4i_backend_formats[] = {
 	DRM_FORMAT_YVYU,
 };
 
-bool sun4i_backend_format_is_supported(uint32_t fmt)
+bool sun4i_backend_format_is_supported(uint32_t fmt, uint64_t modifier)
 {
 	unsigned int i;
 
+	if (modifier != DRM_FORMAT_MOD_LINEAR)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(sun4i_backend_formats); i++)
 		if (sun4i_backend_formats[i] == fmt)
 			return true;
@@ -455,14 +458,15 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	struct sun4i_layer *layer = plane_to_sun4i_layer(state->plane);
 	struct sun4i_backend *backend = layer->backend;
 	uint32_t format = state->fb->format->format;
+	uint64_t modifier = state->fb->modifier;
 
 	if (IS_ERR(backend->frontend))
 		return false;
 
-	if (!sun4i_frontend_format_is_supported(format))
+	if (!sun4i_frontend_format_is_supported(format, modifier))
 		return false;
 
-	if (!sun4i_backend_format_is_supported(format))
+	if (!sun4i_backend_format_is_supported(format, modifier))
 		return true;
 
 	/*
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 93db3af675b3..01f66463271b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -198,7 +198,7 @@ engine_to_sun4i_backend(struct sunxi_engine *engine)
 
 void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 				int layer, bool enable);
-bool sun4i_backend_format_is_supported(uint32_t fmt);
+bool sun4i_backend_format_is_supported(uint32_t fmt, uint64_t modifier);
 int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 				     int layer, struct drm_plane *plane);
 int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 001139417cf5..b78e0a208c95 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -299,10 +299,13 @@ static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_YVYU,
 };
 
-bool sun4i_frontend_format_is_supported(uint32_t fmt)
+bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier)
 {
 	unsigned int i;
 
+	if (modifier != DRM_FORMAT_MOD_LINEAR)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(sun4i_frontend_formats); i++)
 		if (sun4i_frontend_formats[i] == fmt)
 			return true;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 54ec71a3e2f4..b209eacdf8c2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -115,6 +115,6 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 				 struct drm_plane *plane);
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt);
-bool sun4i_frontend_format_is_supported(uint32_t fmt);
+bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier);
 
 #endif /* _SUN4I_FRONTEND_H_ */
-- 
2.19.1

