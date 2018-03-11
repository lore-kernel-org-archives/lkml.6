Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932342AbeCKRXt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 13:23:49 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40184 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932167AbeCKRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 13:23:48 -0400
X-Google-Smtp-Source: AG47ELvmX0Y42TagszWOeEw++EClOh4ME/hJEa4ZljAoGpMQ4X0tZKP+y2p/Cr87FwRi0dzFUWSHcw==
Date: Sun, 11 Mar 2018 22:53:10 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@vanguardiasur.com.ar
Subject: [PATCH] mtd: Replace printk() with more standardize output format.
Message-ID: <20180311172309.GA1964@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk() is the raw way to print output and should be avoided.

For drivers with defined "struct device object", dev_*macro() is
prefer and for "struct netdevice object", netdev_*macro() is prefer over
dev_*macro() to standardize the output format within the subsystem.

If no "struct device object" is defined prefer pr_*macro() over
printk().

This patch Replace printk having a log level with the appropriate output
format according to the order of preference.

Code is indented where possible.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/ftl.c | 111 ++++++++++++++++++++++++++----------------------------
 1 file changed, 53 insertions(+), 58 deletions(-)

diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index 664d206..7db808c 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -177,18 +177,18 @@ static int scan_header(partition_t *part)
     }
 
     if (offset == max_offset) {
-	printk(KERN_NOTICE "ftl_cs: FTL header not found.\n");
+	pr_notice("ftl_cs: FTL header not found.\n");
 	return -ENOENT;
     }
     if (header.BlockSize != 9 ||
 	(header.EraseUnitSize < 10) || (header.EraseUnitSize > 31) ||
 	(header.NumTransferUnits >= le16_to_cpu(header.NumEraseUnits))) {
-	printk(KERN_NOTICE "ftl_cs: FTL header corrupt!\n");
+	pr_notice("ftl_cs: FTL header corrupt!\n");
 	return -1;
     }
     if ((1 << header.EraseUnitSize) != part->mbd.mtd->erasesize) {
-	printk(KERN_NOTICE "ftl: FTL EraseUnitSize %x != MTD erasesize %x\n",
-	       1 << header.EraseUnitSize,part->mbd.mtd->erasesize);
+	pr_notice("ftl: FTL EraseUnitSize %x != MTD erasesize %x\n",
+		  1 << header.EraseUnitSize,part->mbd.mtd->erasesize);
 	return -1;
     }
     part->header = header;
@@ -240,8 +240,8 @@ static int build_maps(partition_t *part)
 	    xvalid++;
 	} else {
 	    if (xtrans == part->header.NumTransferUnits) {
-		printk(KERN_NOTICE "ftl_cs: format error: too many "
-		       "transfer units!\n");
+		pr_notice("ftl_cs: format error: too many "
+			  "transfer units!\n");
 		goto out_XferInfo;
 	    }
 	    if (hdr_ok && (le16_to_cpu(header.LogicalEUN) == 0xffff)) {
@@ -261,8 +261,7 @@ static int build_maps(partition_t *part)
     header = part->header;
     if ((xtrans != header.NumTransferUnits) ||
 	(xvalid+xtrans != le16_to_cpu(header.NumEraseUnits))) {
-	printk(KERN_NOTICE "ftl_cs: format error: erase units "
-	       "don't add up!\n");
+	pr_notice("ftl_cs: format error: erase units don't add up!\n");
 	goto out_XferInfo;
     }
 
@@ -384,8 +383,8 @@ static void ftl_erase_callback(struct erase_info *erase)
 	if (part->XferInfo[i].Offset == erase->addr) break;
 
     if (i == part->header.NumTransferUnits) {
-	printk(KERN_NOTICE "ftl_cs: internal error: "
-	       "erase lookup failed!\n");
+	pr_notice("ftl_cs: internal error: "
+		  "erase lookup failed!\n");
 	return;
     }
 
@@ -394,8 +393,7 @@ static void ftl_erase_callback(struct erase_info *erase)
 	xfer->state = XFER_ERASED;
     else {
 	xfer->state = XFER_FAILED;
-	printk(KERN_NOTICE "ftl_cs: erase failed: state = %d\n",
-	       erase->state);
+	pr_notice("ftl_cs: erase failed: state = %d\n", erase->state);
     }
 
     kfree(erase);
@@ -492,7 +490,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
 	part->bam_index = 0xffff;
 
 	if (ret) {
-	    printk( KERN_WARNING "ftl: Failed to read BAM cache in copy_erase_unit()!\n");
+	    pr_warn("ftl: Failed to read BAM cache in copy_erase_unit()!\n");
 	    return ret;
 	}
     }
@@ -506,7 +504,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
                     (u_char *)&unit);
 
     if (ret) {
-	printk( KERN_WARNING "ftl: Failed to write back to BAM cache in copy_erase_unit()!\n");
+	pr_warn("ftl: Failed to write back to BAM cache in copy_erase_unit()!\n");
 	return ret;
     }
 
@@ -525,7 +523,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
 	    ret = mtd_read(part->mbd.mtd, src, SECTOR_SIZE, &retlen,
                            (u_char *)buf);
 	    if (ret) {
-		printk(KERN_WARNING "ftl: Error reading old xfer unit in copy_erase_unit\n");
+		pr_warn("ftl: Error reading old xfer unit in copy_erase_unit\n");
 		return ret;
             }
 
@@ -533,7 +531,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
 	    ret = mtd_write(part->mbd.mtd, dest, SECTOR_SIZE, &retlen,
                             (u_char *)buf);
 	    if (ret)  {
-		printk(KERN_WARNING "ftl: Error writing new xfer unit in copy_erase_unit\n");
+		pr_warn("ftl: Error writing new xfer unit in copy_erase_unit\n");
 		return ret;
             }
 
@@ -555,7 +553,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
                     &retlen,
                     (u_char *)part->bam_cache);
     if (ret) {
-	printk( KERN_WARNING "ftl: Error writing BAM in copy_erase_unit\n");
+	pr_warn("ftl: Error writing BAM in copy_erase_unit\n");
 	return ret;
     }
 
@@ -565,7 +563,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
                     &retlen, (u_char *)&srcunitswap);
 
     if (ret) {
-	printk(KERN_WARNING "ftl: Error writing new LogicalEUN in copy_erase_unit\n");
+	pr_warn("ftl: Error writing new LogicalEUN in copy_erase_unit\n");
 	return ret;
     }
 
@@ -644,16 +642,16 @@ static int reclaim_block(partition_t *part)
 	if (xfer == 0xffff) {
 	    if (queued) {
 		pr_debug("ftl_cs: waiting for transfer "
-		      "unit to be prepared...\n");
+			 "unit to be prepared...\n");
 		mtd_sync(part->mbd.mtd);
 	    } else {
 		static int ne = 0;
 		if (++ne < 5)
-		    printk(KERN_NOTICE "ftl_cs: reclaim failed: no "
-			   "suitable transfer units!\n");
+		    pr_notice("ftl_cs: reclaim failed: no "
+			      "suitable transfer units!\n");
 		else
 		    pr_debug("ftl_cs: reclaim failed: no "
-			  "suitable transfer units!\n");
+			     "suitable transfer units!\n");
 
 		return -EIO;
 	    }
@@ -679,11 +677,11 @@ static int reclaim_block(partition_t *part)
 	if (best == 0) {
 	    static int ne = 0;
 	    if (++ne < 5)
-		printk(KERN_NOTICE "ftl_cs: reclaim failed: "
-		       "no free blocks!\n");
+		pr_notice("ftl_cs: reclaim failed: "
+			  "no free blocks!\n");
 	    else
 		pr_debug("ftl_cs: reclaim failed: "
-		       "no free blocks!\n");
+			 "no free blocks!\n");
 
 	    return -EIO;
 	}
@@ -692,7 +690,7 @@ static int reclaim_block(partition_t *part)
     if (!ret)
 	erase_xfer(part, xfer);
     else
-	printk(KERN_NOTICE "ftl_cs: copy_erase_unit failed!\n");
+	pr_notice("ftl_cs: copy_erase_unit failed!\n");
     return ret;
 } /* reclaim_block */
 
@@ -710,10 +708,9 @@ static int reclaim_block(partition_t *part)
 static void dump_lists(partition_t *part)
 {
     int i;
-    printk(KERN_DEBUG "ftl_cs: Free total = %d\n", part->FreeTotal);
+    pr_dbg("ftl_cs: Free total = %d\n", part->FreeTotal);
     for (i = 0; i < part->DataUnits; i++)
-	printk(KERN_DEBUG "ftl_cs:   unit %d: %d phys, %d free, "
-	       "%d deleted\n", i,
+	pr_dbg("ftl_cs:   unit %d: %d phys, %d free, %d deleted\n", i,
 	       part->EUNInfo[i].Offset >> part->header.EraseUnitSize,
 	       part->EUNInfo[i].Free, part->EUNInfo[i].Deleted);
 }
@@ -750,7 +747,7 @@ static uint32_t find_free(partition_t *part)
                        (u_char *)(part->bam_cache));
 
 	if (ret) {
-	    printk(KERN_WARNING"ftl: Error reading BAM in find_free\n");
+	    pr_warn("ftl: Error reading BAM in find_free\n");
 	    return 0;
 	}
 	part->bam_index = eun;
@@ -765,7 +762,7 @@ static uint32_t find_free(partition_t *part)
 	if (++ne == 1)
 	    dump_lists(part);
 #endif
-	printk(KERN_NOTICE "ftl_cs: bad free list!\n");
+	pr_notice("ftl_cs: bad free list!\n");
 	return 0;
     }
     pr_debug("ftl_cs: found free block at %d in %d\n", blk, eun);
@@ -791,14 +788,14 @@ static int ftl_read(partition_t *part, caddr_t buffer,
     pr_debug("ftl_cs: ftl_read(0x%p, 0x%lx, %ld)\n",
 	  part, sector, nblocks);
     if (!(part->state & FTL_FORMATTED)) {
-	printk(KERN_NOTICE "ftl_cs: bad partition\n");
+	pr_notice("ftl_cs: bad partition\n");
 	return -EIO;
     }
     bsize = 1 << part->header.EraseUnitSize;
 
     for (i = 0; i < nblocks; i++) {
 	if (((sector+i) * SECTOR_SIZE) >= le32_to_cpu(part->header.FormattedSize)) {
-	    printk(KERN_NOTICE "ftl_cs: bad read offset\n");
+	    pr_notice("ftl_cs: bad read offset\n");
 	    return -EIO;
 	}
 	log_addr = part->VirtualBlockMap[sector+i];
@@ -811,7 +808,7 @@ static int ftl_read(partition_t *part, caddr_t buffer,
                            (u_char *)buffer);
 
 	    if (ret) {
-		printk(KERN_WARNING "Error reading MTD device in ftl_read()\n");
+		pr_warn("Error reading MTD device in ftl_read()\n");
 		return ret;
 	    }
 	}
@@ -849,7 +846,7 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
     ret = mtd_read(part->mbd.mtd, offset, sizeof(uint32_t), &retlen,
                    (u_char *)&old_addr);
     if (ret) {
-	printk(KERN_WARNING"ftl: Error reading old_addr in set_bam_entry: %d\n",ret);
+	pr_warn("ftl: Error reading old_addr in set_bam_entry: %d\n", ret);
 	return ret;
     }
     old_addr = le32_to_cpu(old_addr);
@@ -859,9 +856,9 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
 	(!BLOCK_DELETED(virt_addr) && (old_addr != 0xfffffffe))) {
 	static int ne = 0;
 	if (++ne < 5) {
-	    printk(KERN_NOTICE "ftl_cs: set_bam_entry() inconsistency!\n");
-	    printk(KERN_NOTICE "ftl_cs:   log_addr = 0x%x, old = 0x%x"
-		   ", new = 0x%x\n", log_addr, old_addr, virt_addr);
+	    pr_notice("ftl_cs: set_bam_entry() inconsistency!\n");
+	    pr_notice("ftl_cs:   log_addr = 0x%x, old = 0x%x"
+		      ", new = 0x%x\n", log_addr, old_addr, virt_addr);
 	}
 	return -EIO;
     }
@@ -872,11 +869,9 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
 	if (le32_to_cpu(part->bam_cache[blk]) != old_addr) {
 	    static int ne = 0;
 	    if (++ne < 5) {
-		printk(KERN_NOTICE "ftl_cs: set_bam_entry() "
-		       "inconsistency!\n");
-		printk(KERN_NOTICE "ftl_cs:   log_addr = 0x%x, cache"
-		       " = 0x%x\n",
-		       le32_to_cpu(part->bam_cache[blk]), old_addr);
+		pr_notice("ftl_cs: set_bam_entry() inconsistency!\n");
+		pr_notice("ftl_cs:   log_addr = 0x%x, cache = 0x%x\n",
+			  le32_to_cpu(part->bam_cache[blk]), old_addr);
 	    }
 	    return -EIO;
 	}
@@ -887,9 +882,9 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
                     (u_char *)&le_virt_addr);
 
     if (ret) {
-	printk(KERN_NOTICE "ftl_cs: set_bam_entry() failed!\n");
-	printk(KERN_NOTICE "ftl_cs:   log_addr = 0x%x, new = 0x%x\n",
-	       log_addr, virt_addr);
+	pr_notice("ftl_cs: set_bam_entry() failed!\n");
+	pr_notice("ftl_cs:   log_addr = 0x%x, new = 0x%x\n",
+		  log_addr, virt_addr);
     }
     return ret;
 } /* set_bam_entry */
@@ -905,7 +900,7 @@ static int ftl_write(partition_t *part, caddr_t buffer,
     pr_debug("ftl_cs: ftl_write(0x%p, %ld, %ld)\n",
 	  part, sector, nblocks);
     if (!(part->state & FTL_FORMATTED)) {
-	printk(KERN_NOTICE "ftl_cs: bad partition\n");
+	pr_notice("ftl_cs: bad partition\n");
 	return -EIO;
     }
     /* See if we need to reclaim space, before we start */
@@ -920,7 +915,7 @@ static int ftl_write(partition_t *part, caddr_t buffer,
     virt_addr = sector * SECTOR_SIZE | BLOCK_DATA;
     for (i = 0; i < nblocks; i++) {
 	if (virt_addr >= le32_to_cpu(part->header.FormattedSize)) {
-	    printk(KERN_NOTICE "ftl_cs: bad write offset\n");
+	    pr_notice("ftl_cs: bad write offset\n");
 	    return -EIO;
 	}
 
@@ -929,8 +924,8 @@ static int ftl_write(partition_t *part, caddr_t buffer,
 	if (blk == 0) {
 	    static int ne = 0;
 	    if (++ne < 5)
-		printk(KERN_NOTICE "ftl_cs: internal error: "
-		       "no free blocks!\n");
+		pr_notice("ftl_cs: internal error: "
+			  "no free blocks!\n");
 	    return -ENOSPC;
 	}
 
@@ -946,10 +941,10 @@ static int ftl_write(partition_t *part, caddr_t buffer,
 	ret = mtd_write(part->mbd.mtd, offset, SECTOR_SIZE, &retlen, buffer);
 
 	if (ret) {
-	    printk(KERN_NOTICE "ftl_cs: block write failed!\n");
-	    printk(KERN_NOTICE "ftl_cs:   log_addr = 0x%x, virt_addr"
-		   " = 0x%x, Offset = 0x%zx\n", log_addr, virt_addr,
-		   offset);
+	    pr_notice("ftl_cs: block write failed!\n");
+	    pr_notice("ftl_cs:   log_addr = 0x%x, virt_addr"
+		      " = 0x%x, Offset = 0x%zx\n", log_addr, virt_addr,
+		      offset);
 	    return -EIO;
 	}
 
@@ -1045,8 +1040,8 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	partition = kzalloc(sizeof(partition_t), GFP_KERNEL);
 
 	if (!partition) {
-		printk(KERN_WARNING "No memory to scan for FTL on %s\n",
-		       mtd->name);
+		dev_warn(&mtd->dev, "No memory to scan for FTL on %s\n",
+			 mtd->name);
 		return;
 	}
 
@@ -1057,8 +1052,8 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 
 		partition->state = FTL_FORMATTED;
 #ifdef PCMCIA_DEBUG
-		printk(KERN_INFO "ftl_cs: opening %d KiB FTL partition\n",
-		       le32_to_cpu(partition->header.FormattedSize) >> 10);
+		dev_info(&mtd->dev, "ftl_cs: opening %d KiB FTL partition\n",
+			 le32_to_cpu(partition->header.FormattedSize) >> 10);
 #endif
 		partition->mbd.size = le32_to_cpu(partition->header.FormattedSize) >> 9;
 
-- 
2.7.4
