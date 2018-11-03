Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD57C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21352082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kynS843W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21352082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeKCTVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:21:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45793 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeKCTVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:21:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4so1615025pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce7dCP7DfFpA1e50RettNtIdS5/8ZiyxnOTveZEOqbc=;
        b=kynS843WNKVgkuX88acq89wg8byWQ/X6sYeDsUTzFb8dIlI9nH/aSoo9oDSpB7O2Ag
         MTZgpW12Z6sr0svz+RnwqbW1Sgpq7Ph+JkgVuGL7UcUpbv+KDwl4atFt01kBd+GhFFoe
         OsmVUrr+cGV4XTS1tQuYJtjj+ESCGB11OAcuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce7dCP7DfFpA1e50RettNtIdS5/8ZiyxnOTveZEOqbc=;
        b=FYxY+/22it0VaaqLE9f4fJ8oyg9rFNUq9vuKNccCno0O+yvsw4yV6QDSpgwsONPIYB
         1XRL+He+fwqWuslcgpRfVuBimfIbw9KlYYui9VBH4CJWV4j76MboHlbcN11IhC3R6QM+
         oZbl2Ftbk3pyXXybkV2kOp1z/5QuCXwx9aoMZxJ6QJ3Wg5JWozqqVnw5DJKrtyV9dbt8
         tUM6O3TbhQRybI8+cwhlCSnOnDGKNE8RyblmXMV2HwQx5GjPawZ55xH2GP93EdwtjpNO
         GDsLsDOo+YtPj9YfaqlOnPr+NXivDFwA6VJM3H+j4k6+GXwUOEZ3hh45rTMG6dai7aB0
         cgWQ==
X-Gm-Message-State: AGRZ1gLM18ADj2BDun/nsw1L/ZkKMIH1zdSzYdHAyrLNQDTagpc9KukZ
        XwTwEKPfSWdgrdH2YW4r/Vxj9M77wWQ=
X-Google-Smtp-Source: AJdET5e+pQzSqMcJNJABb28K3oUehx7FlxwUeNS9B+nUNPjuQyX+XcrQxRdm5S+2gEoaL/VSsMJfMw==
X-Received: by 2002:a63:4384:: with SMTP id q126mr13740690pga.160.1541239812653;
        Sat, 03 Nov 2018 03:10:12 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:10:12 -0700 (PDT)
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
Subject: [PATCH 07/10] drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
Date:   Sat,  3 Nov 2018 15:38:57 +0530
Message-Id: <20181103100900.30313-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Horizontal back porch, sync active and sync end bits are
needed to enable for burst mode panel operations.

So, enable them via dsi base control register.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 2d34e5f48d29..feb8c54c5146 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -518,6 +518,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	u16 hbp, hfp_pkt_overhead, hfp, hsa, hblk, vblk;
 	size_t bytes;
 	u8 *buffer;
+	u32 val = 0;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
@@ -527,6 +528,10 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		hblk = mode->hdisplay * Bpp;
 		hfp = 0;
 		vblk = 0;
+
+		regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+		val |= SUN6I_DSI_BASIC_CTL_HBP_DIS;
+		val |= SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS;
 	} else {
 		/*
 		 * A sync period is composed of a blanking packet (4 bytes +
@@ -594,7 +599,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	if (WARN_ON(!buffer))
 		return;
 
-	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 
 	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
 		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
2.18.0.321.gffc6fa0e3

