Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6C9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E6222510
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p3/0IBrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E6222510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbeKMVPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:15:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41841 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732465AbeKMVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:15:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so5876313pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXeHiI0jTSc5wEU3J9SBtYcSgw6GuTxHUVUlo5pmyKk=;
        b=p3/0IBrO812eKj1R1+fv7pTnJ5BlZsDSp3Xty76yodWhSf0zNNIQV+aDpour9/S3v7
         9Qh6ZwMkJik2siXMG4cUAylUmhjTkhqyLeY672rnkpg+oAW1yGakWzKkXNFgHothM/1x
         wqrFxa411CYZ3o9kpg8/G5QUQU66tWjK+kBHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXeHiI0jTSc5wEU3J9SBtYcSgw6GuTxHUVUlo5pmyKk=;
        b=NLDpqh3VECKwRnq9EiPuUzdNSCIKftgVYgpHXtR+5/CrhS3DFF8hSPCs13VGFhUsXk
         JwuII7MZrddozpoENCbQ2IxuYoLDYhtJNaW37AHtOpbbYuHftU6vX8JtxiNc3lfJwWD9
         EpqVHy/d6zsu1LFJN3aT+2tZMReQmEPGeh6S8QHViJWiVGlMCIMIzv/eI4dD9vYMvyEP
         g2D0+yg05J289GqlzMTKmUxQ2TOImAeMohxoEkitoOd2ZocRhZm7mdXH/OuC1OgiwkMb
         DLGS1s/xlzsgI5BnPYClBHX65vO/JfdsMcJThVuEen/e98tZBSBQyIC74GWrqnW0ETfB
         JSjA==
X-Gm-Message-State: AGRZ1gIU/0hYuWYoetXQC8NEaNm/0G3kXcpd4RB4VYpTAwzG2vKlQFqL
        o0OUfMuvbNWxSMbT5AEUzznlEQ==
X-Google-Smtp-Source: AJdET5c5J5NcWM8pvY3YVB3gvLvx89Fw9LaZuo1pOtIkrkPRqUrf2SwgVQFH5WMzc/bki2dUopOW+w==
X-Received: by 2002:a63:a16:: with SMTP id 22mr4382852pgk.318.1542107885602;
        Tue, 13 Nov 2018 03:18:05 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:18:05 -0800 (PST)
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
Subject: [PATCH v4 12/26] drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
Date:   Tue, 13 Nov 2018 16:46:19 +0530
Message-Id: <20181113111633.20189-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
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

BPI-M64-bsp is computing hbp as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
=> (timmings->hor_total_time - timmings->hor_sync_time)
=> (mode->htotal - (mode->hsync_end - mode->hsync_start))

So, update the DSI hblk timing accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index de0992052a90..cd657ac4bdae 100644
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

