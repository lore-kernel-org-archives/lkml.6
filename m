Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ED6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6BA20831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9LF2ccG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6BA20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJ3TFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeJ3TFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:05:00 -0400
Received: from localhost.localdomain (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D2A20831;
        Tue, 30 Oct 2018 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540894330;
        bh=RYvlYxlT3Bt0+fgkhXVFLYhUcM9asU6rlWYXD2Xh/Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9LF2ccGOwXFY8BiS9aW1Nvb9s1fIx7Ennuoug0DwX/fXtWT60d3AS2yakatjkkp8
         60FPdZF2LBRW/jtgyjgUa8SNGVTfnBlr7JyHJJZWX4ys7x309uMQDLEgvzrjubTPHC
         Nrp2qQHL6cUYPOc7Uv2ZlvYRPCDFEoevGvAfkD5c=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 13/17] arm64: dts: qcom: qcs404: Add remoteproc nodes
Date:   Tue, 30 Oct 2018 15:41:04 +0530
Message-Id: <20181030101108.11041-14-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181030101108.11041-1-vkoul@kernel.org>
References: <20181030101108.11041-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the TrustZone based remoteproc nodes and their glink edges for
adsp, cdsp and wcss.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 87 ++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 6f66327014ae..c27ec1806d98 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -373,4 +373,91 @@
 			#interrupt-cells = <2>;
 		};
 	};
+
+	remoteproc-adsp {
+		compatible = "qcom,qcs404-adsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
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
+		memory-region = <&adsp_fw_mem>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		glink-edge {
+			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,remote-pid = <2>;
+			mboxes = <&apcs_glb 8>;
+
+			label = "adsp";
+		};
+	};
+
+	remoteproc-cdsp {
+		compatible = "qcom,qcs404-cdsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
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
+		memory-region = <&cdsp_fw_mem>;
+
+		qcom,smem-states = <&cdsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		glink-edge {
+			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,remote-pid = <5>;
+			mboxes = <&apcs_glb 12>;
+
+			label = "cdsp";
+		};
+	};
+
+	remoteproc-wcss {
+		compatible = "qcom,qcs404-wcss-pas";
+
+		interrupts-extended = <&intc GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
+				      <&wcss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&wcss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&wcss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&wcss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&xo_board>;
+		clock-names = "xo";
+
+		memory-region = <&wlan_fw_mem>;
+
+		qcom,smem-states = <&wcss_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		glink-edge {
+			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,remote-pid = <1>;
+			mboxes = <&apcs_glb 16>;
+
+			label = "wcss";
+		};
+	};
 };
-- 
2.14.4

