Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759060AbeD0RBW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:01:22 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758887AbeD0Q5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:57:39 -0400
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/11] arm64: dts: r8a77965-salvator-x: Enable DU external clocks and HDMI
Date: Fri, 27 Apr 2018 17:57:21 +0100
Message-Id: <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DU1 external dot clock is provided by the fixed frequency clock
generator X21, while the DU0 and DU3 clocks are provided by the
programmable Versaclock5 clock generator.

Enable the clocks, and the HDMI encoder for the M3-N Salvator-X board
and hook it up to the HDMI connector.

Based on patches from Takeshi Kihara <takeshi.kihara.df@renesas.com>

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---
v2:
 - Remove LVDS clocks from DU node
 - Merge DU Clocks and HDMI enablement
---
 .../boot/dts/renesas/r8a77965-salvator-x.dts  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
index 75d890d91df9..340a3c72b65a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
@@ -19,3 +19,31 @@
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
 };
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 721>,
+		 <&versaclock5 1>,
+		 <&x21_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.3",
+		      "dclkin.0", "dclkin.1", "dclkin.3";
+};
+
+&hdmi0 {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			rcar_dw_hdmi0_out: endpoint {
+				remote-endpoint = <&hdmi0_con>;
+			};
+		};
+	};
+};
+
+&hdmi0_con {
+	remote-endpoint = <&rcar_dw_hdmi0_out>;
+};
-- 
2.17.0
