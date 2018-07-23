Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A2520854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oJANRBgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A2520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbeGWW5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:57:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41684 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388228AbeGWW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:57:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so352031pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OcJAee3cdd0GwYh1ij0y6A/aT86+kBdXYoDfzCL9WVo=;
        b=oJANRBgw9vJSxuKGlspyJp+Ana1l3doAmQSBe17A7y8egWZrBy04BHG8hc4kmzjujb
         BFDt7NMiNggrmdPQpargJccT5xgNoI4QhQeJ3ufDcqYR0+LMQwC6vPw9AGSa+LvE/yo+
         X0/4r4pSl8fGjUyDjcryT/JTpBsv8+eLhjFSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OcJAee3cdd0GwYh1ij0y6A/aT86+kBdXYoDfzCL9WVo=;
        b=i0EOaHZvKAjhv/e3NdrAiXm1bICX7BMLKTVgDyO8/Qhj6WR4LKF/cLULOKSeVPsW2Y
         NF3nUT+8FxI9Rw+in18T4KSP/F8HKNxemBHMmJgijZX+nYiWGsWz5hVsKnfw/nCD2MIl
         VIh5f3gbwt9TvsbLhfSHPsArzcWCml6yw2ZJhq7Q5KfGnGB3vxFFgD8pOyeTZ2UtqkBe
         aCxLGPt9kYSXZFY13O9J81z/jVuhiGoTk6rMN03WFim/Fs+irfFy6up0DPk6k8lkbDaa
         G0+seusQPswZ8hestYzINb00OSunJABtA9VD4qtQXxO0nVfmAsHC3bnnjJIsrFuGDOMQ
         enjQ==
X-Gm-Message-State: AOUpUlHVK9t1NPemVslcMOzNfOG8VMpx1AJviH4Rm4nsnH2SyJ/B2X0R
        dGc+z7WWb7C+SGY0QIqY9cBE1Q2jW2s=
X-Google-Smtp-Source: AAOMgpd61OtegwI3b8TJ83kjKn86OmKlrEtLn39BYbywv/DzcywfWBww2aW30Y7x8+vt7DJPyi01Sw==
X-Received: by 2002:a63:b705:: with SMTP id t5-v6mr13916488pgf.45.1532382874415;
        Mon, 23 Jul 2018 14:54:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id n26-v6sm5927629pgv.78.2018.07.23.14.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:54:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, grahamr@codeaurora.org,
        girishm@codeaurora.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
Date:   Mon, 23 Jul 2018 14:54:04 -0700
Message-Id: <20180723215404.74296-3-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180723215404.74296-1-dianders@chromium.org>
References: <20180723215404.74296-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both the interface and core clock.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only 19.2, 100, 150, and 300 MHz now.
- All clocks come from MAIN rather than EVEN.
- Use parent map 0 instead of new parent map 9.

 drivers/clk/qcom/gcc-sdm845.c | 63 +++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 0f694ed4238a..5bca634e277a 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -162,6 +162,13 @@ static const char * const gcc_parent_names_10[] = {
 	"core_bi_pll_test_se",
 };
 
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
@@ -358,6 +365,28 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_gcc_qspi_core_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_qspi_core_clk_src = {
+	.cmd_rcgr = 0x4b008,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
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
@@ -1935,6 +1964,37 @@ static struct clk_branch gcc_qmip_video_ahb_clk = {
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
@@ -3383,6 +3443,9 @@ static struct clk_regmap *gcc_sdm845_clocks[] = {
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

