Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1720AC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97F320874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7wRXl+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97F320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeIYFrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:47:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34575 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeIYFrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:47:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so9875320pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OrXXo1xArmzx/By+DnHd8CcCkXY1YGkHFRgaV4O2kh4=;
        b=T7wRXl+WvUN2tlmzMT7hpg1q9LfIQcixYK2BYuttWurBuE6PwRzsXYMUpKw4DTlePC
         uVUTejfR1Ob+2fTEX2ekcDbmjU39qYopI5rSU+tMFcBR8DEq4AQGLw3eimsXnd99KHXP
         +iR9cUIlHQoyvVjuuxbwwAgJNls7lY1iYW2RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OrXXo1xArmzx/By+DnHd8CcCkXY1YGkHFRgaV4O2kh4=;
        b=Cc1XTY8ObfujWewT/WzD2Dr4qHID4z5ClC7pPeqWHTdtbV3pIezXNhiioZ+DYaFr93
         rOxBl8yyNaowNoIHaXw1Uj97hgmIfubTEoLNC0m8I8Hya4CT41pH35NBPjw3zUHsrge0
         LU6h/eniXZ9VRalc+mdXmkTnto5t57tJwpNLIxeiP+3UaeMsK5tfJlOoLj2KL4qwLgp4
         2LH8myZub0f2XiDe05B0v/5e5kBY7YsLZyFGHTWjRY+/yh03Dac93bOMuhHqdm4ytTlK
         ruu2tvBcxLndNg8r7lifvgkVOmqsmGiYD7yufBFAcV3nhyPIzR5Iw1fO+hHNo0nCLP1+
         x2PA==
X-Gm-Message-State: ABuFfohLgHHfS+5rVv9OppWfzD231xHZWunQGzPY8G9+0c0MvJcwv/L4
        VjyQWSWJ6/tzq0eo5zC8At19Sw==
X-Google-Smtp-Source: ACcGV62INZ2JZxRmvDH/Qa1Phfybk+OHSeRcXgXzpQZi6HXLzfYu59CCH8TT64YUjEDMAMT0ol6Wmw==
X-Received: by 2002:aa7:8087:: with SMTP id v7-v6mr925588pff.38.1537832581772;
        Mon, 24 Sep 2018 16:43:01 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d12-v6sm467110pfn.118.2018.09.24.16.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 16:43:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 1/2] remoteproc: qcom: Rename Hexagon v5 PAS driver
Date:   Mon, 24 Sep 2018 16:45:25 -0700
Message-Id: <20180924234526.22916-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924234526.22916-1-bjorn.andersson@linaro.org>
References: <20180924234526.22916-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hexagon v5 ADSP driver is used for more than only the ADSP and
there's an upcoming non-PAS ADSP PIL for SDM845, so rename the driver to
qcom_q6v5_pas in order to better suite this.

Cc: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Move the rename of qcom_q6v5_pil to the 2nd patch, where it belongs.

 drivers/remoteproc/Kconfig                    | 27 ++++++++++---------
 drivers/remoteproc/Makefile                   |  2 +-
 .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 +--
 3 files changed, 17 insertions(+), 16 deletions(-)
 rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 052d4dd347f9..425e502c6471 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -84,8 +84,16 @@ config KEYSTONE_REMOTEPROC
 	  It's safe to say N here if you're not interested in the Keystone
 	  DSPs or just want to use a bare minimum kernel.
 
-config QCOM_ADSP_PIL
-	tristate "Qualcomm ADSP Peripheral Image Loader"
+config QCOM_RPROC_COMMON
+	tristate
+
+config QCOM_Q6V5_COMMON
+	tristate
+	depends on ARCH_QCOM
+	depends on QCOM_SMEM
+
+config QCOM_Q6V5_PAS
+	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
@@ -98,15 +106,7 @@ config QCOM_ADSP_PIL
 	select QCOM_SCM
 	help
 	  Say y here to support the TrustZone based Peripherial Image Loader
-	  for the Qualcomm ADSP remote processors.
-
-config QCOM_RPROC_COMMON
-	tristate
-
-config QCOM_Q6V5_COMMON
-	tristate
-	depends on ARCH_QCOM
-	depends on QCOM_SMEM
+	  for the Qualcomm Hexagon v5 based remote processors.
 
 config QCOM_Q6V5_PIL
 	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
@@ -120,8 +120,9 @@ config QCOM_Q6V5_PIL
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
-	  Say y here to support the Qualcomm Peripherial Image Loader for the
-	  Hexagon V5 based remote processors.
+	  Say y here to support the TrustZone based Peripherial Image Loader
+	  for the Qualcomm Hexagon v5 based remote processors. This is commonly
+	  used to control subsystems such as ADSP, Compute and Sensor.
 
 config QCOM_Q6V5_WCSS
 	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 03332fa7e2ee..eb86c8ba5a87 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -14,9 +14,9 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
-obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
+obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
 obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
 obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
 obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_q6v5_pas.c
similarity index 98%
rename from drivers/remoteproc/qcom_adsp_pil.c
rename to drivers/remoteproc/qcom_q6v5_pas.c
index d4339a6da616..2478ef3cd519 100644
--- a/drivers/remoteproc/qcom_adsp_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -364,11 +364,11 @@ static struct platform_driver adsp_driver = {
 	.probe = adsp_probe,
 	.remove = adsp_remove,
 	.driver = {
-		.name = "qcom_adsp_pil",
+		.name = "qcom_q6v5_pas",
 		.of_match_table = adsp_of_match,
 	},
 };
 
 module_platform_driver(adsp_driver);
-MODULE_DESCRIPTION("Qualcomm MSM8974/MSM8996 ADSP Peripherial Image Loader");
+MODULE_DESCRIPTION("Qualcomm Hexagon v5 Peripheral Authentication Service driver");
 MODULE_LICENSE("GPL v2");
-- 
2.18.0

