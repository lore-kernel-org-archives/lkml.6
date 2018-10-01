Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F37C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9808D2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="qe7WJwEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9808D2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeJAMGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:06:30 -0400
Received: from onstation.org ([52.200.56.107]:35974 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbeJAMGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:06:30 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 98D459B2;
        Mon,  1 Oct 2018 05:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538371830;
        bh=yA2WiXTlP9dLrmeDmE35z5ov7S0QuUp4U6jefRVM23E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qe7WJwEmHKtf84QEJf6mLWA2moQ0EU4yG/sD8vLX+aMqWhw8wP0v91tWDFt/9qYO+
         lcXdr7pRZ5qGpKIRdsSS+pZ8wcrZmMBvansKml8eihl1hYM13Dk79Eyga17QNKcoPN
         SbA5E6l9cu/gIR2U73byBr8C8m26Z2rlAfKPN5rM=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, david.brown@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH RFC 5/5] ARM: dts: qcom: msm8974-hammerhead: add USB OTG support
Date:   Mon,  1 Oct 2018 01:30:05 -0400
Message-Id: <20181001053005.18906-6-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001053005.18906-1-masneyb@onstation.org>
References: <20181001053005.18906-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

Add the device tree bindings for USB OTG support. Driver was tested
using on a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Brian Masney <masneyb@onstation.org>
Tested-by: Brian Masney <masneyb@onstation.org>
---
See my cover letter for a question about how I can convert this patch
over to use a gpio-hog to get rid of the otg-en-gpios property.

 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 54 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index e67d61f25a96..71e308d8628d 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -243,6 +243,16 @@
 			};
 		};
 
+		i2c1_pins: i2c1 {
+			mux {
+				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
 		i2c3_pins: i2c3 {
 			mux {
 				pins = "gpio10", "gpio11";
@@ -382,6 +392,25 @@
 		};
 	};
 
+	i2c@f9923000 {
+		status = "ok";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_pins>;
+		clock-frequency = <100000>;
+		qcom,src-freq = <50000000>;
+
+		charger: bq24192@6b {
+			compatible = "ti,bq24192";
+			reg = <0x6b>;
+			interrupts-extended = <&spmi_bus 0 0xd5 0 IRQ_TYPE_EDGE_FALLING>;
+
+			omit-battery-class;
+
+			otg-en-gpios = <&pm8941_gpios 35 GPIO_ACTIVE_HIGH>;
+			usb_otg_vbus: usb-otg-vbus { };
+		};
+	};
+
 	i2c@f9925000 {
 		status = "ok";
 		pinctrl-names = "default";
@@ -399,6 +428,31 @@
 			amstaos,proximity-diodes = <0>;
 		};
 	};
+
+	usb@f9a55000 {
+		status = "ok";
+
+		phys = <&usb_hs1_phy>;
+		phy-select = <&tcsr 0xb000 0>;
+
+		extcon = <&charger>, <&usb_id>;
+		vbus-supply = <&usb_otg_vbus>;
+
+		hnp-disable;
+		srp-disable;
+		adp-disable;
+
+		ulpi {
+			phy@a {
+				status = "ok";
+
+				v1p8-supply = <&pm8941_l6>;
+				v3p3-supply = <&pm8941_l24>;
+
+				qcom,init-seq = /bits/ 8 <0x1 0x64>;
+			};
+		};
+	};
 };
 
 &spmi_bus {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index a808973f9dc7..0bd584695ae8 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -704,6 +704,17 @@
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		i2c@f9923000 {
+			status = "disabled";
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9923000 0x1000>;
+			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		i2c@f9924000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
-- 
2.17.1

