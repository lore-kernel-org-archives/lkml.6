Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELscsonvZX8H81E7KSCbaBr5/AqquFXKMXhkkZnpd00tECiOllZF30zn5uVlDrWJj42PfgDx
ARC-Seal: i=1; a=rsa-sha256; t=1519483880; cv=none;
        d=google.com; s=arc-20160816;
        b=AhKAWDjQFnV9C5P6x8SjsPqx5aj15HEnTHU3pKABBX5R6oybllyZLvCbpjNuOisiAj
         +XQgWAZGzAndHfkdWS1LIZV2lkf76HNET4T0gUuYAjqvcxvHSnPKCelzQ4YTs6hBWUCT
         hAuyStjfvrv8vDDOfV7xaitiRvq6GanYzG6qgkmQi87O+T+KTpBw7oeJFFJD/TkEFdY3
         W6IQ4quo8nFOYd5N6RAGdrlOyzlwJjMHtapHduyewIcM7X+39Tda12nCpdWYpGl1zKK0
         wwrcMvVMcJMMFAqS6kCNFUto7UkfdbpwoHufEayoaESOc7OHpIxjOYJVbIvkMaTitZEd
         P34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=duDhTGW9yEQ299QaR4NBGM0K/M7j7JpFAPr8309hn38=;
        b=Co+2cd7Cz3lNYpVgzhpBRFIEId1bll2ld9/15TYCcApgokymap1ZIWoVLHsgdkSxWg
         0wl6kMGf1kmJGMMwRVP6n+r9E+XFQiC+RCEMJkktU6H2f9B+opVZlH0mVoL7tpTQmrSx
         0z4GFrTCxLo5EhePXJEKe1JyaHusL68IbpfyHjp8hpEWO9mMLK5+eaEh/4GFwwO/tQyL
         5x+ezcdsaqGnC/iMo5d2fGGOVY8tyBu+1Z8S//muVUQQ04VnO9Zm8byLAF069Za7gb2P
         AYW+ypiapF+89NyLAfWX/IenYNiDPETBpk6r0UFwDx9gNyt+iYtH92A0jQ77ox2l1MtA
         juPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=MlLVdBHa;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=MlLVdBHa;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w1OEorhv017564
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of 'select MFD_SYSCON'
Date: Sat, 24 Feb 2018 23:50:51 +0900
Message-Id: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593294329790174573?=
X-GMAIL-MSGID: =?utf-8?q?1593294329790174573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
used with care - it forces a lower limit of another symbol, ignoring
the dependency.

MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
select it.

This causes unmet dependencies for architecture without HAS_IOMEM.

  $ make ARCH=score randconfig
  scripts/kconfig/conf  --randconfig Kconfig
  KCONFIG_SEED=0x27C47F43
  warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
  selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)

Use 'depends on' to observe the dependency.

This commit was created by the following command:

  $ find drivers -name 'Kconfig*' | xargs sed -i -e \
    's/select MFD_SYSCON$/depends on MFD_SYSCON/'

Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.

Also, make MFD_SYSCON 'default y' because some defconfig files may
rely on someone select's MFD_SYSCON.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

If you have a better idea to fix 'unmet dependencies',
please suggest.


 drivers/ata/Kconfig                         |  2 +-
 drivers/clk/Kconfig                         |  9 ++++-----
 drivers/clk/imgtec/Kconfig                  |  2 +-
 drivers/clocksource/Kconfig                 |  4 ++--
 drivers/dma/Kconfig                         |  2 +-
 drivers/gpu/drm/exynos/Kconfig              |  2 +-
 drivers/hwspinlock/Kconfig                  |  2 +-
 drivers/input/touchscreen/Kconfig           |  2 +-
 drivers/irqchip/Kconfig                     |  2 +-
 drivers/media/platform/Kconfig              |  2 +-
 drivers/media/platform/exynos4-is/Kconfig   |  2 +-
 drivers/memory/Kconfig                      |  2 +-
 drivers/mfd/Kconfig                         |  5 +++--
 drivers/net/ethernet/hisilicon/Kconfig      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 16 ++++++++--------
 drivers/net/ethernet/ti/Kconfig             |  2 +-
 drivers/pci/dwc/Kconfig                     |  2 +-
 drivers/pci/host/Kconfig                    |  2 +-
 drivers/phy/hisilicon/Kconfig               |  4 ++--
 drivers/phy/ralink/Kconfig                  |  2 +-
 drivers/phy/rockchip/Kconfig                |  2 +-
 drivers/phy/samsung/Kconfig                 |  6 +++---
 drivers/phy/ti/Kconfig                      |  2 +-
 drivers/pinctrl/Kconfig                     |  6 +++---
 drivers/pinctrl/mvebu/Kconfig               |  4 ++--
 drivers/pinctrl/stm32/Kconfig               |  2 +-
 drivers/power/reset/Kconfig                 |  6 +++---
 drivers/remoteproc/Kconfig                  |  4 ++--
 drivers/reset/Kconfig                       |  4 ++--
 drivers/rtc/Kconfig                         |  2 +-
 drivers/soc/qcom/Kconfig                    |  2 +-
 drivers/staging/media/omap4iss/Kconfig      |  2 +-
 drivers/usb/host/Kconfig                    |  2 +-
 drivers/video/fbdev/Kconfig                 |  2 +-
 drivers/watchdog/Kconfig                    |  4 ++--
 35 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a7120d6..e70753c 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -176,7 +176,7 @@ config AHCI_CEVA
 config AHCI_MTK
 	tristate "MediaTek AHCI SATA support"
 	depends on ARCH_MEDIATEK
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  This option enables support for the MediaTek SoC's
 	  onboard AHCI SATA controller.
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 98ce9fc..b4950d8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -136,7 +136,7 @@ config COMMON_CLK_CS2000_CP
 config COMMON_CLK_GEMINI
 	bool "Clock driver for Cortina Systems Gemini SoC"
 	depends on ARCH_GEMINI || COMPILE_TEST
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select RESET_CONTROLLER
 	---help---
 	  This driver supports the SoC clocks on the Cortina Systems Gemini
@@ -146,7 +146,7 @@ config COMMON_CLK_ASPEED
 	bool "Clock driver for Aspeed BMC SoCs"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	default ARCH_ASPEED
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select RESET_CONTROLLER
 	---help---
 	  This driver supports the SoC clocks on the Aspeed BMC platforms.
@@ -193,9 +193,8 @@ config COMMON_CLK_XGENE
 	  Sypport for the APM X-Gene SoC reference, PLL, and device clocks.
 
 config COMMON_CLK_NXP
-	def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
+	def_bool COMMON_CLK && ((ARCH_LPC18XX && MFD_SYSCON) || ARCH_LPC32XX)
 	select REGMAP_MMIO if ARCH_LPC32XX
-	select MFD_SYSCON if ARCH_LPC18XX
 	---help---
 	  Support for clock providers on NXP platforms.
 
@@ -224,7 +223,7 @@ config COMMON_CLK_PIC32
 config COMMON_CLK_OXNAS
 	bool "Clock driver for the OXNAS SoC Family"
 	depends on ARCH_OXNAS || COMPILE_TEST
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	---help---
 	  Support for the OXNAS SoC Family clocks.
 
diff --git a/drivers/clk/imgtec/Kconfig b/drivers/clk/imgtec/Kconfig
index f6dcb74..0034a1f 100644
--- a/drivers/clk/imgtec/Kconfig
+++ b/drivers/clk/imgtec/Kconfig
@@ -1,7 +1,7 @@
 config COMMON_CLK_BOSTON
 	bool "Clock driver for MIPS Boston boards"
 	depends on MIPS || COMPILE_TEST
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	---help---
 	  Enable this to support the system & CPU clocks on the MIPS Boston
 	  development board from Imagination Technologies. These are simple
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b3b4ed9..66c0987 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -61,7 +61,7 @@ config FTTMR010_TIMER
 	depends on HAS_IOMEM
 	select CLKSRC_MMIO
 	select TIMER_OF
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Enables support for the Faraday Technology timer block
 	  FTTMR010.
@@ -387,7 +387,7 @@ config ATMEL_PIT
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
 	select TIMER_OF
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Support for the Atmel ST timer.
 
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 27df3e2..19d89d3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -312,7 +312,7 @@ config LPC18XX_DMAMUX
 	bool "NXP LPC18xx/43xx DMA MUX for PL080"
 	depends on ARCH_LPC18XX || COMPILE_TEST
 	depends on OF && AMBA_PL08X
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Enable support for DMA on NXP LPC18xx/43xx platforms
 	  with PL080 and multiplexed DMA request lines.
diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 735ce47..85fe96a 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -20,7 +20,7 @@ comment "CRTCs"
 config DRM_EXYNOS_FIMD
 	bool "FIMD"
 	depends on !FB_S3C
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Choose this option if you want to use Exynos FIMD for DRM.
 
diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index f0f4679..3393b20 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -19,7 +19,7 @@ config HWSPINLOCK_QCOM
 	tristate "Qualcomm Hardware Spinlock device"
 	depends on HWSPINLOCK
 	depends on ARCH_QCOM
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Say y here to support the Qualcomm Hardware Mutex functionality, which
 	  provides a synchronisation mechanism for the various processors on
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 4f15496..96e5e78 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -987,7 +987,7 @@ config TOUCHSCREEN_TS4800
 	tristate "TS-4800 touchscreen"
 	depends on HAS_IOMEM && OF
 	depends on SOC_IMX51 || COMPILE_TEST
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select INPUT_POLLDEV
 	help
 	  Say Y here if you have a touchscreen on a TS-4800 board.
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d913aec..92cfe72 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -201,7 +201,7 @@ config RENESAS_IRQC
 config ST_IRQCHIP
 	bool
 	select REGMAP
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Enables SysCfg Controlled IRQs on STi based platforms.
 
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 614fbef..8909ee5 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -89,7 +89,7 @@ config VIDEO_OMAP3
 	depends on OMAP_IOMMU
 	select ARM_DMA_USE_IOMMU
 	select VIDEOBUF2_DMA_CONTIG
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select V4L2_FWNODE
 	---help---
 	  Driver for an OMAP 3 camera controller.
diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
index 7b2c49e..cea6f2b 100644
--- a/drivers/media/platform/exynos4-is/Kconfig
+++ b/drivers/media/platform/exynos4-is/Kconfig
@@ -20,7 +20,7 @@ config VIDEO_S5P_FIMC
 	depends on HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select VIDEO_EXYNOS4_IS_COMMON
 	help
 	  This is a V4L2 driver for Samsung S5P and EXYNOS4 SoC camera host
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 19a0e83..924d471 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -29,7 +29,7 @@ config ATMEL_EBI
 	bool "Atmel EBI driver"
 	default y
 	depends on ARCH_AT91 && OF
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select MFD_ATMEL_SMC
 	help
 	  Driver for Atmel EBI controller.
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5..fbbe20a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -123,7 +123,7 @@ config MFD_ATMEL_HLCDC
 
 config MFD_ATMEL_SMC
 	bool
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 
 config MFD_BCM590XX
 	tristate "Broadcom BCM590xx PMUs"
@@ -1206,6 +1206,7 @@ config MFD_SUN6I_PRCM
 config MFD_SYSCON
 	bool "System Controller Register R/W Based on Regmap"
 	select REGMAP_MMIO
+	default y
 	help
 	  Select this option to enable accessing system control registers
 	  via regmap.
@@ -1843,7 +1844,7 @@ config MFD_VEXPRESS_SYSREG
 	select CLKSRC_MMIO
 	select GPIO_GENERIC_PLATFORM
 	select MFD_CORE
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  System Registers are the platform configuration block
 	  on the ARM Ltd. Versatile Express board.
diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 8bcf470..ca9d3e8 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -39,7 +39,7 @@ config HIP04_ETH
 	tristate "HISILICON P04 Ethernet support"
 	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MARVELL_PHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select HNS_MDIO
 	---help---
 	  If you wish to compile a kernel for a hardware with hisilicon p04 SoC and
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index e28c0d2..518c3f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -15,7 +15,7 @@ if STMMAC_ETH
 config STMMAC_PLATFORM
 	tristate "STMMAC Platform bus support"
 	depends on STMMAC_ETH
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	default y
 	---help---
 	  This selects the platform specific bus support for the stmmac driver.
@@ -58,7 +58,7 @@ config DWMAC_IPQ806X
 	tristate "QCA IPQ806x DWMAC support"
 	default ARCH_QCOM
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Support for QCA IPQ806X DWMAC Ethernet.
 
@@ -71,7 +71,7 @@ config DWMAC_LPC18XX
 	tristate "NXP LPC18xx/43xx DWMAC support"
 	default ARCH_LPC18XX
 	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	---help---
 	  Support for NXP LPC18xx/43xx DWMAC Ethernet.
 
@@ -90,7 +90,7 @@ config DWMAC_OXNAS
 	tristate "Oxford Semiconductor OXNAS dwmac support"
 	default ARCH_OXNAS
 	depends on OF && COMMON_CLK && (ARCH_OXNAS || COMPILE_TEST)
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Support for Ethernet controller on Oxford Semiconductor OXNAS SoCs.
 
@@ -101,7 +101,7 @@ config DWMAC_ROCKCHIP
 	tristate "Rockchip dwmac support"
 	default ARCH_ROCKCHIP
 	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Support for Ethernet controller on Rockchip RK3288 SoC.
 
@@ -112,7 +112,7 @@ config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
 	default ARCH_SOCFPGA
 	depends on OF && (ARCH_SOCFPGA || COMPILE_TEST)
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Support for ethernet controller on Altera SOCFPGA
 
@@ -124,7 +124,7 @@ config DWMAC_STI
 	tristate "STi GMAC support"
 	default ARCH_STI
 	depends on OF && (ARCH_STI || COMPILE_TEST)
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	---help---
 	  Support for ethernet controller on STi SOCs.
 
@@ -136,7 +136,7 @@ config DWMAC_STM32
 	tristate "STM32 DWMAC support"
 	default ARCH_STM32
 	depends on OF && HAS_IOMEM && (ARCH_STM32 || COMPILE_TEST)
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	---help---
 	  Support for ethernet controller on STM32 SOCs.
 
diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 48a541e..9acad82 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -65,7 +65,7 @@ config TI_CPSW
 	select TI_DAVINCI_MDIO
 	select TI_CPSW_PHY_SEL
 	select TI_CPSW_ALE
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select REGMAP
 	---help---
 	  This driver supports TI's CPSW Ethernet Switch.
diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 0f666b1..1b13016 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -107,7 +107,7 @@ config PCI_LAYERSCAPE
 	depends on PCI
 	depends on OF && (ARM || ARCH_LAYERSCAPE)
 	depends on PCI_MSI_IRQ_DOMAIN
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index a4ed748..58c94ab 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -182,7 +182,7 @@ config PCIE_ROCKCHIP
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Say Y here if you want internal PCI support on Rockchip SoC.
 	  There is 1 internal PCIe port available to support GEN2 with
diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 6164c4c..4279c17 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -5,7 +5,7 @@ config PHY_HI6220_USB
 	tristate "hi6220 USB PHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
 	select GENERIC_PHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Enable this to support the HISILICON HI6220 USB PHY.
 
@@ -15,6 +15,6 @@ config PHY_HIX5HD2_SATA
 	tristate "HIX5HD2 SATA PHY Driver"
 	depends on ARCH_HIX5HD2 && OF && HAS_IOMEM
 	select GENERIC_PHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
diff --git a/drivers/phy/ralink/Kconfig b/drivers/phy/ralink/Kconfig
index b17635b..dfb01b6 100644
--- a/drivers/phy/ralink/Kconfig
+++ b/drivers/phy/ralink/Kconfig
@@ -5,7 +5,7 @@ config PHY_RALINK_USB
 	tristate "Ralink USB PHY driver"
 	depends on RALINK || COMPILE_TEST
 	select GENERIC_PHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  This option enables support for the Ralink USB PHY found inside
 	  RT3352, MT7620, MT7628 and MT7688.
diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index f5325b2..27c8d71 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -30,7 +30,7 @@ config PHY_ROCKCHIP_PCIE
 	tristate "Rockchip PCIe PHY Driver"
 	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
 	select GENERIC_PHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Enable this to support the Rockchip PCIe PHY.
 
diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index b7e0645..15abc3b 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -33,7 +33,7 @@ config PHY_SAMSUNG_USB2
 	depends on HAS_IOMEM
 	depends on USB_EHCI_EXYNOS || USB_OHCI_EXYNOS || USB_DWC2
 	select GENERIC_PHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	default ARCH_EXYNOS
 	help
 	  Enable this to support the Samsung USB 2.0 PHY driver for Samsung
@@ -72,7 +72,7 @@ config PHY_EXYNOS5_USBDRD
 	depends on HAS_IOMEM
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	default y
 	help
 	  Enable USB DRD PHY support for Exynos 5 SoC series.
@@ -87,7 +87,7 @@ config PHY_EXYNOS5250_SATA
 	select GENERIC_PHY
 	select I2C
 	select I2C_S3C2410
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Enable this to support SATA SerDes/Phy found on Samsung's
 	  Exynos5250 based SoCs.This SerDes/Phy supports SATA 1.5 Gb/s,
diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 2050356..bfa50d1 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -5,7 +5,7 @@ config PHY_DA8XX_USB
 	tristate "TI DA8xx USB PHY Driver"
 	depends on ARCH_DAVINCI_DA8XX
 	select GENERIC_PHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Enable this to support the USB PHY on DA8xx SoCs.
 
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 0f254b3..6bfb4f1 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -168,7 +168,7 @@ config PINCTRL_GEMINI
 	default ARCH_GEMINI
 	select PINMUX
 	select GENERIC_PINCONF
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 
 config PINCTRL_MCP23S08
 	tristate "Microchip MCP23xxx I/O expander"
@@ -194,14 +194,14 @@ config PINCTRL_OXNAS
 	select GPIOLIB
 	select OF_GPIO
 	select GPIOLIB_IRQCHIP
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 
 config PINCTRL_ROCKCHIP
 	bool
 	select PINMUX
 	select GENERIC_PINCONF
 	select GENERIC_IRQ_CHIP
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 
 config PINCTRL_RZA1
 	bool "Renesas RZ/A1 gpio and pinctrl driver"
diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
index d9773b7..6ba5f49 100644
--- a/drivers/pinctrl/mvebu/Kconfig
+++ b/drivers/pinctrl/mvebu/Kconfig
@@ -6,7 +6,7 @@ config PINCTRL_MVEBU
 config PINCTRL_DOVE
 	bool
 	select PINCTRL_MVEBU
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 
 config PINCTRL_KIRKWOOD
 	bool
@@ -47,6 +47,6 @@ config PINCTRL_ORION
 config PINCTRL_ARMADA_37XX
        bool
        select GENERIC_PINCONF
-       select MFD_SYSCON
+       depends on MFD_SYSCON
        select PINCONF
        select PINMUX
diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index 1c4e00b2..6896f7e 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -7,7 +7,7 @@ config PINCTRL_STM32
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select IRQ_DOMAIN_HIERARCHY
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 
 config PINCTRL_STM32F429
 	bool "STMicroelectronics STM32F429 pin control" if COMPILE_TEST && !MACH_STM32F429
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a102e74..8f3b7a6 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -170,7 +170,7 @@ config POWER_RESET_KEYSTONE
 	bool "Keystone reset driver"
 	depends on ARCH_KEYSTONE || COMPILE_TEST
 	depends on HAS_IOMEM
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Reboot support for the KEYSTONE SoCs.
 
@@ -178,7 +178,7 @@ config POWER_RESET_SYSCON
 	bool "Generic SYSCON regmap reset driver"
 	depends on OF
 	depends on HAS_IOMEM
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Reboot support for generic SYSCON mapped register reset.
 
@@ -186,7 +186,7 @@ config POWER_RESET_SYSCON_POWEROFF
 	bool "Generic SYSCON regmap poweroff driver"
 	depends on OF
 	depends on HAS_IOMEM
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Poweroff support for generic SYSCON mapped register poweroff.
 
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index b609e1d..4ef945f 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -90,7 +90,7 @@ config QCOM_ADSP_PIL
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select QCOM_MDT_LOADER
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
@@ -107,7 +107,7 @@ config QCOM_Q6V5_PIL
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7fc7769..e2536dc 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -50,7 +50,7 @@ config RESET_HSDK
 config RESET_IMX7
 	bool "i.MX7 Reset Driver" if COMPILE_TEST
 	default SOC_IMX7D
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
@@ -110,7 +110,7 @@ config RESET_TI_SCI
 config RESET_TI_SYSCON
 	tristate "TI SYSCON Reset Driver"
 	depends on HAS_IOMEM
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  This enables the reset driver support for TI devices with
 	  memory-mapped reset registers as part of a syscon device node. If
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8ab5f0a5..7cc8a6f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1413,7 +1413,7 @@ config RTC_DRV_AT91RM9200
 config RTC_DRV_AT91SAM9
 	tristate "AT91SAM9 RTT as RTC"
 	depends on ARCH_AT91 || COMPILE_TEST
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Some AT91SAM9 SoCs provide an RTT (Real Time Timer) block which
 	  can be used as an RTC thanks to the backup power supply (e.g. a
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e050eb8..c51f50c 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -15,7 +15,7 @@ config QCOM_GLINK_SSR
 config QCOM_GSBI
         tristate "QCOM General Serial Bus Interface"
         depends on ARCH_QCOM
-        select MFD_SYSCON
+        depends on MFD_SYSCON
         help
           Say y here to enable GSBI support.  The GSBI provides control
           functions for connecting the underlying serial UART, SPI, and I2C
diff --git a/drivers/staging/media/omap4iss/Kconfig b/drivers/staging/media/omap4iss/Kconfig
index 4618346..616169e 100644
--- a/drivers/staging/media/omap4iss/Kconfig
+++ b/drivers/staging/media/omap4iss/Kconfig
@@ -2,7 +2,7 @@ config VIDEO_OMAP4
 	tristate "OMAP 4 Camera support"
 	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && I2C && ARCH_OMAP4
 	depends on HAS_DMA
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	select VIDEOBUF2_DMA_CONTIG
 	---help---
 	  Driver for an OMAP 4 ISS controller.
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4fcfb30..b26b124 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -54,7 +54,7 @@ config USB_XHCI_PLATFORM
 
 config USB_XHCI_MTK
 	tristate "xHCI support for MediaTek SoCs"
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	depends on (MIPS && SOC_MT7621) || ARCH_MEDIATEK || COMPILE_TEST
 	---help---
 	  Say 'Y' to enable the support for the xHCI host controller
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 11e699f..88ebc5b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -316,7 +316,7 @@ config PLAT_VERSATILE_CLCD
 	depends on ARM
 	depends on FB_ARMCLCD && FB=y
 	select REGMAP
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 
 config FB_ACORN
 	bool "Acorn VIDC support"
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index aff773b..f0c212f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -374,8 +374,8 @@ config HAVE_S3C2410_WATCHDOG
 config S3C2410_WATCHDOG
 	tristate "S3C2410 Watchdog"
 	depends on HAVE_S3C2410_WATCHDOG || COMPILE_TEST
+	depends on MFD_SYSCON
 	select WATCHDOG_CORE
-	select MFD_SYSCON if ARCH_EXYNOS
 	help
 	  Watchdog timer block in the Samsung SoCs. This will reboot
 	  the system when the timer expires with the watchdog enabled.
@@ -545,7 +545,7 @@ config TS4800_WATCHDOG
 	depends on HAS_IOMEM && OF
 	depends on SOC_IMX51 || COMPILE_TEST
 	select WATCHDOG_CORE
-	select MFD_SYSCON
+	depends on MFD_SYSCON
 	help
 	  Technologic Systems TS-4800 has watchdog timer implemented in
 	  an external FPGA. Say Y here if you want to support for the
-- 
2.7.4
