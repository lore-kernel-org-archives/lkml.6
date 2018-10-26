Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46192ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DADF20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Yf5VhCYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DADF20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeJZXWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:22:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35589 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeJZXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:22:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so655346pgu.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gStIo7NjdB+TGqHNblRTUUqjFPTn5lbRTmfmm273Bxc=;
        b=Yf5VhCYNunBsPm3e5TIp1NrtyNuZROnCExwWWP+jnKIHm/8MdKp3HleEcNYZvbuCHY
         ygswg13ZW87y3w5GYwhMds9ymeERXjpJSE/u8Xv/NyRUW6+QXOI5d1hn2GnZrMol6SUL
         gs1ZU94O9ECeCVRNBgDdaKvljgbrQXRsCNsvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gStIo7NjdB+TGqHNblRTUUqjFPTn5lbRTmfmm273Bxc=;
        b=ae288GwRUUv2XEzgUREM3elVRD3s9e8igJywqC9j9Ni4HF+tI4t94SPFSRumVi3Ogv
         KVCN98EvAieSFK4cFhYWaMec79FWnpiB+KVARkUBGPtcK0hRvsMtcNFGSrPluTBEKXlX
         FJdWdar/hjNlDO4tCIFIylphvjgpC5PpIfvrB11j3JCxM/UsTxjF78IpSkHpuB5gTazp
         flCJZevWt5zgQ46L4bA6zrHMPsSL5E0JnCKHkHmuMFhSn0odxTR9lOa+qgkCDtJyKuIl
         OFeviHW4NHt3Q2n0F/ZjW5ziJEENHJVjHI/dVjwy65LCWpc/qixHFndw4oo/P7O4jyjL
         GwIQ==
X-Gm-Message-State: AGRZ1gL1a3wwPiyrPCFNiZzkMdMGUO3ZTAgLaadCS8lHuSWD9/SBUi45
        33T9208PCcAJL1cwy3Kpguqu5Q==
X-Google-Smtp-Source: AJdET5f2tELebo7pA+gv81OluwfXob4rp1XQeVgf2g02+EfXF3ZDPpSJJx7eZAew0I6nmSg/Yy8auA==
X-Received: by 2002:a63:b218:: with SMTP id x24mr3608910pge.223.1540565125481;
        Fri, 26 Oct 2018 07:45:25 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:45:25 -0700 (PDT)
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
Subject: [PATCH v3 13/25] drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
Date:   Fri, 26 Oct 2018 20:13:32 +0530
Message-Id: <20181026144344.27778-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver is calculating hfp maximum value by subtracting
htotal with hsync_end which is front back value, but the
hpp refers to front porch.

Front porch value is calculating by subtracting hsync_start with
hdisplay as per drm_mode timings, and BSP code from BPI-M64-bsp
is eventually following the same.

BPI-M64-bsp is computing hfp as
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
dsi_hact = x * dsi_pixel_bits[format]/8;
dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
dsi_hfp = dsi_hblk - (4+dsi_hact+2) - (4+dsi_hbp+2);

Example,
u32 fmt = dsi_pixel_bits[format]/8;
=> ((ht-hspw)*fmt - 10) - (6 + x * fmt) - (6 + (hbp-hspw)*fmt - 6)
=> (ht - hspw - x - (hbp - hspw)) * fmt - 16
=> (ht - x - hbp) * fmt - 16
=> (ht - x - (timmings->hor_total_time - timmings->hor_front_porch - x)
* fmt - 16
=> (timmings->hor_total_time - x - timmings->hor_total_time +
timmings->hor_front_porch + x) * fmt - 16
=> timmings->hor_front_porch * fmt - 16

So, update the DSI hfp timing accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index cf42be1f1ba1..6584b51736a9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -490,7 +490,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HFP_PACKET_OVERHEAD	6
 	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
+		  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
 
 	/*
 	 * hblk seems to be the line + porches length.
-- 
2.18.0.321.gffc6fa0e3

