Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeE3OL6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:11:58 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:59091 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeE3OKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:10:30 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 2/6] ARM: dts: dra762: Add MCAN clock support
Date: Wed, 30 May 2018 19:41:29 +0530
Message-ID: <20180530141133.3711-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530141133.3711-1-faiz_abbas@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

MCAN is clocked by H14 divider of DPLL_GMAC. Unlike other
DPLL dividers this DPLL_GMAC H14 divider is controlled by
control module. Adding support for these clocks.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76x.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 1c88c581ff18..bfc82636999c 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -17,3 +17,36 @@
 &crossbar_mpu {
 	ti,irqs-skip = <10 67 68 133 139 140>;
 };
+
+&scm_conf_clocks {
+	dpll_gmac_h14x2_ctrl_ck: dpll_gmac_h14x2_ctrl_ck@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_gmac_x2_ck>;
+		ti,max-div = <63>;
+		reg = <0x03fc>;
+		ti,bit-shift=<20>;
+		ti,latch-bit=<26>;
+		assigned-clocks = <&dpll_gmac_h14x2_ctrl_ck>;
+		assigned-clock-rates = <80000000>;
+	};
+
+	dpll_gmac_h14x2_ctrl_mux_ck: dpll_gmac_h14x2_ctrl_mux_ck@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&dpll_gmac_ck>, <&dpll_gmac_h14x2_ctrl_ck>;
+		reg = <0x3fc>;
+		ti,bit-shift = <29>;
+		ti,latch-bit=<26>;
+		assigned-clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
+		assigned-clock-parents = <&dpll_gmac_h14x2_ctrl_ck>;
+	};
+
+	mcan_clk: mcan_clk@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
+		ti,bit-shift = <27>;
+		reg = <0x3fc>;
+	};
+};
-- 
2.17.0
