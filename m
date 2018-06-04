Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeFDKqx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:46:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeFDKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:46:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 823FA606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
Date: Mon,  4 Jun 2018 16:16:33 +0530
Message-Id: <1528109194-16864-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
SoCs. This is required for managing the cpu frequency transitions which are
controlled by firmware.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173 +++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
new file mode 100644
index 0000000..e3087ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
@@ -0,0 +1,173 @@
+Qualcomm Technologies, Inc. CPUFREQ Bindings
+
+CPUFREQ FW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
+SoCs to manage frequency in hardware. It is capable of controlling frequency
+for multiple clusters.
+
+Properties:
+- compatible
+	Usage:		required
+	Value type:	<string>
+	Definition:	must be "qcom,cpufreq-fw".
+
+* Property qcom,freq-domain
+Devices supporting freq-domain must set their "qcom,freq-domain" property with
+phandle to a freq_domain_table in their DT node.
+
+* Frequency Domain Table Node
+
+This describes the frequency domain belonging to a device.
+This node can have following properties:
+
+- reg
+	Usage:		required
+	Value type:	<prop-encoded-array>
+	Definition:	Addresses and sizes for the memory of the perf
+			, lut and enable bases.
+			perf - indicates the base address for the desired
+			performance state to be set.
+			lut - indicates the look up table base address for the
+			cpufreq	driver to read frequencies.
+			enable - indicates the enable register for firmware.
+- reg-names
+	Usage:		required
+	Value type:	<stringlist>
+	Definition:	Address names. Must be "perf", "lut", "enable".
+			Must be specified in the same order as the reg property.
+
+Example:
+
+Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
+DCVS state together.
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&freq_domain_table0>;
+			L2_0: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+				L3_0: l3-cache {
+				      compatible = "cache";
+				};
+			};
+		};
+
+		CPU1: cpu@100 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_100>;
+			qcom,freq-domain = <&freq_domain_table0>;
+			L2_100: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU2: cpu@200 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			next-level-cache = <&L2_200>;
+			qcom,freq-domain = <&freq_domain_table0>;
+			L2_200: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU3: cpu@300 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			next-level-cache = <&L2_300>;
+			qcom,freq-domain = <&freq_domain_table0>;
+			L2_300: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU4: cpu@400 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x400>;
+			enable-method = "psci";
+			next-level-cache = <&L2_400>;
+			qcom,freq-domain = <&freq_domain_table1>;
+			L2_400: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU5: cpu@500 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x500>;
+			enable-method = "psci";
+			next-level-cache = <&L2_500>;
+			qcom,freq-domain = <&freq_domain_table1>;
+			L2_500: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU6: cpu@600 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x600>;
+			enable-method = "psci";
+			next-level-cache = <&L2_600>;
+			qcom,freq-domain = <&freq_domain_table1>;
+			L2_600: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU7: cpu@700 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x700>;
+			enable-method = "psci";
+			next-level-cache = <&L2_700>;
+			qcom,freq-domain = <&freq_domain_table1>;
+			L2_700: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+	};
+
+	qcom,cpufreq-fw {
+		compatible = "qcom,cpufreq-fw";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		freq_domain_table0 : freq_table0 {
+			reg = <0x17d43920 0x4>, <0x17d43110 0x500>,
+				 <0x17d41000 0x4>;
+			reg-names = "perf", "lut", "enable";
+		};
+
+		freq_domain_table1 : freq_table1 {
+			reg = <0x17d46120 0x4>, <0x17d45910 0x500>,
+				<0x17d45800 0x4> ;
+			reg-names = "perf", "lut", "enable";
+		};
+	};
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
