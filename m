Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9426FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E91D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfAROpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:45:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45877 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfAROny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:43:54 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 725AA207A3; Fri, 18 Jan 2019 15:43:52 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id C9C6C20C3F;
        Fri, 18 Jan 2019 15:43:50 +0100 (CET)
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
Subject: [PATCH v5 09/23] drm/sun4i: frontend: Add support for semi-planar YUV input formats
Date:   Fri, 18 Jan 2019 15:43:14 +0100
Message-Id: <20190118144328.20649-10-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118144328.20649-1-paul.kocialkowski@bootlin.com>
References: <20190118144328.20649-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Semi-planar YUV formats use two distinct planes, one for luminance and
one for chrominance. To add support for them, we need to configure the
second line stride and buffer address registers to setup the second YUV
plane.

New definitions are introduced to configure the input format register
for the YUV420 and YUV422 semi-planar formats.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 50 +++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 ++++
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  4 +++
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 1946dd9e58d9..f262069d348f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -119,11 +119,23 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
 		     fb->pitches[0]);
 
+	if (fb->format->num_planes > 1)
+		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
+			     fb->pitches[1]);
+
 	/* Set the physical address of the buffer in memory */
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	paddr -= PHYS_OFFSET;
-	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+	DRM_DEBUG_DRIVER("Setting buffer #0 address to %pad\n", &paddr);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR0_REG, paddr);
+
+	if (fb->format->num_planes > 1) {
+		paddr = drm_fb_cma_get_gem_addr(fb, state, 1);
+		paddr -= PHYS_OFFSET;
+		DRM_DEBUG_DRIVER("Setting buffer #1 address to %pad\n", &paddr);
+		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR1_REG,
+			     paddr);
+	}
 }
 EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
@@ -133,6 +145,8 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 {
 	if (!format->is_yuv)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (drm_format_info_is_yuv_sampling_420(format))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
 	else if (drm_format_info_is_yuv_sampling_422(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
 	else
@@ -145,12 +159,18 @@ static int
 sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
 					u32 *val)
 {
-	if (format->num_planes == 1)
+	switch (format->num_planes) {
+	case 1:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
-	else
-		return -EINVAL;
+		return 0;
 
-	return 0;
+	case 2:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
 }
 
 static int
@@ -162,6 +182,22 @@ sun4i_frontend_drm_format_to_input_sequence(const struct drm_format_info *format
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
 		return 0;
 
+	case DRM_FORMAT_NV12:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV;
+		return 0;
+
+	case DRM_FORMAT_NV16:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV;
+		return 0;
+
+	case DRM_FORMAT_NV21:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU;
+		return 0;
+
+	case DRM_FORMAT_NV61:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU;
+		return 0;
+
 	case DRM_FORMAT_UYVY:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY;
 		return 0;
@@ -205,6 +241,10 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 
 static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV61,
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index e287a71a0db9..2f9e3f84e2ff 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -22,17 +22,23 @@
 #define SUN4I_FRONTEND_BYPASS_CSC_EN			BIT(1)
 
 #define SUN4I_FRONTEND_BUF_ADDR0_REG		0x020
+#define SUN4I_FRONTEND_BUF_ADDR1_REG		0x024
 
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
+#define SUN4I_FRONTEND_LINESTRD1_REG		0x044
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR	(2 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422	(1 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420	(2 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB		(5 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV		1
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VYUY		2
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YVYU		3
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV		0
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU		1
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB		1
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 29631e0efde3..185ef38649aa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -138,6 +138,10 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_RGBA4444,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV61,
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
-- 
2.20.1

