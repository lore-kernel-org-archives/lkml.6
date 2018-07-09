Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBA9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE1420842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="pv3rGRpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE1420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933744AbeGIP4N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:56:13 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49810 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933357AbeGIPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:49:20 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8468E5C1CDA;
        Mon,  9 Jul 2018 17:49:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531151358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYwNGWAv5dsSdHgoUeJvpX9eEUnLVDGyqfECVUfSsXQ=;
        b=pv3rGRprur47L1msAwnnQ60QLYtIaJc0iVMvrXWJfx3PibHvgktGgf+tAaVxmxc1ZVWo1r
        sVGuJmVGEioB5EkHgxVJZ2v/v4GnbPsEW3IdD8r6aLs1xlvJvju0pjpoSszCUc/pTB0KSK
        aCZSAgLqOrwGsc/0brXX97neyl3tf6U=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        maitysanchayan@gmail.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 6/8] ARM: dts: imx6qdl-apalis/-colibri: fix on-module regulators
Date:   Mon,  9 Jul 2018 17:48:46 +0200
Message-Id: <20180709154848.5401-6-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709154848.5401-1-stefan@agner.ch>
References: <20180709154848.5401-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 2.5V regulator, it does not exist. There is 3.3V and
3.3V_AUDIO provided to the module through the edge connector,
model those as fixed regulators like we use to do in other
Colibri device trees. The SGTL5000 uses 3.3V_AUDIO as VDDA. Note
that the driver derives the analog ground voltage (VAG) from this
supply. The new value should allow higher output swings before
clipping occurs. Refer to the SGTL5000 datasheet for details.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 +++++++++++-----------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 20 ++++++++++----------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 2f711fffa06e..6813f4326807 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -61,17 +61,17 @@
 		status = "disabled";
 	};
 
-	reg_2p5v: regulator-2p5v {
+	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "2P5V";
-		regulator-min-microvolt = <2500000>;
-		regulator-max-microvolt = <2500000>;
+		regulator-name = "+V3.3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
 
-	reg_3p3v: regulator-3p3v {
+	reg_module_3v3_audio: regulator-module-3v3-audio {
 		compatible = "regulator-fixed";
-		regulator-name = "3P3V";
+		regulator-name = "+V3.3_AUDIO";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
@@ -314,8 +314,8 @@
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
-		VDDA-supply = <&reg_2p5v>;
-		VDDIO-supply = <&reg_3p3v>;
+		VDDA-supply = <&reg_module_3v3_audio>;
+		VDDIO-supply = <&reg_module_3v3>;
 	};
 
 	/* STMPE811 touch screen controller */
@@ -447,7 +447,7 @@
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_usdhc1_8bit>;
-	vqmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <8>;
 	disable-wp;
 	no-1-8-v;
@@ -458,7 +458,7 @@
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
-	vqmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <4>;
 	disable-wp;
 	no-1-8-v;
@@ -469,7 +469,7 @@
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-	vqmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <8>;
 	no-1-8-v;
 	non-removable;
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 1a147cb0bed0..9a3bac5be5e2 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -56,17 +56,17 @@
 		status = "disabled";
 	};
 
-	reg_2p5v: regulator-2p5v {
+	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "2P5V";
-		regulator-min-microvolt = <2500000>;
-		regulator-max-microvolt = <2500000>;
+		regulator-name = "+V3.3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
 
-	reg_3p3v: regulator-3p3v {
+	reg_module_3v3_audio: regulator-module-3v3-audio {
 		compatible = "regulator-fixed";
-		regulator-name = "3P3V";
+		regulator-name = "+V3.3_AUDIO";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
@@ -244,8 +244,8 @@
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
-		VDDA-supply = <&reg_2p5v>;
-		VDDIO-supply = <&reg_3p3v>;
+		VDDA-supply = <&reg_module_3v3_audio>;
+		VDDIO-supply = <&reg_module_3v3>;
 		lrclk-strength = <3>;
 	};
 
@@ -380,7 +380,7 @@
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
 	cd-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>; /* MMCD */
 	disable-wp;
-	vqmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <4>;
 	no-1-8-v;
 	status = "disabled";
@@ -390,7 +390,7 @@
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-	vqmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <8>;
 	no-1-8-v;
 	non-removable;
-- 
2.18.0

