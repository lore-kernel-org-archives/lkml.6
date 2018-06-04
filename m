Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeFDTQp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:16:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFDTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:16:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AA5B60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
Subject: [PATCH v6 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
Date: Mon,  4 Jun 2018 12:15:11 -0700
Message-Id: <38cb1906c96504f74517018ca4e0aed63bb77356.1528138319.git.collinsd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1528138319.git.collinsd@codeaurora.org>
References: <cover.1528138319.git.collinsd@codeaurora.org>
In-Reply-To: <cover.1528138319.git.collinsd@codeaurora.org>
References: <cover.1528138319.git.collinsd@codeaurora.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++++++++++++++++++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +++++
 2 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
new file mode 100644
index 0000000..7ef2dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
@@ -0,0 +1,160 @@
+Qualcomm Technologies, Inc. RPMh Regulators
+
+rpmh-regulator devices support PMIC regulator management via the Voltage
+Regulator Manager (VRM) and Oscillator Buffer (XOB) RPMh accelerators.  The APPS
+processor communicates with these hardware blocks via a Resource State
+Coordinator (RSC) using command packets.  The VRM allows changing three
+parameters for a given regulator: enable state, output voltage, and operating
+mode.  The XOB allows changing only a single parameter for a given regulator:
+its enable state.  Despite its name, the XOB is capable of controlling the
+enable state of any PMIC peripheral.  It is used for clock buffers, low-voltage
+switches, and LDO/SMPS regulators which have a fixed voltage and mode.
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
+========================
+First Level Nodes - PMIC
+========================
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
+- vdd-s1-supply
+- vdd-s2-supply
+- vdd-s3-supply
+- vdd-s4-supply
+	Usage:      optional (PM8998 and PM8005 only)
+	Value type: <phandle>
+	Definition: phandle of the parent supply regulator of one or more of the
+		    regulators for this PMIC.
+
+- vdd-s5-supply
+- vdd-s6-supply
+- vdd-s7-supply
+- vdd-s8-supply
+- vdd-s9-supply
+- vdd-s10-supply
+- vdd-s11-supply
+- vdd-s12-supply
+- vdd-s13-supply
+- vdd-l1-l27-supply
+- vdd-l2-l8-l17-supply
+- vdd-l3-l11-supply
+- vdd-l4-l5-supply
+- vdd-l6-supply
+- vdd-l7-l12-l14-l15-supply
+- vdd-l9-supply
+- vdd-l10-l23-l25-supply
+- vdd-l13-l19-l21-supply
+- vdd-l16-l28-supply
+- vdd-l18-l22-supply
+- vdd-l20-l24-supply
+- vdd-l26-supply
+- vin-lvs-1-2-supply
+	Usage:      optional (PM8998 only)
+	Value type: <phandle>
+	Definition: phandle of the parent supply regulator of one or more of the
+		    regulators for this PMIC.
+
+- vdd-bob-supply
+	Usage:      optional (PMI8998 only)
+	Value type: <phandle>
+	Definition: BOB regulator parent supply phandle
+
+===============================
+Second Level Nodes - Regulators
+===============================
+
+- qcom,always-wait-for-ack
+	Usage:      optional
+	Value type: <empty>
+	Definition: Boolean flag which indicates that the application processor
+		    must wait for an ACK or a NACK from RPMh for every request
+		    sent for this regulator including those which are for a
+		    strictly lower power state.
+
+Other properties defined in Documentation/devicetree/bindings/regulator.txt
+may also be used.  regulator-initial-mode and regulator-allowed-modes may be
+specified for VRM regulators using mode values from
+include/dt-bindings/regulator/qcom,rpmh-regulator.h.  regulator-allow-bypass
+may be specified for BOB type regulators managed via VRM.
+regulator-allow-set-load may be specified for LDO type regulators managed via
+VRM.
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
+		vdd-l7-l12-l14-l15-supply = <&pm8998_s5>;
+
+		smps2 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		pm8998_s5: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allowed-modes =
+				<RPMH_REGULATOR_MODE_LPM
+				 RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
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
+			regulator-allowed-modes =
+				<RPMH_REGULATOR_MODE_AUTO
+				 RPMH_REGULATOR_MODE_HPM>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+	};
+};
diff --git a/include/dt-bindings/regulator/qcom,rpmh-regulator.h b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
new file mode 100644
index 0000000..86713dc
--- /dev/null
+++ b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_RPMH_REGULATOR_H
+#define __QCOM_RPMH_REGULATOR_H
+
+/*
+ * These mode constants may be used to specify modes for various RPMh regulator
+ * device tree properties (e.g. regulator-initial-mode).  Each type of regulator
+ * supports a subset of the possible modes.
+ *
+ * %RPMH_REGULATOR_MODE_RET:	Retention mode in which only an extremely small
+ *				load current is allowed.  This mode is supported
+ *				by LDO and SMPS type regulators.
+ * %RPMH_REGULATOR_MODE_LPM:	Low power mode in which a small load current is
+ *				allowed.  This mode corresponds to PFM for SMPS
+ *				and BOB type regulators.  This mode is supported
+ *				by LDO, HFSMPS, BOB, and PMIC4 FTSMPS type
+ *				regulators.
+ * %RPMH_REGULATOR_MODE_AUTO:	Auto mode in which the regulator hardware
+ *				automatically switches between LPM and HPM based
+ *				upon the real-time load current.  This mode is
+ *				supported by HFSMPS, BOB, and PMIC4 FTSMPS type
+ *				regulators.
+ * %RPMH_REGULATOR_MODE_HPM:	High power mode in which the full rated current
+ *				of the regulator is allowed.  This mode
+ *				corresponds to PWM for SMPS and BOB type
+ *				regulators.  This mode is supported by all types
+ *				of regulators.
+ */
+#define RPMH_REGULATOR_MODE_RET		0
+#define RPMH_REGULATOR_MODE_LPM		1
+#define RPMH_REGULATOR_MODE_AUTO	2
+#define RPMH_REGULATOR_MODE_HPM		3
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
