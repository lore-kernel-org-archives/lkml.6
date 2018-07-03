Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF92DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A9323C60
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A9323C60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGCFhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:37:32 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38776 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbeGCFhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:37:31 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id CB04E1B5FCA;
        Tue,  3 Jul 2018 14:37:29 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w635bSO5001809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Jul 2018 14:37:29 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w635bSGc020062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Jul 2018 14:37:28 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w635bSlG020061;
        Tue, 3 Jul 2018 14:37:28 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     witallwang@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fat: Add FITRIM ioctl for FAT file system
Date:   Tue, 03 Jul 2018 14:37:28 +0900
Message-ID: <87fu10anhj.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wentao Wang <witallwang@gmail.com>

Add FITRIM ioctl for FAT file system

[hirofumi@mail.parknet.co.jp: bug fixes, coding style fixes, add signal check]
Signed-off-by: Wentao Wang <witallwang@gmail.com>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/fat.h    |    1 
 fs/fat/fatent.c |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/file.c   |   33 +++++++++++++++++
 3 files changed, 136 insertions(+)

diff -puN fs/fat/fat.h~fat-fitrim fs/fat/fat.h
--- linux/fs/fat/fat.h~fat-fitrim	2018-06-04 13:55:42.328356395 +0900
+++ linux-hirofumi/fs/fat/fat.h	2018-06-04 13:55:42.331356390 +0900
@@ -357,6 +357,7 @@ extern int fat_alloc_clusters(struct ino
 			      int nr_cluster);
 extern int fat_free_clusters(struct inode *inode, int cluster);
 extern int fat_count_free_clusters(struct super_block *sb);
+extern int fat_trim_fs(struct inode *inode, struct fstrim_range *range);
 
 /* fat/file.c */
 extern long fat_generic_ioctl(struct file *filp, unsigned int cmd,
diff -puN fs/fat/fatent.c~fat-fitrim fs/fat/fatent.c
--- linux/fs/fat/fatent.c~fat-fitrim	2018-06-04 13:55:42.329356393 +0900
+++ linux-hirofumi/fs/fat/fatent.c	2018-06-04 14:00:18.550894746 +0900
@@ -4,6 +4,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/sched/signal.h>
 #include "fat.h"
 
 struct fatent_operations {
@@ -690,3 +691,104 @@ out:
 	unlock_fat(sbi);
 	return err;
 }
+
+static int fat_trim_clusters(struct super_block *sb, u32 clus, u32 nr_clus)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	return sb_issue_discard(sb, fat_clus_to_blknr(sbi, clus),
+				nr_clus * sbi->sec_per_clus, GFP_NOFS, 0);
+}
+
+int fat_trim_fs(struct inode *inode, struct fstrim_range *range)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	const struct fatent_operations *ops = sbi->fatent_ops;
+	struct fat_entry fatent;
+	u64 ent_start, ent_end, minlen;
+	u32 free = 0, trimmed = 0;
+	unsigned long reada_blocks, reada_mask, cur_block = 0;
+	int err = 0;
+
+	/*
+	 * FAT data is organized as clusters, trim at the granulary of cluster.
+	 *
+	 * fstrim_range is in byte, convert vaules to cluster index.
+	 * Treat sectors before data region as all used, not to trim them.
+	 */
+	ent_start = max_t(u64, range->start>>sbi->cluster_bits, FAT_START_ENT);
+	ent_end = ent_start + (range->len >> sbi->cluster_bits) - 1;
+	minlen = range->minlen >> sbi->cluster_bits;
+
+	if (ent_start >= sbi->max_cluster || range->len < sbi->cluster_size)
+		return -EINVAL;
+	if (ent_end >= sbi->max_cluster)
+		ent_end = sbi->max_cluster - 1;
+
+	reada_blocks = FAT_READA_SIZE >> sb->s_blocksize_bits;
+	reada_mask = reada_blocks - 1;
+
+	fatent_init(&fatent);
+	lock_fat(sbi);
+	fatent_set_entry(&fatent, ent_start);
+	while (fatent.entry <= ent_end) {
+		/* readahead of fat blocks */
+		if ((cur_block & reada_mask) == 0) {
+			unsigned long rest = sbi->fat_length - cur_block;
+			fat_ent_reada(sb, &fatent, min(reada_blocks, rest));
+		}
+		cur_block++;
+
+		err = fat_ent_read_block(sb, &fatent);
+		if (err)
+			goto error;
+		do {
+			if (ops->ent_get(&fatent) == FAT_ENT_FREE) {
+				free++;
+			} else if (free) {
+				if (free >= minlen) {
+					u32 clus = fatent.entry - free;
+
+					err = fat_trim_clusters(sb, clus, free);
+					if (err && err != -EOPNOTSUPP)
+						goto error;
+					if (!err)
+						trimmed += free;
+					err = 0;
+				}
+				free = 0;
+			}
+		} while (fat_ent_next(sbi, &fatent) && fatent.entry <= ent_end);
+
+		if (fatal_signal_pending(current)) {
+			err = -ERESTARTSYS;
+			goto error;
+		}
+
+		if (need_resched()) {
+			fatent_brelse(&fatent);
+			unlock_fat(sbi);
+			cond_resched();
+			lock_fat(sbi);
+		}
+	}
+	/* handle scenario when tail entries are all free */
+	if (free && free >= minlen) {
+		u32 clus = fatent.entry - free;
+
+		err = fat_trim_clusters(sb, clus, free);
+		if (err && err != -EOPNOTSUPP)
+			goto error;
+		if (!err)
+			trimmed += free;
+		err = 0;
+	}
+
+error:
+	fatent_brelse(&fatent);
+	unlock_fat(sbi);
+
+	range->len = trimmed << sbi->cluster_bits;
+
+	return err;
+}
diff -puN fs/fat/file.c~fat-fitrim fs/fat/file.c
--- linux/fs/fat/file.c~fat-fitrim	2018-06-04 13:55:42.330356392 +0900
+++ linux-hirofumi/fs/fat/file.c	2018-06-04 13:55:42.332356388 +0900
@@ -121,6 +121,37 @@ static int fat_ioctl_get_volume_id(struc
 	return put_user(sbi->vol_id, user_attr);
 }
 
+static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
+{
+	struct super_block *sb = inode->i_sb;
+	struct fstrim_range __user *user_range;
+	struct fstrim_range range;
+	struct request_queue *q = bdev_get_queue(sb->s_bdev);
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
+	user_range = (struct fstrim_range __user *)arg;
+	if (copy_from_user(&range, user_range, sizeof(range)))
+		return -EFAULT;
+
+	range.minlen = max_t(unsigned int, range.minlen,
+			     q->limits.discard_granularity);
+
+	err = fat_trim_fs(inode, &range);
+	if (err < 0)
+		return err;
+
+	if (copy_to_user(user_range, &range, sizeof(range)))
+		return -EFAULT;
+
+	return 0;
+}
+
 long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -133,6 +164,8 @@ long fat_generic_ioctl(struct file *filp
 		return fat_ioctl_set_attributes(filp, user_attr);
 	case FAT_IOCTL_GET_VOLUME_ID:
 		return fat_ioctl_get_volume_id(inode, user_attr);
+	case FITRIM:
+		return fat_ioctl_fitrim(inode, arg);
 	default:
 		return -ENOTTY;	/* Inappropriate ioctl for device */
 	}
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
