Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682C720857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682C720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeIENq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:46:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39658 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbeIENqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:46:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 485A120789; Wed,  5 Sep 2018 11:16:56 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1759D20795;
        Wed,  5 Sep 2018 11:16:46 +0200 (CEST)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 07/10] drm/bridge: cdns: Remove mode_check test
Date:   Wed,  5 Sep 2018 11:16:38 +0200
Message-Id: <62fe67f20c91471d370913910fcd66f6054aec21.1536138624.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crtc_* variants of the timings are initialised at the same value than
their !crtc counterparts, and can later on be tweaked. This means that we
can always use the crtc variants, instead of trying to figure out which of
these two we should use.

Move to always use the crtc_* variants, and remove the extra parameter to
the mode2cfg function that allows to tell which variant we should use.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 51 ++++++++------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index ce9496d13986..6474e6d999b7 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -731,8 +731,7 @@ static unsigned int dpi_to_dsi_timing(unsigned int dpi_timing,
 static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 			     const struct drm_display_mode *mode,
 			     struct cdns_dsi_cfg *dsi_cfg,
-			     struct cdns_dphy_cfg *dphy_cfg,
-			     bool mode_valid_check)
+			     struct cdns_dphy_cfg *dphy_cfg)
 {
 	unsigned long dsi_htotal = 0, dsi_hss_hsa_hse_hbp = 0;
 	struct cdns_dsi_output *output = &dsi->output;
@@ -748,23 +747,15 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 	bpp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
 	nlanes = output->dev->lanes;
 
-	if (mode_valid_check)
-		tmp = mode->htotal -
-		      (sync_pulse ? mode->hsync_end : mode->hsync_start);
-	else
-		tmp = mode->crtc_htotal -
-		      (sync_pulse ?
-		       mode->crtc_hsync_end : mode->crtc_hsync_start);
+	tmp = mode->crtc_htotal -
+		(sync_pulse ? mode->crtc_hsync_end : mode->crtc_hsync_start);
 
 	dsi_cfg->hbp = dpi_to_dsi_timing(tmp, bpp, DSI_HBP_FRAME_OVERHEAD);
 	dsi_htotal += dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
 	dsi_hss_hsa_hse_hbp += dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
 
 	if (sync_pulse) {
-		if (mode_valid_check)
-			tmp = mode->hsync_end - mode->hsync_start;
-		else
-			tmp = mode->crtc_hsync_end - mode->crtc_hsync_start;
+		tmp = mode->crtc_hsync_end - mode->crtc_hsync_start;
 
 		dsi_cfg->hsa = dpi_to_dsi_timing(tmp, bpp,
 						 DSI_HSA_FRAME_OVERHEAD);
@@ -772,32 +763,19 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 		dsi_hss_hsa_hse_hbp += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
 	}
 
-	dsi_cfg->hact = dpi_to_dsi_timing(mode_valid_check ?
-					  mode->hdisplay : mode->crtc_hdisplay,
+	dsi_cfg->hact = dpi_to_dsi_timing(mode->crtc_hdisplay,
 					  bpp, 0);
 	dsi_htotal += dsi_cfg->hact;
 
-	if (mode_valid_check)
-		dpi_hfp = mode->hsync_start - mode->hdisplay;
-	else
-		dpi_hfp = mode->crtc_hsync_start - mode->crtc_hdisplay;
-
+	dpi_hfp = mode->crtc_hsync_start - mode->crtc_hdisplay;
 	dsi_cfg->hfp = dpi_to_dsi_timing(dpi_hfp, bpp, DSI_HFP_FRAME_OVERHEAD);
 	dsi_htotal += dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
 
-	if (mode_valid_check)
-		ret = cdns_dsi_get_dphy_pll_cfg(dsi->dphy, dphy_cfg,
-						mode->htotal, bpp,
-						mode->clock * 1000,
-						dsi_htotal, nlanes,
-						&dsi_hfp_ext);
-	else
-		ret = cdns_dsi_get_dphy_pll_cfg(dsi->dphy, dphy_cfg,
-						mode->crtc_htotal, bpp,
-						mode->crtc_clock * 1000,
-						dsi_htotal, nlanes,
-						&dsi_hfp_ext);
-
+	ret = cdns_dsi_get_dphy_pll_cfg(dsi->dphy, dphy_cfg,
+					mode->crtc_htotal, bpp,
+					mode->crtc_clock * 1000,
+					dsi_htotal, nlanes,
+					&dsi_hfp_ext);
 	if (ret)
 		return ret;
 
@@ -811,8 +789,7 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 	 * interface.
 	 */
 	if ((u64)dphy_cfg->lane_bps * dpi_hfp * nlanes <
-	    (u64)dsi_hss_hsa_hse_hbp *
-	    (mode_valid_check ? mode->clock : mode->crtc_clock) * 1000)
+	    (u64)dsi_hss_hsa_hse_hbp * mode->crtc_clock * 1000)
 		return -EINVAL;
 
 	return 0;
@@ -862,7 +839,7 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 
 	nlanes = output->dev->lanes;
 
-	ret = cdns_dsi_mode2cfg(dsi, mode, &dsi_cfg, &dphy_cfg, true);
+	ret = cdns_dsi_mode2cfg(dsi, mode, &dsi_cfg, &dphy_cfg);
 	if (ret)
 		return MODE_CLOCK_RANGE;
 
@@ -990,7 +967,7 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	bpp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
 	nlanes = output->dev->lanes;
 
-	WARN_ON_ONCE(cdns_dsi_mode2cfg(dsi, mode, &dsi_cfg, &dphy_cfg, false));
+	WARN_ON_ONCE(cdns_dsi_mode2cfg(dsi, mode, &dsi_cfg, &dphy_cfg));
 
 	cdns_dsi_hs_init(dsi, &dphy_cfg);
 	cdns_dsi_init_link(dsi);
-- 
git-series 0.9.1
