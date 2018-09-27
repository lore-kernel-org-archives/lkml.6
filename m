Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009FEECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE68A21531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TdBx1pDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE68A21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI0SHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:07:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeI0SHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:07:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so1752698pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLT1GifvrqLqDc26F7zMlTRS3INNzOgCgNw2mNmNj04=;
        b=TdBx1pDQyyeHVrK31tunjMcjPQT/5inOT28qYX7tBrDNOvhX73XmqM+1hI3WBRWReo
         vjBu+YlQ744mFL7gQa6Ls1FFsC8qhjyXIqdUizMoJJEgQN2Q+sSFtiJQsCpQPPRLywpg
         2usYZzKtxRZrTtjbtklXjZbZ4yco2kfDFg7Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLT1GifvrqLqDc26F7zMlTRS3INNzOgCgNw2mNmNj04=;
        b=jyZV/860fxMDHEdVpK8cGiEV6DM67DqrgRPwEbZ8mWnsRhP4szwexYdKiKzQMWu1ak
         gm+v7V+0Afa8httODl164IyngOGMemqkWzeKqTqfLhGehuDSU6Hff4mOnUaCujgXVPdl
         zGS3vBwqHBP9OTwL9cdUXsbyyJEvJ6nOV+cP6aSNbJ2cUiSNxk/nPmolJCC92IkSCA+u
         rlgnmVQcOVTJ/Fg7CwpmBSDKBda4Cw5ezF0jjLO7Grsmf9AuWMoaJcu6nzXAuTqYAob0
         1sDAOaY2eReqArrd6zH6g+QNOsrNBMqjYEiUAKVyn5dakrgJVF6ThAuzk6TpO162F1Bv
         4q/A==
X-Gm-Message-State: ABuFfoj00I4VwdcnFqwsXX3NqMYaz1a2YLX57/E8LvjhWDlE9syEANMm
        u29NYVYyidpAVGgROvz2IrQArg==
X-Google-Smtp-Source: ACcGV615Klfjg0ZeS+7PTDM26zxgDigtBYfLaaLQeqlGQzeGVRDg30jhXyUaG3IBTXXDx1dHAdKpVQ==
X-Received: by 2002:a17:902:6848:: with SMTP id f8-v6mr574090pln.27.1538048961935;
        Thu, 27 Sep 2018 04:49:21 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:49:21 -0700 (PDT)
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
Subject: [PATCH 01/12] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
Date:   Thu, 27 Sep 2018 17:18:39 +0530
Message-Id: <20180927114850.24565-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
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
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 5f80eb018014..b639e79641df 100644
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

