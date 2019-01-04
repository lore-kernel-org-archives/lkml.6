Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C640C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7BE218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fp/GBlsO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VW+WT2t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfADQu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:50:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:32858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfADQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:50:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A04CC609C2; Fri,  4 Jan 2019 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546620625;
        bh=l2xGmlRCMleAFb+nyn3PENIum8GMuqnbl1NJzjFM8R8=;
        h=From:To:Cc:Subject:Date:From;
        b=fp/GBlsO8fBh0Np2qGcdPJoXlvspxCkHQ+6KXLOTCYK4UPh76IdA9IqgqWSrAFRL1
         5B2IBPO1nqyAFV8q6hLv5EpuFc+tv7xSU9n89+gvwKFpCu49ijXuUO5MYmuLfSZJBs
         uKx0xBzgoo2HpPoXXcgQAsqrqEANc4DUOQRErYbg=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B3056095F;
        Fri,  4 Jan 2019 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546620609;
        bh=l2xGmlRCMleAFb+nyn3PENIum8GMuqnbl1NJzjFM8R8=;
        h=From:To:Cc:Subject:Date:From;
        b=VW+WT2t+/vvT+e+ZduQvVoskhPMjKxNZctB8/PRBrYHY2qa7MxxQEodQAtKYpTwF7
         /7fKoJlp/ZYTA2HRNOgnWK11LRwFPyqcyL7gEump8oAKeskUfWu2AEADmXM74u//4t
         D4caRkvuD8kTwKHgQpFUQo60p+GpnGOLP0qvyob8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B3056095F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1 1/6] clk: qcom: Add missing freq for usb30_master_clk on 8998
Date:   Fri,  4 Jan 2019 09:49:46 -0700
Message-Id: <1546620586-2352-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb30_master_clk supports a 60Mhz frequency, but that is missing from
the table of supported frequencies.  Add it.

Fixes: b5f5f525c547 (clk: qcom: Add MSM8998 Global Clock Control (GCC) driver)
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 1b77939..42de947 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -1112,6 +1112,7 @@ enum {
 
 static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
+	F(60000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
 	F(120000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
 	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
 	{ }
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

