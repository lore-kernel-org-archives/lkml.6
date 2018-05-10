Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeEJUoX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:44:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:59217 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeEJUoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:44:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
   d="scan'208";a="40007063"
From: thor.thayer@linux.intel.com
To: dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH] arm64: dts: stratix10: Add QSPI support for Stratix10
Date: Thu, 10 May 2018 15:46:44 -0500
Message-Id: <1525985204-11525-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add qspi_clock
   The qspi_clk frequency is updated by U-Boot before starting Linux.
Add QSPI interface node.
Add QSPI flash memory child node.
   Setup the QSPI memory in 2 partitions.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 22 +++++++++++++++
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 31 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index e6b059378dc0..ed47dfce3ba6 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -119,6 +119,12 @@
 				#clock-cells = <0>;
 				compatible = "fixed-clock";
 			};
+
+			qspi_clk: qspi_clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <200000000>;
+			};
 		};
 
 		gmac0: ethernet@ff800000 {
@@ -466,5 +472,21 @@
 				interrupts = <16 4>, <48 4>;
 			};
 		};
+
+		qspi: spi@ff8d2000 {
+			compatible = "cdns,qspi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xff8d2000 0x100>,
+			      <0xff900000 0x100000>;
+			interrupts = <0 3 4>;
+			cdns,fifo-depth = <128>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x00000000>;
+			clocks = <&qspi_clk>;
+			bus-num = <1>;
+
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index f9b1ef12db48..60251462067a 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -147,3 +147,34 @@
 		reg = <0x68>;
 	};
 };
+
+&qspi {
+	flash0: n25q00@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q00aa";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partition@qspi-boot {
+			label = "Boot and fpga data";
+			/* 64MB for boot and FPGA data */
+			reg = <0x0 0x4000000>;
+		};
+
+		partition@qspi-rootfs {
+			label = "Root Filesystem - JFFS2";
+			/* 64MB for Linux jffs2 */
+			reg = <0x4000000 0x4000000>;
+		};
+	};
+};
-- 
2.7.4
