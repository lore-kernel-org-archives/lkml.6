Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LTBAAL45"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 905A060555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeFFSpg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:45:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43850 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbeFFSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:45:34 -0400
X-Google-Smtp-Source: ADUXVKKvdspK+iOrOFzsVnEHK7AXkS94SEaUAIJ1mDvdpCOPPsqyUPKVtBMAPe/pr/uGcsrIbSty/A==
From: Corentin Labbe <clabbe@baylibre.com>
To: alexandre.torgue@st.com, peppe.cavallaro@st.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] net: stmmac: fix build failure due to missing COMMON_CLK dependency
Date: Wed,  6 Jun 2018 18:45:22 +0000
Message-Id: <1528310722-11512-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the build failure on m68k;
drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.o: In function `ipq806x_gmac_probe':
dwmac-ipq806x.c:(.text+0xda): undefined reference to `clk_set_rate'
drivers/net/ethernet/stmicro/stmmac/dwmac-rk.o: In function `rk_gmac_probe':
dwmac-rk.c:(.text+0x1e58): undefined reference to `clk_set_rate'
drivers/net/ethernet/stmicro/stmmac/dwmac-sti.o: In function `stid127_fix_retime_src':
dwmac-sti.c:(.text+0xd8): undefined reference to `clk_set_rate'
dwmac-sti.c:(.text+0x114): undefined reference to `clk_set_rate'
drivers/net/ethernet/stmicro/stmmac/dwmac-sti.o:dwmac-sti.c:(.text+0x12c): more undefined references to `clk_set_rate' follow
Lots of stmmac platform drivers need COMMON_CLK in their Kconfig depends.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index e28c0d2c58e9..cb5b0f58c395 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -33,7 +33,7 @@ config DWMAC_DWC_QOS_ETH
 	select PHYLIB
 	select CRC32
 	select MII
-	depends on OF && HAS_DMA
+	depends on OF && COMMON_CLK && HAS_DMA
 	help
 	  Support for chips using the snps,dwc-qos-ethernet.txt DT binding.
 
@@ -57,7 +57,7 @@ config DWMAC_ANARION
 config DWMAC_IPQ806X
 	tristate "QCA IPQ806x DWMAC support"
 	default ARCH_QCOM
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for QCA IPQ806X DWMAC Ethernet.
@@ -100,7 +100,7 @@ config DWMAC_OXNAS
 config DWMAC_ROCKCHIP
 	tristate "Rockchip dwmac support"
 	default ARCH_ROCKCHIP
-	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
+	depends on OF && COMMON_CLK && (ARCH_ROCKCHIP || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for Ethernet controller on Rockchip RK3288 SoC.
@@ -123,7 +123,7 @@ config DWMAC_SOCFPGA
 config DWMAC_STI
 	tristate "STi GMAC support"
 	default ARCH_STI
-	depends on OF && (ARCH_STI || COMPILE_TEST)
+	depends on OF && COMMON_CLK && (ARCH_STI || COMPILE_TEST)
 	select MFD_SYSCON
 	---help---
 	  Support for ethernet controller on STi SOCs.
@@ -147,7 +147,7 @@ config DWMAC_STM32
 config DWMAC_SUNXI
 	tristate "Allwinner GMAC support"
 	default ARCH_SUNXI
-	depends on OF && (ARCH_SUNXI || COMPILE_TEST)
+	depends on OF && COMMON_CLK && (ARCH_SUNXI || COMPILE_TEST)
 	---help---
 	  Support for Allwinner A20/A31 GMAC ethernet controllers.
 
-- 
2.16.4
