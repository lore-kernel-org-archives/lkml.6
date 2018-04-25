Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755983AbeDYQeF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:34:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36527 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755653AbeDYQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:33:21 -0400
X-Google-Smtp-Source: AIpwx4/BBw1OrKsD/sIm9R6wudX56iU0TSm4tlnll8TkIp3VzAoFLcgTMqy1m0wYYofDmODBcH1JeQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] clk: meson: axg: document bindings for the audio clock controller
Date: Wed, 25 Apr 2018 18:33:03 +0200
Message-Id: <20180425163304.10852-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425163304.10852-1-jbrunet@baylibre.com>
References: <20180425163304.10852-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the device tree bindings of the audio clock
controller of the A113 based SoCs

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.txt      | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
new file mode 100644
index 000000000000..1b989ceda567
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
+- reset		: phandle of the internal reset line
+- #clock-cells	: should be 1.
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume. All available clocks are defined as
+preprocessor macros in the dt-bindings/clock/axg-audio-clkc.h header and can be
+used in device tree sources.
+
+Example:
+
+clkc_audio: clock-controller {
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
-- 
2.14.3
