Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeB0OK7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:10:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753392AbeB0OJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:09:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B820760FB1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org, sricharan@codeaurora.org,
        linux@arm.linux.org.uk
Subject: [PATCH v8 15/15] dt-bindings: cpufreq: Document operating-points-v2-krait-cpu
Date: Tue, 27 Feb 2018 19:37:02 +0530
Message-Id: <1519740422-3835-16-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
that has KRAIT processors the voltage/current value of each OPP
varies based on the silicon variant in use.
operating-points-v2-krait-cpu specifies the phandle to nvmem efuse cells
and the operating-points-v2 table for each opp. The qcom-cpufreq driver
reads the efuse value from the SoC to provide the required information
that is used to determine the voltage and current value for each OPP of
operating-points-v2 table when it is parsed by the OPP framework.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/cpufreq/krait-cpufreq.txt  | 363 +++++++++++++++++++++
 1 file changed, 363 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
new file mode 100644
index 0000000..7b083c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
@@ -0,0 +1,363 @@
+QCOM KRAIT CPUFreq and OPP bindings
+===================================
+
+In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
+that has KRAIT processors the voltage value of each OPP varies
+based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
+defines the voltage and current value based on the speed/pvs/version
+combination blown in the efuse. The qcom-cpufreq driver reads the efuse
+value from the SoC to provide the OPP framework with required information.
+This is used to determine the voltage and current value for each OPP of
+operating-points-v2 table when it is parsed by the OPP framework.
+
+Required properties:
+--------------------
+In 'cpus' nodes:
+- operating-points-v2: Phandle to the operating-points-v2 table to use.
+
+In 'operating-points-v2' table:
+- compatible: Should be
+	- 'operating-points-v2-krait-cpu' for ipq8064, apq8064, msm8960,
+					      msm8974.
+- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
+		efuse registers that has information about the
+		speedbin/pvs/version that is used to select the right
+		voltage/current value pair. Note that the length field of the
+		nvmem-cell is used to differentiate between format 'A' or 'B'
+		efuse settings. len of '4' bytes is for format 'A' and '8'
+		bytes for format 'B'. Please refer the for nvmem-cells
+		bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
+		and also examples below for both the cases.
+Example 1:
+---------
+
+/* For arch/arm/boot/dts/apq8064.dtsi --> format 'A' */
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	CPU0: cpu@0 {
+		compatible = "qcom,krait";
+		enable-method = "qcom,kpss-acc-v1";
+		device_type = "cpu";
+		reg = <0>;
+		next-level-cache = <&L2>;
+		qcom,acc = <&acc0>;
+		qcom,saw = <&saw0>;
+		cpu-idle-states = <&CPU_SPC>;
+		operating-points-v2 = <&cpu_opp_table>;
+	};
+};
+
+qfprom: qfprom@700000 {
+	compatible      = "qcom,qfprom";
+	reg	      = <0x00700000 0x1000>;
+	#address-cells  = <1>;
+	#size-cells     = <1>;
+	ranges;
+	pvs_efuse: pvs {
+		reg = <0xc0 0x4>;
+	};
+};
+
+cpu_opp_table: opp-table {
+	compatible = "operating-points-v2-krait-cpu";
+	nvmem-cells = <&pvs_efuse>;
+
+		/*
+		 * Missing opp-shared property means CPUs switch DVFS states
+		 * independently.
+		 */
+
+		opp-918000000 {
+			opp-hz = /bits/ 64 <918000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1100000>;
+			opp-microvolt-speed0-pvs1-v0 = <1050000>;
+			opp-microvolt-speed0-pvs3-v0 = <1000000>;
+			opp-microvolt-speed0-pvs4-v0 = <975000>;
+			opp-microvolt-speed1-pvs0-v0 = <1025000>;
+			opp-microvolt-speed1-pvs1-v0 = <1000000>;
+			opp-microvolt-speed1-pvs2-v0 = <950000>;
+			opp-microvolt-speed1-pvs3-v0 = <925000>;
+			opp-microvolt-speed1-pvs4-v0 = <900000>;
+			opp-microvolt-speed1-pvs5-v0 = <900000>;
+			opp-microvolt-speed1-pvs6-v0 = <900000>;
+			opp-microvolt-speed2-pvs0-v0 = <975000>;
+			opp-microvolt-speed2-pvs1-v0 = <950000>;
+			opp-microvolt-speed2-pvs2-v0 = <925000>;
+			opp-microvolt-speed2-pvs3-v0 = <912500>;
+			opp-microvolt-speed2-pvs4-v0 = <900000>;
+			opp-microvolt-speed2-pvs5-v0 = <900000>;
+			opp-microvolt-speed2-pvs6-v0 = <900000>;
+			opp-microvolt-speed14-pvs0-v0 = <1025000>;
+			opp-microvolt-speed14-pvs1-v0 = <1000000>;
+			opp-microvolt-speed14-pvs2-v0 = <950000>;
+			opp-microvolt-speed14-pvs3-v0 = <925000>;
+			opp-microvolt-speed14-pvs4-v0 = <900000>;
+			opp-microvolt-speed14-pvs5-v0 = <900000>;
+			opp-microvolt-speed14-pvs6-v0 = <900000>;
+		};
+
+		opp-810000000 {
+			opp-hz = /bits/ 64 <810000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1075000>;
+			opp-microvolt-speed0-pvs1-v0 = <1025000>;
+			opp-microvolt-speed0-pvs3-v0 = <975000>;
+			opp-microvolt-speed0-pvs3-v0 = <962500>;
+			opp-microvolt-speed1-pvs0-v0 = <1000000>;
+			opp-microvolt-speed1-pvs1-v0 = <975000>;
+			opp-microvolt-speed1-pvs2-v0 = <937500>;
+			opp-microvolt-speed1-pvs3-v0 = <900000>;
+			opp-microvolt-speed1-pvs4-v0 = <887500>;
+			opp-microvolt-speed1-pvs5-v0 = <887500>;
+			opp-microvolt-speed1-pvs6-v0 = <887500>;
+			opp-microvolt-speed2-pvs0-v0 = <962500>;
+			opp-microvolt-speed2-pvs1-v0 = <937500>;
+			opp-microvolt-speed2-pvs2-v0 = <912500>;
+			opp-microvolt-speed2-pvs3-v0 = <900000>;
+			opp-microvolt-speed2-pvs4-v0 = <887500>;
+			opp-microvolt-speed2-pvs5-v0 = <887500>;
+			opp-microvolt-speed2-pvs6-v0 = <887500>;
+			opp-microvolt-speed14-pvs0-v0 = <1000000>;
+			opp-microvolt-speed14-pvs1-v0 = <975000>;
+			opp-microvolt-speed14-pvs2-v0 = <937500>;
+			opp-microvolt-speed14-pvs3-v0 = <900000>;
+			opp-microvolt-speed14-pvs4-v0 = <887500>;
+			opp-microvolt-speed14-pvs5-v0 = <887500>;
+			opp-microvolt-speed14-pvs6-v0 = <887500>;
+		};
+
+		opp-702000000 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1025000>;
+			opp-microvolt-speed0-pvs1-v0 = <975000>;
+			opp-microvolt-speed0-pvs3-v0 = <925000>;
+			opp-microvolt-speed0-pvs3-v0 = <925000>;
+			opp-microvolt-speed1-pvs0-v0 = <962500>;
+			opp-microvolt-speed1-pvs1-v0 = <962500>;
+			opp-microvolt-speed1-pvs2-v0 = <925000>;
+			opp-microvolt-speed1-pvs3-v0 = <900000>;
+			opp-microvolt-speed1-pvs4-v0 = <875000>;
+			opp-microvolt-speed1-pvs5-v0 = <875000>;
+			opp-microvolt-speed1-pvs6-v0 = <875000>;
+			opp-microvolt-speed2-pvs0-v0 = <950000>;
+			opp-microvolt-speed2-pvs1-v0 = <925000>;
+			opp-microvolt-speed2-pvs2-v0 = <900000>;
+			opp-microvolt-speed2-pvs3-v0 = 900000>;
+			opp-microvolt-speed2-pvs4-v0 = <875000>;
+			opp-microvolt-speed2-pvs5-v0 = <875000>;
+			opp-microvolt-speed2-pvs6-v0 = <875000>;
+			opp-microvolt-speed14-pvs0-v0 = <962500>;
+			opp-microvolt-speed14-pvs1-v0 = <962500>;
+			opp-microvolt-speed14-pvs2-v0 = <925000>;
+			opp-microvolt-speed14-pvs3-v0 = <900000>;
+			opp-microvolt-speed14-pvs4-v0 = <875000>;
+			opp-microvolt-speed14-pvs5-v0 = <875000>;
+			opp-microvolt-speed14-pvs6-v0 = <875000>;
+		};
+
+		opp-594000000 {
+			opp-hz = /bits/ 64 <594000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1000000>;
+			opp-microvolt-speed0-pvs1-v0 = <950000>;
+			opp-microvolt-speed0-pvs3-v0 = <900000>;
+			opp-microvolt-speed0-pvs3-v0 = <900000>;
+			opp-microvolt-speed1-pvs0-v0 = <950000>;
+			opp-microvolt-speed1-pvs1-v0 = <950000>;
+			opp-microvolt-speed1-pvs2-v0 = <925000>;
+			opp-microvolt-speed1-pvs3-v0 = <900000>;
+			opp-microvolt-speed1-pvs4-v0 = <875000>;
+			opp-microvolt-speed1-pvs5-v0 = <875000>;
+			opp-microvolt-speed1-pvs6-v0 = <875000>;
+			opp-microvolt-speed2-pvs0-v0 = <950000>;
+			opp-microvolt-speed2-pvs1-v0 = <925000>;
+			opp-microvolt-speed2-pvs2-v0 = <900000>;
+			opp-microvolt-speed2-pvs3-v0 = <900000>;
+			opp-microvolt-speed2-pvs4-v0 = <875000>;
+			opp-microvolt-speed2-pvs5-v0 = <875000>;
+			opp-microvolt-speed2-pvs6-v0 = <875000>;
+			opp-microvolt-speed14-pvs0-v0 = <950000>;
+			opp-microvolt-speed14-pvs1-v0 = <950000>;
+			opp-microvolt-speed14-pvs2-v0 = <925000>;
+			opp-microvolt-speed14-pvs3-v0 = <900000>;
+			opp-microvolt-speed14-pvs4-v0 = <875000>;
+			opp-microvolt-speed14-pvs5-v0 = <875000>;
+			opp-microvolt-speed14-pvs6-v0 = <875000>;
+		};
+
+		opp-486000000 {
+			opp-hz = /bits/ 64 <486000000>;
+			opp-microvolt-speed0-pvs0-v0 = <975000>;
+			opp-microvolt-speed0-pvs1-v0 = <925000>;
+			opp-microvolt-speed0-pvs3-v0 = <875000>;
+			opp-microvolt-speed0-pvs3-v0 = <875000>;
+			opp-microvolt-speed1-pvs0-v0 = <950000>;
+			opp-microvolt-speed1-pvs1-v0 = <950000>;
+			opp-microvolt-speed1-pvs2-v0 = <925000>;
+			opp-microvolt-speed1-pvs3-v0 = <900000>;
+			opp-microvolt-speed1-pvs4-v0 = <875000>;
+			opp-microvolt-speed1-pvs5-v0 = <875000>;
+			opp-microvolt-speed1-pvs6-v0 = <875000>;
+			opp-microvolt-speed2-pvs0-v0 = <950000>;
+			opp-microvolt-speed2-pvs1-v0 = <925000>;
+			opp-microvolt-speed2-pvs2-v0 = <900000>;
+			opp-microvolt-speed2-pvs3-v0 = <900000>;
+			opp-microvolt-speed2-pvs4-v0 = <875000>;
+			opp-microvolt-speed2-pvs5-v0 = <875000>;
+			opp-microvolt-speed2-pvs6-v0 = <875000>;
+			opp-microvolt-speed14-pvs0-v0 = <950000>;
+			opp-microvolt-speed14-pvs1-v0 = <950000>;
+			opp-microvolt-speed14-pvs2-v0 = <925000>;
+			opp-microvolt-speed14-pvs3-v0 = <900000>;
+			opp-microvolt-speed14-pvs4-v0 = <875000>;
+			opp-microvolt-speed14-pvs5-v0 = <875000>;
+			opp-microvolt-speed14-pvs6-v0 = <875000>;
+		};
+
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt-speed0-pvs0-v0 = <950000>;
+			opp-microvolt-speed0-pvs1-v0 = <900000>;
+			opp-microvolt-speed0-pvs3-v0 = <850000>;
+			opp-microvolt-speed0-pvs3-v0 = <850000>;
+			opp-microvolt-speed1-pvs0-v0 = <950000>;
+			opp-microvolt-speed1-pvs1-v0 = <950000>;
+			opp-microvolt-speed1-pvs2-v0 = <925000>;
+			opp-microvolt-speed1-pvs3-v0 = <900000>;
+			opp-microvolt-speed1-pvs4-v0 = <875000>;
+			opp-microvolt-speed1-pvs5-v0 = <875000>;
+			opp-microvolt-speed1-pvs6-v0 = <875000>;
+			opp-microvolt-speed2-pvs0-v0 = <950000>;
+			opp-microvolt-speed2-pvs1-v0 = <925000>;
+			opp-microvolt-speed2-pvs2-v0 = <900000>;
+			opp-microvolt-speed2-pvs3-v0 = <900000>;
+			opp-microvolt-speed2-pvs4-v0 = <875000>;
+			opp-microvolt-speed2-pvs5-v0 = <875000>;
+			opp-microvolt-speed2-pvs6-v0 = <875000>;
+			opp-microvolt-speed14-pvs0-v0 = <950000>;
+			opp-microvolt-speed14-pvs1-v0 = <950000>;
+			opp-microvolt-speed14-pvs2-v0 = <925000>;
+			opp-microvolt-speed14-pvs3-v0 = <900000>;
+			opp-microvolt-speed14-pvs4-v0 = <875000>;
+			opp-microvolt-speed14-pvs5-v0 = <875000>;
+			opp-microvolt-speed14-pvs6-v0 = <875000>;
+		};
+};
+
+EXAMPLE 2:
+---------
+/* For arch/arm/boot/dts/qcom-msm8974.dtsi--> format 'B' */
+
+qfprom: qfprom@700000 {
+	compatible      = "qcom,qfprom";
+	reg		= <0x00700000 0x1000>;
+	#address-cells	= <1>;
+	#size-cells	= <1>;
+	ranges;
+	pvs_efuse: pvs {
+		reg = <0xc0 0x8>;
+	};
+};
+
+cpu_opp_table: opp-table {
+	compatible = "operating-points-v2-krait-cpu";
+	nvmem-cells = <&pvs_efuse>;
+
+		/*
+		 * Missing opp-shared property means CPUs switch DVFS states
+		 * independently.
+		 */
+	opp-960000000 {
+		opp-hz = /bits/ 64 <960000000>;
+		opp-microvolt-speed0-pvs0-v0 = <915000>;
+		opp-microvolt-speed0-pvs1-v0 = <895000>;
+		opp-microvolt-speed0-pvs2-v0 = <875000>;
+		opp-microvolt-speed0-pvs3-v0 = <860000>;
+		opp-microvolt-speed0-pvs4-v0 = <850000>;
+		opp-microvolt-speed0-pvs5-v0 = <840000>;
+		opp-microvolt-speed0-pvs6-v0 = <830000>;
+		opp-microvolt-speed2-pvs0-v0 = <875000>;
+		opp-microvolt-speed2-pvs1-v0 = <860000>;
+		opp-microvolt-speed2-pvs2-v0 = <845000>;
+		opp-microvolt-speed2-pvs3-v0 = <830000>;
+		opp-microvolt-speed2-pvs4-v0 = <820000>;
+		opp-microvolt-speed2-pvs5-v0 = <810000>;
+		opp-microvolt-speed2-pvs6-v0 = <800000>;
+		opp-microvolt-speed1-pvs0-v0 = <840000>;
+		opp-microvolt-speed1-pvs1-v0 = <825000>;
+		opp-microvolt-speed1-pvs2-v0 = <810000>;
+		opp-microvolt-speed1-pvs3-v0 = <795000>;
+		opp-microvolt-speed1-pvs4-v0 = <785000>;
+		opp-microvolt-speed1-pvs5-v0 = <775000>;
+		opp-microvolt-speed1-pvs6-v0 = <765000>;
+
+		opp-microamp-speed0-pvs0-v0 = <252>;
+		opp-microamp-speed0-pvs1-v0 = <252>;
+		opp-microamp-speed0-pvs2-v0 = <252>;
+		opp-microamp-speed0-pvs3-v0 = <252>;
+		opp-microamp-speed0-pvs4-v0 = <252>;
+		opp-microamp-speed0-pvs5-v0 = <252>;
+		opp-microamp-speed0-pvs6-v0 = <252>;
+		opp-microamp-speed2-pvs0-v0 = <245>;
+		opp-microamp-speed2-pvs1-v0 = <245>;
+		opp-microamp-speed2-pvs2-v0 = <245>;
+		opp-microamp-speed2-pvs3-v0 = <245>;
+		opp-microamp-speed2-pvs4-v0 = <245>;
+		opp-microamp-speed2-pvs5-v0 = <245>;
+		opp-microamp-speed2-pvs6-v0 = <245>;
+		opp-microamp-speed1-pvs0-v0 = <242>;
+		opp-microamp-speed1-pvs1-v0 = <242>;
+		opp-microamp-speed1-pvs2-v0 = <242>;
+		opp-microamp-speed1-pvs3-v0 = <242>;
+		opp-microamp-speed1-pvs4-v0 = <242>;
+		opp-microamp-speed1-pvs5-v0 = <242>;
+		opp-microamp-speed1-pvs6-v0 = <242>;
+	};
+
+	opp-883200000 {
+		opp-hz = /bits/ 64 <883200000>;
+		opp-microvolt-speed0-pvs0-v0 = <900000>;
+		opp-microvolt-speed0-pvs1-v0 = <885000>;
+		opp-microvolt-speed0-pvs2-v0 = <865000>;
+		opp-microvolt-speed0-pvs3-v0 = <850000>;
+		opp-microvolt-speed0-pvs4-v0 = <840000>;
+		opp-microvolt-speed0-pvs5-v0 = <830000>;
+		opp-microvolt-speed0-pvs6-v0 = <820000>;
+		opp-microvolt-speed2-pvs0-v0 = <865000>;
+		opp-microvolt-speed2-pvs1-v0 = <850000>;
+		opp-microvolt-speed2-pvs2-v0 = <835000>;
+		opp-microvolt-speed2-pvs3-v0 = <820000>;
+		opp-microvolt-speed2-pvs4-v0 = <810000>;
+		opp-microvolt-speed2-pvs5-v0 = <800000>;
+		opp-microvolt-speed2-pvs6-v0 = <790000>;
+		opp-microvolt-speed1-pvs0-v0 = <830000>;
+		opp-microvolt-speed1-pvs1-v0 = <815000>;
+		opp-microvolt-speed1-pvs2-v0 = <800000>;
+		opp-microvolt-speed1-pvs3-v0 = <785000>;
+		opp-microvolt-speed1-pvs4-v0 = <775000>;
+		opp-microvolt-speed1-pvs5-v0 = <765000>;
+		opp-microvolt-speed1-pvs6-v0 = <755000>;
+
+		opp-microamp-speed0-pvs0-v0 = <229>;
+		opp-microamp-speed0-pvs1-v0 = <229>;
+		opp-microamp-speed0-pvs2-v0 = <229>;
+		opp-microamp-speed0-pvs3-v0 = <229>;
+		opp-microamp-speed0-pvs4-v0 = <229>;
+		opp-microamp-speed0-pvs5-v0 = <229>;
+		opp-microamp-speed0-pvs6-v0 = <229>;
+		opp-microamp-speed2-pvs0-v0 = <223>;
+		opp-microamp-speed2-pvs1-v0 = <223>;
+		opp-microamp-speed2-pvs2-v0 = <223>;
+		opp-microamp-speed2-pvs3-v0 = <223>;
+		opp-microamp-speed2-pvs4-v0 = <223>;
+		opp-microamp-speed2-pvs5-v0 = <223>;
+		opp-microamp-speed2-pvs6-v0 = <223>;
+		opp-microamp-speed1-pvs0-v0 = <221>;
+		opp-microamp-speed1-pvs1-v0 = <221>;
+		opp-microamp-speed1-pvs2-v0 = <221>;
+		opp-microamp-speed1-pvs3-v0 = <221>;
+		opp-microamp-speed1-pvs4-v0 = <221>;
+		opp-microamp-speed1-pvs5-v0 = <221>;
+		opp-microamp-speed1-pvs6-v0 = <221>;
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
