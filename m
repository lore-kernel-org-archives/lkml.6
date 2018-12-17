Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83553C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323B320672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbeLQMht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:37:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57704 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeLQMhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:37:20 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gYs8t-0003o4-U3; Mon, 17 Dec 2018 13:37:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 09/15] arm64: dts: rockchip: add power-domain nodes on rk3368
Date:   Mon, 17 Dec 2018 13:36:44 +0100
Message-Id: <20181217123650.6773-10-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power-controller main node, the individual power domains
below it and their used quality-of-service syscons on rk3368
and hook the power-domains to their user-devicenodes.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 177 +++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 3ef1c27cb7d3..e79c5985f60a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -625,6 +626,112 @@
 		status = "disabled";
 	};
 
+	pmu: power-management@ff730000 {
+		compatible = "rockchip,rk3368-pmu", "syscon", "simple-mfd";
+		reg = <0x0 0xff730000 0x0 0x1000>;
+
+		power: power-controller {
+			compatible = "rockchip,rk3368-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/*
+			 * Note: Although SCLK_* are the working clocks
+			 * of device without including on the NOC, needed for
+			 * synchronous reset.
+			 *
+			 * The clocks on the which NOC:
+			 * ACLK_IEP/ACLK_VIP/ACLK_VOP0 are on ACLK_VIO0_NIU.
+			 * ACLK_ISP/ACLK_VOP1 are on ACLK_VIO1_NIU.
+			 * ACLK_RGA is on ACLK_RGA_NIU.
+			 * The others (HCLK_*,PLCK_*) are on HCLK_VIO_NIU.
+			 *
+			 * Which clock are device clocks:
+			 *	clocks		devices
+			 *	*_IEP		IEP:Image Enhancement Processor
+			 *	*_ISP		ISP:Image Signal Processing
+			 *	*_VIP		VIP:Video Input Processor
+			 *	*_VOP*		VOP:Visual Output Processor
+			 *	*_RGA		RGA
+			 *	*_EDP*		EDP
+			 *	*_DPHY*		LVDS
+			 *	*_HDMI		HDMI
+			 *	*_MIPI_*	MIPI
+			 */
+			pd_vio@RK3368_PD_VIO {
+				reg = <RK3368_PD_VIO>;
+				clocks = <&cru ACLK_IEP>,
+					 <&cru ACLK_ISP>,
+					 <&cru ACLK_VIP>,
+					 <&cru ACLK_RGA>,
+					 <&cru ACLK_VOP>,
+					 <&cru ACLK_VOP_IEP>,
+					 <&cru DCLK_VOP>,
+					 <&cru HCLK_IEP>,
+					 <&cru HCLK_ISP>,
+					 <&cru HCLK_RGA>,
+					 <&cru HCLK_VIP>,
+					 <&cru HCLK_VOP>,
+					 <&cru HCLK_VIO_HDCPMMU>,
+					 <&cru PCLK_EDP_CTRL>,
+					 <&cru PCLK_HDMI_CTRL>,
+					 <&cru PCLK_HDCP>,
+					 <&cru PCLK_ISP>,
+					 <&cru PCLK_VIP>,
+					 <&cru PCLK_DPHYRX>,
+					 <&cru PCLK_DPHYTX>,
+					 <&cru PCLK_MIPI_CSI>,
+					 <&cru PCLK_MIPI_DSI0>,
+					 <&cru SCLK_VOP0_PWM>,
+					 <&cru SCLK_EDP_24M>,
+					 <&cru SCLK_EDP>,
+					 <&cru SCLK_HDCP>,
+					 <&cru SCLK_ISP>,
+					 <&cru SCLK_RGA>,
+					 <&cru SCLK_HDMI_CEC>,
+					 <&cru SCLK_HDMI_HDCP>;
+				pm_qos = <&qos_iep>,
+					 <&qos_isp_r0>,
+					 <&qos_isp_r1>,
+					 <&qos_isp_w0>,
+					 <&qos_isp_w1>,
+					 <&qos_vip>,
+					 <&qos_vop>,
+					 <&qos_rga_r>,
+					 <&qos_rga_w>;
+			};
+
+			/*
+			 * Note: ACLK_VCODEC/HCLK_VCODEC are VCODEC
+			 * (video endecoder & decoder) clocks that on the
+			 * ACLK_VCODEC_NIU and HCLK_VCODEC_NIU (NOC).
+			 */
+			pd_video@RK3368_PD_VIDEO {
+				reg = <RK3368_PD_VIDEO>;
+				clocks = <&cru ACLK_VIDEO>,
+					 <&cru HCLK_VIDEO>,
+					 <&cru SCLK_HEVC_CABAC>,
+					 <&cru SCLK_HEVC_CORE>;
+				pm_qos = <&qos_hevc_r>,
+					 <&qos_vpu_r>,
+					 <&qos_vpu_w>;
+			};
+
+			/*
+			 * Note: ACLK_GPU is the GPU clock,
+			 * and on the ACLK_GPU_NIU (NOC).
+			 */
+			pd_gpu_1@RK3368_PD_GPU_1 {
+				reg = <RK3368_PD_GPU_1>;
+				clocks = <&cru ACLK_GPU_CFG>,
+					 <&cru ACLK_GPU_MEM>,
+					 <&cru SCLK_GPU_CORE>;
+				pm_qos = <&qos_gpu>;
+			};
+		};
+	};
+
 	pmugrf: syscon@ff738000 {
 		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
@@ -731,6 +838,7 @@
 		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3368_PD_VIO>;
 		status = "disabled";
 	};
 
@@ -743,6 +851,7 @@
 		clocks = <&cru ACLK_ISP>, <&cru HCLK_ISP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3368_PD_VIO>;
 		rockchip,disable-mmu-reset;
 		status = "disabled";
 	};
@@ -754,6 +863,7 @@
 		interrupt-names = "vop_mmu";
 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
 		clock-names = "aclk", "iface";
+		power-domains = <&power RK3368_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -767,6 +877,7 @@
 		clocks = <&cru ACLK_VIDEO>, <&cru HCLK_VIDEO>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3368_PD_VIDEO>;
 		status = "disabled";
 	};
 
@@ -779,9 +890,75 @@
 		clocks = <&cru ACLK_VIDEO>, <&cru HCLK_VIDEO>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3368_PD_VIDEO>;
 		status = "disabled";
 	};
 
+	qos_iep: qos@ffad0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0000 0x0 0x20>;
+	};
+
+	qos_isp_r0: qos@ffad0080 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0080 0x0 0x20>;
+	};
+
+	qos_isp_r1: qos@ffad0100 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0100 0x0 0x20>;
+	};
+
+	qos_isp_w0: qos@ffad0180 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0180 0x0 0x20>;
+	};
+
+	qos_isp_w1: qos@ffad0200 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0200 0x0 0x20>;
+	};
+
+	qos_vip: qos@ffad0280 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0280 0x0 0x20>;
+	};
+
+	qos_vop: qos@ffad0300 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0300 0x0 0x20>;
+	};
+
+	qos_rga_r: qos@ffad0380 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0380 0x0 0x20>;
+	};
+
+	qos_rga_w: qos@ffad0400 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0400 0x0 0x20>;
+	};
+
+	qos_hevc_r: qos@ffae0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffae0000 0x0 0x20>;
+	};
+
+	qos_vpu_r: qos@ffae0100 {
+		compatible = "syscon";
+		reg = <0x0 0xffae0100 0x0 0x20>;
+	};
+
+	qos_vpu_w: qos@ffae0180 {
+		compatible = "syscon";
+		reg = <0x0 0xffae0180 0x0 0x20>;
+	};
+
+	qos_gpu: qos@ffaf0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffaf0000 0x0 0x20>;
+	};
+
 	efuse256: efuse@ffb00000 {
 		compatible = "rockchip,rk3368-efuse";
 		reg = <0x0 0xffb00000 0x0 0x20>;
-- 
2.19.2

