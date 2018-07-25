Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3494C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6791B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6791B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeGYILS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:11:18 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:28506 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbeGYIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:09:34 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pB1ZSLA74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P6x7d5U
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 08:59:07 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 07/32] ARM: dts: omap3-gta04: fix touchscreen tsc2007
Date:   Wed, 25 Jul 2018 08:58:39 +0200
Message-Id: <7bb1a5e9d1179d39585a391fb65d396dfc68471a.1532501910.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we fix penirq polarity, add penirq pinmux and touchscreen
properties.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e5c1395182bf..c5549d528437 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -301,6 +301,13 @@
 			OMAP3_CORE1_IOPAD(0x2134, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio112 */
 		>;
 	};
+
+	penirq_pins: pinmux_penirq_pins {
+		pinctrl-single,pins = <
+			/* here we could enable to wakeup the cpu from suspend by a pen touch */
+			OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio160 */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
@@ -441,10 +448,19 @@
 	tsc2007@48 {
 		compatible = "ti,tsc2007";
 		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&penirq_pins>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>; /* GPIO_160 */
-		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;	/* GPIO_160 */
 		ti,x-plate-ohms = <600>;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <640>;
+		touchscreen-max-pressure = <1000>;
+		touchscreen-fuzz-x = <3>;
+		touchscreen-fuzz-y = <8>;
+		touchscreen-fuzz-pressure = <10>;
+		touchscreen-inverted-y;
 	};
 
 	/* RFID EEPROM */
-- 
2.12.2

