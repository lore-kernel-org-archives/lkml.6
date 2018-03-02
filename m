Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422876AbeCBPo4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:44:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33833 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934173AbeCBPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:44:47 -0500
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        "Simon Glass" <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <u-boot@lists.denx.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/10] arm: dts: stm32: add display for STM32F769 disco board
Date: Fri, 2 Mar 2018 16:44:10 +0100
Message-ID: <1520005451-23217-10-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the display controller, mipi dsi bridge & panel.
Set panel display timings.

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 arch/arm/dts/stm32f769-disco.dts | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/dts/stm32f769-disco.dts b/arch/arm/dts/stm32f769-disco.dts
index 59c9d31..82985b9 100644
--- a/arch/arm/dts/stm32f769-disco.dts
+++ b/arch/arm/dts/stm32f769-disco.dts
@@ -42,6 +42,7 @@
 
 /dts-v1/;
 #include "stm32f746.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/memory/stm32-sdram.h>
 
 / {
@@ -264,3 +265,73 @@
 	bus-width = <4>;
 	max-frequency = <25000000>;
 };
+
+&ltdc {
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ltdc_out_dsi: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&dsi_in>;
+		};
+	};
+};
+
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dsi_in: endpoint {
+				remote-endpoint = <&ltdc_out_dsi>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dsi_out: endpoint {
+				remote-endpoint = <&dsi_panel_in>;
+			};
+		};
+	};
+
+	panel-dsi@0 {
+		compatible = "orisetech,otm8009a";
+		reg = <0>; /* dsi virtual channel (0..3) */
+		reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
+		status = "okay";
+
+		port {
+			dsi_panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+
+		display-timings {
+			timing@0 {
+				clock-frequency = <32729000>;
+				hactive = <480>;
+				hfront-porch = <120>;
+				hback-porch = <63>;
+				hsync-len = <120>;
+				vactive = <800>;
+				vfront-porch = <12>;
+				vback-porch = <12>;
+				vsync-len = <12>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <0>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
-- 
1.9.1
