Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B55C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5872146F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfAROvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:51:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47969 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbfAROvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:51:46 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 425C420CE0; Fri, 18 Jan 2019 15:51:44 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id E2A91207A3;
        Fri, 18 Jan 2019 15:51:42 +0100 (CET)
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
Subject: [PATCH RESEND v5 08/23] drm/sun4i: frontend: Add support for packed YUV422 input formats
Date:   Fri, 18 Jan 2019 15:51:18 +0100
Message-Id: <20190118145133.21281-9-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces support for packed YUV formats with 4:2:2 sampling using
the frontend. Definitions are introduced for the data format and pixel
sequence input format register values.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index bf37a4ea81c5..1946dd9e58d9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -133,6 +133,8 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 {
 	if (!format->is_yuv)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (drm_format_info_is_yuv_sampling_422(format))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
 	else
 		return -EINVAL;
 
@@ -160,10 +162,26 @@ sun4i_frontend_drm_format_to_input_sequence(const struct drm_format_info *format
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
 		return 0;
 
+	case DRM_FORMAT_UYVY:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY;
+		return 0;
+
+	case DRM_FORMAT_VYUY:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VYUY;
+		return 0;
+
 	case DRM_FORMAT_XRGB8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB;
 		return 0;
 
+	case DRM_FORMAT_YUYV:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV;
+		return 0;
+
+	case DRM_FORMAT_YVYU:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YVYU;
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -187,7 +205,11 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 
 static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
 };
 
 bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier)
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 17b46ecf7d9e..e287a71a0db9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -27,7 +27,12 @@
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422	(1 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB		(5 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY		0
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV		1
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VYUY		2
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YVYU		3
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB		1
 
-- 
2.20.1

