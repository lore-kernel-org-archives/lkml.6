Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbeAaCht (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:37:49 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:33636 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753451AbeAaChF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:37:05 -0500
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hyc.lee@gmail.com
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@lge.com,
        Hyunchul Lee <cheol.lee@lge.com>
Subject: [PATCH v2 1/3] f2fs: support passing down write hints given by users to block layer
Date: Wed, 31 Jan 2018 11:36:57 +0900
Message-Id: <1517366219-22166-2-git-send-email-hyc.lee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
References: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunchul Lee <cheol.lee@lge.com>

Add the 'whint_mode' mount option that controls which write
hints are passed down to block layer. There are "off" and
"user-based" mode. The default mode is "off".

1) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.

2) whint_mode=user-based. F2FS tries to pass down hints given
by users.

User                  F2FS                     Block
----                  ----                     -----
                      META                     WRITE_LIFE_NOT_SET
                      HOT_NODE                 "
                      WARM_NODE                "
                      COLD_NODE                "
ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
extension list        "                        "

-- buffered io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
WRITE_LIFE_NONE       "                        "
WRITE_LIFE_MEDIUM     "                        "
WRITE_LIFE_LONG       "                        "

-- direct io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG

Many thanks to Chao Yu and Jaegeuk Kim for comments to
implement this patch.

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
v2:
 - Set "whint_mode" to off if "active_logs" is two or four
 - Use a local variable to check "whint_mode" instead of sbi->whint_mode
   in f2fs_direct_IO
 - Fix comments about rw_hint_to_seg_type()

 fs/f2fs/data.c    | 28 +++++++++++++++++++++-----
 fs/f2fs/f2fs.h    |  9 +++++++++
 fs/f2fs/segment.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/super.c   | 30 +++++++++++++++++++++++++++-
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6cba74e..726b0ef 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -175,15 +175,22 @@ static bool __same_bdev(struct f2fs_sb_info *sbi,
  */
 static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 				struct writeback_control *wbc,
-				int npages, bool is_read)
+				int npages, bool is_read,
+				enum page_type type, enum temp_type temp)
 {
 	struct bio *bio;
 
 	bio = f2fs_bio_alloc(sbi, npages, true);
 
 	f2fs_target_device(sbi, blk_addr, bio);
-	bio->bi_end_io = is_read ? f2fs_read_end_io : f2fs_write_end_io;
-	bio->bi_private = is_read ? NULL : sbi;
+	if (is_read) {
+		bio->bi_end_io = f2fs_read_end_io;
+		bio->bi_private = NULL;
+	} else {
+		bio->bi_end_io = f2fs_write_end_io;
+		bio->bi_private = sbi;
+		bio->bi_write_hint = io_type_to_rw_hint(sbi, type, temp);
+	}
 	if (wbc)
 		wbc_init_bio(wbc, bio);
 
@@ -382,7 +389,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 
 	/* Allocate a new bio */
 	bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
-				1, is_read_io(fio->op));
+				1, is_read_io(fio->op), fio->type, fio->temp);
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		bio_put(bio);
@@ -445,7 +452,8 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 			goto out_fail;
 		}
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr, fio->io_wbc,
-						BIO_MAX_PAGES, false);
+						BIO_MAX_PAGES, false,
+						fio->type, fio->temp);
 		io->fio = *fio;
 	}
 
@@ -2287,10 +2295,13 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	size_t count = iov_iter_count(iter);
 	loff_t offset = iocb->ki_pos;
 	int rw = iov_iter_rw(iter);
 	int err;
+	enum rw_hint hint;
+	int whint_mode = sbi->whint_mode;
 
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
@@ -2301,11 +2312,18 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
 
+	if (rw == WRITE && whint_mode == WHINT_MODE_OFF) {
+		hint = iocb->ki_hint;
+		iocb->ki_hint = WRITE_LIFE_NOT_SET;
+	}
+
 	down_read(&F2FS_I(inode)->dio_rwsem[rw]);
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
 	up_read(&F2FS_I(inode)->dio_rwsem[rw]);
 
 	if (rw == WRITE) {
+		if (whint_mode == WHINT_MODE_OFF)
+			iocb->ki_hint = hint;
 		if (err > 0) {
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_IO,
 									err);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6300ac5..475637d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1037,6 +1037,11 @@ enum {
 	MAX_TIME,
 };
 
+enum {
+	WHINT_MODE_OFF,		/* not pass down write hints */
+	WHINT_MODE_USER,	/* try to pass down hints given by users */
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1220,6 +1225,8 @@ struct f2fs_sb_info {
 	char *s_qf_names[MAXQUOTAS];
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
+	/* For which write hints are passed down to block layer */
+	int whint_mode;
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -2768,6 +2775,8 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 int __init create_segment_manager_caches(void);
 void destroy_segment_manager_caches(void);
 int rw_hint_to_seg_type(enum rw_hint hint);
+enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi, enum page_type type,
+				enum temp_type temp);
 
 /*
  * checkpoint.c
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b16a8e6..840c8ff 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2455,6 +2455,62 @@ int rw_hint_to_seg_type(enum rw_hint hint)
 	}
 }
 
+/* This returns write hints for each segment type. This hints will be
+ * passed down to block layer. There are mapping tables which depend on
+ * the mount option 'whint_mode'.
+ *
+ * 1) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.
+ *
+ * 2) whint_mode=user-based. F2FS tries to pass down hints given by users.
+ *
+ * User                  F2FS                     Block
+ * ----                  ----                     -----
+ *                       META                     WRITE_LIFE_NOT_SET
+ *                       HOT_NODE                 "
+ *                       WARM_NODE                "
+ *                       COLD_NODE                "
+ * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+ * extension list        "                        "
+ *
+ * -- buffered io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+ * WRITE_LIFE_NONE       "                        "
+ * WRITE_LIFE_MEDIUM     "                        "
+ * WRITE_LIFE_LONG       "                        "
+ *
+ * -- direct io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+ * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+ * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+ * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+ *
+ */
+
+enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+				enum page_type type, enum temp_type temp)
+{
+	if (sbi->whint_mode == WHINT_MODE_USER) {
+		if (type == DATA) {
+			switch (temp) {
+			case COLD:
+				return WRITE_LIFE_EXTREME;
+			case HOT:
+				return WRITE_LIFE_SHORT;
+			default:
+				return WRITE_LIFE_NOT_SET;
+			}
+		} else {
+			return WRITE_LIFE_NOT_SET;
+		}
+	} else {
+		return WRITE_LIFE_NOT_SET;
+	}
+}
+
 static int __get_segment_type_2(struct f2fs_io_info *fio)
 {
 	if (fio->type == DATA)
@@ -2642,6 +2698,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.type = META,
+		.temp = HOT,
 		.op = REQ_OP_WRITE,
 		.op_flags = REQ_SYNC | REQ_META | REQ_PRIO,
 		.old_blkaddr = page->index,
@@ -2690,6 +2747,8 @@ int rewrite_data_page(struct f2fs_io_info *fio)
 	int err;
 
 	fio->new_blkaddr = fio->old_blkaddr;
+	/* i/o temperature is needed for passing down write hints */
+	__get_segment_type(fio);
 	stat_inc_inplace_blocks(fio->sbi);
 
 	err = f2fs_submit_page_bio(fio);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8173ae6..139547d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -129,6 +129,7 @@ enum {
 	Opt_jqfmt_vfsold,
 	Opt_jqfmt_vfsv0,
 	Opt_jqfmt_vfsv1,
+	Opt_whint,
 	Opt_err,
 };
 
@@ -182,6 +183,7 @@ enum {
 	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
+	{Opt_whint, "whint_mode=%s"},
 	{Opt_err, NULL},
 };
 
@@ -679,6 +681,22 @@ static int parse_options(struct super_block *sb, char *options)
 					"quota operations not supported");
 			break;
 #endif
+		case Opt_whint:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (strlen(name) == 10 &&
+					!strncmp(name, "user-based", 10)) {
+				sbi->whint_mode = WHINT_MODE_USER;
+			} else if (strlen(name) == 3 &&
+					!strncmp(name, "off", 3)) {
+				sbi->whint_mode = WHINT_MODE_OFF;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -715,6 +733,12 @@ static int parse_options(struct super_block *sb, char *options)
 			return -EINVAL;
 		}
 	}
+
+	/* Not pass down write hints if the number of active logs is lesser
+	 * than NR_CURSEG_TYPE.
+	 */
+	if (sbi->active_logs != NR_CURSEG_TYPE)
+		sbi->whint_mode = WHINT_MODE_OFF;
 	return 0;
 }
 
@@ -1225,6 +1249,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",prjquota");
 #endif
 	f2fs_show_quota_options(seq, sbi->sb);
+	if (sbi->whint_mode == WHINT_MODE_USER)
+		seq_printf(seq, ",whint_mode=%s", "user-based");
 
 	return 0;
 }
@@ -1234,6 +1260,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	/* init some FS parameters */
 	sbi->active_logs = NR_CURSEG_TYPE;
 	sbi->inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
+	sbi->whint_mode = WHINT_MODE_OFF;
 
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_XATTR);
@@ -1274,6 +1301,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
+	int old_whint_mode = sbi->whint_mode;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	struct f2fs_fault_info ffi = sbi->fault_info;
 #endif
@@ -1373,7 +1401,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
-	if (*flags & SB_RDONLY) {
+	if (*flags & SB_RDONLY || sbi->whint_mode != old_whint_mode) {
 		writeback_inodes_sb(sb, WB_REASON_SYNC);
 		sync_inodes_sb(sb);
 
-- 
1.9.1
