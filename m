Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034408AbeCBQr0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:47:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967930AbeCBQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7561601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 02/10] dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
Date: Fri,  2 Mar 2018 09:43:09 -0700
Message-Id: <20180302164317.10554-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device binding documentation for Qualcomm Technology Inc's RPMH RSC
driver. The hardware block is used for communicating resource state
requests for shared resources.

Cc: devicetree@vger.kernel.org
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---

Changes in v2:
	- Amend text to describe the registers in reg property
	- Add reg-names for the registers
	- Update examples to use GIC_SPI in interrupts instead of 0
	- Rephrase incorrect description

Changes in v3:
	- Fix unwanted capitalization
	- Remove clients from the examples, this doc does not describe
	  them
	- Rephrase introductory paragraph
	- Remove hardware specifics from DT bindings
---
 .../devicetree/bindings/arm/msm/rpmh-rsc.txt       | 131 +++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt b/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
new file mode 100644
index 000000000000..afd3817cc615
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
@@ -0,0 +1,131 @@
+RPMH RSC:
+------------
+
+Resource Power Manager Hardened (RPMH) is the mechanism for communicating with
+the hardened resource accelerators on Qualcomm SoCs. Requests to the resources
+can be written to the Trigger Command Set (TCS)  registers and using a (addr,
+val) pair and triggered. Messages in the TCS are then sent in sequence over an
+internal bus.
+
+The hardware block (Direct Resource Voter or DRV) is a part of the h/w entity
+(Resource State Coordinator a.k.a RSC) that can handle a multiple sleep and
+active/wake resource requests. Multiple such DRVs can exist in a SoC and can
+be written to from Linux. The structure of each DRV follows the same template
+with a few variations that are captured by the properties here.
+
+A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
+have powered off to facilitate idle power saving. TCS could be classified as -
+
+	SLEEP,  /* Triggered by F/W */
+	WAKE,   /* Triggered by F/W */
+	ACTIVE, /* Triggered by Linux */
+	CONTROL /* Triggered by F/W */
+
+The order in which they are described in the DT, should match the hardware
+configuration.
+
+Requests can be made for the state of a resource, when the subsystem is active
+or idle. When all subsystems like Modem, GPU, CPU are idle, the resource state
+will be an aggregate of the sleep votes from each of those subsystem. Drivers
+may request a sleep value for their shared resources in addition to the active
+mode requests.
+
+Control requests are instance specific requests that may or may not reach an
+accelerator. Only one platform device in Linux can request a control channel
+on a DRV.
+
+Properties:
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Should be "qcom,rpmh-rsc".
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: The first register specifies the base address of the DRV.
+	            The second register specifies the start address of the
+	            TCS.
+
+- reg-names:
+	Usage: required
+	Value type: <string>
+	Definition: Maps the register specified in the reg property. Must be
+	            "drv" and "tcs".
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-interrupt>
+	Definition: The interrupt that trips when a message complete/response
+	           is received for this DRV from the accelerators.
+
+- qcom,drv-id:
+	Usage: required
+	Value type: <u32>
+	Definition: the id of the DRV in the RSC block.
+
+- qcom,tcs-config:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: the tuple defining the configuration of TCS.
+	            Must have 2 cells which describe each TCS type.
+	            <type number_of_tcs>.
+	            The order of the TCS must match the hardware
+	            configuration.
+	- Cell #1 (TCS Type): TCS types to be specified -
+		SLEEP_TCS
+		WAKE_TCS
+		ACTIVE_TCS
+		CONTROL_TCS
+	- Cell #2 (Number of TCS): <u32>
+
+- label:
+	Usage: optional
+	Value type: <string>
+	Definition: Name for the RSC. The name would be used in trace logs.
+
+Drivers that want to use the RSC to communicate with RPMH must specify their
+bindings as child of the RSC controllers they wish to communicate with.
+
+Example 1:
+
+For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
+register offsets for DRV2 start at 0D00, the register calculations are like
+this -
+First tuple: 0x179C0000 + 0x10000 * 2 = 0x179E0000
+Second tuple: 0x179E0000 + 0xD00 = 0x179E0D00
+
+	apps_rsc: rsc@179e000 {
+		label = "apps_rsc";
+		compatible = "qcom,rpmh-rsc";
+		reg = <0x179e0000 0x10000>, <0x179e0d00 0x3000>;
+		reg-names = "drv", "tcs";
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+		qcom,drv-id = <2>;
+		qcom,tcs-config = <SLEEP_TCS   3>,
+				  <WAKE_TCS    3>,
+				  <ACTIVE_TCS  2>,
+				  <CONTROL_TCS 1>;
+	};
+
+Example 2:
+
+For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
+register offsets for DRV0 start at 01C00, the register calculations are like
+this -
+First tuple: 0xAF20000
+Second tuple: 0xAF20000 + 0x1C00 = 0xAF21C00
+
+	disp_rsc: rsc@af20000 {
+		label = "disp_rsc";
+		compatible = "qcom,rpmh-rsc";
+		reg = <0xaf20000 0x10000>, <0xaf21c00 0x3000>;
+		reg-names = "drv", "tcs";
+		interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+		qcom,drv-id = <0>;
+		qcom,tcs-config = <SLEEP_TCS   1>,
+				  <WAKE_TCS    1>,
+				  <ACTIVE_TCS  0>,
+				  <CONTROL_TCS 0>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
