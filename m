Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444A220833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iMGkihgJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="keaQpJem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444A220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeGYS6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:58:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbeGYS6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:58:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A23F60B81; Wed, 25 Jul 2018 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532540739;
        bh=qh7yaEpIyifS3E+8H/BApyYvs4KZtbpDnPNVf/JtnBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMGkihgJ9JVKJx7Y/ibQdAWMnixIzDnPAS3td2ZDGk1/V5g4ZbW7wEScyh7aQVnkz
         oJrXUJ7MyIeReYoBXT0fMAJNtGBLzeCKVwaJjsqsyevNY+JNeBdNE0ABgtk53J7X3g
         Lkg1uvk2cemvn5HMkhLWEx//OnlD40Dimq/LTQYQ=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B27956074D;
        Wed, 25 Jul 2018 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532540738;
        bh=qh7yaEpIyifS3E+8H/BApyYvs4KZtbpDnPNVf/JtnBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keaQpJemDRW0QIy604xsToeESiTmUGyamGs7ryXPPUGqJAmK+MigPu366ZCeOxQNI
         ffL5owwuvx8JmxnMoDDxVATovgzwQPSrL1jcAfeUuJrZuiWo9kXhgm9fjHf+4bcBW5
         QcTc6TvVXX+wTg7Y6490MIyygijjYEpujPKXhwAE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B27956074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     evgreen@chromium.org, robh@kernel.org, bp@alien8.de,
        mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org,
        rishabhb@codeaurora.org
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH v0 2/4] drivers: soc: Support to add cache erp driver for Last Level Cache Controller (LLCC)
Date:   Wed, 25 Jul 2018 10:44:55 -0700
Message-Id: <1532540697-26630-3-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532540697-26630-1-git-send-email-vnkgutta@codeaurora.org>
References: <1532540697-26630-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache error reporting controller is to detect and report single
and double bit errors on Last Level Cache Controller (LLCC) cache.
Add required support to register cache erp driver as platform driver,
from LLCC driver.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 drivers/soc/qcom/llcc-slice.c      | 18 ++++++++++++++++--
 include/linux/soc/qcom/llcc-qcom.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index a63640d..9860ef9 100644
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
+						"qcom_llcc_erp", -1, drv_data,
+						sizeof(*drv_data));
+		if (IS_ERR(llcc_edac))
+			dev_err(dev, "Failed to register llcc edac driver\n");
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_llcc_probe);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index c681e79..1a3bc25 100644
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
+	u32 ecc_irq;
 };
 
 #if IS_ENABLED(CONFIG_QCOM_LLCC)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

