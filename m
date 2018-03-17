Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeCQBJb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 21:09:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbeCQBJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 21:09:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A65560C66
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org
Subject: [PATCH 2/2] dt-bindings: regulator: add QCOM RPMh regulator bindings
Date: Fri, 16 Mar 2018 18:09:11 -0700
Message-Id: <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1521246069.git.collinsd@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org>
In-Reply-To: <cover.1521246069.git.collinsd@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bindings for RPMh regulator devices found on some
Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
processor within the SoC to make PMIC regulator requests which
are aggregated within the RPMh hardware block along with requests
from other processors in the SoC to determine the final PMIC
regulator hardware state.

Signed-off-by: David Collins <collinsd@codeaurora.org>
---
 .../bindings/regulator/qcom,rpmh-regulator.txt     | 246 +++++++++++++++++++++
 1 file changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
new file mode 100644
index 0000000..2d86306
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
@@ -0,0 +1,246 @@
+Qualcomm Technologies, Inc. RPMh Regulators
+
+rpmh-regulator devices support PMIC regulator management via the VRM and XOB
+RPMh accelerators.  The APPS processor communicates with these hardware blocks
+via an RSC using command packets.  The VRM allows changing four parameters for a
+given regulator: enable state, output voltage, operating mode, and minimum
+headroom voltage.  The XOB allows changing only a single parameter for a given
+regulator: its enable state.
+
+=======================
+Required Node Structure
+=======================
+
+RPMh regulators must be described in two levels of device nodes.  The first
+level describes the PMIC containing the regulators and must reside within an
+RPMh device node.  The second level describes each regulator within the PMIC
+which is to be used on the board.  Each of these regulators maps to a single
+RPMh resource.
+
+The names used for regulator nodes must match those supported by a given PMIC.
+Supported regulator node names:
+	PM8998:		smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
+	PMI8998:	bob
+	PM8005:		smps1 - smps4
+
+==================================
+First Level Nodes - PMIC
+==================================
+
+- compatible
+	Usage:      required
+	Value type: <string>
+	Definition: Must be one of: "qcom,pm8998-rpmh-regulators",
+		    "qcom,pmi8998-rpmh-regulators" or
+		    "qcom,pm8005-rpmh-regulators".
+
+- qcom,pmic-id
+	Usage:      required
+	Value type: <string>
+	Definition: RPMh resource name suffix used for the regulators found on
+		    this PMIC.  Typical values: "a", "b", "c", "d", "e", "f".
+
+- vdd_s1-supply
+- vdd_s2-supply
+- vdd_s3-supply
+- vdd_s4-supply
+- vdd_s5-supply
+- vdd_s6-supply
+- vdd_s7-supply
+- vdd_s8-supply
+- vdd_s9-supply
+- vdd_s10-supply
+- vdd_s11-supply
+- vdd_s12-supply
+- vdd_s13-supply
+- vdd_l1_l27-supply
+- vdd_l2_l8_l17-supply
+- vdd_l3_l11-supply
+- vdd_l4_l5-supply
+- vdd_l6-supply
+- vdd_l7_l12_l14_l15-supply
+- vdd_l9-supply
+- vdd_l10_l23_l25-supply
+- vdd_l13_l19_l21-supply
+- vdd_l16_l28-supply
+- vdd_l18_l22-supply
+- vdd_l20_l24-supply
+- vdd_l26-supply
+- vdd_lvs1_lvs2-supply
+- vdd_lvs1_lvs2-supply
+	Usage:      optional (PM8998 only)
+	Value type: <phandle>
+	Definition: phandle of the parent supply regulator of one or more of the
+		    regulators for this PMIC.
+
+- vdd_bob-supply
+	Usage:      optional (PMI8998 only)
+	Value type: <phandle>
+	Definition: phandle of the parent supply regulator of one or more of the
+		    regulators for this PMIC.
+
+- vdd_s1-supply
+- vdd_s2-supply
+- vdd_s3-supply
+- vdd_s4-supply
+	Usage:      optional (PM8005 only)
+	Value type: <phandle>
+	Definition: phandle of the parent supply regulator of one or more of the
+		    regulators for this PMIC.
+
+=========================================
+Second Level Nodes - Regulators
+=========================================
+
+- regulator-name
+	Usage:      optional
+	Value type: <string>
+	Definition: Specifies the name for this RPMh regulator.  If not
+		    specified, then the regulator's name is equal to its subnode
+		    name.
+
+- regulator-min-microvolt
+	Usage:      required
+	Value type: <u32>
+	Definition: For VRM resources, this is the minimum supported voltage in
+		    microvolts.  For XOB resources, this is the fixed output
+		    voltage.
+
+- regulator-max-microvolt
+	Usage:      required
+	Value type: <u32>
+	Definition: For VRM resources, this is the maximum supported voltage in
+		    microvolts.  For XOB resources, this is the fixed output
+		    voltage.
+
+- qcom,regulator-initial-voltage
+	Usage:      optional; VRM regulators only
+	Value type: <u32>
+	Definition: Specifies the initial voltage in microvolts to request for a
+		    VRM regulator.  Supported values are 0 to 8191000.
+
+- regulator-initial-mode
+	Usage:      optional; VRM regulators only
+	Value type: <u32>
+	Definition: Specifies the initial mode to request for a VRM regulator.
+		    Supported values are RPMH_REGULATOR_MODE_* which are defined
+		    in [1] (i.e. 0 to 4).
+
+- regulator-allow-set-load
+	Usage:      optional
+	Value type: <empty>
+	Definition: Boolean flag indicating that the the mode of this regulator
+		    may be configured at runtime based upon consumer load needs.
+
+- qcom,allowed-modes
+	Usage:      required if regulator-allow-set-load is specified;
+		    VRM regulators only
+	Value type: <prop-encoded-array>
+	Definition: A list of integers specifying the PMIC regulator modes which
+		    can be configured at runtime based upon consumer load needs.
+		    Supported values are RPMH_REGULATOR_MODE_* which are defined
+		    in [1] (i.e. 0 to 4).  Elements must be specified in order
+		    from lowest to highest value.
+
+- qcom,mode-threshold-currents
+	Usage:      required if regulator-allow-set-load is specified;
+		    VRM regulators only
+	Value type: <prop-encoded-array>
+	Definition: A list of integers specifying the minimum allowed load
+		    current in microamps for each of the modes listed in
+		    qcom,allowed-modes.  The first element should always be 0.
+		    Elements must be specified in order from lowest to highest
+		    value.
+
+- qcom,headroom-voltage
+	Usage:      optional; VRM regulators only
+	Value type: <u32>
+	Definition: Specifies the headroom voltage in microvolts to request for
+		    a VRM regulator.  RPMh hardware automatically ensures that
+		    the parent of this regulator outputs a voltage high enough
+		    to satisfy the requested headroom.  Supported values are
+		    0 to 511000.
+
+ - regulator-enable-ramp-delay
+	Usage:      optional
+	Value type: <u32>
+	Definition: The time in microseconds to delay after enabling a
+		    regulator.  Note that RPMh hardware ensures that regulator
+		    output has stabilized before acknowledging a given regulator
+		    enable request.
+
+- qcom,rpmh-resource-type
+	Usage:      optional
+	Value type: <string>
+	Definition: RPMh accelerator type for this regulator.  If not specified,
+		    then the default type associated with this regulator will be
+		    used.  Supported values: "vrm" or "xob".
+
+- qcom,always-wait-for-ack
+	Usage:      optional
+	Value type: <empty>
+	Definition: Boolean flag which indicates that the application processor
+		    must wait for an ACK or a NACK from RPMh for every request
+		    sent for this regulator including those which are for a
+		    strictly lower power state.
+
+Other properties defined in regulator.txt may also be used.
+
+[1] include/dt-bindings/regulator/qcom,rpmh-regulator.h
+
+========
+Examples
+========
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+&apps_rsc {
+	pm8998-rpmh-regulators {
+		compatible = "qcom,pm8998-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd_l7_l12_l14_l15-supply = <&pm8998_s5>;
+
+		smps2 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1100000>;
+			qcom,regulator-initial-voltage = <1100000>;
+		};
+
+		pm8998_s5: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+			qcom,regulator-initial-voltage = <1904000>;
+		};
+
+		ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			qcom,regulator-initial-voltage = <1800000>;
+			qcom,headroom-voltage = <56000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+			regulator-allow-set-load;
+			qcom,allowed-modes =
+				<RPMH_REGULATOR_MODE_LPM
+				 RPMH_REGULATOR_MODE_HPM>;
+			qcom,mode-threshold-currents = <0 10000>;
+		};
+
+		lvs1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+	};
+
+	pmi8998-rpmh-regulators {
+		compatible = "qcom,pmi8998-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		bob {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3600000>;
+			qcom,regulator-initial-voltage = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_PASS>;
+		};
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
