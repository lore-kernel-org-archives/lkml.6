Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E8C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C20240F3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C20240F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeFVLJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:09:02 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:37326 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeFVLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:09:00 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 1n8n1y00a3XaVaC01n8nla; Fri, 22 Jun 2018 13:08:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWJvr-0002Ol-Ki; Fri, 22 Jun 2018 13:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWJvr-0008KJ-IL; Fri, 22 Jun 2018 13:08:47 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>
Cc:     Wright Feng <wright.feng@cypress.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Quan Nguyen <qnguyen@apm.com>,
        Keyur Chudgar <kchudgar@apm.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Iyappan Subramanian <isubramanian@apm.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] net: Remove depends on HAS_DMA in case of platform dependency
Date:   Fri, 22 Jun 2018 13:08:43 +0200
Message-Id: <20180622110843.31965-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
In most cases this other symbol is an architecture or platform specific
symbol, or PCI.

Generic symbols and drivers without platform dependencies keep their
dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
cannot work anyway.

This simplifies the dependencies, and allows to improve compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
v4:
  - Rebase to v4.18-rc1 (applies to next-20180622, too),

v3:
  - Rebase to v4.17-rc1,
  - Drop obsolete note about FSL_FMAN,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/net/ethernet/amd/Kconfig                | 2 +-
 drivers/net/ethernet/apm/xgene-v2/Kconfig       | 1 -
 drivers/net/ethernet/apm/xgene/Kconfig          | 1 -
 drivers/net/ethernet/arc/Kconfig                | 6 ++++--
 drivers/net/ethernet/broadcom/Kconfig           | 2 --
 drivers/net/ethernet/calxeda/Kconfig            | 2 +-
 drivers/net/ethernet/hisilicon/Kconfig          | 2 +-
 drivers/net/ethernet/marvell/Kconfig            | 8 +++-----
 drivers/net/ethernet/mellanox/mlxsw/Kconfig     | 2 +-
 drivers/net/ethernet/renesas/Kconfig            | 2 --
 drivers/net/wireless/broadcom/brcm80211/Kconfig | 1 -
 drivers/net/wireless/quantenna/qtnfmac/Kconfig  | 2 +-
 12 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index d5c15e8bb3de706b..f273af136fc7c995 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -173,7 +173,7 @@ config SUNLANCE
 
 config AMD_XGBE
 	tristate "AMD 10GbE Ethernet driver"
-	depends on ((OF_NET && OF_ADDRESS) || ACPI || PCI) && HAS_IOMEM && HAS_DMA
+	depends on ((OF_NET && OF_ADDRESS) || ACPI || PCI) && HAS_IOMEM
 	depends on X86 || ARM64 || COMPILE_TEST
 	select BITREVERSE
 	select CRC32
diff --git a/drivers/net/ethernet/apm/xgene-v2/Kconfig b/drivers/net/ethernet/apm/xgene-v2/Kconfig
index 1205861b631896a0..eedd3f3dd22e2201 100644
--- a/drivers/net/ethernet/apm/xgene-v2/Kconfig
+++ b/drivers/net/ethernet/apm/xgene-v2/Kconfig
@@ -1,6 +1,5 @@
 config NET_XGENE_V2
 	tristate "APM X-Gene SoC Ethernet-v2 Driver"
-	depends on HAS_DMA
 	depends on ARCH_XGENE || COMPILE_TEST
 	help
 	  This is the Ethernet driver for the on-chip ethernet interface
diff --git a/drivers/net/ethernet/apm/xgene/Kconfig b/drivers/net/ethernet/apm/xgene/Kconfig
index afccb033177b3923..e4e33c900b577161 100644
--- a/drivers/net/ethernet/apm/xgene/Kconfig
+++ b/drivers/net/ethernet/apm/xgene/Kconfig
@@ -1,6 +1,5 @@
 config NET_XGENE
 	tristate "APM X-Gene SoC Ethernet Driver"
-	depends on HAS_DMA
 	depends on ARCH_XGENE || COMPILE_TEST
 	select PHYLIB
 	select MDIO_XGENE
diff --git a/drivers/net/ethernet/arc/Kconfig b/drivers/net/ethernet/arc/Kconfig
index e743ddf46343302f..5d0ab8e74b680cc6 100644
--- a/drivers/net/ethernet/arc/Kconfig
+++ b/drivers/net/ethernet/arc/Kconfig
@@ -24,7 +24,8 @@ config ARC_EMAC_CORE
 config ARC_EMAC
 	tristate "ARC EMAC support"
 	select ARC_EMAC_CORE
-	depends on OF_IRQ && OF_NET && HAS_DMA && (ARC || COMPILE_TEST)
+	depends on OF_IRQ && OF_NET
+	depends on ARC || COMPILE_TEST
 	---help---
 	  On some legacy ARC (Synopsys) FPGA boards such as ARCAngel4/ML50x
 	  non-standard on-chip ethernet device ARC EMAC 10/100 is used.
@@ -33,7 +34,8 @@ config ARC_EMAC
 config EMAC_ROCKCHIP
 	tristate "Rockchip EMAC support"
 	select ARC_EMAC_CORE
-	depends on OF_IRQ && OF_NET && REGULATOR && HAS_DMA && (ARCH_ROCKCHIP || COMPILE_TEST)
+	depends on OF_IRQ && OF_NET && REGULATOR
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	---help---
 	  Support for Rockchip RK3036/RK3066/RK3188 EMAC ethernet controllers.
 	  This selects Rockchip SoC glue layer support for the
diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index af75156919edfead..4c3bfde6e8de00f2 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -157,7 +157,6 @@ config BGMAC
 config BGMAC_BCMA
 	tristate "Broadcom iProc GBit BCMA support"
 	depends on BCMA && BCMA_HOST_SOC
-	depends on HAS_DMA
 	depends on BCM47XX || ARCH_BCM_5301X || COMPILE_TEST
 	select BGMAC
 	select PHYLIB
@@ -170,7 +169,6 @@ config BGMAC_BCMA
 
 config BGMAC_PLATFORM
 	tristate "Broadcom iProc GBit platform support"
-	depends on HAS_DMA
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	depends on OF
 	select BGMAC
diff --git a/drivers/net/ethernet/calxeda/Kconfig b/drivers/net/ethernet/calxeda/Kconfig
index 07d2201530d26c85..9fdd496b90ff47cb 100644
--- a/drivers/net/ethernet/calxeda/Kconfig
+++ b/drivers/net/ethernet/calxeda/Kconfig
@@ -1,6 +1,6 @@
 config NET_CALXEDA_XGMAC
 	tristate "Calxeda 1G/10G XGMAC Ethernet driver"
-	depends on HAS_IOMEM && HAS_DMA
+	depends on HAS_IOMEM
 	depends on ARCH_HIGHBANK || COMPILE_TEST
 	select CRC32
 	help
diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 8bcf470ff5f38a4e..fb1a7251f45d3369 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_HISILICON
 	bool "Hisilicon devices"
 	default y
-	depends on (OF || ACPI) && HAS_DMA
+	depends on OF || ACPI
 	depends on ARM || ARM64 || COMPILE_TEST
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
index cc2f7701e71e1b03..f33fd22b351c856a 100644
--- a/drivers/net/ethernet/marvell/Kconfig
+++ b/drivers/net/ethernet/marvell/Kconfig
@@ -18,8 +18,8 @@ if NET_VENDOR_MARVELL
 
 config MV643XX_ETH
 	tristate "Marvell Discovery (643XX) and Orion ethernet support"
-	depends on (MV64X60 || PPC32 || PLAT_ORION || COMPILE_TEST) && INET
-	depends on HAS_DMA
+	depends on MV64X60 || PPC32 || PLAT_ORION || COMPILE_TEST
+	depends on INET
 	select PHYLIB
 	select MVMDIO
 	---help---
@@ -58,7 +58,6 @@ config MVNETA_BM_ENABLE
 config MVNETA
 	tristate "Marvell Armada 370/38x/XP/37xx network interface support"
 	depends on ARCH_MVEBU || COMPILE_TEST
-	depends on HAS_DMA
 	select MVMDIO
 	select PHYLINK
 	---help---
@@ -84,7 +83,6 @@ config MVNETA_BM
 config MVPP2
 	tristate "Marvell Armada 375/7K/8K network interface support"
 	depends on ARCH_MVEBU || COMPILE_TEST
-	depends on HAS_DMA
 	select MVMDIO
 	select PHYLINK
 	---help---
@@ -93,7 +91,7 @@ config MVPP2
 
 config PXA168_ETH
 	tristate "Marvell pxa168 ethernet support"
-	depends on HAS_IOMEM && HAS_DMA
+	depends on HAS_IOMEM
 	depends on CPU_PXA168 || ARCH_BERLIN || COMPILE_TEST
 	select PHYLIB
 	---help---
diff --git a/drivers/net/ethernet/mellanox/mlxsw/Kconfig b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
index f4d9c9975ac3d857..82827a8d3d67cac7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
@@ -30,7 +30,7 @@ config MLXSW_CORE_THERMAL
 
 config MLXSW_PCI
 	tristate "PCI bus implementation for Mellanox Technologies Switch ASICs"
-	depends on PCI && HAS_DMA && HAS_IOMEM && MLXSW_CORE
+	depends on PCI && HAS_IOMEM && MLXSW_CORE
 	default m
 	---help---
 	  This is PCI bus implementation for Mellanox Technologies Switch ASICs.
diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index 27be51f0a421b43e..f3f7477043ce1061 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -17,7 +17,6 @@ if NET_VENDOR_RENESAS
 
 config SH_ETH
 	tristate "Renesas SuperH Ethernet support"
-	depends on HAS_DMA
 	depends on ARCH_RENESAS || SUPERH || COMPILE_TEST
 	select CRC32
 	select MII
@@ -31,7 +30,6 @@ config SH_ETH
 
 config RAVB
 	tristate "Renesas Ethernet AVB support"
-	depends on HAS_DMA
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select CRC32
 	select MII
diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
index 9d99eb42d9176f0f..6acba67bca07abd7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
@@ -60,7 +60,6 @@ config BRCMFMAC_PCIE
 	bool "PCIE bus interface support for FullMAC driver"
 	depends on BRCMFMAC
 	depends on PCI
-	depends on HAS_DMA
 	select BRCMFMAC_PROTO_MSGBUF
 	select FW_LOADER
 	---help---
diff --git a/drivers/net/wireless/quantenna/qtnfmac/Kconfig b/drivers/net/wireless/quantenna/qtnfmac/Kconfig
index 025fa6018550895a..8d1492a90bd135c0 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/Kconfig
+++ b/drivers/net/wireless/quantenna/qtnfmac/Kconfig
@@ -7,7 +7,7 @@ config QTNFMAC
 config QTNFMAC_PEARL_PCIE
 	tristate "Quantenna QSR10g PCIe support"
 	default n
-	depends on HAS_DMA && PCI && CFG80211
+	depends on PCI && CFG80211
 	select QTNFMAC
 	select FW_LOADER
 	select CRC32
-- 
2.17.1

