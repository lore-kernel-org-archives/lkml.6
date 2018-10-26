Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB65C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E46B20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qCn+CrVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E46B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeJZXW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:22:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40318 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeJZXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:22:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9-v6so617841pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UenRKo6OwvlFVAyYotlbn7LHAAkj6pMaa7wSfZK+ZAg=;
        b=qCn+CrVtnXCEoxMdBkn7/Ql4nXBkUWxhrhSwVTUosuf/V+OH4kIQFcbpvN+Hv1aNF/
         bNM0CftpaS6doZ9THR5unnaaaS4ehW65SrhzLsP8bZB/em+6iIvTQv3P4Q2+62KRAZCy
         96qifaCVulYjBpIKrIpRlvSnaeMOsa3NXGGFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UenRKo6OwvlFVAyYotlbn7LHAAkj6pMaa7wSfZK+ZAg=;
        b=ZmXKH/geC2ReliF9gPVbp3RttnstrGYFJcba2hHJFGiVGAZJOW71g1MLq15uOJxhKd
         iif3ZvAbFJB1K6GDpCZtVZv6j1KiaJY9qQhPrg01jdRNxze7jkmol9KTdVt9E3SMLSEB
         shhiJFOCnKaGiRPch0kwAv9IZBCXFMWjcoPV2L+lsuoVeOm3rTsntToeNGQEIlmBe1/r
         RIjZgr5hSqarH0PlE0O37ax7gYnl2CbVG7c1OOfeS3yv6nd89vRjaS/toRQgj4tAv46I
         SndsvCl5V8ptSNClUyOQcbGM1+9bdavZ9IVr+1i24MgS74+rtXHhnUEKzaMZNyMAbPEV
         hiPw==
X-Gm-Message-State: AGRZ1gIGQCMGngBmEwdZOM8k/ZAxD9VGycrUVWC817X7qMIFNGySWdSo
        42H6JiVFDd0TSt1e8cvGPVikrQ==
X-Google-Smtp-Source: AJdET5fDAHkS/vHusTVMTAA1dHL/rHuu08w6nk79FMLY4a8CZbFU+ntkK0EOPt7KCuk2ibeUTT0tXg==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22-v6mr3748802pls.117.1540565136958;
        Fri, 26 Oct 2018 07:45:36 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:45:36 -0700 (PDT)
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
Subject: [PATCH v3 15/25] drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
Date:   Fri, 26 Oct 2018 20:13:34 +0530
Message-Id: <20181026144344.27778-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike hblk, the vblk timings should follow an equation to compute
the desired value for lane 4 devices and rest of devices it would be 0.

BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
dsi_vblk = (lane-tmp%lane);

So, update the vblk timing calculation accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 20e330186b7f..42bd7506abaf 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -511,8 +511,19 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 * Allwinner BSP is using a rather convoluted calculation
 	 * there only for 4 lanes. However, using 0 (the !4 lanes
 	 * case) even with a 4 lanes screen seems to work...
+	 *
+	 * The vertical blank is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
 	 */
-	vblk = 0;
+#define VBLK_PACKET_OVERHEAD	6
+	if (device->lanes == 4) {
+		int tmp;
+
+		tmp = (mode->htotal * Bpp) * mode->vtotal - (hblk + VBLK_PACKET_OVERHEAD);
+		vblk =(device->lanes - tmp % device->lanes);
+	} else {
+		vblk = 0;
+	}
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
-- 
2.18.0.321.gffc6fa0e3

