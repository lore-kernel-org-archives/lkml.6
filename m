Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755157AbeBBSk1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:40:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:63572 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755004AbeBBSj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:39:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="14589453"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/8] parport: Don't shadow error codes in ->probe()
Date: Fri,  2 Feb 2018 20:39:51 +0200
Message-Id: <20180202183955.85453-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
References: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ->probe() calls helper functions return theirs error codes
instead of shadowing them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index ac72ad1cabf5..7cf847e6e660 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -536,12 +536,10 @@ static int serial_register(struct pci_dev *dev, const struct pci_device_id *id)
 	struct serial_private *serial;
 
 	board = &pci_parport_serial_boards[id->driver_data];
-
 	if (board->num_ports == 0)
 		return 0;
 
 	serial = pciserial_init_ports(dev, board);
-
 	if (IS_ERR(serial))
 		return PTR_ERR(serial);
 
@@ -627,14 +625,16 @@ static int parport_serial_pci_probe(struct pci_dev *dev,
 	if (err)
 		return err;
 
-	if (parport_register(dev, id))
-		return -ENODEV;
+	err = parport_register(dev, id);
+	if (err)
+		return err;
 
-	if (serial_register (dev, id)) {
+	err = serial_register(dev, id);
+	if (err) {
 		int i;
 		for (i = 0; i < priv->num_par; i++)
 			parport_pc_unregister_port (priv->port[i]);
-		return -ENODEV;
+		return err;
 	}
 
 	return 0;
-- 
2.15.1
