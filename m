Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A0C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9890A218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKXNYUjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfBFFNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:13:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40003 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfBFFNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:13:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so2418054pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jBPy0BCogKNseYJcIvB8uJfzudS8Sr9y75W4AtxYtoc=;
        b=dKXNYUjLUW8z8GvDR1xLm+3bFXFqFtT9u0J7f//ld8CCA8ZaauK8ErwhzKngAhjAwY
         Jb86uDn2jxNMw0TONnz/3U2+tbuGidKkC8xR2rjzYwSYiXnGb4toAwYNYSc1L3Ju/Uk/
         VNUnoMBQW2Uo2lKlEP6Hxrl0MPxYb9BfMpIDgnkTwgEQiQ6BMk6miksoZ6WLkUZIIGrn
         jfPaCduO1K6Rjw2ZantKB9/8aewzAxYSAIwGTG7i3eHHIClusIaPLyAMy1GALMjKtTN8
         R4+hOR50sTvs3rJCyr9K6jg+rXQMC7SFBycZeJNTmxSnx74NHk/z24rorpLTDFkHMAw8
         ye5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jBPy0BCogKNseYJcIvB8uJfzudS8Sr9y75W4AtxYtoc=;
        b=Gz/A11uL0goDjiATOIdZ8eOsX0gS0ca7SMVGHOoWoaP61h7YZmJX4j4SphTHHMpJM+
         LGJERVYGlmOKYh6b9PUjfkVp4gsiH0mZm29XTowj8/k8aTAv73mBgYEwvGF+wsHyOGZO
         HMFQP41u0rGTiVwOlnHmpNYmvZl05KwZDY3Oqlu6ezMoyuY5SLnMsRZP7mZy6WHcKwY6
         Ze5tYO71g9aqQyG7hAe91UeYJxzx52ngcmuJ3HyzXwy5wuyhDtZbthO3MLBYOGKYq+u2
         SX3QM2DJLVy+iMzjw58Ct7ByvkUP3Fxoqn1ZLXtfTwBSoVmxoCvq8FRYCSaK3UvKKgSZ
         hAxQ==
X-Gm-Message-State: AHQUAuZpN09IwUDmyfoYr66pfENRP4WmjKE+PiEVxDzOQQyTIq0QhIte
        MHtohhGB958Hyh7mIxOKzX1fLw==
X-Google-Smtp-Source: AHgI3IZFmEELaSCcsRwB4RDnAAy41n0qmHt67B2BT/H/viI6YpmPpaHothYeYKdi8wdHIseZSkWbRw==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr7874228pgk.190.1549430025738;
        Tue, 05 Feb 2019 21:13:45 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71sm10735012pfi.123.2019.02.05.21.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:13:44 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
Date:   Tue,  5 Feb 2019 21:13:30 -0800
Message-Id: <20190206051335.23799-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206051335.23799-1-bjorn.andersson@linaro.org>
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Audio DSP (ADSP) and Compute DSP (CDSP) nodes for TrustZone
based remoteproc, supporting booting these cores on e.g. the MTP, and
enable the same for the MTP.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 58 +++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 89071463a84a..2e78638eb73b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -48,6 +48,10 @@
 	};
 };
 
+&adsp_pas {
+	status = "okay";
+};
+
 &apps_rsc {
 	pm8998-rpmh-regulators {
 		compatible = "qcom,pm8998-rpmh-regulators";
@@ -344,6 +348,10 @@
 	};
 };
 
+&cdsp_pas {
+	status = "okay";
+};
+
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			   <GCC_QSPI_CORE_CLK_SRC>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index a33d27b3a389..12efbdb1fa2e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -324,6 +324,64 @@
 		};
 	};
 
+	adsp_pas: remoteproc-adsp {
+		compatible = "qcom,sdm845-adsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>;
+		clock-names = "xo";
+
+		memory-region = <&adsp_mem>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+			label = "lpass";
+			qcom,remote-pid = <2>;
+			mboxes = <&apss_shared 8>;
+		};
+	};
+
+	cdsp_pas: remoteproc-cdsp {
+		compatible = "qcom,sdm845-cdsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>;
+		clock-names = "xo";
+
+		memory-region = <&cdsp_mem>;
+
+		qcom,smem-states = <&cdsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>;
+			label = "turing";
+			qcom,remote-pid = <5>;
+			mboxes = <&apss_shared 4>;
+		};
+	};
+
 	tcsr_mutex: hwlock {
 		compatible = "qcom,tcsr-mutex";
 		syscon = <&tcsr_mutex_regs 0 0x1000>;
-- 
2.18.0

