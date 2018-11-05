Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00E4204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qDZ7zJNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00E4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeKERH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:07:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47093 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeKERH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:07:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so3819080pgp.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 23:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5Q+sdCSN0WuQeiZXB4pTMtXM5r578o/UZpfe4ERYhA=;
        b=qDZ7zJNECXbROK9OrrJJjcASSPbX3cwDR24sUCc7bBjVEfXLQ60xUsU4U3qL1/yh0n
         3XC3TZWPMAeYp8Xke6dBOeoR3heJqgOFR2i0RI+HmAHdENf+OsG+WhXSrm5yMze5Kyd+
         VnilRvMgy6CNnqOweVp9bkL3keStjJERMukYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5Q+sdCSN0WuQeiZXB4pTMtXM5r578o/UZpfe4ERYhA=;
        b=NX5FiISLWpeJvFehQigObX2aj1z8oo/AlGsTB5zdEkNP15tsLLAD3XML3cqbhwzkaE
         G6aqMKW3lOzPT+nLDtcze3CFOuS2KCFQdlWdwB3qx+5C9HS5vz9zQixlmaIzE84zS2KY
         dP3JfNZpB8Ppj/utrmGLShqC9rBimWAT+vui3pwIJPlge47xTmgiwks5jmj8ZFu/jIKC
         dyZlRh5sCLodrBoudxGRdvN8bem+cI8nBHbVukJmW/dJ4FHXaOHrZbH28TFpBesZhaPB
         NbpDO7Jo9vTDJdm9XQMF4AjIgNUMHF2XgI122/TGe85fvoxcfhGJdr5W4dnmha5+COdM
         ZSsQ==
X-Gm-Message-State: AGRZ1gJaUrBwiIke1xqiYdT8X1bgZlee7NT8QFZ6IuzVLRDnW9RGKliX
        ZPeh1lhPn9EHcWA8UTNTfV0ILw==
X-Google-Smtp-Source: AJdET5ebRo2+I5AumN37wSrm/4607ZUrFjWLJeTtY71tlVYVFEeJEEuMg2k1Afc+S9acZ/lYCM3Eqw==
X-Received: by 2002:a62:8647:: with SMTP id x68-v6mr21981464pfd.252.1541404143428;
        Sun, 04 Nov 2018 23:49:03 -0800 (PST)
Received: from localhost.localdomain ([2405:204:638e:987d:4588:e264:3e7b:ee8])
        by smtp.gmail.com with ESMTPSA id n189-v6sm14790630pfn.163.2018.11.04.23.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 23:49:02 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        zhaoyifan <zhao_steven@263.net>
Subject: [PATCH v2 2/3] arm64: allwinner: h6: Add common orangepi nodes into dtsi
Date:   Mon,  5 Nov 2018 13:18:41 +0530
Message-Id: <20181105074842.21988-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181105074842.21988-1-jagan@amarulasolutions.com>
References: <20181105074842.21988-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the information from hardware schematics and orangepi
vendor orangepi H6 boards, One Plus and Lite2 shares common nodes
like axp805, uart, mmc0 etc. The common differences between them is
- One Plus, has Ethernet
- Lite2, has Wifi, USB3, CSI port.

So, add common orangepi nodes into sun50i-h6-orangepi.dtsi so-that
it case use on respective orangepi h6 board dts files.

Cc: zhaoyifan <zhao_steven@263.net>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Add proper commit message about vendor intention on
  board differences.

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

