Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBACC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350BD20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="exlzwDBv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZZGzjGLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350BD20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeLMQo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:44:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeLMQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:44:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9BABB6071A; Thu, 13 Dec 2018 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544719468;
        bh=HfqVVxA71rjyRwHgyZk8YKiBoDalmd4CQn13qw4F8BU=;
        h=From:To:Cc:Subject:Date:From;
        b=exlzwDBvt+GE/Yeind13OGJ/wQmsBD2p4GjOvZMzWg894rMAYAtIb2wySvUzO1QWi
         sDdCd+b8WhXYrjRpZOuexNmjSEMdXM3I4KnnR7wcBjMMF9UideqY6L/y9H5WxSB7R+
         GMHZFwQwlPuvMvLwt4erQMMddi1AZ9HeikpPecvQ=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58A99600E2;
        Thu, 13 Dec 2018 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544719467;
        bh=HfqVVxA71rjyRwHgyZk8YKiBoDalmd4CQn13qw4F8BU=;
        h=From:To:Cc:Subject:Date:From;
        b=ZZGzjGLSi1bpTlkIumtPH39UZ46F3kT04IbrfZtpIWKGF+gu8UubkhtBADf4CIkZf
         2b7jOY42QXqteWIPOcawyqk/8/5ldzM8x++R+WH33D/aCgFd7pkMcY28aaMmwdWU7o
         KS+Fqz15ZiaYWpji8jYA0ovCq8oM9doFo+evv6wY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58A99600E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sboyd@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] clk: qcom: Drop unused 8998 clock
Date:   Thu, 13 Dec 2018 09:44:14 -0700
Message-Id: <1544719454-10638-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc_lpass_trig_clk is not used downstream, therefore there is no reason to
expect it to be needed for clients.  Lets remove it because messing with
the clock has been observed to cause Linux hangs when the qdss_clk is
initialized by rpmcc.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index f3c2ab4..4b75a09 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2005,19 +2005,6 @@ enum {
 	},
 };
 
-static struct clk_branch gcc_lpass_trig_clk = {
-	.halt_reg = 0x4701c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x4701c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_lpass_trig_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_mmss_noc_cfg_ahb_clk = {
 	.halt_reg = 0x9004,
 	.halt_check = BRANCH_HALT,
@@ -2710,7 +2697,6 @@ enum {
 	[GCC_HMSS_AT_CLK] = &gcc_hmss_at_clk.clkr,
 	[GCC_HMSS_RBCPR_CLK] = &gcc_hmss_rbcpr_clk.clkr,
 	[GCC_HMSS_TRIG_CLK] = &gcc_hmss_trig_clk.clkr,
-	[GCC_LPASS_TRIG_CLK] = &gcc_lpass_trig_clk.clkr,
 	[GCC_MMSS_NOC_CFG_AHB_CLK] = &gcc_mmss_noc_cfg_ahb_clk.clkr,
 	[GCC_MMSS_QM_AHB_CLK] = &gcc_mmss_qm_ahb_clk.clkr,
 	[GCC_MMSS_QM_CORE_CLK] = &gcc_mmss_qm_core_clk.clkr,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

