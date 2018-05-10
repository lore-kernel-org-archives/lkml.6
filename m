Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756995AbeEJJ3P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:29:15 -0400
Received: from regular1.263xmail.com ([211.150.99.133]:37225 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeEJJ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:29:11 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 59.33.101.82
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <8a08539e6a62418933a2e5eb9abc0dfa>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Joseph Chen <chenjh@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rocky Hao <rocky.hao@rock-chips.com>
Subject: [PATCH v1 5/5] arm64: dts: rockchip: Add sdmmc UHS support for roc-rk3328-cc
Date: Thu, 10 May 2018 17:28:41 +0800
Message-Id: <1525944521-17114-1-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

In roc-rk3328-cc board, the signal voltage of sdmmc is supplied by
the vcc_sdio regulator, which is a mux between 1.8V and 3.3V,
controlled by a special output only gpio pin labeled
"gpiomut_pmuio_iout", corresponding bit 1 of the syscon GRF_SOC_CON10.

This special pin can now be reference as <&gpio_syscon10 1>, thanks
to the gpio-syscon driver, which makes writing regulator-gpio possible.

If the signal voltage changes, the io domain needs to change
correspondingly.

To use this feature, the following options are required in kernel config:
 - CONFIG_GPIO_SYSCON=y
 - CONFIG_POWER_AVS=y
 - CONFIG_ROCKCHIP_IODOMAIN=y

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v1:
- Split into small patches
- Sort dts properties in sdmmc node

 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index b983abd..3f33e42 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -41,6 +41,19 @@
 		vin-supply = <&vcc_io>;
 	};
 
+	vcc_sdio: sdmmcio-regulator {
+		compatible = "regulator-gpio";
+		gpios = <&gpio_syscon10 1 GPIO_ACTIVE_HIGH>;
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
 
-- 
2.7.4
