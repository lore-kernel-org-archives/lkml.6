Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9869C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D438208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FG4pshZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D438208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeH1LDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:03:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41737 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeH1LDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:03:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so339466plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=73HPGL63Esv8GtHzIlNSJjuXKAKifPboU2ChJ9Oi9P8=;
        b=FG4pshZAM1r22VmHGpgqH+Wqy67J7uI8dv3GUpS+FWDSl1wWzKoYLzqQzWjm5f3WtF
         0PL6FRAHi72gwx331WN5CUubwycmCMsX68fwUWsslIp8kp2B0N4If+UH2KYm+RNASkLW
         XWNSMfkDqgVoWpDkqOsgrL1dXhYecG7xqHxu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=73HPGL63Esv8GtHzIlNSJjuXKAKifPboU2ChJ9Oi9P8=;
        b=GaDoKDvgPAvqcbj1c0cLXaTjt6Uv/eDpZ/lbWuvOTOcOegKLpKb9E4TI351aBwAE8A
         n5bmrWLoad4BjfNtQf7odpCk06PWx5dp3a5i1e86X2M0KLwqiio5FfgEygyG1UlzxtJI
         GfhL7n3wUv5RFlQwOPa2aYMIu02nJLn8zWcccdJ/Adfwz+tUeALQeLRqQYgRd6xUr1UZ
         syb+bvitfASOO42twUoujroug0epT4wAMz9x+OrZCaxFccERYFxHNhWLQa/BUkBJkLiZ
         xR9mcblKoWHBnmAflgHxIbe4knVLVaYc2Ei0BkyFHqh4YcPdhXtr1x0FXs2UAwBOPXxL
         YPKg==
X-Gm-Message-State: APzg51C4WzzuRr0cUIp9LwTPqRJEbS0sfESA8Q47v/3xS/8v0D/rmva+
        eokCCLIx/1eRqllMEq0EkK38zA==
X-Google-Smtp-Source: ANB0VdZd3qpg7t3rIC2sG1CMHl6dzapvvnPledNhrcaFLrjpCTzEjmIGjXo9JUWoC5BGUyyGqZmpNg==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13-v6mr281913pls.167.1535440401999;
        Tue, 28 Aug 2018 00:13:21 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f4-v6sm1143482pfj.46.2018.08.28.00.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 00:13:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: adsp: Add SDM845 ADSP and CDSP support
Date:   Tue, 28 Aug 2018 00:14:58 -0700
Message-Id: <20180828071458.26858-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for booting the Audio and Compute DSPs found in Qualcomm's
SDM845 platform.

As with the previous platforms the power rail handling needs to be
updated once the appropriate support lands upstream.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.txt     |  2 ++
 drivers/remoteproc/qcom_q6v5_pas.c                   | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index 728e4193f7a6..b7d058228185 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -10,6 +10,8 @@ on the Qualcomm ADSP Hexagon core.
 		    "qcom,msm8974-adsp-pil"
 		    "qcom,msm8996-adsp-pil"
 		    "qcom,msm8996-slpi-pil"
+		    "qcom,sdm845-adsp-pas"
+		    "qcom,sdm845-cdsp-pas"
 
 - interrupts-extended:
 	Usage: required
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 2478ef3cd519..53eff2afda06 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -342,6 +342,16 @@ static const struct adsp_data adsp_resource_init = {
 		.ssctl_id = 0x14,
 };
 
+static const struct adsp_data cdsp_resource_init = {
+	.crash_reason_smem = 601,
+	.firmware_name = "cdsp.mdt",
+	.pas_id = 18,
+	.has_aggre2_clk = false,
+	.ssr_name = "cdsp",
+	.sysmon_name = "cdsp",
+	.ssctl_id = 0x17,
+};
+
 static const struct adsp_data slpi_resource_init = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
@@ -355,6 +365,8 @@ static const struct adsp_data slpi_resource_init = {
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
+	{ .compatible = "qcom,sdm845-adsp-pas", .data = &adsp_resource_init},
+	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &cdsp_resource_init},
 	{ },
 };
-- 
2.18.0

