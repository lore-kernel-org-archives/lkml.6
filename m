Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F97FC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F320221873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hkI8oW4q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="osgzGObj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeLRST5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:19:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeLRST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:19:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D173560736; Tue, 18 Dec 2018 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545157195;
        bh=LNgzGpUiFLm/ygBsRDMZrqTlO/PVw7/BSolccWEjytg=;
        h=From:To:Cc:Subject:Date:From;
        b=hkI8oW4qxHPXt3E68xtnS7deJ8wthfqy2SRHvpae2vwGiMZpUWJbOQf0AaNTb4OgI
         oxL6zE2xUVG1zpYSFojNb6P+oKbXGv/Nt6kkRDXPr4bwh1hmlrJzOtbDlTRJNFiFfi
         spOWac0r/H/0ImohzA2uPGA6EC+97YDMfOGIDPT8=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D6696021A;
        Tue, 18 Dec 2018 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545157194;
        bh=LNgzGpUiFLm/ygBsRDMZrqTlO/PVw7/BSolccWEjytg=;
        h=From:To:Cc:Subject:Date:From;
        b=osgzGObj0gYD4MWe+jfVeCt0qzI/aDf/MRGmof310LMvZy7MqSCrpQs2vuzXMJM2+
         g+WySwspROE178Qy0QcmwUFGm1qBklnsF1ziPCyvITfxoH4SCaNRz7hzh3QVhLl2UB
         EJcYEpvivwSKkhv8aacaFoAwWsnAuEbyGZSP70Ms=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D6696021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] clk: qcom: gcc: Use active only source for CPUSS clocks
Date:   Tue, 18 Dec 2018 23:49:41 +0530
Message-Id: <1545157181-27095-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks of the CPUSS such as "gcc_cpuss_ahb_clk_src" is a CRITICAL
clock and needs to vote on the active only source of XO, so as to keep the
vote as long as CPUSS is active. Similar rbcpr_clk_src is also has the same
requirement.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index c782e62..58fa5c2 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -115,8 +115,8 @@ enum {
 	"core_bi_pll_test_se",
 };

-static const char * const gcc_parent_names_7[] = {
-	"bi_tcxo",
+static const char * const gcc_parent_names_7_ao[] = {
+	"bi_tcxo_ao",
 	"gpll0",
 	"gpll0_out_even",
 	"core_bi_pll_test_se",
@@ -128,6 +128,12 @@ enum {
 	"core_bi_pll_test_se",
 };

+static const char * const gcc_parent_names_8_ao[] = {
+	"bi_tcxo_ao",
+	"gpll0",
+	"core_bi_pll_test_se",
+};
+
 static const struct parent_map gcc_parent_map_10[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
@@ -210,7 +216,7 @@ enum {
 	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_names = gcc_parent_names_7,
+		.parent_names = gcc_parent_names_7_ao,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -229,7 +235,7 @@ enum {
 	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_rbcpr_clk_src",
-		.parent_names = gcc_parent_names_8,
+		.parent_names = gcc_parent_names_8_ao,
 		.num_parents = 3,
 		.ops = &clk_rcg2_ops,
 	},
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

