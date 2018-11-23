Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BD2C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B9420820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B9420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502615AbeKWUKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49140 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388038AbeKWUKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E525B207AB; Fri, 23 Nov 2018 10:26:37 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 95591207AB;
        Fri, 23 Nov 2018 10:26:27 +0100 (CET)
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
Subject: [PATCH v2 01/43] drm/sun4i: Cleanup video/YUV source before enabling a layer
Date:   Fri, 23 Nov 2018 10:24:33 +0100
Message-Id: <20181123092515.2511-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a dedicated function for cleaning the video and YUV source
channel layer enable bits. This function is called first on layer atomic
update to make sure that there are no leftover bits from previous
plane configuration that were not cleaned until now.

It fixes issues when alternating between video and YUV planes, where
both bits would be set eventually, leading to broken plane display.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 9 +++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h | 2 ++
 drivers/gpu/drm/sun4i/sun4i_layer.c   | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index bf49c55b0f2c..67b4bb4f5365 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -395,6 +395,15 @@ int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend, int layer,
 	return 0;
 }
 
+void sun4i_backend_cleanup_layer(struct sun4i_backend *backend,
+				 int layer)
+{
+	regmap_update_bits(backend->engine.regs,
+			   SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN |
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN, 0);
+}
+
 static bool sun4i_backend_plane_uses_scaler(struct drm_plane_state *state)
 {
 	u16 src_h = state->src_h >> 16;
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index e3d4c6035eb2..339dbff1cce4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -208,5 +208,7 @@ int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
 					int layer, uint32_t in_fmt);
 int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend,
 				    int layer, struct drm_plane *plane);
+void sun4i_backend_cleanup_layer(struct sun4i_backend *backend,
+				 int layer);
 
 #endif /* _SUN4I_BACKEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 78f77af8805a..e0e37c2f1721 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -92,6 +92,8 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 	struct sun4i_backend *backend = layer->backend;
 	struct sun4i_frontend *frontend = backend->frontend;
 
+	sun4i_backend_cleanup_layer(backend, layer->id);
+
 	if (layer_state->uses_frontend) {
 		sun4i_frontend_init(frontend);
 		sun4i_frontend_update_coord(frontend, plane);
-- 
2.19.1

