Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F1320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImysuCnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F1320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeGSOGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:06:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44096 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731842AbeGSOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:05:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so7448878ljq.11;
        Thu, 19 Jul 2018 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQTRny113LNxRmec6/bLm6uD/H077n6KTOjiQBp4Z2E=;
        b=ImysuCnxjnONLCLMs2o22bUfWnWkxZ7xAqrNFzsiHTlIBTNumCNGADwVx1+JZg6yPh
         VP0uONv/f1ilnGQ/bfXceYazfGrGDMiSFLaRt7QKDDuX4F8ThwBi8DLvncHFY3zUJkej
         VaXeisj9a6BrCZsjBJ1IiY0QabE2sC3/RNV7YiYXon56Qny9dynDnGqc6KmgGbTSw0Rn
         cLsMdLOefLld0XwvQDLz3PeDhpjFoth3u0j8eroHwQcGHaTUNJ8ccdHpSfhXTtvl9tYO
         /7D9vqT1CPxee4s6jR7rxEZVV2zAyEvG+KVigL4FMq76B2xfjRAzXQ2Xf45LMQ5wtkQ8
         A0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQTRny113LNxRmec6/bLm6uD/H077n6KTOjiQBp4Z2E=;
        b=M41uLjxJBrjO6FSJ2aPC6xsrnJEru8YzjLXEZKrnCnG8fTMrZMyiZ1jmXMJMqL2ver
         go0IHpPfh14tPKEvENOOdBDyToQdNCorw1JesifZi509XL0RFiNktL1iVbTy3RESAhfo
         4JlvPFkMwu4ImOvxp6VO/XQh4B2hBCgeTlDdUMrwOHiYqSXIxiT3uHg4q28Dy96fnBvG
         SeIrMHd/AZvp0RzyNXvhbqz3Fj45WeDSvI95LTOV09GbSg6n8NnAEfnuJKlIbqbtsMzI
         pEFKgGvQEvX+owmDn7NX//8SBBxbVr4IXS1weOx5kvV/gGlNob4fJmOk3baKKTUDFuYw
         4RSQ==
X-Gm-Message-State: AOUpUlHUqnhFWfUZDHfKT7nckRskH9pCCk1u9H9vc1phkHLNMFpp+ght
        j0a7+pCdca3J1bFAj8BfphU=
X-Google-Smtp-Source: AAOMgpeQX+45OePCxhxrcBMsFVl2i5tI/svKtqejyfV5gW0mSe1zkB1GKRJ0qAA26hsQ0rJNyLjaUw==
X-Received: by 2002:a19:7403:: with SMTP id v3-v6mr3050376lfe.97.1532006557234;
        Thu, 19 Jul 2018 06:22:37 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1109592ljc.67.2018.07.19.06.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:22:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] clk: tegra20: Turn EMC clock gate into divider
Date:   Thu, 19 Jul 2018 16:21:30 +0300
Message-Id: <20180719132132.16153-7-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719132132.16153-1-digetx@gmail.com>
References: <20180719132132.16153-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel should never gate the EMC clock as it causes immediate lockup, so
removing clk-gate functionality doesn't affect anything. Turning EMC clk
gate into divider allows to implement glitch-less EMC scaling, avoiding
reparenting to a backup clock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra20.c | 36 ++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cc857d4d4a86..ebea97016d58 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -578,7 +578,6 @@ static struct tegra_clk tegra20_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_afi] = { .dt_id = TEGRA20_CLK_AFI, .present = true },
 	[tegra_clk_fuse] = { .dt_id = TEGRA20_CLK_FUSE, .present = true },
 	[tegra_clk_kfuse] = { .dt_id = TEGRA20_CLK_KFUSE, .present = true },
-	[tegra_clk_emc] = { .dt_id = TEGRA20_CLK_EMC, .present = true },
 };
 
 static unsigned long tegra20_clk_measure_input_freq(void)
@@ -799,6 +798,31 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 	TEGRA_INIT_DATA_NODIV("disp2",	mux_pllpdc_clkm, CLK_SOURCE_DISP2, 30, 2, 26,  0, TEGRA20_CLK_DISP2),
 };
 
+static void __init tegra20_emc_clk_init(void)
+{
+	struct clk *clk;
+
+	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
+			       ARRAY_SIZE(mux_pllmcp_clkm),
+			       CLK_SET_RATE_NO_REPARENT,
+			       clk_base + CLK_SOURCE_EMC,
+			       30, 2, 0, &emc_lock);
+
+	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
+				    &emc_lock);
+	clks[TEGRA20_CLK_MC] = clk;
+
+	/*
+	 * Note that 'emc_mux' source and 'emc' rate shouldn't be changed at
+	 * the same time due to a HW bug, this won't happen because we're
+	 * defining 'emc_mux' and 'emc' as distinct clocks.
+	 */
+	clk = clk_register_divider(NULL, "emc", "emc_mux", CLK_IS_CRITICAL,
+				   clk_base + CLK_SOURCE_EMC, 0, 7,
+				   0, &emc_lock);
+	clks[TEGRA20_CLK_EMC] = clk;
+}
+
 static void __init tegra20_periph_clk_init(void)
 {
 	struct tegra_periph_init_data *data;
@@ -812,15 +836,7 @@ static void __init tegra20_periph_clk_init(void)
 	clks[TEGRA20_CLK_AC97] = clk;
 
 	/* emc */
-	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
-			       clk_base + CLK_SOURCE_EMC,
-			       30, 2, 0, &emc_lock);
-
-	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
-				    &emc_lock);
-	clks[TEGRA20_CLK_MC] = clk;
+	tegra20_emc_clk_init();
 
 	/* dsi */
 	clk = tegra_clk_register_periph_gate("dsi", "pll_d", 0, clk_base, 0,
-- 
2.18.0

