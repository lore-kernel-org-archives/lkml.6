Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C234C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3693E22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oqoD/W7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3693E22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbeKMVQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:16:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38732 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbeKMVQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:16:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so5539002pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KiNNAL5FNd2IGkoW7kve11vnz/CEWnCQcGVfDy5CmDU=;
        b=oqoD/W7vMonGUOH7jryCGWFxxLuL2hJXGRp68F8je6O2iyl8WOX187F0TSWv86bOvy
         HMvMWNDDjMuEgEEQS1iI5wIuQjlITCzQH1SMVGHzL3IHM+3ABfjqh5P4/6bxOx3H+eRu
         nZJn+pyvQSLQntbqnY51w32jkD9zGvo06EVIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiNNAL5FNd2IGkoW7kve11vnz/CEWnCQcGVfDy5CmDU=;
        b=gFfxqJWeP/lWKCjFYzAP7VXcs1d5RCGr9H09B3LvyrDaWRQ3/LLe0DiBwvYBiNWtDa
         4dDHvfyj3A529SpoLgFRGufodayQ5/idWcdX0QErjjzm3WkfBpwZY71qSON/XX/qZL4s
         TTVEzur30nvKc36wl317OLhoDkPDb8deVjmttHGj97DvX7hMx5sNktWzQ39rnx3pMMdR
         dRBEAFLVsPTUlGvG1VoD++NRPYNf48hO1knnhwituWJJ6lL4K1/kleUJdCuDQBFTwng8
         ESO6gWErXkSPAMl2dFgim5R3QJNiEsK7r1t5/2ivzn5YsZG6Ckrr7uzghtCegHNvseHH
         wCQA==
X-Gm-Message-State: AGRZ1gKS8/a6WqUxcZ7U3yamkjUz8YJ5ljtt+L6LiMZdNgcwZu9Cj2BM
        /o+qaCrNZ6wLcWb0x5rLaogkqA==
X-Google-Smtp-Source: AJdET5fxwmbnpRiHRLvlzdbDPt8wJDBKu18uNDB5dVMb8m8vNdS/K2Bz+hxnyOIAB/e0lbZCxnAjaQ==
X-Received: by 2002:a62:8647:: with SMTP id x68-v6mr4951565pfd.252.1542107904617;
        Tue, 13 Nov 2018 03:18:24 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:18:24 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 15/26] drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
Date:   Tue, 13 Nov 2018 16:46:22 +0530
Message-Id: <20181113111633.20189-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike hblk, the vblk timings should follow an equation to compute
the desired value for lane 4 devices and rest of devices it would be 0.

BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
(from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
dsi_vblk = (lane-tmp%lane);

So, update the vblk timing calculation accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 32 ++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 63b924b89bd7..703722f7c81b 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -355,6 +355,30 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode, u16 hblk)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	u16 vblk = 0;
+
+	/*
+	 * The vertical blank is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define VBLK_PACKET_OVERHEAD	6
+	if (device->lanes == 4) {
+		unsigned int Bpp;
+		int tmp;
+
+		Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+		tmp = (mode->htotal * Bpp) * mode->vtotal -
+		      (hblk + VBLK_PACKET_OVERHEAD);
+		vblk = (device->lanes - tmp % device->lanes);
+	}
+
+	return vblk;
+}
+
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
@@ -503,13 +527,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
 		   Bpp - HBLK_PACKET_OVERHEAD);
 
-	/*
-	 * And I'm not entirely sure what vblk is about. The driver in
-	 * Allwinner BSP is using a rather convoluted calculation
-	 * there only for 4 lanes. However, using 0 (the !4 lanes
-	 * case) even with a 4 lanes screen seems to work...
-	 */
-	vblk = 0;
+	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
-- 
2.18.0.321.gffc6fa0e3

