Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935448AbeBMOgZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:36:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45178 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935298AbeBMOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:36:00 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chris Zhong <zyw@rock-chips.com>,
        kernel@collabora.com
Subject: [PATCH v2 2/3] arm64: dts: rockchip: add cdn-dp node for rk3399.
Date: Tue, 13 Feb 2018 15:35:48 +0100
Message-Id: <20180213143549.15197-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213143549.15197-1-enric.balletbo@collabora.com>
References: <20180213143549.15197-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Zhong <zyw@rock-chips.com>

Add a node for the cdn DP controller which is embedded in the rk3399
SoC.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
- None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index cdf733e4a450..17a9dc5591c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -457,6 +457,46 @@
 		};
 	};
 
+        cdn_dp: dp@fec00000 {
+                compatible = "rockchip,rk3399-cdn-dp";
+                reg = <0x0 0xfec00000 0x0 0x100000>;
+                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&cru SCLK_DP_CORE>, <&cru PCLK_DP_CTRL>,
+                         <&cru SCLK_SPDIF_REC_DPTX>, <&cru PCLK_VIO_GRF>;
+                clock-names = "core-clk", "pclk", "spdif", "grf";
+                assigned-clocks = <&cru SCLK_DP_CORE>;
+                assigned-clock-rates = <100000000>;
+                power-domains = <&power RK3399_PD_HDCP>;
+                phys = <&tcphy0_dp>, <&tcphy1_dp>;
+                resets = <&cru SRST_DPTX_SPDIF_REC>, <&cru SRST_P_UPHY0_DPTX>,
+                         <&cru SRST_P_UPHY0_APB>, <&cru SRST_DP_CORE>;
+                reset-names = "spdif", "dptx", "apb", "core";
+                rockchip,grf = <&grf>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #sound-dai-cells = <1>;
+                status = "disabled";
+
+                ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        dp_in: port {
+                                #address-cells = <1>;
+                                #size-cells = <0>;
+                                dp_in_vopb: endpoint@0 {
+                                        reg = <0>;
+                                        remote-endpoint = <&vopb_out_dp>;
+                                };
+
+                                dp_in_vopl: endpoint@1 {
+                                        reg = <1>;
+                                        remote-endpoint = <&vopl_out_dp>;
+                                };
+                        };
+                };
+        };
+
 	gic: interrupt-controller@fee00000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <4>;
@@ -1553,6 +1593,11 @@
 				reg = <3>;
 				remote-endpoint = <&mipi1_in_vopl>;
 			};
+
+                        vopl_out_dp: endpoint@4 {
+                                reg = <4>;
+                                remote-endpoint = <&dp_in_vopl>;
+                        };
 		};
 	};
 
@@ -1605,6 +1650,11 @@
 				reg = <3>;
 				remote-endpoint = <&mipi1_in_vopb>;
 			};
+
+                        vopb_out_dp: endpoint@4 {
+                                reg = <4>;
+                                remote-endpoint = <&dp_in_vopb>;
+                        };
 		};
 	};
 
-- 
2.15.1
