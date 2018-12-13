Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509C9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092E920811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MwdYCzjq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MwdYCzjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092E920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeLMWnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:43:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:43:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC14060722; Thu, 13 Dec 2018 22:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544741030;
        bh=of37OIEc3PKbJqChP1sgAFxoQhy8JH7vSRgSXYq4uus=;
        h=From:To:Cc:Subject:Date:From;
        b=MwdYCzjqfgvqom/B/hOqiVtHFvMsdtkwjl/ov0q3S83mw12Oab0QP3eMAn+kGx501
         FO1EARwnbIsV+TFcNkCYOTorPk3Td5gSLP2YcQ520YExPho/zqnzldLzWzklKGzx1Q
         8XCrqq6fSL/+Mb4+B8yhQ12dxX73Mx6ZcUfEpXuY=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 597CE601D7;
        Thu, 13 Dec 2018 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544741030;
        bh=of37OIEc3PKbJqChP1sgAFxoQhy8JH7vSRgSXYq4uus=;
        h=From:To:Cc:Subject:Date:From;
        b=MwdYCzjqfgvqom/B/hOqiVtHFvMsdtkwjl/ov0q3S83mw12Oab0QP3eMAn+kGx501
         FO1EARwnbIsV+TFcNkCYOTorPk3Td5gSLP2YcQ520YExPho/zqnzldLzWzklKGzx1Q
         8XCrqq6fSL/+Mb4+B8yhQ12dxX73Mx6ZcUfEpXuY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 597CE601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sboyd@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2] clk: qcom: Leave mmss noc on for 8998
Date:   Thu, 13 Dec 2018 15:43:40 -0700
Message-Id: <1544741020-8261-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other qcom targets, gcc_mmss_noc_cfg_ahb_clk should not be
disabled.  Any mmss access depends on this clock, and its been observed
that enabling mmssnoc_axi_rpm_clk with rpmcc results in an implicit
access to mmss and will crash the system if gcc_mmss_noc_cfg_ahb_clk is
disabled.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---

v2:
-Switch to CLK_IS_CRITICAL and add comment per Stephen

 drivers/clk/qcom/gcc-msm8998.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index f3c2ab4..b0c4b38 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2027,6 +2027,12 @@ enum {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mmss_noc_cfg_ahb_clk",
 			.ops = &clk_branch2_ops,
+			/*
+			 * Any access to mmss depends on this clock.
+			 * Gating this clock has been shown to crash the system
+			 * when mmssnoc_axi_rpm_clk is inited in rpmcc.
+			 */
+			.flags = CLK_IS_CRITICAL,
 		},
 	},
 };
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

