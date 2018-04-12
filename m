Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeDLLPx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:15:53 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35648 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbeDLLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:15:25 -0400
X-Google-Smtp-Source: AIpwx48n2Bo1GT2Uhv/dWp+TpReoUUIrsjVRGJeZw6qAx/G6Cj/OS0dFxxp4OLGlDYGnNWOwQsCEhQ==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Subject: [PATCH v7 26/26] arm64: dts: Convert to the hierarchical CPU topology layout for MSM8916
Date: Thu, 12 Apr 2018 13:14:31 +0200
Message-Id: <1523531671-27491-27-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

In the hierarchical layout, we are creating power domains around each CPU
and describes the idle states for them inside the power domain provider
node.  Note that, the CPU's idle states still needs to be compatible with
"arm,idle-state".

Furthermore, represent the CPU cluster as a separate master power domain,
powering the CPU's power domains. The cluster node, contains the idle
states for the cluster and each idle state needs to be compatible with the
"domain-idle-state".

If the running platform is using a PSCI FW that supports the OS initiated
CPU suspend mode, which likely should be the case unless the PSCI FW is
very old, this change makes the PSCI driver to enable it.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 53 ++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 66b318e..aff4b91 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -113,10 +113,10 @@
 			reg = <0x0>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD0>;
 		};
 
 		CPU1: cpu@1 {
@@ -125,10 +125,10 @@
 			reg = <0x1>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD1>;
 		};
 
 		CPU2: cpu@2 {
@@ -137,10 +137,10 @@
 			reg = <0x2>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD2>;
 		};
 
 		CPU3: cpu@3 {
@@ -149,10 +149,10 @@
 			reg = <0x3>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD3>;
 		};
 
 		L2_0: l2-cache {
@@ -169,12 +169,57 @@
 				min-residency-us = <2000>;
 				local-timer-stop;
 			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-gdhs {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
 		};
 	};
 
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SPC>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SPC>;
+		};
+
+		CPU_PD2: cpu-pd2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SPC>;
+		};
+
+		CPU_PD3: cpu-pd3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_SPC>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+		};
 	};
 
 	pmu {
-- 
2.7.4
