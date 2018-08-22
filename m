Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBF3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845EE214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845EE214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeHVQwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:52:22 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:49060 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeHVQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:52:22 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id SDTQ1y00V3XaVaC01DTQoT; Wed, 22 Aug 2018 15:27:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsTAS-0003xO-CD; Wed, 22 Aug 2018 15:27:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsTAS-0007pO-9z; Wed, 22 Aug 2018 15:27:24 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Arnd Bergmann <arnd@arnd.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] Revert "net: stmmac: fix build failure due to missing COMMON_CLK dependency"
Date:   Wed, 22 Aug 2018 15:27:23 +0200
Message-Id: <20180822132723.30047-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.

All legacy clock implementations now implement clk_set_rate() (Some
implementations may be dummies, though).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arnd.de>
Acked-by: Jose Abreu <joabreu@synopsys.com>
---
Marked "RFC", as this depends on "m68k: coldfire: Normalize clk API" and
"MIPS: AR7: Normalize clk API".

v2:
  - Add Acked-by,
  - Dropped RFC state, as all dependencies are now upstream:
      - commit eec85fa9d98a889e ("m68k: coldfire: Normalize clk API"),
      - commit 6b5939d2e528525a ("MIPS: AR7: Normalize clk API").
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index edf20361ea5f15c7..bf4acebb6bcddd88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -33,7 +33,7 @@ config DWMAC_DWC_QOS_ETH
 	select PHYLIB
 	select CRC32
 	select MII
-	depends on OF && COMMON_CLK && HAS_DMA
+	depends on OF && HAS_DMA
 	help
 	  Support for chips using the snps,dwc-qos-ethernet.txt DT binding.
 
@@ -57,7 +57,7 @@ config DWMAC_ANARION
 config DWMAC_IPQ806X
 	tristate "QCA IPQ806x DWMAC support"
 	default ARCH_QCOM
-	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for QCA IPQ806X DWMAC Ethernet.
@@ -100,7 +100,7 @@ config DWMAC_OXNAS
 config DWMAC_ROCKCHIP
 	tristate "Rockchip dwmac support"
 	default ARCH_ROCKCHIP
-	depends on OF && COMMON_CLK && (ARCH_ROCKCHIP || COMPILE_TEST)
+	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for Ethernet controller on Rockchip RK3288 SoC.
@@ -123,7 +123,7 @@ config DWMAC_SOCFPGA
 config DWMAC_STI
 	tristate "STi GMAC support"
 	default ARCH_STI
-	depends on OF && COMMON_CLK && (ARCH_STI || COMPILE_TEST)
+	depends on OF && (ARCH_STI || COMPILE_TEST)
 	select MFD_SYSCON
 	---help---
 	  Support for ethernet controller on STi SOCs.
@@ -147,7 +147,7 @@ config DWMAC_STM32
 config DWMAC_SUNXI
 	tristate "Allwinner GMAC support"
 	default ARCH_SUNXI
-	depends on OF && COMMON_CLK && (ARCH_SUNXI || COMPILE_TEST)
+	depends on OF && (ARCH_SUNXI || COMPILE_TEST)
 	---help---
 	  Support for Allwinner A20/A31 GMAC ethernet controllers.
 
-- 
2.17.1

