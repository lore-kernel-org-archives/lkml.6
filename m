Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915AFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC2220873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+DdWSYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeL2Ndj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:33:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42775 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeL2Ndh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:33:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so19444480edw.9;
        Sat, 29 Dec 2018 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k13CwrRPNYtJ7lsBiqAPPxCzsrGsqSruGobJNVs9boI=;
        b=p+DdWSYTbMvZE4LFQPsS6oE3GVU6PQDwjPmWN+PrO/Iz4TH85TuBV+m7hxMxUpuDJc
         ePPxDJVifCgfZmmIrGbg6t5oEJaWi1mcjktZJ9KHA1APIeWvQBBp588sUn4CXl7d7zJ2
         qWyQns6xOycA53X4BJCGVUru4e4KA3JXy/h4Y/N4FfQQWTiUvTRfH0DxKZDaVd7EL0Rx
         qGbPCEOg6dvmFvcuJc09+fsSQPcXFHHLBibUalcQjelIz7RakmFrS52tPMnu2RoNrXCR
         vvVJTzDtRbT3yCm6vHBOfgJEEpk0yDfypVW/Y3po6/KReXNK5OHGAvRQ6/CMma4ljBt4
         r4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k13CwrRPNYtJ7lsBiqAPPxCzsrGsqSruGobJNVs9boI=;
        b=r+OadePjFmmhWmIvBUhPxTTjVhF5pwVAdih5WBz2gKu39JFdlNovzPIuXtpbhe1p4+
         PlAUKBmVSmJCt6GTFr5FVvwmEEf2MVKXiKWTn4uvHpnjjhfcPnyl1CK7WbLeBboShI4H
         FP0hgAsOUA/b9eW64rjoooOxCx7CrUx8itNLNJQDuabxgy1D7p7LeD0ir74yrwI4kGsn
         5WcCx9B2ngnhauPu3YdQZX8REWQgGhf0FS+7sueJ+j8/YteG/Nw0UhELC8HfpIoB5SwY
         ib2sq+Je1qkjUNzPh/+i7ATrlPLXFoR9RPyAQRLZkedsKCVH72PiWmsvZpgLdeVFADEA
         GU7A==
X-Gm-Message-State: AA+aEWYWJCuX0seHABDYw5A/JETuis/KIvoV+oxM0cy5qeg/5PZyaSgt
        ErE/xEMDwPf9qap9Uecw5PHfLZKp
X-Google-Smtp-Source: AFSGD/US03gx33a/c6v1zDMgPDz3TADuJ8aHK0/wmFr4DQq1NGUzn6qTteSs59fkUtLoGtj5t6/hJA==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr26300545edq.30.1546090414971;
        Sat, 29 Dec 2018 05:33:34 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 05:33:34 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 2/7] clk: rockchip: rk3188: add CLK_SET_RATE_PARENT for lcdc dclk
Date:   Sat, 29 Dec 2018 14:33:13 +0100
Message-Id: <20181229133318.18128-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Add CLK_SET_RATE_PARENT for lcdc dclk.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 7ea20341e..5ecf28854 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -586,12 +586,12 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 	COMPOSITE(0, "dclk_lcdc0_src", mux_pll_src_cpll_gpll_p, 0,
 			RK2928_CLKSEL_CON(27), 0, 1, MFLAGS, 8, 8, DFLAGS,
 			RK2928_CLKGATE_CON(3), 1, GFLAGS),
-	MUX(DCLK_LCDC0, "dclk_lcdc0", mux_rk3066_lcdc0_p, 0,
+	MUX(DCLK_LCDC0, "dclk_lcdc0", mux_rk3066_lcdc0_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(27), 4, 1, MFLAGS),
 	COMPOSITE(0, "dclk_lcdc1_src", mux_pll_src_cpll_gpll_p, 0,
 			RK2928_CLKSEL_CON(28), 0, 1, MFLAGS, 8, 8, DFLAGS,
 			RK2928_CLKGATE_CON(3), 2, GFLAGS),
-	MUX(DCLK_LCDC1, "dclk_lcdc1", mux_rk3066_lcdc1_p, 0,
+	MUX(DCLK_LCDC1, "dclk_lcdc1", mux_rk3066_lcdc1_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(28), 4, 1, MFLAGS),
 
 	COMPOSITE_NOMUX(0, "cif1_pre", "cif_src", 0,
-- 
2.11.0

