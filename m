Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756023AbeBOV15 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:27:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755992AbeBOV1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:27:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7587A60F72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>, devicetree@vger.kernel.org
Subject: [PATCH v7 2/2] dt-bindings/interrupt-controller: pdc: describe PDC device binding
Date: Thu, 15 Feb 2018 14:27:42 -0700
Message-Id: <20180215212742.4675-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215212742.4675-1-ilina@codeaurora.org>
References: <20180215212742.4675-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archana Sathyakumar <asathyak@codeaurora.org>

Add device binding documentation for the PDC Interrupt controller on
QCOM SoC's like the SDM845. The interrupt-controller can be used to
sense edge low interrupts and wakeup interrupts when the GIC is
non-operational.

Cc: devicetree@vger.kernel.org
Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 .../bindings/interrupt-controller/qcom,pdc.txt     | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
new file mode 100644
index 000000000000..0b2c97ddb520
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -0,0 +1,78 @@
+PDC interrupt controller
+
+Qualcomm Technologies Inc. SoCs based on the RPM Hardened architecture have a
+Power Domain Controller (PDC) that is on always-on domain. In addition to
+providing power control for the power domains, the hardware also has an
+interrupt controller that can be used to help detect edge low interrupts as
+well detect interrupts when the GIC is non-operational.
+
+GIC is parent interrupt controller at the highest level. Platform interrupt
+controller PDC is next in hierarchy, followed by others. Drivers requiring
+wakeup capabilities of their device interrupts routed through the PDC, must
+specify PDC as their interrupt controller and request the PDC port associated
+with the GIC interrupt. See example below.
+
+Properties:
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Should contain "qcom,<soc>-pdc"
+		    - "qcom,sdm845-pdc": For SDM845
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Specifies the base physical address for PDC hardware.
+
+- interrupt-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: Specifies the number of cells needed to encode an interrupt
+		    source.
+		    Must be 2.
+		    The first element of the tuple is the PDC pin for the
+		    interrupt.
+		    The second element is the trigger type.
+
+- interrupt-parent:
+	Usage: required
+	Value type: <phandle>
+	Definition: Specifies the interrupt parent necessary for hierarchical
+		    domain to operate.
+
+- interrupt-controller:
+	Usage: required
+	Value type: <bool>
+	Definition: Identifies the node as an interrupt controller.
+
+- qcom,pdc-ranges:
+	Usage: required
+	Value type: <u32 array>
+	Definition: Specifies the PDC pin offset and the number of PDC ports.
+		    The tuples indicates the valid mapping of valid PDC ports
+		    and their hwirq mapping.
+		    The first element of the tuple is the starting PDC port.
+		    The second element is the GIC hwirq number for the PDC port.
+		    The third element is the number of interrupts in sequence.
+
+Example:
+
+	pdc: interrupt-controller@b220000 {
+		compatible = "qcom,sdm845-pdc";
+		reg = <0xb220000 0x30000>;
+		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&intc>;
+		interrupt-controller;
+	};
+
+DT binding of a device that wants to use the GIC SPI 514 as a wakeup
+interrupt, must do -
+
+	wake-device {
+		interrupts-extended = <&pdc 2 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+In this case interrupt 514 would be mapped to port 2 on the PDC as defined by
+the qcom,pdc-ranges property.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
