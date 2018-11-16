Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E6AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A19020684
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WB18R8Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A19020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390187AbeKQCxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:53:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45153 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390166AbeKQCxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:53:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so10819864pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBsrf76ZM/i+rqqgf+m+LE5qjwwWDpXcodR4cqVxPuQ=;
        b=WB18R8BfhzYgZ8PV7X/XRfYMIAIQzuqSvdw8GvUoE8MchkdJ5CQx1pwo1Z2AqQynTY
         wab2418IG2H5iQBRD56tNCpzUnUQumNMa27A7L4BHjrVsFsT7S3QN7T+0seFkWJzaDpb
         ocmMwZY36ulZgMXmIfc66gtW6k3wUb3m4FmEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBsrf76ZM/i+rqqgf+m+LE5qjwwWDpXcodR4cqVxPuQ=;
        b=o3mANkQlV4sC70Hk8w7EL2iQyEzGEU0cTxHJ+j5zEWYbBXQYRDB20g7kbv+OaZy+Pt
         5tYYFuC3W68gk8MJVOojViLK9e21A/RwN//GTNcbdzwFrESALFotjPctHv3h8vd2x2uc
         f63oTuzik567Nq+RX3zK83Psh+v8a7Iew8YF8BcRhWIp+l7EDJvsZSOmtIAgp5h6M8iy
         GnZy096XplXCyrHZX965aHbf8X3prAunq9SPsr92w5BdAQKO5NQ3wBibIhC6xFogFE1Q
         lx+d/hgXehpGfSv9Z3L2o+2Rv6tm/6nj8we1684G9TllyPdv/cfF+sxjvNkkV2KDYsIh
         rjMw==
X-Gm-Message-State: AGRZ1gJgDasxwvXbfNP8l9bdZrG+ICaBdnTJNktkUqqxp60TOpXmCtY3
        gr1uR87EqZFdq+Xl8N1X8yjx0g==
X-Google-Smtp-Source: AJdET5dLcC4ia6XQOMeChAGQ+PpLrfV212072zXMAz/H5w2/HqWBTXxsNpTbqcIes6VU8Qumxt9PsA==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr10597592pgd.446.1542386407688;
        Fri, 16 Nov 2018 08:40:07 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:40:07 -0800 (PST)
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
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 04/12] drm/sun4i: sun6i_mipi_dsi: Simplify drq set to support all modes
Date:   Fri, 16 Nov 2018 22:09:08 +0530
Message-Id: <20181116163916.29621-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner MIPI DSI DRQ set value can be varied with respective
video modes.
- burst mode the set value is always 0
- video modes whose front porch greater than 20, the set value
  can be computed based front porch and bpp.
- video modes whose front porch is not greater than 20, the set value
  is simply 0

This patch simplifies existing drq set value code by grouping
into sun6i_dsi_get_drq and support all video modes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index efd08bfd0cb8..d60955880c43 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -363,6 +363,26 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
+			      struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	int drq = 0;
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		return drq;
+
+	if ((mode->hsync_start - mode->hdisplay) > 20) {
+		/* Maaaaaagic */
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
+
+		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
+		drq /= 32;
+	}
+
+	return drq;
+}
+
 static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode, u16 hblk)
 {
@@ -478,21 +498,9 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
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
+		     SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
+		     SUN6I_DSI_TCON_DRQ_SET(sun6i_dsi_get_drq(dsi, mode)));
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3

