Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D91C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5940720820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5940720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394305AbeKWUMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:12:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49428 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393979AbeKWUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B232E20EB0; Fri, 23 Nov 2018 10:26:58 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id CA23B20E3C;
        Fri, 23 Nov 2018 10:26:34 +0100 (CET)
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
Subject: [PATCH v2 28/43] drm/sun4i: frontend: Add support for planar YUV input formats
Date:   Fri, 23 Nov 2018 10:25:00 +0100
Message-Id: <20181123092515.2511-29-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Planar YUV formats come with 3 distinct planes, which requires
configuring the frontend line stride and address registers for the
third plane.

Our hardware only supports the YUV planes order and in order to support
formats with a YVU plane order, a helper is introduced to indicate
whether to invert the address of the two chroma planes.

Missing definitions for YUV411 and YUV444 input format configuration are
also introduced as support is added for these formats. For the input
sequence part, no configuration is required for planar YUV formats so
zero is returned in that case.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 54 +++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  5 +++
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  8 ++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index e31438e5cabd..001139417cf5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -106,12 +106,27 @@ void sun4i_frontend_exit(struct sun4i_frontend *frontend)
 }
 EXPORT_SYMBOL(sun4i_frontend_exit);
 
+static bool sun4i_frontend_format_chroma_requires_swap(uint32_t fmt)
+{
+	switch (fmt) {
+	case DRM_FORMAT_YVU411:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YVU444:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
 	dma_addr_t paddr;
+	bool swap;
 
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Frontend stride: %d bytes\n", fb->pitches[0]);
@@ -122,6 +137,13 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
 			     fb->pitches[1]);
 
+	if (fb->format->num_planes > 2)
+		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
+			     fb->pitches[2]);
+
+	/* Some planar formats require chroma channel swapping by hand. */
+	swap = sun4i_frontend_format_chroma_requires_swap(fb->format->format);
+
 	/* Set the physical address of the buffer in memory */
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	paddr -= PHYS_OFFSET;
@@ -129,12 +151,20 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR0_REG, paddr);
 
 	if (fb->format->num_planes > 1) {
-		paddr = drm_fb_cma_get_gem_addr(fb, state, 1);
+		paddr = drm_fb_cma_get_gem_addr(fb, state, swap ? 2 : 1);
 		paddr -= PHYS_OFFSET;
 		DRM_DEBUG_DRIVER("Setting buffer #1 address to %pad\n", &paddr);
 		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR1_REG,
 			     paddr);
 	}
+
+	if (fb->format->num_planes > 2) {
+		paddr = drm_fb_cma_get_gem_addr(fb, state, swap ? 1 : 2);
+		paddr -= PHYS_OFFSET;
+		DRM_DEBUG_DRIVER("Setting buffer #2 address to %pad\n", &paddr);
+		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR2_REG,
+			     paddr);
+	}
 }
 EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
@@ -142,10 +172,14 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
 	if (!drm_format_is_yuv(fmt))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (drm_format_is_yuv_sampling_411(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV411;
 	else if (drm_format_is_yuv_sampling_420(fmt))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
 	else if (drm_format_is_yuv_sampling_422(fmt))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
+	else if (drm_format_is_yuv_sampling_444(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444;
 	else
 		return -EINVAL;
 
@@ -165,6 +199,10 @@ static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
 		return 0;
 
+	case 3:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -172,6 +210,12 @@ static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
 
 static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
 {
+	/* Planar formats have an explicit input sequence. */
+	if (drm_format_is_yuv_planar(fmt)) {
+		*val = 0;
+		return 0;
+	}
+
 	switch (fmt) {
 	case DRM_FORMAT_BGRX8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
@@ -243,7 +287,15 @@ static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUV411,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YUV444,
 	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVU411,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_YVU444,
 	DRM_FORMAT_YVYU,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 7d01b4f09b75..54ec71a3e2f4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -23,15 +23,20 @@
 
 #define SUN4I_FRONTEND_BUF_ADDR0_REG		0x020
 #define SUN4I_FRONTEND_BUF_ADDR1_REG		0x024
+#define SUN4I_FRONTEND_BUF_ADDR2_REG		0x028
 
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
 #define SUN4I_FRONTEND_LINESTRD1_REG		0x044
+#define SUN4I_FRONTEND_LINESTRD2_REG		0x048
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR	(0 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR	(2 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444	(0 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422	(1 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420	(2 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV411	(3 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB		(5 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV		1
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 80c718f06ce8..2fb27819ad20 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -143,7 +143,15 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUV411,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YUV444,
 	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVU411,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_YVU444,
 	DRM_FORMAT_YVYU,
 };
 
-- 
2.19.1

