Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73529C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CB820842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391710AbfBMLCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:02:44 -0500
Received: from inva020.nxp.com ([92.121.34.13]:39246 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbfBMLC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:02:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 28DC11A00FD;
        Wed, 13 Feb 2019 12:02:26 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C9A81A0018;
        Wed, 13 Feb 2019 12:02:26 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B621F2060A;
        Wed, 13 Feb 2019 12:02:25 +0100 (CET)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     alexandru.marginean@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] arm64: dts: fsl: ls1028a: Add PCI IERC node and ENETC endpoints
Date:   Wed, 13 Feb 2019 13:02:21 +0200
Message-Id: <1550055743-15542-2-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1028A SoC features a PCI Integrated Endpoint Root Complex
(IERC) defining several integrated PCI devices, including the ENETC
ethernet controller integrated endpoints (IEPs). The IERC implements
ECAM (Enhanced Configuration Access Mechanism) to provide access
to the PCIe config space of the IEPs. This means the the IEPs
(including ENETC) do not support the standard PCIe BARs, instead
the Enhanced Allocation (EA) capability structures in the ECAM space
are used to fix the base addresses in the system, and the PCI
subsystem uses these structures for device enumeration and discovery.
The "ranges" entries contain basic information from these EA capabily
structures required by the kernel for device enumeration.

The current patch also enables the first 2 ENETC PFs (Physiscal
Functions) and the associated VFs (Virtual Functions), 2 VFs for
each PF.  Each of these ENETC PFs has an external ethernet port
on the LS1028A SoC.

Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index a8cf92a..7f5a8e6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -335,5 +335,38 @@
 				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		pcie@1f0000000 { /* Integrated Endpoint Root Complex */
+			compatible = "pci-host-ecam-generic";
+			reg = <0x01 0xf0000000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			msi-parent = <&its>;
+			device_type = "pci";
+			bus-range = <0x0 0x0>;
+			dma-coherent;
+			msi-map = <0 &its 0x17 0xe>;
+			iommu-map = <0 &smmu 0x17 0xe>;
+				  /* PF0-6 BAR0 - non-prefetchable memory */
+			ranges = <0x82000000 0x0 0x00000000  0x1 0xf8000000  0x0 0x160000
+				  /* PF0-6 BAR2 - prefetchable memory */
+				  0xc2000000 0x0 0x00000000  0x1 0xf8160000  0x0 0x070000
+				  /* PF0: VF0-1 BAR0 - non-prefetchable memory */
+				  0x82000000 0x0 0x00000000  0x1 0xf81d0000  0x0 0x020000
+				  /* PF0: VF0-1 BAR2 - prefetchable memory */
+				  0xc2000000 0x0 0x00000000  0x1 0xf81f0000  0x0 0x020000
+				  /* PF1: VF0-1 BAR0 - non-prefetchable memory */
+				  0x82000000 0x0 0x00000000  0x1 0xf8210000  0x0 0x020000
+				  /* PF1: VF0-1 BAR2 - prefetchable memory */
+				  0xc2000000 0x0 0x00000000  0x1 0xf8230000  0x0 0x020000>;
+
+			enetc_port0: pci@0,0 {
+				reg = <0x000000 0 0 0 0>;
+			};
+			enetc_port1: pci@0,1 {
+				reg = <0x000100 0 0 0 0>;
+			};
+		};
 	};
 };
-- 
2.7.4

