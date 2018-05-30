Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeE3PME (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:12:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7963 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753660AbeE3PLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:11:51 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 30 May 2018 08:11:55 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] usb: xhci: tegra: Fix runtime PM support
Date: Wed, 30 May 2018 16:11:42 +0100
Message-ID: <1527693102-4711-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix silly mistake when enabling runtime PM support for the Tegra XHCI
driver. If runtime PM was enabled correctly for the XHCI device, then
we should call pm_runtime_get_sync() to enable the device.

Fixes: ee9e5f4c7825 ("usb: xhci: tegra: Add runtime PM support")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index c78fc2942bca..a8c1d073cba0 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1136,7 +1136,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tegra);
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
+	if (pm_runtime_enabled(&pdev->dev))
 		err = pm_runtime_get_sync(&pdev->dev);
 	else
 		err = tegra_xusb_runtime_resume(&pdev->dev);
-- 
2.7.4
