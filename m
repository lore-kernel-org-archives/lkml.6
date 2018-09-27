Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F2AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40948215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bJb2hqzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40948215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeI0SH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:07:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37996 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0SH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:07:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so1786633pgr.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h7PHMbYpuEXpp+8XgIFSEXt+FJJ3QcGp+T82lkpHAH4=;
        b=bJb2hqzNxsJ4M9UVqML0qhncsnI2R9K8AIwYoU9+qM0IcYtmlASU/nCLCNOBUUNQ/m
         wGWuz7FnvhfOHv1mYzjJB4TzZ2ydF/2fDLKOdeoUI7Eb5pMeEdk6Ce3sU2KV8mgYjIna
         Sliro/d0zM+nc9oQS+3Qm5mxL2HYih09bwbe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7PHMbYpuEXpp+8XgIFSEXt+FJJ3QcGp+T82lkpHAH4=;
        b=m60gUlrOoLnNauDBazCHvmvG3hPTi5tZYcaDKupk7T6wPlJK9DETWSEQ0iJDi/0bS0
         nM/DzSrX49lr00PGmqMFrMg+HwKkyqVfDHQpAnCFnx40xvc77OIEL0if/X1qRuedovQM
         drc99D9f83ihgrJPOeUVeWJ6hVFKzLIujM51UzxVZjbxYHj2e+YIaU+hMObbArXi0bAL
         FocB3C3Up3ygAXt02iz+3ZQ7lwMPPOi3BtM8Oa0szar/pMxyygvEjYeKJDrp49x7rhqs
         3Lu1CyvuM/wjCAebTQTtmxLcFIZIOGioruqtnhFXZZW+j5R+80huxcyWM9qRJ9rXrWn5
         FJ0A==
X-Gm-Message-State: ABuFfogltbLPeyJKPb0eso0Mh8UZanX3wap8fXaKPfQx04qrc5CfW8gd
        V01AflW8mPZYaasnmhQ+6WK4nA==
X-Google-Smtp-Source: ACcGV63oiscJEiP9nlZ/hvm2ilMa/7Ju7fl+feJ0Sd/gTtC1VKv0GWKXIM/Le/43UYW07D20gIaPcw==
X-Received: by 2002:a63:7107:: with SMTP id m7-v6mr9830760pgc.73.1538049004209;
        Thu, 27 Sep 2018 04:50:04 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:50:03 -0700 (PDT)
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
Subject: [PATCH 07/12] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Date:   Thu, 27 Sep 2018 17:18:45 +0530
Message-Id: <20180927114850.24565-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON DRQ set bits for non-burst DSI mode can computed via
horizontal front porch instead of front porch + sync timings.

Since there no documentation for TCON_DRQ_REG(0x7c) register
this change is taken as reference from BPI-M64-bsp.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 599284971ab6..9918fdb990ff 100644
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

