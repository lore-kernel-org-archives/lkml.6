Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067A420820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067A420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409111AbeKWUOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:14:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49179 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393892AbeKWUKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B70BF20F8D; Fri, 23 Nov 2018 10:26:38 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 602EE20D29;
        Fri, 23 Nov 2018 10:26:28 +0100 (CET)
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
Subject: [PATCH v2 04/43] drm/sun4i: backend: Add a helper and a list for supported formats
Date:   Fri, 23 Nov 2018 10:24:36 +0100
Message-Id: <20181123092515.2511-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to check whether the backend supports a specific format, an
explicit list and a related helper are introduced.

The prototype of this helper is added to the header so that it can be
called from sun4i_layer later (when introducing tiled mode support).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index c3444246755b..7dd24eb03f89 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -155,6 +155,33 @@ static int sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
 	return 0;
 }
 
+static const uint32_t sun4i_backend_formats[] = {
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+};
+
+bool sun4i_backend_format_is_supported(uint32_t fmt)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun4i_backend_formats); i++)
+		if (sun4i_backend_formats[i] == fmt)
+			return true;
+
+	return false;
+}
+
 int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 				     int layer, struct drm_plane *plane)
 {
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 339dbff1cce4..93db3af675b3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -198,6 +198,7 @@ engine_to_sun4i_backend(struct sunxi_engine *engine)
 
 void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 				int layer, bool enable);
+bool sun4i_backend_format_is_supported(uint32_t fmt);
 int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 				     int layer, struct drm_plane *plane);
 int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
-- 
2.19.1

