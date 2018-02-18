Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeBRTsI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 14:48:08 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38778 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeBRTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 14:48:02 -0500
X-Google-Smtp-Source: AH8x226yGEnSYS2XabMMne6xPhB4afUzn/m0mZj+kuszkTGGqL70+8Ac+7EUVb/tjf6J6n7/16RX7w==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: tegra30: Add video decoder node
Date: Sun, 18 Feb 2018 22:46:56 +0300
Message-Id: <97998e361326230278c0508e774ff4ec570394c5.1518981147.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518981147.git.digetx@gmail.com>
References: <cover.1518981147.git.digetx@gmail.com>
In-Reply-To: <cover.1518981147.git.digetx@gmail.com>
References: <cover.1518981147.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for the Video Decoder Engine found on Tegra30 SoC's.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 833d97206aef..a110cf84d85f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -97,6 +97,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0x40000000 0x40000>;
+
+		vde_pool: vde@400 {
+			reg = <0x400 0x3fc00>;
+			pool;
+		};
 	};
 
 	host1x@50000000 {
@@ -366,6 +371,28 @@
 		*/
 	};
 
+	vde@6001a000 {
+		compatible = "nvidia,tegra30-vde", "nvidia,tegra20-vde";
+		reg = <0x6001a000 0x1000   /* Syntax Engine */
+		       0x6001b000 0x1000   /* Video Bitstream Engine */
+		       0x6001c000  0x100   /* Macroblock Engine */
+		       0x6001c200  0x100   /* Post-processing Engine */
+		       0x6001c400  0x100   /* Motion Compensation Engine */
+		       0x6001c600  0x100   /* Transform Engine */
+		       0x6001c800  0x100   /* Pixel prediction block */
+		       0x6001ca00  0x100   /* Video DMA */
+		       0x6001d800  0x400>; /* Video frame controls */
+		reg-names = "sxe", "bsev", "mbe", "ppe", "mce",
+			    "tfe", "ppb", "vdma", "frameid";
+		iram = <&vde_pool>; /* IRAM region */
+		interrupts = <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>, /* Sync token interrupt */
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>, /* BSE-V interrupt */
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>; /* SXE interrupt */
+		interrupt-names = "sync-token", "bsev", "sxe";
+		clocks = <&tegra_car TEGRA30_CLK_VDE>;
+		resets = <&tegra_car 61>;
+	};
+
 	apbmisc@70000800 {
 		compatible = "nvidia,tegra30-apbmisc", "nvidia,tegra20-apbmisc";
 		reg = <0x70000800 0x64   /* Chip revision */
-- 
2.16.1
