Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2ABC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454ED2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X/o8nAEp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mnoNs2SQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfAHKYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:24:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:32968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:24:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 95E2B6063A; Tue,  8 Jan 2019 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943046;
        bh=oK4JGaZaybYHB7ww6FPJp4LuGZnEPIesoOH+Ya9ZdDg=;
        h=From:To:Cc:Subject:Date:From;
        b=X/o8nAEpFEG/uqLZjdKIsd/FOsv8G8Lp5yBaPktRHmS3aUWagQEBkZW4JBjBamVT8
         lfHIHtDOdl6BCw2VADe4qr/2DhvVS19dcWiBbrFm3/HEtsz2ET47xdWvM2SEpekwXR
         hPPHvydrxA48E0MYmyrWcU5UAq+Iff4AKSdusmBc=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73648601EA;
        Tue,  8 Jan 2019 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943045;
        bh=oK4JGaZaybYHB7ww6FPJp4LuGZnEPIesoOH+Ya9ZdDg=;
        h=From:To:Cc:Subject:Date:From;
        b=mnoNs2SQlwTIG5JPf/ClBxZUO3aF20+gDFP24HKx0qq34QUsjhNSZrwKA2n+6kUbA
         3R6A5BAU4fUXUvWtRgJ/8lEkwcXh6F31PCjJeNFMjczFAsfNx9J1HSc5jWSMxYGw7n
         7Q2ecEmkWtnYZyWVs8x5MglsaVUykLNwBV1+6dVA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73648601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 1/3] dt-bindings: remoteproc: qcom: Introduce shutdown-ack irq for Q6V5
Date:   Tue,  8 Jan 2019 15:53:42 +0530
Message-Id: <20190108102344.28451-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce shutdown-irq binding required for sysmon shutdown for Q6V5 MSS
on SDM845/MSM8996 SoCs and for WCSS Q6V5 on QCS404 SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v2:
  * Make shutdown-ack mandatory for MSS on SDM845/MSM8996 and
    for WCSS on QCS404 (Dropping Rob's reviewed-by due to this)

 .../bindings/remoteproc/qcom,adsp.txt           | 17 ++++++++++++++---
 .../bindings/remoteproc/qcom,q6v5.txt           | 15 ++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index 60ee0f73071a..292dfda9770d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -19,13 +19,24 @@ on the Qualcomm ADSP Hexagon core.
 - interrupts-extended:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: must list the watchdog, fatal IRQs ready, handover and
-		    stop-ack IRQs
+	Definition: reference to the interrupts that match interrupt-names
 
 - interrupt-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
+	Definition: The interrupts needed depends on the compatible
+		    string:
+	qcom,msm8974-adsp-pil:
+	qcom,msm8996-adsp-pil:
+	qcom,msm8996-slpi-pil:
+	qcom,qcs404-adsp-pas:
+	qcom,qcs404-cdsp-pas:
+	qcom,sdm845-adsp-pas:
+	qcom,sdm845-cdsp-pas:
+		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
+	qcom,qcs404-wcss-pas:
+		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
+		    "shutdown-ack"
 
 - firmware-name:
 	Usage: optional
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 401e49ebee39..41ca5df5be5a 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -28,13 +28,22 @@ on the Qualcomm Hexagon core.
 - interrupts-extended:
 	Usage: required
 	Value type: <prop-encoded-array>
-	Definition: must list the watchdog, fatal IRQs ready, handover and
-		    stop-ack IRQs
+	Definition: reference to the interrupts that match interrupt-names
 
 - interrupt-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
+	Definition: The interrupts needed depends on the the compatible
+		    string:
+	qcom,q6v5-pil:
+	qcom,ipq8074-wcss-pil:
+	qcom,msm8916-mss-pil:
+	qcom,msm8974-mss-pil:
+		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
+	qcom,msm8996-mss-pil:
+	qcom,sdm845-mss-pil:
+		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
+		    "shutdown-ack"
 
 - firmware-name:
 	Usage: optional
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

