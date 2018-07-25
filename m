Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B69C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5797020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5797020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeGYIMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:12:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:17539 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeGYIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:09:31 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pB1ZSLA74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P6x7d5S
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
Subject: [PATCH 05/32] ARM: dts: omap3-gta04: add devconf1 setup for correct tvout pins
Date:   Wed, 25 Jul 2018 08:58:37 +0200
Message-Id: <ea448f034b5061ab6731ee00fc798c68825b6c9c.1532501910.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VENC with external OPA362 amplifier needs a special
"pinmux" setup in DEVCONF1 (TVOUTBYPASS and TVOUTACEN).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fa887743860e..01f590f06536 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -169,6 +169,24 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&tca6507 0 GPIO_ACTIVE_LOW>;	/* W2CBW003 reset through tca6507 */
 	};
+
+	/* devconf1 setup for tvout pins */
+	pinmux_tv_out@480022d8 {
+		compatible = "pinctrl-single";
+		reg = <0x480022d8 4>;	/* CONTROL_DEVCONF1 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,bit-per-mux;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x81>;	/* TV out pin control */
+		#pinctrl-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tv_acbias_devconf1_pins>;
+		tv_acbias_devconf1_pins: pinmux_tv_acbias_devconf1_pins {
+			/*			offset	bits	mask */
+			pinctrl-single,bits = <0x00 0x40800 0x40800>;	/* set TVOUTBYPASS and TVOUTACEN */
+		};
+	};
 };
 
 &omap3_pmx_core {
-- 
2.12.2

