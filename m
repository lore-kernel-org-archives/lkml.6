Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758902AbeD0Q5k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:57:40 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53204 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758871AbeD0Q5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:57:38 -0400
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Cc: Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 09/11] arm64: dts: r8a77965: Add HDMI encoder instance
Date: Fri, 27 Apr 2018 17:57:20 +0100
Message-Id: <20180427165722.19445-10-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the HDMI encoder to the R8A77965 DT in disabled state.

Based on a similar patch of the R8A7796 device tree
by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[Kieran: Rebase to top of tree]
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
 - Provide correct CPC MSSR header
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index a35ea2f32da2..b46af2744135 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -8,7 +8,7 @@
  * Copyright (C) 2016 Renesas Electronics Corp.
  */
 
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
+#include <dt-bindings/clock/r8a77965-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/r8a77965-sysc.h>
 
@@ -1105,6 +1105,33 @@
 			};
 		};
 
+		hdmi0: hdmi@fead0000 {
+			compatible = "renesas,r8a77965-hdmi",
+				     "renesas,rcar-gen3-hdmi";
+			reg = <0 0xfead0000 0 0x10000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 729>,
+				 <&cpg CPG_CORE R8A77965_CLK_HDMI>;
+			clock-names = "iahb", "isfr";
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 729>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					dw_hdmi0_in: endpoint {
+						remote-endpoint = <&du_out_hdmi0>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
 		du: display@feb00000 {
 			compatible = "renesas,du-r8a77965";
 			reg = <0 0xfeb00000 0 0x80000>;
@@ -1132,6 +1159,7 @@
 				port@1 {
 					reg = <1>;
 					du_out_hdmi0: endpoint {
+						remote-endpoint = <&dw_hdmi0_in>;
 					};
 				};
 				port@2 {
-- 
2.17.0
