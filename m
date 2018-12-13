Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE0FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAEA20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RN+FI4aM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAEA20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeLMSdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:33:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35378 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLMSdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:33:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so1459861plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 10:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wI5gWMJsdMj64ncgmgaBtYPWUY6/Yf5A6IpwSbxIuWA=;
        b=RN+FI4aMKhbbZgU3OQ5pMoXaTIueSUf6tWHvvkI8I1WUAYv/0NcKPKuMrvlBMrZnL3
         9V8suIZUl2UsaTWvFnjdhkUfIE8aWKsoRde+hdT8WCbg0MUtgFZ6QYohakKhdLGxDjW/
         5n0SQ6yC9hpzkww2CJdV0T7IwRkMiUIQUyMHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wI5gWMJsdMj64ncgmgaBtYPWUY6/Yf5A6IpwSbxIuWA=;
        b=U+BkpIK00jD7Nba19QiF5CwFNEAdOkKmcMMYp+VJY3S0XKAujIVR6OI2ynVG4LbYlJ
         FV3Z6CqZMOSs204eAg3NwMCkPX1GTL43MHYptxl08CghSQk3fEhvJzbwyf+F7mxblxKj
         5tSmSyPFvFvn2rLTJg5L3Ke2bCJfqFu6JGkdQXgd5xEhgyy5KOH7+wEP6XWNCXH8cDZ3
         NqkmHGkeU3XKhwYJVItADnWwCLQ8yJ/mQNlQIW4TfEFpEMVW2B3kI1SrktqyHa3EJMvT
         qGYA4cgueC1dnsDUDRoKCXT7GpHo1ft7/NSSKvQ2RbCDjsnZL9xUw+dYXh1LvnBMKvqy
         4p5g==
X-Gm-Message-State: AA+aEWbo5dpoz6K9kQA8qjShgJbRRHuY+CBb+rQiZ5H4TIsNdroBgNBA
        Y4zxp2/EIY+X4ZmptaBAhpWHaQ==
X-Google-Smtp-Source: AFSGD/V9sxiGLApB3uHD3Sup2cZmeYVkxhZ6G1NP+YvN4AU7wCFnmwON6V6PPyOKpwS4XHRLvTEkBA==
X-Received: by 2002:a17:902:a411:: with SMTP id p17mr24238859plq.292.1544726024199;
        Thu, 13 Dec 2018 10:33:44 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x27sm7039022pfe.178.2018.12.13.10.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 10:33:43 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH] arm64: dts: qcom: qcs404: Fix regulator supply names
Date:   Thu, 13 Dec 2018 10:32:00 -0800
Message-Id: <20181213183200.3204-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator definition got their supply names cleaned up during
upstreaming, so they no longer match the driver defined names. Update
the supply names.

Also fill out the missing voltage of SMPS 5.

Fixes: 0b363f5b871c ("arm64: dts: qcom: qcs404: Add PMS405 RPM regulators")
Reported-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index a39924efebe4..d6cc3a96530e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -37,18 +37,18 @@
 	pms405-regulators {
 		compatible = "qcom,rpm-pms405-regulators";
 
-		vdd-s1-supply = <&vph_pwr>;
-		vdd-s2-supply = <&vph_pwr>;
-		vdd-s3-supply = <&vph_pwr>;
-		vdd-s4-supply = <&vph_pwr>;
-		vdd-s5-supply = <&vph_pwr>;
-		vdd-l1-l2-supply = <&vreg_s5_1p35>;
-		vdd-l3-l8-supply = <&vreg_s5_1p35>;
-		vdd-l4-supply = <&vreg_s5_1p35>;
-		vdd-l5-l6-supply = <&vreg_s4_1p8>;
-		vdd-l7-supply = <&vph_pwr>;
-		vdd-l9-supply = <&vreg_s5_1p35>;
-		vdd-l10-l11-l12-l13-supply = <&vph_pwr>;
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_l1_l2-supply = <&vreg_s5_1p35>;
+		vdd_l3_l8-supply = <&vreg_s5_1p35>;
+		vdd_l4-supply = <&vreg_s5_1p35>;
+		vdd_l5_l6-supply = <&vreg_s4_1p8>;
+		vdd_l7-supply = <&vph_pwr>;
+		vdd_l9-supply = <&vreg_s5_1p35>;
+		vdd_l10_l11_l12_l13-supply = <&vph_pwr>;
 
 		vreg_s4_1p8: s4 {
 			regulator-min-microvolt = <1728000>;
@@ -56,8 +56,8 @@
 		};
 
 		vreg_s5_1p35: s5 {
-			regulator-min-microvolt = <>;
-			regulator-max-microvolt = <>;
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
 		};
 
 		vreg_l1_1p3: l1 {
-- 
2.18.0

