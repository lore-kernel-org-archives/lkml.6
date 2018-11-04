Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96C7C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F3F2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="eRNizsVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F3F2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbeKEHHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:07:22 -0500
Received: from onstation.org ([52.200.56.107]:56674 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbeKEHHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:07:22 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 604D211;
        Sun,  4 Nov 2018 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541368255;
        bh=oiJ2+5ruPJPT8yD+1W31PoOLNLdV1G1GQagb4ttwu7c=;
        h=From:To:Cc:Subject:Date:From;
        b=eRNizsVD2uS9a1hBe9tzVKTu4JBdo3LaIiMJoJuOJh+6nsPqC7N3WC72gaPPS4p9E
         DnVL6/x9O7aQb3RI+W6VPQo5L+OqW0QQ/bMweANaNCiAp5sLFg7SrSMsJzIa0psttl
         oNxstjvJBUi72i3PetfGqzkUNEv5vletLlLKEIjU=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH] ARM: dts: qcom: msm8974-hammerhead: add WiFi support
Date:   Sun,  4 Nov 2018 16:50:34 -0500
Message-Id: <20181104215034.3677-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

This patch adds WiFi support to the LG Nexus 5 (hammerhead) phone.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
[masneyb@onstation.org: Enabled wlan_regulator_pin and wlan_sleep_clk_pin]
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index fe2b5524a679..7fad5a48d4a3 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -221,6 +221,20 @@
 			};
 		};
 	};
+
+	vreg_wlan: wlan-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wl-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_regulator_pin>;
+	};
 };
 
 &soc {
@@ -253,6 +267,20 @@
 			};
 		};
 
+		sdhc2_pin_a: sdhc2-pin-active {
+			clk {
+				pins = "sdc2_clk";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			cmd-data {
+				pins = "sdc2_cmd", "sdc2_data";
+				drive-strength = <6>;
+				bias-pull-up;
+			};
+		};
+
 		i2c3_pins: i2c3 {
 			mux {
 				pins = "gpio10", "gpio11";
@@ -324,6 +352,32 @@
 		pinctrl-0 = <&sdhc1_pin_a>;
 	};
 
+	sdhci@f98a4900 {
+		status = "ok";
+
+		max-frequency = <100000000>;
+		bus-width = <4>;
+		non-removable;
+		vmmc-supply = <&vreg_wlan>;
+		vqmmc-supply = <&pm8941_s3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdhc2_pin_a>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		bcrmf@1 {
+			compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
+			reg = <1>;
+
+			brcm,drive-strength = <10>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&wlan_sleep_clk_pin>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		input-name = "gpio-keys";
@@ -463,6 +517,22 @@
 				output-high;
 				line-name = "otg-gpio";
 			};
+
+			wlan_sleep_clk_pin: wl-sleep-clk {
+				pins = "gpio16";
+				function = "func2";
+
+				output-high;
+				power-source = <PM8941_GPIO_S3>;
+			};
+
+			wlan_regulator_pin: wl-reg-active {
+				pins = "gpio17";
+				function = "normal";
+
+				bias-disable;
+				power-source = <PM8941_GPIO_S3>;
+			};
 		};
 	};
 };
-- 
2.17.2

