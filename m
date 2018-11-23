Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E02FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4593820820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4593820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502775AbeKWUK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49421 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390496AbeKWUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A6B2920E0E; Fri, 23 Nov 2018 10:26:58 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8484120E13;
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
Subject: [PATCH v2 27/43] drm/sun4i: frontend: Add support for semi-planar YUV input formats
Date:   Fri, 23 Nov 2018 10:24:59 +0100
Message-Id: <20181123092515.2511-28-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
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
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 52 +++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 +++
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  4 ++
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index f443e8e1d8ec..e31438e5cabd 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -118,11 +118,23 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
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
 
@@ -130,6 +142,8 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
 	if (!drm_format_is_yuv(fmt))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (drm_format_is_yuv_sampling_420(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
 	else if (drm_format_is_yuv_sampling_422(fmt))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
 	else
@@ -140,12 +154,20 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 
 static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
 {
-	if (drm_format_num_planes(fmt) == 1)
+	int num_planes = drm_format_num_planes(fmt);
+
+	switch (num_planes) {
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
 
 static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
@@ -155,6 +177,22 @@ static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
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
@@ -198,6 +236,10 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 
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
index 399755939a28..7d01b4f09b75 100644
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
index 6155eca6b1bd..80c718f06ce8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -136,6 +136,10 @@ static const uint32_t sun4i_layer_formats[] = {
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
2.19.1

