Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7436C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7D82075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edited-us.20150623.gappssmtp.com header.i=@edited-us.20150623.gappssmtp.com header.b="qFEqbtax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7D82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=edited.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935769AbeFRSK1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:10:27 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46979 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935537AbeFRSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:10:25 -0400
Received: by mail-io0-f196.google.com with SMTP id d22-v6so17632122iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edited-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JqrnX7gisdu8gqS3KN9VfZpqg6hrQYOdExt4OP21obg=;
        b=qFEqbtax0CuchLwtgUuf6zCQIRTxPpuGPGXupxc8hYFoM9aaF3M1b+o4IB2F5xG4HZ
         05RmsbIARKnV7mzGN8o5Wi6WkXW+4rxytenWClqzUa0Ye/nKcddNrVLo3inxI9z+KrF9
         rln5xaUImnhhMkCyLPBXWUuVwrKHQrv8oa474rQGsEM38IStw6b75l8uTX24YdTTZXTu
         36SIfZCWdF/+xH4VbjRNTS/7BPGnsGeKCXpTw7qysWgEMb0t6UXdLgllNzlnIR+w5jPk
         s94Yul2AQZP5BxaEJESQ4Y4rnoRfSKkm9Si24vw24arAEZNy4V/pEGmNjrWRhCyO5wlp
         vH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JqrnX7gisdu8gqS3KN9VfZpqg6hrQYOdExt4OP21obg=;
        b=KgEtpquNop+A+uEu2T0HWADGdRSWSwwkogzDUa8IRBLkdw7V988ZymYY4Cu8hBn1c3
         jwsJwNY6lT1DRiaECkpn+5PvWAAGheo512T/X0pxwK7crUm+s637khirf4m1WVwjMPYQ
         HqcRxtG6U43Z0MQbwn76lrL1WmXnzhZ0BxuNCNLm8ppF6lGKTDtVEeAoUiGtDFlzD2lj
         bR9mETEfXu8SNHgkITg9IbFAK3kgHydkQOKAVYCx2HnZ8Hg9+Sk2Q7f0CQa0CLWbqhPI
         USA2SZpsEjoRl75eYOoUIEg6iHKDjT2bRSz6ZQ4SY3D0Na9LuJoA0/gIr50/qYWR/GgG
         SiXA==
X-Gm-Message-State: APt69E2Hp11OfGq8W1MrfhMVx6cS166jX4nONOW3JC/egHN71gT6sg32
        w4ubWLKC0LBED6ZCIJQJO41qAQ==
X-Google-Smtp-Source: ADUXVKIFjfbKtf/uBuXPMw1aD9O2xMpHb6cCIWBPHh3xbNuvog/vUL2xJ+rOAbvH0cghqxMHT1mCtQ==
X-Received: by 2002:a6b:8dd8:: with SMTP id p207-v6mr11354089iod.303.1529345425008;
        Mon, 18 Jun 2018 11:10:25 -0700 (PDT)
Received: from localhost.localdomain (ip-21-240-239-173.midwest.us.northamericancoax.com. [173.239.240.21])
        by smtp.gmail.com with ESMTPSA id w124-v6sm4282751itb.3.2018.06.18.11.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 11:10:23 -0700 (PDT)
From:   Ryan Grachek <ryan@edited.us>
Cc:     john.stultz@linaro.org, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hikey960: Clean up MMC properties and move to proper file
Date:   Mon, 18 Jun 2018 13:10:08 -0500
Message-Id: <20180618181008.21831-1-ryan@edited.us>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain properties should be moved to the board file to reflect
the specific properties of the board, and not the SoC. Move these
properties to proper location and organize properties in both files.

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 27 ++++++++++++++++++-----
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 27 +++++------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index abc991619c75..1c2a9a5d0477 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -602,20 +602,37 @@
 };
 
 &dwmmc1 {
+	bus-width = <0x4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	disable-wp;
+	cd-inverted;
+	cd-gpios = <&gpio25 3 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd_pmx_func
+		&sd_clk_cfg_func
+		&sd_cfg_func>;
 	vmmc-supply = <&ldo16>;
 	vqmmc-supply = <&ldo9>;
 	status = "okay";
 };
 
 &dwmmc2 { /* WIFI */
-	broken-cd;
-	/* WL_EN */
-	vmmc-supply = <&wlan_en>;
+	bus-width = <0x4>;
 	non-removable;
+	broken-cd;
+	cap-sd-highspeed;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	#address-cells = <0x1>;
-	#size-cells = <0x0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio_pmx_func
+		&sdio_clk_cfg_func
+		&sdio_cfg_func>;
+	/* WL_EN */
+	vmmc-supply = <&wlan_en>;
 	status = "ok";
 
 	wlcore: wlcore@2 {
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 74c0509f99e9..fe4c9f321b70 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1114,15 +1114,10 @@
 
 		/* SD */
 		dwmmc1: dwmmc1@ff37f000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cd-inverted;
 			compatible = "hisilicon,hi3660-dw-mshc";
-			bus-width = <0x4>;
-			disable-wp;
-			cap-sd-highspeed;
-			card-detect-delay = <200>;
 			reg = <0x0 0xff37f000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_SD>,
 				<&crg_ctrl HI3660_HCLK_GATE_SD>;
@@ -1130,16 +1125,8 @@
 			clock-frequency = <3200000>;
 			resets = <&crg_rst 0x94 18>;
 			reset-names = "reset";
-			cd-gpios = <&gpio25 3 0>;
 			hisilicon,peripheral-syscon = <&sctrl>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&sd_pmx_func
-				     &sd_clk_cfg_func
-				     &sd_cfg_func>;
-			sd-uhs-sdr12;
-			sd-uhs-sdr25;
-			sd-uhs-sdr50;
-			sd-uhs-sdr104;
+			card-detect-delay = <200>;
 			status = "disabled";
 		};
 
@@ -1147,6 +1134,8 @@
 		dwmmc2: dwmmc2@ff3ff000 {
 			compatible = "hisilicon,hi3660-dw-mshc";
 			reg = <0x0 0xff3ff000 0x0 0x1000>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_SDIO0>,
 				 <&crg_ctrl HI3660_HCLK_GATE_SDIO0>;
@@ -1154,12 +1143,6 @@
 			resets = <&crg_rst 0x94 20>;
 			reset-names = "reset";
 			card-detect-delay = <200>;
-			cap-sd-highspeed;
-			keep-power-in-suspend;
-			pinctrl-names = "default";
-			pinctrl-0 = <&sdio_pmx_func
-				     &sdio_clk_cfg_func
-				     &sdio_cfg_func>;
 			status = "disabled";
 		};
 
-- 
2.11.0

