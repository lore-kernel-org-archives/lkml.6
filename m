Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeE0VzD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:55:03 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:45052 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeE0Vyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:54:51 -0400
From: Stefan Agner <stefan@agner.ch>
To: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/6] mtd: rawnand: tegra: add devicetree binding
Date: Sun, 27 May 2018 23:54:38 +0200
Message-Id: <20180527215442.14760-3-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[26];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <dev@lynxeye.de>

This adds the devicetree binding for the Tegra 2 NAND flash
controller.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../bindings/mtd/nvidia,tegra20-nand.txt      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
new file mode 100644
index 000000000000..49e472af1b39
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
@@ -0,0 +1,62 @@
+NVIDIA Tegra NAND Flash controller
+
+Required properties:
+- compatible: Must be one of:
+  - "nvidia,tegra20-nand"
+- reg: MMIO address range
+- interrupts: interrupt output of the NFC controller
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - nand
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: Must include the following entries:
+  - nand
+
+Optional children nodes:
+Individual NAND chips are children of the NAND controller node. Currently
+only one NAND chip supported.
+
+Required children node properties:
+- reg: An integer ranging from 1 to 6 representing the CS line to use.
+
+Optional children node properties:
+- nand-ecc-mode: String, operation mode of the NAND ecc mode. "hw" by default
+- nand-ecc-algo: string, algorithm of NAND ECC.
+		 Supported values are: "rs", "bch".
+- nand-bus-width : 8 or 16 bus width if not present 8
+- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
+- nand-ecc-strength: integer representing the number of bits to correct
+		     per ECC step. Supported strength using HW ECC modes are:
+		     - RS: 4, 6, 8
+		     - BCH: 4, 8, 14, 16
+- nand-ecc-step-size: integer representing the number of data bytes
+		      that are covered by a single ECC step. Must be 512.
+- wp-gpios: GPIO specifier for the write protect pin.
+
+Optional child node of NAND chip nodes:
+Partitions: see partition.txt
+
+  Example:
+	nand@70008000 {
+		compatible = "nvidia,tegra20-nand";
+		reg = <0x70008000 0x100>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
+		clock-names = "nand";
+		resets = <&tegra_car 13>;
+		reset-names = "nand";
+
+		nand-chip@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			nand-bus-width = <8>;
+			nand-on-flash-bbt;
+			nand-ecc-algo = "bch";
+			nand-ecc-step-size = <512>;
+			nand-ecc-strength = <8>;
+			wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;
+		};
+	};
-- 
2.17.0
