Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFA8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4477621536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Q04LvEmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4477621536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeI0C4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:56:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55534 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeI0C4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:56:43 -0400
Received: from trochilidae.toradex.int (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9F9A05C2109;
        Wed, 26 Sep 2018 22:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537994516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2HjWbsZsRziC4ct55Tfwt7fcALLOqQwx1ID1Q3x7pQ=;
        b=Q04LvEmJpqXM8cgRbUe84iIEgLzGeer7rikHquny0/GX3+kEs9svP3laXiUS4EPBl7REae
        c+33P1nOyDbYD36Yty9tYH4a2F9LgzHUCa2danZBF0H/uzkfLwXv5y6undVuZk4ptHCbxT
        GMESwk4MtMcaeoKfeM60cmrYF2WWAGM=
From:   Stefan Agner <stefan@agner.ch>
To:     stefan@agner.ch, alison.wang@nxp.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 2/2] drm/fsl-dcu: use drm_display_mode_to_videomode to calculate timing parameters
Date:   Wed, 26 Sep 2018 22:41:50 +0200
Message-Id: <20180926204150.29829-2-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926204150.29829-1-stefan@agner.ch>
References: <20180926204150.29829-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Satendra Singh Thakur <satendra.t@samsung.com>

Use the drm_display_mode_to_videomode function to calculate front/
back porches and sync length.

Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 32 ++++++++++------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 05d1c9977395..18afc94e4dff 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <video/videomode.h>
 
 #include "fsl_dcu_drm_crtc.h"
 #include "fsl_dcu_drm_drv.h"
@@ -85,39 +86,34 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
 	struct drm_connector *con = &fsl_dev->connector.base;
 	struct drm_display_mode *mode = &crtc->state->mode;
-	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, pol = 0;
+	unsigned int pol = 0;
+	struct videomode vm;
 
 	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
 
-	/* Configure timings: */
-	hbp = mode->htotal - mode->hsync_end;
-	hfp = mode->hsync_start - mode->hdisplay;
-	hsw = mode->hsync_end - mode->hsync_start;
-	vbp = mode->vtotal - mode->vsync_end;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vsw = mode->vsync_end - mode->vsync_start;
+	drm_display_mode_to_videomode(mode, &vm);
 
 	/* INV_PXCK as default (most display sample data on rising edge) */
 	if (!(con->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE))
 		pol |= DCU_SYN_POL_INV_PXCK;
 
-	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+	if (vm.flags & DISPLAY_FLAGS_HSYNC_LOW)
 		pol |= DCU_SYN_POL_INV_HS_LOW;
 
-	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+	if (vm.flags & DISPLAY_FLAGS_VSYNC_LOW)
 		pol |= DCU_SYN_POL_INV_VS_LOW;
 
 	regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
-		     DCU_HSYN_PARA_BP(hbp) |
-		     DCU_HSYN_PARA_PW(hsw) |
-		     DCU_HSYN_PARA_FP(hfp));
+		     DCU_HSYN_PARA_BP(vm.hback_porch) |
+		     DCU_HSYN_PARA_PW(vm.hsync_len) |
+		     DCU_HSYN_PARA_FP(vm.hfront_porch));
 	regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
-		     DCU_VSYN_PARA_BP(vbp) |
-		     DCU_VSYN_PARA_PW(vsw) |
-		     DCU_VSYN_PARA_FP(vfp));
+		     DCU_VSYN_PARA_BP(vm.vback_porch) |
+		     DCU_VSYN_PARA_PW(vm.vsync_len) |
+		     DCU_VSYN_PARA_FP(vm.vfront_porch));
 	regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
-		     DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
-		     DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
+		     DCU_DISP_SIZE_DELTA_Y(vm.vactive) |
+		     DCU_DISP_SIZE_DELTA_X(vm.hactive));
 	regmap_write(fsl_dev->regmap, DCU_SYN_POL, pol);
 	regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
 		     DCU_BGND_G(0) | DCU_BGND_B(0));
-- 
2.19.0

