Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5882ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7178120850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="ZjayEgwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7178120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeGRPCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:02:12 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:44280 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbeGRPCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:02:11 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 46E97B00779
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:24:01 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-type:content-type
        :mime-version:references:in-reply-to:x-mailer:message-id:date
        :date:subject:subject:to:from:from; s=dkim; t=1531923840; x=
        1532787841; bh=WZ5goYWe8Oq6EHOATy0yRG0c44cv/dzKhK9vdPswsOg=; b=Z
        jayEgwc2+ZGbyEGrfgZwkfsCRwqwxFmsa9gzJjGdJoHffr/eiDelKnbT26WWgXCu
        2QcClpUT04dAKYqDBH+DldpbbKe3V4FWYoacs4mqQA08Vg+J2DJJvwxSMh1/Tky/
        zU2uhOiqA2byh7BQAH9rh3Yt3GWGVA6s2plB46Wc5Q=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pcm9USi5H7Ti for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 16:24:00 +0200 (CEST)
Received: from localhost.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 7DF55B00049;
        Wed, 18 Jul 2018 16:23:59 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE checking if panel is used.
Date:   Wed, 18 Jul 2018 16:23:57 +0200
Message-Id: <20180718142357.120998-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle both positive and negative dclk polarity,
according to bus_flags, taking care of this:

On A20 and similar SoCs, the only way to achieve Positive Edge
(Rising Edge), is setting dclk clock phase to 2/3(240°).
By default TCON works in Negative Edge(Falling Edge), this is why phase
is set to 0 in that case.
Unfortunately there's no way to logically invert dclk through IO_POL
register.
The only acceptable way to work, triple checked with scope,
is using clock phase set to 0° for Negative Edge and set to 240° for
Positive Edge.
On A33 and similar SoCs there would be a 90° phase option, but it divides
also dclk by 2.
This patch is a way to avoid quirks all around TCON and DOTCLOCK drivers
for using A33 90° phase divided by 2 and consequently increase code
complexity.

Check if panel is used. TCON can also handle VGA DAC, then panel could
be empty.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 8232b39e16ca..5c7d6ae53111 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -17,6 +17,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -474,6 +475,33 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	/*
+	 * On A20 and similar SoCs, the only way to achieve Positive Edge
+	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
+	 * By default TCON works in Negative Edge(Falling Edge),
+	 * this is why phase is set to 0 in that case.
+	 * Unfortunately there's no way to logically invert dclk through
+	 * IO_POL register.
+	 * The only acceptable way to work, triple checked with scope,
+	 * is using clock phase set to 0° for Negative Edge and set to 240°
+	 * for Positive Edge.
+	 * On A33 and similar SoCs there would be a 90° phase option,
+	 * but it divides also dclk by 2.
+	 * Following code is a way to avoid quirks all around TCON
+	 * and DOTCLOCK drivers.
+	 */
+	if (!IS_ERR(tcon->panel)) {
+		struct drm_panel *panel = tcon->panel;
+		struct drm_connector *connector = panel->connector;
+		struct drm_display_info display_info = connector->display_info;
+
+		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
+			clk_set_phase(tcon->dclk, 240);
+
+		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+			clk_set_phase(tcon->dclk, 0);
+	}
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
 			   val);
-- 
2.17.1

