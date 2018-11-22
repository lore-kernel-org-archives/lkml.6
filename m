Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA9AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA2820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA2820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394296AbeKVVDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:03:00 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:48380 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394235AbeKVVCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:02:38 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 702F15FD90; Thu, 22 Nov 2018 18:23:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v9 8/8] arm64: dts: allwinner: a64: enable sound on Pinebook
Date:   Thu, 22 Nov 2018 18:23:25 +0800
Message-Id: <20181122102325.29495-9-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

The Pinebook has a headphone jack tied to the HP headphone output of
the SoC, and internal speakers connected to the LINEOUT of the SoC,
through a standalone amplifier.

This commit enables I2S, digital and analog parts of audio codec on
Pinebook, along with a device node for the external amplifier.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
[wens@csie.org: dropped headphone_amp; added headphone amp regulator supply;
		fixed speaker_amp node name and sound-name-prefix name]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index ec537c529726..b6d0b926a2ff 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -74,6 +74,32 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
+
+	speaker_amp: audio-amplifier {
+		compatible = "simple-audio-amplifier";
+		/*
+		 * TODO This is actually a fixed regulator controlled by
+		 * the GPIO line on the PMIC. This should be corrected
+		 * once GPIO support is added for this PMIC.
+		 */
+		VCC-supply = <&reg_ldo_io0>;
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+		sound-name-prefix = "Speaker Amp";
+	};
+
+};
+
+&codec {
+	hpvcc-supply = <&reg_eldo1>;
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
 };
 
 &ehci0 {
@@ -277,6 +303,29 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	status = "okay";
+	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
+	simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
+				    "Microphone", "Internal Microphone Right",
+				    "Headphone", "Headphone Jack",
+				    "Speaker", "Internal Speaker";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"Speaker Amp INL", "LINEOUT",
+			"Speaker Amp INR", "LINEOUT",
+			"Internal Speaker", "Speaker Amp OUTL",
+			"Internal Speaker", "Speaker Amp OUTR",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Internal Microphone Left", "MBIAS",
+			"MIC1", "Internal Microphone Left",
+			"Internal Microphone Right", "HBIAS",
+			"MIC2", "Internal Microphone Right";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.19.1

