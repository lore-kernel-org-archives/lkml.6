Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6FEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6979120858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cr+cDwc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6979120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeH0PXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:23:24 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40108 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeH0PXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:23:23 -0400
Received: by mail-lj1-f181.google.com with SMTP id j19-v6so12056624ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtiMjRzmWzHX4uiypyPK/pndRvCDAWXrFCNoaRIqQmY=;
        b=Cr+cDwc11T1tliNfeRdHr9TicTVGlDmvlWSLki2DA6tI0LpTzCi2vNMUHvd07rs2u8
         fPLCcQWkUnH8uBpEADVjrV78txbJQiHWL3JQwB2n6QumHNUJ6vlMgVMp+1wUlvb3vfmQ
         cA4P3sbeXbGdT2FTx6QdKT1gC/oGOBCFoR2Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NtiMjRzmWzHX4uiypyPK/pndRvCDAWXrFCNoaRIqQmY=;
        b=VO2q8BDOfqlQUCkVxaFA6hQYC8c1wdAq8WBA3hzAHCyU4n5c1/2+UGlw/1aeVvkK47
         33RXJKbVpGhIVSXcY959RuPRcgDvw5asbtBPxJFo0S2dOFaR7diZzX+zGetkY5xRH96u
         L8831mZeGe0FxMHWrHmZWtoSg0m5fxTO+NB868srHjw+NBmzgcgmyuSv/GwHeJMS7jIH
         H3Y5pzi6SfvWEUYu0z0IMaCUzhcV+ogFzM4U8WTyj63XOxLfr0zbrYP06FhiRJZtJK/p
         VBQnmqkIp1XspBWeFUcDcE+IRN/OqEESgQ3Sk2J5GrNp6P4Fn21OU+frY0TjCl+dAyGp
         hy4Q==
X-Gm-Message-State: APzg51DFiLO8rKgsRO6pxkyTxvphKxg9GrNu/eV1G0SCjsbm9ToPfA8S
        T83zjFwSoCcShPxOdx1wjlAEoA==
X-Google-Smtp-Source: ANB0VdYa0vpeEdyl8PfUrFhNHIB/nHeQuD2LmO4fNwqdkd9EnrOGmxgqzcv1gK+MyvLtOjE3zw5Jvg==
X-Received: by 2002:a2e:8957:: with SMTP id b23-v6mr8897187ljk.50.1535369824487;
        Mon, 27 Aug 2018 04:37:04 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id u28-v6sm2241961ljd.61.2018.08.27.04.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 04:37:04 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Date:   Mon, 27 Aug 2018 13:36:04 +0200
Message-Id: <20180827113605.9594-7-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827113605.9594-1-niklas.cassel@linaro.org>
References: <20180827113605.9594-1-niklas.cassel@linaro.org>
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

