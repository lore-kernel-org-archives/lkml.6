Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935886AbeEYMyB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:54:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54772 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934422AbeEYMxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:53:41 -0400
X-Google-Smtp-Source: AB8JxZrckOoyyNrkn0FxkQo1KlElAiUj1W/yxInkz9Ca6K3136rpig4rUHZkmnFfIGrkVdE1WkD8vQ==
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [RFC PATCH 3/3] dbg: ARM: dts: boneblack: add USB topology and serdev nodes
Date: Fri, 25 May 2018 14:52:57 +0200
Message-Id: <20180525125257.29124-4-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525125257.29124-1-johan@kernel.org>
References: <20180525125257.29124-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hub device and two USB devices, of which one has a combined node.

Note that we need to represent the serial ports as well -- consider
devices with multiple ports per interface; which one should serdev
use? Sibling devices can also be described this way (e.g. gpio@0), and
would need to use the same address size.

Also note that serial ports have a standardised node name in ePAPR.

Not-signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index d154d3133c16..d5f4c78efa53 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -26,3 +26,60 @@
 		opp-supported-hw = <0x06 0x0100>;
 	};
 };
+
+&usb1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	dlink_hub: hub@1 {
+		compatible = "usb2101,8501";
+		reg = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ft232r: device@3 {
+			compatible = "usb403,6001";
+			reg = <3>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			serial@0 {
+				reg = <0>;
+
+				serdev {
+					compatible = "none,serdev-mockup";
+				};
+			};
+		};
+
+		mos7820: device@5 {
+			compatible = "usb9710,7840";
+			reg = <5>;
+
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			interface@0 {
+				compatible = "usbif9710,7840.config1.0";
+				reg = <0 1>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				serial@0 {
+					reg = <0>;
+
+					gnss {
+						compatible = "u-blox,neo-8";
+					};
+				};
+
+				serial@1 {
+					reg = <1>;
+				};
+			};
+		};
+	};
+};
-- 
2.17.0
