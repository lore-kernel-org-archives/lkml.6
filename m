Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41B4C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5D2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gc15ndhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA5D2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbeKMVOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:14:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37564 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732391AbeKMVOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:14:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so5855979pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ES0cZhisRcmV8a8D5yir4UWuJgGe2haJZaAh1WF1HU=;
        b=Gc15ndhF1igW5AkAXKJxAnpVuJDtUW0qMYRXdTIStPPgOFBOXKz8iR5/W57SpditQh
         4GX5n2L6FjJfhqGUoPaBYer2AHcSfAbXOqGfYMKzXZ16XcEsG54Y+v8VLjXaadakvLzO
         8Gq6werHjrMD4a6/PoiVZrnr2pAqrJju/3EL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ES0cZhisRcmV8a8D5yir4UWuJgGe2haJZaAh1WF1HU=;
        b=pLt9PRLAFBC8pGha9UWzZs+iC8icjnH6b3rJKUTfoduvngkmqz5HVUANjOyQ3v1zj1
         dpq1Dpkvb8IECuThV3eeLVgLbVeeLoDWwUfbsfqt2/3g8yxiaITJgwr4RrfTRTTn+qgG
         olENBrsk6PTFRhC09/NafKYgVJSX3CKerlrJrlelP3rUjRbWPrZaW71Gt+TKLIZCLNlL
         gaPeeWKSexTUlSl7DfkjyYw0hA/LDgY9ScVhOgYtb9adzQAULYl30kwsff+ve7bYMsRE
         GNU2mJNTKpgJdp3cWsbdNCx/durog06DeeKa4BdYo4QAzglNlbxqtUyh3iiDPHKXVm+O
         eC2A==
X-Gm-Message-State: AGRZ1gJDrAZxOd2lZG1arArUl0Km0Kts4bcBHzUvdOWh2cZgqXYqTFsB
        o3UvmxR328ot7WVllynu/NiJtw==
X-Google-Smtp-Source: AJdET5eJlzXrq6V6oaP76A2ePAOdAd0mPFR0yhAWAQjyuPvmz7DZ0/USu8zIOzcHyZXT/wKrpyDY/g==
X-Received: by 2002:a17:902:d24:: with SMTP id 33-v6mr4725603plu.319.1542107816601;
        Tue, 13 Nov 2018 03:16:56 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:16:56 -0800 (PST)
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
Subject: [PATCH v4 01/26] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
Date:   Tue, 13 Nov 2018 16:46:08 +0530
Message-Id: <20181113111633.20189-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI DPHY gate bit on MIPI DSI clock register is bit 15
not bit 30.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index f7d297368eb2..019d67bf97c4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -581,7 +581,7 @@ static const char * const dsi_dphy_parents[] = { "pll-video0", "pll-periph0" };
 static const u8 dsi_dphy_table[] = { 0, 2, };
 static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(dsi_dphy_clk, "dsi-dphy",
 				       dsi_dphy_parents, dsi_dphy_table,
-				       0x168, 0, 4, 8, 2, BIT(31), CLK_SET_RATE_PARENT);
+				       0x168, 0, 4, 8, 2, BIT(15), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);
-- 
2.18.0.321.gffc6fa0e3

