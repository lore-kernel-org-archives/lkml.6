Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ABBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07520883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbfAIPDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:03:02 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:55614 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732002AbfAIPDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:03:02 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 5BBFB5FD40; Wed,  9 Jan 2019 23:03:00 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 4/5] ARM: dts: sun8i: r40: bananapi-m2-ultra: Add Bluetooth device node
Date:   Wed,  9 Jan 2019 23:02:56 +0800
Message-Id: <20190109150257.12602-5-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109150257.12602-1-wens@csie.org>
References: <20190109150257.12602-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
identifies as BCM43430, while the Bluetooth side identifies as BCM43438.

The Bluetooth side is connected to UART3 in a 4 wire configuration. Same
as the WiFi side, due to being the same chip and package, DLDO1 and
DLDO2 regulator outputs from the PMIC provide overall power via VBAT and
I/O power via VDDIO. The CLK_OUT_A clock output from the SoC provides
the LPO low power clock at 32.768 kHz.

This patch enables Bluetooth on this board, and also adds the missing
LPO clock on the WiFi side. There is also a PCM connection for
Bluetooth, but this is not covered here.

The LPO clock is fed from CLK_OUT_A, which needs to be muxed on pin
PI12. This can be represented in multiple ways. This patch puts the
pinctrl property in the pin controller node. This is due to limitations
in Linux, where pinmux settings, even the same one, can not be shared
by multiple devices. Thus we cannot put it in both the WiFi and
Bluetooth device nodes. Putting it the CCU node is another option, but
Linux's CCU driver does not handle pinctrl. Also the pin controller is
guaranteed to be initialized after the CCU, when clocks are available.
And any other devices that use muxed pins are guaranteed to be
initialized after the pin controller. Thus having the CLK_OUT_A pinmux
reference be in the pin controller node is a good choice without having
to deal with implementation issues.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 1a6794e63b90..c488aaacbd68 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -102,6 +102,8 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
+		clocks = <&ccu CLK_OUTA>;
+		clock-names = "ext_clock";
 	};
 };
 
@@ -196,6 +198,11 @@
 	status = "okay";
 };
 
+&pio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&clk_out_a_pin>;
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <2500000>;
@@ -293,6 +300,25 @@
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pg_pins>, <&uart3_rts_cts_pg_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&ccu CLK_OUTA>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo2>;
+		vddio-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
+		/* TODO host wake line connected to PMIC GPIO pins */
+		shutdown-gpios = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
+		max-speed = <1500000>;
+	};
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_vcc5v0>;
 	usb2_vbus-supply = <&reg_vcc5v0>;
-- 
2.20.1

