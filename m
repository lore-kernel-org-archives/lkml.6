Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85481C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A02B20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RukWt6JX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lwaSzwnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A02B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbeLCPfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:35:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59220 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:35:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 980D260246; Mon,  3 Dec 2018 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543851314;
        bh=6XJQSVpsjPMZ+YVQkAGC8l4Vwe9V+Eqo7n4zjnXMDic=;
        h=From:To:Cc:Subject:Date:From;
        b=RukWt6JXIjVsUid84bgtaHSZ2zOidXlRHElRF/Y+eprulQ1wPIMSdkDon7Xx86+Ec
         1C/VxnFfqk4dy2shSqkZaDwOSqEvCikj09Fpg8SMhXM1mOia3nnnkjIURcQjwAA3CY
         bsXVmvZtEoVGjBhJkOaFaz8JEJjLfun55SQg4iGM=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 266F3601C4;
        Mon,  3 Dec 2018 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543851313;
        bh=6XJQSVpsjPMZ+YVQkAGC8l4Vwe9V+Eqo7n4zjnXMDic=;
        h=From:To:Cc:Subject:Date:From;
        b=lwaSzwnbC57FfinUiMbZxmo7HLKyzXIJsdR85hhedqxfKrNmOFyb3WJ3rO1FStT32
         jUmEmWuM7zK2g0QFOEQfdoxBhj/0u+4I2t3BpvoLsg38WXC7fko3TsZWCH/BZ81pWY
         cYumZZf/R7y/6jY8GsrbyhECoFlyE6N6aB417Ybk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 266F3601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] clk: qcom: Fix MSM8998 resets
Date:   Mon,  3 Dec 2018 08:34:58 -0700
Message-Id: <1543851298-32320-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offsets for the defined BCR reset registers does not match the hardware
documentation.  Update the values to match the hardware documentation.

Fixes: b5f5f525c547 (clk: qcom: Add MSM8998 Global Clock Control (GCC) driver)
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 9f0ae40..01cc555 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2742,25 +2742,25 @@ enum {
 };
 
 static const struct qcom_reset_map gcc_msm8998_resets[] = {
-	[GCC_BLSP1_QUP1_BCR] = { 0x102400 },
-	[GCC_BLSP1_QUP2_BCR] = { 0x110592 },
-	[GCC_BLSP1_QUP3_BCR] = { 0x118784 },
-	[GCC_BLSP1_QUP4_BCR] = { 0x126976 },
-	[GCC_BLSP1_QUP5_BCR] = { 0x135168 },
-	[GCC_BLSP1_QUP6_BCR] = { 0x143360 },
-	[GCC_BLSP2_QUP1_BCR] = { 0x155648 },
-	[GCC_BLSP2_QUP2_BCR] = { 0x163840 },
-	[GCC_BLSP2_QUP3_BCR] = { 0x172032 },
-	[GCC_BLSP2_QUP4_BCR] = { 0x180224 },
-	[GCC_BLSP2_QUP5_BCR] = { 0x188416 },
-	[GCC_BLSP2_QUP6_BCR] = { 0x196608 },
-	[GCC_PCIE_0_BCR] = { 0x438272 },
-	[GCC_PDM_BCR] = { 0x208896 },
-	[GCC_SDCC2_BCR] = { 0x81920 },
-	[GCC_SDCC4_BCR] = { 0x90112 },
-	[GCC_TSIF_BCR] = { 0x221184 },
-	[GCC_UFS_BCR] = { 0x479232 },
-	[GCC_USB_30_BCR] = { 0x61440 },
+	[GCC_BLSP1_QUP1_BCR] = { 0x19000 },
+	[GCC_BLSP1_QUP2_BCR] = { 0x1b000 },
+	[GCC_BLSP1_QUP3_BCR] = { 0x1d000 },
+	[GCC_BLSP1_QUP4_BCR] = { 0x1f000 },
+	[GCC_BLSP1_QUP5_BCR] = { 0x21000 },
+	[GCC_BLSP1_QUP6_BCR] = { 0x23000 },
+	[GCC_BLSP2_QUP1_BCR] = { 0x26000 },
+	[GCC_BLSP2_QUP2_BCR] = { 0x28000 },
+	[GCC_BLSP2_QUP3_BCR] = { 0x2a000 },
+	[GCC_BLSP2_QUP4_BCR] = { 0x2c000 },
+	[GCC_BLSP2_QUP5_BCR] = { 0x2e000 },
+	[GCC_BLSP2_QUP6_BCR] = { 0x30000 },
+	[GCC_PCIE_0_BCR] = { 0x6c01c },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_TSIF_BCR] = { 0x36000 },
+	[GCC_UFS_BCR] = { 0x75000 },
+	[GCC_USB_30_BCR] = { 0xf000 },
 };
 
 static const struct regmap_config gcc_msm8998_regmap_config = {
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

