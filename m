Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE554272E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nr+853it";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KvLDdK8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE554272E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965796AbeF1LsJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:48:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeF1LsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:48:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E93660791; Thu, 28 Jun 2018 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530186485;
        bh=eKDxRqEGV3HPQ3sPWKriFr28XLQYgIJbhsiDEuMKkEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nr+853itODj/DhMr96A2NqFATzZESnh1uWsxJhTulhFZJMGHv9YdHmPnkAiDFdDGZ
         r9sA0BqjOxQJzCAtpY2i+9LhRMrkCEsZThKXqkbPfLbipYVdD+Ek3OwDsfMt2K+A3P
         QdUH9LyBCgVRbH5XobL1IehohHjhlM7TN545CID8=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 257EE606FC;
        Thu, 28 Jun 2018 11:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530186484;
        bh=eKDxRqEGV3HPQ3sPWKriFr28XLQYgIJbhsiDEuMKkEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvLDdK8CTDLXOVguGlxHwTjkT+jRMeZosKuD+OUGjxa5XkYEFdUJe1TSrIa5G6Hq7
         E5S42bqSvoSZkccSGAikXJ/tn/XQLntnyr8Sz7ZN5k9FgvdtPV+pQKaMM5JlJ2k2iP
         jm84Gc++AJMpYI4yu4onxKuKWV0JS4x8Kv4KuLm8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 257EE606FC
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
Subject: [PATCH v2 2/2] clk: qcom: gcc: Register QUPv3 RCGs for DFS on SDM845
Date:   Thu, 28 Jun 2018 17:17:31 +0530
Message-Id: <1530186451-24648-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530186451-24648-1-git-send-email-tdas@codeaurora.org>
References: <1530186451-24648-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUPv3 clocks support DFS and thus register the RCGs which require support
for the same.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index e78e6f5..034c762 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3421,9 +3421,29 @@ enum {
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
@@ -3437,7 +3457,12 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x48190, BIT(0), 0x1);
 	regmap_update_bits(regmap, 0x52004, BIT(22), 0x1);

-	return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
+	if (ret)
+		return ret;
+
+	return qcom_cc_register_rcg_dfs(pdev, gcc_dfs_clocks,
+					ARRAY_SIZE(gcc_dfs_clocks));
 }

 static struct platform_driver gcc_sdm845_driver = {
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

