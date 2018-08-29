Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA7AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2D72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW5/fEmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2D72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeH2LyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:54:01 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41552 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeH2LyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:54:00 -0400
Received: by mail-lf1-f44.google.com with SMTP id l26-v6so3506213lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPmzBAaCwGcvI/sAuYQ1Clo4rSi6tAkAe6FRcMV4N8Q=;
        b=HW5/fEmgKIUafjeUg4zbJPEGYLu/s0WsK6ytwflfgvJ9MHT7krbYvZXp1jujKnYoGf
         7CKQ21h+087UWapk0Wg2LFKg4us//HMcr0pPT1KBMoueiYdGndgsCQKOg2tlWWv4MyII
         Q6w5V44OtoZ7MTO5MUDKg/S2UmrcSQ0P/G5i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RPmzBAaCwGcvI/sAuYQ1Clo4rSi6tAkAe6FRcMV4N8Q=;
        b=I0AMIMZbOgTcjaQC8dH5FsOekGLInSl8sNE07hiclxwDWuCp58EmAUrw5z2THiOKTd
         tqgZ0NlqU2BSYEuu/POoi3xi/yNqGD3ttTujj31GW2GtuqRdzC5yZJt4PcvHRvHBCGiV
         aMUPCiyFAJ1ATPvWHJP8X+1xOMnvhueoOdF2xXlpaI/rQLJscObAsZQ0rav3h3THGKd2
         I2LhY0DOu0m5l+44T0ay/1Jm21s6g1A9OHe65NhrJVhXlhBZaB/UNGLd/vms+pa+w/KY
         sY4o9AE+TFl3aXnJnTBW0jSSalU3xfMMwqZTA9N1EuErR2eTeCaeG6vfXthcQ5WnyRco
         6ZFw==
X-Gm-Message-State: APzg51DmSIeo99hzDsZTmZWczi5aO6BnDzw1AVtJNfF5c6ZnW4TDhZEl
        /WoajScm8AVEouYkFaaG02BE/eOOwe8=
X-Google-Smtp-Source: ANB0Vdbz2buhBBncItmHfiZG0V5b3Guv57Xw6jIEgmomgTgk8BUH1SGFbO6kMlbywvNV2Z2Q+aSpgg==
X-Received: by 2002:a19:290c:: with SMTP id p12-v6mr3374579lfp.124.1535529501784;
        Wed, 29 Aug 2018 00:58:21 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id y16-v6sm596945lje.30.2018.08.29.00.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:58:21 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 9/9] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Date:   Wed, 29 Aug 2018 09:57:23 +0200
Message-Id: <20180829075724.9095-10-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
we unconditionally include the soc/qcom/Makefile.

This opens up the possibility to compile test the code even when building
for other architectures.

Allow COMPILE_TEST for all qcom SoC Kconfigs, except for two Kconfigs
that depend on QCOM_SCM, since that triggers lots of build errors in
qcom_scm.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/Kconfig | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index cf4ece232897..684cb51694d1 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -33,7 +33,7 @@ config QCOM_GLINK_SSR
 
 config QCOM_GSBI
         tristate "QCOM General Serial Bus Interface"
-        depends on ARCH_QCOM
+        depends on ARCH_QCOM || COMPILE_TEST
         select MFD_SYSCON
         help
           Say y here to enable GSBI support.  The GSBI provides control
@@ -42,7 +42,7 @@ config QCOM_GSBI
 
 config QCOM_LLCC
 	tristate "Qualcomm Technologies, Inc. LLCC driver"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Qualcomm Technologies, Inc. platform specific
 	  Last Level Cache Controller(LLCC) driver. This provides interfaces
@@ -73,7 +73,8 @@ config QCOM_PM
 
 config QCOM_QMI_HELPERS
 	tristate
-	depends on ARCH_QCOM && NET
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on NET
 	help
 	  Helper library for handling QMI encoded messages.  QMI encoded
 	  messages are used in communication between the majority of QRTR
@@ -104,7 +105,7 @@ config QCOM_RPMH
 
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HWSPINLOCK
 	help
 	  Say y here to enable support for the Qualcomm Shared Memory Manager.
@@ -113,7 +114,7 @@ config QCOM_SMEM
 
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
 	help
 	  If you say yes to this option, support will be included for the
@@ -150,7 +151,7 @@ config QCOM_SMSM
 
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
 	help
 	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
@@ -158,7 +159,7 @@ config QCOM_WCNSS_CTRL
 
 config QCOM_APR
 	tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
 	help
           Enable APR IPC protocol support between
-- 
2.17.1

