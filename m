Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971089AbeEXTZn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:25:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967322AbeEXTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:25:41 -0400
From: Mark Brown <broonie@kernel.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: qcom_spmi: Document SAW support" to the regulator tree
In-Reply-To: <1520166709-554-3-git-send-email-ilialin@codeaurora.org>
Message-Id: <E1fLvrl-0006TA-04@debutante>
Date: Thu, 24 May 2018 20:25:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: qcom_spmi: Document SAW support

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f50e5ddae899d1599e4d6ccb46eadd78b7ed14bc Mon Sep 17 00:00:00 2001
From: Ilia Lin <ilialin@codeaurora.org>
Date: Mon, 21 May 2018 14:25:31 +0300
Subject: [PATCH] dt-bindings: qcom_spmi: Document SAW support

Document the DT bindings for the SAW regulators.

The saw-leader is the only property that is configurable in DT.

The saw-slave property allows ganging (grouping) of
several regulators so that their outputs can be combined.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/qcom,spmi-regulator.txt         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index 57d2c65899df..406f2e570c50 100644
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
2.17.0
