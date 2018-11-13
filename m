Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D094C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3563820685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LXQiTYVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3563820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbeKMVPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:15:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37778 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732786AbeKMVPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:15:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so5548641pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jROG6UOjt8ak5A6N/TCD5RGHneXG5PcbkfCte5OCDJE=;
        b=LXQiTYVflyPz68NqHSTd3wz5D2x5gI+3PhqcDra3MGw0DkT17UbvZrk66pViGfiC9B
         GOMWxPd5ePBUmoH7U/lUANgAJS8we+wBGRDq24WwRJ6Tb9T1mrh8CYvuKwLqKYv4Zu+3
         1S6P61wATkhCiHeoM5CrBF9FLYmmGkAz1azN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jROG6UOjt8ak5A6N/TCD5RGHneXG5PcbkfCte5OCDJE=;
        b=BxMIynVKSnjTTILa0Tz+ENiP1OZFjeLp+8AKMgS0wl2540at4LzffzRTBbZH46ERLP
         bNJoincSXTfYQ7vtS5JBLx6xq45d8ADvh1pNSITwo11i8cDxrZljbA6ogb5JadOHVG/N
         08+lr/SBmyWdz3DCO8UP9KoZGnVgvYPl4Fzqq46aNYNWjLVpNhlPx357FiwtIV+w/XJI
         jHUoR6PShYA+6Wfmw7513au/uHONMGHs8RntKbojmigXE5q4dfTb30eb1Sr0qr83kVmn
         pfPmZ79dspUsxRwNrvN2daWH8cJ0pPiFGkA9y2iE4zMrR8AAKRGbpp14R2PIsRxXFh0X
         W5lQ==
X-Gm-Message-State: AGRZ1gJ8pIGgUakdEipCCWqihYcx69tfY6w7zR3KSFIz0xMelk7kLg7x
        WoAB+6xZ+edWvJ5QNJ/D+tC02w==
X-Google-Smtp-Source: AJdET5cb91fcvQbuJw5ySdoTmKHQBJBviUFXEGQXSzMxixvPh+JbeJWx95n0XPVVqY9oH1endkKtgg==
X-Received: by 2002:a62:9f42:: with SMTP id g63-v6mr4693848pfe.144.1542107891914;
        Tue, 13 Nov 2018 03:18:11 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:18:11 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 13/26] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
Date:   Tue, 13 Nov 2018 16:46:20 +0530
Message-Id: <20181113111633.20189-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 10 bytes packet overhead for hblk where blank is set using
a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)

This is according to BSP code from BPI-M64-bsp (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);

So, add 10 bytes packet overhead for DSI hblk.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index cd657ac4bdae..1a3cdd5b72a0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -494,8 +494,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/*
 	 * hblk seems to be the line + porches length.
+	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
+	 * payload + 2 bytes). So minimal size is 10 bytes
 	 */
-	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
+#define HBLK_PACKET_OVERHEAD	10
+	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
+		   Bpp - HBLK_PACKET_OVERHEAD);
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3

