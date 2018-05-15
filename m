Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeEOCzS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:55:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33767 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeEOCzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:55:14 -0400
X-Google-Smtp-Source: AB8JxZp4l5pdo4DtraZK9Kv/JvMLgJp0ZslMZ7lEGztxLVEGzKaL0eGE8J5gwEdtMz8gIulY0tYKOg==
From: Leo Yan <leo.yan@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Tao Wang <jean.wangtao@linaro.org>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/5] arm64: dts: hi3660: Add thermal cooling management
Date: Tue, 15 May 2018 10:53:14 +0800
Message-Id: <1526352795-6991-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
References: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Wang <jean.wangtao@linaro.org>

Add nodes and properties for thermal cooling management support.

Signed-off-by: Tao Wang <jean.wangtao@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index a39da09..e20edd9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi3660-clock.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "hisilicon,hi3660";
@@ -64,6 +65,8 @@
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <110>;
 		};
 
 		cpu1: cpu@1 {
@@ -112,6 +115,8 @@
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <550>;
 		};
 
 		cpu5: cpu@101 {
@@ -1073,5 +1078,44 @@
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			#thermal-sensor-cells = <1>;
 		};
+
+		thermal-zones {
+
+			cls0: cls0 {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				sustainable-power = <4500>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsensor 1>;
+
+				trips {
+					threshold: trip-point@0 {
+						temperature = <65000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+
+					target: trip-point@1 {
+						temperature = <75000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&target>;
+						contribution = <1024>;
+						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+					map1 {
+						trip = <&target>;
+						contribution = <512>;
+						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
1.9.1
