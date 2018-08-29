Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDECEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10E1205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZCS87Q2v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b+9yeiKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10E1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeH2XL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:11:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2XLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:11:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 496DF603D2; Wed, 29 Aug 2018 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569987;
        bh=WF+PHE6mmS50HexoxWt8U7CydUjnB7bmUQ1w+0CWYzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCS87Q2v0Io+rU2vXUPS7XIgTXPZwasCBiOiRH0bATqUDDGNj2meoEv5tToaWxl2Z
         H01jM4jHYjOss1yApQVf2DNH74jk0VA4gaVaIUnwqcYlt+7E9QdRN5LgD/gOf/wywS
         aYgXLRRb8uHj3JT5R97DMvYWRcyFlGNKpZzSyh50=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D933603D2;
        Wed, 29 Aug 2018 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569985;
        bh=WF+PHE6mmS50HexoxWt8U7CydUjnB7bmUQ1w+0CWYzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+9yeiKz+qi+s/eZzS5TVaR2/hiQvSjngXLrmzn9O1EdFvvt9qyjni/m3m+HjvVCB
         riqsUi6wOwCzsFqCC3WNm9wOgKWcKsB8Xew11//8XMHNDm3OBWW4dOM+ZS6bxEy4sU
         IrzPcir9TiM8ZqxGZ8H0kWvQ/RYYyTJ5Pplgoor4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D933603D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        mka@chromium.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 6/6] remoteproc: qcom: q6v5-pil: Add PDC reset for modem on SDM845 SoCs
Date:   Thu, 30 Aug 2018 00:42:15 +0530
Message-Id: <20180829191215.10071-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180829191215.10071-1-sibis@codeaurora.org>
References: <20180829191215.10071-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the presence of a PDC block working with subsystem RSC, assert/deassert
PDC reset in modem start/stop path.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 968413edf0c8..835fa005fe3e 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -149,6 +149,7 @@ struct q6v5 {
 	u32 halt_nc;
 
 	struct reset_control *mss_restart;
+	struct reset_control *pdc_reset;
 
 	struct qcom_q6v5 q6v5;
 
@@ -349,10 +350,17 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
 
 static int q6v5_reset_assert(struct q6v5 *qproc)
 {
-	if (qproc->has_alt_reset)
-		return reset_control_reset(qproc->mss_restart);
-	else
-		return reset_control_assert(qproc->mss_restart);
+	int ret;
+
+	if (qproc->has_alt_reset) {
+		reset_control_assert(qproc->pdc_reset);
+		ret = reset_control_reset(qproc->mss_restart);
+		reset_control_deassert(qproc->pdc_reset);
+	} else {
+		ret = reset_control_assert(qproc->mss_restart);
+	}
+
+	return ret;
 }
 
 static int q6v5_reset_deassert(struct q6v5 *qproc)
@@ -360,9 +368,11 @@ static int q6v5_reset_deassert(struct q6v5 *qproc)
 	int ret;
 
 	if (qproc->has_alt_reset) {
+		reset_control_assert(qproc->pdc_reset);
 		writel(1, qproc->rmb_base + RMB_MBA_ALT_RESET);
 		ret = reset_control_reset(qproc->mss_restart);
 		writel(0, qproc->rmb_base + RMB_MBA_ALT_RESET);
+		reset_control_deassert(qproc->pdc_reset);
 	} else {
 		ret = reset_control_deassert(qproc->mss_restart);
 	}
@@ -1183,6 +1193,15 @@ static int q6v5_init_reset(struct q6v5 *qproc)
 		return PTR_ERR(qproc->mss_restart);
 	}
 
+	if (qproc->has_alt_reset) {
+		qproc->pdc_reset = devm_reset_control_get_exclusive(qproc->dev,
+								"pdc_reset");
+		if (IS_ERR(qproc->pdc_reset)) {
+			dev_err(qproc->dev, "failed to acquire pdc reset\n");
+			return PTR_ERR(qproc->pdc_reset);
+		}
+	}
+
 	return 0;
 }
 
@@ -1303,12 +1322,12 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->active_reg_count = ret;
 
+	qproc->has_alt_reset = desc->has_alt_reset;
 	ret = q6v5_init_reset(qproc);
 	if (ret)
 		goto free_rproc;
 
 	qproc->version = desc->version;
-	qproc->has_alt_reset = desc->has_alt_reset;
 	qproc->need_mem_protection = desc->need_mem_protection;
 
 	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

