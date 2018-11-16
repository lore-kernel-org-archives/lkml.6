Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D24C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E562087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S2T6BdWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E562087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbeKQCxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:53:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44537 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390166AbeKQCxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:53:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id b81-v6so11157946pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MRo42Xf+FQpuD9HBlP4kHgZ6kHSlZrL0EE25YHygWMY=;
        b=S2T6BdWe4saNqr8iZpsCHP/vmNp1zYBDZeUNmr44SF6J0TY+di02NvuGEMk3OMnRqd
         uodzP5KSJsAw856X8sbpZ1+C7XmfY652LOfU1ARhg4s78dhnVad0Gz5/h8XmY1SEGuBp
         DFbaA1ROMKE1CPSDJAPai98J4NwIkPl1derII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MRo42Xf+FQpuD9HBlP4kHgZ6kHSlZrL0EE25YHygWMY=;
        b=lNCFgsvDzkjwMXC07jyE4Ocg3ByWwIDmC7Fidekn7dvVUaD+2G2bmbVpqlcY54pJrz
         YHiSZFckvV99sj5i1sCMPlTikj3D7uV4Ky7gjdeGIvJOoj0jRapgUQ3Jr1+zyo9RHzS9
         +dPz6IS2cq2Gm8oy8PWDMBT8Z5eZBnqEZIJZOGKxvCqvxtUzPPv9MCoh5hwcD9OocwTZ
         SZCsenSpnkbyOotxQ3qGwcKOBQw59Q42KOipZTSchqopjbc1U7ZezJUQ7PMMDDbbtD12
         B6HJhwXNadAYqwDfjd4tRwOSC5yUtRbYTdb1EPYfKltCcVqnVltH4iF6OcF8b6bHePb7
         A0cQ==
X-Gm-Message-State: AGRZ1gJzQtKedLMy7G/+2XofMkhaBHWuHvA4g3XWt/T9B/Byjj4hsDPO
        9iEccG/1+lY7fxMH2zD17Etgrg==
X-Google-Smtp-Source: AJdET5dZ5SU50zmOjkRJkoJuTE+S0902DCIO0+YdWzY+sLBUXEOUSOcfG/pI+yUb0aZoOL90/n2p9Q==
X-Received: by 2002:a62:528e:: with SMTP id g136mr7747262pfb.111.1542386445340;
        Fri, 16 Nov 2018 08:40:45 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:40:44 -0800 (PST)
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
Subject: [PATCH v2 09/12] drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
Date:   Fri, 16 Nov 2018 22:09:13 +0530
Message-Id: <20181116163916.29621-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
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
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 22d2987c3298..20a1de8493e0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -644,15 +644,21 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	struct sun6i_dsi_timings timings;
 	size_t bytes;
 	u8 *buffer;
+	u32 val = 0;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
 	memset(&timings, 0, sizeof(timings));
 
-	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
 		timings.hblk = (mode->hdisplay * Bpp);
-	else
+
+		regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+		val |= SUN6I_DSI_BASIC_CTL_HBP_DIS;
+		val |= SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS;
+	} else {
 		sun6i_dsi_get_timings(dsi, mode, &timings);
+	}
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(timings.hfp, timings.hblk),
@@ -661,7 +667,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	if (WARN_ON(!buffer))
 		return;
 
-	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 
 	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
 		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
2.18.0.321.gffc6fa0e3

