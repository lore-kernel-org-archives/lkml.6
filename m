Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC309C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D66C21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKeEb0j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfBOE5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:57:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35259 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfBOE5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:57:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id z15so4255645pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 20:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kSA1TWJhCcW942nec5H5KUTcw9lD/Qj1J6bxw+KVpGs=;
        b=IKeEb0j6DAR83CuSjVdt+YyIhrkgUdVyBUvbEEJELqkUf4I5O2LdHtKSQF3GXDVXr8
         p+lBX83Z8AvVqicqN6dgQpD90KQr6K48FvDCOEOuqkW+KYy9yRqDXj7PC2yKwQ7bsSJA
         kf6eR03uJ2NwVMbFYaGO08gzKuLMJ5dOQwZcfRP8oxrJWlps6mpeosxAbOA0+Mksm341
         HpsUizT8a2SB9VvjXR6BMuDHyDh5i8VRHiVbIffyNCG7PIQ0ojP8GrEw23oylLkbfTSo
         n+f0ZEXu3X7tk8LvrL+bY22Ljry9OscxM/fZtUz5oaYUs9KlH+y5fir2gCmRAhtcTi5C
         koJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kSA1TWJhCcW942nec5H5KUTcw9lD/Qj1J6bxw+KVpGs=;
        b=UgRRrkFAFiz3W0RrUNX6LdWgfyUPTgO0f/y1dexPqf1rEUuE7KsKlJDtfX8p5POVlu
         p199JCyLwWPf+PL7sXubVVNX6zL9zjaKXpjPwyO/8QmYMTKO5JQy8AZnT9Rn/sC/wT1P
         58RVpjcDLVcPAc1rFw/Xu8+FwnXOYJqmL+fEqLgo2rt689qpcARsTs0ZzONjcrdKP+jt
         MA6QOIdfi6vMibpKJpmyRdP7JUOpAqX+wTusFoeHOlkz83xKqkRpLTdtyarel4fBF60R
         oXm1GX5vV2OxI4XbCmLcH1a679Hx3vrG+R6mqasF8NESTA6r+mVKzIqLZ11yPCTIfFUv
         0+TQ==
X-Gm-Message-State: AHQUAuaEAq/4dPIxOsePdvGOCLwZ+uqnsxb5SyJYncEwcRkLX9eu5i9b
        eTxc7wcMOMEuMKacINOagfiH
X-Google-Smtp-Source: AHgI3IYEo2fZJzhKYguqyf8Kkk3NMjRd9PiChuOsx5/5A+QXOd7rdaa/TR826KA2AgI9mwkoiO9rJQ==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr3592785pgc.165.1550206621218;
        Thu, 14 Feb 2019 20:57:01 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98a:c91:14c4:f458:9909:7fad])
        by smtp.gmail.com with ESMTPSA id y12sm9021267pgh.38.2019.02.14.20.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 20:57:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        tom@vamrs.com, dev@vamrs.com, linux-kernel@vger.kernel.org,
        mani@kernel.org, pbrobinson@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] arm64: dts: rockchip: Add on-board WiFi/BT support for Rock960 boards
Date:   Fri, 15 Feb 2019 10:26:48 +0530
Message-Id: <20190215045648.26380-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add on-board WiFi/BT support for Rock960 boards such as Rock960 based
on AP6356S and Ficus based on AP6354 wireless modules.

Firmwares for the respective boards are available here:

http://people.linaro.org/~manivannan.sadhasivam/rock960_wifi/
http://people.linaro.org/~manivannan.sadhasivam/ficus_wifi/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Added address and size cells property to sdio0 node

 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 98 ++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 56abbb08c133..d33cd441dee9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -9,6 +9,15 @@
 #include "rk3399-opp.dtsi"
 
 / {
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
+	};
+
 	vcc1v8_s0: vcc1v8-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s0";
@@ -362,6 +371,20 @@
 };
 
 &pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_host_wake_l: bt-host-wake-l {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_l: bt-wake-l {
+			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc {
 		sdmmc_bus1: sdmmc-bus1 {
 			rockchip,pins =
@@ -387,6 +410,26 @@
 		};
 	};
 
+	sdio0 {
+		sdio0_bus4: sdio0-bus4 {
+			rockchip,pins =
+				<2 20 RK_FUNC_1 &pcfg_pull_up_20ma>,
+				<2 21 RK_FUNC_1 &pcfg_pull_up_20ma>,
+				<2 22 RK_FUNC_1 &pcfg_pull_up_20ma>,
+				<2 23 RK_FUNC_1 &pcfg_pull_up_20ma>;
+		};
+
+		sdio0_cmd: sdio0-cmd {
+			rockchip,pins =
+				<2 24 RK_FUNC_1 &pcfg_pull_up_20ma>;
+		};
+
+		sdio0_clk: sdio0-clk {
+			rockchip,pins =
+				<2 25 RK_FUNC_1 &pcfg_pull_none_20ma>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins =
@@ -403,6 +446,19 @@
 				<1 14 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins =
+				<0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_host_wake_l: wifi-host-wake-l {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm2 {
@@ -413,6 +469,35 @@
 	status = "okay";
 };
 
+&sdio0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <50000000>;
+	bus-width = <4>;
+	cap-sdio-irq;
+	cap-sd-highspeed;
+	no-emmc;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+	};
+};
+
 &sdhci {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
@@ -439,8 +524,19 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts>;
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+	};
 };
 
 &uart2 {
-- 
2.17.1

