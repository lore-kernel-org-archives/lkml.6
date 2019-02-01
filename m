Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC7BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBAD20855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bdX9sXiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfBAPnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:43:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42213 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbfBAPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:43:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so6159118lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rS6sGbJP+zjY5kJm8iT11B1WuOcwYEUOTtJGe88GIrs=;
        b=bdX9sXiywy0BGPdJwc5OTztIqQo0WTncpb/ZlqVFxOTBr0j9Hc/hOb3la6YN6Krgxq
         BJY376aZ5qf4y4aNLn3kGIXsqow0XD6fQnpCsjs++yoDdrMR77yh8ZJThJo0lBUp+5ID
         EdgNlkBPPGibaIaBvITW1dJxiVrNqSlL1Fpy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rS6sGbJP+zjY5kJm8iT11B1WuOcwYEUOTtJGe88GIrs=;
        b=lpZNzyw14JVn7HnMTQHPEsu2kUmN9dHyUZnfTqCAL0wecwMoxzxgMjj0aubuVOn22L
         oOuzdIJUNN/8RRpUBYeYtthuCXK8CXfZqvIqefswBMn/JjnMATbK/pYLRJos5oMvQN88
         VZpacaBZ6FNx9o5rg4Mis6N0bVn/YNACd6XxpXXVxheMq/pWmnUt7IWVtixIyn7irNRx
         V0zu0Dyc+64chJeDBo2kPunoQiZQ0iZw3WmaVYD5ujXLGwd9i3F3s1snH76j22NsmBvC
         URKF4xNP2efpyDOtPmq0JwPmd+598YC+9zR/IJ5wy0gJFFOsMnkvlN7920tp1Wu2npX7
         ikxw==
X-Gm-Message-State: AJcUukez0ABZ3PvQQfSd1iiD8AjY0oJeUPgIZGbNvxUcNsDq0hDjSouq
        GPA7pNH6xWmJkN1GYQbtBPGLqw==
X-Google-Smtp-Source: ALg8bN6wZLRx3APZR1H/AYjNK+cdvIN3IPrZAwkaLn+hv3CJ4/x48AjmcKpGiIL9oGehk6sBp0t6Dg==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr31408690lja.58.1549035780689;
        Fri, 01 Feb 2019 07:43:00 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:43:00 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 09/23] drm/sun4i: sun6i_mipi_dsi: Enable HBP, HSA_HSE for burst mode
Date:   Fri,  1 Feb 2019 21:12:18 +0530
Message-Id: <20190201154232.10505-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Horizontal back porch, sync active and sync end bits are
needed to disable for burst mode panel operations.

So, disable them via dsi base control register.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a2ad9fa7f8d5..3d7c03161954 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -549,12 +549,17 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	u16 hbp, hfp, hsa, hblk, vblk;
 	size_t bytes;
 	u8 *buffer;
+	u32 val = 0;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
 	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
 		hbp = hfp = hsa = vblk = 0;
 		hblk = (mode->hdisplay * Bpp);
+
+		regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+		val |= SUN6I_DSI_BASIC_CTL_HBP_DIS;
+		val |= SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS;
 		goto alloc_buf;
 	}
 
@@ -603,7 +608,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	if (WARN_ON(!buffer))
 		return;
 
-	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 
 	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
 		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
2.18.0.321.gffc6fa0e3

