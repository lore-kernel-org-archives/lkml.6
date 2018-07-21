Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE2DECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED9820868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TtukvSSZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZmqR3rdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED9820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeGUTJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:09:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbeGUTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:09:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 20CF260314; Sat, 21 Jul 2018 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532196939;
        bh=2jrd2lK6NCgp/KwTu6+N3zA+aajc3IIBkVAXHnSE9NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtukvSSZaEJ+FiD7Vhz2/r41w3ZY0bNYViCp8qLfXiVpIxfY9qD8ewCT3qBUalJGi
         OvpztbsBSR8bsdbOr9hsdw2Ff4+sN6gBdKNEQ+nD19DwNXpZrOPEaZn83fulZuXfKx
         g62VuAfS2474FhqnhzNfMo/satZ4slghhozhx6G8=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7AE3B6021A;
        Sat, 21 Jul 2018 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532196937;
        bh=2jrd2lK6NCgp/KwTu6+N3zA+aajc3IIBkVAXHnSE9NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmqR3rdJux+aYjTSLMroK5rluApGwTGGIgsv4D1/6xiBtgHsiXtSUK9iCrEasVkWh
         TRWVr22h+OWfsUqybJ3PTyJS4hZCwT9D+9wL5skFLsUCUJG7iiqOz6GPTbYjcHXmL8
         rsY4owA9lg6o86I/Xrh2zPQH9GAP8hUtoYxiq9yA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AE3B6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        grahamr@qti.qualcomm.com, Taniya Das <tdas@codeaurora.org>
Subject: [RFC PATCH 4/4] clk: qcom: sdm845: Add Power Domain to RCGs and PLL
Date:   Sat, 21 Jul 2018 23:45:02 +0530
Message-Id: <1532196902-28570-5-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532196902-28570-1-git-send-email-tdas@codeaurora.org>
References: <1532196902-28570-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test code for GCC Power Domain Voting for root clocks/plls.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi |  2 +
 drivers/clk/qcom/gcc-sdm845.c        | 83 +++++++++++++++++++++++++++++-------
 drivers/clk/qcom/vdd-level.h         | 31 ++++++++++++++
 3 files changed, 101 insertions(+), 15 deletions(-)
 create mode 100644 drivers/clk/qcom/vdd-level.h

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 00722b5..742f72a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -247,6 +247,8 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_CX_AO>;
 		};

 		qupv3_id_0: geniqup@8c0000 {
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 0f694ed..60225c1 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -24,6 +24,11 @@
 #include "clk-alpha-pll.h"
 #include "gdsc.h"
 #include "reset.h"
+#include "clk-pd.h"
+#include "vdd-level.h"
+
+#include <linux/delay.h>
+#include <linux/clk.h>

 #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }

@@ -162,12 +167,22 @@ enum {
 	"core_bi_pll_test_se",
 };

+static CLK_POWERDOMAIN_INIT(vdd_cx, VDD_NUM, 1, vdd_corner);
+static CLK_POWERDOMAIN_INIT(vdd_cx_ao, VDD_NUM, 1, vdd_corner);
+
 static struct clk_alpha_pll gpll0 = {
 	.offset = 0x0,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(0),
+		.pd = &vdd_cx,
+		.rate_max = (unsigned long[VDD_NUM]) {
+			[VDD_MIN] = 615000000,
+			[VDD_LOW] = 1066000000,
+			[VDD_LOW_L1] = 1600000000,
+			[VDD_NOMINAL] = 2000000000,
+		},
 		.hw.init = &(struct clk_init_data){
 			.name = "gpll0",
 			.parent_names = (const char *[]){ "bi_tcxo" },
@@ -183,6 +198,13 @@ enum {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(4),
+		.pd = &vdd_cx,
+		.rate_max = (unsigned long[VDD_NUM]) {
+			[VDD_MIN] = 615000000,
+			[VDD_LOW] = 1066000000,
+			[VDD_LOW_L1] = 1600000000,
+			[VDD_NOMINAL] = 2000000000,
+		},
 		.hw.init = &(struct clk_init_data){
 			.name = "gpll4",
 			.parent_names = (const char *[]){ "bi_tcxo" },
@@ -226,11 +248,20 @@ enum {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_names = gcc_parent_names_7,
-		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+	.clkr = {
+	/*	.pd = &vdd_cx_ao,  Remove this for testing */
+		.pd = &vdd_cx,
+		.rate_max = (unsigned long[VDD_NUM]) {
+			[VDD_MIN] = 19200000,
+			[VDD_LOW] = 50000000,
+			[VDD_NOMINAL] = 100000000,
+		},
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_cpuss_ahb_clk_src",
+			.parent_names = gcc_parent_names_7,
+			.num_parents = 4,
+			.ops = &clk_rcg2_ops,
+		},
 	},
 };

@@ -268,11 +299,20 @@ enum {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_gp1_clk_src",
-		.parent_names = gcc_parent_names_1,
-		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+	.clkr = {
+		.pd = &vdd_cx_ao,
+		.rate_max = (unsigned long[VDD_NUM]) {
+			[VDD_MIN] = 19200000,
+			[VDD_LOWER] = 50000000,
+			[VDD_LOW] = 100000000,
+			[VDD_NOMINAL] = 200000000,
+		},
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gp1_clk_src",
+			.parent_names = gcc_parent_names_1,
+			.num_parents = 5,
+			.ops = &clk_rcg2_ops,
+		},
 	},
 };

@@ -282,11 +322,20 @@ enum {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_gp2_clk_src",
-		.parent_names = gcc_parent_names_1,
-		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+	.clkr = {
+		.pd = &vdd_cx,
+		.rate_max = (unsigned long[VDD_NUM]) {
+			[VDD_MIN] = 19200000,
+			[VDD_LOWER] = 50000000,
+			[VDD_LOW] = 100000000,
+			[VDD_NOMINAL] = 200000000,
+		},
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gp2_clk_src",
+			.parent_names = gcc_parent_names_1,
+			.num_parents = 5,
+			.ops = &clk_rcg2_ops,
+		},
 	},
 };

@@ -3472,6 +3521,10 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);

+	/* Indexes of the power domain */
+	vdd_cx.pd_index[0] = 0;
+	vdd_cx_ao.pd_index[0] = 1;
+
 	return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
 }

diff --git a/drivers/clk/qcom/vdd-level.h b/drivers/clk/qcom/vdd-level.h
new file mode 100644
index 0000000..7de65142
--- /dev/null
+++ b/drivers/clk/qcom/vdd-level.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef __DRIVERS_CLK_QCOM_VDD_LEVEL_H
+#define __DRIVERS_CLK_QCOM_VDD_LEVEL_H
+
+#include <dt-bindings/power/qcom-rpmpd.h>
+
+enum vdd_levels {
+	VDD_NONE,
+	VDD_MIN,	/* MIN SVS */
+	VDD_LOWER,	/* SVS2 */
+	VDD_LOW,	/* SVS */
+	VDD_LOW_L1,	/* SVSL1 */
+	VDD_NOMINAL,	/* NOM */
+	VDD_HIGH,	/* TURBO */
+	VDD_NUM,
+};
+
+static int vdd_corner[] = {
+	RPMH_REGULATOR_LEVEL_RETENTION,	/* VDD_NONE */
+	RPMH_REGULATOR_LEVEL_MIN_SVS,	/* VDD_MIN */
+	RPMH_REGULATOR_LEVEL_LOW_SVS,	/* VDD_LOWER */
+	RPMH_REGULATOR_LEVEL_SVS,	/* VDD_LOW */
+	RPMH_REGULATOR_LEVEL_SVS_L1,	/* VDD_LOW_L1 */
+	RPMH_REGULATOR_LEVEL_NOM,	/* VDD_NOMINAL */
+	RPMH_REGULATOR_LEVEL_TURBO,	/* VDD_HIGH */
+};
+
+#endif
+
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

