Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC15C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825E820861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825E820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502659AbeKWUKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49206 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502644AbeKWUKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0BE35213F9; Fri, 23 Nov 2018 10:26:48 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2E57420DC1;
        Fri, 23 Nov 2018 10:26:29 +0100 (CET)
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
Subject: [PATCH v2 07/43] drm/sun4i: backend: Use a specific function to check if a plane is supported
Date:   Fri, 23 Nov 2018 10:24:39 +0100
Message-Id: <20181123092515.2511-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, it is assumed that a plane is supported either
through the frontend or through the backend alone. However, the DRM
interface does not allow finely reporting our hardware capabilities
and there are cases where neither are support.

In particular, some plane formats are supported by the backend and not
the frontend, so they can only be supported without scaling.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 735fea7ead0b..52caf561da0e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -477,6 +477,23 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	return false;
 }
 
+static bool sun4i_backend_plane_is_supported(struct drm_plane_state *state,
+					     bool *uses_frontend)
+{
+	if (sun4i_backend_plane_uses_frontend(state)) {
+		*uses_frontend = true;
+		return true;
+	}
+
+	*uses_frontend = false;
+
+	/* Scaling is not supported without the frontend. */
+	if (sun4i_backend_plane_uses_scaler(state))
+		return false;
+
+	return true;
+}
+
 static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
 				       struct drm_crtc_state *old_state)
 {
@@ -517,14 +534,14 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		struct drm_framebuffer *fb = plane_state->fb;
 		struct drm_format_name_buf format_name;
 
-		if (sun4i_backend_plane_uses_frontend(plane_state)) {
+		if (!sun4i_backend_plane_is_supported(plane_state,
+						      &layer_state->uses_frontend))
+			return -EINVAL;
+
+		if (layer_state->uses_frontend) {
 			DRM_DEBUG_DRIVER("Using the frontend for plane %d\n",
 					 plane->index);
-
-			layer_state->uses_frontend = true;
 			num_frontend_planes++;
-		} else {
-			layer_state->uses_frontend = false;
 		}
 
 		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
-- 
2.19.1

