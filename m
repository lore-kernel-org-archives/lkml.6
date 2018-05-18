Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeEROsq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:48:46 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55913 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeEROsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:48:14 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: renesas: draak: Describe CVBS input
Date: Fri, 18 May 2018 16:47:57 +0200
Message-Id: <1526654878-11143-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526654878-11143-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1526654878-11143-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe CVBS video input through analog video decoder ADV7180
connected to video input interface VIN4.

The video input signal path is shared with HDMI video input, and
selected by on-board switches SW-53 and SW-54 with CVBS input selected
by the default switches configuration.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

---
v2 -> v3:
- Add comment to describe the shared input video path
- Add my SoB and Niklas' R-b tags
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 9d73de8..95745fc 100644
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
@@ -154,6 +159,23 @@
 		reg = <0x50>;
 		pagesize = <8>;
 	};
+
+	analog-video@20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+
+		port {
+			/*
+			 * The VIN4 video input path is shared between
+			 * CVBS and HDMI inputs through SW[49-54] switches.
+			 *
+			 * CVBS is the default selection, link it to VIN4 here.
+			 */
+			adv7180_out: endpoint {
+				remote-endpoint = <&vin4_in>;
+			};
+		};
+	};
 };

 &i2c1 {
@@ -246,3 +268,23 @@
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
