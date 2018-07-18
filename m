Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5859ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD9F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/1+aRpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD9F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeGRSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:44:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37449 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeGRSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:44:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id a26-v6so2567826pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DHdw+VSD8awo56Z5wZiJk2ihD0O4WYGT6u8SSXDUxd4=;
        b=W/1+aRpKSic6BvVUCWro5uIxZLtdiBRh9KCBXm1QAbnGptTn4Jtsc0PbqADIOKbkqa
         l6f5xr0OsYWkhxN4+jPvWlGnSydIft9gT67NJ6BhN5bntldewfvfef2AlRooJgYrBbCj
         Od22EYX9QW1Hhp8HPBByjChwrZKUd+A87FY/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DHdw+VSD8awo56Z5wZiJk2ihD0O4WYGT6u8SSXDUxd4=;
        b=k10HhmllxDvl4AWvYIv+45xGOwb+M8kKOxkMakcPecDT8Iig52Mj1NT3fPPSjAb+XT
         oOBxOve+VLU0uHlj1CBw0IrBlTQGCWqHVDgPIcht0aHS2foPgrOnGBpsAVyKf+f3pkrI
         gsQaaRTqiiTHoRx7d8RyaWhRj+bbsoW4Hl4N4j9rQKYAXOh9tAUIJ5AdF5sk9fwkgNjx
         Rzyp3LrJnNayX8FjQWIp1zk7ulHxbwC8xOvBAfjx7ojM9mHPJSlkP/RAEoIZqCulzyQE
         l5tg+a7fnyHphXNr3IEpWoBpJ+k3RYSUp68bCh56yV4jTus6bYQIq8pYe+mrSzWHrVON
         uw8w==
X-Gm-Message-State: AOUpUlEDMLjh8Qk5D89fQSfgXf+BxcCE9K3s9pMw6qN4sohyjHY1aRBj
        u6dQa8IJGuJL1TgKemu8LtVu8Q==
X-Google-Smtp-Source: AAOMgpdInpo3MbCxyWg18uLpBwSM1aUoYdoxH+cplHnr1n0ZIEpgYW7S2ydeWWXQ8qwkHeIQ0n8uqw==
X-Received: by 2002:a63:5350:: with SMTP id t16-v6mr6634751pgl.196.1531937125791;
        Wed, 18 Jul 2018 11:05:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id f5-v6sm12818857pga.58.2018.07.18.11.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 11:05:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, girishm@codeaurora.org,
        anischal@codeaurora.org, bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
Date:   Wed, 18 Jul 2018 11:04:30 -0700
Message-Id: <20180718180431.48580-3-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180718180431.48580-1-dianders@chromium.org>
References: <20180718180431.48580-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both the interface and core clock.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/qcom/gcc-sdm845.c | 73 +++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 0f694ed4238a..2ee96f9bc217 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -162,6 +162,20 @@ static const char * const gcc_parent_names_10[] = {
 	"core_bi_pll_test_se",
 };
 
+static const struct parent_map gcc_parent_map_9[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL0_OUT_EVEN, 6 },
+	{ P_SLEEP_CLK, 7 },
+};
+
+static const char * const gcc_parent_names_9[] = {
+	"bi_tcxo",
+	"gpll0",
+	"gpll0_out_even",
+	"core_pi_sleep_clk",
+};
+
 static struct clk_alpha_pll gpll0 = {
 	.offset = 0x0,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
@@ -358,6 +372,31 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_gcc_qspi_core_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
+	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
+	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
+	F(150000000, P_GPLL0_OUT_EVEN, 2, 0, 0),
+	F(300000000, P_GPLL0_OUT_EVEN, 1, 0, 0),
+	F(400000000, P_GPLL0_OUT_MAIN, 1.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_qspi_core_clk_src = {
+	.cmd_rcgr = 0x4b008,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_9,
+	.freq_tbl = ftbl_gcc_qspi_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gcc_qspi_core_clk_src",
+		.parent_names = gcc_parent_names_9,
+		.num_parents = 4,
+		.ops = &clk_rcg2_floor_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
 	F(9600000, P_BI_TCXO, 2, 0, 0),
 	F(19200000, P_BI_TCXO, 1, 0, 0),
@@ -1935,6 +1974,37 @@ static struct clk_branch gcc_qmip_video_ahb_clk = {
 	},
 };
 
+static struct clk_branch gcc_qspi_cnoc_periph_ahb_clk = {
+	.halt_reg = 0x4b000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4b000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_qspi_cnoc_periph_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qspi_core_clk = {
+	.halt_reg = 0x4b004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4b004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_qspi_core_clk",
+			.parent_names = (const char *[]){
+				"gcc_qspi_core_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
 	.halt_reg = 0x17030,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -3383,6 +3453,9 @@ static struct clk_regmap *gcc_sdm845_clocks[] = {
 	[GPLL4] = &gpll4.clkr,
 	[GCC_CPUSS_DVM_BUS_CLK] = &gcc_cpuss_dvm_bus_clk.clkr,
 	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
+	[GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
+	[GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
+	[GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_sdm845_resets[] = {
-- 
2.18.0.233.g985f88cf7e-goog

