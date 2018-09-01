Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32BCC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 22:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4537A20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 22:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAUvO+gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4537A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeIBCff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 22:35:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35951 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeIBCff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 22:35:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so6995838plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kA1RAQ3SM5mO3p+BXP++ZWoTDtO9ytm3z5oALV7bmWw=;
        b=aAUvO+gn7Ni5qL3pV3up/VzKzgjux0ggAbUrIhOS92EsNCA5r7huUYwFWAowkNohR/
         5fMFYADRJtLGr70ITYLqSbByytfsSx/1Ly/HnARz0xeyI1eQ1Jw3rZNdom1R7T6QKGfU
         5K7spbTMi6DnBiROVr83VjMw9tq8f3ftpeYso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kA1RAQ3SM5mO3p+BXP++ZWoTDtO9ytm3z5oALV7bmWw=;
        b=GMTeG7vfaR9McI6aHWij6EY7nvmh2o39Xt05Fimea9Hcbmo2sG8amgPHVjEqGh+pKp
         jdcWdVVVBRVkr9HMcMkGu9diHTDgK6pYkGZxbOQgodZHnd2cALe9XuoSQsckbVlaEUBF
         0lDtj8jHVPWTf6Rs5wpY9UBqKWKqMVcisyFLWmXQrBZFKRY/xQYKWE87aLXgDlhzTLWU
         DHN1eY6j6sOo+J8hCxAbSWfFFCG1AbeawlKPLAOwLGEWRZbeK7wumybw4f1TvN4FoWjL
         KC+YBHcB0MHXf+b0uZhK6qdbDgR/cktGyZi1joHD5o8Gf+gndHqHtifVV03+/I5ZyoQb
         vQxA==
X-Gm-Message-State: APzg51BpSQA8+t0Moye6F2hmXkFYKX2C38CnFwMIL1IwJ3O5T1D6sOE+
        WOanq5wHQhOHpMT7ZvsNIAn6aw==
X-Google-Smtp-Source: ANB0VdZuH+UY5dvp5ajxFz/H6WIQ5FBBsdPNMRv3RO98kZnGpACZViJRiRad0IGYz3KuZzKKCoxnCw==
X-Received: by 2002:a17:902:934c:: with SMTP id g12-v6mr21575107plp.67.1535840530100;
        Sat, 01 Sep 2018 15:22:10 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j13-v6sm16352992pgq.56.2018.09.01.15.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 15:22:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Add AOSS reset driver node for SDM845
Date:   Sat,  1 Sep 2018 15:23:55 -0700
Message-Id: <20180901222355.21803-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

This patch adds the node to support AOSS reset driver on
SDM845

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
[bjorn: Updated addresses to match the binding that was merged]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c9a2aa6a1b5..077760792cf0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/reset/qcom,sdm845-aoss.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -978,6 +979,12 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		aoss_reset: reset-controller@c2a0000 {
+			compatible = "qcom,sdm845-aoss-cc";
+			reg = <0xc2a0000 0x31000>;
+			#reset-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.18.0

