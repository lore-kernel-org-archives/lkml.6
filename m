Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CBAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB98F207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfA3P6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:58:54 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43942 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfA3P6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:58:54 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 2C9173A663B;
        Wed, 30 Jan 2019 16:50:30 +0100 (CET)
X-Originating-IP: 90.88.147.226
Received: from localhost.localdomain (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8D4E0FF811;
        Wed, 30 Jan 2019 15:50:27 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/3] dt-bindings: phy: Add bindings for the SMSC USB333x ULPI USB PHY
Date:   Wed, 30 Jan 2019 16:50:21 +0100
Message-Id: <20190130155023.4495-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130155023.4495-1-paul.kocialkowski@bootlin.com>
References: <20190130155023.4495-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the device-tree bindings for this ULPI USB PHY.
Optional bindings that are not prefixed with the vendor may be
relevant to other ULPI USB PHYs since they match generic ULPI
registers.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../devicetree/bindings/phy/smsc-usb333x.txt  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/smsc-usb333x.txt

diff --git a/Documentation/devicetree/bindings/phy/smsc-usb333x.txt b/Documentation/devicetree/bindings/phy/smsc-usb333x.txt
new file mode 100644
index 000000000000..50d500d67b2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/smsc-usb333x.txt
@@ -0,0 +1,50 @@
+Device tree bindings for SMSC USB333x ULPI USB PHY
+
+Required properties:
+- compatible: Should be "smsc,usb333x".
+
+Optional properties:
+- reset-gpios: GPIO to reset the PHY.
+- clocks: Reference clock that feeds the PHY's PLL.
+- clock-names: Should be "refclk" for the reference clock.
+- extvbus-passthru: Enable EXTVBUS signal pass-through to assert the VbusValid
+  signal internally. This is useful when no VBUS line is connected to the PHY.
+- auto-resume: Enable automatic transmission resume (in host mode).
+- chrg-vbus: Enable internal VBUS pull-up to 3.3 V during OTG SRP.
+- dischrg-vbus: Enable internal VBUS pull-down during OTG SRP.
+- id-pull-up: Enable internal ID pull-up tp 3.3 V.
+- smsc,varisense: Squelch detector threshold register field value, as described
+  in the datasheet.
+- smsc,phyboost: Output voltage change register field value, as described in the
+  datasheet.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+Refer to usb/ulpi.txt for the parent ULPI bus binding required for this PHY.
+
+Example:
+
+&usb0 {
+	compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
+	clocks = <&clkc 28>;
+	interrupt-parent = <&intc>;
+	interrupts = <0 21 4>;
+	reg = <0xe0002000 0x1000>;
+	dr_mode = "peripheral";
+	phys = <&usb_phy0>;
+	phy-names = "usb-phy";
+	phy_type = "ulpi";
+
+	ulpi {
+		usb_phy0: usb-phy0 {
+			#phy-cells = <0>;
+			compatible = "smsc,usb333x";
+			reset-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+			clocks = <&usb_phy_clk>;
+			clock-names = "refclk";
+			smsc,varisense = <1>;
+			smsc,phyboost = <5>;
+			extvbus-passthru;
+			chrg-vbus;
+		};
+	};
+};
-- 
2.20.1

