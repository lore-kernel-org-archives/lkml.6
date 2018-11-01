Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C053C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ECB20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ECB20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeKBFFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:05:34 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:45914 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbeKBFFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:05:33 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id BD4A2BFA47;
        Thu,  1 Nov 2018 21:01:07 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 42D3CC1064; Thu,  1 Nov 2018 21:01:07 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id EEF67C1044;
        Thu,  1 Nov 2018 21:00:33 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 1/7] drm/sun4i: tcon: Pass encoder instead of using panel for RGB setup
Date:   Thu,  1 Nov 2018 21:00:39 +0100
Message-Id: <20181101200045.6078-2-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Features such as dithering and pixel data edge configuration currently
rely on the panel registered with the TCON driver. However, bridges are
also supported in addition panels.

Instead of retrieving the connector from the panel, pass the encoder
from the calling function, as is done for other interfaces.

The connector is then retrieved from the encoder with the dedicated
helper. Even in the case of bridges, the connector is registered with
the encoder from our driver and is accessible when iterating connectors.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index f949287d926c..262ffb6b0f82 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -478,8 +478,11 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 }
 
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
+				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
+	struct drm_connector *connector = sun4i_tcon_get_connector(encoder);
+	struct drm_display_info display_info = connector->display_info;
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
@@ -491,8 +494,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Set dithering if needed */
-	if (tcon->panel)
-		sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
+	sun4i_tcon0_mode_set_dithering(tcon, connector);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
@@ -556,17 +558,11 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	 * Following code is a way to avoid quirks all around TCON
 	 * and DOTCLOCK drivers.
 	 */
-	if (tcon->panel) {
-		struct drm_panel *panel = tcon->panel;
-		struct drm_connector *connector = panel->connector;
-		struct drm_display_info display_info = connector->display_info;
-
-		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
-			clk_set_phase(tcon->dclk, 240);
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
+		clk_set_phase(tcon->dclk, 240);
 
-		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
-			clk_set_phase(tcon->dclk, 0);
-	}
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+		clk_set_phase(tcon->dclk, 0);
 
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
@@ -684,7 +680,7 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 		sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
 		break;
 	case DRM_MODE_ENCODER_NONE:
-		sun4i_tcon0_mode_set_rgb(tcon, mode);
+		sun4i_tcon0_mode_set_rgb(tcon, encoder, mode);
 		sun4i_tcon_set_mux(tcon, 0, encoder);
 		break;
 	case DRM_MODE_ENCODER_TVDAC:
-- 
2.19.1

