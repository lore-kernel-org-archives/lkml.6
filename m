Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BFE21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnnzFMqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfAVFwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:52:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39856 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfAVFvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:51:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so11213507pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 21:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kRXJdEO8I/SlhbNJiF5XYNK/PWPlwRsErJzpDvsBh7A=;
        b=RnnzFMqVPwZXf6lbGg26UrDC1U31+Y2IVKtIin52AUk8gWv2E7oFKRnGa6S4KYmAmZ
         HH3hKspDqqPSyuo9XGTF1xH5sj6JjTKtPJpullhS1uQ4GDN9XvzP5nTypcjfUJ7yaSfb
         mAi/SXjKUWL8knanbKy1bfLb6ipDb9YRFab9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kRXJdEO8I/SlhbNJiF5XYNK/PWPlwRsErJzpDvsBh7A=;
        b=jvhyFZOCPfHDpTUs8E5TJjZNeo5JB06ppdHAEIOor3kaMIgfuTjPZ/ksN5n1b9l8dg
         JEv6VwXHrKY6JZ3gq6zy6mqcF3xs8kHiX4A3V/ymMQAviZ8Hd5VGJqIXjw7swA1Q0awV
         YanoUxVvmE6ilNNIeSmMeNH7dSst8uu01locwogRkx/jpIpBwxSEjgOqYsy55ck1TUk7
         Rh1F7VIYz7H8D7a7MmjIMHDaop3SuL+rU37iasMdjxdH5KlziUPjcpT6SnJ5BjOshbqL
         0UfRIWVzu+CuRaltebjwXcNHEjrIvwD3VUAsGSS6Wd3v7aGq33f6RASqKakVVC1l9fuC
         xhhA==
X-Gm-Message-State: AJcUukcYWKo2jsEhj1pW+e8r6+ho1r22Ul24xHaTUDTAGMvmoErdleG+
        B34pr3yQkRLA1NjfnVrDAdruBQ==
X-Google-Smtp-Source: ALg8bN6jt3cD5HSf+9YDjigyHAzbQgpiTbsPW3wVOsisVRZSmq7Y31Wl2cGWMp3ZIvrrbDpAAYNF1g==
X-Received: by 2002:a63:da14:: with SMTP id c20mr2291579pgh.233.1548136309012;
        Mon, 21 Jan 2019 21:51:49 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z62sm23771572pfl.33.2019.01.21.21.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 21:51:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
Date:   Mon, 21 Jan 2019 21:51:05 -0800
Message-Id: <20190122055112.30943-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122055112.30943-1-bjorn.andersson@linaro.org>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ADSP and CDSP nodes for PAS-based remoteproc, supporting booting
these cores on e.g. the MTP, and enable the same for the MTP.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 58 +++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index af8c6a2445a2..02b8357c8ce8 100644
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
index 64f57cc5c61a..1033b77856e6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -319,6 +319,64 @@
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
+		clocks = <&xo_board>;
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
+		clocks = <&xo_board>;
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

