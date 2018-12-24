Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03246C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3E721721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CEFh0riI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nyz3kgF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeLXItX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:49:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLXItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:49:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F42D608CD; Mon, 24 Dec 2018 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545641361;
        bh=25ZxDDBoAMl3ipPhUl6iV7pmCG65GyELxEpfWHYjbnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEFh0riIkBMIVZ/ch1RduqlpMPgyzLi4Jq2CetknA74SSzcND2svVf0Ukt1BdeL5r
         aOdTl77cbc+14S+S7x4xCjBn5hC4IdCI1/LyJjhyehGXz7Ipt2i9rEc1dMUbvaqMso
         NgfGW5YgLDKb/wKsy/7SQrfImvrtBCL603IuU3GI=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 616D1608CD;
        Mon, 24 Dec 2018 08:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545641358;
        bh=25ZxDDBoAMl3ipPhUl6iV7pmCG65GyELxEpfWHYjbnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nyz3kgF81PhDwwB6LrpoB07XLbSJjy38FH/54DaYXzOqi2PVLo0/7tpvAeLOQQwnC
         sW6gEAPgjniU7c0E51fil5FYs+lidc9bOPcmKxxXVcM3mWZDIHsz4l8nSC8afBHe/u
         GAUbQ7LmgO7Vm7rrd0eTOemn3rZjbt3tOxCO0/hc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 616D1608CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 4/4] remoteproc: qcom: Enable shutdown-ack irq on Q6V5
Date:   Mon, 24 Dec 2018 14:18:25 +0530
Message-Id: <20181224084824.25193-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181224084824.25193-1-sibis@codeaurora.org>
References: <20181224084824.25193-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable shutdown-ack irq handling for MSS Q6V5 on SDM845/MSM8996
SoCs and for WCSS Q6V5 on QCS404 SoC.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 11 ++++++++---
 drivers/remoteproc/qcom_q6v5_pas.c |  9 +++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 3bc2dec85928..fdb18d1ea177 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -134,6 +134,7 @@ struct rproc_hexagon_res {
 	int version;
 	bool need_mem_protection;
 	bool has_alt_reset;
+	u8 has_shutdown_irq;
 };
 
 struct q6v5 {
@@ -1252,6 +1253,7 @@ static int q6v5_probe(struct platform_device *pdev)
 {
 	const struct rproc_hexagon_res *desc;
 	struct q6v5 *qproc;
+	struct qcom_q6v5 *q6v5;
 	struct rproc *rproc;
 	int ret;
 
@@ -1273,6 +1275,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
 	platform_set_drvdata(pdev, qproc);
+	q6v5 = &qproc->q6v5;
 
 	ret = q6v5_init_mem(qproc, pdev);
 	if (ret)
@@ -1330,7 +1333,8 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->version = desc->version;
 	qproc->need_mem_protection = desc->need_mem_protection;
 
-	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
+	q6v5->has_shutdown_irq = desc->has_shutdown_irq;
+	ret = qcom_q6v5_init(q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
 			     qcom_msa_handover);
 	if (ret)
 		goto free_rproc;
@@ -1340,8 +1344,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	qcom_add_glink_subdev(rproc, &qproc->glink_subdev);
 	qcom_add_smd_subdev(rproc, &qproc->smd_subdev);
 	qcom_add_ssr_subdev(rproc, &qproc->ssr_subdev, "mpss");
-	qproc->sysmon = qcom_add_sysmon_subdev(rproc, "modem", 0x12,
-					       &qproc->q6v5);
+	qproc->sysmon = qcom_add_sysmon_subdev(rproc, "modem", 0x12, q6v5);
 
 	ret = rproc_add(rproc);
 	if (ret)
@@ -1391,6 +1394,7 @@ static const struct rproc_hexagon_res sdm845_mss = {
 	},
 	.need_mem_protection = true,
 	.has_alt_reset = true,
+	.has_shutdown_irq = true,
 	.version = MSS_SDM845,
 };
 
@@ -1410,6 +1414,7 @@ static const struct rproc_hexagon_res msm8996_mss = {
 	},
 	.need_mem_protection = true,
 	.has_alt_reset = false,
+	.has_shutdown_irq = true,
 	.version = MSS_MSM8996,
 };
 
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 920a39ea6609..2d6ff59575cd 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -43,6 +43,7 @@ struct adsp_data {
 	const char *ssr_name;
 	const char *sysmon_name;
 	int ssctl_id;
+	u8 has_shutdown_irq;
 };
 
 struct qcom_adsp {
@@ -257,6 +258,7 @@ static int adsp_probe(struct platform_device *pdev)
 {
 	const struct adsp_data *desc;
 	struct qcom_adsp *adsp;
+	struct qcom_q6v5 *q6v5;
 	struct rproc *rproc;
 	int ret;
 
@@ -280,6 +282,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->pas_id = desc->pas_id;
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
 	platform_set_drvdata(pdev, adsp);
+	q6v5 = &adsp->q6v5;
 
 	ret = adsp_alloc_memory_region(adsp);
 	if (ret)
@@ -293,7 +296,8 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
+	q6v5->has_shutdown_irq = desc->has_shutdown_irq;
+	ret = qcom_q6v5_init(q6v5, pdev, rproc, desc->crash_reason_smem,
 			     qcom_pas_handover);
 	if (ret)
 		goto free_rproc;
@@ -304,7 +308,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
 					      desc->sysmon_name,
 					      desc->ssctl_id,
-					      &adsp->q6v5);
+					      q6v5);
 
 	ret = rproc_add(rproc);
 	if (ret)
@@ -366,6 +370,7 @@ static const struct adsp_data slpi_resource_init = {
 static const struct adsp_data wcss_resource_init = {
 	.crash_reason_smem = 421,
 	.firmware_name = "wcnss.mdt",
+	.has_shutdown_irq = true,
 	.pas_id = 6,
 	.ssr_name = "mpss",
 	.sysmon_name = "wcnss",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

