Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F035321473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F035321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeLCJS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:18:58 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55768 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725874AbeLCJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:18:58 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wB38j0o1010630;
        Mon, 3 Dec 2018 10:45:00 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 6B16B62DA7; Mon,  3 Dec 2018 11:14:58 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at,
        robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-mtd@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] dt-binding: mtd: add NPCM FIU controller
Date:   Mon,  3 Dec 2018 11:14:55 +0200
Message-Id: <20181203091456.454030-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181203091456.454030-1-tmaimon77@gmail.com>
References: <20181203091456.454030-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM Flash Interface Unit(FIU) SPI-NOR controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 Documentation/devicetree/bindings/mtd/npcm-fiu.txt | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/npcm-fiu.txt

diff --git a/Documentation/devicetree/bindings/mtd/npcm-fiu.txt b/Documentation/devicetree/bindings/mtd/npcm-fiu.txt
new file mode 100644
index 000000000000..9746cb5b1ced
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/npcm-fiu.txt
@@ -0,0 +1,64 @@
+* Nuvoton FLASH Interface Unit (FIU) SPI Controller
+
+NPCM FIU supports single, dual and quad communication interface.
+
+The NPCM7XX supports three FIU modules,
+FIU0 and FIUx supports two chip selects,
+FIU3 support four chip select.
+
+Required properties:
+  - compatible : "nuvoton,npcm750-fiu" for the NPCM7XX BMC
+  - #address-cells : should be 1.
+  - #size-cells : should be 0.
+  - reg : the first contains the register location and length,
+          the second contains the memory mapping address and length
+  - reg-names: Should contain the reg names "control" and "memory"
+  - clocks : phandle of F reference clock.
+
+Required properties in case the pins can be muxed:
+  - pinctrl-names : a pinctrl state named "default" must be defined.
+  - pinctrl-0 : phandle referencing pin configuration of the device.
+
+Optional property:
+  - spix-mode: enable spix-mode for an expansion bus to an ASIC or CPLD.
+
+The SPI device must be a child of the FIU node and must have a
+compatible property as specified in bindings/mtd/jedec,spi-nor.txt
+
+Required property:
+- reg: chip select number.
+
+Optional property:
+- spi-rx-bus-width: see ../spi/spi-bus.txt for the description.
+
+Aliases:
+- All the FIU controller nodes should be represented in the aliases node using
+  the following format 'fiu{n}' where n is a unique number for the alias.
+  In the NPCM7XX BMC:
+  		fiu0 represent fiu 0 controller
+  		fiu1 represent fiu 3 controller
+  		fiu2 represent fiu x controller
+
+Example:
+fiu3: fiu@c00000000 {
+	compatible = "nuvoton,npcm750-fiu";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
+	reg-names = "control", "memory";
+	clocks = <&clk NPCM7XX_CLK_AHB>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi3_pins>;
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		partition@0 {
+			label = "flash_data";
+			reg = <0x0 0x800000>;
+		};
+	};
+};
+
-- 
2.14.1

