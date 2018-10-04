Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86512C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CFD20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CFD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJDTXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:23:20 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43993 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbeJDTXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:23:20 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id D7E4566839;
        Thu,  4 Oct 2018 12:30:12 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 04/10] arm64: allwinner: dts: h6: add USB2-related device nodes
Date:   Thu,  4 Oct 2018 20:28:49 +0800
Message-Id: <20181004122855.22981-5-icenowy@aosc.io>
In-Reply-To: <20181004122855.22981-1-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has two USB2 ports, one OTG and one host-only.

Add device tree nodes related to them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
No changes in v4.

Changes in v3:
- Removed the wrongly introduced usb3phy node.
- Added Chen-Yu's Review tag.

 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 81 ++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 040828d2e2c0..3d60af6cb3ae 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -258,6 +258,87 @@
 			status = "disabled";
 		};
 
+		usb2otg: usb@5100000 {
+			compatible = "allwinner,sun8i-a33-musb";
+			reg = <0x05100000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usb2phy 0>;
+			phy-names = "usb";
+			extcon = <&usb2phy 0>;
+			status = "disabled";
+		};
+
+		usb2phy: phy@5100400 {
+			compatible = "allwinner,sun50i-h6-usb-phy";
+			reg = <0x05100400 0x14>,
+			      <0x05101800 0x4>,
+			      <0x05311800 0x4>;
+			reg-names = "phy_ctrl",
+				    "pmu0",
+				    "pmu3";
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY3>;
+			clock-names = "usb0_phy",
+				      "usb3_phy";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY3>;
+			reset-names = "usb0_reset",
+				      "usb3_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci0: usb@5101000 {
+			compatible = "allwinner,sun50i-h6-ehci", "generic-ehci";
+			reg = <0x05101000 0x100>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_BUS_EHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>,
+				 <&ccu RST_BUS_EHCI0>;
+			status = "disabled";
+		};
+
+		ohci0: usb@5101400 {
+			compatible = "allwinner,sun50i-h6-ohci", "generic-ohci";
+			reg = <0x05101400 0x100>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			status = "disabled";
+		};
+
+		ehci3: usb@5311000 {
+			compatible = "allwinner,sun50i-h6-ehci", "generic-ehci";
+			reg = <0x05311000 0x100>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI3>,
+				 <&ccu CLK_BUS_EHCI3>,
+				 <&ccu CLK_USB_OHCI3>;
+			resets = <&ccu RST_BUS_OHCI3>,
+				 <&ccu RST_BUS_EHCI3>;
+			phys = <&usb2phy 3>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci3: usb@5311400 {
+			compatible = "allwinner,sun50i-h6-ohci", "generic-ohci";
+			reg = <0x05311400 0x100>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI3>,
+				 <&ccu CLK_USB_OHCI3>;
+			resets = <&ccu RST_BUS_OHCI3>;
+			phys = <&usb2phy 3>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		r_ccu: clock@7010000 {
 			compatible = "allwinner,sun50i-h6-r-ccu";
 			reg = <0x07010000 0x400>;
-- 
2.18.0

