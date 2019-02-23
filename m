Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F61C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C384D20855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955904;
	bh=0SxXURlF+Br8MWQYVTHLQnwpZ0lu5NMYcqFaK4DHWPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Gf0G8gqXktTQrITt/820gRf9vtRCSH8B2q1aBLdGU2knX89XTDvhEHujOJp8fsYH
	 GdOly9TnXsGeCqgSfbeBmtfeXRsTuHBqOAg506wtPVDy+UExJIdMxOh4S22WoTRQmb
	 1hWw82dm6i3wIcelNE9xLNsgn6ZsiMinFQigCcwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfBWVFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfBWVEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:04:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D467D20657;
        Sat, 23 Feb 2019 21:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955894;
        bh=0SxXURlF+Br8MWQYVTHLQnwpZ0lu5NMYcqFaK4DHWPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2sWqQAmRjX95zC/D4XM5kceMWxpSRN0jFw6m6cCPgdWJKSdmhhmZzQJ+vAP+T58Mb
         0oXZMrJKkkYBDWDdLdJDlcGIHuKMPlsIKe0+y5NrxbF+7Du2HdciqXYiYu1Xwdjzj4
         oyazMU/Arfu/OGvAbqSD1BcY+a03ANX8Z3YYIdBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taniya Das <tdas@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 20/72] clk: qcom: gcc: Use active only source for CPUSS clocks
Date:   Sat, 23 Feb 2019 16:03:30 -0500
Message-Id: <20190223210422.199966-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
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
index f133b7f5652fb..26110e74e086d 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -115,8 +115,8 @@ static const char * const gcc_parent_names_6[] = {
 	"core_bi_pll_test_se",
 };
 
-static const char * const gcc_parent_names_7[] = {
-	"bi_tcxo",
+static const char * const gcc_parent_names_7_ao[] = {
+	"bi_tcxo_ao",
 	"gpll0",
 	"gpll0_out_even",
 	"core_bi_pll_test_se",
@@ -128,6 +128,12 @@ static const char * const gcc_parent_names_8[] = {
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
@@ -210,7 +216,7 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_names = gcc_parent_names_7,
+		.parent_names = gcc_parent_names_7_ao,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -229,7 +235,7 @@ static struct clk_rcg2 gcc_cpuss_rbcpr_clk_src = {
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

