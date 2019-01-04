Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF8C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21552087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfADTVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:21:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:26731 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfADTVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:21:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 11:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="107019242"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2019 11:21:39 -0800
From:   thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH] arm64: dts: stratix10: Add Stratix10 SMMU support
Date:   Fri,  4 Jan 2019 13:23:46 -0600
Message-Id: <1546629826-1167-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Now there are device tree clocks for the ARM64 SMMU,
add SMMU support to the Stratix10 Device Tree which
includes adding the SMMU node and adding IOMMU stream
ids to the SMMU peripherals.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index b2c9bb664595..e3f5eaa3657d 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -161,6 +161,7 @@
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
+			iommus = <&smmu 1>;
 			status = "disabled";
 		};
 
@@ -177,6 +178,7 @@
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
+			iommus = <&smmu 2>;
 			status = "disabled";
 		};
 
@@ -193,6 +195,7 @@
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
+			iommus = <&smmu 3>;
 			status = "disabled";
 		};
 
@@ -303,6 +306,7 @@
 			clocks = <&clkmgr STRATIX10_L4_MP_CLK>,
 				 <&clkmgr STRATIX10_SDMMC_CLK>;
 			clock-names = "biu", "ciu";
+			iommus = <&smmu 5>;
 			status = "disabled";
 		};
 
@@ -336,6 +340,29 @@
 			reg = <0xffd11000 0x1000>;
 		};
 
+		smmu: iommu@fa000000 {
+			compatible = "arm,mmu-500", "arm,smmu-v2";
+			reg = <0xfa000000 0x40000>;
+			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
+			clock-names = "iommu";
+			interrupt-parent = <&intc>;
+			interrupts = <0 128 4>,	/* Global Secure Fault */
+				<0 129 4>, /* Global Non-secure Fault */
+				/* Non-secure Context Interrupts (32) */
+				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
+				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
+				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
+				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
+				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
+				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
+				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
+				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
+			stream-match-mask = <0x7ff0>;
+			status = "disabled";
+		};
+
 		spi0: spi@ffda4000 {
 			compatible = "snps,dw-apb-ssi";
 			#address-cells = <1>;
@@ -445,6 +472,7 @@
 			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
 			clocks = <&clkmgr STRATIX10_USB_CLK>;
+			iommus = <&smmu 6>;
 			status = "disabled";
 		};
 
@@ -457,6 +485,7 @@
 			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
 			clocks = <&clkmgr STRATIX10_USB_CLK>;
+			iommus = <&smmu 7>;
 			status = "disabled";
 		};
 
-- 
2.7.4

