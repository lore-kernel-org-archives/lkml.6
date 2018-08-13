Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893D3C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182C821781
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KkoXoDbj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LtwZFhcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182C821781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeHMQTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:19:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbeHMQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:19:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E81760D9C; Mon, 13 Aug 2018 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167441;
        bh=ow1xX2fPyz8pK8MShOTMpuws8K/wfS6Xi5YwvHfO2JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkoXoDbj9Gswlcn7YZWDcigcSrZcyX+/gJQVmBsjUtg/cLFulgsmW47t7oSNAwv3K
         eqa7LTryXfWHD5EY07SBzhP2t0QjyRT4VwsElbAaV1mcZdaacTbRW0YKKjPVDdTu89
         9OF+rL/Hgd3ctMrFEKjpLGSEuoD7gdswHXtWw04g=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9C8A60D0C;
        Mon, 13 Aug 2018 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167416;
        bh=ow1xX2fPyz8pK8MShOTMpuws8K/wfS6Xi5YwvHfO2JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LtwZFhcvw+G70s3+k+tbTciwi1lBNMK9pJuHHt/eFCFZn8M/u8Lv+yKpa/kF2L2Pu
         3xWObOfOPsFzpBNT2goZUUC2squeeAuOniw6SLhu7OOOP76NjF5azXlbsTqYkfSLtq
         zkhswcF7GUKNyWAI6S1ga7CZawNAAvZvVn2BuQLI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9C8A60D0C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 05/14] clk: qcom: Add MSM8960/APQ8064's HFPLLs
Date:   Mon, 13 Aug 2018 19:05:58 +0530
Message-Id: <1534167367-17545-6-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
References: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Describe the HFPLLs present on MSM8960 and APQ8064 devices.

Acked-by: Rob Herring <robh@kernel.org> (bindings)
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8960.c               | 172 +++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8960.h |   2 +
 2 files changed, 174 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index eb551c7..809f16a 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -30,6 +30,7 @@
 #include "clk-pll.h"
 #include "clk-rcg.h"
 #include "clk-branch.h"
+#include "clk-hfpll.h"
 #include "reset.h"
 
 static struct clk_pll pll3 = {
@@ -86,6 +87,164 @@
 	},
 };
 
+static struct hfpll_data hfpll0_data = {
+	.mode_reg = 0x3200,
+	.l_reg = 0x3208,
+	.m_reg = 0x320c,
+	.n_reg = 0x3210,
+	.config_reg = 0x3204,
+	.status_reg = 0x321c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3214,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll0 = {
+	.d = &hfpll0_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll0",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll0.lock),
+};
+
+static struct hfpll_data hfpll1_8064_data = {
+	.mode_reg = 0x3240,
+	.l_reg = 0x3248,
+	.m_reg = 0x324c,
+	.n_reg = 0x3250,
+	.config_reg = 0x3244,
+	.status_reg = 0x325c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3254,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct hfpll_data hfpll1_data = {
+	.mode_reg = 0x3300,
+	.l_reg = 0x3308,
+	.m_reg = 0x330c,
+	.n_reg = 0x3310,
+	.config_reg = 0x3304,
+	.status_reg = 0x331c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3314,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll1 = {
+	.d = &hfpll1_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll1",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll1.lock),
+};
+
+static struct hfpll_data hfpll2_data = {
+	.mode_reg = 0x3280,
+	.l_reg = 0x3288,
+	.m_reg = 0x328c,
+	.n_reg = 0x3290,
+	.config_reg = 0x3284,
+	.status_reg = 0x329c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3294,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll2 = {
+	.d = &hfpll2_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll2",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll2.lock),
+};
+
+static struct hfpll_data hfpll3_data = {
+	.mode_reg = 0x32c0,
+	.l_reg = 0x32c8,
+	.m_reg = 0x32cc,
+	.n_reg = 0x32d0,
+	.config_reg = 0x32c4,
+	.status_reg = 0x32dc,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x32d4,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll3 = {
+	.d = &hfpll3_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll3",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll3.lock),
+};
+
+static struct hfpll_data hfpll_l2_8064_data = {
+	.mode_reg = 0x3300,
+	.l_reg = 0x3308,
+	.m_reg = 0x330c,
+	.n_reg = 0x3310,
+	.config_reg = 0x3304,
+	.status_reg = 0x331c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3314,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct hfpll_data hfpll_l2_data = {
+	.mode_reg = 0x3400,
+	.l_reg = 0x3408,
+	.m_reg = 0x340c,
+	.n_reg = 0x3410,
+	.config_reg = 0x3404,
+	.status_reg = 0x341c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3414,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll_l2 = {
+	.d = &hfpll_l2_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll_l2",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll_l2.lock),
+};
+
 static struct clk_pll pll14 = {
 	.l_reg = 0x31c4,
 	.m_reg = 0x31c8,
@@ -3112,6 +3271,9 @@ enum {
 	[PMIC_ARB1_H_CLK] = &pmic_arb1_h_clk.clkr,
 	[PMIC_SSBI2_CLK] = &pmic_ssbi2_clk.clkr,
 	[RPM_MSG_RAM_H_CLK] = &rpm_msg_ram_h_clk.clkr,
+	[PLL9] = &hfpll0.clkr,
+	[PLL10] = &hfpll1.clkr,
+	[PLL12] = &hfpll_l2.clkr,
 };
 
 static const struct qcom_reset_map gcc_msm8960_resets[] = {
@@ -3323,6 +3485,11 @@ enum {
 	[PMIC_ARB1_H_CLK] = &pmic_arb1_h_clk.clkr,
 	[PMIC_SSBI2_CLK] = &pmic_ssbi2_clk.clkr,
 	[RPM_MSG_RAM_H_CLK] = &rpm_msg_ram_h_clk.clkr,
+	[PLL9] = &hfpll0.clkr,
+	[PLL10] = &hfpll1.clkr,
+	[PLL12] = &hfpll_l2.clkr,
+	[PLL16] = &hfpll2.clkr,
+	[PLL17] = &hfpll3.clkr,
 };
 
 static const struct qcom_reset_map gcc_apq8064_resets[] = {
@@ -3482,6 +3649,11 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (match->data == &gcc_apq8064_desc) {
+		hfpll1.d = &hfpll1_8064_data;
+		hfpll_l2.d = &hfpll_l2_8064_data;
+	}
+
 	tsens = platform_device_register_data(&pdev->dev, "qcom-tsens", -1,
 					      NULL, 0);
 	if (IS_ERR(tsens))
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8960.h b/include/dt-bindings/clock/qcom,gcc-msm8960.h
index 7d20eed..e02742f 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8960.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8960.h
@@ -319,5 +319,7 @@
 #define CE3_SRC					303
 #define CE3_CORE_CLK				304
 #define CE3_H_CLK				305
+#define PLL16					306
+#define PLL17					307
 
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

