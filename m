Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4EBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5231420665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="USfPeOIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5231420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeJXAQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:16:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeJXAQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:16:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so868615pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blc8pa2mH8WA0kLLsJN5Bi8u1t4IIhc8DjF+yhou15g=;
        b=USfPeOIkp2ETkJWiArIhI83smWHBeA73W6HXY+EPSy8wwm0TGIxzNFIOa4eZonrfpC
         Z7naxMoFedsDNBaq8j2xuSC//P+vNc8pSETgglMDPp5/uXWivibCaGhhkfJVIqfsMR0s
         BVMuFCnocX19GDoCJx1Wn08jVrBF5S2bkYb/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blc8pa2mH8WA0kLLsJN5Bi8u1t4IIhc8DjF+yhou15g=;
        b=LeOWtjMUDSjGmzntHKC9zozdcMrvn6UFiR6EZ8VjOKCuB4Io10p3/3MAXuPTusKb5m
         GeYjwd3mHXaI4Nbt6DXAT6d24cYY8a+805YoQ9D6VZsVIwDZxnL+FMSYXfOsEDriSDH2
         vxdEqWTZtswv9h5fUYDasqUtLs96CaUcx7d7dsfD0FGwBy9FfdKhSpHdvziGt23f2cIu
         ysMPtxsMgPuG/GF+MhSkOebLv7xJRP/Vrj3nVk9qyOwH2jGJ1Fnhj2VyUZgkEObghhcz
         fOGqWCaP7WdyetcMGHy2GnF42KBVstqHt3+bhAE1rCNrL/JhPLy8p+2EIH4H8FsXiUzO
         8klg==
X-Gm-Message-State: ABuFfoh3pfqmog0epjvRBQI3QPq54/mYdrW7IjUkgXs254HzQqV10qwr
        WG0GXEPkIUviS10cSUU1wVfUtA==
X-Google-Smtp-Source: ACcGV60AXjcwdPsoZe6YALxa5lDpJrnpWVk/hri+trnu15ok01soQwW7+2OBOxHDVg+435IWgolscw==
X-Received: by 2002:a63:4343:: with SMTP id q64-v6mr48792747pga.276.1540309926729;
        Tue, 23 Oct 2018 08:52:06 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:52:06 -0700 (PDT)
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
Subject: [PATCH v2 12/15] clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
Date:   Tue, 23 Oct 2018 21:20:32 +0530
Message-Id: <20181023155035.9101-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A64 manual say PLL_MIPI rates are 500MHz to 1.4GHz, but
using minimum 500MHz can't release the clock and which
is not working.

So use working minimum rate as 300MHz which is tested on
Bananapi DSI panel.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 019d67bf97c4..5a3a5b821f8b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -167,6 +167,8 @@ static struct ccu_nkm pll_mipi_clk = {
 	.n		= _SUNXI_CCU_MULT(8, 4),
 	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
 	.m		= _SUNXI_CCU_DIV(0, 4),
+	.min_rate	= 300000000,		/* Actual rate is 500MHz */
+	.max_rate	= 1400000000UL,
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-- 
2.18.0.321.gffc6fa0e3

