Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F378C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C29820854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="WmaXGohq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C29820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeILXix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:38:53 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52682 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeILXiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:38:52 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6CCAB5C1D14;
        Wed, 12 Sep 2018 20:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536777184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaBv4jnDyG/evfBSq/n0ZMjQhW/OTdgMnwvW64EeIo4=;
        b=WmaXGohqeFbGOshFzIwdR7M58nw9BmFIQfdpYaC96F6GdrYghv4gbS/FL49CuQKjbEF69D
        s3cY7lBr/UaICmQ7HDGrMvgh6cZMSxhHB333Irmf2nvannNVG1K5V4spZTA/EW39dPTa8L
        YVsWny3JonZZzjp3jL1mVr2L0IjmDbE=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 7/8] ARM: dts: imx6qdl-apalis: add VGA support
Date:   Wed, 12 Sep 2018 11:32:21 -0700
Message-Id: <20180912183222.25414-8-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apalis iMX6 modules use a simple DAC using resistor ladders
to convert parallel RGB to VGA. Add support for this output using
the dumb VGA driver.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6q-apalis-eval.dts | 28 +++++++++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi   | 52 +++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 707ac9a46115..ae07b3a105ef 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -140,6 +140,16 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_con_in: endpoint {
+				remote-endpoint = <&vga_bridge_out>;
+			};
+		};
+	};
 };
 
 &backlight {
@@ -281,6 +291,24 @@
 	status = "okay";
 };
 
+&vgabridge {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			vga_bridge_out: endpoint {
+				remote-endpoint = <&vga_con_in>;
+			};
+		};
+	};
+};
+
+&vgadisplay {
+	status = "okay";
+};
+
 &iomuxc {
 	/*
 	 * Mux the Apalis GPIOs
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 05f07ea3e8c8..e8d0407e3e18 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -138,6 +138,54 @@
 		spdif-out;
 		status = "disabled";
 	};
+
+	vgabridge: bridge {
+		compatible = "dumb-vga-dac";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		de-active = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				vga_bridge_in: endpoint {
+					remote-endpoint = <&vga_display_out>;
+				};
+			};
+		};
+	};
+
+	vgadisplay: display@di0 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb565";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu2_vdac>;
+		status = "disabled";
+
+		port@0 {
+			reg = <0>;
+
+			vga_display_in: endpoint {
+				remote-endpoint = <&ipu2_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			vga_display_out: endpoint {
+				remote-endpoint = <&vga_bridge_in>;
+			};
+		};
+	};
+
 };
 
 &audmux {
@@ -373,6 +421,10 @@
 	status = "disabled";
 };
 
+&ipu2_di0_disp0 {
+	remote-endpoint = <&vga_display_in>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
2.18.0

