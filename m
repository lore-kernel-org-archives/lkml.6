Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F2ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFC620651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="a+9DETh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFC620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeJZXWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:22:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36048 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJZXWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:22:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so673229pfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMs9eO77nl0Eah3EaCbogJZGiro2jRBYTgO70Xm449I=;
        b=a+9DETh0u939w4jAirodb/qnd2j+apuSoNCYkyoljf3MVh9k2qQLRJT6MtcUrZeG/J
         B1jZoo4ZbiLlLfeWF1Z2uekx/+cvkX/06qBnPtnHdgwa6mbvkuM5x55QoKhGPKhTK1m1
         Q9gDBJzgc3Ktf2GgDb81jjw9cZcConF+pzBtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMs9eO77nl0Eah3EaCbogJZGiro2jRBYTgO70Xm449I=;
        b=ox7+XOk4cl+A/SwmHX/h3EYBoHmIigdSDJZwjn1/2s9/Q+rCnITqWUQzwSnr45HsdL
         zJeQbeiSmukD2q1bTwFjZsMKjKQOiYRA67PgREPJrq0yMH4IgLaIeTe8AtPY/PIy4YMU
         gaH62AkpKraRIiXYj0Z4049GLJKXOJy7jZqZu3x60saF4ByBM89ylO20Pnf+HN4rygnu
         mrbThOZTTX3TAGkO5vErpqyq2irWvrjQ9KXA90P6h/jNOag/QFQo4FU2yyK0bwUfceTv
         qPSFgcylIWhPBUzE7slfOBrrBAvhuOZKiJrmBMIQyQbhdbA7uYAoNxcDUsDTjx77PQ/r
         WAIQ==
X-Gm-Message-State: AGRZ1gLCEja5yWjy9NemQkKFmyrsok6sQsTtptQmcuRNedjbBv2Sr+8o
        GYRo+UFbGVADLlHp4zvNaWTlAQ==
X-Google-Smtp-Source: AJdET5dgwl8AGfxA5UhLunN3uxeVtMs9gaT+XpatQelxAyvZpuQ46W7uxHtqkj7NCXxoK7BKPBpvPw==
X-Received: by 2002:a62:b802:: with SMTP id p2-v6mr629099pfe.1.1540565097511;
        Fri, 26 Oct 2018 07:44:57 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:44:56 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 08/25] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Date:   Fri, 26 Oct 2018 20:13:27 +0530
Message-Id: <20181026144344.27778-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON DRQ set bits for non-burst DSI mode can computed via
horizontal front porch instead of front porch + sync timings.

BSP code form BPI-M64-bsp is computing TCON DRQ set bits
for non-burts as
(in linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

=> panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
=> (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
   - panel->lcd_x - panel->hbp
=> timmings->hor_front_porch
=> mode->hsync_start - mode->hdisplay

So, update the DRQ set bits accordingly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Fixed proper commit message
- add tested credit
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 3a1d48bc1996..8d154cf2e6d6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -367,9 +367,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	struct mipi_dsi_device *device = dsi->device;
 	u32 val = 0;
 
-	if ((mode->hsync_end - mode->hdisplay) > 20) {
+	if ((mode->hsync_start - mode->hdisplay) > 20) {
 		/* Maaaaaagic */
-		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
 		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
 		drq /= 32;
-- 
2.18.0.321.gffc6fa0e3

