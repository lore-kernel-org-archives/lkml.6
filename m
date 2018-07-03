Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E0C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7A82244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHI6fezu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7A82244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeGCHV3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:21:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46747 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbeGCHV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:21:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so690896lju.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mAhAb6Gx5VvTr8G6mqKdwiVj+JSA81/HtN577BT8Riw=;
        b=CHI6fezu+y/PCQXI+UoK/SChwcol8AbaQ7IUN17CiTW9K5vFM6c+RIVwP6PvViHu4M
         YeJbe5cTTbGl9rcMbHBeILScixsC8Bt3+cioVP5CQeP53Ko1Abvq2GRiVcwKHsCA9fEK
         Dz9R/68dcH8rLgd45Hub5EOxpTSF0RTjzZBZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mAhAb6Gx5VvTr8G6mqKdwiVj+JSA81/HtN577BT8Riw=;
        b=nRs7M5tXrII+T+WfYrfkTaD96JQbzdVGqNIbs+hUFxiQBwdnZGFzccx01vVy/VEmGk
         ddO78UoPLz4h0LwL3Tuv1bwqN4+RcB2v/hjZCaMBjPLwFCbqZlb4gGOi+qNoEk4VtAdK
         3+LEp7zUs8uuwSNcN/JxnirwUaJbdG55pz3ZbXiyFBNLnKM26IF/3aot6a69ezu4gIZ5
         auoUs2uHfNdSTyvqfRK58qMgOvcirVBrXdlS9Sb/bG2erxYuzMfTiZPZSVgfRAT7fZIH
         tEhhz+ksUSXo+b2msvLMmLhGo5WODWOy7kqffrp/8SN+IsB+s7ag2nCl5lRDUWmN5EHm
         PiOg==
X-Gm-Message-State: APt69E2RGK7dNTBBT0N+1A4gCeECAbacZJohVujOiukW/cXqksMBSgtI
        p2wO78bsGmHMatzCE1TTnreKWw==
X-Google-Smtp-Source: AAOMgpeCCAXJIsL1a5h9Q2ldmX1+fUS5gAla/1bZDU8h4J5Eqdz0q0JNmkE5HzcnPEyti8YJXbrORw==
X-Received: by 2002:a2e:9c82:: with SMTP id x2-v6mr11304663lji.131.1530602485572;
        Tue, 03 Jul 2018 00:21:25 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id n17-v6sm67580ljg.55.2018.07.03.00.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:21:25 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Date:   Tue,  3 Jul 2018 09:20:33 +0200
Message-Id: <20180703072034.20213-7-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703072034.20213-1-niklas.cassel@linaro.org>
References: <20180703072034.20213-1-niklas.cassel@linaro.org>
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
---
 drivers/soc/qcom/Kconfig | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ac657164a136..fd09b95be0ba 100644
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

