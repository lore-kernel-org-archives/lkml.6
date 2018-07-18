Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D14ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0068205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0/20GA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0068205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeGRHUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:20:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38590 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeGRHUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:20:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so1556185pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=983ENG+uR6T3i+yZoQw2w119/pBf9+bpzs9vYk5rarE=;
        b=F0/20GA0BuCtCFnXTUAf9mmSlKh30DiHD3lYza665pIBMLkxHlgQxFC5dpB8HBTsPM
         WhLKrYWfVCFZ9NDZvRdBB9Hchbvg2y2+pyV0BU7MrEWW7CfAZ9T902gET4U/dkwXowXz
         lNUu6D9p3hUTtYY2zbqOm0D0BGEJ26FtkqDLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=983ENG+uR6T3i+yZoQw2w119/pBf9+bpzs9vYk5rarE=;
        b=CYyxta1ZWlza9kjhTujg/rb7/u8ZwpInKbmHz2bDZ7F40IhWDBwevGAl+3tSC/giiC
         Xn38LA6dglXUvciEXdLBzOnlVrg8RFfQzpdsWJCFwdCzmwzI3xyvnv/oHHywERwQuWUn
         EKSV/WGEXtoldIPQCieyH8m++fva+KHbsPkvbVAI9mi2/gGPyKr7n770QcO18oOHHmkD
         qNHwz/dbt5oOEzdgMSFv4eZkBiz5m0V4jHDmKD81IVQmW9pwoyPy5GagrG5gTvkkZxEC
         AbNUR2mfrMxWAdewWceAjjOYbIS7PiVuKOk3euPDkGZ4TcxbEuV7KNxdC3u7GX2YUH9C
         t6lQ==
X-Gm-Message-State: AOUpUlEQ7Ul51omN+2q6xQ19JIlZGd23831lu7q+APS04uVo65de2KvP
        EAzP/NvE00XHyma8X4NUO3TtQZ+8Kzo=
X-Google-Smtp-Source: AAOMgpfZKgNfmlb9HiniAnzUmmWJ00RHR2CLVkgEE3JdcIy8xB4zK1JDHo2ABujNrdAdnGxGWtSYLw==
X-Received: by 2002:a62:9f16:: with SMTP id g22-v6mr3853543pfe.207.1531896268411;
        Tue, 17 Jul 2018 23:44:28 -0700 (PDT)
Received: from localhost ([103.249.91.115])
        by smtp.gmail.com with ESMTPSA id d132-v6sm4905676pgc.93.2018.07.17.23.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 23:44:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 7/7] arm64: dts: sdm845: Add tsens nodes
Date:   Wed, 18 Jul 2018 12:13:13 +0530
Message-Id: <d263ed254f53a7e79c19ff471b5873a6f5eafd4d.1531895128.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 has two tsens blocks, one with 13 sensors and the other with 8
sensors. It uses version 2 of the TSENS IP, so use the fallback property to
allow more common code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb..01ff146 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,22 @@
 			#interrupt-cells = <2>;
 		};
 
+		tsens0: thermal-sensor@c263000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc263000 0x1ff>, /* TM */
+			      <0xc222000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c265000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc265000 0x1ff>, /* TM */
+			      <0xc223000 0x1ff>; /* SROT */
+			#qcom,sensors = <8>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.7.4

