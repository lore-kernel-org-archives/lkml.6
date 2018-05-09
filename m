Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933412AbeEIBEq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:04:46 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59564 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbeEIBEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:04:42 -0400
Date: Wed, 09 May 2018 11:04:48 +1000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2] nubus: Call bus_register unconditionally
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S933412AbeEIBEq/20180509010448Z+1826@vger.kernel.org>

Loading a NuBus driver module on a non-NuBus machine triggers the
BUG_ON(!drv->bus->p) in driver_register(), because bus_register() was
not called, because it is conditional on MACH_IS_MAC.

Fix the crash by calling bus_register() unconditionally. Call it from
a postcore_initcall(), like other busses do.

Hence, the bus type is available for device_register(), which happens
in a subsys initcall, and for driver_register(), which happens in a
device or module initcall.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v1:
- Improved commit log entry.
- The device_register(&nubus_parent) stays in the subsys initcall.
---
 drivers/nubus/bus.c   | 19 +++++++------------
 drivers/nubus/nubus.c |  2 +-
 include/linux/nubus.h |  2 +-
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index d306c348c857..a59b6c4bb5b8 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -63,20 +63,15 @@ static struct device nubus_parent = {
 	.init_name	= "nubus",
 };
 
-int __init nubus_bus_register(void)
+static int __init nubus_bus_register(void)
 {
-	int err;
-
-	err = device_register(&nubus_parent);
-	if (err)
-		return err;
-
-	err = bus_register(&nubus_bus_type);
-	if (!err)
-		return 0;
+	return bus_register(&nubus_bus_type);
+}
+postcore_initcall(nubus_bus_register);
 
-	device_unregister(&nubus_parent);
-	return err;
+int __init nubus_parent_device_register(void)
+{
+	return device_register(&nubus_parent);
 }
 
 static void nubus_device_release(struct device *dev)
diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index 4621ff98138c..bb0d63a44f41 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -875,7 +875,7 @@ static int __init nubus_init(void)
 		return 0;
 
 	nubus_proc_init();
-	err = nubus_bus_register();
+	err = nubus_parent_device_register();
 	if (err)
 		return err;
 	nubus_scan_bus();
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index 6e8200215321..eba50b057f6f 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -163,7 +163,7 @@ void nubus_seq_write_rsrc_mem(struct seq_file *m,
 unsigned char *nubus_dirptr(const struct nubus_dirent *nd);
 
 /* Declarations relating to driver model objects */
-int nubus_bus_register(void);
+int nubus_parent_device_register(void);
 int nubus_device_register(struct nubus_board *board);
 int nubus_driver_register(struct nubus_driver *ndrv);
 void nubus_driver_unregister(struct nubus_driver *ndrv);
-- 
2.16.1
