Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5FDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611A72150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UrQt3Oh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611A72150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeI0SII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:08:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38630 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeI0SIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:08:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so1744958pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0R68Y/KzwdIumM6zfyEnPevd749hoDtm4cNpSj8lHM=;
        b=UrQt3Oh+h3lHXl9yq+YbsI4BIj37f6E/418FWFbw2leiym7BkzqO0wDW7L66LC8hQH
         dMw3mR4yfjL0UttZBbUvKBghOkokwFcBlP/r9iRVIVqgQOD+sU9RiBOJc0oZH2Foweny
         Tf7Ckqitg+pcY9xhvI1zuRPmP4SQxg3XEpeu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0R68Y/KzwdIumM6zfyEnPevd749hoDtm4cNpSj8lHM=;
        b=fdPK5ecqdCzag1l+qTxOomiTBAp/Kd3p1pWdSnUDDt2OobT5YT9mMeefEFOwAL3F59
         Wa8/V2td79k54KSznV6/7rPhAFm+WVcMHTkep9JgZso2aNZabwRbb7Z0Ntxpg/co4mFS
         JYw5saKOocT4T9FQC7A2rL2lxApOlCNNhO9DE1PzNdg/twZdjmDJ+/ioC643DXP/rOPD
         PPkQEH/k2Opm1RNGuw00iFwE4ONg2oEZyV6ZGXIuORpRZdHbFCT1CCXJbJkjWdLq6c3M
         kd1v3SVC30vy+NbV+1rM9shQIl6shWS5POsHSDXvjO/Fyr2omf/dPImyrDMK9LVaLzYB
         YzPw==
X-Gm-Message-State: ABuFfojDPiEKPesVr4jclrteKb6njjZD5J/ChePfmI4PqBpdNohwEdqA
        5MhcmeMdloOrlCcE6SJ21flw8A==
X-Google-Smtp-Source: ACcGV62iZgr6a1wPuCr8fIWrr0mf1eoTyBfPRoHo5BLUU2Swc38AUSdthHx5XNtUnk+Nngsr4XPO7g==
X-Received: by 2002:a62:8145:: with SMTP id t66-v6mr10902156pfd.192.1538049011667;
        Thu, 27 Sep 2018 04:50:11 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:50:10 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
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
Subject: [PATCH 08/12] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
Date:   Thu, 27 Sep 2018 17:18:46 +0530
Message-Id: <20180927114850.24565-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accordingly to BPI-M64-bsp DE DSI code Video start delay
can be computed by subtracting total vertical timing with
front porch timing and with adding 1 delay line for TCON.

This patch simply add the start_delay logic from BPI-M64-bsp,
w/o this new computation, the DSI on A64 encounter vblank time out.

[CRTC:36:crtc-0] vblank wait timed out

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 9918fdb990ff..217db74c6dc3 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -358,7 +358,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
+	u32 vfp = mode->vsync_start - mode->vdisplay;
+	u32 start_delay;
+
+	start_delay = mode->vtotal - vfp + 1;
+	if (start_delay > mode->vtotal)
+		start_delay -= mode->vtotal;
+
+	if (!start_delay)
+		start_delay = 1;
+
+	return start_delay;
 }
 
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3

