Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeEVQhQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:37:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34222 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeEVQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:35:09 -0400
X-Google-Smtp-Source: AB8JxZrLhmR9u5ugcxXppIgBKswImhMomAtxRNuKpkPlTvfowrJEHTLp5HHpSMSgeXdouwt5fCDITQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] dt-bindings: clock: add meson axg audio clock controller bindings
Date: Tue, 22 May 2018 18:34:56 +0200
Message-Id: <20180522163457.13834-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180522163457.13834-1-jbrunet@baylibre.com>
References: <20180522163457.13834-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the clock ids dt-bindings usable by the consumers of the clock
controller and add the documentation for the device tree bindings of
the audio clock controller of the A113 based SoCs.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.txt      | 56 +++++++++++++
 include/dt-bindings/clock/axg-audio-clkc.h         | 94 ++++++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
 create mode 100644 include/dt-bindings/clock/axg-audio-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
new file mode 100644
index 000000000000..61777ad24f61
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
@@ -0,0 +1,56 @@
+* Amlogic AXG Audio Clock Controllers
+
+The Amlogic AXG audio clock controller generates and supplies clock to the
+other elements of the audio subsystem, such as fifos, i2s, spdif and pdm
+devices.
+
+Required Properties:
+
+- compatible	: should be "amlogic,axg-audio-clkc" for the A113X and A113D
+- reg		: physical base address of the clock controller and length of
+		  memory mapped region.
+- clocks	: a list of phandle + clock-specifier pairs for the clocks listed
+		  in clock-names.
+- clock-names	: must contain the following:
+		  * "pclk" - Main peripheral bus clock
+		  may contain the following:
+		  * "mst_in[0-7]" - 8 input plls to generate clock signals
+		  * "slv_sclk[0-9]" - 10 slave bit clocks provided by external
+				      components.
+		  * "slv_lrclk[0-9]" - 10 slave sample clocks provided by external
+				       components.
+- resets	: phandle of the internal reset line
+- #clock-cells	: should be 1.
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume. All available clocks are defined as
+preprocessor macros in the dt-bindings/clock/axg-audio-clkc.h header and can be
+used in device tree sources.
+
+Example:
+
+clkc_audio: clock-controller@0 {
+	compatible = "amlogic,axg-audio-clkc";
+	reg = <0x0 0x0 0x0 0xb4>;
+	#clock-cells = <1>;
+
+	clocks = <&clkc CLKID_AUDIO>,
+		 <&clkc CLKID_MPLL0>,
+		 <&clkc CLKID_MPLL1>,
+		 <&clkc CLKID_MPLL2>,
+		 <&clkc CLKID_MPLL3>,
+		 <&clkc CLKID_HIFI_PLL>,
+		 <&clkc CLKID_FCLK_DIV3>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_GP0_PLL>;
+	clock-names = "pclk",
+		      "mst_in0",
+		      "mst_in1",
+		      "mst_in2",
+		      "mst_in3",
+		      "mst_in4",
+		      "mst_in5",
+		      "mst_in6",
+		      "mst_in7";
+	resets = <&reset RESET_AUDIO>;
+};
diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
new file mode 100644
index 000000000000..fd9c362099d9
--- /dev/null
+++ b/include/dt-bindings/clock/axg-audio-clkc.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2018 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __AXG_AUDIO_CLKC_BINDINGS_H
+#define __AXG_AUDIO_CLKC_BINDINGS_H
+
+#define AUD_CLKID_SLV_SCLK0		9
+#define AUD_CLKID_SLV_SCLK1		10
+#define AUD_CLKID_SLV_SCLK2		11
+#define AUD_CLKID_SLV_SCLK3		12
+#define AUD_CLKID_SLV_SCLK4		13
+#define AUD_CLKID_SLV_SCLK5		14
+#define AUD_CLKID_SLV_SCLK6		15
+#define AUD_CLKID_SLV_SCLK7		16
+#define AUD_CLKID_SLV_SCLK8		17
+#define AUD_CLKID_SLV_SCLK9		18
+#define AUD_CLKID_SLV_LRCLK0		19
+#define AUD_CLKID_SLV_LRCLK1		20
+#define AUD_CLKID_SLV_LRCLK2		21
+#define AUD_CLKID_SLV_LRCLK3		22
+#define AUD_CLKID_SLV_LRCLK4		23
+#define AUD_CLKID_SLV_LRCLK5		24
+#define AUD_CLKID_SLV_LRCLK6		25
+#define AUD_CLKID_SLV_LRCLK7		26
+#define AUD_CLKID_SLV_LRCLK8		27
+#define AUD_CLKID_SLV_LRCLK9		28
+#define AUD_CLKID_DDR_ARB		29
+#define AUD_CLKID_PDM			30
+#define AUD_CLKID_TDMIN_A		31
+#define AUD_CLKID_TDMIN_B		32
+#define AUD_CLKID_TDMIN_C		33
+#define AUD_CLKID_TDMIN_LB		34
+#define AUD_CLKID_TDMOUT_A		35
+#define AUD_CLKID_TDMOUT_B		36
+#define AUD_CLKID_TDMOUT_C		37
+#define AUD_CLKID_FRDDR_A		38
+#define AUD_CLKID_FRDDR_B		39
+#define AUD_CLKID_FRDDR_C		40
+#define AUD_CLKID_TODDR_A		41
+#define AUD_CLKID_TODDR_B		42
+#define AUD_CLKID_TODDR_C		43
+#define AUD_CLKID_LOOPBACK		44
+#define AUD_CLKID_SPDIFIN		45
+#define AUD_CLKID_SPDIFOUT		46
+#define AUD_CLKID_RESAMPLE		47
+#define AUD_CLKID_POWER_DETECT		48
+#define AUD_CLKID_MST_A_MCLK		49
+#define AUD_CLKID_MST_B_MCLK		50
+#define AUD_CLKID_MST_C_MCLK		51
+#define AUD_CLKID_MST_D_MCLK		52
+#define AUD_CLKID_MST_E_MCLK		53
+#define AUD_CLKID_MST_F_MCLK		54
+#define AUD_CLKID_SPDIFOUT_CLK		55
+#define AUD_CLKID_SPDIFIN_CLK		56
+#define AUD_CLKID_PDM_DCLK		57
+#define AUD_CLKID_PDM_SYSCLK		58
+#define AUD_CLKID_MST_A_SCLK		79
+#define AUD_CLKID_MST_B_SCLK		80
+#define AUD_CLKID_MST_C_SCLK		81
+#define AUD_CLKID_MST_D_SCLK		82
+#define AUD_CLKID_MST_E_SCLK		83
+#define AUD_CLKID_MST_F_SCLK		84
+#define AUD_CLKID_MST_A_LRCLK		86
+#define AUD_CLKID_MST_B_LRCLK		87
+#define AUD_CLKID_MST_C_LRCLK		88
+#define AUD_CLKID_MST_D_LRCLK		89
+#define AUD_CLKID_MST_E_LRCLK		90
+#define AUD_CLKID_MST_F_LRCLK		91
+#define AUD_CLKID_TDMIN_A_SCLK_SEL	116
+#define AUD_CLKID_TDMIN_B_SCLK_SEL	117
+#define AUD_CLKID_TDMIN_C_SCLK_SEL	118
+#define AUD_CLKID_TDMIN_LB_SCLK_SEL	119
+#define AUD_CLKID_TDMOUT_A_SCLK_SEL	120
+#define AUD_CLKID_TDMOUT_B_SCLK_SEL	121
+#define AUD_CLKID_TDMOUT_C_SCLK_SEL	122
+#define AUD_CLKID_TDMIN_A_SCLK		123
+#define AUD_CLKID_TDMIN_B_SCLK		124
+#define AUD_CLKID_TDMIN_C_SCLK		125
+#define AUD_CLKID_TDMIN_LB_SCLK		126
+#define AUD_CLKID_TDMOUT_A_SCLK		127
+#define AUD_CLKID_TDMOUT_B_SCLK		128
+#define AUD_CLKID_TDMOUT_C_SCLK		129
+#define AUD_CLKID_TDMIN_A_LRCLK		130
+#define AUD_CLKID_TDMIN_B_LRCLK		131
+#define AUD_CLKID_TDMIN_C_LRCLK		132
+#define AUD_CLKID_TDMIN_LB_LRCLK	133
+#define AUD_CLKID_TDMOUT_A_LRCLK	134
+#define AUD_CLKID_TDMOUT_B_LRCLK	135
+#define AUD_CLKID_TDMOUT_C_LRCLK	136
+
+#endif /* __AXG_AUDIO_CLKC_BINDINGS_H */
-- 
2.14.3
