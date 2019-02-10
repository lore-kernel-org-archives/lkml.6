Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCAAC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852D8213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UuXAH/C8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XxlAIFcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfBJUOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:14:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfBJUOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:14:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F0180605FC; Sun, 10 Feb 2019 20:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549829660;
        bh=ikKJEH4RmBXZ2bJy9ZyrbKW9RnEG3zsXDA9QBc0+Udo=;
        h=From:To:Cc:Subject:Date:From;
        b=UuXAH/C8YYH6y9U2E+TUWUnx5tTexE7MoBAMXbPLT7fkGmOotas5T5iRrWzc1YW9/
         EC+G+M1kPgMhLjHZULU/Evrm1nyxnCRynvHViWfvfEbiF3ksUHI5RMiXMBmXsUqwTA
         QXxTqtLw1nCWF51scntO1vdCpFSZOuILrKveuXWk=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BDD5760274;
        Sun, 10 Feb 2019 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549829658;
        bh=ikKJEH4RmBXZ2bJy9ZyrbKW9RnEG3zsXDA9QBc0+Udo=;
        h=From:To:Cc:Subject:Date:From;
        b=XxlAIFcwjdTnpF1wUrFLv3F6fMLVjTI3ZU8TxxyxVYD87bGZ1wOGHWKrrogSiAtM5
         pKHr7YX0PdHA9yU09iQWnE4Y3HsaQ/FV2/zYNAvCI/nKhxugk0oqeSIvuWja5oLvFE
         4+oUSg9kfdriwPyHI2SqGCIAlSrCpvWt2QBgO4Dk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDD5760274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1] clk: qcom: Make common clk_hw registrations
Date:   Sun, 10 Feb 2019 13:14:05 -0700
Message-Id: <1549829645-24400-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several clock controller drivers define a list of clk_hw devices, and then
register those devices in probe() before using common code to process the
rest of initialization.  Extend the common code to accept a list of clk_hw
devices to process, thus eliminating many duplicate implementations.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/clk/qcom/common.c       |  8 ++++++++
 drivers/clk/qcom/common.h       |  2 ++
 drivers/clk/qcom/gcc-ipq8074.c  | 10 ++--------
 drivers/clk/qcom/gcc-mdm9615.c  | 11 ++---------
 drivers/clk/qcom/gcc-msm8996.c  | 10 ++--------
 drivers/clk/qcom/gcc-msm8998.c  | 10 ++++++----
 drivers/clk/qcom/gcc-qcs404.c   |  9 ++-------
 drivers/clk/qcom/gcc-sdm660.c   | 11 +++--------
 drivers/clk/qcom/mmcc-msm8996.c | 10 ++--------
 9 files changed, 29 insertions(+), 52 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 0a48ed5..a6b2f861 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -231,6 +231,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	struct gdsc_desc *scd;
 	size_t num_clks = desc->num_clks;
 	struct clk_regmap **rclks = desc->clks;
+	size_t num_clk_hws = desc->num_clk_hws;
+	struct clk_hw **clk_hws = desc->clk_hws;
 
 	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
 	if (!cc)
@@ -269,6 +271,12 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
 	qcom_cc_drop_protected(dev, cc);
 
+	for (i = 0; i < num_clk_hws; i++) {
+		ret = devm_clk_hw_register(dev, clk_hws[i]);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < num_clks; i++) {
 		if (!rclks[i])
 			continue;
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 4aa33ee..1e2a8bd 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -27,6 +27,8 @@ struct qcom_cc_desc {
 	size_t num_resets;
 	struct gdsc **gdscs;
 	size_t num_gdscs;
+	struct clk_hw **clk_hws;
+	size_t num_clk_hws;
 };
 
 /**
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 505c626..0e32892 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4715,18 +4715,12 @@ enum {
 	.num_clks = ARRAY_SIZE(gcc_ipq8074_clks),
 	.resets = gcc_ipq8074_resets,
 	.num_resets = ARRAY_SIZE(gcc_ipq8074_resets),
+	.clk_hws = gcc_ipq8074_hws,
+	.num_clk_hws = ARRAY_SIZE(gcc_ipq8074_hws),
 };
 
 static int gcc_ipq8074_probe(struct platform_device *pdev)
 {
-	int ret, i;
-
-	for (i = 0; i < ARRAY_SIZE(gcc_ipq8074_hws); i++) {
-		ret = devm_clk_hw_register(&pdev->dev, gcc_ipq8074_hws[i]);
-		if (ret)
-			return ret;
-	}
-
 	return qcom_cc_probe(pdev, &gcc_ipq8074_desc);
 }
 
diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
index 849046f..8c6d931 100644
--- a/drivers/clk/qcom/gcc-mdm9615.c
+++ b/drivers/clk/qcom/gcc-mdm9615.c
@@ -1702,6 +1702,8 @@ enum {
 	.num_clks = ARRAY_SIZE(gcc_mdm9615_clks),
 	.resets = gcc_mdm9615_resets,
 	.num_resets = ARRAY_SIZE(gcc_mdm9615_resets),
+	.clk_hws = gcc_mdm9615_hws,
+	.num_clk_hws = ARRAY_SIZE(gcc_mdm9615_hws),
 };
 
 static const struct of_device_id gcc_mdm9615_match_table[] = {
@@ -1712,21 +1714,12 @@ enum {
 
 static int gcc_mdm9615_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
-	int ret;
-	int i;
 
 	regmap = qcom_cc_map(pdev, &gcc_mdm9615_desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	for (i = 0; i < ARRAY_SIZE(gcc_mdm9615_hws); i++) {
-		ret = devm_clk_hw_register(dev, gcc_mdm9615_hws[i]);
-		if (ret)
-			return ret;
-	}
-
 	return qcom_cc_really_probe(pdev, &gcc_mdm9615_desc, regmap);
 }
 
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 9d13617..4632b92 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -3656,6 +3656,8 @@ enum {
 	.num_resets = ARRAY_SIZE(gcc_msm8996_resets),
 	.gdscs = gcc_msm8996_gdscs,
 	.num_gdscs = ARRAY_SIZE(gcc_msm8996_gdscs),
+	.clk_hws = gcc_msm8996_hws,
+	.num_clk_hws = ARRAY_SIZE(gcc_msm8996_hws),
 };
 
 static const struct of_device_id gcc_msm8996_match_table[] = {
@@ -3666,8 +3668,6 @@ enum {
 
 static int gcc_msm8996_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	int i, ret;
 	struct regmap *regmap;
 
 	regmap = qcom_cc_map(pdev, &gcc_msm8996_desc);
@@ -3680,12 +3680,6 @@ static int gcc_msm8996_probe(struct platform_device *pdev)
 	 */
 	regmap_update_bits(regmap, 0x52008, BIT(21), BIT(21));
 
-	for (i = 0; i < ARRAY_SIZE(gcc_msm8996_hws); i++) {
-		ret = devm_clk_hw_register(dev, gcc_msm8996_hws[i]);
-		if (ret)
-			return ret;
-	}
-
 	return qcom_cc_really_probe(pdev, &gcc_msm8996_desc, regmap);
 }
 
diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 3cbabbb..c240fba 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2959,6 +2959,10 @@ enum {
 	.fast_io	= true,
 };
 
+static struct clk_hw *gcc_msm8998_hws[] = {
+	&xo.hw,
+};
+
 static const struct qcom_cc_desc gcc_msm8998_desc = {
 	.config = &gcc_msm8998_regmap_config,
 	.clks = gcc_msm8998_clocks,
@@ -2967,6 +2971,8 @@ enum {
 	.num_resets = ARRAY_SIZE(gcc_msm8998_resets),
 	.gdscs = gcc_msm8998_gdscs,
 	.num_gdscs = ARRAY_SIZE(gcc_msm8998_gdscs),
+	.clk_hws = gcc_msm8998_hws,
+	.num_clk_hws = ARRAY_SIZE(gcc_msm8998_hws),
 };
 
 static int gcc_msm8998_probe(struct platform_device *pdev)
@@ -2986,10 +2992,6 @@ static int gcc_msm8998_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_clk_hw_register(&pdev->dev, &xo.hw);
-	if (ret)
-		return ret;
-
 	return qcom_cc_really_probe(pdev, &gcc_msm8998_desc, regmap);
 }
 
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 64da032..a7b2fe0 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2692,6 +2692,8 @@ enum {
 	.num_clks = ARRAY_SIZE(gcc_qcs404_clocks),
 	.resets = gcc_qcs404_resets,
 	.num_resets = ARRAY_SIZE(gcc_qcs404_resets),
+	.clk_hws = gcc_qcs404_hws,
+	.num_clk_hws = ARRAY_SIZE(gcc_qcs404_hws),
 };
 
 static const struct of_device_id gcc_qcs404_match_table[] = {
@@ -2703,7 +2705,6 @@ enum {
 static int gcc_qcs404_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
-	int ret, i;
 
 	regmap = qcom_cc_map(pdev, &gcc_qcs404_desc);
 	if (IS_ERR(regmap))
@@ -2711,12 +2712,6 @@ static int gcc_qcs404_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&gpll3_out_main, regmap, &gpll3_config);
 
-	for (i = 0; i < ARRAY_SIZE(gcc_qcs404_hws); i++) {
-		ret = devm_clk_hw_register(&pdev->dev, gcc_qcs404_hws[i]);
-		if (ret)
-			return ret;
-	}
-
 	return qcom_cc_really_probe(pdev, &gcc_qcs404_desc, regmap);
 }
 
diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index ba239ea..8827db2 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -2420,6 +2420,8 @@ enum {
 	.num_resets = ARRAY_SIZE(gcc_sdm660_resets),
 	.gdscs = gcc_sdm660_gdscs,
 	.num_gdscs = ARRAY_SIZE(gcc_sdm660_gdscs),
+	.clk_hws = gcc_sdm660_hws,
+	.num_clk_hws = ARRAY_SIZE(gcc_sdm660_hws),
 };
 
 static const struct of_device_id gcc_sdm660_match_table[] = {
@@ -2431,7 +2433,7 @@ enum {
 
 static int gcc_sdm660_probe(struct platform_device *pdev)
 {
-	int i, ret;
+	int ret;
 	struct regmap *regmap;
 
 	regmap = qcom_cc_map(pdev, &gcc_sdm660_desc);
@@ -2446,13 +2448,6 @@ static int gcc_sdm660_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Register the hws */
-	for (i = 0; i < ARRAY_SIZE(gcc_sdm660_hws); i++) {
-		ret = devm_clk_hw_register(&pdev->dev, gcc_sdm660_hws[i]);
-		if (ret)
-			return ret;
-	}
-
 	return qcom_cc_really_probe(pdev, &gcc_sdm660_desc, regmap);
 }
 
diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index 7d4ee10..7235510 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -3347,6 +3347,8 @@ enum {
 	.num_resets = ARRAY_SIZE(mmcc_msm8996_resets),
 	.gdscs = mmcc_msm8996_gdscs,
 	.num_gdscs = ARRAY_SIZE(mmcc_msm8996_gdscs),
+	.clk_hws = mmcc_msm8996_hws,
+	.num_clk_hws = ARRAY_SIZE(mmcc_msm8996_hws),
 };
 
 static const struct of_device_id mmcc_msm8996_match_table[] = {
@@ -3357,8 +3359,6 @@ enum {
 
 static int mmcc_msm8996_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	int i, ret;
 	struct regmap *regmap;
 
 	regmap = qcom_cc_map(pdev, &mmcc_msm8996_desc);
@@ -3370,12 +3370,6 @@ static int mmcc_msm8996_probe(struct platform_device *pdev)
 	/* Disable the NoC FSM for mmss_mmagic_cfg_ahb_clk */
 	regmap_update_bits(regmap, 0x5054, BIT(15), 0);
 
-	for (i = 0; i < ARRAY_SIZE(mmcc_msm8996_hws); i++) {
-		ret = devm_clk_hw_register(dev, mmcc_msm8996_hws[i]);
-		if (ret)
-			return ret;
-	}
-
 	return qcom_cc_really_probe(pdev, &mmcc_msm8996_desc, regmap);
 }
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

