Return-Path: <jonathanh@nvidia.com>
X-Google-Smtp-Source: AB8JxZohyHCN92Lyn8Uuu14bkPHeY6Lqx348/r+E//0bkDRRgpxPm4qbVH4330+PWV7bIJBeEAz4
ARC-Seal: i=1; a=rsa-sha256; t=1526478548; cv=none;
        d=google.com; s=arc-20160816;
        b=H8SiqChlPQGP51QM2GWlv9jDUaINzyyyHQSZIgrOkJyBSKJyw9S23UwUGQoW5rUXw6
         R2/gQ4OSm+ubJm3CGojWQ1uZCNf085GRyxvWm77Jn7OJ/PCVCd+xqTa5kOTsn2PbfoPm
         jRjpyc3hw5TqnaU4/Vsth9F5z9oaLZW/dy9Sij5j7yMeKQrdTJ1Vv1lhrcuLUIAR/Gjx
         Vmt1kQWF0ixvz4Ey9iUt2tP/4rO1Epbr6uECyGatSDVlqnQeMQK+zoy9IK0xxYr6oOuD
         htzaLjMyhkAwTBiPC9VsLkz99SVsriiFmo5837gV4dI7T0yAOZ5A3Y+XmMGtCt06Sx8c
         WVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=S2yFd4KkLlC86TchNBGBu5vJtSuwGhK17o7Ll2nPizc=;
        b=NC1yG0VIsmC3rj559JmnPMzuc/jPHsNSfsk65wL9XXd+QOizh2UgaiDUegeiiDbzoh
         iCt95ODeW+qlNRsUbs0pZLZR3I252Bh9ZqmZpZSAlNskyRn/xcpdC4dwDRydUgSQTBWB
         oA4JVp6zF/yD900M4W0J48BCjZeI+xMJgzMuqQgxsfuyA8v7no7PkkJGDLtlkEWxFFy9
         EpOTudVBpAsm4W/VNQNNFg3I7Lb6WcIa6wUGjhd/nbonfMdROJnN7e0zMPmO61ONM+RZ
         wjyrkTtXrPi0y36dXca/+omLvRz4ZibiSeYDPaxZNOHrBkAEUu3tUEseIz0osOaZKM9b
         K5lA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Wed, 16 May 2018 06:49:07 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 2/3] usb: xhci: tegra: Add runtime PM support
Date: Wed, 16 May 2018 14:48:54 +0100
Message-ID: <1526478535-23760-2-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526478535-23760-1-git-send-email-jonathanh@nvidia.com>
References: <1526478535-23760-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600628770577254966?=
X-GMAIL-MSGID: =?utf-8?q?1600628770577254966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add runtime PM support to the Tegra XHCI driver and move the function
calls to enable/disable the clocks, regulators and PHY into the runtime
PM callbacks.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---

Changes since V2:
- Remove extra unnecessary blank line
- Add Thierry's ACK

Changes since V1:
- None

 drivers/usb/host/xhci-tegra.c | 88 ++++++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 02b0b24faa58..437e08010587 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -18,6 +18,7 @@
 #include <linux/phy/tegra/xusb.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -761,6 +762,49 @@ static void tegra_xusb_phy_disable(struct tegra_xusb *tegra)
 	}
 }
 
+static int tegra_xusb_runtime_suspend(struct device *dev)
+{
+	struct tegra_xusb *tegra = dev_get_drvdata(dev);
+
+	tegra_xusb_phy_disable(tegra);
+	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
+	tegra_xusb_clk_disable(tegra);
+
+	return 0;
+}
+
+static int tegra_xusb_runtime_resume(struct device *dev)
+{
+	struct tegra_xusb *tegra = dev_get_drvdata(dev);
+	int err;
+
+	err = tegra_xusb_clk_enable(tegra);
+	if (err) {
+		dev_err(dev, "failed to enable clocks: %d\n", err);
+		return err;
+	}
+
+	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
+	if (err) {
+		dev_err(dev, "failed to enable regulators: %d\n", err);
+		goto disable_clk;
+	}
+
+	err = tegra_xusb_phy_enable(tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to enable PHYs: %d\n", err);
+		goto disable_regulator;
+	}
+
+	return 0;
+
+disable_regulator:
+	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
+disable_clk:
+	tegra_xusb_clk_disable(tegra);
+	return err;
+}
+
 static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
 {
 	unsigned int code_tag_blocks, code_size_blocks, code_blocks;
@@ -1067,22 +1111,15 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	 */
 	platform_set_drvdata(pdev, tegra);
 
-	err = tegra_xusb_clk_enable(tegra);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable clocks: %d\n", err);
-		goto put_usb2;
-	}
-
-	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable regulators: %d\n", err);
-		goto disable_clk;
-	}
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev))
+		err = pm_runtime_get_sync(&pdev->dev);
+	else
+		err = tegra_xusb_runtime_resume(&pdev->dev);
 
-	err = tegra_xusb_phy_enable(tegra);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable PHYs: %d\n", err);
-		goto disable_regulator;
+		dev_err(&pdev->dev, "failed to enable device: %d\n", err);
+		goto disable_rpm;
 	}
 
 	tegra_xusb_ipfs_config(tegra, regs);
@@ -1090,7 +1127,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	err = tegra_xusb_load_firmware(tegra);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to load firmware: %d\n", err);
-		goto disable_phy;
+		goto put_rpm;
 	}
 
 	tegra->hcd->regs = tegra->regs;
@@ -1100,7 +1137,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	err = usb_add_hcd(tegra->hcd, tegra->xhci_irq, IRQF_SHARED);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to add USB HCD: %d\n", err);
-		goto disable_phy;
+		goto put_rpm;
 	}
 
 	device_wakeup_enable(tegra->hcd->self.controller);
@@ -1155,13 +1192,11 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	usb_put_hcd(xhci->shared_hcd);
 remove_usb2:
 	usb_remove_hcd(tegra->hcd);
-disable_phy:
-	tegra_xusb_phy_disable(tegra);
-disable_regulator:
-	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
-disable_clk:
-	tegra_xusb_clk_disable(tegra);
-put_usb2:
+put_rpm:
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		tegra_xusb_runtime_suspend(&pdev->dev);
+disable_rpm:
+	pm_runtime_disable(&pdev->dev);
 	usb_put_hcd(tegra->hcd);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
@@ -1181,9 +1216,8 @@ static int tegra_xusb_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, tegra->fw.size, tegra->fw.virt,
 			  tegra->fw.phys);
 
-	tegra_xusb_phy_disable(tegra);
-	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
-	tegra_xusb_clk_disable(tegra);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	tegra_xusb_padctl_put(tegra->padctl);
 
@@ -1211,6 +1245,8 @@ static int tegra_xusb_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops tegra_xusb_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra_xusb_runtime_suspend,
+			   tegra_xusb_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_xusb_suspend, tegra_xusb_resume)
 };
 
-- 
2.7.4
