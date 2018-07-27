Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8892089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pNCGBOyQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UWtrdPmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8892089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeG0QvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:51:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeG0QvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:51:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 289F960B62; Fri, 27 Jul 2018 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532705321;
        bh=i4h1ZO925eZkFZT+DmUMvFxOS80S10ooZwtqH6hbaeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNCGBOyQI2W4W2R9ZK3KA1CjY51x1pSGtpr94gZhg4RLHxBblDRdRFIe/7sagOSaA
         r9oDBoK9aLksAEfjJH/LM5oCBwYGHvnnCIWoc6T1au1UiNhH1gD5f9bYf7nIj1J4Jr
         hii4GYwh4X3UDl6j0uQSIHmCknKCLGsbFYnqT3Qw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0114F60481;
        Fri, 27 Jul 2018 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532705319;
        bh=i4h1ZO925eZkFZT+DmUMvFxOS80S10ooZwtqH6hbaeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWtrdPmx1wAZRPONU7zexD0R+zG3/ZquQ14FdtSo5ZvGTVwWEritW5+6gBfbq6o3x
         ngLGvfy1od9K2jrRtZipnK8ccNp6vt58tgwnJXCf0JjQ6rahuFfiP8h9y05W3aNv22
         RNXVOS3PlZuI35iIXn3Lvi30yQfdu+ofahuHP9/8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0114F60481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 4/4] remoteproc: qcom: q6v5-pil: Add PDC restart for modem on SDM845 SoCs
Date:   Fri, 27 Jul 2018 20:58:11 +0530
Message-Id: <20180727152811.15258-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180727152811.15258-1-sibis@codeaurora.org>
References: <20180727152811.15258-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the presence of a PDC block working with subsystem RSC,
assert/deassert PDC restart in modem start/stop path.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../bindings/remoteproc/qcom,q6v5.txt         |  4 +++
 drivers/remoteproc/qcom_q6v5_pil.c            | 27 ++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 601dd9f389aa..124fb1dc6fb8 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -51,6 +51,8 @@ on the Qualcomm Hexagon core.
 	Usage: required
 	Value type: <phandle>
 	Definition: reference to the reset-controller for the modem sub-system
+		    reference to the list of 2 reset-controllers for the modem
+		    sub-system on SDM845 SoCs
 		    reference to the list of 3 reset-controllers for the
 		    wcss sub-system
 
@@ -58,6 +60,8 @@ on the Qualcomm Hexagon core.
 	Usage: required
 	Value type: <stringlist>
 	Definition: must be "mss_restart" for the modem sub-system
+	Definition: must be "mss_restart", "pdc_restart" for the modem
+		    sub-system on SDM845 SoCs
 	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
 		    for the wcss syb-system
 
diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index d57fdb34e3dd..5be794639fc3 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -149,6 +149,7 @@ struct q6v5 {
 	u32 halt_nc;
 
 	struct reset_control *mss_restart;
+	struct reset_control *pdc_restart;
 
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
+		reset_control_assert(qproc->pdc_restart);
+		ret = reset_control_reset(qproc->mss_restart);
+		reset_control_deassert(qproc->pdc_restart);
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
+		reset_control_assert(qproc->pdc_restart);
 		writel(1, qproc->rmb_base + RMB_MBA_ALT_RESET);
 		ret = reset_control_reset(qproc->mss_restart);
 		writel(0, qproc->rmb_base + RMB_MBA_ALT_RESET);
+		reset_control_deassert(qproc->pdc_restart);
 	} else {
 		ret = reset_control_deassert(qproc->mss_restart);
 	}
@@ -1182,6 +1192,15 @@ static int q6v5_init_reset(struct q6v5 *qproc)
 		return PTR_ERR(qproc->mss_restart);
 	}
 
+	if (qproc->has_alt_reset) {
+		qproc->pdc_restart = devm_reset_control_get(qproc->dev,
+							    "pdc_restart");
+		if (IS_ERR(qproc->pdc_restart)) {
+			dev_err(qproc->dev, "failed to acquire pdc restart\n");
+			return PTR_ERR(qproc->pdc_restart);
+		}
+	}
+
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

