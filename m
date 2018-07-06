Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A57AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D663D23FE7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D663D23FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933193AbeGFFsR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:48:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933112AbeGFFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:48:13 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F048086A;
        Fri,  6 Jul 2018 05:48:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.17 27/46] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
Date:   Fri,  6 Jul 2018 07:46:48 +0200
Message-Id: <20180706054525.891089477@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

commit 58b3d02f066e5b1480d80bd308c545526eea3250 upstream.

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
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180613081647.31183-1-paul.kocialkowski@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/sun4i/sun4i_tcon.c |   25 -------------------------
 1 file changed, 25 deletions(-)

--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -17,7 +17,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -350,9 +349,6 @@ static void sun4i_tcon0_mode_set_lvds(st
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 				     const struct drm_display_mode *mode)
 {
-	struct drm_panel *panel = tcon->panel;
-	struct drm_connector *connector = panel->connector;
-	struct drm_display_info display_info = connector->display_info;
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
@@ -410,27 +406,6 @@ static void sun4i_tcon0_mode_set_rgb(str
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


