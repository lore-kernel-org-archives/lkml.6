Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B27C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62734206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62734206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeLDOX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:23:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33388 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeLDOXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:24 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2ACA420E97; Tue,  4 Dec 2018 15:23:19 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4666D20E1F;
        Tue,  4 Dec 2018 15:22:42 +0100 (CET)
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
Subject: [PATCH v3 14/21] drm/sun4i: layer: Add tiled modifier support and helper
Date:   Tue,  4 Dec 2018 15:22:11 +0100
Message-Id: <20181204142218.16284-15-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a list of supported modifiers for the driver, that
includes the Allwinner tiled modifier, as well as a format_mod_supported
callback.

The callback uses both the backend and frontend helpers to indicate
per-format modifier support (including for the linear modifier).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 8cf8ca997b1d..c5a999ca1d72 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -114,6 +114,13 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 	sun4i_backend_layer_enable(backend, layer->id, true);
 }
 
+static bool sun4i_layer_format_mod_supported(struct drm_plane *plane,
+					     uint32_t format, uint64_t modifier)
+{
+	return sun4i_backend_format_is_supported(format, modifier) ||
+	       sun4i_frontend_format_is_supported(format, modifier);
+}
+
 static const struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
 	.prepare_fb	= drm_gem_fb_prepare_fb,
 	.atomic_disable	= sun4i_backend_layer_atomic_disable,
@@ -127,6 +134,7 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= sun4i_backend_layer_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
+	.format_mod_supported	= sun4i_layer_format_mod_supported,
 };
 
 static const uint32_t sun4i_layer_formats[] = {
@@ -157,6 +165,12 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_YVYU,
 };
 
+static const uint64_t sun4i_layer_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_ALLWINNER_TILED,
+	DRM_FORMAT_MOD_INVALID
+};
+
 static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 						struct sun4i_backend *backend,
 						enum drm_plane_type type)
@@ -173,7 +187,7 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 				       &sun4i_backend_layer_funcs,
 				       sun4i_layer_formats,
 				       ARRAY_SIZE(sun4i_layer_formats),
-				       NULL, type, NULL);
+				       sun4i_layer_modifiers, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
-- 
2.19.2

