Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F4AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3762206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdfMUI4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3762206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeI2AA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeI2AA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:00:56 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B118206B7;
        Fri, 28 Sep 2018 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538156166;
        bh=i+hMQrbslWabLizd9DOoUMafHjvQd3LtYRXESOJbG6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdfMUI4zN0l9cl/KUFo850/zkoL73H2iGp2U8M5gSKcJdt9JJrevQGIEOPY6K60/e
         wpTrf/YEW/S7Wa0kQQLLsQ6xtQtxmZbd2WAwuw3fOSOjEyQx45ci5t0OzpfsKoeTO7
         ZXCQBAvqxVYQ66Sx/ZXdmzbfW0fUzFrNhuXanslM=
Date:   Fri, 28 Sep 2018 10:36:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Daniel Rosenberg <drosen@google.com>
Subject: Re: [PATCH v2] f2fs: checkpoint disabling
Message-ID: <20180928173605.GA64391@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180926194014.44029-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926194014.44029-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that, it requires "f2fs: return correct errno in f2fs_gc".

This adds a lightweight non-persistent snapshotting scheme to f2fs.

To use, mount with the option checkpoint=disable, and to return to
normal operation, remount with checkpoint=enable. If the filesystem
is shut down before remounting with checkpoint=enable, it will revert
back to its apparent state when it was first mounted with
checkpoint=disable. This is useful for situations where you wish to be
able to roll back the state of the disk in case of some critical
failure.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v1:
 - fix fsync loop

 Documentation/filesystems/f2fs.txt |   5 ++
 fs/f2fs/checkpoint.c               |  16 ++++
 fs/f2fs/data.c                     |  14 +++-
 fs/f2fs/debug.c                    |   3 +-
 fs/f2fs/f2fs.h                     |  15 +++-
 fs/f2fs/file.c                     |  12 ++-
 fs/f2fs/gc.c                       |   9 ++-
 fs/f2fs/inode.c                    |   6 +-
 fs/f2fs/namei.c                    |  19 +++++
 fs/f2fs/segment.c                  |  75 +++++++++++++++++-
 fs/f2fs/segment.h                  |  15 ++++
 fs/f2fs/super.c                    | 118 ++++++++++++++++++++++++++++-
 include/linux/f2fs_fs.h            |   1 +
 13 files changed, 294 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index bde3e91e5372..e46c2147ddf8 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -212,6 +212,11 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
                        non-atomic files likewise "nobarrier" mount option.
 test_dummy_encryption  Enable dummy encryption, which provides a fake fscrypt
                        context. The fake fscrypt context is used by xfstests.
+checkpoint=%s          Set to "disable" to turn off checkpointing. Set to "enable"
+                       to reenable checkpointing. Is enabled by default. While
+                       disabled, any unmounting or unexpected shutdowns will cause
+                       the filesystem contents to appear as they did when the
+                       filesystem was mounted with that option.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d312d2829d5a..01e0d8f5bbbe 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1214,6 +1214,11 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
 
+	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+		__set_ckpt_flags(ckpt, CP_DISABLED_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_DISABLED_FLAG);
+
 	/* set this flag to activate crc|cp_ver for recovery */
 	__set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
 	__clear_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG);
@@ -1421,6 +1426,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
 	clear_sbi_flag(sbi, SBI_NEED_CP);
+	sbi->unusable_block_count = 0;
 	__set_cp_next_pack(sbi);
 
 	/*
@@ -1445,6 +1451,16 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long long ckpt_ver;
 	int err = 0;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		if (cpc->reason != CP_PAUSE) {
+			if (cpc->reason != CP_UMOUNT)
+				f2fs_msg(sbi->sb, KERN_WARNING,
+					"Wrong disabled checkpoint!");
+			return 0;
+		}
+		f2fs_msg(sbi->sb, KERN_WARNING,
+				"Start checkpoint disabled!");
+	}
 	mutex_lock(&sbi->cp_mutex);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cb3ebcae0398..dc66c1948d8c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -537,7 +537,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	if (fio->in_list)
 		goto next;
 out:
-	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
+	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
+				f2fs_is_checkpoint_ready(sbi))
 		__submit_merged_bio(io);
 	up_write(&io->io_rwsem);
 }
@@ -1695,6 +1696,10 @@ static inline bool check_inplace_update_policy(struct inode *inode,
 			is_inode_flag_set(inode, FI_NEED_IPU))
 		return true;
 
+	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
+		return true;
+
 	return false;
 }
 
@@ -1725,6 +1730,9 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 			return true;
 		if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
 			return true;
+		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
+			return true;
 	}
 	return false;
 }
@@ -2345,6 +2353,10 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	trace_f2fs_write_begin(inode, pos, len, flags);
 
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		goto fail;
+
 	if ((f2fs_is_atomic_file(inode) &&
 			!f2fs_available_free_memory(sbi, INMEM_PAGES)) ||
 			is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST)) {
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index d3c402183e3c..cb9e7679124b 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -267,7 +267,8 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s]=====\n",
 			si->sbi->sb->s_bdev, i++,
 			f2fs_readonly(si->sbi->sb) ? "RO": "RW",
-			f2fs_cp_error(si->sbi) ? "Error": "Good");
+			is_set_ckpt_flags(si->sbi, CP_DISABLED_FLAG) ?
+			"Disabled": (f2fs_cp_error(si->sbi) ? "Error": "Good"));
 		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
 			   si->sit_area_segs, si->nat_area_segs);
 		seq_printf(s, "[SSA: %d] [MAIN: %d",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b32fd9f7da95..89ff070ee95a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -98,6 +98,7 @@ extern char *f2fs_fault_name[FAULT_MAX];
 #define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
 #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
+#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
@@ -176,6 +177,7 @@ enum {
 #define	CP_RECOVERY	0x00000008
 #define	CP_DISCARD	0x00000010
 #define CP_TRIMMED	0x00000020
+#define CP_PAUSE	0x00000040
 
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
@@ -1089,6 +1091,7 @@ enum {
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
 	SBI_IS_RECOVERED,			/* recovered orphan/data */
+	SBI_CP_DISABLED,			/* CP was disabled last mount */
 };
 
 enum {
@@ -1222,6 +1225,9 @@ struct f2fs_sb_info {
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
 
+	/* Additional tracking for no checkpoint mode */
+	block_t unusable_block_count;		/* # of blocks saved by last cp */
+
 	unsigned int nquota_files;		/* # of quota sysfile */
 
 	u32 s_next_generation;			/* for NFS support */
@@ -1729,7 +1735,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, true))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
-
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		avail_user_block_count -= sbi->unusable_block_count;
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		if (diff > *count)
@@ -1936,6 +1943,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, false))
 		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		valid_block_count += sbi->unusable_block_count;
 
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
@@ -2939,6 +2948,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
+void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
 void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
@@ -3469,7 +3479,8 @@ static inline bool f2fs_may_encrypt(struct inode *inode)
 static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
 {
 	return (f2fs_post_read_required(inode) ||
-			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
+			(rw == WRITE && (test_opt(F2FS_I_SB(inode), LFS) ||
+			is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))) ||
 			F2FS_I_SB(inode)->s_ndevs);
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 357422a4c319..d68a1b00e3fd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -211,7 +211,8 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	};
 	unsigned int seq_id = 0;
 
-	if (unlikely(f2fs_readonly(inode->i_sb)))
+	if (unlikely(f2fs_readonly(inode->i_sb) ||
+				is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return 0;
 
 	trace_f2fs_sync_file_enter(inode);
@@ -2158,6 +2159,12 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		f2fs_msg(sbi->sb, KERN_INFO,
+			"Skipping Checkpoint. Checkpoints currently disabled.");
+		return -EINVAL;
+	}
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2529,6 +2536,9 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		return -EINVAL;
+
 	if (copy_from_user(&range, (struct f2fs_flush_device __user *)arg,
 							sizeof(range)))
 		return -EFAULT;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c051dc4ddf1a..5d2fa37472be 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -362,6 +362,10 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 
 		if (sec_usage_check(sbi, secno))
 			goto next;
+		/* Don't touch checkpointed data */
+		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+					get_ckpt_valid_blocks(sbi, segno)))
+			goto next;
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
 			goto next;
 
@@ -1169,7 +1173,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		 * threshold, we can make them free by checkpoint. Then, we
 		 * secure free segments which doesn't need fggc any more.
 		 */
-		if (prefree_segments(sbi)) {
+		if (prefree_segments(sbi) &&
+				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 			ret = f2fs_write_checkpoint(sbi, &cpc);
 			if (ret)
 				goto stop;
@@ -1221,7 +1226,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			segno = NULL_SEGNO;
 			goto gc_more;
 		}
-		if (gc_type == FG_GC)
+		if (gc_type == FG_GC && !is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 			ret = f2fs_write_checkpoint(sbi, &cpc);
 	}
 stop:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 86e7333d60c1..4ee9d6c4b719 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -607,6 +607,9 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
+	if (f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
+
 	/*
 	 * We need to balance fs here to prevent from producing dirty node pages
 	 * during the urgent cleaning time when runing out of free sections.
@@ -688,7 +691,8 @@ void f2fs_evict_inode(struct inode *inode)
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
 
-	if (likely(!is_set_ckpt_flags(sbi, CP_ERROR_FLAG)))
+	if (likely(!is_set_ckpt_flags(sbi, CP_ERROR_FLAG) &&
+				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
 	else
 		f2fs_inode_synced(inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ded185baa9ae..a14632744a6a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -16,6 +16,7 @@
 
 #include "f2fs.h"
 #include "node.h"
+#include "segment.h"
 #include "xattr.h"
 #include "acl.h"
 #include <trace/events/f2fs.h>
@@ -269,6 +270,9 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		return err;
 
 	err = dquot_initialize(dir);
 	if (err)
@@ -315,6 +319,9 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		return err;
 
 	err = fscrypt_prepare_link(old_dentry, dir, dentry);
 	if (err)
@@ -561,6 +568,9 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		return err;
 
 	err = fscrypt_prepare_symlink(dir, symname, len, dir->i_sb->s_blocksize,
 				      &disk_link);
@@ -690,6 +700,9 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		return err;
 
 	err = dquot_initialize(dir);
 	if (err)
@@ -824,6 +837,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		return err;
 
 	if (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			(!projid_eq(F2FS_I(new_dir)->i_projid,
@@ -1014,6 +1030,9 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		return err;
 
 	if ((is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			!projid_eq(F2FS_I(new_dir)->i_projid,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 97a4fae75651..471aa8821d4c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -176,6 +176,8 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
 		return false;
 	if (sbi->gc_mode == GC_URGENT)
 		return true;
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		return true;
 
 	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
 			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
@@ -480,6 +482,9 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	if (need && excess_cached_nats(sbi))
 		f2fs_balance_fs_bg(sbi);
 
+	if (f2fs_is_checkpoint_ready(sbi))
+		return;
+
 	/*
 	 * We should do GC or end up with checkpoint, if there are so many dirty
 	 * dir/node pages without enough free segments.
@@ -796,7 +801,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned short valid_blocks;
+	unsigned short valid_blocks, ckpt_valid_blocks;
 
 	if (segno == NULL_SEGNO || IS_CURSEG(sbi, segno))
 		return;
@@ -804,8 +809,10 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_lock(&dirty_i->seglist_lock);
 
 	valid_blocks = get_valid_blocks(sbi, segno, false);
+	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno);
 
-	if (valid_blocks == 0) {
+	if (valid_blocks == 0 && (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) ||
+				ckpt_valid_blocks == sbi->blocks_per_seg)) {
 		__locate_dirty_segment(sbi, segno, PRE);
 		__remove_dirty_segment(sbi, segno, DIRTY);
 	} else if (valid_blocks < sbi->blocks_per_seg) {
@@ -818,6 +825,43 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
+/* This moves currently empty dirty blocks to prefree. Must hold seglist_lock */
+void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi)
+{
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	unsigned int segno;
+
+	mutex_lock(&dirty_i->seglist_lock);
+	for_each_set_bit(segno, dirty_i->dirty_segmap[DIRTY], MAIN_SEGS(sbi)) {
+		if (get_valid_blocks(sbi, segno, false))
+			continue;
+		if (IS_CURSEG(sbi, segno))
+			continue;
+		__locate_dirty_segment(sbi, segno, PRE);
+		__remove_dirty_segment(sbi, segno, DIRTY);
+	}
+	mutex_unlock(&dirty_i->seglist_lock);
+}
+
+/* This is only used by SBI_CP_DISABLED */
+static unsigned int get_free_segment(struct f2fs_sb_info *sbi)
+{
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	unsigned int segno = 0;
+
+	mutex_lock(&dirty_i->seglist_lock);
+	for_each_set_bit(segno, dirty_i->dirty_segmap[DIRTY], MAIN_SEGS(sbi)) {
+		if (get_valid_blocks(sbi, segno, false))
+			continue;
+		if (get_ckpt_valid_blocks(sbi, segno))
+			continue;
+		mutex_unlock(&dirty_i->seglist_lock);
+		return segno;
+	}
+	mutex_unlock(&dirty_i->seglist_lock);
+	return NULL_SEGNO;
+}
+
 static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t lstart,
 		block_t start, block_t len)
@@ -2028,7 +2072,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			sbi->discard_blks--;
 
 		/* don't overwrite by SSR to keep node chain */
-		if (IS_NODESEG(se->type)) {
+		if (IS_NODESEG(se->type) &&
+				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
 				se->ckpt_valid_blocks++;
 		}
@@ -2050,6 +2095,15 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_bug_on(sbi, 1);
 			se->valid_blocks++;
 			del = 0;
+		} else if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+			/*
+			 * If checkpoints are off, we must not reuse data that
+			 * was used in the previous checkpoint. If it was used
+			 * before, we must track that to know how much space we
+			 * really have.
+			 */
+			if (f2fs_test_bit(offset, se->ckpt_valid_map))
+				sbi->unusable_block_count++;
 		}
 
 		if (f2fs_test_and_clear_bit(offset, se->discard_map))
@@ -2332,6 +2386,9 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	if (sbi->segs_per_sec != 1)
 		return CURSEG_I(sbi, type)->segno;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		return 0;
+
 	if (test_opt(sbi, NOHEAP) &&
 		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		return 0;
@@ -2475,6 +2532,15 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 			return 1;
 		}
 	}
+
+	/* find valid_blocks=0 in dirty list */
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		segno = get_free_segment(sbi);
+		if (segno != NULL_SEGNO) {
+			curseg->next_segno = segno;
+			return 1;
+		}
+	}
 	return 0;
 }
 
@@ -2492,7 +2558,8 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
 					type == CURSEG_WARM_NODE)
 		new_curseg(sbi, type, false);
-	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
+	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type) &&
+			likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		new_curseg(sbi, type, false);
 	else if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
 		change_curseg(sbi, type);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 086150028c6d..ab3465faddf1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -339,6 +339,12 @@ static inline unsigned int get_valid_blocks(struct f2fs_sb_info *sbi,
 		return get_seg_entry(sbi, segno)->valid_blocks;
 }
 
+static inline unsigned int get_ckpt_valid_blocks(struct f2fs_sb_info *sbi,
+				unsigned int segno)
+{
+	return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+}
+
 static inline void seg_info_from_raw_sit(struct seg_entry *se,
 					struct f2fs_sit_entry *rs)
 {
@@ -576,6 +582,15 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 		reserved_sections(sbi) + needed);
 }
 
+static inline int f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
+{
+	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		return 0;
+	if (likely(!has_not_enough_free_secs(sbi, 0, 0)))
+		return 0;
+	return -ENOSPC;
+}
+
 static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
 {
 	return prefree_segments(sbi) > SM_I(sbi)->rec_prefree_segments;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c47b1ef2685a..d698e11b06e4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -136,6 +136,7 @@ enum {
 	Opt_alloc,
 	Opt_fsync,
 	Opt_test_dummy_encryption,
+	Opt_checkpoint,
 	Opt_err,
 };
 
@@ -194,6 +195,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
+	{Opt_checkpoint, "checkpoint=%s"},
 	{Opt_err, NULL},
 };
 
@@ -769,6 +771,23 @@ static int parse_options(struct super_block *sb, char *options)
 					"Test dummy encryption mount option ignored");
 #endif
 			break;
+		case Opt_checkpoint:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+
+			if (strlen(name) == 6 &&
+					!strncmp(name, "enable", 6)) {
+				clear_opt(sbi, DISABLE_CHECKPOINT);
+			} else if (strlen(name) == 7 &&
+					!strncmp(name, "disable", 7)) {
+				set_opt(sbi, DISABLE_CHECKPOINT);
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -827,6 +846,12 @@ static int parse_options(struct super_block *sb, char *options)
 		}
 	}
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT) && test_opt(sbi, LFS)) {
+		f2fs_msg(sb, KERN_ERR,
+				"LFS not compatible with checkpoint=disable\n");
+		return -EINVAL;
+	}
+
 	/* Not pass down write hints if the number of active logs is lesser
 	 * than NR_CURSEG_TYPE.
 	 */
@@ -1014,8 +1039,8 @@ static void f2fs_put_super(struct super_block *sb)
 	 * But, the previous checkpoint was not done by umount, it needs to do
 	 * clean checkpoint again.
 	 */
-	if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
-			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+	if ((is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
+			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
@@ -1087,6 +1112,8 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return 0;
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		return 0;
 
 	trace_f2fs_sync_fs(sb, sync);
 
@@ -1186,6 +1213,11 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
+	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
+		buf->f_bfree = 0;
+	else
+		buf->f_bfree -= sbi->unusable_block_count;
+
 	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
 		buf->f_bavail = buf->f_bfree -
 				F2FS_OPTION(sbi).root_reserved_blocks;
@@ -1365,6 +1397,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
 		seq_printf(seq, ",alloc_mode=%s", "reuse");
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		seq_puts(seq, ",checkpoint=disable");
+
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
@@ -1392,6 +1427,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, INLINE_DENTRY);
 	set_opt(sbi, EXTENT_CACHE);
 	set_opt(sbi, NOHEAP);
+	clear_opt(sbi, DISABLE_CHECKPOINT);
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
 	set_opt(sbi, DISCARD);
@@ -1413,6 +1449,52 @@ static void default_options(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_QUOTA
 static int f2fs_enable_quotas(struct super_block *sb);
 #endif
+
+static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct cp_control cpc;
+	int err;
+
+	sbi->sb->s_flags |= SB_ACTIVE;
+
+	mutex_lock(&sbi->gc_mutex);
+	for (; dirty_segments(sbi) > 2 * NR_CURSEG_TYPE;) {
+		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
+		if (err == -ENODATA)
+			break;
+		if (err && err != -EAGAIN) {
+			mutex_unlock(&sbi->gc_mutex);
+			return err;
+		}
+	}
+	mutex_unlock(&sbi->gc_mutex);
+
+	err = sync_filesystem(sbi->sb);
+	if (err)
+		return err;
+
+	mutex_lock(&sbi->gc_mutex);
+	cpc.reason = CP_PAUSE;
+	set_sbi_flag(sbi, SBI_CP_DISABLED);
+	f2fs_write_checkpoint(sbi, &cpc);
+
+	sbi->unusable_block_count = 0;
+	mutex_unlock(&sbi->gc_mutex);
+	return 0;
+}
+
+static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
+{
+	mutex_lock(&sbi->gc_mutex);
+	f2fs_dirty_to_prefree(sbi);
+
+	clear_sbi_flag(sbi, SBI_CP_DISABLED);
+	set_sbi_flag(sbi, SBI_IS_DIRTY);
+	mutex_unlock(&sbi->gc_mutex);
+
+	f2fs_sync_fs(sbi->sb, 1);
+}
+
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -1422,6 +1504,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
+	bool disable_checkpoint = test_opt(sbi, DISABLE_CHECKPOINT);
+	bool checkpoint_changed;
 #ifdef CONFIG_QUOTA
 	int i, j;
 #endif
@@ -1466,6 +1550,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	err = parse_options(sb, data);
 	if (err)
 		goto restore_opts;
+	checkpoint_changed =
+			disable_checkpoint != test_opt(sbi, DISABLE_CHECKPOINT);
 
 	/*
 	 * Previous and new state of filesystem is RO,
@@ -1499,6 +1585,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
+	if ((*flags & MS_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
+		err = -EINVAL;
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"disabling checkpoint not compatible with read-only");
+		goto restore_opts;
+	}
+
 	/*
 	 * We stop the GC thread if FS is mounted as RO
 	 * or if background_gc = off is passed in mount
@@ -1527,6 +1620,16 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		clear_sbi_flag(sbi, SBI_IS_CLOSE);
 	}
 
+	if (checkpoint_changed) {
+		if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+			err = f2fs_disable_checkpoint(sbi);
+			if (err)
+				goto restore_gc;
+		} else {
+			f2fs_enable_checkpoint(sbi);
+		}
+	}
+
 	/*
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
@@ -3064,6 +3167,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_meta;
 
+	if (unlikely(is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)))
+		goto skip_recovery;
+
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
 		/*
@@ -3103,6 +3209,14 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* f2fs_recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		err = f2fs_disable_checkpoint(sbi);
+		if (err)
+			goto free_meta;
+	} else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)) {
+		f2fs_enable_checkpoint(sbi);
+	}
+
 	/*
 	 * If filesystem is not mounted as read-only then
 	 * do start the gc_thread.
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 1d4b196291d6..9e95bbce5dd4 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -115,6 +115,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_DISABLED_FLAG		0x00001000
 #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
 #define CP_NOCRC_RECOVERY_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
-- 
2.19.0.605.g01d371f741-goog

