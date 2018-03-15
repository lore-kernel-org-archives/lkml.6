Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeCOQ0L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:26:11 -0400
Received: from h1.radempa.de ([176.9.142.194]:52251 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752205AbeCOQZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:25:32 -0400
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com,
        Harald Geyer <harald@ccbib.org>
Subject: [PATCHv2 4/5] arm64: dts: allwinner: a64: Add pwm device
Date: Thu, 15 Mar 2018 16:25:09 +0000
Message-Id: <20180315162510.11669-5-harald@ccbib.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180315162510.11669-1-harald@ccbib.org>
References: <20180315162510.11669-1-harald@ccbib.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is compatible with A13, so no new driver is needed.
A new compatible string is reserved in the binding documentation, to be
used together with the proper fall back. Tested on Teres-I.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
changes since v1:
 * add and use an A64 specific compatible string
 * claim the full memory range

I saw that Andre Przywara has been working on A64 pwm too and has
submitted some patches a few days ago. I think his patches are functionally
equivalent to this one here, but clean up things a bit and additionally
add support for r_pwm and thus are preferable. See:

https://groups.google.com/forum/#!topic/linux-sunxi/hQFeteP591k

I'm including my patch here mostly to have a consistent series for others
to test. OTOH you might merge the device tree changes here and pick up
the cleanup patches from him. Either way should work fine.

 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi       | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
index 51ff54c8b8ef..5986a3b2a504 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
@@ -5,6 +5,7 @@ Required properties:
     - "allwinner,sun4i-a10-pwm"
     - "allwinner,sun5i-a10s-pwm"
     - "allwinner,sun5i-a13-pwm"
+    - "allwinner,sun50i-a64-pwm","allwinner,sun5i-a13-pwm"
     - "allwinner,sun7i-a20-pwm"
     - "allwinner,sun8i-h3-pwm"
   - reg: physical base address and length of the controller's registers
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..7e72eadd07b1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -364,6 +364,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pin: pwm_pin {
+				pins = "PD22";
+				function = "pwm";
+			};
+
 			rmii_pins: rmii_pins {
 				pins = "PD10", "PD11", "PD13", "PD14", "PD17",
 				       "PD18", "PD19", "PD20", "PD22", "PD23";
@@ -629,6 +634,15 @@
 			#interrupt-cells = <3>;
 		};
 
+		pwm: pwm@1c21400 {
+			compatible = "allwinner,sun50i-a64-pwm",
+				     "allwinner,sun5i-a13-pwm";
+			reg = <0x01c21400 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		rtc: rtc@1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-- 
2.11.0
