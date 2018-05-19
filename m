Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeESRfX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 13:35:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeESRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 13:35:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F04A1602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
Date: Sat, 19 May 2018 23:04:50 +0530
Message-Id: <1526751291-17873-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
SoCs. This is required for managing the cpu frequency transitions which are
controlled by firmware.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
new file mode 100644
index 0000000..bc912f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
@@ -0,0 +1,68 @@
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
+Note that #address-cells, #size-cells, and ranges shall be present to ensure
+the cpufreq can address a freq-domain registers.
+
+A freq-domain sub-node would be defined for the cpus with the following
+properties:
+
+- compatible:
+	Usage:		required
+	Value type:	<string>
+	Definition:	must be "cpufreq".
+
+- reg
+	Usage:		required
+	Value type:	<prop-encoded-array>
+	Definition:	Addresses and sizes for the memory of the perf_base
+			, lut_base and en_base.
+- reg-names
+	Usage:		required
+	Value type:	<stringlist>
+	Definition:	Address names. Must be "perf_base", "lut_base",
+			"en_base".
+			Must be specified in the same order as the
+			corresponding addresses are specified in the reg
+			property.
+
+- qcom,cpulist
+	Usage:		required
+	Value type:	<phandles of CPU>
+	Definition:	List of related cpu handles which are under a cluster.
+
+Example:
+	qcom,cpufreq-fw {
+		compatible = "qcom,cpufreq-fw";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		freq-domain-0 {
+			compatible = "cpufreq";
+			reg = <0x17d43920 0x4>,
+			     <0x17d43110 0x500>,
+			     <0x17d41000 0x4>;
+			reg-names = "perf_base", "lut_base", "en_base";
+			qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3>;
+		};
+
+		freq-domain-1 {
+			compatible = "cpufreq";
+			reg = <0x17d46120 0x4>,
+			    <0x17d45910 0x500>,
+			    <0x17d45800 0x4>;
+			reg-names = "perf_base", "lut_base", "en_base";
+			qcom,cpulist = <&CPU4 &CPU5 &CPU6 &CPU7>;
+		};
+	};
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
