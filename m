Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB5EC282CA
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16C42133D
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="kLPnCnWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfAYQXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:23:37 -0500
Received: from onstation.org ([52.200.56.107]:55028 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbfAYQXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:23:13 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 43AE1853;
        Fri, 25 Jan 2019 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1548433392;
        bh=ZZc/a5ejspeqnRSsAutrcFfbg8XjdF+sInooQkTsOEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLPnCnWGjfdnG8TLAZ3NoC/cPGqAHuZwyvlsuzkXjMm7qpsrbQkr1btrKji2KZTaH
         lok6lYdAsNpCLMnHznMGsEdIBvtoV7er26Q/XbDyj2s8T1e+6bB5NnOKjf5Nz/X6Ow
         5s5dZHSuHewPcNiokAHovyq90j6mAHn7h5Taym8g=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 8/9] arm: dts: qcom: mdm9615: add interrupt controller properties
Date:   Fri, 25 Jan 2019 11:23:01 -0500
Message-Id: <20190125162302.14036-9-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190125162302.14036-1-masneyb@onstation.org>
References: <20190125162302.14036-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt controller properties now that ssbi-gpio is a proper
hierarchical IRQ chip. The interrupts property is no longer needed so
remove it.

Note that the IRQs started at 24 instead of 192 like all of the other
PMICs. This is the same IRQs as the MPP for this board. qcom-pm8xxx.c
doesn't set the shared IRQs so this is highly likely to be a copy and
paste error.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index c852b69229c9..0ed6fc3e873c 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -323,13 +323,8 @@
 
 				pmicgpio: gpio@150 {
 					compatible = "qcom,pm8018-gpio", "qcom,ssbi-gpio";
-					interrupt-parent = <&pmicintc>;
-					interrupts = <24 IRQ_TYPE_NONE>,
-						     <25 IRQ_TYPE_NONE>,
-						     <26 IRQ_TYPE_NONE>,
-						     <27 IRQ_TYPE_NONE>,
-						     <28 IRQ_TYPE_NONE>,
-						     <29 IRQ_TYPE_NONE>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
-- 
2.17.2

