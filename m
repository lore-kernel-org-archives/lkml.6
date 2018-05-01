Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeEAJLY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:11:24 -0400
Received: from foss.arm.com ([217.140.101.70]:44066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753731AbeEAJLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:11:21 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@arm.com>
Subject: [PATCH v2 05/27] dts: bindings: Document device tree binding for CATU
Date: Tue,  1 May 2018 10:10:35 +0100
Message-Id: <1525165857-11096-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document CATU device-tree bindings. CATU augments the TMC-ETR
by providing an improved Scatter Gather mechanism for streaming
trace data to non-contiguous system RAM pages.

Cc: devicetree@vger.kernel.org
Cc: frowand.list@gmail.com
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt          | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 15ac8e8..cdd84d0 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -39,6 +39,8 @@ its hardware characteristcs.
 
 		- System Trace Macrocell:
 			"arm,coresight-stm", "arm,primecell"; [1]
+		- Coresight Address Translation Unit (CATU)
+			"arm, coresight-catu", "arm,primecell";
 
 	* reg: physical base address and length of the register
 	  set(s) of the component.
@@ -86,6 +88,9 @@ its hardware characteristcs.
 	* arm,buffer-size: size of contiguous buffer space for TMC ETR
 	 (embedded trace router)
 
+* Optional property for CATU :
+	* interrupts : Exactly one SPI may be listed for reporting the address
+	  error
 
 Example:
 
@@ -118,6 +123,35 @@ Example:
 		};
 	};
 
+	etr@20070000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20070000 0 0x1000>;
+
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* input port */
+			port@0 {
+				reg =  <0>;
+				etr_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&replicator2_out_port0>;
+				};
+			};
+
+			/* CATU link represented by output port */
+			port@1 {
+				reg = <0>;
+				etr_out_port: endpoint {
+					remote-endpoint = <&catu_in_port>;
+				};
+			};
+		};
+	};
+
 2. Links
 	replicator {
 		/* non-configurable replicators don't show up on the
@@ -247,5 +281,23 @@ Example:
 		};
 	};
 
+5. CATU
+
+	catu@207e0000 {
+		compatible = "arm,coresight-catu", "arm,primecell";
+		reg = <0 0x207e0000 0 0x1000>;
+
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		port {
+			catu_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&etr_out_port>;
+			};
+		};
+	};
+
 [1]. There is currently two version of STM: STM32 and STM500.  Both
 have the same HW interface and as such don't need an explicit binding name.
-- 
2.7.4
