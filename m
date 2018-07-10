Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E859C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1EF20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+PXNpCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1EF20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeGJWFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:05:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41030 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbeGJWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:05:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so8211221ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r77vFufQugD38FT6Qik0HjEm2T+usPOnxeVVlHujmEw=;
        b=B+PXNpCak3cHIOTo/g66Ui0/VvXcQQJWxK/Hx7DLIxDkmU429QzWEeNYFibQmoWNoZ
         aN/Ex2cNj/8OazpGv+3iglXbU++zaZQ2jZQhb9rz5jzIzjOvzSjYrLbL2FVli6cnqApE
         un1uTNwhrASYfDXc11AV4xIVbHSoOGbBptnFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r77vFufQugD38FT6Qik0HjEm2T+usPOnxeVVlHujmEw=;
        b=o+9wX87OPOJm4Ddzvp6oiWtSUByf2N2J8grqmqcS4H9taBPG/K4FcyBCwj6GB1RyXo
         vaqGmFOErNM23jw0fUlhfVknQ6dJpez2Uuz3yrffjzaiVdQiIh6yIEKgX8nlblAxgYDg
         /RWz4DwMN6qmCEaAYLWrsCyBQuxoSBg17MA5pVV9axZ946wdA/MkKB4UO+7H8rrUbk8Y
         3qF5XECDvXFVcmJxO3wl9FWeYOPIwQIuoXFNWY8iI406wsDwmivvg9TPepw/L6tw31Nj
         xA7tZRtuQTvryV4T5nPFDwOXzqx3cRDWuk2bpKw+ErdqRB3idMmuUjdx72lkaaaPYkLn
         alMA==
X-Gm-Message-State: APt69E07bOF+//44Ljxic6HWECjSWR5/MVbsHQhm5/yu34eDQTFrrJ9P
        IKryPW/GhH5jCEYr77d9V1o8Dg==
X-Google-Smtp-Source: AAOMgpdUsbRwKoDZNYEMTyRyKfBoTc5TmPhVtTBWVb37uNpARwWbSNCdVf/jeBkzLrJPUUAQ4ZCrGw==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10-v6mr26238448plb.224.1531260234968;
        Tue, 10 Jul 2018 15:03:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id y69-v6sm34939756pfd.36.2018.07.10.15.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 15:03:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, swboyd@chromium.org,
        tfiga@chromium.org, Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
Date:   Tue, 10 Jul 2018 15:02:00 -0700
Message-Id: <20180710220202.116404-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180710220202.116404-1-dianders@chromium.org>
References: <20180710220202.116404-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Gautam <mgautam@codeaurora.org>

This adds nodes for USB and related PHYs.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
[dianders: reworked quite a bit]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 189 +++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 15188d34a2ab..1de59a39f4fa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -249,6 +250,18 @@
 			#power-domain-cells = <1>;
 		};
 
+		qfprom@780000 {
+			compatible = "qcom,qfprom";
+			reg = <0x780000 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qusb2p_hstx_trim: hstx-trim@1eb {
+				reg = <0x1eb 0x1>;
+				bits = <1 4>;
+			};
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x8c0000 0x6000>;
@@ -961,6 +974,182 @@
 			};
 		};
 
+		usb_1_hsphy: phy@88e2000 {
+			compatible = "qcom,sdm845-qusb2-phy";
+			reg = <0x88e2000 0x400>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			nvmem-cells = <&qusb2p_hstx_trim>;
+		};
+
+		usb_2_hsphy: phy@88e3000 {
+			compatible = "qcom,sdm845-qusb2-phy";
+			reg = <0x88e3000 0x400>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+		};
+
+		usb_1_qmpphy: phy@88e9000 {
+			compatible = "qcom,sdm845-qmp-usb3-phy";
+			reg = <0x88e9000 0x18c>,
+			      <0x88e8000 0x10>;
+			reg-names = "reg-base", "dp_com";
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+
+			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
+			reset-names = "phy", "common";
+
+			usb_1_ssphy: lane@88e9200 {
+				reg = <0x88e9200 0x128>,
+				      <0x88e9400 0x200>,
+				      <0x88e9c00 0x218>,
+				      <0x88e9a00 0x100>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
+		usb_2_qmpphy: phy@88eb000 {
+			compatible = "qcom,sdm845-qmp-usb3-uni-phy";
+			reg = <0x88eb000 0x18c>;
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+
+			resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
+				 <&gcc GCC_USB3_PHY_SEC_BCR>;
+			reset-names = "phy", "common";
+
+			usb_2_ssphy: lane@88eb200 {
+				reg = <0x88eb200 0x128>,
+				      <0x88eb400 0x1fc>,
+				      <0x88eb800 0x218>,
+				      <0x88e9600 0x70>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_uni_phy_pipe_clk_src";
+			};
+		};
+
+		usb_1: usb@a6f8800 {
+			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
+			reg = <0xa6f8800 0x400>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+				      "sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <150000000>;
+
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			usb_1_dwc3: dwc3@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0xa600000 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
+		usb_2: usb@a8f8800 {
+			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
+			reg = <0xa8f8800 0x400>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+				      "sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <150000000>;
+
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_SEC_GDSC>;
+
+			resets = <&gcc GCC_USB30_SEC_BCR>;
+
+			usb_2_dwc3: dwc3@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0xa800000 0xcd00>;
+				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_2_hsphy>, <&usb_2_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.18.0.203.gfac676dfb9-goog

