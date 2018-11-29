Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A6C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCBE2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lp/KPDuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCBE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeK3JVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:21:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40010 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeK3JVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:21:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so1714284pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=22X9W5SJJprXsXAG56nZhOGU8DoyVlO99wlxyqdHEMA=;
        b=lp/KPDuKzVvgrOrtK6tJLzEaj6KtGjK8wcHcc//612Ptd717OFD1pn45qK4fiBNo71
         CrBLvkqIvLnSZq32bjSGXuN971j4+f+uu1erGQl+gHHI+VcLG0qyH92WUmWz+bCso59t
         mLwm+zzP2IVVztnCpWIKMwykDluiIKYZnfXyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=22X9W5SJJprXsXAG56nZhOGU8DoyVlO99wlxyqdHEMA=;
        b=oKwL8aDSQSHF5DjfPUbJSikBWecVVF1u2tClOp6phKXOnSPlMrABxxKzx+BobRugkD
         3z+qbTb6eLNPTlHFxmg/KyF8XnbQ8rcTd09TeHUWOruebSrxvbm4rJnXBnFwuudSP1ee
         i0cBhsBRC2JcsBCMc9rBaSku7p6WSIqK1HMeqcyE4afEVmYLjm7/HTheejRCyJaNox/c
         vqCAU/H8SrSgre4tpxYvBbmjGMnMJvASB1rMRKzibYttudxY93fYhr7dyH/dY384fLAU
         LoOZZEuJKZYPcCnIGUtIWtet6NAd7a1DzPQGls5JMTzk6TDH47EHKCqy3Eo97mxYzX+/
         PC7Q==
X-Gm-Message-State: AA+aEWarneOwC/CDcaskNcPdW5wVhxChDeErdQILoKL9uhUWca5VDPsO
        kYpcIb4LMta9+b1PmLLfNTR0bQ==
X-Google-Smtp-Source: AFSGD/Wpb4tCpa0Aj4ZO5NdxDguuNIWWfVRREUdZXoPJ9HaMTKXFjSGyIwXO+0g7pCZlOoDQLDQzgw==
X-Received: by 2002:a62:7e93:: with SMTP id z141mr3062204pfc.239.1543529685347;
        Thu, 29 Nov 2018 14:14:45 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id c67sm4697690pfg.170.2018.11.29.14.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 14:14:44 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v1 3/4] arm64: dts: qcom: sdm845: Fix QMP PHY #clock-cells
Date:   Thu, 29 Nov 2018 14:13:56 -0800
Message-Id: <20181129221357.67417-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181129221357.67417-1-evgreen@chromium.org>
References: <20181129221357.67417-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move #clock-cells into the child node for instances of the qcom-qmp-phy
nodes, and set it to zero, in accordance with the proper bindings. PHYs
that don't provide clocks don't have #clock-cells, and so are left alone.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 61a7cee153eae..4582db5e86350 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1178,7 +1178,6 @@
 			      <0x88e8000 0x10>;
 			reg-names = "reg-base", "dp_com";
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1200,6 +1199,7 @@
 				      <0x88e9600 0x128>,
 				      <0x88e9800 0x200>,
 				      <0x88e9a00 0x100>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
@@ -1211,7 +1211,6 @@
 			compatible = "qcom,sdm845-qmp-usb3-uni-phy";
 			reg = <0x88eb000 0x18c>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1231,6 +1230,7 @@
 				      <0x88eb400 0x1fc>,
 				      <0x88eb800 0x218>,
 				      <0x88e9600 0x70>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
-- 
2.18.1

