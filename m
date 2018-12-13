Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29236C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DE42087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BLU0B29T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QKZAIc7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DE42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeLMQ7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:59:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeLMQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:59:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0841F60132; Thu, 13 Dec 2018 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544720383;
        bh=dKzQjPrQFAlvgQoG9iZUPmDlA4WUnrorf26brMypZX4=;
        h=From:To:Cc:Subject:Date:From;
        b=BLU0B29TQ31UmhE8mP32B8EmlRADP1fw7zz3xGhO6AY9IQi3AEFBwZGJCHYxbg2yO
         n3QvVJv/s/6fC/zZHA1H5frnw5JAKci7gtFkLLqr+3mk621wS407dlIiKPRWdZgwoi
         cV+cuJF1z98PvTxH7rQ69sb/YyORMKyng1AIPMkY=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E6C0602F8;
        Thu, 13 Dec 2018 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544720382;
        bh=dKzQjPrQFAlvgQoG9iZUPmDlA4WUnrorf26brMypZX4=;
        h=From:To:Cc:Subject:Date:From;
        b=QKZAIc7y4c/QqqZ9GQiLKpyNx4AfcoPR6XmdMof91f5WH29RrbMODj0TfnOtt+yz6
         sHAFrQ66339IUb777YnpFRl2+ISLx096r3rtDGRj1JUOQ7ItOziB+RPcL/o86SEWzt
         Sf0cSQPDA9oR+cmdM7pbiy9TU/hlfs7WHB4wP3fk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E6C0602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sboyd@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] clk: qcom: Leave mmss noc on for 8998
Date:   Thu, 13 Dec 2018 09:59:30 -0700
Message-Id: <1544720370-11598-1-git-send-email-jhugo@codeaurora.org>
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
 drivers/clk/qcom/gcc-msm8998.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 4b75a09..b371308 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2014,6 +2014,7 @@ enum {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mmss_noc_cfg_ahb_clk",
 			.ops = &clk_branch2_ops,
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

