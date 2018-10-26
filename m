Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3DAC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BA120651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BR/O0TL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BA120651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeJZXWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:22:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39160 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeJZXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:22:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so4416pla.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzYsobS71oU5eR+nCqctsEelM8iLw0Ecr2La7CxlAO8=;
        b=BR/O0TL5MOkrEbMcuc7MkTgo4m3V4Fxw1ESKkXIpCxC/17FzfssRNmxVV3PaL6j4Wm
         MDtll/L04n3t/bNVGECryTTlglskuI/pte8xXuK3XyLybCuFhQzppvVo9iiTD0FyQl5Q
         4p/dXV5oMMAqek5FXutWeuqMQOuDWAi3xF0hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzYsobS71oU5eR+nCqctsEelM8iLw0Ecr2La7CxlAO8=;
        b=iFO1Tx46Y4o2KqBhys4+0IRSW6KD6AffDRcdGjubp+6SHwCrpWN7KJr8Y+jwTKNpCc
         Q8MwzAfWPaimmk8j+uDwUi3Mspq1tBqS0Lwa3uinvPl0IBkHCXxDmvhEQ4I9Ve8r1oiT
         zAUEgqXcmDFKYmEEXGuOYDde8juJbWBCIm8LcTVYLYlGoqcnneQAWTZo6NJ8wngIfBPc
         kvlx/14sqdG1luQPd57Xt3MVMIP8r3372MS4PEGszEt3yo/7TP4nijvNbN+k25U6+6H/
         EtfRamKaWYR4RGuDhkxB2b66qgsdvAyTx40xveNqkWUvtGlQ8xx96WMHgYfq/jNQe2Ht
         /xZw==
X-Gm-Message-State: AGRZ1gLLDG8frIUQzDyHtKj2i558BilPUUDT88GThhOVZcnWD/bR2OZ/
        AaLLf9CKX6p7FnnB9lWiMsQJ/Q==
X-Google-Smtp-Source: AJdET5dB/Dxd/8QFJYIpBnoUYvo7mQsaQ0AobFhN6+4RxofTwTehooR371empGplpVn4+Nth/1g+nQ==
X-Received: by 2002:a17:902:9b84:: with SMTP id y4-v6mr3845077plp.332.1540565114258;
        Fri, 26 Oct 2018 07:45:14 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:45:13 -0700 (PDT)
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
Subject: [PATCH v3 11/25] drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
Date:   Fri, 26 Oct 2018 20:13:30 +0530
Message-Id: <20181026144344.27778-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hblk is adding line with all porch timing values, or timings
values from htotal without sync time.

Current driver is subtracting htotal with hsa, but the hsa
is bounded with packet overhead. For real hblk calculation
needed by subtracting htotal with back and front porch values
and BSP code BPI-M64-bsp is eventually following the same.

BPI-M64-bsp is computing hbp as
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
=> (timmings->hor_total_time - timmings->hor_sync_time)
=> (mode->htotal - (mode->hsync_end - mode->hsync_start))

So, update the DSI hblk timing accordingly.

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
index 78bad71045ca..596e560263bf 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -495,7 +495,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	/*
 	 * hblk seems to be the line + porches length.
 	 */
-	hblk = mode->htotal * Bpp - hsa;
+	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3

