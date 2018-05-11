Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeEKKAf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:00:35 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51885 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeEKKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:00:32 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: renesas: draak: Describe HDMI input
Date: Fri, 11 May 2018 12:00:02 +0200
Message-Id: <1526032802-14376-4-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe HDMI input connected to VIN4 interface for R-Car D3 Draak
development board.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 68 ++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index d03f194..e0ce462 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -59,6 +59,17 @@
 		};
 	};
 
+	hdmi-in {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&adv7612_in>;
+			};
+		};
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -142,6 +153,11 @@
 		groups = "usb0";
 		function = "usb0";
 	};
+
+	vin4_pins: vin4 {
+		groups = "vin4_data24", "vin4_sync", "vin4_clk", "vin4_clkenb";
+		function = "vin4";
+	};
 };
 
 &i2c0 {
@@ -154,6 +170,35 @@
 		reg = <0x50>;
 		pagesize = <8>;
 	};
+
+	hdmi-decoder@4c {
+		compatible = "adi,adv7612";
+		reg = <0x4c>;
+		default-input = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7612_in: endpoint {
+					remote-endpoint = <&hdmi_con_in>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				adv7612_out: endpoint {
+					pclk-sample = <0>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+
+					remote-endpoint = <&vin4_in>;
+				};
+			};
+		};
+	};
 };
 
 &i2c1 {
@@ -246,3 +291,26 @@
 	timeout-sec = <60>;
 	status = "okay";
 };
+
+&vin4 {
+	pinctrl-0 = <&vin4_pins>;
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
+				hsync-active = <0>;
+				vsync-active = <0>;
+
+				remote-endpoint = <&adv7612_out>;
+			};
+		};
+	};
+};
-- 
2.7.4
