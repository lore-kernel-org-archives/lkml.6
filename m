Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeEKT0x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:26:53 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:28297 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeEKT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:26:51 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <ssantosh@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux-next PATCH 1/4] ARM: dts: k2g: add dt bindings to support network driver
Date: Fri, 11 May 2018 15:29:09 -0400
Message-ID: <1526066952-5230-2-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add dt bindings to support network driver based on
Network Sub System (NSS) found on k2g SoC. This consists of
bindings for netcp node, nss qmss , pktdma, cpsw 2u version
of ethss and mdio.

In order to support transitioning between non-promiscuous
and promiscuous modes in K2G's ethernet switch, netcp ALE
needs to be enabled. Therefore this patch enables K2G's
netcp ALE for that purpose.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi | 147 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi       |  13 +++
 2 files changed, 160 insertions(+)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi

diff --git a/arch/arm/boot/dts/keystone-k2g-netcp.dtsi b/arch/arm/boot/dts/keystone-k2g-netcp.dtsi
new file mode 100644
index 0000000..d0e6a9a
--- /dev/null
+++ b/arch/arm/boot/dts/keystone-k2g-netcp.dtsi
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for K2G Netcp driver
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+qmss: qmss@4020000 {
+	compatible = "ti,66ak2g-navss-qm";
+	dma-coherent;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	power-domains = <&k2g_pds 0x0018>;
+	clocks = <&k2g_clks 0x0018 0>;
+	clock-names = "nss_vclk";
+	ranges;
+	queue-range = <0 0x80>;
+	linkram0 = <0x4020000 0x7ff>;
+	status = "disabled";
+
+	qmgrs {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		qmgr0 {
+			managed-queues = <0 0x80>;
+			reg = <0x4100000 0x800>,
+			      <0x4040000 0x100>,
+			      <0x4080000 0x800>,
+			      <0x40c0000 0x800>;
+			reg-names = "peek", "config",
+				    "region", "push";
+		};
+
+	};
+	queue-pools {
+		qpend {
+			qpend-0 {
+				qrange = <77 8>;
+				interrupts =<0 308 0xf04 0 309 0xf04 0 310 0xf04
+					     0 311 0xf04 0 312 0xf04 0 313 0xf04
+					     0 314 0xf04 0 315 0xf04>;
+				qalloc-by-id;
+			};
+		};
+		general-purpose {
+			gp-0 {
+				qrange = <112 8>;
+			};
+			netcp-tx {
+				qrange = <5 8>;
+				qalloc-by-id;
+			};
+		};
+	};
+
+	descriptor-regions {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		region-12 {
+			id = <12>;
+			region-spec = <1023 128>; /* num_desc desc_size */
+			link-index = <0x400>;
+		};
+	};
+}; /* qmss */
+
+knav_dmas: knav_dmas@0 {
+	compatible = "ti,keystone-navigator-dma";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	status = "disabled";
+	power-domains = <&k2g_pds 0x0018>;
+	clocks = <&k2g_clks 0x0018 0>;
+	clock-names = "nss_vclk";
+	ranges;
+	ti,navigator-cloud-address = <0x40c0000 0x40c0000 0x40c0000 0x40c0000>;
+
+	dma_gbe: dma_gbe@0 {
+		reg = <0x4010000 0x100>,
+		      <0x4011000 0x2a0>, /* 21 Tx channels */
+		      <0x4012000 0x400>, /* 32 Rx channels */
+		      <0x4010100 0x80>,
+		      <0x4013000 0x400>; /* 32 Rx flows */
+		reg-names = "global", "txchan", "rxchan",
+			    "txsched", "rxflow";
+	};
+
+};
+
+netcp: netcp@4000000 {
+	reg = <0x2620110 0x8>;
+	reg-names = "efuse";
+	compatible = "ti,netcp-1.0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	status = "disabled";
+	power-domains = <&k2g_pds 0x0018>;
+	clocks = <&k2g_clks 0x0018 3>, <&k2g_clks 0x0018 8>;
+	clock-names = "ethss_clk", "cpts";
+
+	/* NetCP address range */
+	ranges = <0 0x4000000 0x1000000>;
+
+	dma-coherent;
+
+	ti,navigator-dmas = <&dma_gbe 0>, <&dma_gbe 5>;
+	ti,navigator-dma-names = "netrx0", "nettx";
+
+	netcp-devices {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		gbe: gbe@200000 {
+			label = "netcp-gbe";
+			compatible = "ti,netcp-gbe-2";
+			reg = <0x200000 0x20>, <0x220000 0x20000>;
+			enable-ale;
+			tx-queue = <5>;
+			tx-channel = "nettx";
+			cpts-rftclk-sel = <0>;
+			cpts-ext-ts-inputs = <8>;
+
+			interfaces {
+				gbe0: interface-0 {
+					slave-port = <0>;
+					link-interface	= <5>;
+				};
+			};
+		};
+	};
+
+	netcp-interfaces {
+		interface-0 {
+			rx-channel = "netrx0";
+			rx-pool = <512 12>;
+			tx-pool = <511 12>;
+			rx-queue-depth = <128 128 0 0>;
+			rx-buffer-size = <1518 4096 0 0>;
+			rx-queue = <77>;
+			tx-completion-queue = <78>;
+			efuse-mac = <1>;
+			netcp-gbe = <&gbe0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index da78c00..a8324a7 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -609,5 +609,18 @@
 			reg = <0x21010000 0x200>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_EDGE_RISING>;
 		};
+
+		mdio: mdio@4200f00 {
+			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
+			reg = <0x04200f00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k2g_clks 0x0018 3>;
+			clock-names = "fck";
+			power-domains = <&k2g_pds 0x0018>;
+			status = "disabled";
+			bus_freq = <2500000>;
+		};
+		#include "keystone-k2g-netcp.dtsi"
 	};
 };
-- 
1.9.1
