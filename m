Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2F7EFC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5452208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5452208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934911AbeFMIRf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:17:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43672 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933618AbeFMIRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:17:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6C2B820A33; Wed, 13 Jun 2018 10:17:29 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1F5E520A2A;
        Wed, 13 Jun 2018 10:17:19 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
Date:   Wed, 13 Jun 2018 10:16:47 +0200
Message-Id: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2c17a4368aad2b88b68e4390c819e226cf320f70.

The offending commit triggers a run-time fault when accessing the panel
element of the sun4i_tcon structure when no such panel is attached.

It was apparently assumed in said commit that a panel is always used with
the TCON. Although it is often the case, this is not always true.
For instance a bridge might be used instead of a panel.

This issue was discovered using an A13-OLinuXino, that uses the TCON
in RGB mode for a simple DAC-based VGA bridge.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c3d92d537240..8045871335b5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -17,7 +17,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -350,9 +349,6 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 				     const struct drm_display_mode *mode)
 {
-	struct drm_panel *panel = tcon->panel;
-	struct drm_connector *connector = panel->connector;
-	struct drm_display_info display_info = connector->display_info;
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
@@ -410,27 +406,6 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
-	/*
-	 * On A20 and similar SoCs, the only way to achieve Positive Edge
-	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
-	 * By default TCON works in Negative Edge(Falling Edge),
-	 * this is why phase is set to 0 in that case.
-	 * Unfortunately there's no way to logically invert dclk through
-	 * IO_POL register.
-	 * The only acceptable way to work, triple checked with scope,
-	 * is using clock phase set to 0° for Negative Edge and set to 240°
-	 * for Positive Edge.
-	 * On A33 and similar SoCs there would be a 90° phase option,
-	 * but it divides also dclk by 2.
-	 * Following code is a way to avoid quirks all around TCON
-	 * and DOTCLOCK drivers.
-	 */
-	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
-		clk_set_phase(tcon->dclk, 240);
-
-	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
-		clk_set_phase(tcon->dclk, 0);
-
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
 			   val);
-- 
2.17.0

