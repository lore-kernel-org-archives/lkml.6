Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A6C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FEA22430
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WAgYyUS5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CIWu5Wxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FEA22430
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeHKE0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:26:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeHKE0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:26:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27B4D60B84; Sat, 11 Aug 2018 01:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533952470;
        bh=rbB7vpGnqlTwPZQSYwwke9PUOsfJsq1u9Pm7itiGw9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAgYyUS5zC7DluMXRgKCoDyV5DHTvIcTwx+AipGCT+8XWVZYmMTuUTJB1qB4Q0Uuw
         hM9H/sk15eyR4z3e7cgmU26IGPXZ2VCy3MI0V3mqQWYvIWKRHh/xlx31BBs2OPzt0L
         yt+7NltZW6uMH4FRqB2LfYxVUhWYj45z0GwGW7TY=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 598A960B1E;
        Sat, 11 Aug 2018 01:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533952469;
        bh=rbB7vpGnqlTwPZQSYwwke9PUOsfJsq1u9Pm7itiGw9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIWu5Wxontfy+zU6anDVAk2xazcGlUKmhJNB8l2BQDR/VAh3L5BTj0B9BHpQzJfkV
         MqsFpHwcWVRhJ79FYdm1kZIzAFEThurq+KjjRbiC0H8eW+B/sPpJOig93I8YLTNunC
         ErAAXKnfUgCaacI6NmkqcC6yxPHEeDmmeM2QC2RA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 598A960B1E
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
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v4 2/2] clk: qcom: gcc: Register QUPv3 RCGs for DFS on SDM845
Date:   Sat, 11 Aug 2018 07:23:56 +0530
Message-Id: <1533952436-17221-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533952436-17221-1-git-send-email-tdas@codeaurora.org>
References: <1533952436-17221-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUPv3 clocks support DFS and thus register the RCGs which require support
for the same.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index fa1a196..fef6732 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3458,9 +3458,29 @@ enum {
 };
 MODULE_DEVICE_TABLE(of, gcc_sdm845_match_table);
 
+static struct clk_rcg2 *gcc_dfs_clocks[] = {
+	&gcc_qupv3_wrap0_s0_clk_src,
+	&gcc_qupv3_wrap0_s1_clk_src,
+	&gcc_qupv3_wrap0_s2_clk_src,
+	&gcc_qupv3_wrap0_s3_clk_src,
+	&gcc_qupv3_wrap0_s4_clk_src,
+	&gcc_qupv3_wrap0_s5_clk_src,
+	&gcc_qupv3_wrap0_s6_clk_src,
+	&gcc_qupv3_wrap0_s7_clk_src,
+	&gcc_qupv3_wrap1_s0_clk_src,
+	&gcc_qupv3_wrap1_s1_clk_src,
+	&gcc_qupv3_wrap1_s2_clk_src,
+	&gcc_qupv3_wrap1_s3_clk_src,
+	&gcc_qupv3_wrap1_s4_clk_src,
+	&gcc_qupv3_wrap1_s5_clk_src,
+	&gcc_qupv3_wrap1_s6_clk_src,
+	&gcc_qupv3_wrap1_s7_clk_src,
+};
+
 static int gcc_sdm845_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
 
 	regmap = qcom_cc_map(pdev, &gcc_sdm845_desc);
 	if (IS_ERR(regmap))
@@ -3470,6 +3490,11 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
+	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
+					ARRAY_SIZE(gcc_dfs_clocks));
+	if (ret)
+		return ret;
+
 	return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
 }
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

