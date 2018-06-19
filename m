Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43980C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F53205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F53205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966782AbeFSPhE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:37:04 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966503AbeFSPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:37:03 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M0p8p-1gLUMt3vjT-00v4wU; Tue, 19 Jun 2018 17:36:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fat: propagate 64-bit inode timestamps
Date:   Tue, 19 Jun 2018 17:35:58 +0200
Message-Id: <20180619153646.3637529-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:0hN+XNTArUQmlD7jabnqZOFpNxr2NnwbLuTkaDDr5ek8aitiJpH
 wmGCXkHco+kqxU+kclKd/fXUaNZVj/vydTLAN8myWvRaCU7StWAEAiwR4Yd5Kphd7UzuoZB
 dlx60KRjRDFuVVNU/hDnNYqQGEDt1L1ykH/FhtvrjFYeSZFhzOfiqDS2Z+bm9UVR1mNMVIo
 VWYfSPhVajPko+EpQHZNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ReBdBI2u8qg=:cZ+e0eRScbhuIzhKYNf/Q5
 ULUHLMgJgVrDG+H2WRqp1CXfrpwAEdwJweNhSB68LNyoPyYhJCChsF4+QvAMQ86GExTfU4Rna
 TUh+J26ajJYOAnlNUabIqE33FIAMJp+KuOXWmH32qmoqIsEeewmuV+iTB0GWnAMnFndO2OBN9
 IZ1rnfrYzuhB2gcVQzquS3AOYvuUS+20DCipfwCsG2cfBuP6eN27D3XU+e1ZgQ4277ODzTjum
 Q0CEs9v0vpShy9V5EMgTKUBXTftV6U+kGzJGQJGLYWSuZV2akLdvh5zSsLtISajBKt5p/m5vW
 yPcFqZid3c0UmmFM/A5K/qplig63qVGAUZbQWYThcJofh/l5dk7nfaY6MojI0jWY41NlyvUe8
 348cGkh+ns65qj19twHDx6CIjC66U83zSP1CkkFmXCt+bkkUwLQfgZeJUmuXnEwO2zI8aOZu2
 S3ZHfwTZtl6Io56t8NScb5HFqx7l+Iwv08JElhaQaVUqeb0gDYJY8thSy/GRgZhR7O015D9zQ
 u+vEDSsdOo5n3vcgpTt5LP2ZEQe1GqartRtT4isKhx7gXYH0daqoMsU3vqIYKHJhvXcFr54ys
 gi4E2JyYuCdAGdXoYMlkE4tk7pxCvlJJ+a8hC1QZmwFbnbiyPgarR0PH1gpaWVJ22J8YtLyjZ
 kL2/ZjC6dVnz4klh9XkP+NrPy3HqU6uzgrPu5fetqBQBjs9aWTSP2Tb2H7bUNHNr/o1k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we pass down 64-bit timestamps from VFS, we just need to convert
that correctly into on-disk timestamps. To make that work correctly, this
changes the last use of time_to_tm() in the kernel to time64_to_tm(),
which also lets use remove that deprecated interfaces.

Similarly, the time_t use in fat_time_fat2unix() truncates the timestamp
on the way in, which can be avoided by using types that are wide enough
to hold the intermediate values during the conversion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fat/dir.c         |  2 +-
 fs/fat/fat.h         |  6 +++---
 fs/fat/inode.c       | 18 +++++++-----------
 fs/fat/misc.c        | 12 +++++++-----
 fs/fat/namei_msdos.c | 17 ++++++-----------
 fs/fat/namei_vfat.c  | 20 +++++++-------------
 6 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 8e100c3bf72c..7f5f3699fc6c 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1130,7 +1130,7 @@ static int fat_zeroed_cluster(struct inode *dir, sector_t blknr, int nr_used,
 	return err;
 }
 
-int fat_alloc_new_dir(struct inode *dir, struct timespec *ts)
+int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 8fc1093da47d..be012de96f65 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -304,7 +304,7 @@ extern int fat_scan_logstart(struct inode *dir, int i_logstart,
 			     struct fat_slot_info *sinfo);
 extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
 				struct msdos_dir_entry **de);
-extern int fat_alloc_new_dir(struct inode *dir, struct timespec *ts);
+extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
 extern int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			   struct fat_slot_info *sinfo);
 extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
@@ -406,9 +406,9 @@ void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...);
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
 
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 065dc919a0ce..afa0595cb2f7 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -508,8 +508,8 @@ static int fat_validate_dir(struct inode *dir)
 /* doesn't deal with root inode */
 int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
-	struct timespec ts;
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct timespec64 ts;
 	int error;
 
 	MSDOS_I(inode)->i_pos = 0;
@@ -560,13 +560,13 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
 	fat_time_fat2unix(sbi, &ts, de->time, de->date, 0);
-	inode->i_mtime = timespec_to_timespec64(ts);
+	inode->i_mtime = ts;
 	if (sbi->options.isvfat) {
 		fat_time_fat2unix(sbi, &ts, de->ctime,
 				  de->cdate, de->ctime_cs);
-		inode->i_ctime = timespec_to_timespec64(ts);
+		inode->i_ctime = ts;
 		fat_time_fat2unix(sbi, &ts, 0, de->adate, 0);
-		inode->i_atime = timespec_to_timespec64(ts);
+		inode->i_atime = ts;
 	} else
 		inode->i_ctime = inode->i_atime = inode->i_mtime;
 
@@ -835,7 +835,6 @@ static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int __fat_write_inode(struct inode *inode, int wait)
 {
-	struct timespec ts;
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
@@ -873,16 +872,13 @@ static int __fat_write_inode(struct inode *inode, int wait)
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
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index f9bdc1e01c98..2206a6821264 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -180,17 +180,19 @@ int fat_chain_add(struct inode *inode, int new_dclus, int nr_cluster)
 #define IS_LEAP_YEAR(y)	(!((y) & 3) && (y) != YEAR_2100)
 
 /* Linear day numbers of the respective 1sts in non-leap years. */
-static time_t days_in_year[] = {
+static time64_t days_in_year[] = {
 	/* Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec */
 	0,   0,  31,  59,  90, 120, 151, 181, 212, 243, 273, 304, 334, 0, 0, 0,
 };
 
 /* Convert a FAT time/date pair to a UNIX date (seconds since 1 1 70). */
-void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec *ts,
+void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
 		       __le16 __time, __le16 __date, u8 time_cs)
 {
 	u16 time = le16_to_cpu(__time), date = le16_to_cpu(__date);
-	time_t second, day, leap_day, month, year;
+	time64_t second;
+	long day, leap_day, month;
+	long long year;
 
 	year  = date >> 9;
 	month = max(1, (date >> 5) & 0xf);
@@ -224,11 +226,11 @@ void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec *ts,
 }
 
 /* Convert linear UNIX date to a FAT time/date pair. */
-void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec *ts,
+void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
 		       __le16 *time, __le16 *date, u8 *time_cs)
 {
 	struct tm tm;
-	time_to_tm(ts->tv_sec,
+	time64_to_tm(ts->tv_sec,
 		   (sbi->options.tz_set ? sbi->options.time_offset :
 		   -sys_tz.tz_minuteswest) * SECS_PER_MIN, &tm);
 
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 16a832c37d66..efb8c40c9d27 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -225,7 +225,7 @@ static struct dentry *msdos_lookup(struct inode *dir, struct dentry *dentry,
 /***** Creates a directory entry (name is already formatted). */
 static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 			   int is_dir, int is_hid, int cluster,
-			   struct timespec *ts, struct fat_slot_info *sinfo)
+			   struct timespec64 *ts, struct fat_slot_info *sinfo)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
 	struct msdos_dir_entry de;
@@ -250,7 +250,7 @@ static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 	if (err)
 		return err;
 
-	dir->i_ctime = dir->i_mtime = timespec_to_timespec64(*ts);
+	dir->i_ctime = dir->i_mtime = *ts;
 	if (IS_DIRSYNC(dir))
 		(void)fat_sync_inode(dir);
 	else
@@ -267,7 +267,6 @@ static int msdos_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	struct inode *inode = NULL;
 	struct fat_slot_info sinfo;
 	struct timespec64 ts;
-	struct timespec t;
 	unsigned char msdos_name[MSDOS_NAME];
 	int err, is_hid;
 
@@ -286,8 +285,7 @@ static int msdos_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	}
 
 	ts = current_time(dir);
-	t = timespec64_to_timespec(ts);
-	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &t, &sinfo);
+	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &ts, &sinfo);
 	if (err)
 		goto out;
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
@@ -347,7 +345,6 @@ static int msdos_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct inode *inode;
 	unsigned char msdos_name[MSDOS_NAME];
 	struct timespec64 ts;
-	struct timespec t;
 	int err, is_hid, cluster;
 
 	mutex_lock(&MSDOS_SB(sb)->s_lock);
@@ -365,13 +362,12 @@ static int msdos_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
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
@@ -503,9 +499,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
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
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 9a5469120caa..82cd1e69cbdf 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -577,7 +577,7 @@ xlate_to_uni(const unsigned char *name, int len, unsigned char *outname,
 
 static int vfat_build_slots(struct inode *dir, const unsigned char *name,
 			    int len, int is_dir, int cluster,
-			    struct timespec *ts,
+			    struct timespec64 *ts,
 			    struct msdos_dir_slot *slots, int *nr_slots)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
@@ -653,7 +653,7 @@ static int vfat_build_slots(struct inode *dir, const unsigned char *name,
 }
 
 static int vfat_add_entry(struct inode *dir, const struct qstr *qname,
-			  int is_dir, int cluster, struct timespec *ts,
+			  int is_dir, int cluster, struct timespec64 *ts,
 			  struct fat_slot_info *sinfo)
 {
 	struct msdos_dir_slot *slots;
@@ -678,7 +678,7 @@ static int vfat_add_entry(struct inode *dir, const struct qstr *qname,
 		goto cleanup;
 
 	/* update timestamp */
-	dir->i_ctime = dir->i_mtime = dir->i_atime = timespec_to_timespec64(*ts);
+	dir->i_ctime = dir->i_mtime = dir->i_atime = *ts;
 	if (IS_DIRSYNC(dir))
 		(void)fat_sync_inode(dir);
 	else
@@ -762,14 +762,12 @@ static int vfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
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
@@ -853,19 +851,17 @@ static int vfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
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
@@ -904,7 +900,6 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
-	struct timespec t;
 	loff_t new_i_pos;
 	int err, is_dir, update_dotdot, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
@@ -939,9 +934,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
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
-- 
2.9.0

