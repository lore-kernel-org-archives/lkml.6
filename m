Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbeENNNO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:13:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45756 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932330AbeENNNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:13:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 744256047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v6 10/14] dt-bindings: qcom_spmi: Add support for SAW documentation
Date: Mon, 14 May 2018 16:11:56 +0300
Message-Id: <1526303520-5843-11-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SAW controlled regulators.
The regulators defined as SAW controlled in the device tree
will be controlled through special CPU registers instead of direct
SPMI accesses.
This is required especially for CPU supply regulators to synchronize
with clock scaling and for Automatic Voltage Switching.
Document it.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/qcom,spmi-regulator.txt     | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index 57d2c65..406f2e5 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -110,6 +110,11 @@ Qualcomm SPMI Regulators
 	Definition: Reference to regulator supplying the input pin, as
 		    described in the data sheet.
 
+- qcom,saw-reg:
+	Usage: optional
+	Value type: <phandle>
+	Description: Reference to syscon node defining the SAW registers.
+
 
 The regulator node houses sub-nodes for each regulator within the device. Each
 sub-node is identified using the node's name, with valid values listed for each
@@ -201,6 +206,17 @@ see regulator.txt - with additional custom properties described below:
 			2 = 0.55 uA
 			3 = 0.75 uA
 
+- qcom,saw-slave:
+	Usage: optional
+	Value type: <boo>
+	Description: SAW controlled gang slave. Will not be configured.
+
+- qcom,saw-leader:
+	Usage: optional
+	Value type: <boo>
+	Description: SAW controlled gang leader. Will be configured as
+		     SAW regulator.
+
 Example:
 
 	regulators {
@@ -221,3 +237,32 @@ Example:
 
 		....
 	};
+
+Example 2:
+
+	saw3: syscon@9A10000 {
+		compatible = "syscon";
+		reg = <0x9A10000 0x1000>;
+	};
+
+	...
+
+	spm-regulators {
+		compatible = "qcom,pm8994-regulators";
+		qcom,saw-reg = <&saw3>;
+		s8 {
+			qcom,saw-slave;
+		};
+		s9 {
+			qcom,saw-slave;
+		};
+		s10 {
+			qcom,saw-slave;
+		};
+		pm8994_s11_saw: s11 {
+			qcom,saw-leader;
+			regulator-always-on;
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1140000>;
+		};
+	};
-- 
1.9.1
