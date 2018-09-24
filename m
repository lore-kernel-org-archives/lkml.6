Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A18FC004D2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37B120C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwGybSo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37B120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeIYFro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:47:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42093 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeIYFrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:47:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so9859934pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZtoKBVrzm3qMlK4nocfukac9kOAi6Sol1hWQrZ1Hds=;
        b=YwGybSo8x7biBN5aNjE+AJ09/n8uysgjLxmVQyStVfuEORfxeCDBwYGsCP/aoJRPlS
         073wHCbbKBhvDhvWhLIzbqRKpcyJaDTm32Z3TOx+nHuWHVNKpXxk47jAGTNjIYitVGIF
         8l58haGmAqyRk8TFDMypnI7FsXZxzHLn4KuMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nZtoKBVrzm3qMlK4nocfukac9kOAi6Sol1hWQrZ1Hds=;
        b=ZCh5T+NXrqnbYHlUyYe5xxDt/G8C4uAD+3YX9nVdBwgz0B6EaAme4fxpyY73lGonII
         ud8Usfl1doJQQTJM+uaDB3n+qbEx74oS1fidx4xi7jPlUh0de4JNiNwKI/KxRfiXjBfc
         iBxh6aYPmyXWaCVQq88LyQF+YLrlSG3TsWfrIMaQD9r/sQyhr1+QDpwvsSwTKgaK4ZnA
         L5DNnT8Jj1jnVdGL/0BXMCERxo2j09mPqbxsCLn61xf1Vw43RBDEjDIbKelSOdnqcNKp
         FUEJnoqEMz5dvT/QtA9Zz1vbvFJ/FRuKw0ZfUp3OYQMakfTuWuOJ2nMiw90GOntZqbth
         VXNw==
X-Gm-Message-State: ABuFfogRUVbmJS5AWT5gug//3lpWHY2bbfP1OM/2zYGyDKAzd+oJjRKy
        SbWOFxYKvfRYAkerUVgMjLBjLw==
X-Google-Smtp-Source: ACcGV609x1IOst5Seja/UUYpJbkuXSYkmPvyp5NTC13+tn3DVv3NYqlkll54m44CBM1DfseQiw9cgg==
X-Received: by 2002:a62:f208:: with SMTP id m8-v6mr892839pfh.222.1537832583275;
        Mon, 24 Sep 2018 16:43:03 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d12-v6sm467110pfn.118.2018.09.24.16.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 16:43:02 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v3 2/2] remoteproc: qcom: Rename Hexagon v5 modem driver
Date:   Mon, 24 Sep 2018 16:45:26 -0700
Message-Id: <20180924234526.22916-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924234526.22916-1-bjorn.andersson@linaro.org>
References: <20180924234526.22916-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom_q6v5_pil implements support for the self-authenticating modem
subsystem. With the introduction of other q6v5 based non-TZ based
remoteproc driver the current name is cause for confusion, so rename it
to be more specific.

No functional change.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Chances since v2:
- Updated module description, driver name and header comment

 drivers/remoteproc/Kconfig                         | 14 +++++++-------
 drivers/remoteproc/Makefile                        |  2 +-
 .../{qcom_q6v5_pil.c => qcom_q6v5_mss.c}           |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/remoteproc/{qcom_q6v5_pil.c => qcom_q6v5_mss.c} (99%)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 425e502c6471..8894935583e2 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -92,30 +92,30 @@ config QCOM_Q6V5_COMMON
 	depends on ARCH_QCOM
 	depends on QCOM_SMEM
 
-config QCOM_Q6V5_PAS
-	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
+config QCOM_Q6V5_MSS
+	tristate "Qualcomm Hexagon V5 self-authenticating modem subsystem support"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
-	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
-	  Say y here to support the TrustZone based Peripherial Image Loader
-	  for the Qualcomm Hexagon v5 based remote processors.
+	  Say y here to support the Qualcomm self-authenticating modem
+	  subsystem based on Hexagon V5.
 
-config QCOM_Q6V5_PIL
-	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
+config QCOM_Q6V5_PAS
+	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index eb86c8ba5a87..050f41ac93b0 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -16,8 +16,8 @@ obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
+obj-$(CONFIG_QCOM_Q6V5_MSS)		+= qcom_q6v5_mss.o
 obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
-obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
 obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
 obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
 obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_mss.c
similarity index 99%
rename from drivers/remoteproc/qcom_q6v5_pil.c
rename to drivers/remoteproc/qcom_q6v5_mss.c
index d7a4b9eca5d2..9ebbb9339295 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1,5 +1,5 @@
 /*
- * Qualcomm Peripheral Image Loader
+ * Qualcomm self-authenticating modem subsystem remoteproc driver
  *
  * Copyright (C) 2016 Linaro Ltd.
  * Copyright (C) 2014 Sony Mobile Communications AB
@@ -1368,11 +1368,11 @@ static struct platform_driver q6v5_driver = {
 	.probe = q6v5_probe,
 	.remove = q6v5_remove,
 	.driver = {
-		.name = "qcom-q6v5-pil",
+		.name = "qcom-q6v5-mss",
 		.of_match_table = q6v5_of_match,
 	},
 };
 module_platform_driver(q6v5_driver);
 
-MODULE_DESCRIPTION("Peripheral Image Loader for Hexagon");
+MODULE_DESCRIPTION("Qualcomm Self-authenticating modem remoteproc driver");
 MODULE_LICENSE("GPL v2");
-- 
2.18.0

