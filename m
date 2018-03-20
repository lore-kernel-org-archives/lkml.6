Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbeCTPc6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:32:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43340 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeCTPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:32:57 -0400
X-Google-Smtp-Source: AG47ELufaWiKhYL1j8P9cnT7DSFqPzT/8ZL5LhlveJGy14hEADEhc6T1WwVqruIYp3T9L9Wm5FL4wQ==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: boris.brezillon@free-electrons.com
Cc: richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        maxime.ripard@free-electrons.com, alexandre.belloni@free-electrons.com,
        rainyfeeling@outlook.com, miquel.raynal@free-electrons.com,
        nicolas.ferre@microchip.com,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH v2 1/2] mtd: maps: Remove print after allocation failure
Date: Tue, 20 Mar 2018 21:01:24 +0530
Message-Id: <1521559885-10523-1-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prints after [k|v][m|z|c]alloc() functions are not needed, because
in case of failure, allocator will print their internal error prints
anyway.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
* Prefered
if (!map) {
	map = kmalloc();
        if (!map)
		err;
}

than

if (!map)
	map = kmalloc();
if (!map)
	err

 drivers/mtd/maps/amd76xrom.c  | 6 ++----
 drivers/mtd/maps/ck804xrom.c  | 8 +++-----
 drivers/mtd/maps/esb2rom.c    | 7 +++----
 drivers/mtd/maps/ichxrom.c    | 6 ++----
 drivers/mtd/maps/sun_uflash.c | 4 +---
 drivers/mtd/maps/vmu-flash.c  | 3 ---
 6 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
index 26de0a1..406a8d3 100644
--- a/drivers/mtd/maps/amd76xrom.c
+++ b/drivers/mtd/maps/amd76xrom.c
@@ -188,10 +188,8 @@ static int amd76xrom_init_one(struct pci_dev *pdev,
 
 		if (!map) {
 			map = kmalloc(sizeof(*map), GFP_KERNEL);
-		}
-		if (!map) {
-			printk(KERN_ERR MOD_NAME ": kmalloc failed");
-			goto out;
+			if (!map)
+				goto out;
 		}
 		memset(map, 0, sizeof(*map));
 		INIT_LIST_HEAD(&map->list);
diff --git a/drivers/mtd/maps/ck804xrom.c b/drivers/mtd/maps/ck804xrom.c
index 584962e..7377623 100644
--- a/drivers/mtd/maps/ck804xrom.c
+++ b/drivers/mtd/maps/ck804xrom.c
@@ -216,12 +216,10 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
 		unsigned long offset;
 		int i;
 
-		if (!map)
-			map = kmalloc(sizeof(*map), GFP_KERNEL);
-
 		if (!map) {
-			printk(KERN_ERR MOD_NAME ": kmalloc failed");
-			goto out;
+			map = kmalloc(sizeof(*map), GFP_KERNEL);
+			if (!map)
+				goto out;
 		}
 		memset(map, 0, sizeof(*map));
 		INIT_LIST_HEAD(&map->list);
diff --git a/drivers/mtd/maps/esb2rom.c b/drivers/mtd/maps/esb2rom.c
index da9f6d7..2c63ecd 100644
--- a/drivers/mtd/maps/esb2rom.c
+++ b/drivers/mtd/maps/esb2rom.c
@@ -276,11 +276,10 @@ static int __init esb2rom_init_one(struct pci_dev *pdev,
 		unsigned long offset;
 		int i;
 
-		if (!map)
-			map = kmalloc(sizeof(*map), GFP_KERNEL);
 		if (!map) {
-			printk(KERN_ERR MOD_NAME ": kmalloc failed");
-			goto out;
+			map = kmalloc(sizeof(*map), GFP_KERNEL);
+			if (!map)
+				goto out;
 		}
 		memset(map, 0, sizeof(*map));
 		INIT_LIST_HEAD(&map->list);
diff --git a/drivers/mtd/maps/ichxrom.c b/drivers/mtd/maps/ichxrom.c
index 1888c5b..cacef9d 100644
--- a/drivers/mtd/maps/ichxrom.c
+++ b/drivers/mtd/maps/ichxrom.c
@@ -212,10 +212,8 @@ static int __init ichxrom_init_one(struct pci_dev *pdev,
 
 		if (!map) {
 			map = kmalloc(sizeof(*map), GFP_KERNEL);
-		}
-		if (!map) {
-			printk(KERN_ERR MOD_NAME ": kmalloc failed");
-			goto out;
+			if (!map)
+				goto out;
 		}
 		memset(map, 0, sizeof(*map));
 		INIT_LIST_HEAD(&map->list);
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 1e73bba..80a253c 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -62,10 +62,8 @@ int uflash_devinit(struct platform_device *op, struct device_node *dp)
 	}
 
 	up = kzalloc(sizeof(struct uflash_dev), GFP_KERNEL);
-	if (!up) {
-		printk(KERN_ERR PFX "Cannot allocate struct uflash_dev\n");
+	if (!up)
 		return -ENOMEM;
-	}
 
 	/* copy defaults and tweak parameters */
 	memcpy(&up->map, &uflash_map_templ, sizeof(uflash_map_templ));
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 6b223cf..a76a5ff 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -130,9 +130,6 @@ static int maple_vmu_read_block(unsigned int num, unsigned char *buf,
 	if (!pcache->buffer) {
 		pcache->buffer = kmalloc(card->blocklen, GFP_KERNEL);
 		if (!pcache->buffer) {
-			dev_err(&mdev->dev, "VMU at (%d, %d) - read fails due"
-				" to lack of memory\n", mdev->port,
-				mdev->unit);
 			error = -ENOMEM;
 			goto outB;
 		}
-- 
2.7.4
