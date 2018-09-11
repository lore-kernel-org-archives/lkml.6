Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1A1C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA1820839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA1820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeIKPQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:16:27 -0400
Received: from foss.arm.com ([217.140.101.70]:41238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbeIKPQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:16:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 789FF15B2;
        Tue, 11 Sep 2018 03:17:48 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B00A3F557;
        Tue, 11 Sep 2018 03:17:46 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH 03/11] dts: spreadtrum: Update coresight bindings for hardware ports
Date:   Tue, 11 Sep 2018 11:17:04 +0100
Message-Id: <1536661032-30481-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new coresight bindings for hw ports

Cc: orsonzhai@gmail.com
Cc: zhang.lyra@gmail.com
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/sprd/sc9836.dtsi |  74 ++++++++------
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 183 +++++++++++++++++++++--------------
 2 files changed, 151 insertions(+), 106 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
index 63894c4..416f271 100644
--- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
@@ -50,10 +50,11 @@
 		reg = <0 0x10003000 0 0x1000>;
 		clocks = <&clk26mhz>;
 		clock-names = "apb_pclk";
-		port {
-			etf_in: endpoint {
-				slave-mode;
-				remote-endpoint = <&funnel_out_port0>;
+		in-ports {
+			port {
+				etf_in: endpoint {
+					remote-endpoint = <&funnel_out_port0>;
+				};
 			};
 		};
 	};
@@ -63,55 +64,54 @@
 		reg = <0 0x10001000 0 0x1000>;
 		clocks = <&clk26mhz>;
 		clock-names = "apb_pclk";
-		ports {
+
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* funnel output port */
 			port@0 {
 				reg = <0>;
 				funnel_out_port0: endpoint {
 					remote-endpoint = <&etf_in>;
 				};
 			};
+		};
 
-			/* funnel input port 0-4 */
-			port@1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm0_out>;
 				};
 			};
 
-			port@2 {
+			port@1 {
 				reg = <1>;
 				funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm1_out>;
 				};
 			};
 
-			port@3 {
+			port@2 {
 				reg = <2>;
 				funnel_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm2_out>;
 				};
 			};
 
-			port@4 {
+			port@3 {
 				reg = <3>;
 				funnel_in_port3: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm3_out>;
 				};
 			};
 
-			port@5 {
+			port@4 {
 				reg = <4>;
 				funnel_in_port4: endpoint {
-					slave-mode;
 					remote-endpoint = <&stm_out>;
 				};
 			};
@@ -126,9 +126,11 @@
 		cpu = <&cpu0>;
 		clocks = <&clk26mhz>;
 		clock-names = "apb_pclk";
-		port {
-			etm0_out: endpoint {
-				remote-endpoint = <&funnel_in_port0>;
+		out-ports {
+			port {
+				etm0_out: endpoint {
+					remote-endpoint = <&funnel_in_port0>;
+				};
 			};
 		};
 	};
@@ -140,9 +142,11 @@
 		cpu = <&cpu1>;
 		clocks = <&clk26mhz>;
 		clock-names = "apb_pclk";
-		port {
-			etm1_out: endpoint {
-				remote-endpoint = <&funnel_in_port1>;
+		out-ports {
+			port {
+				etm1_out: endpoint {
+					remote-endpoint = <&funnel_in_port1>;
+				};
 			};
 		};
 	};
@@ -154,9 +158,11 @@
 		cpu = <&cpu2>;
 		clocks = <&clk26mhz>;
 		clock-names = "apb_pclk";
-		port {
-			etm2_out: endpoint {
-				remote-endpoint = <&funnel_in_port2>;
+		out-ports {
+			port {
+				etm2_out: endpoint {
+					remote-endpoint = <&funnel_in_port2>;
+				};
 			};
 		};
 	};
@@ -168,9 +174,11 @@
 		cpu = <&cpu3>;
 		clocks = <&clk26mhz>;
 		clock-names = "apb_pclk";
-		port {
-			etm3_out: endpoint {
-				remote-endpoint = <&funnel_in_port3>;
+		out-ports {
+			port {
+				etm3_out: endpoint {
+					remote-endpoint = <&funnel_in_port3>;
+				};
 			};
 		};
 	};
@@ -182,9 +190,11 @@
 		reg-names = "stm-base", "stm-stimulus-base";
 		clocks = <&clk26mhz>;
 		clock-names = "apb_pclk";
-		port {
-			stm_out: endpoint {
-				remote-endpoint = <&funnel_in_port4>;
+		out-ports {
+			port {
+				stm_out: endpoint {
+					remote-endpoint = <&funnel_in_port4>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 48f5928..50aef73 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -304,7 +304,7 @@
 			reg = <0 0x10001000 0 0x1000>;
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -314,20 +314,23 @@
 						remote-endpoint = <&etb_in>;
 					};
 				};
+			};
 
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					soc_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint =
 						<&main_funnel_out_port>;
 					};
 				};
 
-				port@2 {
+				port@4 {
 					reg = <4>;
 					soc_funnel_in_port1: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&stm_out_port>;
 					};
@@ -340,11 +343,12 @@
 			reg = <0 0x10003000 0 0x1000>;
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
-			port {
-				etb_in: endpoint {
-					slave-mode;
-					remote-endpoint =
-						<&soc_funnel_out_port>;
+			out-ports {
+				port {
+					etb_in: endpoint {
+						remote-endpoint =
+							<&soc_funnel_out_port>;
+					};
 				};
 			};
 		};
@@ -356,10 +360,12 @@
 			reg-names = "stm-base", "stm-stimulus-base";
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
-			port {
-				stm_out_port: endpoint {
-					remote-endpoint =
-						<&soc_funnel_in_port1>;
+			out-ports {
+				port {
+					stm_out_port: endpoint {
+						remote-endpoint =
+							<&soc_funnel_in_port1>;
+					};
 				};
 			};
 		};
@@ -369,7 +375,7 @@
 			reg = <0 0x11001000 0 0x1000>;
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -380,27 +386,29 @@
 							<&cluster0_etf_in>;
 					};
 				};
+			};
 
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					cluster0_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out>;
 					};
 				};
 
-				port@2 {
+				port@1 {
 					reg = <1>;
 					cluster0_funnel_in_port1: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm1_out>;
 					};
 				};
 
-				port@3 {
+				port@2 {
 					reg = <2>;
 					cluster0_funnel_in_port2: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm2_out>;
 					};
 				};
@@ -408,7 +416,6 @@
 				port@4 {
 					reg = <4>;
 					cluster0_funnel_in_port3: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm3_out>;
 					};
 				};
@@ -420,7 +427,7 @@
 			reg = <0 0x11002000 0 0x1000>;
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -431,35 +438,36 @@
 							<&cluster1_etf_in>;
 					};
 				};
+			};
 
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					cluster1_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm4_out>;
 					};
 				};
 
-				port@2 {
+				port@1 {
 					reg = <1>;
 					cluster1_funnel_in_port1: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm5_out>;
 					};
 				};
 
-				port@3 {
+				port@2 {
 					reg = <2>;
 					cluster1_funnel_in_port2: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm6_out>;
 					};
 				};
 
-				port@4 {
+				port@3 {
 					reg = <3>;
 					cluster1_funnel_in_port3: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm7_out>;
 					};
 				};
@@ -472,7 +480,7 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -483,11 +491,15 @@
 						<&main_funnel_in_port0>;
 					};
 				};
+			};
 
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					cluster0_etf_in: endpoint {
-						slave-mode;
 						remote-endpoint =
 						<&cluster0_funnel_out_port>;
 					};
@@ -501,7 +513,7 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -512,11 +524,15 @@
 						<&main_funnel_in_port1>;
 					};
 				};
+			};
 
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					cluster1_etf_in: endpoint {
-						slave-mode;
 						remote-endpoint =
 						<&cluster1_funnel_out_port>;
 					};
@@ -530,7 +546,7 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -541,20 +557,23 @@
 							<&soc_funnel_in_port0>;
 					};
 				};
+			};
 
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					main_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&cluster0_etf_out>;
 					};
 				};
 
-				port@2 {
+				port@1 {
 					reg = <1>;
 					main_funnel_in_port1: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&cluster1_etf_out>;
 					};
@@ -569,10 +588,12 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm0_out: endpoint {
-					remote-endpoint =
-						<&cluster0_funnel_in_port0>;
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_in_port0>;
+					};
 				};
 			};
 		};
@@ -584,10 +605,12 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm1_out: endpoint {
-					remote-endpoint =
-						<&cluster0_funnel_in_port1>;
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_in_port1>;
+					};
 				};
 			};
 		};
@@ -599,10 +622,12 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm2_out: endpoint {
-					remote-endpoint =
-						<&cluster0_funnel_in_port2>;
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_in_port2>;
+					};
 				};
 			};
 		};
@@ -614,10 +639,12 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm3_out: endpoint {
-					remote-endpoint =
-						<&cluster0_funnel_in_port3>;
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_in_port3>;
+					};
 				};
 			};
 		};
@@ -629,10 +656,12 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm4_out: endpoint {
-					remote-endpoint =
-						<&cluster1_funnel_in_port0>;
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_in_port0>;
+					};
 				};
 			};
 		};
@@ -644,10 +673,12 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm5_out: endpoint {
-					remote-endpoint =
-						<&cluster1_funnel_in_port1>;
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_in_port1>;
+					};
 				};
 			};
 		};
@@ -659,10 +690,12 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm6_out: endpoint {
-					remote-endpoint =
-						<&cluster1_funnel_in_port2>;
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_in_port2>;
+					};
 				};
 			};
 		};
@@ -674,10 +707,12 @@
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm7_out: endpoint {
-					remote-endpoint =
-						<&cluster1_funnel_in_port3>;
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_in_port3>;
+					};
 				};
 			};
 		};
-- 
2.7.4

