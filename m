Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758222AbeD0MNW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:13:22 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:49440 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758022AbeD0MJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:09:31 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v4 03/14] ARM: dts: dra7-mmc-iodelay: Add a new pinctrl group for clk line without pullup
Date: Fri, 27 Apr 2018 17:38:54 +0530
Message-ID: <20180427120905.3665-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a short period when the bus voltage is switched from 3.3v to 1.8v,
(to enumerate UHS mode), the mmc module is disabled and the mmc IO lines
are kept in a state according to the programmed pad mux pull type.

According to 4.2.4.2 Timing to Switch Signal Voltage in "SD Specifications
Part 1 Physical Layer Specification Version 5.00 February 22, 2016", the
host should hold CLK low for at least 5ms.

In order to keep the card line low during voltage switch, the pad mux of
mmc1_clk line should be configured to pull down.

Add a new pinctrl group for clock line without pullup to be used in boards
where mmc1_clk line is not connected to an external pullup.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-mmc-iodelay.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7-mmc-iodelay.dtsi

diff --git a/arch/arm/boot/dts/dra7-mmc-iodelay.dtsi b/arch/arm/boot/dts/dra7-mmc-iodelay.dtsi
new file mode 100644
index 000000000000..aa0947266526
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-mmc-iodelay.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MMC IOdelay values for TI's DRA7xx SoCs.
+ * Copyright (C) 2018 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+&dra7_pmx_core {
+	mmc1_pins_default_no_clk_pu: mmc1_pins_default_no_clk_pu {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+		>;
+	};
+};
-- 
2.17.0
