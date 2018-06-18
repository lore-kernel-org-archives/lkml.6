Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E29C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A40820652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A40820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965116AbeFRJtX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:49:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965196AbeFRIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1AE3C7F;
        Mon, 18 Jun 2018 08:21:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 145/279] ARM: dts: logicpd-som-lv: Fix WL127x Startup Issues
Date:   Mon, 18 Jun 2018 10:12:10 +0200
Message-Id: <20180618080614.822462119@linuxfoundation.org>
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

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 189822cbcbf3ea37c26a15612d8f922c440bc0e0 ]

The VAUX3 rail from the PMIC powers a clock driver which clocks
the WL127x. This corrects a bug which did not correctly associate
the vin-supply with the proper power rail.

This also fixes a typo in the pinmuxing to properly configure the
interrupt pin.

Fixes: ab8dd3aed011 ("ARM: DTS: Add minimal Support for Logic PD
DM3730 SOM-LV")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/logicpd-som-lv.dtsi |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -26,7 +26,7 @@
 		gpio = <&gpio1 3 0>;   /* gpio_3 */
 		startup-delay-us = <70000>;
 		enable-active-high;
-		vin-supply = <&vmmc2>;
+		vin-supply = <&vaux3>;
 	};
 
 	/* HS USB Host PHY on PORT 1 */
@@ -209,7 +209,7 @@
 	};
 	wl127x_gpio: pinmux_wl127x_gpio_pin {
 		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a0c, PIN_INPUT | MUX_MODE4)		/* sys_boot0.gpio_2 */
+			OMAP3_WKUP_IOPAD(0x2a0a, PIN_INPUT | MUX_MODE4)		/* sys_boot0.gpio_2 */
 			OMAP3_WKUP_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE4)	/* sys_boot1.gpio_3 */
 		>;
 	};
@@ -244,6 +244,11 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
+&vaux3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
 &twl {
 	twl_power: power {
 		compatible = "ti,twl4030-power-idle-osc-off", "ti,twl4030-power-idle";


