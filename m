Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AEAC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC7E20890
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC7E20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIKPQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:16:30 -0400
Received: from foss.arm.com ([217.140.101.70]:41250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbeIKPQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7A1F1682;
        Tue, 11 Sep 2018 03:17:50 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6B6E3F557;
        Tue, 11 Sep 2018 03:17:48 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH 04/11] dts: qcom: Update coresight bindings for hardware ports
Date:   Tue, 11 Sep 2018 11:17:05 +0100
Message-Id: <1536661032-30481-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to updated coresight bindings for hw ports

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 98 ++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7b32b89..5bed52b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1099,10 +1099,11 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			port {
-				tpiu_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out1>;
+			out-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint = <&replicator_out1>;
+					};
 				};
 			};
 		};
@@ -1114,7 +1115,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1132,11 +1133,16 @@
 				port@4 {
 					reg = <4>;
 					funnel0_in4: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel1_out>;
 					};
 				};
-				port@8 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					funnel0_out: endpoint {
 						remote-endpoint = <&etf_in>;
@@ -1152,7 +1158,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1162,16 +1168,22 @@
 						remote-endpoint = <&etr_in>;
 					};
 				};
+
 				port@1 {
 					reg = <1>;
 					replicator_out1: endpoint {
 						remote-endpoint = <&tpiu_in>;
 					};
 				};
-				port@2 {
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					replicator_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&etf_out>;
 					};
 				};
@@ -1185,18 +1197,23 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
 					etf_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel0_out>;
 					};
 				};
-				port@1 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					etf_out: endpoint {
 						remote-endpoint = <&replicator_in>;
@@ -1212,10 +1229,11 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			port {
-				etr_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out0>;
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint = <&replicator_out0>;
+					};
 				};
 			};
 		};
@@ -1227,39 +1245,41 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
 					funnel1_in0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out>;
 					};
 				};
 				port@1 {
 					reg = <1>;
 					funnel1_in1: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm1_out>;
 					};
 				};
 				port@2 {
 					reg = <2>;
 					funnel1_in2: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm2_out>;
 					};
 				};
 				port@3 {
 					reg = <3>;
 					funnel1_in3: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm3_out>;
 					};
 				};
-				port@4 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					funnel1_out: endpoint {
 						remote-endpoint = <&funnel0_in4>;
@@ -1309,9 +1329,11 @@
 
 			cpu = <&CPU0>;
 
-			port {
-				etm0_out: endpoint {
-				remote-endpoint = <&funnel1_in0>;
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&funnel1_in0>;
+					};
 				};
 			};
 		};
@@ -1325,9 +1347,11 @@
 
 			cpu = <&CPU1>;
 
-			port {
-				etm1_out: endpoint {
-					remote-endpoint = <&funnel1_in1>;
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&funnel1_in1>;
+					};
 				};
 			};
 		};
@@ -1341,9 +1365,11 @@
 
 			cpu = <&CPU2>;
 
-			port {
-				etm2_out: endpoint {
-					remote-endpoint = <&funnel1_in2>;
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&funnel1_in2>;
+					};
 				};
 			};
 		};
@@ -1357,9 +1383,11 @@
 
 			cpu = <&CPU3>;
 
-			port {
-				etm3_out: endpoint {
-					remote-endpoint = <&funnel1_in3>;
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&funnel1_in3>;
+					};
 				};
 			};
 		};
-- 
2.7.4

