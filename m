Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeBWNb2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:31:28 -0500
Received: from mail01.prevas.se ([62.95.78.3]:56206 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbeBWNb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:31:27 -0500
X-IronPort-AV: E=Sophos;i="5.47,383,1515452400";
   d="scan'208";a="3297971"
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] ARM: dts: ls1021a: add size-cells and address-cells to scfg and dcfg nodes
Date: Fri, 23 Feb 2018 14:31:14 +0100
Message-ID: <20180223133114.7091-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.8.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single u32 is sufficient to specify a register in the Device
Configuration Unit/Supplemental Configuration Unit. Moreover, they only
consist of 32 bit registers (for the DCFG we even have "These registers
only support 32-bit accesses." according to the reference manual), so no
size specification is needed.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
None of the in-tree .dts files using ls1021a.dtsi currently define a
subnode of either node. It is possible, though somewhat unlikely, that
some out-of-tree .dts file is built against the in-tree ls1021a.dtsi,
and I don't know if such files are treated the same as out-of-tree
modules (i.e., they get to fix the breakage).

The reason I'm proposing to add these is that I'm about to add a subnode
of scfg with a reg property, and if possible I'd like to avoid the
somewhat clumsy

  reg = <0 0x1ac 0 4>;

when reg = <0x1ac>; would convey the same information. But if the
#address-cells and #size-cells properties are set in stone once the
.dtsi is in mainline, I'll just accept the clumsiness.

arch/arm/boot/dts/ls1021a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c31dad98f989..3c9fadcd611d 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -159,6 +159,8 @@
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1021a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			big-endian;
 		};
 
@@ -202,6 +204,8 @@
 		scfg: scfg@1570000 {
 			compatible = "fsl,ls1021a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			big-endian;
 		};
 
-- 
2.15.1
