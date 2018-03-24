Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeCXQco (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 12:32:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34755 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbeCXQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 12:32:42 -0400
X-Google-Smtp-Source: AG47ELuduwt4YxjDQvPBNEqeuHtUPcO4a64NNZLRDRzJ+WYP7lXf9t14m4MlTB+c+DqrZXtdro8hHA==
Date: Sat, 24 Mar 2018 22:01:45 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: chips: Replace printk() with pr_*()
Message-ID: <20180324163145.GA472@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: y
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using pr_<loglevel>() is more concise than printk(KERN_<LOGLEVEL>).
This patch:
* Replace printks having a log level with the appropriate
pr_*() macros.
* Indent the code where possible.
* Remove periods from messages.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes:
Before printk() is changes to dev_*macro(), but it was not good idea
because mtd->dev is only initialized after mtd_device_register() is called.

 drivers/mtd/chips/cfi_cmdset_0001.c | 130 +++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 62 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 5e1b68c..3313dbb 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -182,7 +182,7 @@ static void fixup_convert_atmel_pri(struct mtd_info *mtd)
 	memcpy(&atmel_pri, extp, sizeof(atmel_pri));
 	memset((char *)extp + 5, 0, sizeof(*extp) - 5);
 
-	printk(KERN_ERR "atmel Features: %02x\n", atmel_pri.Features);
+	pr_err("atmel Features: %02x\n", atmel_pri.Features);
 
 	if (atmel_pri.Features & 0x01) /* chip erase supported */
 		features |= (1<<0);
@@ -224,8 +224,7 @@ static void fixup_intel_strataflash(struct mtd_info *mtd)
 	struct cfi_private *cfi = map->fldrv_priv;
 	struct cfi_pri_intelext *extp = cfi->cmdset_priv;
 
-	printk(KERN_WARNING "cfi_cmdset_0001: Suspend "
-	                    "erase on write disabled.\n");
+	pr_warn("cfi_cmdset_0001: Suspend erase on write disabled\n");
 	extp->SuspendCmdSupport &= ~1;
 }
 #endif
@@ -239,7 +238,7 @@ static void fixup_no_write_suspend(struct mtd_info *mtd)
 
 	if (cfip && (cfip->FeatureSupport&4)) {
 		cfip->FeatureSupport &= ~4;
-		printk(KERN_WARNING "cfi_cmdset_0001: write suspend disabled\n");
+		pr_warn("cfi_cmdset_0001: write suspend disabled\n");
 	}
 }
 #endif
@@ -282,13 +281,13 @@ static void fixup_LH28F640BF(struct mtd_info *mtd)
 	/* Reset the Partition Configuration Register on LH28F640BF
 	 * to a single partition (PCR = 0x000): PCR is embedded into A0-A15. */
 	if (is_LH28F640BF(cfi)) {
-		printk(KERN_INFO "Reset Partition Config. Register: 1 Partition of 4 planes\n");
+		pr_info("Reset Partition Config. Register: 1 Partition of 4 planes\n");
 		map_write(map, CMD(0x60), 0);
 		map_write(map, CMD(0x04), 0);
 
 		/* We have set one single partition thus
 		 * Simultaneous Operations are not allowed */
-		printk(KERN_INFO "cfi_cmdset_0001: Simultaneous Operations disabled\n");
+		pr_info("cfi_cmdset_0001: Simultaneous Operations disabled\n");
 		extp->FeatureSupport &= ~512;
 	}
 }
@@ -307,7 +306,7 @@ static void fixup_use_write_buffers(struct mtd_info *mtd)
 	struct map_info *map = mtd->priv;
 	struct cfi_private *cfi = map->fldrv_priv;
 	if (cfi->cfiq->BufWriteTimeoutTyp) {
-		printk(KERN_INFO "Using buffer write method\n" );
+		pr_info("Using buffer write method\n");
 		mtd->_write = cfi_intelext_write_buffers;
 		mtd->_writev = cfi_intelext_writev;
 	}
@@ -323,7 +322,7 @@ static void fixup_unlock_powerup_lock(struct mtd_info *mtd)
 	struct cfi_pri_intelext *cfip = cfi->cmdset_priv;
 
 	if (cfip->FeatureSupport&32) {
-		printk(KERN_INFO "Using auto-unlock on power-up/resume\n" );
+		pr_info("Using auto-unlock on power-up/resume\n");
 		mtd->flags |= MTD_POWERUP_LOCK;
 	}
 }
@@ -392,9 +391,8 @@ read_pri_intelext(struct map_info *map, __u16 adr)
 
 	if (extp->MajorVersion != '1' ||
 	    (extp->MinorVersion < '0' || extp->MinorVersion > '5')) {
-		printk(KERN_ERR "  Unknown Intel/Sharp Extended Query "
-		       "version %c.%c.\n",  extp->MajorVersion,
-		       extp->MinorVersion);
+		pr_err("Unknown Intel/Sharp Extended Query version %c.%c\n",
+		       extp->MajorVersion, extp->MinorVersion);
 		kfree(extp);
 		return NULL;
 	}
@@ -452,9 +450,8 @@ read_pri_intelext(struct map_info *map, __u16 adr)
 			extp_size = sizeof(*extp) + extra_size;
 			kfree(extp);
 			if (extp_size > 4096) {
-				printk(KERN_ERR
-					"%s: cfi_pri_intelext is too fat\n",
-					__func__);
+				pr_err("%s: cfi_pri_intelext is too fat\n",
+				       __func__);
 				return NULL;
 			}
 			goto again;
@@ -519,7 +516,8 @@ struct mtd_info *cfi_cmdset_0001(struct map_info *map, int primary)
 #endif
 
 		if(extp->SuspendCmdSupport & 1) {
-			printk(KERN_NOTICE "cfi_cmdset_0001: Erase suspend on write enabled\n");
+			pr_notice("%s: Erase suspend on write enabled\n",
+				  __func__);
 		}
 	}
 	else if (cfi->cfi_mode == CFI_MODE_JEDEC) {
@@ -622,15 +620,16 @@ static struct mtd_info *cfi_intelext_setup(struct mtd_info *mtd)
 
 	if (offset != devsize) {
 		/* Argh */
-		printk(KERN_WARNING "Sum of regions (%lx) != total size of set of interleaved chips (%lx)\n", offset, devsize);
+		pr_warn("Sum of regions (%lx) != total size of set of interleaved chips (%lx)\n",
+			offset, devsize);
 		goto setup_err;
 	}
 
 	for (i=0; i<mtd->numeraseregions;i++){
-		printk(KERN_DEBUG "erase region %d: offset=0x%llx,size=0x%x,blocks=%d\n",
-		       i,(unsigned long long)mtd->eraseregions[i].offset,
-		       mtd->eraseregions[i].erasesize,
-		       mtd->eraseregions[i].numblocks);
+		pr_debug("erase region %d: offset=0x%llx,size=0x%x,blocks=%d\n",
+			 i, (unsigned long long)mtd->eraseregions[i].offset,
+			 mtd->eraseregions[i].erasesize,
+			 mtd->eraseregions[i].numblocks);
 	}
 
 #ifdef CONFIG_MTD_OTP
@@ -722,10 +721,10 @@ static int cfi_intelext_partition_fixup(struct mtd_info *mtd,
 			prinfo = (struct cfi_intelext_programming_regioninfo *)&extp->extra[offs];
 			mtd->writesize = cfi->interleave << prinfo->ProgRegShift;
 			mtd->flags &= ~MTD_BIT_WRITEABLE;
-			printk(KERN_DEBUG "%s: program region size/ctrl_valid/ctrl_inval = %d/%d/%d\n",
-			       map->name, mtd->writesize,
-			       cfi->interleave * prinfo->ControlValid,
-			       cfi->interleave * prinfo->ControlInvalid);
+			pr_debug("%s: program region size/ctrl_valid/ctrl_inval = %d/%d/%d\n",
+				 map->name, mtd->writesize,
+				 cfi->interleave * prinfo->ControlValid,
+				 cfi->interleave * prinfo->ControlInvalid);
 		}
 
 		/*
@@ -736,9 +735,8 @@ static int cfi_intelext_partition_fixup(struct mtd_info *mtd,
 		partshift = cfi->chipshift - __ffs(numparts);
 
 		if ((1 << partshift) < mtd->erasesize) {
-			printk( KERN_ERR
-				"%s: bad number of hw partitions (%d)\n",
-				__func__, numparts);
+			pr_err("%s: bad number of hw partitions (%d)\n",
+			       __func__, numparts);
 			return -EINVAL;
 		}
 
@@ -771,10 +769,9 @@ static int cfi_intelext_partition_fixup(struct mtd_info *mtd,
 			}
 		}
 
-		printk(KERN_DEBUG "%s: %d set(s) of %d interleaved chips "
-				  "--> %d partitions of %d KiB\n",
-				  map->name, cfi->numchips, cfi->interleave,
-				  newcfi->numchips, 1<<(newcfi->chipshift-10));
+		pr_debug("%s: %d set(s) of %d interleaved chips --> %d partitions of %d KiB\n",
+			 map->name, cfi->numchips, cfi->interleave,
+			 newcfi->numchips, 1 << (newcfi->chipshift - 10));
 
 		map->fldrv_priv = newcfi;
 		*pcfi = newcfi;
@@ -853,8 +850,8 @@ static int chip_ready (struct map_info *map, struct flchip *chip, unsigned long
 				/* Urgh. Resume and pretend we weren't here.
 				 * Make sure we're in 'read status' mode if it had finished */
 				put_chip(map, chip, adr);
-				printk(KERN_ERR "%s: Chip not ready after erase "
-				       "suspended: status = 0x%lx\n", map->name, status.x[0]);
+				pr_err("%s: Chip not ready after erase suspended: status = 0x%lx\n",
+				       map->name, status.x[0]);
 				return -EIO;
 			}
 
@@ -1057,7 +1054,8 @@ static void put_chip(struct map_info *map, struct flchip *chip, unsigned long ad
 	case FL_JEDEC_QUERY:
 		break;
 	default:
-		printk(KERN_ERR "%s: put_chip() called with oldstate %d!!\n", map->name, chip->oldstate);
+		pr_err("%s: %s() called with oldstate %d!!\n",
+		       map->name, __func__, chip->oldstate);
 	}
 	wake_up(&chip->wq);
 }
@@ -1436,7 +1434,8 @@ static int cfi_intelext_unpoint(struct mtd_info *mtd, loff_t from, size_t len)
 			if(chip->ref_point_counter == 0)
 				chip->state = FL_READY;
 		} else {
-			printk(KERN_ERR "%s: Error: unpoint called on non pointed region\n", map->name);
+			pr_err("%s: Error: unpoint called on non pointed region\n",
+			       map->name);
 			err = -EINVAL;
 		}
 
@@ -1560,7 +1559,7 @@ static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
 				   chip->word_write_time_max);
 	if (ret) {
 		xip_enable(map, chip, adr);
-		printk(KERN_ERR "%s: word write error (status timeout)\n", map->name);
+		pr_err("%s: word write error (status timeout)\n", map->name);
 		goto out;
 	}
 
@@ -1577,10 +1576,12 @@ static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
 		if (chipstatus & 0x02) {
 			ret = -EROFS;
 		} else if (chipstatus & 0x08) {
-			printk(KERN_ERR "%s: word write error (bad VPP)\n", map->name);
+			pr_err("%s: word write error (bad VPP)\n",
+			       map->name);
 			ret = -EIO;
 		} else {
-			printk(KERN_ERR "%s: word write error (status 0x%lx)\n", map->name, chipstatus);
+			pr_err("%s: word write error (status 0x%lx)\n",
+			       map->name, chipstatus);
 			ret = -EINVAL;
 		}
 
@@ -1723,7 +1724,8 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 	status = map_read(map, cmd_adr);
 	if (map_word_bitsset(map, status, CMD(0x30))) {
 		xip_enable(map, chip, cmd_adr);
-		printk(KERN_WARNING "SR.4 or SR.5 bits set in buffer write (status %lx). Clearing.\n", status.x[0]);
+		pr_warn("SR.4 or SR.5 bits set in buffer write (status %lx). Clearing\n",
+			status.x[0]);
 		xip_disable(map, chip, cmd_adr);
 		map_write(map, CMD(0x50), cmd_adr);
 		map_write(map, CMD(0x70), cmd_adr);
@@ -1741,8 +1743,8 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 		map_write(map, CMD(0x50), cmd_adr);
 		map_write(map, CMD(0x70), cmd_adr);
 		xip_enable(map, chip, cmd_adr);
-		printk(KERN_ERR "%s: Chip not ready for buffer write. Xstatus = %lx, status = %lx\n",
-				map->name, Xstatus.x[0], status.x[0]);
+		pr_err("%s: Chip not ready for buffer write. Xstatus = %lx, status = %lx\n",
+		       map->name, Xstatus.x[0], status.x[0]);
 		goto out;
 	}
 
@@ -1806,7 +1808,7 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 		map_write(map, CMD(0x70), cmd_adr);
 		chip->state = FL_STATUS;
 		xip_enable(map, chip, cmd_adr);
-		printk(KERN_ERR "%s: buffer write error (status timeout)\n", map->name);
+		pr_err("%s: buffer write error (status timeout)\n", map->name);
 		goto out;
 	}
 
@@ -1823,10 +1825,11 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 		if (chipstatus & 0x02) {
 			ret = -EROFS;
 		} else if (chipstatus & 0x08) {
-			printk(KERN_ERR "%s: buffer write error (bad VPP)\n", map->name);
+			pr_err("%s: buffer write error (bad VPP)\n", map->name);
 			ret = -EIO;
 		} else {
-			printk(KERN_ERR "%s: buffer write error (status 0x%lx)\n", map->name, chipstatus);
+			pr_err("%s: buffer write error (status 0x%lx)\n",
+			       map->name, chipstatus);
 			ret = -EINVAL;
 		}
 
@@ -1942,7 +1945,7 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 		map_write(map, CMD(0x70), adr);
 		chip->state = FL_STATUS;
 		xip_enable(map, chip, adr);
-		printk(KERN_ERR "%s: block erase error: (status timeout)\n", map->name);
+		pr_err("%s: block erase error: (status timeout)\n", map->name);
 		goto out;
 	}
 
@@ -1961,23 +1964,26 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 		xip_enable(map, chip, adr);
 
 		if ((chipstatus & 0x30) == 0x30) {
-			printk(KERN_ERR "%s: block erase error: (bad command sequence, status 0x%lx)\n", map->name, chipstatus);
+			pr_err("%s: block erase error: (bad command sequence, status 0x%lx)\n",
+			       map->name, chipstatus);
 			ret = -EINVAL;
 		} else if (chipstatus & 0x02) {
 			/* Protection bit set */
 			ret = -EROFS;
 		} else if (chipstatus & 0x8) {
 			/* Voltage */
-			printk(KERN_ERR "%s: block erase error: (bad VPP)\n", map->name);
+			pr_err("%s: block erase error: (bad VPP)\n", map->name);
 			ret = -EIO;
 		} else if (chipstatus & 0x20 && retries--) {
-			printk(KERN_DEBUG "block erase failed at 0x%08lx: status 0x%lx. Retrying...\n", adr, chipstatus);
+			pr_debug("block erase failed at 0x%08lx: status 0x%lx. Retrying...\n",
+				 adr, chipstatus);
 			DISABLE_VPP(map);
 			put_chip(map, chip, adr);
 			mutex_unlock(&chip->mutex);
 			goto retry;
 		} else {
-			printk(KERN_ERR "%s: block erase failed at 0x%08lx (status 0x%lx)\n", map->name, adr, chipstatus);
+			pr_err("%s: block erase failed at 0x%08lx (status 0x%lx)\n",
+			       map->name, adr, chipstatus);
 			ret = -EIO;
 		}
 
@@ -2073,8 +2079,8 @@ static int __xipram do_printlockstatus_oneblock(struct map_info *map,
 						unsigned long adr,
 						int len, void *thunk)
 {
-	printk(KERN_DEBUG "block status register for 0x%08lx is %x\n",
-	       adr, do_getlockstatus_oneblock(map, chip, adr, len, thunk));
+	pr_debug("block status register for 0x%08lx is %x\n",
+		 adr, do_getlockstatus_oneblock(map, chip, adr, len, thunk));
 	return 0;
 }
 #endif
@@ -2131,7 +2137,7 @@ static int __xipram do_xxlock_oneblock(struct map_info *map, struct flchip *chip
 		map_write(map, CMD(0x70), adr);
 		chip->state = FL_STATUS;
 		xip_enable(map, chip, adr);
-		printk(KERN_ERR "%s: block unlock error: (status timeout)\n", map->name);
+		pr_err("%s: block unlock error: (status timeout)\n", map->name);
 		goto out;
 	}
 
@@ -2147,8 +2153,8 @@ static int cfi_intelext_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	int ret;
 
 #ifdef DEBUG_LOCK_BITS
-	printk(KERN_DEBUG "%s: lock status before, ofs=0x%08llx, len=0x%08X\n",
-	       __func__, ofs, len);
+	pr_debug("%s: lock status before, ofs=0x%08llx, len=0x%08X\n",
+		 __func__, ofs, len);
 	cfi_varsize_frob(mtd, do_printlockstatus_oneblock,
 		ofs, len, NULL);
 #endif
@@ -2157,8 +2163,7 @@ static int cfi_intelext_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 		ofs, len, DO_XXLOCK_ONEBLOCK_LOCK);
 
 #ifdef DEBUG_LOCK_BITS
-	printk(KERN_DEBUG "%s: lock status after, ret=%d\n",
-	       __func__, ret);
+	pr_debug("%s: lock status after, ret=%d\n", __func__, ret);
 	cfi_varsize_frob(mtd, do_printlockstatus_oneblock,
 		ofs, len, NULL);
 #endif
@@ -2171,8 +2176,8 @@ static int cfi_intelext_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	int ret;
 
 #ifdef DEBUG_LOCK_BITS
-	printk(KERN_DEBUG "%s: lock status before, ofs=0x%08llx, len=0x%08X\n",
-	       __func__, ofs, len);
+	pr_debug("%s: lock status before, ofs=0x%08llx, len=0x%08X\n",
+		 __func__, ofs, len);
 	cfi_varsize_frob(mtd, do_printlockstatus_oneblock,
 		ofs, len, NULL);
 #endif
@@ -2181,8 +2186,7 @@ static int cfi_intelext_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 					ofs, len, DO_XXLOCK_ONEBLOCK_UNLOCK);
 
 #ifdef DEBUG_LOCK_BITS
-	printk(KERN_DEBUG "%s: lock status after, ret=%d\n",
-	       __func__, ret);
+	pr_debug("%s: lock status after, ret=%d\n", __func__, ret);
 	cfi_varsize_frob(mtd, do_printlockstatus_oneblock,
 		ofs, len, NULL);
 #endif
@@ -2520,7 +2524,8 @@ static int cfi_intelext_suspend(struct mtd_info *mtd)
 				 */
 			} else {
 				/* There seems to be an operation pending. We must wait for it. */
-				printk(KERN_NOTICE "Flash device refused suspend due to pending operation (oldstate %d)\n", chip->oldstate);
+				pr_notice("Flash device refused suspend due to pending operation (oldstate %d)\n",
+					  chip->oldstate);
 				ret = -EAGAIN;
 			}
 			break;
@@ -2529,7 +2534,8 @@ static int cfi_intelext_suspend(struct mtd_info *mtd)
 			   allowed to. Or should we return -EAGAIN, because the upper layers
 			   ought to have already shut down anything which was using the device
 			   anyway? The latter for now. */
-			printk(KERN_NOTICE "Flash device refused suspend due to active operation (state %d)\n", chip->state);
+			pr_notice("Flash device refused suspend due to active operation (state %d)\n",
+				  chip->state);
 			ret = -EAGAIN;
 		case FL_PM_SUSPENDED:
 			break;
-- 
2.7.4
