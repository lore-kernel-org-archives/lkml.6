Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28709C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05C720851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dY2fxuPN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K7g7mBjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05C720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeLMRJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:09:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeLMRJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:09:22 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C8C04608FF; Thu, 13 Dec 2018 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544720961;
        bh=7W2RS0AZlLIaSl6nh7HXG6MNVr2oYC/ut88J6IALeDk=;
        h=From:To:Cc:Subject:Date:From;
        b=dY2fxuPN0Qaslih9HtCb8E9XdZ22ECGEz2bHelXW/Xapro+ief3kjWpPPFQuDFdsU
         mLibpEpaW6/N6PH0DaX67yQFmPxKq8+NSFU8/H7VkIce3FUjEKfF6cIwvFpPD3rz5u
         DjMyHk3n40AspYg6GaOHiGwt7rQc/UfRMg3AGomw=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 078DF608FF;
        Thu, 13 Dec 2018 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544720960;
        bh=7W2RS0AZlLIaSl6nh7HXG6MNVr2oYC/ut88J6IALeDk=;
        h=From:To:Cc:Subject:Date:From;
        b=K7g7mBjN4Mz/OWZI0L6FnILK5BBHlStIfcJwncaI4UZqMWMaDvh+eUiPoSqQmLSZe
         eT4GCOCLXCESoTxB0DC+oU5VS9y3sK/5RQWYc1+UAMpoYJ8lHRBTU9AlnD9TOEieKQ
         oS5W98UIaE1CWPraUpTexIHbq5Bvos93YkIulmvk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 078DF608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sboyd@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2] clk: qcom: Drop unused 8998 clock
Date:   Thu, 13 Dec 2018 10:09:09 -0700
Message-Id: <1544720949-18404-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc_lpass_trig_clk is not used downstream, therefore there is no reason to
expect it to be needed for clients.  Let's remove it because messing with
the clock has been observed to cause Linux hangs when the qdss_clk is
initialized by rpmcc.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---

v2:
-corrected commit text per Marc
-added Marc's reviewed-by

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

