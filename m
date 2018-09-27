Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F53BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA8620836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA8620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kippendief.biz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeI0PcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:32:11 -0400
Received: from fallback2.virtu.nl ([217.114.100.110]:43075 "EHLO
        fallback2.virtu.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeI0PcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:32:10 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 11:32:09 EDT
Received: from realmta3.virtu.nl (realmta3.virtu.nl [217.114.99.55])
        by fallback2.virtu.nl (Postfix) with ESMTPS id 35FB228752;
        Thu, 27 Sep 2018 11:09:00 +0200 (CEST)
Received: from efgh.nl ([185.76.17.58] helo=carbon.kippendief.biz)
        by realmta3.virtu.nl with esmtp (Exim 4.80)
        (envelope-from <jorik@kippendief.biz>)
        id 1g5Rns-0001u6-EK; Thu, 27 Sep 2018 10:37:49 +0200
From:   jorik@kippendief.biz
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, jorik@kippendief.biz
Subject: [PATCH] dts: sun8i-h3: add sy8106a to orange pi plus
Date:   Thu, 27 Sep 2018 10:36:36 +0200
Message-Id: <20180927083636.5415-1-jorik@kippendief.biz>
X-Mailer: git-send-email 2.17.1
X-Virtu-SpamScore: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorik Jonker <jorik@kippendief.biz>

The Orange Pi Plus board lacks voltage scaling capabilities in its
current form. This results in random freezes during boot when cpufreq is
enabled, probably due to wrong voltages.

This patch (a copy/paste of 06139c) does the following things on this
board:
- enable r_i2c
- add sy8106a to the r_i2c bus
- have the sy8106a regulate VDD of cpu

I have tested this on two Orange Pi Plus boards, and they run stable
across a range of voltages (and frequencies).

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index b403e5d78..fd64b5c94 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -74,6 +74,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
 &ehci3 {
 	status = "okay";
 };
@@ -119,6 +123,31 @@
 	};
 };
 
+&r_i2c {
+	status = "okay";
+
+	reg_vdd_cpux: regulator@65 {
+		compatible = "silergy,sy8106a";
+		reg = <0x65>;
+		regulator-name = "vdd-cpux";
+		silergy,fixed-microvolt = <1200000>;
+		/*
+		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
+		 * however both the Armbian DVFS table and the official one
+		 * have operating points with voltage under 1.1V, and both
+		 * DVFS table are known to work properly at the lowest
+		 * operating point.
+		 *
+		 * Use 1.0V as the minimum voltage instead.
+		 */
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-ramp-delay = <200>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
 &usbphy {
 	usb3_vbus-supply = <&reg_usb3_vbus>;
 };
-- 
2.17.1

