Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B577C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4869208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4869208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936812AbeFRKNX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:13:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934506AbeFRIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8634C7A;
        Mon, 18 Jun 2018 08:16:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 042/279] ARM64: dts: meson-gxl: add USB host support
Date:   Mon, 18 Jun 2018 10:10:27 +0200
Message-Id: <20180618080610.536015394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 8aec5fc1d4d881fe446addb94309efb39d4e5b23 ]

This adds USB host support to the Meson GXL SoC. A dwc3 controller is
used for host-mode, while a dwc2 controller (not added in this patch
because I could not get it working) is used for device-mode only.

The dwc3 controller's internal roothub has two USB2 ports enabled but no
USB3 port. Each of the ports is supplied by a separate PHY. The USB pins
are connected to the SoC's USBHOST_A and USBOTG_B pins.
Due to the way the roothub works internally the USB PHYs are left
enabled. When the dwc3 controller is disabled the PHY is never powered on
so it does not draw any extra power. However, when the dwc3 host
controller is enabled then all PHYs also have to be enabled, otherwise
USB devices will not be detected (regardless of whether they are plugged
into an enabled port or not). This means that only the dwc3 controller
has to be enabled on boards with USB support (instead of requiring all
boards to enable the PHYs additionally with the chance of forgetting to
enable one and breaking all other ports with that as well).

This also adds the USB3 PHY which currently only does some basic
initialization. That however is required because without it high-speed
devices (like USB thumb drives) do not work on some devices (probably
because the bootloader does not configure the USB3 PHY registers).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi |   61 +++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -57,6 +57,67 @@
 			no-map;
 		};
 	};
+
+	soc {
+		usb0: usb@c9000000 {
+			status = "disabled";
+			compatible = "amlogic,meson-gxl-dwc3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc CLKID_USB>;
+			clock-names = "usb_general";
+			resets = <&reset RESET_USB_OTG>;
+			reset-names = "usb_otg";
+
+			dwc3: dwc3@c9000000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xc9000000 0x0 0x100000>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				maximum-speed = "high-speed";
+				snps,dis_u2_susphy_quirk;
+				phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>;
+			};
+		};
+	};
+};
+
+&apb {
+	usb2_phy0: phy@78000 {
+		compatible = "amlogic,meson-gxl-usb2-phy";
+		#phy-cells = <0>;
+		reg = <0x0 0x78000 0x0 0x20>;
+		clocks = <&clkc CLKID_USB>;
+		clock-names = "phy";
+		resets = <&reset RESET_USB_OTG>;
+		reset-names = "phy";
+		status = "okay";
+	};
+
+	usb2_phy1: phy@78020 {
+		compatible = "amlogic,meson-gxl-usb2-phy";
+		#phy-cells = <0>;
+		reg = <0x0 0x78020 0x0 0x20>;
+		clocks = <&clkc CLKID_USB>;
+		clock-names = "phy";
+		resets = <&reset RESET_USB_OTG>;
+		reset-names = "phy";
+		status = "okay";
+	};
+
+	usb3_phy: phy@78080 {
+		compatible = "amlogic,meson-gxl-usb3-phy";
+		#phy-cells = <0>;
+		reg = <0x0 0x78080 0x0 0x20>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clkc CLKID_USB>, <&clkc_AO CLKID_AO_CEC_32K>;
+		clock-names = "phy", "peripheral";
+		resets = <&reset RESET_USB_OTG>, <&reset RESET_USB_OTG>;
+		reset-names = "phy", "peripheral";
+		status = "okay";
+	};
 };
 
 &ethmac {


