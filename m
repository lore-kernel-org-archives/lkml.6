Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755131AbeBBSkS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:40:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:10384 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755002AbeBBSj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:39:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="27608623"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/8] parport: PCI core handles power state for us
Date: Fri,  2 Feb 2018 20:39:49 +0200
Message-Id: <20180202183955.85453-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
References: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>

There is no need to repeat the work that is already done in the PCI
driver core. The patch removes excerpts from suspend and resume
callbacks.

Note that there is no more calls performed to enable or disable a PCI
device during suspend-resume cycle. Nowadays they seems to be
superflous. Someone can read more in [1].

While here, convert calls to new driver API.

[1] https://www.kernel.org/doc/ols/2009/ols2009-pages-319-330.pdf

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index eda733c8f6e0..9689503641dc 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -661,57 +661,41 @@ static void parport_serial_pci_remove(struct pci_dev *dev)
 	return;
 }
 
-#ifdef CONFIG_PM
-static int parport_serial_pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused parport_serial_pci_suspend(struct device *dev)
 {
-	struct parport_serial_private *priv = pci_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct parport_serial_private *priv = pci_get_drvdata(pdev);
 
 	if (priv->serial)
 		pciserial_suspend_ports(priv->serial);
 
 	/* FIXME: What about parport? */
-
-	pci_save_state(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
 	return 0;
 }
 
-static int parport_serial_pci_resume(struct pci_dev *dev)
+static int __maybe_unused parport_serial_pci_resume(struct device *dev)
 {
-	struct parport_serial_private *priv = pci_get_drvdata(dev);
-	int err;
-
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-
-	/*
-	 * The device may have been disabled.  Re-enable it.
-	 */
-	err = pci_enable_device(dev);
-	if (err) {
-		printk(KERN_ERR "parport_serial: %s: error enabling "
-			"device for resume (%d)\n", pci_name(dev), err);
-		return err;
-	}
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct parport_serial_private *priv = pci_get_drvdata(pdev);
 
 	if (priv->serial)
 		pciserial_resume_ports(priv->serial);
 
 	/* FIXME: What about parport? */
-
 	return 0;
 }
-#endif
+
+static SIMPLE_DEV_PM_OPS(parport_serial_pm_ops,
+			 parport_serial_pci_suspend, parport_serial_pci_resume);
 
 static struct pci_driver parport_serial_pci_driver = {
 	.name		= "parport_serial",
 	.id_table	= parport_serial_pci_tbl,
 	.probe		= parport_serial_pci_probe,
 	.remove		= parport_serial_pci_remove,
-#ifdef CONFIG_PM
-	.suspend	= parport_serial_pci_suspend,
-	.resume		= parport_serial_pci_resume,
-#endif
+	.driver         = {
+		.pm     = &parport_serial_pm_ops,
+	},
 };
 
 
-- 
2.15.1
