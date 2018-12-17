Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB98C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2271320672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeLQMlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:41:39 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57862 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbeLQMlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:41:39 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gYs8v-0003o4-8P; Mon, 17 Dec 2018 13:37:05 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 13/15] arm64: dts: rockchip: add core display support for rk3368
Date:   Mon, 17 Dec 2018 13:36:48 +0100
Message-Id: <20181217123650.6773-14-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the display subsystem and vop and hook up the individual
encoder ports.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 73 ++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index f03f57d96515..0a2523e706ae 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -181,6 +181,11 @@
 				     <&cpu_b2>, <&cpu_b3>;
 	};
 
+	display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
@@ -856,6 +861,40 @@
 		status = "disabled";
 	};
 
+	vop: vop@ff930000 {
+		compatible = "rockchip,rk3368-vop";
+		reg = <0x0 0xff930000 0x0 0x2f4>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP>, <&cru DCLK_VOP>, <&cru HCLK_VOP>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		power-domains = <&power RK3368_PD_VIO>;
+		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>,
+			 <&cru SRST_LCDC0_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&vop_mmu>;
+		status = "disabled";
+
+		vop_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vop_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop>;
+			};
+
+			vop_out_edp: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&edp_in_vop>;
+			};
+
+			vop_out_mipi: endpoint@2 {
+				reg = <2>;
+				remote-endpoint = <&mipi_in_vop>;
+			};
+		};
+	};
+
 	vop_mmu: iommu@ff930300 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff930300 0x0 0x100>;
@@ -879,6 +918,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mipi_in: port@0 {
+				reg = <0>;
+
+				mipi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_mipi>;
+				};
+			};
+		};
 	};
 
 	edp: dp@ff970000 {
@@ -894,6 +946,19 @@
 		reset-names = "dp";
 		rockchip,grf = <&grf>;
 		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_in: port@0 {
+				reg = <0>;
+
+				edp_in_vop: endpoint {
+					remote-endpoint = <&vop_out_edp>;
+				};
+			};
+		};
 	};
 
 	hdmi: hdmi@ff980000 {
@@ -908,6 +973,14 @@
 		clock-names = "iahb", "isfr", "cec";
 		power-domains = <&power RK3368_PD_VIO>;
 		status = "disabled";
+
+		ports {
+			hdmi_in: port {
+				hdmi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+		};
 	};
 
 	hevc_mmu: iommu@ff9a0440 {
-- 
2.19.2

