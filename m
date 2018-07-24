Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D3AECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A4520685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A4520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbeGXCWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:22:15 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58202 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388252AbeGXCWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:22:15 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id BD2E59F6AF;
        Tue, 24 Jul 2018 01:18:17 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/3] arm64: allwinner: dts: h6: add Wi-Fi support for Pine H64 model A/B
Date:   Tue, 24 Jul 2018 09:15:51 +0800
Message-Id: <20180724011551.49603-4-icenowy@aosc.io>
In-Reply-To: <20180724011551.49603-1-icenowy@aosc.io>
References: <20180724011551.49603-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pine H64 model A has a Wi-Fi module connector and the model B has an
on-board RTL8723BS Wi-Fi module.

Add support for them. For model A, as it's not defaultly present, keep
it disabled now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../allwinner/sun50i-h6-pine-h64-model-b.dts  |  8 +++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 29 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
index d0fcc25efb00..d0f775613c9b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -18,3 +18,11 @@
 		};
 	};
 };
+
+&mmc1 {
+	status = "okay";
+};
+
+&wifi_pwrseq {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index a85867f8b684..75db6d4139bf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -40,6 +40,12 @@
 			gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
 		};
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PL2 */
+		status = "disabled";
+	};
 };
 
 &mmc0 {
@@ -50,6 +56,17 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_cldo2>;
+	vqmmc-supply = <&reg_bldo2>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "disabled";
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
@@ -128,12 +145,24 @@
 			};
 
 			reg_cldo2: cldo2 {
+				/*
+				 * This regulator is connected with CLDO3.
+				 * Before the kernel can support synchronized
+				 * enable of coupled regulators, keep them
+				 * both always on as a ugly hack.
+				 */
+				regulator-always-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc-wifi-1";
 			};
 
 			reg_cldo3: cldo3 {
+				/*
+				 * This regulator is connected with CLDO2.
+				 * See the comments for CLDO2.
+				 */
+				regulator-always-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc-wifi-2";
-- 
2.18.0

