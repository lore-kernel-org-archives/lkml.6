Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAB4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EB9208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="KeWK4Bcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EB9208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeGKBTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:19:02 -0400
Received: from onstation.org ([52.200.56.107]:37630 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732310AbeGKBSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:18:55 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E9F861949;
        Wed, 11 Jul 2018 01:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531271386;
        bh=nYbPB/pwfcByXIVH+dRspHVWo6UIgVLvdE+xkl/jA1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeWK4Bcu5AGkGr52CAZJR+e5GxeDDoOdh5jDVuVY02QUSLMCEleeLY5l4bLkgPCor
         hj79jKa2qkF7qWE0awTUhuuHInwqcNwVK3dnSr2L0gX/wyJa/Ki3tY3064PCs1TQB5
         EBVtZ6CnQMTMmhuKUBh+LgswLGUzH/SLAWBfOOis=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        masneyb@onstation.org
Subject: [PATCH 3/3] ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for mpu6515
Date:   Tue, 10 Jul 2018 21:09:32 -0400
Message-Id: <20180711010932.20313-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711010932.20313-1-masneyb@onstation.org>
References: <20180711010932.20313-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree bindings for the mpu6515 to the LG Nexus 5
(hammerhead) phone. Confirmed that the gyroscope / accelerometer
(mpu6515), magnetometer (ak8963), and temperature / pressure (bmp280)
sensors are available on the phone.

Interrupts are not working properly on the ak8963 magnetometer so they
are currently not configured.

The bmp280 retuns temperature/pressure measurement skipped errors but
will reliably work if I run:

    echo 1 > in_pressure_oversampling_ratio
    echo 1 > in_temp_oversampling_ratio

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
I'll send follow up patch(es) once I investigate why the skipped errors
are occurring with the bmp280 with the default oversampling ratios.

 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 56 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index c2dc9d09484a..96158044ca10 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -241,6 +241,24 @@
 				bias-pull-up;
 			};
 		};
+
+		i2c12_pins: i2c12 {
+			mux {
+				pins = "gpio87", "gpio88";
+				function = "blsp_i2c12";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
+		mpu6515_pin: mpu6515 {
+			irq {
+				pins = "gpio73";
+				function = "gpio";
+				bias-disable;
+				input-enable;
+			};
+		};
 	};
 
 	sdhci@f9824900 {
@@ -277,6 +295,44 @@
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 	};
+
+	i2c@f9968000 {
+		status = "ok";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c12_pins>;
+		clock-frequency = <100000>;
+		qcom,src-freq = <50000000>;
+
+		mpu6515@68 {
+			compatible = "invensense,mpu6515";
+			reg = <0x68>;
+			interrupts-extended = <&msmgpio 73 IRQ_TYPE_EDGE_FALLING>;
+			vddio-supply = <&pm8941_lvs1>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&mpu6515_pin>;
+
+			i2c-gate {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				ak8963@f {
+					compatible = "asahi-kasei,ak8963";
+					reg = <0x0f>;
+					// Device currently only works in polling mode.
+					// gpios = <&msmgpio 61 0>;
+					vid-supply = <&pm8941_lvs1>;
+					vdd-supply = <&pm8941_l17>;
+				};
+
+				bmp280@76 {
+					compatible = "bosch,bmp280";
+					reg = <0x76>;
+					vdda-supply = <&pm8941_lvs1>;
+					vddd-supply = <&pm8941_l17>;
+				};
+			};
+		};
+	};
 };
 
 &spmi_bus {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a49b292..cebb6ae9143a 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -737,6 +737,17 @@
 			dma-names = "tx", "rx";
 		};
 
+		blsp_i2c12: i2c@f9968000 {
+			status = "disabled";
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9968000 0x1000>;
+			interrupts = <0 106 IRQ_TYPE_NONE>;
+			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		spmi_bus: spmi@fc4cf000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg-names = "core", "intr", "cnfg";
-- 
2.17.1

