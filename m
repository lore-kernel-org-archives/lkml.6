Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeBBSk6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:40:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:52245 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755014AbeBBSkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:40:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="24456002"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/8] parport: Convert to use managed functions pcim_* and devm_*
Date: Fri,  2 Feb 2018 20:39:50 +0200
Message-Id: <20180202183955.85453-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
References: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the error handling much more simpler than open-coding everything
and in addition makes the probe function smaller an tidier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 9689503641dc..ac72ad1cabf5 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -617,27 +617,23 @@ static int parport_serial_pci_probe(struct pci_dev *dev,
 	struct parport_serial_private *priv;
 	int err;
 
-	priv = kzalloc (sizeof *priv, GFP_KERNEL);
+	priv = devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+
 	pci_set_drvdata (dev, priv);
 
-	err = pci_enable_device (dev);
-	if (err) {
-		kfree (priv);
+	err = pcim_enable_device(dev);
+	if (err)
 		return err;
-	}
 
-	if (parport_register (dev, id)) {
-		kfree (priv);
+	if (parport_register(dev, id))
 		return -ENODEV;
-	}
 
 	if (serial_register (dev, id)) {
 		int i;
 		for (i = 0; i < priv->num_par; i++)
 			parport_pc_unregister_port (priv->port[i]);
-		kfree (priv);
 		return -ENODEV;
 	}
 
@@ -657,7 +653,6 @@ static void parport_serial_pci_remove(struct pci_dev *dev)
 	for (i = 0; i < priv->num_par; i++)
 		parport_pc_unregister_port (priv->port[i]);
 
-	kfree (priv);
 	return;
 }
 
-- 
2.15.1
