Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B673C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31941218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfBFDc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:32:56 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33836 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbfBFDcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:32:50 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id DB8975FDD0; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 8/9] ARM: dts: sun9i: a80-optimus: Enable GMAC
Date:   Wed,  6 Feb 2019 11:32:38 +0800
Message-Id: <20190206033239.3619-9-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A80 Optimus has a Realtek RTL8211E ethernet PHY which uses RGMII to
talk to the MAC. The PHY is powered by 2 regulators: cldo1 for the PHY's
core logic and gpio1-ldo for I/O. The latter also powers the SoC side
pins. As there is no binding to model a second regulator supply for the
PHY, it is omitted. It is however properly modeled for the PIO.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 9c25176e69dc..864715ec3cb0 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -120,6 +120,19 @@
 	status = "okay";
 };
 
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_rgmii_pins>;
+	phy = <&phy1>;
+	phy-mode = "rgmii";
+	phy-supply = <&reg_cldo1>;
+	status = "okay";
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -391,6 +404,14 @@
 				 */
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				/*
+				 * The PHY requires 20ms after all voltages
+				 * are applied until core logic is ready and
+				 * 30ms after the reset pin is de-asserted.
+				 * Set a 100ms delay to account for PMIC
+				 * ramp time and board traces.
+				 */
+				regulator-enable-ramp-delay = <100000>;
 				regulator-name = "vcc-gmac-phy";
 			};
 
-- 
2.20.1

