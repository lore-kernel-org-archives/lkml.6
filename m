Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AB5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0762080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ihnl4FAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0762080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeKADgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:36:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40653 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbeKADgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:36:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9-v6so7686180pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dly3EdXwiM28tvPh6d6lKREUSJ1IEBQJuP8IQUNlkyM=;
        b=ihnl4FAC9v3WdVpJKl0SyPl7KBn6MOFqsqux0aBGJqyrxnd0smcrbfimWGmiDCSDw4
         WrVfp7Wq4AF+/iDSeJ92uwkXR/gCkb2Jg4jzp3A1Uuto+Gkkqrgyym7WJtI4KfU3SNbH
         ToWyZ9NK7CxJ26YYA5QSSTX24nVQl3yrOn2Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dly3EdXwiM28tvPh6d6lKREUSJ1IEBQJuP8IQUNlkyM=;
        b=eZcW2lmqnMvkMIJLZ9A4Xa8vCXnSyOqhoEYUv1nfmWmPIsTFXvmE+nR0tTR+5LIJ/7
         l3owquOPFttH7FJBPnT5NMwhlkMZRwzIlzYiYfHHIVoglnXFd+GA1fLpjbV1ntTSsfK4
         ZdOW/jqxotLyndmWFGmfdHXxaCzDwvgnJ8rK/sAF064d5X1C8pNeddW8c+7dojkVhFX+
         Ofh4MCJ0TsvxKGBOBeTyhhMqy3xDZEGvBuYPFFlxxQIuBkz416Ts+KgylfwXSpMEVjSg
         Lj9hyeDhcpYujALWknlAFPXuFkLodgx+1fRrCIubu0/uCOkBoO62rTMHUO6NrrUvMQT5
         gGKw==
X-Gm-Message-State: AGRZ1gKIwZlMNG/FudcgcR3YrFQjlY9ktGwvvDZ7QISbtXS+daSv1LmP
        bnOlLGjslvWevhIbA196e02YhA==
X-Google-Smtp-Source: AJdET5fypv2rgSROHDnKhcW66LSzIVKvihUqi8CGUWusk2dCQnpaZMRSzmaVnCs792hyW/1ZE9rLEg==
X-Received: by 2002:a17:902:ea:: with SMTP id a97-v6mr4494665pla.164.1541011017390;
        Wed, 31 Oct 2018 11:36:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:4070:221e:94ae:dc27:379e:a542:5441])
        by smtp.gmail.com with ESMTPSA id 72-v6sm37165627pfl.126.2018.10.31.11.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:36:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/7] arm64: allwinner: h6: Add common orangepi nodes into dtsi
Date:   Thu,  1 Nov 2018 00:06:29 +0530
Message-Id: <20181031183634.29640-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orangepi H6 boards, One Plus and Lite2 shares common
nodes like axp805, uart, mmc0 etc and the common differences
between them is Ethernet is available in One Plus where
as Wifi, USB3, CSI port is available in Lite2.

So, add common orangepi nodes into sun50i-h6-orangepi.dtsi

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-h6-orangepi-one-plus.dts | 140 +---------------
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 150 ++++++++++++++++++
 2 files changed, 151 insertions(+), 139 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 0612c19cd994..12e17567ab56 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -4,147 +4,9 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-/dts-v1/;
-
-#include "sun50i-h6.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
+#include "sun50i-h6-orangepi.dtsi"
 
 / {
 	model = "OrangePi One Plus";
 	compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_cldo1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&r_i2c {
-	status = "okay";
-
-	axp805: pmic@36 {
-		compatible = "x-powers,axp805", "x-powers,axp806";
-		reg = <0x36>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		x-powers,self-working-mode;
-
-		regulators {
-			reg_aldo1: aldo1 {
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc-pl";
-			};
-
-			reg_aldo2: aldo2 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc-ac200";
-			};
-
-			reg_aldo3: aldo3 {
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc25-dram";
-			};
-
-			reg_bldo1: bldo1 {
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc-bias-pll";
-			};
-
-			reg_bldo2: bldo2 {
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc-efuse-pcie-hdmi-io";
-			};
-
-			reg_bldo3: bldo3 {
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc-dcxoio";
-			};
-
-			bldo4 {
-				/* unused */
-			};
-
-			reg_cldo1: cldo1 {
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc-3v3";
-			};
-
-			reg_cldo2: cldo2 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc-wifi-1";
-			};
-
-			reg_cldo3: cldo3 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc-wifi-2";
-			};
-
-			reg_dcdca: dcdca {
-				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
-				regulator-name = "vdd-cpu";
-			};
-
-			reg_dcdcc: dcdcc {
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
-				regulator-name = "vdd-gpu";
-			};
-
-			reg_dcdcd: dcdcd {
-				regulator-always-on;
-				regulator-min-microvolt = <960000>;
-				regulator-max-microvolt = <960000>;
-				regulator-name = "vdd-sys";
-			};
-
-			reg_dcdce: dcdce {
-				regulator-always-on;
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-name = "vcc-dram";
-			};
-
-			sw {
-				/* unused */
-			};
-		};
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_ph_pins>;
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
new file mode 100644
index 000000000000..0612c19cd994
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2018 Amarula Solutions
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h6.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "OrangePi One Plus";
+	compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_cldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp805: pmic@36 {
+		compatible = "x-powers,axp805", "x-powers,axp806";
+		reg = <0x36>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		x-powers,self-working-mode;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pl";
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-ac200";
+			};
+
+			reg_aldo3: aldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc25-dram";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-bias-pll";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-efuse-pcie-hdmi-io";
+			};
+
+			reg_bldo3: bldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-dcxoio";
+			};
+
+			bldo4 {
+				/* unused */
+			};
+
+			reg_cldo1: cldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-3v3";
+			};
+
+			reg_cldo2: cldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-wifi-1";
+			};
+
+			reg_cldo3: cldo3 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-wifi-2";
+			};
+
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdcc: dcdcc {
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-name = "vdd-gpu";
+			};
+
+			reg_dcdcd: dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <960000>;
+				regulator-max-microvolt = <960000>;
+				regulator-name = "vdd-sys";
+			};
+
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vcc-dram";
+			};
+
+			sw {
+				/* unused */
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
-- 
2.18.0.321.gffc6fa0e3

