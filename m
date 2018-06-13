Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C28FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F6C204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPFgj82M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F6C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935674AbeFMM4Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:56:16 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:37547 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935608AbeFMMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:55:24 -0400
Received: by mail-lf0-f45.google.com with SMTP id g21-v6so3794315lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OLH0hJwQ8RwvhYHIJtBDADe36nWSDQszwbIGDDuCigE=;
        b=EPFgj82M3Rq+yQA7dvMSIg4TyN4llg9rorKu+fLpiGlhkOCplhu3Y3s3nauTWyWgsG
         rJAB3VP3RPkLRtEL4RgTcYwOK5CdYgEohYjLDFBJpBaBLeT8v5+m9gEzJ8Gwh1LRAuOc
         aeFLMBj31aMJNIDoqDhAmR+ktJf56WVk4B4mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OLH0hJwQ8RwvhYHIJtBDADe36nWSDQszwbIGDDuCigE=;
        b=QWSQv8/RGp4xAZLLnfXVKCffMfYL5jNzhxsuB1qspj7KXfOlwicNk8QE4UoLj2+k8A
         RfByaRHn+v0p3ULKuDwg0vUGCnniwIjzGW8l5fv8O4v8xchWYgvJw+2oTCF7o+jfXXnq
         ifBKiL9ee7l8jLuC0NfvNfJQdMRqI5rqZvwqWm3fXuxuCEhBj5M1Hp8SyLFSN3OWwcjb
         Z9s7kRiodJS+mS5d8Fumh7tIkqYCqnd+wAGQzFAV8Wl5Fs9xcYghjDn31h1zYsWdMdzf
         q2VlKEUvDBsnCbDsYVOnjIqvT44h2q8+aEd1zNSM/3+VipQSxglVDa2aGrSRTPcrQpd5
         +MuQ==
X-Gm-Message-State: APt69E23z3BCSsQwxQUUkVkETz1wWIrXL7znfAW/uGBdipgPVC/m5HUy
        dId/NDTnRpz98ilwWjDpLQ/cqg==
X-Google-Smtp-Source: ADUXVKKr67ag1dT5/SwWaL2eMZJtIjk9fqjKddT/690eBrVWcuaFz9DkBC/SiChzUQ2TX31Dq5jXJw==
X-Received: by 2002:a19:97cb:: with SMTP id z194-v6mr3198585lfd.17.1528894522956;
        Wed, 13 Jun 2018 05:55:22 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id p5-v6sm526516ljh.3.2018.06.13.05.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:55:22 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] soc: qcom: Remove depends on ARCH_QCOM
Date:   Wed, 13 Jun 2018 14:54:00 +0200
Message-Id: <20180613125401.11734-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180613125401.11734-1-niklas.cassel@linaro.org>
References: <20180613125401.11734-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
we unconditionally include the soc/qcom/Makefile.

This opens up the possibility to compile test the code even when
building for other architectures.

Remove the depends on ARCH_QCOM for all Kconfigs, except for
two Kconfigs that depend on QCOM_SCM, since that triggers lots of build
errors in qcom_scm. However, that shouldn't stop us from removing
it from those where it is possible.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 1d4a9f3ada8c..8c83025c466e 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -5,7 +5,7 @@ menu "Qualcomm SoC drivers"
 
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
-	depends on (ARCH_QCOM && OF) || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	help
 	  Command DB queries shared memory by key string for shared system
 	  resources. Platform drivers that require to set state of a shared
@@ -14,7 +14,6 @@ config QCOM_COMMAND_DB
 
 config QCOM_GENI_SE
 	tristate "QCOM GENI Serial Engine Driver"
-	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  This driver is used to manage Generic Interface (GENI) firmware based
 	  Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
@@ -32,7 +31,6 @@ config QCOM_GLINK_SSR
 
 config QCOM_GSBI
         tristate "QCOM General Serial Bus Interface"
-        depends on ARCH_QCOM
         select MFD_SYSCON
         help
           Say y here to enable GSBI support.  The GSBI provides control
@@ -55,7 +53,7 @@ config QCOM_PM
 
 config QCOM_QMI_HELPERS
 	tristate
-	depends on ARCH_QCOM && NET
+	depends on NET
 	help
 	  Helper library for handling QMI encoded messages.  QMI encoded
 	  messages are used in communication between the majority of QRTR
@@ -76,7 +74,6 @@ config QCOM_RMTFS_MEM
 
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
-	depends on ARCH_QCOM
 	depends on HWSPINLOCK
 	help
 	  Say y here to enable support for the Qualcomm Shared Memory Manager.
@@ -85,7 +82,6 @@ config QCOM_SMEM
 
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
-	depends on ARCH_QCOM
 	depends on RPMSG && OF
 	help
 	  If you say yes to this option, support will be included for the
@@ -122,7 +118,6 @@ config QCOM_SMSM
 
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
-	depends on ARCH_QCOM
 	depends on RPMSG
 	help
 	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
@@ -130,7 +125,6 @@ config QCOM_WCNSS_CTRL
 
 config QCOM_APR
 	tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
-	depends on ARCH_QCOM
 	depends on RPMSG
 	help
           Enable APR IPC protocol support between
-- 
2.17.1

