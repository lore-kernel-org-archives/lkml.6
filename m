Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123EFC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C605820824
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DjwUqxwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C605820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeJXAO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:14:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45022 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbeJXAO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:14:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so844065pgs.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owvG08mCzufA5uZoCz7gh3bK+359aJ5DTWVXJJSc3f4=;
        b=DjwUqxwBLZjf1a9fJIsBpliZNeiSad140/whrcBdMwSWD0TLvehl1lUwqUZWQmfaIj
         bOnGOjNHS6OTS/errIyNtakMrB9QCii8jiYuMPHN2Kj5I2xntdalFmAAinuE4RPWMgfh
         hWsIfuj/rAL8rCS4nH5Y0ULrq9eAd3MhbhwVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owvG08mCzufA5uZoCz7gh3bK+359aJ5DTWVXJJSc3f4=;
        b=jwutcO62wSubcDtTdj1aC1DpQmTSk+uucDtUGQyOQFFuCAdrJ7V5II8kEYmIYcpsVU
         tgduC2BPUBt20A+wI858SweSGPqAibwQUqRuZxM4dl/JkRaOsMMWorBG0D2q7Dyzxxon
         lgu3svCNi0a5t+iPgspRKbTRu0gHm/lc19wsr8SkmjuHMRH4BbiZ4xZOgdLVgS6fuZ8k
         vuM24DL+hgF0a4QE/58K9LolHeu5Gq/39GY8MxPZJfZhZyr2r15FHJIO9ebeyZvRib+2
         bZcT29ZDa4ns3k1d8BZuILiewaoUCwKMJtoJLccpEmeQ9AwtsDVlKn+fqxNosx5VGkZ+
         98qA==
X-Gm-Message-State: ABuFfohtaAarmDDSn94X32Ecp1yOEwj5rUsULnPFCWwfDL6bhLds6RhB
        e4ZONyVpvUBScfxKePn3HWgZWA==
X-Google-Smtp-Source: ACcGV62QGCXofUr5IKML2JRpFmSxWakkBBbKBkBbOO/UHABwp7wG50CN3RF5pfY1tE+7RRnht2CyiA==
X-Received: by 2002:a62:b209:: with SMTP id x9-v6mr51462381pfe.148.1540309859945;
        Tue, 23 Oct 2018 08:50:59 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:50:59 -0700 (PDT)
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
Subject: [PATCH v2 01/15] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
Date:   Tue, 23 Oct 2018 21:20:21 +0530
Message-Id: <20181023155035.9101-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI DPHY gate bit on MIPI DSI clock register is bit 15
not bit 30.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

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

