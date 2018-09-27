Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFECC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC0C215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qz0Tycde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC0C215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeI1BU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:20:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35966 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:20:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so2559355pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/VF1TI5TGQ3LEbw72u8BbpO4IegdgRaxnJZQlZMRJUI=;
        b=Qz0TycdetPLav2S+Ksio52U7NrZPn6UIbEODF8wATLT1G4E5RMQb6CHUVac9IkviJl
         M+kRwfMcTIoaP9ygAYiBd/s93y4EnH7fnCi7Liwotj+jP1YY5ZUY7zGTdqgDC9FG3dsi
         +8AA3GDVieKtTQ5/NXrZDqEegUSv5NZRZphQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/VF1TI5TGQ3LEbw72u8BbpO4IegdgRaxnJZQlZMRJUI=;
        b=Oq//fLhTv97onm14DwifVHV4L5J0tNJnplATvDY/wjlINx4pNwTYU2dCwra9N4q+2j
         hTnUaUZUjM0LL387cScVSIeoX2k99xU3H59thQJ4al38O98dliDrAY631TnTV5YuufCG
         4Lpz9jX3ql9pWqmSe1AbiD5t6f2c2Na8Y+0TlTV3uw0Eion1m/ODSdHZ+RqliJE1WbHo
         gyWfyQsXVek7oXKBtHrFWYfEoHkr0oPmznsFB4TmX8TGoeRJ4pji6FFiWChKzFqAcvew
         Bxt4IO6cVd1B0GuMyR24BZNCtUWH0Nt1e6QIH1ZBwV4h+jv/7jOaxF0v1UHpHTwFUuqU
         JmbA==
X-Gm-Message-State: ABuFfojKqGThWGCLVZf145JtFOs/4ohFKRshctpnAOv2Mg1Jrb+wua9y
        8AKTFVS4FZRuD81KGRys09ULlA==
X-Google-Smtp-Source: ACcGV60cc76xMBk1OL7O06mLldDmr5K2bxNO+gX1TWNHnCmcMkciJDfwTjmxV2Xo/1mbA6bp9yGdqA==
X-Received: by 2002:a17:902:6e01:: with SMTP id u1-v6mr12696563plk.13.1538074876749;
        Thu, 27 Sep 2018 12:01:16 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k63-v6sm3433615pga.36.2018.09.27.12.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:01:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2] remoteproc: qcom: pas: Add QCS404 remoteprocs
Date:   Thu, 27 Sep 2018 12:03:46 -0700
Message-Id: <20180927190346.2984-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the three PAS based remote processors found in
QCS404.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Fixed incorrect sysmon_name, as pointed out by Sibi.

 .../devicetree/bindings/remoteproc/qcom,adsp.txt     |  3 +++
 drivers/remoteproc/qcom_adsp_pil.c                   | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index b7d058228185..9c0cff3a5ed8 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -10,6 +10,9 @@ on the Qualcomm ADSP Hexagon core.
 		    "qcom,msm8974-adsp-pil"
 		    "qcom,msm8996-adsp-pil"
 		    "qcom,msm8996-slpi-pil"
+		    "qcom,qcs404-adsp-pas"
+		    "qcom,qcs404-cdsp-pas"
+		    "qcom,qcs404-wcss-pas"
 		    "qcom,sdm845-adsp-pas"
 		    "qcom,sdm845-cdsp-pas"
 
diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
index da2254ea1135..d5e58235e83a 100644
--- a/drivers/remoteproc/qcom_adsp_pil.c
+++ b/drivers/remoteproc/qcom_adsp_pil.c
@@ -362,10 +362,22 @@ static const struct adsp_data slpi_resource_init = {
 		.ssctl_id = 0x16,
 };
 
+static const struct adsp_data wcss_resource_init = {
+	.crash_reason_smem = 421,
+	.firmware_name = "wcnss.mdt",
+	.pas_id = 6,
+	.ssr_name = "mpss",
+	.sysmon_name = "wcnss",
+	.ssctl_id = 0x12,
+};
+
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
+	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
+	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
+	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
 	{ .compatible = "qcom,sdm845-adsp-pas", .data = &adsp_resource_init},
 	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &cdsp_resource_init},
 	{ },
-- 
2.18.0

