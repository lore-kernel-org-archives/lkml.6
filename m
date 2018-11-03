Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D51C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7289A20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PDS9oZXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7289A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeKCTUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:20:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42606 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbeKCTUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:20:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id t6-v6so2130623plo.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoHXhQs3sGHJc3VqucM8YHfwrLVjYZhUwHaLNgzq7Hk=;
        b=PDS9oZXI08XHodXR7M+0+fMtcP+VlY9g+hL69LXq+DNFteFFc+lUCpCpwI7wLoHCbG
         i1r9Nbg5hKlV3gpKaTq29eKsfIcOM2gv2hoYNro/woLd7+XOwl1AuDQrqvfhPQ1oDEHW
         JAzTxzknORGbhh4L0SgffAHR07HzUdEktD9rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoHXhQs3sGHJc3VqucM8YHfwrLVjYZhUwHaLNgzq7Hk=;
        b=G21U8uUfjWRt6XJVya4eCLdgZi43VD7wC5abnZ6cKgmRnnGy7RivwlsCjmuQ18Sxef
         vtfzUwrXQ5SofsPs1C/8B7eg3YuxTQdcJPtUkdE+mDdtfXJLWxPonMNv+a8lEBJ4Rfmi
         DX3KIp56wqgTUjjzZfUMcsPqwdkhot5yoSGC9posuG5y5szSfB1RAS5ZR+hMfG+eDVkR
         3o6kUFcplKOuMHFOnvkNjyTnfP1Ksvd3QqqdWu1+zWeFZcP8bC0yNDXzsdvxzEtCAqAw
         Uj+QbE8dvoMIuc3NOmyLO6rMGPLQTkCdUfKmc0njawcLPP6qgZ+SI4j4sL8gE7YeZjni
         a/sg==
X-Gm-Message-State: AGRZ1gI7D7BtMhzVUY5BiaERroqTP6wAoAnNFiDQV2Pt9rnnQqn1TCg1
        hRD+ztZMO2+gdc/2eMafiqkUsA==
X-Google-Smtp-Source: AJdET5cZWnpRoke0soGNzGMb4cUkutwXdz4Xu2YGKFvhfMeGnaV3L3bKJ4djXsCJup2lz7coshRSDA==
X-Received: by 2002:a17:902:bf0c:: with SMTP id bi12-v6mr15243833plb.330.1541239791555;
        Sat, 03 Nov 2018 03:09:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:09:50 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 04/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
Date:   Sat,  3 Nov 2018 15:38:54 +0530
Message-Id: <20181103100900.30313-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting up burst mode display would require to compute
- Horizontal timing edge values to fill burst drq register
- Line, sync values to fill burst line register

Since there is no direct documentation for these computations
the edge and line formulas are taken from BSP code
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
line_num = panel->lcd_ht*dsi_pixel_bits[panel->lcd_dsi_format]/
	  (8*panel->lcd_dsi_lane);
edge1 = sync_point+(panel->lcd_x+panel->lcd_hbp+20)*
	dsi_pixel_bits[panel->lcd_dsi_format] /(8*panel->lcd_dsi_lane);
edge1 = (edge1>line_num)?line_num:edge1;
edge0 = edge1+(panel->lcd_x+40)*tcon_div/8;
edge0 = (edge0>line_num)?(edge0-line_num):1;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 48 +++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 4965b2c71e4c..b6c01891df36 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -375,20 +375,52 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
 	struct mipi_dsi_device *device = dsi->device;
+	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+	u32 line_num, edge0, edge1, hact_sync_bp;
+	u32 sync_point, tcon_div;
 	u32 val = 0;
 
-	if ((mode->hsync_start - mode->hdisplay) > 20) {
-		/* Maaaaaagic */
-		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
+	if (device->mode_flags != MIPI_DSI_MODE_VIDEO_BURST) {
+		if ((mode->hsync_start - mode->hdisplay) > 20) {
+			/* Maaaaaagic */
+			u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
-		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
-		drq /= 32;
+			drq *= Bpp;
+			drq /= 32;
 
-		val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
-		       SUN6I_DSI_TCON_DRQ_SET(drq));
+			val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
+			       SUN6I_DSI_TCON_DRQ_SET(drq));
+		}
+
+		regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
+
+		return;
 	}
 
-	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
+	sync_point = 40;
+	tcon_div = 8;	/* FIXME need to retrive the divider from TCON */
+
+	line_num = mode->htotal * Bpp / (8 * device->lanes);
+	/* Horizental timings duration excluding front porch */
+	hact_sync_bp = (mode->hdisplay + mode->htotal - mode->hsync_start);
+	edge1 = sync_point + ((hact_sync_bp + 20) * Bpp / (8 * device->lanes));
+	if (edge1 > line_num)
+		edge1 = line_num;
+
+	edge0 = edge1 + (mode->hdisplay + 40) * tcon_div / 8;
+	if (edge0 > line_num)
+		edge0 -= line_num;
+	else
+		edge0 = 1;
+
+	regmap_write(dsi->regs, SUN6I_DSI_BURST_DRQ_REG,
+		     SUN6I_DSI_BURST_DRQ_EDGE1(edge1) |
+		     SUN6I_DSI_BURST_DRQ_EDGE0(edge0));
+	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
+		     SUN6I_DSI_TCON_DRQ_ENABLE_MODE);
+	regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
+		     SUN6I_DSI_BURST_LINE_NUM(line_num) |
+		     SUN6I_DSI_BURST_LINE_SYNC_POINT(sync_point));
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3

