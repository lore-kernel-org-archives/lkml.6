Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeEPNm2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:42:28 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50447 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEPNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:42:25 -0400
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: renesas: draak: Describe CVBS input
Date: Wed, 16 May 2018 15:42:08 +0200
Message-Id: <1526478129-16465-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526478129-16465-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1526478129-16465-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe CVBS video input through analog video decoder ADV7180
connected to video input interface VIN4.

The video input signal path is shared with HDMI video input, and
selected by on-board switches SW-53 and SW-54 with CVBS input selected
by the default switches configuration.
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index d03f194..9aba28f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -142,6 +142,11 @@
 		groups = "usb0";
 		function = "usb0";
 	};
+
+	vin4_pins_cvbs: vin4 {
+		groups = "vin4_data8", "vin4_sync", "vin4_clk";
+		function = "vin4";
+	};
 };
 
 &i2c0 {
@@ -154,6 +159,17 @@
 		reg = <0x50>;
 		pagesize = <8>;
 	};
+
+	analog-video@20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+
+		port {
+			adv7180_out: endpoint {
+				remote-endpoint = <&vin4_in>;
+			};
+		};
+	};
 };
 
 &i2c1 {
@@ -246,3 +262,23 @@
 	timeout-sec = <60>;
 	status = "okay";
 };
+
+&vin4 {
+	pinctrl-0 = <&vin4_pins_cvbs>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			vin4_in: endpoint {
+				remote-endpoint = <&adv7180_out>;
+			};
+		};
+	};
+};
-- 
2.7.4
