Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605F3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADE320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfAQHQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:16:31 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:65333 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729294AbfAQHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:16:26 -0500
X-UUID: 6a78dac995514bbcb30776ac0efb4c2e-20190117
X-UUID: 6a78dac995514bbcb30776ac0efb4c2e-20190117
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 147278029; Thu, 17 Jan 2019 15:16:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 15:16:18 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 15:16:17 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>, Min Guo <min.guo@mediatek.com>
Subject: [PATCH v3 2/4] arm: dts: mt2701: Add usb2 device nodes
Date:   Thu, 17 Jan 2019 15:15:46 +0800
Message-ID: <1547709348-17506-3-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Guo <min.guo@mediatek.com>

Add musb nodes and usb2 phy nodes for MT2701

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index be0edb3..2635911 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -6,6 +6,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "mt2701.dtsi"
 
 / {
@@ -60,6 +61,20 @@
 		>;
 		default-brightness-level = <9>;
 	};
+
+	extcon_usb: extcon_iddig {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pio 44 GPIO_ACTIVE_HIGH>;
+	};
+
+	usb_vbus: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 45 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &auxadc {
@@ -229,3 +244,9 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb2 {
+	vbus-supply = <&usb_vbus>;
+	extcon = <&extcon_usb>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 180377e..a6b1434 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -670,6 +670,39 @@
 		};
 	};
 
+	usb2: usb@11200000 {
+		compatible = "mediatek,mt2701-musb",
+			     "mediatek,mtk-musb";
+		reg = <0 0x11200000 0 0x1000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "mc";
+		phys = <&u2port2 PHY_TYPE_USB2>;
+		dr_mode = "otg";
+		clocks = <&pericfg CLK_PERI_USB0>,
+			 <&pericfg CLK_PERI_USB0_MCU>,
+			 <&pericfg CLK_PERI_USB_SLV>;
+		clock-names = "main","mcu","univpll";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+		status = "disabled";
+	};
+
+	u2phy0: usb-phy@11210000 {
+		compatible = "mediatek,generic-tphy-v1";
+		reg = <0 0x11210000 0 0x0800>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "okay";
+
+		u2port2: usb-phy@1a1c4800 {
+			reg = <0 0x11210800 0 0x0100>;
+			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
 	ethsys: syscon@1b000000 {
 		compatible = "mediatek,mt2701-ethsys", "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
-- 
1.9.1

