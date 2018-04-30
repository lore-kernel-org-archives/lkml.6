Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeD3Oox (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:44:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbeD3Oou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:44:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2F2B60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2] arm64: dts: qcom: Add SDM845 SMEM nodes
Date: Mon, 30 Apr 2018 20:14:28 +0530
Message-Id: <20180430144428.3288-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the necessary dt nodes to support SMEM driver
on SDM845. It also adds the required memory carveouts
so that the kernel does not access memory that is in
use.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

This patch depends on:
https://patchwork.kernel.org/patch/10276419/
https://patchwork.kernel.org/patch/10363361/

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9be763da0664..55e7d7e23b10 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -21,6 +21,27 @@
 		reg = <0 0x80000000 0 0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		memory@85fc0000 {
+			reg = <0 0x85fc0000 0 0x20000>;
+			no-map;
+		};
+
+		smem_mem: memory@86000000 {
+			reg = <0x0 0x86000000 0x0 0x200000>;
+			no-map;
+		};
+
+		memory@86200000 {
+			reg = <0 0x86200000 0 0x2d00000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -147,6 +168,18 @@
 		};
 	};
 
+	tcsr_mutex: hwlock {
+		compatible = "qcom,tcsr-mutex";
+		syscon = <&tcsr_mutex_regs 0 0x1000>;
+		#hwlock-cells = <1>;
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -339,6 +372,11 @@
 			};
 		};
 
+		tcsr_mutex_regs: syscon@1f40000 {
+			compatible = "syscon";
+			reg = <0x1f40000 0x40000>;
+		};
+
 		apss_shared: mailbox@17990000 {
 			compatible = "qcom,sdm845-apss-shared";
 			reg = <0x17990000 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
