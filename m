Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbeBSUWn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:22:43 -0500
Received: from vern.gendns.com ([206.190.152.46]:58393 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753648AbeBSUWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:39 -0500
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v7 01/42] dt-bindings: clock: Add new bindings for TI Davinci PLL clocks
Date: Mon, 19 Feb 2018 14:21:22 -0600
Message-Id: <1519071723-31790-2-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519071723-31790-1-git-send-email-david@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new binding for the PLL IP blocks in the mach-davinci
family of processors. Currently, only da850 has device tree support
but these bindings can also work for other SoCs in this family just
by adding new compatible strings.

Note: Although these PLL controllers are very similar to the TI Keystone
SoCs, we are not re-using those bindings. The Keystone bindings use a
legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs
have a slightly different PLL register layout and a number of quirks
that can't be handled by the existing bindings, so the keystone bindings
could not be used as-is anyway.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- None (there was some debate about having child nodes, but the consensus was
  that this is "good enough" as it is)

v6 changes:
- Added clock-names property
- Added ti,clkmode-square-wave property
- Added pllout child node
- Added obsclk child node
- Expanded examples


 .../devicetree/bindings/clock/ti/davinci/pll.txt   | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt

diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
new file mode 100644
index 0000000..36998e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
@@ -0,0 +1,96 @@
+Binding for TI DaVinci PLL Controllers
+
+The PLL provides clocks to most of the components on the SoC. In addition
+to the PLL itself, this controller also contains bypasses, gates, dividers,
+an multiplexers for various clock signals.
+
+Required properties:
+- compatible: shall be one of:
+	- "ti,da850-pll0" for PLL0 on DA850/OMAP-L138/AM18XX
+	- "ti,da850-pll1" for PLL1 on DA850/OMAP-L138/AM18XX
+- reg: physical base address and size of the controller's register area.
+- clocks: phandles corresponding to the clock names
+- clock-names: names of the clock sources - depends on compatible string
+	- for "ti,da850-pll0", shall be "clksrc", "extclksrc"
+	- for "ti,da850-pll1", shall be "clksrc"
+
+Optional properties:
+- ti,clkmode-square-wave: Indicates that the the board is supplying a square
+	wave input on the OSCIN pin instead of using a crystal oscillator.
+	This property is only valid when compatible = "ti,da850-pll0".
+
+
+Optional child nodes:
+
+pllout
+	Describes the main PLL clock output (before POSTDIV). The node name must
+	be "pllout".
+
+	Required properties:
+	- #clock-cells: shall be 0
+
+sysclk
+	Describes the PLLDIVn divider clocks that provide the SYSCLKn clock
+	domains. The node name must be "sysclk". Consumers of this node should
+	use "n" in "SYSCLKn" as the index parameter for the clock cell.
+
+	Required properties:
+	- #clock-cells: shall be 1
+
+auxclk
+	Describes the AUXCLK output of the PLL. The node name must be "auxclk".
+	This child node is only valid when compatible = "ti,da850-pll0".
+
+	Required properties:
+	- #clock-cells: shall be 0
+
+obsclk
+	Describes the OBSCLK output of the PLL. The node name must be "obsclk".
+
+	Required properties:
+	- #clock-cells: shall be 0
+
+
+Examples:
+
+	pll0: clock-controller@11000 {
+		compatible = "ti,da850-pll0";
+		reg = <0x11000 0x1000>;
+		clocks = <&ref_clk>, <&pll1_sysclk 3>;
+		clock-names = "clksrc", "extclksrc";
+		ti,clkmode-square-wave;
+
+		pll0_pllout: pllout {
+			#clock-cells = <0>;
+		};
+
+		pll0_sysclk: sysclk {
+			#clock-cells = <1>;
+		};
+
+		pll0_auxclk: auxclk {
+			#clock-cells = <0>;
+		};
+
+		pll0_obsclk: obsclk {
+			#clock-cells = <0>;
+		};
+	};
+
+	pll1: clock-controller@21a000 {
+		compatible = "ti,da850-pll1";
+		reg = <0x21a000 0x1000>;
+		clocks = <&ref_clk>;
+		clock-names = "clksrc";
+
+		pll0_sysclk: sysclk {
+			#clock-cells = <1>;
+		};
+
+		pll0_obsclk: obsclk {
+			#clock-cells = <0>;
+		};
+	};
+
+Also see:
+- Documentation/devicetree/bindings/clock/clock-bindings.txt
-- 
2.7.4
