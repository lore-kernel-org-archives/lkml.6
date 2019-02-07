Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585BB20844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I93jGVOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfBGFyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:54:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42293 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfBGFyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:54:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so4296399plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 21:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=swvbNBv+LvJQkqr26tX9fTzwidgI0RC66IvI6f27eJ4=;
        b=I93jGVOLhr1IScjguAw11x4BSytMhirVNDJLqV4trKpyxqSXZqWzeMsaEownUtXxfC
         zx5uS++CWxWaUdXT7mf/NILyhPcR7PkNT8xPPiFltsy9h0yLmKbN+ALNa/rdDEJhKTTZ
         /H3KdoOnupPf7H8gx2HlhHwIyZKJGBNV3PPY6gIWhdqf1iNLI6PWZXwO89tcIan09rhM
         459mvTqWEpcsQiCDtfVEo8/8uGdUrIuLhjeze9P6/B1zlp4PconxO/4kyWndGgcf9UdI
         FQ6eJPG6hGobXHDtwF0VEIYiYvhG/dCGp6EfytQzp1AWoSPv0Tm71ygvglVV/uhl83c0
         H4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=swvbNBv+LvJQkqr26tX9fTzwidgI0RC66IvI6f27eJ4=;
        b=MFDmCiOH7YU8CJdDMvScAhaMCNhzGfxG3+7O1jQGuP7w+zPAjRhsF0Os49IFE6IMqc
         gFjCDbGgEJLT8kYW14SjwvTlSQCe2AZ8d1Oz4pwCysIUrjBHVxo4FK7JcboyhgQKThJg
         zURlRnATbwFD6QOmS7E1pveucxuIKhIdhUZigGoVBABsy7L97hZ4UiQXqc4gd3iTcbuc
         ErpwoSpjltw9yC1AF3PXItHxrlGGVEWFQpGbN42KIV5t4R185RT7aR/VZl4N/HcF3D5K
         n875pBWs12W8ANY9CBXUU66c3mOUxZVrJyU9l0ossDkvJWh1WAfUJr/v9qah+iBcQYku
         Pe8A==
X-Gm-Message-State: AHQUAuYgSRtIGsqf9a6z+XzOUuXMeptDq2KWkLXRhK+H4D7ZVRqlc0Qs
        BaToxuSKm34DxIJ07ULtYd1i
X-Google-Smtp-Source: AHgI3IZYXmH6xWwIA/mxI4AW/NlCyIWiNufAJdcB8RxL7hLJmRWiEdS8r3/hHfsqYvtU06qrNWTFaw==
X-Received: by 2002:a17:902:449:: with SMTP id 67mr6093465ple.310.1549518847371;
        Wed, 06 Feb 2019 21:54:07 -0800 (PST)
Received: from localhost.localdomain ([2405:204:730d:914e:a8b4:2532:ae24:7d86])
        by smtp.gmail.com with ESMTPSA id l19sm19256807pfi.71.2019.02.06.21.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 21:54:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        tom@vamrs.com, dev@vamrs.com, linux-kernel@vger.kernel.org,
        mani@kernel.org, pbrobinson@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] arm64: dts: rockchip: Add on-board WiFi/BT support for Rock960 boards
Date:   Thu,  7 Feb 2019 11:23:49 +0530
Message-Id: <20190207055349.27919-1-manivannan.sadhasivam@linaro.org>
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
 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 56abbb08c133..1b2f7cd82244 100644
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
@@ -413,6 +469,33 @@
 	status = "okay";
 };
 
+&sdio0 {
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
@@ -439,8 +522,19 @@
 
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

