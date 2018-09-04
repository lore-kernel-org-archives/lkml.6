Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C71C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3FB206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mYOade+Z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mYOade+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3FB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeIEDuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:50:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeIEDuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:50:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CDED2607DD; Tue,  4 Sep 2018 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536103378;
        bh=g3Sdv6CpVkM0FD+8VN6I1vcE8P5fndxD3Xsg60kjUBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYOade+Z/Bt9LwtyLjQn5hGchqUQf4gtkXzlZQeXCscVCCZv+7eUYn9rhlY6V1oh3
         5+FwWvDy2+cMbPZhkU+rfBtcdINjzDmRqWHgevmNs/zyVQm25ozn95uA1hHIS2TFsq
         uDedygiVyDvf2MflDEyddG/qJ8H22dx9DV6VWS0o=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 702C6607DD;
        Tue,  4 Sep 2018 23:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536103378;
        bh=g3Sdv6CpVkM0FD+8VN6I1vcE8P5fndxD3Xsg60kjUBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYOade+Z/Bt9LwtyLjQn5hGchqUQf4gtkXzlZQeXCscVCCZv+7eUYn9rhlY6V1oh3
         5+FwWvDy2+cMbPZhkU+rfBtcdINjzDmRqWHgevmNs/zyVQm25ozn95uA1hHIS2TFsq
         uDedygiVyDvf2MflDEyddG/qJ8H22dx9DV6VWS0o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 702C6607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH v4 2/4] drivers: soc: Add support to register LLCC EDAC driver
Date:   Tue,  4 Sep 2018 16:22:23 -0700
Message-Id: <1536103345-1919-3-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
References: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache error reporting controller detects and reports single and
double bit errors on Last Level Cache Controller (LLCC) cache.
Add required support to register LLCC EDAC driver as platform driver,
from LLCC driver.

Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/soc/qcom/llcc-slice.c      | 18 ++++++++++++++++--
 include/linux/soc/qcom/llcc-qcom.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index a63640d..09c8bb0 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -224,7 +224,7 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev)
 	u32 attr0_val;
 	u32 max_cap_cacheline;
 	u32 sz;
-	int ret;
+	int ret = 0;
 	const struct llcc_slice_config *llcc_table;
 	struct llcc_slice_desc desc;
 
@@ -282,6 +282,7 @@ int qcom_llcc_probe(struct platform_device *pdev,
 	struct resource *llcc_banks_res, *llcc_bcast_res;
 	void __iomem *llcc_banks_base, *llcc_bcast_base;
 	int ret, i;
+	struct platform_device *llcc_edac;
 
 	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data)
@@ -341,6 +342,19 @@ int qcom_llcc_probe(struct platform_device *pdev,
 	mutex_init(&drv_data->lock);
 	platform_set_drvdata(pdev, drv_data);
 
-	return qcom_llcc_cfg_program(pdev);
+	ret = qcom_llcc_cfg_program(pdev);
+	if (ret)
+		return ret;
+
+	drv_data->ecc_irq = platform_get_irq(pdev, 0);
+	if (drv_data->ecc_irq >= 0) {
+		llcc_edac = platform_device_register_data(&pdev->dev,
+						"qcom_llcc_edac", -1, drv_data,
+						sizeof(*drv_data));
+		if (IS_ERR(llcc_edac))
+			dev_err(dev, "Failed to register llcc edac driver\n");
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_llcc_probe);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index c681e79..2e4b34d 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -78,6 +78,7 @@ struct llcc_slice_config {
  * @num_banks: Number of llcc banks
  * @bitmap: Bit map to track the active slice ids
  * @offsets: Pointer to the bank offsets array
+ * @ecc_irq: interrupt for llcc cache error detection and reporting
  */
 struct llcc_drv_data {
 	struct regmap *regmap;
@@ -89,6 +90,7 @@ struct llcc_drv_data {
 	u32 num_banks;
 	unsigned long *bitmap;
 	u32 *offsets;
+	int ecc_irq;
 };
 
 #if IS_ENABLED(CONFIG_QCOM_LLCC)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

