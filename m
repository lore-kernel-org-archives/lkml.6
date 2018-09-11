Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E52AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530DE20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530DE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeIKPQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:16:45 -0400
Received: from foss.arm.com ([217.140.101.70]:41352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbeIKPQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:16:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649AD1688;
        Tue, 11 Sep 2018 03:18:06 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 751A43F557;
        Tue, 11 Sep 2018 03:18:04 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 11/11] dts: tc2: Update coresight bindings for hardware ports
Date:   Tue, 11 Sep 2018 11:17:12 +0100
Message-Id: <1536661032-30481-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new coresight bindings

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 90 +++++++++++++++++-------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index ac6b90e..3a50906 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -393,10 +393,11 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etb_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port0>;
+		in-ports {
+			port {
+				etb_in_port: endpoint {
+					remote-endpoint = <&replicator_out_port0>;
+				};
 			};
 		};
 	};
@@ -407,10 +408,11 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			tpiu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port1>;
+		in-ports {
+			port {
+				tpiu_in_port: endpoint {
+					remote-endpoint = <&replicator_out_port1>;
+				};
 			};
 		};
 	};
@@ -421,11 +423,10 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* replicator output ports */
 			port@0 {
 				reg = <0>;
 				replicator_out_port0: endpoint {
@@ -439,12 +440,15 @@
 					remote-endpoint = <&tpiu_in_port>;
 				};
 			};
+		};
 
-			/* replicator input port */
-			port@2 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				replicator_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&funnel_out_port0>;
 				};
 			};
@@ -457,11 +461,10 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* funnel output port */
 			port@0 {
 				reg = <0>;
 				funnel_out_port0: endpoint {
@@ -469,28 +472,29 @@
 						<&replicator_in_port0>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port@1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm0_out_port>;
 				};
 			};
 
-			port@2 {
+			port@1 {
 				reg = <1>;
 				funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm1_out_port>;
 				};
 			};
 
-			port@3 {
+			port@2 {
 				reg = <2>;
 				funnel_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm0_out_port>;
 				};
 			};
@@ -500,7 +504,6 @@
 			port@4 {
 				reg = <4>;
 				funnel_in_port4: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm1_out_port>;
 				};
 			};
@@ -508,7 +511,6 @@
 			port@5 {
 				reg = <5>;
 				funnel_in_port5: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm2_out_port>;
 				};
 			};
@@ -522,9 +524,11 @@
 		cpu = <&cpu0>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			ptm0_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port0>;
+		out-ports {
+			port {
+				ptm0_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port0>;
+				};
 			};
 		};
 	};
@@ -536,9 +540,11 @@
 		cpu = <&cpu1>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			ptm1_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port1>;
+		out-ports {
+			port {
+				ptm1_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port1>;
+				};
 			};
 		};
 	};
@@ -550,9 +556,11 @@
 		cpu = <&cpu2>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm0_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port2>;
+		out-ports {
+			port {
+				etm0_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port2>;
+				};
 			};
 		};
 	};
@@ -564,9 +572,11 @@
 		cpu = <&cpu3>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm1_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port4>;
+		out-ports {
+			port {
+				etm1_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port4>;
+				};
 			};
 		};
 	};
@@ -578,9 +588,11 @@
 		cpu = <&cpu4>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm2_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port5>;
+		out-ports {
+			port {
+				etm2_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port5>;
+				};
 			};
 		};
 	};
-- 
2.7.4

