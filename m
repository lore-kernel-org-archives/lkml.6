Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E533C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B90D222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kXBtTe/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439810AbfBNTdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:33:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35490 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbfBNTdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:33:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so3568389pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmLB70XfR2J1D03CPPvqliqiD+PkiFMaZcieUMY43lg=;
        b=kXBtTe/clCxAbpE5dE4G/zYOQM5UWkCoZ8dYjMIC9oKZLt+EX4u/msuGADKWI4qMwe
         NAjFd0bR1BORcLV9cm3xRxZ6UVMVvCniFOFeDyrXkvCS/g/ghZJxIHWbiR5x65Mi8jbq
         Y12bxshHcvuqf8c5eLDHHik34DCAfHamojyo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmLB70XfR2J1D03CPPvqliqiD+PkiFMaZcieUMY43lg=;
        b=TJ6SN1EH8Zs8sf/ZwBF3/kf3piRnuoLPtmbJVpgjscyicEbp62Dl1L2fd2E30Dq4vV
         YzvQwSjbNCvtC0RjLc0bK+hqUviiVk83QNrFHvuMhhFFrIheDBinW9VQXtGcBdGhQrXg
         QhwkAnTSpHG+IN7NLDPD5F0I4OAiuMYMaI3BulSAuQT1q5f+FPuSCbl521Nzo/8fbSWX
         cbHxmVZpVWKXKvgthp/l73akz7PyFXvVprAXRvSp6KfOtArn1Dj8OO7cGMXJa+MmkXye
         3jbLWss3p4okNVqLlIIwjIrFXHYNhtOvE558MDsgptm1zcloXtq+0o9QK/Ys3pgRv98R
         84zQ==
X-Gm-Message-State: AHQUAubxZH56849SIPePwd0trVb4UneMTe4MaD4DWtkPQEQ8JeML3QY1
        1Q058I9HatxmukUfxuvy5cTRlg==
X-Google-Smtp-Source: AHgI3IbHhb1emtbzhHKeCm+L56KqhBW7mFSfErni09bP9cRLuonoxPPLn1mJD0iOb9MTS6ldkEZmzQ==
X-Received: by 2002:a63:e915:: with SMTP id i21mr1455445pgh.409.1550172788374;
        Thu, 14 Feb 2019 11:33:08 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:33:07 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 05/10] drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
Date:   Fri, 15 Feb 2019 01:02:32 +0530
Message-Id: <20190214193236.7504-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner MIPI DSI drq has enable mode bit and set bits.
1) drq for non-burst, with front porch less than 20 would need to
   set both enable mode bit and set bits.
2) drq for non-burst, with front porch greater or equal to 20 would
   not require to do any drq bit setup.
3) drq for burst mode, would only need to set enable mode bit.

This patch simplifies existing drq code by grouping into
sun6i_dsi_get_drq and support all video modes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 39 ++++++++++++++++----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a4360aed17bf..ab95e2a873b5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -355,6 +355,28 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
+			      struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		return SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
+
+	if ((mode->hsync_start - mode->hdisplay) > 20) {
+		/* Maaaaaagic */
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
+
+		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
+		drq /= 32;
+
+		return (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
+			SUN6I_DSI_TCON_DRQ_SET(drq));
+	}
+
+	return 0;
+}
+
 static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
@@ -399,21 +421,8 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
-	struct mipi_dsi_device *device = dsi->device;
-	u32 val = 0;
-
-	if ((mode->hsync_start - mode->hdisplay) > 20) {
-		/* Maaaaaagic */
-		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
-
-		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
-		drq /= 32;
-
-		val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
-		       SUN6I_DSI_TCON_DRQ_SET(drq));
-	}
-
-	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
+	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
+		     sun6i_dsi_get_drq(dsi, mode));
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3

