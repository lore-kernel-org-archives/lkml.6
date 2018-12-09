Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18468C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDA720837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDA720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLIVvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:51:19 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38371 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIVvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:51:19 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43CfzR5Jf3z1qxKM;
        Sun,  9 Dec 2018 22:51:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43CfzR3Rm4z1qqkb;
        Sun,  9 Dec 2018 22:51:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id wAEq4KOGGl7A; Sun,  9 Dec 2018 22:51:14 +0100 (CET)
X-Auth-Info: 2r071s4YWjbLjLETqj+qetzUebsurUkfWEi2o9hiP2k=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  9 Dec 2018 22:51:13 +0100 (CET)
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] ARM: dts: vf610-bk4: Provide support for reading ID code from MVB device
Date:   Sun,  9 Dec 2018 22:50:56 +0100
Message-Id: <20181209215056.22027-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181113121213.14296-1-lukma@denx.de>
References: <20181113121213.14296-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The procedure to read this ID value is as follows:

rmmod spi_fsl_dspi
insmod spi-gpio.ko

echo 504 > /sys/class/gpio/export
cat /sys/class/gpio/gpio504/value
...
echo 511 > /sys/class/gpio/export
cat /sys/class/gpio/gpio511/value

rmmod spi-gpio.ko
insmod spi_fsl_dspi

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Add 'vf610-bk4:' to mail topic
- Change spi_gpio -> spi-gpio node name
- Change '72xx165' -> 'gpio' as described in
Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
---
 arch/arm/boot/dts/vf610-bk4.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index cab95714c058..c59a8922ccd5 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -59,6 +59,29 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	spi-gpio {
+		compatible = "spi-gpio";
+		pinctrl-0 = <&pinctrl_gpio_spi>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* PTD12 ->RPIO[91] */
+		sck-gpios  = <&gpio2 27 GPIO_ACTIVE_LOW>;
+		/* PTD10 ->RPIO[89] */
+		miso-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <0>;
+
+		gpio@0 {
+			compatible = "pisosr-gpio";
+			reg = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* PTB18 -> RGPIO[40] */
+			load-gpios  = <&gpio1 8 GPIO_ACTIVE_LOW>;
+			spi-max-frequency = <100000>;
+		};
+	};
 };
 
 &adc0 {
@@ -430,6 +453,14 @@
 		>;
 	};
 
+	pinctrl_gpio_spi: pinctrl-gpio-spi {
+		fsl,pins = <
+			VF610_PAD_PTB18__GPIO_40        0x1183
+			VF610_PAD_PTD10__GPIO_89        0x1183
+			VF610_PAD_PTD12__GPIO_91        0x1183
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			VF610_PAD_PTA22__I2C2_SCL               0x34df
-- 
2.11.0

