Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B4ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936C4206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtwElgx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936C4206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeITXEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:04:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45157 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbeITXEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:04:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so4638317pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NaOfTbA5BHfEo4zV49s3Hc2oVirXXIQsKVy7HL8tknw=;
        b=QtwElgx6osfgEjtI8U932YUq8N3vjzkQMPnrcxBefrPbBaUVKCBeYCb+a/vPEd5OON
         dGno6CudZaRmM/ZBvTLAAZE+7GrZKpLbq8ct9xDMYiKixHOLNCllYw+c9Ax4jWUwcyuY
         A4TEQJgCadVIAqsqNMVARqTk8R8zCt2/LrKOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NaOfTbA5BHfEo4zV49s3Hc2oVirXXIQsKVy7HL8tknw=;
        b=cIuXjKKH+IuX1GBiCF3sJZKdizK1ZgG+4osjOpiSkEupd/mKjmf1DWUSTBazOrfG/9
         Gc13MlQBpV4EIUrhO+LSGeNVpvGUQp44K4/6201/CQqoGwChdInTYVcTcMuiCZteQDw5
         iAWnEk3RbFfa5KQoQC43Jq5R9naQBhe4sI/C33zbXwtjILOhWKmK+pvl/Mf4pWWyZOzD
         XkAb3McAyre9rddfdUG7x9t8Iym57mvvMBiS9oR82zptURWH6Fz2WHAspo1v1BgrhbLt
         4NguTPuKt6++EIEkgvwg8NV9JTECXOVxNMUhDO3O/JU7HCtG7Ly1oN//EdNpsW3AhriA
         eeMg==
X-Gm-Message-State: APzg51Bpn9FkINv8OxUiIbAYB5hc8nqKo82KEc/0LPL8yPi5/VRkGozK
        6r2WAkKYW9GdoRvASgl1BtMbKw==
X-Google-Smtp-Source: ANB0Vdaxp6bZSVApsbO/Q344nyoakXnno+U45uLTio1o00Wm2NeM1araWmgrAYwLQJnC0E52GDFz6g==
X-Received: by 2002:a17:902:7e09:: with SMTP id b9-v6mr40080518plm.221.1537464019170;
        Thu, 20 Sep 2018 10:20:19 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c28-v6sm8059228pgn.65.2018.09.20.10.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:20:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: pas: Add QCS404 remoteprocs
Date:   Thu, 20 Sep 2018 10:22:37 -0700
Message-Id: <20180920172237.30965-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

Add compatibles for the three PAS based remote processors found in
QCS404.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
[bjorn: Added adsp and cdsp to the patch]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
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
index da2254ea1135..fcbb816a9698 100644
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
+	.sysmon_name = "wlan",
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

