Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939077AbeE1NkP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937511AbeE1Kol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 081/496] ARM: dts: rockchip: Fix DWMMC clocks
Date: Mon, 28 May 2018 11:57:46 +0200
Message-Id: <20180528100323.186877882@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit e78c637127ee7683d606737f2e62b5da6fd7b1c3 ]

Trying to boot an RK3328 box with an HS200-capable eMMC, I see said eMMC
fail to initialise as it can't run its tuning procedure, because the
sample clock is missing. Upon closer inspection, whilst the clock is
present in the DT, its name is subtly incorrect per the binding, so
__of_clk_get_by_name() never finds it. By inspection, the drive clock
suffers from a similar problem, so has never worked properly either.

This error has propagated across the 32-bit DTs too, so fix those up.

Fixes: 187d7967a5ee ("ARM: dts: rockchip: add the sdio/sdmmc node for rk3036")
Fixes: faea098e1808 ("ARM: dts: rockchip: add core rk3036 dtsi")
Fixes: 9848ebeb952d ("ARM: dts: rockchip: add core rk3228 dtsi")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/rk3036.dtsi |    4 ++--
 arch/arm/boot/dts/rk322x.dtsi |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -261,7 +261,7 @@
 		max-frequency = <37500000>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		resets = <&cru SRST_SDIO>;
@@ -279,7 +279,7 @@
 		max-frequency = <37500000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		default-sample-phase = <158>;
 		disable-wp;
 		dmas = <&pdma 12>;
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -600,7 +600,7 @@
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
@@ -613,7 +613,7 @@
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdio_clk &sdio_cmd &sdio_bus4>;
@@ -628,7 +628,7 @@
 		max-frequency = <37500000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		bus-width = <8>;
 		default-sample-phase = <158>;
 		fifo-depth = <0x100>;
