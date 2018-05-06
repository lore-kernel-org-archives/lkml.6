Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeEFBsG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 21:48:06 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47586 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeEFBsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 21:48:03 -0400
Date: Sun, 06 May 2018 11:47:52 +1000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] nubus: Unconditionally register bus type
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S1751932AbeEFBsG/20180506014807Z+120@vger.kernel.org>

Loading a NuBus driver module on a non-NuBus machine triggers the
BUG_ON(!drv->bus->p) in driver_register() because the bus does not get
registered unless MACH_IS_MAC(). Avoid this by registering the bus
unconditionally using postcore_initcall().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/nubus/bus.c   | 3 ++-
 drivers/nubus/nubus.c | 5 -----
 include/linux/nubus.h | 1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index d306c348c857..27ca9f1a281b 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -63,7 +63,7 @@ static struct device nubus_parent = {
 	.init_name	= "nubus",
 };
 
-int __init nubus_bus_register(void)
+static int __init nubus_bus_register(void)
 {
 	int err;
 
@@ -78,6 +78,7 @@ int __init nubus_bus_register(void)
 	device_unregister(&nubus_parent);
 	return err;
 }
+postcore_initcall(nubus_bus_register);
 
 static void nubus_device_release(struct device *dev)
 {
diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index 4621ff98138c..f6bab483f4cb 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -869,15 +869,10 @@ static void __init nubus_scan_bus(void)
 
 static int __init nubus_init(void)
 {
-	int err;
-
 	if (!MACH_IS_MAC)
 		return 0;
 
 	nubus_proc_init();
-	err = nubus_bus_register();
-	if (err)
-		return err;
 	nubus_scan_bus();
 	return 0;
 }
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index 6e8200215321..f01e7f4bcff8 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -163,7 +163,6 @@ void nubus_seq_write_rsrc_mem(struct seq_file *m,
 unsigned char *nubus_dirptr(const struct nubus_dirent *nd);
 
 /* Declarations relating to driver model objects */
-int nubus_bus_register(void);
 int nubus_device_register(struct nubus_board *board);
 int nubus_driver_register(struct nubus_driver *ndrv);
 void nubus_driver_unregister(struct nubus_driver *ndrv);
-- 
2.16.1
