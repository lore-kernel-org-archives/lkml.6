Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCZJVp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:21:45 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:12374 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCZJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:21:44 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Xingyu Chen <xingyu.chen@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] ARM64: dts: meson-axg: add saradc support
Date: Mon, 26 Mar 2018 17:21:17 +0800
Message-ID: <20180326092117.208416-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
Hi Kevin:

  Please note, the saradc driver in Meson-AXG platfrom actually
depend on the AO clock driver [0] & saradc patch itself [1].
  And I've rebased this patch on top of your v4.17/dt64 branch

[0] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com
[1] https://lkml.kernel.org/r/20180326084629.100070-1-yixun.lan@amlogic.com

Yixun
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  5 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 57eedced5a51..bbb88debbc04 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -47,3 +47,8 @@
 	pinctrl-0 = <&i2c1_z_pins>;
 	pinctrl-names = "default";
 };
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 40ca49fb94a6..105884efc033 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -818,6 +818,27 @@
 				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
+
+			saradc: adc@9000 {
+				compatible = "amlogic,meson-axg-saradc",
+					"amlogic,meson-saradc";
+				reg = <0x0 0x9000 0x0 0x38>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>,
+					<&clkc_AO CLKID_AO_SAR_ADC>,
+					<&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					<&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+				clock-names = "clkin", "core", "adc_clk", "adc_sel";
+				status = "disabled";
+			};
 		};
 	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
 };
-- 
2.15.1
