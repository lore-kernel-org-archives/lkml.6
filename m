Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeCOQTM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:19:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeCOQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:19:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: mark PM functions as __maybe_unused
Date: Thu, 15 Mar 2018 17:18:39 +0100
Message-Id: <20180315161901.772729-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:FwSW0MpuubBCFsr8R6uT50AgdYR5VWAITzNF/CN0EhalEH9JX66
 RYBGQSwkDwSQnhzt4vofAW/o20RvfFoFOed0KxRr7jUqYzebCpwD/HP52HXvW5Ihu5suRS2
 BjBq1En9YEDKO+iUVFH5BzzV7KWP3R6r4uy2tFqRl0ttVMeyZ1uRluTE7L0xkvYYuuIbiu0
 Myx2cPDxwKgrT3JZ/8xwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fXrB6xAZBN0=:hL1jTtC84nZfq2c2LzYyh6
 yjbfyNRL46WSO/5FN7yLYLxGuaewviGg1EztzlxxQ5DzPyIaJZBtgq/WoxED9kDkj9iLr6Gx0
 6WtKYmhezhnX5EaGzhSIHiAjPmrOd5kpXBAf0tK/2SdeLME7aLgw0pydeituOPunpn9lpNFKC
 HhswUPXzacui8LTp+D9HOiKZFRZSRHCj6ZGpn29jiaw3q1XLmFxxTJb+ZWugC4PsBSuUqf6tV
 HtcXYNVFLdDgwMf6OxQN1GT4eZ1BcEDTFx2L4CP/9krKiYE1BaAbutE/QudJNP1nl3BQEvEan
 WNKaleJhrZYX3XlTNABxPcy27elip6F1ry65wVvn5tTPdlZqFDffhQpYtF9Mze3GW14h8wght
 LuhC/5Ubqnpyb/9ipnWSOSOnRjxDwdDWfY3l993XjiW92WYSyVlZjkNCvOg3E6kCmtLRdzGsw
 dIKfgF2gXz8ilzQDcFb0V2F0ljr7trq6aGFWEYx1YAE0L1e826aOWmOvSbL3E5YSFv017imy0
 7MhJWDsCKFcs23xUioqKal6HPWtc9+o4Ws5Mo6UQHBG2muBmWWzJ7hxCKoVkW2DQFjegck6wm
 8Upvo6JrgCeOaL3nV+/LwuG523kUvkyhxNWbP4n9f15o9Leu/2to8Hl95lbhtxaoxCj65EaS6
 4zOSdCB5Dm4BB15pWzmZRQr2ls+AYhiSoidg9weYMIus8d3aIXTYWub/4Mys+qHnQQXH/rEFk
 wKyV6xjJSmN/BYvXceW5JHpLeD3WPI7M2bGFDQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new PM support causes a warning when CONFIG_PM is disabled:

drivers/pci/host/pci-tegra.c:2482:12: error: 'tegra_pcie_pm_resume' defined but not used [-Werror=unused-function]
 static int tegra_pcie_pm_resume(struct device *dev)
drivers/pci/host/pci-tegra.c:2463:12: error: 'tegra_pcie_pm_suspend' defined but not used [-Werror=unused-function]
 static int tegra_pcie_pm_suspend(struct device *dev)

Marking the functions as __maybe_unused lets the compiler drop them
silently instead.

Fixes: b90b44154023 ("PCI: tegra: Add power management support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 39c4af9cf055..389e74be846c 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2460,7 +2460,7 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_pcie_pm_suspend(struct device *dev)
+static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 {
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
 	struct tegra_pcie_port *port;
@@ -2479,7 +2479,7 @@ static int tegra_pcie_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_pcie_pm_resume(struct device *dev)
+static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 {
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
 	int err;
-- 
2.9.0
