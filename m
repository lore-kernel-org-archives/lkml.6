Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920E9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BE5208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BE5208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeGaHjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:39:14 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:41978 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeGaHjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:39:14 -0400
Received: from djw?t-chip.com.cn (unknown [192.168.167.158])
        by regular1.263xmail.com (Postfix) with ESMTP id 56967213;
        Tue, 31 Jul 2018 14:00:37 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 2D1CB3C2;
        Tue, 31 Jul 2018 14:00:26 +0800 (CST)
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 14.20.128.48
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <a3f89377acd7ae2a56ef7705eaa52e55>
X-ATTACHMENT-NUM: 0
X-SENDER: djw@t-chip.com.cn
X-DNS-TYPE: 0
Received: from unknown (unknown [14.20.128.48])
        by smtp.263.net (Postfix) whith SMTP id 28719MAH316;
        Tue, 31 Jul 2018 14:00:32 +0800 (CST)
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] arm64: dts: rockchip: add sdmmc UHS support for roc-rk3328-cc
Date:   Tue, 31 Jul 2018 13:59:22 +0800
Message-Id: <1533016762-5268-5-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

In roc-rk3328-cc board, the signal voltage of sdmmc is supplied by the
vcc_sdio regulator, which is a mux between 1.8V and 3.3V, controlled by
a special output only gpio pin labeled "gpiomut_pmuio_iout",
corresponding bit 1 of the syscon GRF_SOC_CON10.

This special pin can now be reference as <&grf_gpio 0>, thanks to the
gpio-syscon driver, which makes writing regulator-gpio possible.

If the signal voltage changes, the io domain needs to change
correspondingly.

To use this feature, the following options are required in kernel config:
 - CONFIG_GPIO_SYSCON=y
 - CONFIG_POWER_AVS=y
 - CONFIG_ROCKCHIP_IODOMAIN=y

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v4:
- Use <&grf_gpio 0> to refer to the GPIO_MUTE pin.

Changes in v3:
- Use <&gpio_mute 0> instead of <&gpio_mute 1> to refer to the GPIO_MUTE pin.

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in rk3328-roc-cc.dts

Changes in v1:
- Split into small patches
- Sort dts properties in sdmmc node

 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index b983abd..1edb39a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -41,6 +41,19 @@
 		vin-supply = <&vcc_io>;
 	};
 
+	vcc_sdio: sdmmcio-regulator {
+		compatible = "regulator-gpio";
+		gpios = <&grf_gpio 0 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		regulator-name = "vcc_sdio";
+		regulator-type = "voltage";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -213,7 +226,7 @@
 
 	vccio1-supply = <&vcc_io>;
 	vccio2-supply = <&vcc18_emmc>;
-	vccio3-supply = <&vcc_io>;
+	vccio3-supply = <&vcc_sdio>;
 	vccio4-supply = <&vcc_18>;
 	vccio5-supply = <&vcc_io>;
 	vccio6-supply = <&vcc_io>;
@@ -242,7 +255,12 @@
 	max-frequency = <150000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vcc_sdio>;
 	status = "okay";
 };
 
@@ -277,3 +295,7 @@
 &usb_host0_ohci {
 	status = "okay";
 };
+
+&grf_gpio {
+	status = "okay";
+};
-- 
2.7.4


