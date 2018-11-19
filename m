Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0797C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B3020831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/8MFWFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B3020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeKSWte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:49:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44323 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbeKSWte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:49:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id j17-v6so31811932wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vbujpZlR3xwCQtHN+6i4d1gyZCoKcwoCzl86pAegAMo=;
        b=G/8MFWFL/2b/pz78l1CvrUfCvTR63oUZyGVoJDnd4pU0iEETt3KEAIlDSYGzANK6td
         t/iNHC9qBHA5qlFYMe/gBF7qmX6LhFWfb8wjR0X9PPOgRlYSzX8pOPt9gCDYDufbFxal
         mM+QOUyUqOHj9uETDRP9NYe/UBH5Li2LC9KT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vbujpZlR3xwCQtHN+6i4d1gyZCoKcwoCzl86pAegAMo=;
        b=minsqE+K7oD3P8bj7c8jwd7yObkAbqkqlHP1Mg6r1h1itkfCCbB9Q0WMm8jxoIre6N
         rn0oGRb7S9qx2KWjlPAe6SwRfUj7H+V8AwmnP16iIOOZ5RRK839v1WHT8rbcrZTMHL9m
         W8Yw/MPNqBeh9RXipKsa5bJEITWjl3vDL3PkclbjhH2zfuZqK7oZwasymoCtyOWhm2yy
         1DwKp8murTVSU8Ujd/PwlK/afZC9eeAyKC4Qsx91f5pxFZkaqUIw5CtShzlfDb+4kR7Y
         /j0RU0Hhuq4nDdsPCacVFG9t6oV9dF5/J6BEvBYtGNkYy3cT+WnNV6skHIIoovL9rGb8
         c97A==
X-Gm-Message-State: AGRZ1gJ45RNAm8ZS1GnWG6LV9vLQT9vaL+sT2jxeePIrB+KASTfAWKfm
        bTSxAg9aopIUzYAOt7Q4EVM3o/WJM4M=
X-Google-Smtp-Source: AJdET5eOpfYI6WvgA5Qt4LfcVCE1vdgu4tJ4aLhqoHVteVyTKX2KC030+7I76CCee3lsbTRtKVY4CQ==
X-Received: by 2002:adf:df0a:: with SMTP id y10-v6mr18346814wrl.127.1542630364278;
        Mon, 19 Nov 2018 04:26:04 -0800 (PST)
Received: from localhost ([49.248.195.80])
        by smtp.gmail.com with ESMTPSA id u8-v6sm27063818wrr.33.2018.11.19.04.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 04:26:03 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 3/4] arm64: dts: qcom: qcs404: Add tsens controller
Date:   Mon, 19 Nov 2018 17:55:21 +0530
Message-Id: <ea728b3e42858f62daf8e4a8658adda813043ff7.1542629810.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1542629810.git.amit.kucheria@linaro.org>
References: <cover.1542629810.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1542629810.git.amit.kucheria@linaro.org>
References: <cover.1542629810.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has a single TSENS IP block with 10 sensors. The calibration data
is stored in an eeprom (qfprom) that is accessed through the nvmem
framework. We add the qfprom node to allow the tsens sensors to be
calibrated correctly.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c16562bbe4..57d14d8f0c901 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -253,6 +253,16 @@
 			reg = <0x00060000 0x6000>;
 		};
 
+		qfprom: qfprom@a4000 {
+			compatible = "qcom,qfprom";
+			reg = <0x000a4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			tsens_caldata: caldata@d0 {
+				reg = <0x1f8 0x14>;
+			};
+		};
+
 		rng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
@@ -260,6 +270,16 @@
 			clock-names = "core";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+			nvmem-cells = <&tsens_caldata>;
+			nvmem-cell-names = "calib";
+			#qcom,sensors = <10>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,qcs404-pinctrl";
 			reg = <0x01000000 0x200000>,
-- 
2.17.1

