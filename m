Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC6FC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D698218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfA3Im0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:42:26 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60674 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfA3ImV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:42:21 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id C130D5FD01; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        Andre Przywara <andre.przywara@arm.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] ARM: dts: bananapi-m2-plus: Add CPU supply regulator
Date:   Wed, 30 Jan 2019 16:41:55 +0800
Message-Id: <20190130084203.25053-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original Bananapi M2+ uses a fixed regulator to supply the CPU
cores. According to Bananapi, the retail v1.1 version is designed to
supply 1.3V. Actual measurements show 1.310V. Earlier engineering
samples had it at 1.4V, but this is not covered here.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 30 +++++++------------
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 14 +++++++++
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
index a567567763f4..39834329b6ae 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
@@ -5,27 +5,19 @@
 
 #include "sunxi-bananapi-m2-plus.dtsi"
 
-/ {
+&reg_vdd_cpux {
 	/*
 	 * Bananapi M2+ v1.2 uses a GPIO line to change the effective
 	 * resistance on the CPU regulator's feedback pin.
 	 */
-	reg_vdd_cpux: vdd-cpux {
-		compatible = "regulator-gpio";
-		regulator-name = "vdd-cpux";
-		regulator-type = "voltage";
-		regulator-boot-on;
-		regulator-always-on;
-		regulator-min-microvolt = <1108475>;
-		regulator-max-microvolt = <1308475>;
-		regulator-ramp-delay = <50>; /* 4ms */
-		gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
-		gpios-states = <0x1>;
-		states = <1108475 0x0
-			  1308475 0x1>;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&reg_vdd_cpux>;
+	compatible = "regulator-gpio";
+	regulator-type = "voltage";
+	regulator-min-microvolt = <1108475>;
+	regulator-max-microvolt = <1308475>;
+	regulator-ramp-delay = <50>; /* 4ms */
+	enable-gpios =  <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
+	gpios-states = <0x1>;
+	states = <1108475 0x0
+		  1308475 0x1>;
 };
diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index 3bed375b9c03..eb90f53ae958 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -99,6 +99,16 @@
 		      gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
 	};
 
+	reg_vdd_cpux: vdd-cpux {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpux";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1310000>;
+		regulator-max-microvolt = <1310000>;
+		gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -108,6 +118,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
 &de {
 	status = "okay";
 };
-- 
2.20.1

