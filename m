Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372CFC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044A1206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044A1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeLDOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:23:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33297 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbeLDOXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:14 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3FA0207AD; Tue,  4 Dec 2018 15:23:09 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3FD6520A62;
        Tue,  4 Dec 2018 15:22:40 +0100 (CET)
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
Subject: [PATCH v3 06/21] drm/sun4i: frontend: Configure and enable YUV to RGB CSC when needed
Date:   Tue,  4 Dec 2018 15:22:03 +0100
Message-Id: <20181204142218.16284-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prevision of adding support for YUV formats, set the YUV to RGB
colorspace conversion coefficients if required and don't bypass the
CSC engine when converting.

The BT601 coefficients from the A33 BSP are copied over from the backend
code. Because of module inter-dependency, we can't have the frontend use
these coefficients from the backend directly.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 45 ++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 ++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index d0eca4b8784d..1737a4394401 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -48,6 +48,28 @@ static const u32 sun4i_frontend_horz_coef[64] = {
 	0x03ff0000, 0x0000fd41, 0x01ff0000, 0x0000fe42,
 };
 
+/*
+ * These coefficients are taken from the A33 BSP from Allwinner.
+ *
+ * The first three values of each row are coded as 13-bit signed fixed-point
+ * numbers, with 10 bits for the fractional part. The fourth value is a
+ * constant coded as a 14-bit signed fixed-point number with 4 bits for the
+ * fractional part.
+ *
+ * The values in table order give the following colorspace translation:
+ * G = 1.164 * Y - 0.391 * U - 0.813 * V + 135
+ * R = 1.164 * Y + 1.596 * V - 222
+ * B = 1.164 * Y + 2.018 * U + 276
+ *
+ * This seems to be a conversion from Y[16:235] UV[16:240] to RGB[0:255],
+ * following the BT601 spec.
+ */
+static const u32 sunxi_bt601_yuv2rgb_coef[12] = {
+	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
+	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
+	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
+};
+
 static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 {
 	int i;
@@ -188,6 +210,8 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	const struct drm_format_info *format = fb->format;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
+	unsigned int i;
+	u32 bypass;
 	int ret;
 
 	ret = sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
@@ -226,9 +250,26 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG, 0x400);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG, 0x400);
 
+	/*
+	 * Checking the input format is sufficient since we currently only
+	 * support RGB output formats to the backend. If YUV output formats
+	 * ever get supported, an YUV input and output would require bypassing
+	 * the CSC engine too.
+	 */
+	if (format->is_yuv) {
+		/* Setup the CSC engine for YUV to RGB conversion. */
+		bypass = 0;
+
+		for (i = 0; i < ARRAY_SIZE(sunxi_bt601_yuv2rgb_coef); i++)
+			regmap_write(frontend->regs,
+				     SUN4I_FRONTEND_CSC_COEF_REG(i),
+				     sunxi_bt601_yuv2rgb_coef[i]);
+	} else {
+		bypass = SUN4I_FRONTEND_BYPASS_CSC_EN;
+	}
+
 	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_BYPASS_REG,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN);
+			   SUN4I_FRONTEND_BYPASS_CSC_EN, bypass);
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
 		     in_mod_val | in_fmt_val | in_ps_val);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index ad146e8d8d70..326cd5607efa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -35,6 +35,8 @@
 #define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_BGRX8888	1
 #define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888	2
 
+#define SUN4I_FRONTEND_CSC_COEF_REG(c)		(0x070 + (0x4 * (c)))
+
 #define SUN4I_FRONTEND_CH0_INSIZE_REG		0x100
 #define SUN4I_FRONTEND_INSIZE(h, w)			((((h) - 1) << 16) | (((w) - 1)))
 
-- 
2.19.2

