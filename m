Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D2120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ti3PBuRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D2120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbeGXSxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:53:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35129 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGXSxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:53:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so3399507pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9M1f0vmM1jcAf8046vWNhmE8pQ1/MUTcKZlaenPTYic=;
        b=Ti3PBuRorsT9/zqC3i6HC/o/23A2HTcIeh3YDzr/QzuC5qSC5AQseiaYef0mt6YVTY
         lViKA/rjyeD35BaoEWazGhw7FDvtLr4mUUffqkVKMSSUt7r85sP/iK5/Ll41OqRlZEdm
         gTu1kVLfYyz05VP7gTPXcSaDDqsyHaF+f7Tuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9M1f0vmM1jcAf8046vWNhmE8pQ1/MUTcKZlaenPTYic=;
        b=YOiYBUrCt8gqo/V5Y108vMvWbGlYLhMP4qWoHx/fnb2Lo13Cd+/LrzUzlPK0+uEJCc
         h1Re6S7UfD0U+eCMGgv+BcXBnihiSBbSHB24JNojdNjRhTDZEKLOezAkqXJDlri6uZx7
         bJ/gOraSeZrlvHUVeBmszURCN7wuJtpl/2StGr0XOmAw+vPrawn8gn9UxVAuqlhr0/vn
         dm2vsP/DKQV94kV8le9MD2Q7taoqK71rZVqKi9eFwXSbdh0fn4m4xoEfqfkMaVwtaH7d
         mbHW3CMh6Cqno8O+BXfXrl8EekcT32hrUVXpX+axjUm+CNXJShfQJi51yOpwy62JNJR3
         TzXQ==
X-Gm-Message-State: AOUpUlG9+uXDQQzDZZuX0PEAlFPPHtqjvNSxZotPGLNzGAyYNHiCdy/H
        NYgFtgj6NLZsBg867fMknqiBfw==
X-Google-Smtp-Source: AAOMgpexvMRx4hDW0qo9HMeqWGIuRpLTkVgc/nE1YKxleCXW00FQpf52kdL4vciNNeeqOKFTYG8X6g==
X-Received: by 2002:a62:b20c:: with SMTP id x12-v6mr18995449pfe.64.1532454343669;
        Tue, 24 Jul 2018 10:45:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id b62-v6sm34278653pfm.97.2018.07.24.10.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 10:45:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, girishm@codeaurora.org,
        linux-arm-msm@vger.kernel.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org, grahamr@codeaurora.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>
Subject: [PATCH v3 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
Date:   Tue, 24 Jul 2018 10:45:13 -0700
Message-Id: <20180724174513.174018-3-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180724174513.174018-1-dianders@chromium.org>
References: <20180724174513.174018-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both the interface and core clock.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
(am from https://lore.kernel.org/patchwork/patch/966680/mbox)

---

Changes in v3:
- Removed gcc_parent_names_9 which I had left in (doh!).

Changes in v2:
- Only 19.2, 100, 150, and 300 MHz now.
- All clocks come from MAIN rather than EVEN.
- Use parent map 0 instead of new parent map 9.

 drivers/clk/qcom/gcc-sdm845.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 0f694ed4238a..fc1c6658ad82 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -358,6 +358,28 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
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
+		.parent_names = gcc_parent_names_0,
+		.num_parents = 4,
+		.ops = &clk_rcg2_floor_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
 	F(9600000, P_BI_TCXO, 2, 0, 0),
 	F(19200000, P_BI_TCXO, 1, 0, 0),
@@ -1935,6 +1957,37 @@ static struct clk_branch gcc_qmip_video_ahb_clk = {
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
@@ -3383,6 +3436,9 @@ static struct clk_regmap *gcc_sdm845_clocks[] = {
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

