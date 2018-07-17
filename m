Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED01ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48F52146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48F52146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbeGQJYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:24:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57589 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbeGQJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:24:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DE7A620733; Tue, 17 Jul 2018 10:53:12 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 96E09207B4;
        Tue, 17 Jul 2018 10:53:02 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 2/2] drm/sun4i: sun4i: Introduce a quirk for lowest plane alpha support
Date:   Tue, 17 Jul 2018 10:52:30 +0200
Message-Id: <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
References: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all sunxi platforms with the first version of the Display Engine
support an alpha component on the plane with the lowest z position
(as in: lowest z-pos), that gets blended with the background color.

In particular, the A13 is known to have this limitation. However, it was
recently discovered that the A20 and A33 are capable of having alpha on
their lowest plane.

Thus, this introduces a specific quirk to indicate such support,
per-platform. Since this was not tested on sun4i and sun6i platforms, a
conservative approach is kept and this feature is not supported.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index a3cc398d4d80..cdc4a8a91ea2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -35,6 +35,8 @@
 struct sun4i_backend_quirks {
 	/* backend <-> TCON muxing selection done in backend */
 	bool needs_output_muxing;
+	/* alpha at the lowest z position is not always supported */
+	bool supports_lowest_plane_alpha;
 };
 
 static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
@@ -484,6 +486,7 @@ static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
 static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 				      struct drm_crtc_state *crtc_state)
 {
+	struct sun4i_backend *backend = engine_to_sun4i_backend(engine);
 	struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] = { 0 };
 	struct drm_atomic_state *state = crtc_state->state;
 	struct drm_device *drm = state->dev;
@@ -584,8 +587,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	}
 
 	/* We can't have an alpha plane at the lowest position */
-	if (plane_states[0]->fb->format->has_alpha ||
-	    (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE))
+	if ((plane_states[0]->fb->format->has_alpha ||
+	    (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE)) &&
+	    !backend->quirks->supports_lowest_plane_alpha)
 		return -EINVAL;
 
 	for (i = 1; i < num_planes; i++) {
@@ -970,9 +974,11 @@ static const struct sun4i_backend_quirks sun6i_backend_quirks = {
 
 static const struct sun4i_backend_quirks sun7i_backend_quirks = {
 	.needs_output_muxing = true,
+	.supports_lowest_plane_alpha = true,
 };
 
 static const struct sun4i_backend_quirks sun8i_a33_backend_quirks = {
+	.supports_lowest_plane_alpha = true,
 };
 
 static const struct sun4i_backend_quirks sun9i_backend_quirks = {
-- 
2.17.1

