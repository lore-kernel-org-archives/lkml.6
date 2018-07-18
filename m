Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FE8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77DB20863
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77DB20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbeGRKHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:07:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43965 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbeGRKHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:07:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 943BF20876; Wed, 18 Jul 2018 11:30:42 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4D77C203EC;
        Wed, 18 Jul 2018 11:30:32 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2] drm/sun4i: sun4i: Introduce a quirk for lowest plane alpha support
Date:   Wed, 18 Jul 2018 11:29:48 +0200
Message-Id: <20180718092948.15334-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.18.0
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

Changes since v1:
* reordered backend declaration;
* updated comment to reflect that not all platforms are affected;
* used num_alpha_planes_max variable instead of define, since it is now
  dynamic;
* reordered check to have quirk first in associated conditional.

 drivers/gpu/drm/sun4i/sun4i_backend.c | 40 +++++++++++++++++----------
 drivers/gpu/drm/sun4i/sun4i_backend.h |  1 -
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index de0a76dfa1a2..eda9466b793b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -34,6 +34,8 @@
 struct sun4i_backend_quirks {
 	/* backend <-> TCON muxing selection done in backend */
 	bool needs_output_muxing;
+	/* alpha at the lowest z position is not always supported */
+	bool supports_lowest_plane_alpha;
 };
 
 static const u32 sunxi_rgb2yuv_coef[12] = {
@@ -463,12 +465,14 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 				      struct drm_crtc_state *crtc_state)
 {
 	struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] = { 0 };
+	struct sun4i_backend *backend = engine_to_sun4i_backend(engine);
 	struct drm_atomic_state *state = crtc_state->state;
 	struct drm_device *drm = state->dev;
 	struct drm_plane *plane;
 	unsigned int num_planes = 0;
 	unsigned int num_alpha_planes = 0;
 	unsigned int num_frontend_planes = 0;
+	unsigned int num_alpha_planes_max = 1;
 	unsigned int num_yuv_planes = 0;
 	unsigned int current_pipe = 0;
 	unsigned int i;
@@ -532,33 +536,39 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	 * the layer with the highest priority.
 	 *
 	 * The second step is the actual alpha blending, that takes
-	 * the two pipes as input, and uses the eventual alpha
+	 * the two pipes as input, and uses the potential alpha
 	 * component to do the transparency between the two.
 	 *
-	 * This two steps scenario makes us unable to guarantee a
+	 * This two-step scenario makes us unable to guarantee a
 	 * robust alpha blending between the 4 layers in all
 	 * situations, since this means that we need to have one layer
 	 * with alpha at the lowest position of our two pipes.
 	 *
-	 * However, we cannot even do that, since the hardware has a
-	 * bug where the lowest plane of the lowest pipe (pipe 0,
-	 * priority 0), if it has any alpha, will discard the pixel
-	 * entirely and just display the pixels in the background
-	 * color (black by default).
+	 * However, we cannot even do that on every platform, since the
+	 * hardware has a bug where the lowest plane of the lowest pipe
+	 * (pipe 0, priority 0), if it has any alpha, will discard the
+	 * pixel data entirely and just display the pixels in the
+	 * background color (black by default).
 	 *
-	 * This means that we effectively have only three valid
-	 * configurations with alpha, all of them with the alpha being
-	 * on pipe1 with the lowest position, which can be 1, 2 or 3
-	 * depending on the number of planes and their zpos.
+	 * This means that on the affected platforms, we effectively
+	 * have only three valid configurations with alpha, all of them
+	 * with the alpha being on pipe1 with the lowest position, which
+	 * can be 1, 2 or 3 depending on the number of planes and their zpos.
 	 */
-	if (num_alpha_planes > SUN4I_BACKEND_NUM_ALPHA_LAYERS) {
+
+	/* For platforms that are not affected by the issue described above. */
+	if (backend->quirks->supports_lowest_plane_alpha)
+		num_alpha_planes_max++;
+
+	if (num_alpha_planes > num_alpha_planes_max) {
 		DRM_DEBUG_DRIVER("Too many planes with alpha, rejecting...\n");
 		return -EINVAL;
 	}
 
 	/* We can't have an alpha plane at the lowest position */
-	if (plane_states[0]->fb->format->has_alpha ||
-	    (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE))
+	if (!backend->quirks->supports_lowest_plane_alpha &&
+	    (plane_states[0]->fb->format->has_alpha ||
+	    (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE)))
 		return -EINVAL;
 
 	for (i = 1; i < num_planes; i++) {
@@ -941,9 +951,11 @@ static const struct sun4i_backend_quirks sun6i_backend_quirks = {
 
 static const struct sun4i_backend_quirks sun7i_backend_quirks = {
 	.needs_output_muxing = true,
+	.supports_lowest_plane_alpha = true,
 };
 
 static const struct sun4i_backend_quirks sun8i_a33_backend_quirks = {
+	.supports_lowest_plane_alpha = true,
 };
 
 static const struct sun4i_backend_quirks sun9i_backend_quirks = {
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 4caee0392fa4..c428952f3661 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -167,7 +167,6 @@
 #define SUN4I_BACKEND_PIPE_OFF(p)		(0x5000 + (0x400 * (p)))
 
 #define SUN4I_BACKEND_NUM_LAYERS		4
-#define SUN4I_BACKEND_NUM_ALPHA_LAYERS		1
 #define SUN4I_BACKEND_NUM_FRONTEND_LAYERS	1
 #define SUN4I_BACKEND_NUM_YUV_PLANES		1
 
-- 
2.18.0

