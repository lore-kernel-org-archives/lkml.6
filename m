Return-Path: <jonathanh@nvidia.com>
X-Google-Smtp-Source: AB8JxZoWRV6FtxQ1MuIP5Db+ZHkUKgpg0hyI6SYxLTH93Dt/RHG0na3Yqf8ss9C4/ZBxbp5iDLcN
ARC-Seal: i=1; a=rsa-sha256; t=1526478546; cv=none;
        d=google.com; s=arc-20160816;
        b=SC7dBZ6xrqDF5vUKtXQAkxPy9noPQSK9M692keLjaA1+Jgwgc8w1d2T40fDpULvCfT
         1UdwdVRu3Ab15hvm/0gr9ZJ3Et4jfBqnHBHqHgg0mCwXAfDCGLsqtGWzjyFqnTWm/3KR
         aTwNvKYJ859Tq4XwWPICjcV6uOsEEvBfZO17dB4sCUKngpOELG8GPOYXbtlx/EaFqhIp
         JMFXV6//rxX9LhX1dMDjfx4cV0oaIIpnsDKFaTZSAocR2c6b8fIjW44NyuMWJTarfvXG
         r/h3HIhdFC/SdPT+n8DdOvXIjXXhcSQEadyyLNCY1DY62AnTTGk3S3HlS+5PCe0txtR/
         5/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=OHFx5hX/RUCKr+1irjylNXLAGCVY6TXHSs7cTwNsX+M=;
        b=fSpG1wVZDdEeYrks/t6DM0cnG9zzoRufmkEQmRsUGR7OaR+K0lUwgIxmfgjbEUGGip
         QeX7quMJzMWqE70aAENzj5wSXU3Jp4L4G7biGADOjQb0xB4hcqa5wy1yqiKddUzk1zk+
         RcEw0ljb68P/xImTVau/nBafPqN29wyr4RqKAjueK4lqk7yGk6b+5rLjtc82or2JCmAr
         sbBtrxPHeKYG21C8gJciBzzanWXp3USxNJuwbOafg8qjh6aUSHbSMetl0wCZkEDluZ7Y
         bQn5FP0taqsgYoLAy0+U3XijX/BPdHLu2F7pgAcG50ZmS1WRMnM/mzCrsehvXBm6+Udm
         yTkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Wed, 16 May 2018 06:49:05 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 1/3] usb: xhci: tegra: Prepare for adding runtime PM support
Date: Wed, 16 May 2018 14:48:53 +0100
Message-ID: <1526478535-23760-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600628768824002131?=
X-GMAIL-MSGID: =?utf-8?q?1600628768824002131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When adding runtime PM support to the Tegra XHCI driver, it is desirable
to move the function calls to enable the clocks, regulators and PHY from
the tegra_xusb_probe into the runtime PM handlers. Currently, the
clocks, regulators and PHY are all enabled before we call
usb_create_hcd() in tegra_xusb_probe(), however, we cannot call
pm_runtime_get_sync() at this point because the platform device data is
not yet initialised. Fortunately, the function usb_create_hcd() can be
called before we enable the clocks, regulators and PHY and so prepare
for adding runtime PM support, by moving the call to usb_create_hcd()
before we enable the hardware.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---

Changes since V2:
- Add Thierry's ACK

Changes since V1:
- None

 drivers/usb/host/xhci-tegra.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 2c076ea80522..02b0b24faa58 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1054,10 +1054,23 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		}
 	}
 
+	tegra->hcd = usb_create_hcd(&tegra_xhci_hc_driver, &pdev->dev,
+				    dev_name(&pdev->dev));
+	if (!tegra->hcd) {
+		err = -ENOMEM;
+		goto put_padctl;
+	}
+
+	/*
+	 * This must happen after usb_create_hcd(), because usb_create_hcd()
+	 * will overwrite the drvdata of the device with the hcd it creates.
+	 */
+	platform_set_drvdata(pdev, tegra);
+
 	err = tegra_xusb_clk_enable(tegra);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable clocks: %d\n", err);
-		goto put_padctl;
+		goto put_usb2;
 	}
 
 	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
@@ -1080,19 +1093,6 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto disable_phy;
 	}
 
-	tegra->hcd = usb_create_hcd(&tegra_xhci_hc_driver, &pdev->dev,
-				    dev_name(&pdev->dev));
-	if (!tegra->hcd) {
-		err = -ENOMEM;
-		goto disable_phy;
-	}
-
-	/*
-	 * This must happen after usb_create_hcd(), because usb_create_hcd()
-	 * will overwrite the drvdata of the device with the hcd it creates.
-	 */
-	platform_set_drvdata(pdev, tegra);
-
 	tegra->hcd->regs = tegra->regs;
 	tegra->hcd->rsrc_start = regs->start;
 	tegra->hcd->rsrc_len = resource_size(regs);
@@ -1100,7 +1100,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	err = usb_add_hcd(tegra->hcd, tegra->xhci_irq, IRQF_SHARED);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to add USB HCD: %d\n", err);
-		goto put_usb2;
+		goto disable_phy;
 	}
 
 	device_wakeup_enable(tegra->hcd->self.controller);
@@ -1155,14 +1155,14 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	usb_put_hcd(xhci->shared_hcd);
 remove_usb2:
 	usb_remove_hcd(tegra->hcd);
-put_usb2:
-	usb_put_hcd(tegra->hcd);
 disable_phy:
 	tegra_xusb_phy_disable(tegra);
 disable_regulator:
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 disable_clk:
 	tegra_xusb_clk_disable(tegra);
+put_usb2:
+	usb_put_hcd(tegra->hcd);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
 	return err;
-- 
2.7.4
