Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeCFLUf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:20:35 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:28608 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeCFLUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:20:34 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w26BIwS8011970
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, John Crispin <john@phrozen.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>
Subject: [PATCH] phy: add 'depends on HAS_IOMEM' to fix unmet dependency
Date: Tue,  6 Mar 2018 20:18:49 +0900
Message-Id: <1520335129-11101-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These configs select MFD_SYSCON, but do not depend on HAS_IOMEM.

Compile testing on architecture without HAS_IOMEM causes "unmet
direct dependencies" in Kconfig phase.

Detected by "make ARCH=score allyesconfig".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Arnd Bergmann and I discussed how to fix unmet dependency of MFD_SYSCON.
https://lkml.org/lkml/2018/2/27/284

We agreed to add 'depends on HAS_IOMEM' to drivers causing
unmet dependency.


 drivers/phy/hisilicon/Kconfig | 1 +
 drivers/phy/ralink/Kconfig    | 1 +
 drivers/phy/rockchip/Kconfig  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 6164c4c..1131ba6 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -4,6 +4,7 @@
 config PHY_HI6220_USB
 	tristate "hi6220 USB PHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
diff --git a/drivers/phy/ralink/Kconfig b/drivers/phy/ralink/Kconfig
index b17635b..14fd219 100644
--- a/drivers/phy/ralink/Kconfig
+++ b/drivers/phy/ralink/Kconfig
@@ -4,6 +4,7 @@
 config PHY_RALINK_USB
 	tristate "Ralink USB PHY driver"
 	depends on RALINK || COMPILE_TEST
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index f5325b2..0e15119 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -29,6 +29,7 @@ config PHY_ROCKCHIP_INNO_USB2
 config PHY_ROCKCHIP_PCIE
 	tristate "Rockchip PCIe PHY Driver"
 	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
-- 
2.7.4
