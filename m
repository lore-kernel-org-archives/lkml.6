Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031297AbeBNUQK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:16:10 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:38670 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030499AbeBNUQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:16:07 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v5 06/12] dt-bindings: display: sun4i-drm: Add A83T HDMI pipeline
Date: Wed, 14 Feb 2018 21:09:00 +0100
Message-Id: <20180214200906.31509-7-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214200906.31509-1-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds all necessary compatibles and descriptions needed to
implement A83T HDMI pipeline.

Mixer is already properly described, so only compatible is added.

However, A83T TV TCON, which is connected to HDMI, doesn't have channel 0,
contrary to all TCONs currently described. Because of that, TCON
documentation is extended.

A83T features Synopsys DW HDMI controller with a custom PHY which looks
like Synopsys Gen2 PHY with few additions. Since there is no
documentation, needed properties were found out through experimentation
and reading BSP code.

At the end, example is added for newer SoCs, which feature DE2 and DW
HDMI.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../bindings/display/sunxi/sun4i-drm.txt           | 61 +++++++++++++++++++---
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index cd626ee1147a..b995bfee734a 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -64,6 +64,52 @@ Required properties:
     first port should be the input endpoint. The second should be the
     output, usually to an HDMI connector.
 
+DWC HDMI TX Encoder
+-------------------
+
+The HDMI transmitter is a Synopsys DesignWare HDMI 1.4 TX controller IP
+with Allwinner's own PHY IP. It supports audio and video outputs and CEC.
+
+These DT bindings follow the Synopsys DWC HDMI TX bindings defined in
+Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt with the
+following device-specific properties.
+
+Required properties:
+
+  - compatible: value must be one of:
+    * "allwinner,sun8i-a83t-dw-hdmi"
+  - reg: base address and size of memory-mapped region
+  - reg-io-width: See dw_hdmi.txt. Shall be 1.
+  - interrupts: HDMI interrupt number
+  - clocks: phandles to the clocks feeding the HDMI encoder
+    * iahb: the HDMI bus clock
+    * isfr: the HDMI register clock
+    * tmds: TMDS clock
+  - clock-names: the clock names mentioned above
+  - resets: phandle to the reset controller
+  - reset-names: must be "ctrl"
+  - phys: phandle to the DWC HDMI PHY
+  - phy-names: must be "phy"
+
+  - ports: A ports node with endpoint definitions as defined in
+    Documentation/devicetree/bindings/media/video-interfaces.txt. The
+    first port should be the input endpoint. The second should be the
+    output, usually to an HDMI connector.
+
+DWC HDMI PHY
+------------
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun8i-a83t-hdmi-phy
+  - reg: base address and size of memory-mapped region
+  - clocks: phandles to the clocks feeding the HDMI PHY
+    * bus: the HDMI PHY interface clock
+    * mod: the HDMI PHY module clock
+  - clock-names: the clock names mentioned above
+  - resets: phandle to the reset controller driving the PHY
+  - reset-names: must be "phy"
+
 TV Encoder
 ----------
 
@@ -94,24 +140,26 @@ Required properties:
    * allwinner,sun7i-a20-tcon
    * allwinner,sun8i-a33-tcon
    * allwinner,sun8i-a83t-tcon-lcd
+   * allwinner,sun8i-a83t-tcon-tv
    * allwinner,sun8i-v3s-tcon
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
- - clocks: phandles to the clocks feeding the TCON. Three are needed:
+ - clocks: phandles to the clocks feeding the TCON.
    - 'ahb': the interface clocks
-   - 'tcon-ch0': The clock driving the TCON channel 0
+   - 'tcon-ch0': The clock driving the TCON channel 0, except for A83T TV TCON
  - resets: phandles to the reset controllers driving the encoder
    - "lcd": the reset line for the TCON channel 0
 
  - clock-names: the clock names mentioned above
  - reset-names: the reset names mentioned above
- - clock-output-names: Name of the pixel clock created
+ - clock-output-names: Name of the pixel clock created, if TCON supports
+   channel 0.
 
 - ports: A ports node with endpoint definitions as defined in
   Documentation/devicetree/bindings/media/video-interfaces.txt. The
   first port should be the input endpoint, the second one the output
 
-  The output may have multiple endpoints. The TCON has two channels,
+  The output may have multiple endpoints. TCON can have 1 or 2 channels,
   usually with the first channel being used for the panels interfaces
   (RGB, LVDS, etc.), and the second being used for the outputs that
   require another controller (TV Encoder, HDMI, etc.). The endpoints
@@ -122,8 +170,8 @@ Required properties:
 On SoCs other than the A33 and V3s, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
 
-On SoCs that support LVDS (all SoCs but the A13, H3, H5 and V3s), you
-need one more reset line:
+When TCON support LVDS (all TCONs except TV TCON on A83T and those found
+in A13, H3, H5 and V3s SoCs), you need one more reset line:
    - 'lvds': The reset line driving the LVDS logic
 
 And on the A23, A31, A31s and A33, you need one more clock line:
@@ -226,6 +274,7 @@ supported.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun8i-a83t-de2-mixer-0
+    * allwinner,sun8i-a83t-de2-mixer-1
     * allwinner,sun8i-v3s-de2-mixer
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
-- 
2.16.1
