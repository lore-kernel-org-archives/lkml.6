Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFA9C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D95B223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D95B223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbeKOTnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:43:50 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:46464 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388055AbeKOTnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:43:13 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 1433B5FDD9; Thu, 15 Nov 2018 17:36:05 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/15] arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node
Date:   Thu, 15 Nov 2018 17:36:03 +0800
Message-Id: <20181115093603.26729-16-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
References: <20181115093603.26729-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
identifies as BCM43430, while the Bluetooth side identifies as BCM43438.

The Bluetooth side is connected to UART1 in a 4 wire configuration. Same
as the WiFi side, due to being the same chip and package, DLDO2 provides
overall power via VBAT, and DLDO4 provides I/O power via VDDIO. The RTC
clock output provides the LPO low power clock at 32.768 kHz.

This patch enables Bluetooth on this board, and also adds the missing
LPO clock on the WiFi side. There is also a PCM connection for Bluetooth,
but this is not covered here.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index ef1c90401bb2..beca5c4979cf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -94,6 +94,8 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
 	};
 };
 
@@ -335,7 +337,19 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo2>;
+		vddio-supply = <&reg_dldo4>;
+		device-wakeup-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		host-wakeup-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		shutdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+	};
 };
 
 &usb_otg {
-- 
2.19.1

