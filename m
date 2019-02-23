Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF138C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03720652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957238;
	bh=xw0FXe1Bs2Wv3qb2e9hhR+PzJMOUSwat9clVu0Sbx10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HCLrlHgq04IsFilCcNz/ZQiszrGfYc2EeuOfVMk51A8hrw1wf2kE8p5Zy25O2TiHH
	 CY8OYAh/sKsRV8Qbw6ZChKtym2anmQFAbmyp30YeNbamXC/0iacLyLaKbhW5dqppNg
	 JX9Qo7VSBML4qLPd2qGOID6gv35f9xHkVgk5mlig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfBWV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfBWVHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6194820861;
        Sat, 23 Feb 2019 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956025;
        bh=xw0FXe1Bs2Wv3qb2e9hhR+PzJMOUSwat9clVu0Sbx10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URYVKG9JBotj5YPAtuKpNpaJf+jhiyMFmQ6WTjRx7zejiJX6M7GWLgXmjNOeScKCu
         LaUvJ/qWz/0Pi9/YpRFFtdSMx13HhtSbztFsaLnVuzytv2wbRuRhTZJVnjg3CXbJsB
         tnzvtYKdZzFY1O7vgDbXfzrlo0uC+mTQg7BXXMwg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taniya Das <tdas@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/65] clk: qcom: gcc: Use active only source for CPUSS clocks
Date:   Sat, 23 Feb 2019 16:05:52 -0500
Message-Id: <20190223210640.200911-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

[ Upstream commit 9ff1a3b4912528f853048ccd9757ba6a2cc75557 ]

The clocks of the CPUSS such as "gcc_cpuss_ahb_clk_src" is a CRITICAL
clock and needs to vote on the active only source of XO, so as to keep
the vote as long as CPUSS is active. Similar rbcpr_clk_src is also has
the same requirement.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver for SDM845")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index fa1a196350f15..3bf11a6200942 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -131,8 +131,8 @@ static const char * const gcc_parent_names_6[] = {
 	"core_bi_pll_test_se",
 };
 
-static const char * const gcc_parent_names_7[] = {
-	"bi_tcxo",
+static const char * const gcc_parent_names_7_ao[] = {
+	"bi_tcxo_ao",
 	"gpll0",
 	"gpll0_out_even",
 	"core_bi_pll_test_se",
@@ -144,6 +144,12 @@ static const char * const gcc_parent_names_8[] = {
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
@@ -226,7 +232,7 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_names = gcc_parent_names_7,
+		.parent_names = gcc_parent_names_7_ao,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -245,7 +251,7 @@ static struct clk_rcg2 gcc_cpuss_rbcpr_clk_src = {
 	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_rbcpr_clk_src",
-		.parent_names = gcc_parent_names_8,
+		.parent_names = gcc_parent_names_8_ao,
 		.num_parents = 3,
 		.ops = &clk_rcg2_ops,
 	},
-- 
2.19.1

