Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5B2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F5320850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bRpFOgws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F5320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeGRLcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:32:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46960 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeGRLcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:32:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id l123-v6so2014029pfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aS0R/TfkevDrS2zrgOVE3mC2tHeBQtHUwt/i9SJ6RdQ=;
        b=bRpFOgwsjxueMyoRklMpe6OyzlctIVML7jQ2K122JHIHQlkTrL7FDk8DfztJSKc1ZU
         F/eE8DhKQ55Up9ADd/V/wmhV4DTOzN/sNneVYXUiZvNxGVX2f1y8pMX42yLtCm8lDsMd
         S6ScFR4KdXRx+UWBeQv9UFXyL437ybhFh9xKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aS0R/TfkevDrS2zrgOVE3mC2tHeBQtHUwt/i9SJ6RdQ=;
        b=iMyuKJOWmMPCIyrqH0ruWLxHIx9wq68ICWPSUi7LEJcai7qNN0F7NuuXTH1epsLTRK
         l4xQi8Y85t/tXWndv5uzhtJtYzadWCw0ckUdNgrwnOQ8MjjZGKaD8b/P56O4Vxl4MaxE
         OH9+XJ7hbs4MsjYbSDH90/wjSnr/P5N5cxF9Q3ShoCASxz0qvW+PF/WqX1rinBkG/J7x
         3w31UPWPI3l5VpMY6chCasAo9hLs3WC+9zyu9NnqwqoEiAns51BpnB8/TVGSfRgWCGEA
         zYdj1uyzVgDhVeNrHGkjTQV9grYGLyKoZXgQwO98BPIC8uh2QgSoAakhyPCqkcUhtMxD
         jDqA==
X-Gm-Message-State: AOUpUlG+0ZQnQ8XJfGLyX/vYzi+OPcOe++OU+e6vTXrVYFsoac1pFqou
        5JQ0npuibTQPCRqk4Xvjb+SRdQ==
X-Google-Smtp-Source: AAOMgpexv8XeWifkwa8eM7i0s4XNhCvlsvMMmLUA8TXbdBnNATebixVwUROGtBNsWgG/eOPOmTpmxA==
X-Received: by 2002:a63:3046:: with SMTP id w67-v6mr878042pgw.176.1531911323248;
        Wed, 18 Jul 2018 03:55:23 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:55:22 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
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
Subject: [PATCH v3 01/18] clk: sunxi-ng: a64: Add minimal rate for video PLLs
Date:   Wed, 18 Jul 2018 16:24:41 +0530
Message-Id: <20180718105458.22304-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation and experience with other similar SoCs, video
PLLs don't work stable if their output frequency is set below 192 MHz.

Because of that, set minimal rate to both A64 video PLLs to 192 MHz.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none 
Changes for v2:
- New patch

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 46 ++++++++++++++-------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index ee9c12cf3f08..d0e30192f0cf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -64,17 +64,18 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				   BIT(28),	/* lock */
 				   CLK_SET_RATE_UNGATE);
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video0_clk, "pll-video0",
-					"osc24M", 0x010,
-					8, 7,		/* N */
-					0, 4,		/* M */
-					BIT(24),	/* frac enable */
-					BIT(25),	/* frac select */
-					270000000,	/* frac rate 0 */
-					297000000,	/* frac rate 1 */
-					BIT(31),	/* gate */
-					BIT(28),	/* lock */
-					CLK_SET_RATE_UNGATE);
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(pll_video0_clk, "pll-video0",
+					    "osc24M", 0x010,
+					    192000000,	/* Minimum rate */
+					    8, 7,		/* N */
+					    0, 4,		/* M */
+					    BIT(24),	/* frac enable */
+					    BIT(25),	/* frac select */
+					    270000000,	/* frac rate 0 */
+					    297000000,	/* frac rate 1 */
+					    BIT(31),	/* gate */
+					    BIT(28),	/* lock */
+					    CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x018,
@@ -125,17 +126,18 @@ static struct ccu_nk pll_periph1_clk = {
 	},
 };
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video1_clk, "pll-video1",
-					"osc24M", 0x030,
-					8, 7,		/* N */
-					0, 4,		/* M */
-					BIT(24),	/* frac enable */
-					BIT(25),	/* frac select */
-					270000000,	/* frac rate 0 */
-					297000000,	/* frac rate 1 */
-					BIT(31),	/* gate */
-					BIT(28),	/* lock */
-					CLK_SET_RATE_UNGATE);
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(pll_video1_clk, "pll-video1",
+					    "osc24M", 0x030,
+					    192000000,	/* Minimum rate */
+					    8, 7,		/* N */
+					    0, 4,		/* M */
+					    BIT(24),	/* frac enable */
+					    BIT(25),	/* frac select */
+					    270000000,	/* frac rate 0 */
+					    297000000,	/* frac rate 1 */
+					    BIT(31),	/* gate */
+					    BIT(28),	/* lock */
+					    CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					"osc24M", 0x038,
-- 
2.17.1

