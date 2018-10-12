Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947F0C71122
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9402087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a+Eq51TC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9402087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJMDvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:51:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35470 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJMDvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:51:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9CKH9LK028879;
        Fri, 12 Oct 2018 15:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539375429;
        bh=bqKTNj6UCXTvYaT/JmFtNfELonVklcIHr1Dw/PTwpAs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a+Eq51TCSIo0OJwj/XTXytpldnFwTKwKBg1ltChKlxXl/sXq1nVhOSToYzfD/2QnY
         vrqFIidRjxf3SvMRgbi+jcDGNvVsEUPls6NNGAvK1g4+ZrVTxjxpeRLvuGEoswD6rL
         x0sXlRHwr4mRzuRYeCqYvhKfYs0SU2ZaOexNpwwo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH9aR011715;
        Fri, 12 Oct 2018 15:17:09 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 12
 Oct 2018 15:17:09 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 12 Oct 2018 15:17:09 -0500
Received: from uda0869644a.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH7EV000402;
        Fri, 12 Oct 2018 15:17:09 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 1/8] drm/omap: Add ability to check if requested plane modes can be supported
Date:   Fri, 12 Oct 2018 15:16:56 -0500
Message-ID: <20181012201703.29065-2-bparrot@ti.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20181012201703.29065-1-bparrot@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently assume that an overlay has the same maximum width and
maximum height as the overlay manager. This assumption is incorrect. On
some variants the overlay manager maximum width is twice the maximum
width that the overlay can handle. We need to add the appropriate data
per variant as well as export a helper function to retrieve the data so
check can be made dynamically in omap_plane_atomic_check().

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c   | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/dss/omapdss.h |  2 ++
 drivers/gpu/drm/omapdrm/omap_plane.c  | 14 ++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index fe0b5f6ede72..70c3e3353947 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -103,6 +103,8 @@ struct dispc_features {
 	u8 mgr_height_start;
 	u16 mgr_width_max;
 	u16 mgr_height_max;
+	u16 ovl_width_max;
+	u16 ovl_height_max;
 	unsigned long max_lcd_pclk;
 	unsigned long max_tv_pclk;
 	unsigned int max_downscale;
@@ -2596,6 +2598,13 @@ static int dispc_ovl_calc_scaling(struct dispc_device *dispc,
 	return 0;
 }
 
+static void dispc_ovl_get_max_size(struct dispc_device *dispc,
+				   u16 *width, u16 *height)
+{
+	*width = dispc->feat->ovl_width_max;
+	*height = dispc->feat->ovl_height_max;
+}
+
 static int dispc_ovl_setup_common(struct dispc_device *dispc,
 				  enum omap_plane_id plane,
 				  enum omap_overlay_caps caps,
@@ -4247,6 +4256,8 @@ static const struct dispc_features omap24xx_dispc_feats = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.ovl_width_max		=	2048,
+	.ovl_height_max		=	2048,
 	.max_lcd_pclk		=	66500000,
 	.max_downscale		=	2,
 	/*
@@ -4284,6 +4295,8 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.ovl_width_max		=	2048,
+	.ovl_height_max		=	2048,
 	.max_lcd_pclk		=	173000000,
 	.max_tv_pclk		=	59000000,
 	.max_downscale		=	4,
@@ -4318,6 +4331,8 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.ovl_width_max		=	2048,
+	.ovl_height_max		=	2048,
 	.max_lcd_pclk		=	173000000,
 	.max_tv_pclk		=	59000000,
 	.max_downscale		=	4,
@@ -4352,6 +4367,8 @@ static const struct dispc_features omap36xx_dispc_feats = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.ovl_width_max		=	2048,
+	.ovl_height_max		=	2048,
 	.max_lcd_pclk		=	173000000,
 	.max_tv_pclk		=	59000000,
 	.max_downscale		=	4,
@@ -4386,6 +4403,8 @@ static const struct dispc_features am43xx_dispc_feats = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.ovl_width_max		=	2048,
+	.ovl_height_max		=	2048,
 	.max_lcd_pclk		=	173000000,
 	.max_tv_pclk		=	59000000,
 	.max_downscale		=	4,
@@ -4420,6 +4439,8 @@ static const struct dispc_features omap44xx_dispc_feats = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.ovl_width_max		=	2048,
+	.ovl_height_max		=	2048,
 	.max_lcd_pclk		=	170000000,
 	.max_tv_pclk		=	185625000,
 	.max_downscale		=	4,
@@ -4459,6 +4480,8 @@ static const struct dispc_features omap54xx_dispc_feats = {
 	.mgr_height_start	=	27,
 	.mgr_width_max		=	4096,
 	.mgr_height_max		=	4096,
+	.ovl_width_max		=	2048,
+	.ovl_height_max		=	4096,
 	.max_lcd_pclk		=	170000000,
 	.max_tv_pclk		=	192000000,
 	.max_downscale		=	4,
@@ -4734,6 +4757,7 @@ static const struct dispc_ops dispc_ops = {
 	.ovl_enable = dispc_ovl_enable,
 	.ovl_setup = dispc_ovl_setup,
 	.ovl_get_color_modes = dispc_ovl_get_color_modes,
+	.ovl_get_max_size = dispc_ovl_get_max_size,
 
 	.wb_get_framedone_irq = dispc_wb_get_framedone_irq,
 	.wb_setup = dispc_wb_setup,
diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 1f698a95a94a..45334d5c618e 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -632,6 +632,8 @@ struct dispc_ops {
 
 	const u32 *(*ovl_get_color_modes)(struct dispc_device *dispc,
 					  enum omap_plane_id plane);
+	void (*ovl_get_max_size)(struct dispc_device *dispc,
+				 u16 *width, u16 *height);
 
 	u32 (*wb_get_framedone_irq)(struct dispc_device *dispc);
 	int (*wb_setup)(struct dispc_device *dispc,
diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index 161233cbc9a0..e1e338e76841 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -106,11 +106,18 @@ static void omap_plane_atomic_disable(struct drm_plane *plane,
 static int omap_plane_atomic_check(struct drm_plane *plane,
 				   struct drm_plane_state *state)
 {
+	struct omap_drm_private *priv = plane->dev->dev_private;
 	struct drm_crtc_state *crtc_state;
+	u16 width, height;
+	u32 width_fp, height_fp;
 
 	if (!state->fb)
 		return 0;
 
+	priv->dispc_ops->ovl_get_max_size(priv->dispc, &width, &height);
+	width_fp = width << 16;
+	height_fp = height << 16;
+
 	/* crtc should only be NULL when disabling (i.e., !state->fb) */
 	if (WARN_ON(!state->crtc))
 		return 0;
@@ -132,6 +139,13 @@ static int omap_plane_atomic_check(struct drm_plane *plane,
 	if (state->crtc_y + state->crtc_h > crtc_state->adjusted_mode.vdisplay)
 		return -EINVAL;
 
+	/* Make sure dimensions are within bounds. */
+	if (state->src_h > height_fp || state->crtc_h > height)
+		return -EINVAL;
+
+	if (state->src_w > width_fp || state->crtc_w > width)
+		return -EINVAL;
+
 	if (state->rotation != DRM_MODE_ROTATE_0 &&
 	    !omap_framebuffer_supports_rotation(state->fb))
 		return -EINVAL;
-- 
2.9.0

