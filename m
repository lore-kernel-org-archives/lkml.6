Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B07DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966AC2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966AC2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeHMVDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:03:08 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:46420 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbeHMVDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:03:08 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 663F813FD18;
        Tue, 14 Aug 2018 03:19:46 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w7DIJihY015507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Aug 2018 03:19:45 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w7DIJiRR011745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Aug 2018 03:19:44 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w7DIJip5011744;
        Tue, 14 Aug 2018 03:19:44 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fat: Support timespec64 for 2107
Date:   Tue, 14 Aug 2018 03:19:44 +0900
Message-ID: <874lfydt8f.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On disk format of FAT is supporting until the end of 2107 year.
So this uses timespec64 internally without any truncation (until 2107).

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c         |    2 +-
 fs/fat/fat.h         |    6 +++---
 fs/fat/inode.c       |   20 ++++++--------------
 fs/fat/misc.c        |    4 ++--
 fs/fat/namei_msdos.c |   17 ++++++-----------
 fs/fat/namei_vfat.c  |   20 +++++++-------------
 6 files changed, 25 insertions(+), 44 deletions(-)

diff -puN fs/fat/dir.c~fat-timespec64-cleanup fs/fat/dir.c
--- linux/fs/fat/dir.c~fat-timespec64-cleanup	2018-08-14 01:09:15.355075178 +0900
+++ linux-hirofumi/fs/fat/dir.c	2018-08-14 01:38:37.527642880 +0900
@@ -1130,7 +1130,7 @@ error:
 	return err;
 }
 
-int fat_alloc_new_dir(struct inode *dir, struct timespec *ts)
+int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
diff -puN fs/fat/misc.c~fat-timespec64-cleanup fs/fat/misc.c
--- linux/fs/fat/misc.c~fat-timespec64-cleanup	2018-08-14 01:09:15.356075177 +0900
+++ linux-hirofumi/fs/fat/misc.c	2018-08-14 01:38:37.580642805 +0900
@@ -186,7 +186,7 @@ static time_t days_in_year[] = {
 };
 
 /* Convert a FAT time/date pair to a UNIX date (seconds since 1 1 70). */
-void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec *ts,
+void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
 		       __le16 __time, __le16 __date, u8 time_cs)
 {
 	u16 time = le16_to_cpu(__time), date = le16_to_cpu(__date);
@@ -225,7 +225,7 @@ void fat_time_fat2unix(struct msdos_sb_i
 }
 
 /* Convert linear UNIX date to a FAT time/date pair. */
-void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec *ts,
+void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
 		       __le16 *time, __le16 *date, u8 *time_cs)
 {
 	struct tm tm;
diff -puN fs/fat/inode.c~fat-timespec64-cleanup fs/fat/inode.c
--- linux/fs/fat/inode.c~fat-timespec64-cleanup	2018-08-14 01:09:15.357075175 +0900
+++ linux-hirofumi/fs/fat/inode.c	2018-08-14 01:38:37.613642759 +0900
@@ -508,7 +508,6 @@ static int fat_validate_dir(struct inode
 /* doesn't deal with root inode */
 int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
-	struct timespec ts;
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	int error;
 
@@ -559,14 +558,11 @@ int fat_fill_inode(struct inode *inode,
 	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
-	fat_time_fat2unix(sbi, &ts, de->time, de->date, 0);
-	inode->i_mtime = timespec_to_timespec64(ts);
+	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
 	if (sbi->options.isvfat) {
-		fat_time_fat2unix(sbi, &ts, de->ctime,
+		fat_time_fat2unix(sbi, &inode->i_ctime, de->ctime,
 				  de->cdate, de->ctime_cs);
-		inode->i_ctime = timespec_to_timespec64(ts);
-		fat_time_fat2unix(sbi, &ts, 0, de->adate, 0);
-		inode->i_atime = timespec_to_timespec64(ts);
+		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
 	} else
 		inode->i_ctime = inode->i_atime = inode->i_mtime;
 
@@ -843,7 +839,6 @@ static int fat_statfs(struct dentry *den
 
 static int __fat_write_inode(struct inode *inode, int wait)
 {
-	struct timespec ts;
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
@@ -881,16 +876,13 @@ retry:
 		raw_entry->size = cpu_to_le32(inode->i_size);
 	raw_entry->attr = fat_make_attrs(inode);
 	fat_set_start(raw_entry, MSDOS_I(inode)->i_logstart);
-	ts = timespec64_to_timespec(inode->i_mtime);
-	fat_time_unix2fat(sbi, &ts, &raw_entry->time,
+	fat_time_unix2fat(sbi, &inode->i_mtime, &raw_entry->time,
 			  &raw_entry->date, NULL);
 	if (sbi->options.isvfat) {
 		__le16 atime;
-		ts = timespec64_to_timespec(inode->i_ctime);
-		fat_time_unix2fat(sbi, &ts, &raw_entry->ctime,
+		fat_time_unix2fat(sbi, &inode->i_ctime, &raw_entry->ctime,
 				  &raw_entry->cdate, &raw_entry->ctime_cs);
-		ts = timespec64_to_timespec(inode->i_atime);
-		fat_time_unix2fat(sbi, &ts, &atime,
+		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
 				  &raw_entry->adate, NULL);
 	}
 	spin_unlock(&sbi->inode_hash_lock);
diff -puN fs/fat/namei_msdos.c~fat-timespec64-cleanup fs/fat/namei_msdos.c
--- linux/fs/fat/namei_msdos.c~fat-timespec64-cleanup	2018-08-14 01:09:15.358075174 +0900
+++ linux-hirofumi/fs/fat/namei_msdos.c	2018-08-14 01:38:37.528642879 +0900
@@ -225,7 +225,7 @@ static struct dentry *msdos_lookup(struc
 /***** Creates a directory entry (name is already formatted). */
 static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 			   int is_dir, int is_hid, int cluster,
-			   struct timespec *ts, struct fat_slot_info *sinfo)
+			   struct timespec64 *ts, struct fat_slot_info *sinfo)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
 	struct msdos_dir_entry de;
@@ -250,7 +250,7 @@ static int msdos_add_entry(struct inode
 	if (err)
 		return err;
 
-	dir->i_ctime = dir->i_mtime = timespec_to_timespec64(*ts);
+	dir->i_ctime = dir->i_mtime = *ts;
 	if (IS_DIRSYNC(dir))
 		(void)fat_sync_inode(dir);
 	else
@@ -267,7 +267,6 @@ static int msdos_create(struct inode *di
 	struct inode *inode = NULL;
 	struct fat_slot_info sinfo;
 	struct timespec64 ts;
-	struct timespec t;
 	unsigned char msdos_name[MSDOS_NAME];
 	int err, is_hid;
 
@@ -286,8 +285,7 @@ static int msdos_create(struct inode *di
 	}
 
 	ts = current_time(dir);
-	t = timespec64_to_timespec(ts);
-	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &t, &sinfo);
+	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &ts, &sinfo);
 	if (err)
 		goto out;
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
@@ -347,7 +345,6 @@ static int msdos_mkdir(struct inode *dir
 	struct inode *inode;
 	unsigned char msdos_name[MSDOS_NAME];
 	struct timespec64 ts;
-	struct timespec t;
 	int err, is_hid, cluster;
 
 	mutex_lock(&MSDOS_SB(sb)->s_lock);
@@ -365,13 +362,12 @@ static int msdos_mkdir(struct inode *dir
 	}
 
 	ts = current_time(dir);
-	t = timespec64_to_timespec(ts);
-	cluster = fat_alloc_new_dir(dir, &t);
+	cluster = fat_alloc_new_dir(dir, &ts);
 	if (cluster < 0) {
 		err = cluster;
 		goto out;
 	}
-	err = msdos_add_entry(dir, msdos_name, 1, is_hid, cluster, &t, &sinfo);
+	err = msdos_add_entry(dir, msdos_name, 1, is_hid, cluster, &ts, &sinfo);
 	if (err)
 		goto out_free;
 	inc_nlink(dir);
@@ -503,9 +499,8 @@ static int do_msdos_rename(struct inode
 		new_i_pos = MSDOS_I(new_inode)->i_pos;
 		fat_detach(new_inode);
 	} else {
-		struct timespec t = timespec64_to_timespec(ts);
 		err = msdos_add_entry(new_dir, new_name, is_dir, is_hid, 0,
-				      &t, &sinfo);
+				      &ts, &sinfo);
 		if (err)
 			goto out;
 		new_i_pos = sinfo.i_pos;
diff -puN fs/fat/fat.h~fat-timespec64-cleanup fs/fat/fat.h
--- linux/fs/fat/fat.h~fat-timespec64-cleanup	2018-08-14 01:09:15.358075174 +0900
+++ linux-hirofumi/fs/fat/fat.h	2018-08-14 01:38:37.664642686 +0900
@@ -304,7 +304,7 @@ extern int fat_scan_logstart(struct inod
 			     struct fat_slot_info *sinfo);
 extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
 				struct msdos_dir_entry **de);
-extern int fat_alloc_new_dir(struct inode *dir, struct timespec *ts);
+extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
 extern int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			   struct fat_slot_info *sinfo);
 extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
@@ -406,9 +406,9 @@ void fat_msg(struct super_block *sb, con
 	 } while (0)
 extern int fat_clusters_flush(struct super_block *sb);
 extern int fat_chain_add(struct inode *inode, int new_dclus, int nr_cluster);
-extern void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec *ts,
+extern void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
 			      __le16 __time, __le16 __date, u8 time_cs);
-extern void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec *ts,
+extern void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
 			      __le16 *time, __le16 *date, u8 *time_cs);
 extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
 
diff -puN fs/fat/namei_vfat.c~fat-timespec64-cleanup fs/fat/namei_vfat.c
--- linux/fs/fat/namei_vfat.c~fat-timespec64-cleanup	2018-08-14 01:09:15.359075173 +0900
+++ linux-hirofumi/fs/fat/namei_vfat.c	2018-08-14 01:38:57.797614202 +0900
@@ -577,7 +577,7 @@ xlate_to_uni(const unsigned char *name,
 
 static int vfat_build_slots(struct inode *dir, const unsigned char *name,
 			    int len, int is_dir, int cluster,
-			    struct timespec *ts,
+			    struct timespec64 *ts,
 			    struct msdos_dir_slot *slots, int *nr_slots)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
@@ -653,7 +653,7 @@ out_free:
 }
 
 static int vfat_add_entry(struct inode *dir, const struct qstr *qname,
-			  int is_dir, int cluster, struct timespec *ts,
+			  int is_dir, int cluster, struct timespec64 *ts,
 			  struct fat_slot_info *sinfo)
 {
 	struct msdos_dir_slot *slots;
@@ -678,7 +678,7 @@ static int vfat_add_entry(struct inode *
 		goto cleanup;
 
 	/* update timestamp */
-	dir->i_ctime = dir->i_mtime = dir->i_atime = timespec_to_timespec64(*ts);
+	dir->i_ctime = dir->i_mtime = dir->i_atime = *ts;
 	if (IS_DIRSYNC(dir))
 		(void)fat_sync_inode(dir);
 	else
@@ -762,14 +762,12 @@ static int vfat_create(struct inode *dir
 	struct inode *inode;
 	struct fat_slot_info sinfo;
 	struct timespec64 ts;
-	struct timespec t;
 	int err;
 
 	mutex_lock(&MSDOS_SB(sb)->s_lock);
 
 	ts = current_time(dir);
-	t = timespec64_to_timespec(ts);
-	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &t, &sinfo);
+	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
 	if (err)
 		goto out;
 	inode_inc_iversion(dir);
@@ -853,19 +851,17 @@ static int vfat_mkdir(struct inode *dir,
 	struct inode *inode;
 	struct fat_slot_info sinfo;
 	struct timespec64 ts;
-	struct timespec t;
 	int err, cluster;
 
 	mutex_lock(&MSDOS_SB(sb)->s_lock);
 
 	ts = current_time(dir);
-	t = timespec64_to_timespec(ts);
-	cluster = fat_alloc_new_dir(dir, &t);
+	cluster = fat_alloc_new_dir(dir, &ts);
 	if (cluster < 0) {
 		err = cluster;
 		goto out;
 	}
-	err = vfat_add_entry(dir, &dentry->d_name, 1, cluster, &t, &sinfo);
+	err = vfat_add_entry(dir, &dentry->d_name, 1, cluster, &ts, &sinfo);
 	if (err)
 		goto out_free;
 	inode_inc_iversion(dir);
@@ -904,7 +900,6 @@ static int vfat_rename(struct inode *old
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
-	struct timespec t;
 	loff_t new_i_pos;
 	int err, is_dir, update_dotdot, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
@@ -939,9 +934,8 @@ static int vfat_rename(struct inode *old
 		new_i_pos = MSDOS_I(new_inode)->i_pos;
 		fat_detach(new_inode);
 	} else {
-		t = timespec64_to_timespec(ts);
 		err = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir, 0,
-				     &t, &sinfo);
+				     &ts, &sinfo);
 		if (err)
 			goto out;
 		new_i_pos = sinfo.i_pos;
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
