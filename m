Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F74C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075C920666
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075C920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeKBMVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:21:06 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60938 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeKBMVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:21:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 173DC2000C9;
        Fri,  2 Nov 2018 04:15:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1915B200010;
        Fri,  2 Nov 2018 04:15:25 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EB0E4402EB;
        Fri,  2 Nov 2018 11:15:18 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] arm64: dts: nxp: add more thermal zone support
Date:   Fri,  2 Nov 2018 11:11:15 +0800
Message-Id: <20181102031115.3818-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable all the supported thermal sensors, add sensor id information
to thermal zone node.
Dts for ls1012a, ls1046a, ls1043a, ls1088a are updated.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   39 +++------------
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   59 +++++++++++------------
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   55 ++++++++++------------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   54 ++++++----------------
 4 files changed, 75 insertions(+), 132 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 68ac78c..9526b66 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -28,7 +28,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu0: cpu@0 {
+		cooling_map0: cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
@@ -100,36 +100,7 @@
 		mask = <0x02>;
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
-			polling-delay = <5000>;
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
+	#include "fsl-tmu.dtsi"
 
 	soc {
 		compatible = "simple-bus";
@@ -506,3 +477,9 @@
 		};
 	};
 };
+
+&thermal_zones {
+	thermal-zone0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7881e3d..3afc6d4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -37,7 +37,7 @@
 		 *
 		 * Currently supported enable-method is psci v0.2
 		 */
-		cpu0: cpu@0 {
+		cooling_map0: cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
@@ -146,36 +146,7 @@
 		mask = <0x02>;
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
-			polling-delay = <5000>;
-
-			thermal-sensors = <&tmu 3>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-				cpu_crit: cpu-crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
+	#include "fsl-tmu.dtsi"
 
 	timer {
 		compatible = "arm,armv8-timer";
@@ -747,3 +718,29 @@
 
 #include "qoriq-qman-portals.dtsi"
 #include "qoriq-bman-portals.dtsi"
+
+&thermal_zones {
+	thermal-zone0 {
+		status = "okay";
+	};
+
+	thermal-zone1 {
+		status = "okay";
+	};
+
+	thermal-zone2 {
+		status = "okay";
+	};
+
+	thermal-zone3 {
+		status = "okay";
+	};
+
+	thermal-zone4 {
+		status = "okay";
+	};
+
+	thermal-zone5 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index ef83786..11793ca 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -33,7 +33,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu0: cpu@0 {
+		cooling_map0: cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x0>;
@@ -115,36 +115,7 @@
 		mask = <0x02>;
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
-			polling-delay = <5000>;
-			thermal-sensors = <&tmu 3>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
+	#include "fsl-tmu.dtsi"
 
 	timer {
 		compatible = "arm,armv8-timer";
@@ -743,3 +714,25 @@
 
 #include "qoriq-qman-portals.dtsi"
 #include "qoriq-bman-portals.dtsi"
+
+&thermal_zones {
+	thermal-zone0 {
+		status = "okay";
+	};
+
+	thermal-zone1 {
+		status = "okay";
+	};
+
+	thermal-zone2 {
+		status = "okay";
+	};
+
+	thermal-zone3 {
+		status = "okay";
+	};
+
+	thermal-zone4 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612..d47f1a0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -25,7 +25,7 @@
 		#size-cells = <0>;
 
 		/* We have 2 clusters having 4 Cortex-A53 cores each */
-		cpu0: cpu@0 {
+		cooling_map0: cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
@@ -61,7 +61,7 @@
 			#cooling-cells = <2>;
 		};
 
-		cpu4: cpu@100 {
+		cooling_map1: cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x100>;
@@ -128,43 +128,7 @@
 		};
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
-			polling-delay = <5000>;
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-
-				map1 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu4 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
+	#include "fsl-tmu.dtsi"
 
 	timer {
 		compatible = "arm,armv8-timer";
@@ -648,3 +612,15 @@
 	};
 
 };
+
+#include "fsl-tmu-map1.dtsi"
+
+&thermal_zones {
+	thermal-zone0 {
+		status = "okay";
+	};
+
+	thermal-zone1 {
+		status = "okay";
+	};
+};
-- 
1.7.1

