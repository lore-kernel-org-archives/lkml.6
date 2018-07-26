Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0231AC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FCF20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLLcPF5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FCF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeGZBdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:33:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32816 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbeGZBdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:33:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so6351088pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ST7WNY5/Dw8um0ZTtHAmBEYB4ZdmbliPNlMb3EkU29w=;
        b=fLLcPF5WXjHih2a2TEpqLG7XJPH40XFZi1w8wSXU9y5ZgAI3FXG12bu4Glqr3D5xPl
         Scf3en4v7McA+6/0FQiBZyZnAxvGmm0EUd/2Uio5TWxaPjET+TQem/fAxSVElsXxfUlZ
         p0hPBMdL0N6JSc2vFSoYOOcaHNSrhL2uYcfY525VApBoPNmsaHSyLuqNv0IkHbw44ngc
         DVs3ABEZqtdesM7wb7Atwp1RXzQjgTGUTQCL92goswwtqi/WAmPPuLQcyX/FBkOCVNPD
         bDQjh6Xa1tVHxKds3Seera0uK11YpX9eWSgxR+ESFuLsBqeaWCIL/oBwwQmpET+zRUGa
         nEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ST7WNY5/Dw8um0ZTtHAmBEYB4ZdmbliPNlMb3EkU29w=;
        b=rrY41F0XyBKhObgiTjqbDEUd7Pd4T5Hgdxkxh15a7pxIaPM3FJYKkiZcS2Bx7zR8eO
         EQXTIMsHwyAaesARemz19T6/1CdXQ0LxrvoMV403vlN3vyKd4ZI7rIa0uD2xs1Q6uJc9
         bJ15m168Y2PW8B4ZojE8lJz1xlaGyOaGFWDDmUsWj2BvlrCGyuKiUqO/9UXfW88sJrtV
         rLpO/CLOxv3N4JBwwFgWm+mjV8HYGfNv/zRA+Jnnr9RvNqGobZhcAdgGzg9NSjWFTlWc
         gNkCbtbdWND7XnWFG3tm1mUFoNpVonn0J7rMiFFa00HWvqgDYebnP6WZmPiXxZVuQosJ
         /nnA==
X-Gm-Message-State: AOUpUlGRFti5Hon1e++Vzr8MBThe9RQ6+zd3SHavviVWLfnwZNJci6y0
        Fc8DBYuRpn3lgrNIMOSyx3qWBw==
X-Google-Smtp-Source: AAOMgpfYVaf4X7qN4r4d+7kAuLp74wa6fzTAiFHU+rl9ZmuJ1tajttwPzVaEAYzhjB0ln6Pcd2R+NA==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr22792818pgu.260.1532564377464;
        Wed, 25 Jul 2018 17:19:37 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1611:7129:1142:3149:848c])
        by smtp.gmail.com with ESMTPSA id e82-v6sm30644177pfd.40.2018.07.25.17.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 17:19:36 -0700 (PDT)
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH v2] f2fs: checkpoint disabling
Date:   Wed, 25 Jul 2018 17:19:09 -0700
Message-Id: <20180726001909.18252-1-drosen@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a lightweight non-persistent snapshotting scheme to f2fs.

To use, mount with the option checkpoint=disable, and to return to
normal operation, remount with checkpoint=enable. If the filesystem
is shut down before remounting with checkpoint=enable, it will revert
back to its apparent state when it was first mounted with
checkpoint=disable. This is useful for situations where you wish to be
able to roll back the state of the disk in case of some critical
failure.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---

Included changes suggested by Jaegeuk and Chao.
it now holds the gc lock around setting up free space tracking in
f2fs_disable_checkpoint. I wasn't quite sure what was mean by
the comment on should_update_outplace, but I've changed it to return
true for NEW_ADDR as well. It may be better to instead skip over the
reset of that block if old_blkaddr is NEW_ADDR, because I think that
means the data has not yet been committed, and thus wouldn't be
overwriting data from the previous checkpoint.

We're currently using this during updates to extend the period of time
that we can safely roll back a faulty update. After performing an update
and reboot, we'd mount in this mode. If there ends up being some sort of
fatal error, data changes are automatically reverted, allowing us to
revert to the state before the update without worrying about any incompatible
changes that may've been made to data while running under the faulty system.
It increases our ability to revert a faulty update from up to mounting user
data partitions to a bit farther along.

 Documentation/filesystems/f2fs.txt |   5 ++
 fs/f2fs/data.c                     |  23 ++++++
 fs/f2fs/f2fs.h                     |  55 +++++++++++++-
 fs/f2fs/file.c                     |  18 +++++
 fs/f2fs/gc.c                       |   4 +
 fs/f2fs/segment.c                  |  58 ++++++++++++---
 fs/f2fs/segment.h                  |  26 +++++++
 fs/f2fs/super.c                    | 116 +++++++++++++++++++++++++++--
 8 files changed, 288 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 69f8de9957397..a026b353a99d4 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -193,6 +193,11 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
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
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6b8ca5011bfd6..8f32df9b7b8f3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1690,6 +1690,19 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 
 	if (test_opt(sbi, LFS))
 		return true;
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		struct seg_entry *se;
+		unsigned int segno, offset;
+
+		if (!fio || fio->old_blkaddr == NULL_ADDR ||
+				fio->old_blkaddr == NEW_ADDR)
+			return true;
+		segno = GET_SEGNO(sbi, fio->old_blkaddr);
+		se = get_seg_entry(sbi, segno);
+		offset = GET_BLKOFF_FROM_SEG0(sbi, fio->old_blkaddr);
+		if (f2fs_test_bit(offset, se->ckpt_valid_map))
+			return true;
+	}
 	if (S_ISDIR(inode->i_mode))
 		return true;
 	if (f2fs_is_atomic_file(inode))
@@ -1717,10 +1730,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 {
 	struct page *page = fio->page;
 	struct inode *inode = page->mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	struct extent_info ei = {0,0,0};
 	struct node_info ni;
 	bool ipu_force = false;
+	bool need_tmp_grab = test_opt(sbi, DISABLE_CHECKPOINT);
+	blkcnt_t tmp_block = 1;
 	int err = 0;
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -1798,6 +1814,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	if (err)
 		goto out_writepage;
 
+	if (need_tmp_grab) {
+		err = inc_valid_block_count(sbi, dn.inode, &tmp_block);
+		if (err)
+			goto out_writepage;
+	}
 	set_page_writeback(page);
 	ClearPageError(page);
 
@@ -1807,6 +1828,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (page->index == 0)
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
+	if (need_tmp_grab)
+		dec_valid_block_count(sbi, dn.inode, tmp_block);
 out_writepage:
 	f2fs_put_dnode(&dn);
 out:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0374f069520cf..f594957f9d0cd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -97,6 +97,7 @@ extern char *f2fs_fault_name[FAULT_MAX];
 #define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
 #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
+#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
@@ -175,6 +176,7 @@ enum {
 #define	CP_RECOVERY	0x00000008
 #define	CP_DISCARD	0x00000010
 #define CP_TRIMMED	0x00000020
+#define CP_PAUSE	0x00000040
 
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
@@ -1074,6 +1076,7 @@ enum {
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_DISABLE_ATOMIC_WRITE,		/* turn off atomic write */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
+	SBI_CP_DISABLED,			/* CP was disabled last mount */
 };
 
 enum {
@@ -1199,6 +1202,12 @@ struct f2fs_sb_info {
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
 
+	/* Additional tracking for no checkpoint mode */
+	block_t unusable_block_count;		/* # of blocks saved by last cp */
+	block_t free_ssr_data_block;
+	block_t free_ssr_node_block;
+	block_t free_segments;
+
 	unsigned int nquota_files;		/* # of quota sysfile */
 
 	u32 s_next_generation;			/* for NFS support */
@@ -1650,7 +1659,7 @@ static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
 {
-	blkcnt_t diff = 0, release = 0;
+	blkcnt_t diff = 0, release = 0, seg_diff = 0, seg_rel = 0;
 	block_t avail_user_block_count;
 	int ret;
 
@@ -1678,6 +1687,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, true))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		avail_user_block_count -= sbi->unusable_block_count;
 
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
@@ -1691,6 +1702,35 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 			goto enospc;
 		}
 	}
+	if (likely(!test_opt(sbi, DISABLE_CHECKPOINT)))
+		goto normal;
+	if (unlikely(*count > sbi->free_ssr_data_block)) {
+		/* We'll need to pull from free. */
+		blkcnt_t needed = *count - sbi->free_ssr_data_block;
+		blkcnt_t new_segs = ((needed - 1) >>
+					sbi->log_blocks_per_seg) + 1;
+
+		/* Check if we have enough free */
+		if (unlikely(new_segs > sbi->free_segments)) {
+			seg_diff = new_segs - sbi->free_segments;
+
+			seg_rel = ((needed - 1) % sbi->log_blocks_per_seg) + 1;
+			seg_rel += (seg_diff - 1) << sbi->log_blocks_per_seg;
+			new_segs -= seg_diff;
+			*count -= seg_rel;
+			release += seg_rel;
+			if (!*count) {
+				spin_unlock(&sbi->stat_lock);
+				goto enospc;
+			}
+		}
+
+		sbi->free_segments -= new_segs;
+		sbi->free_ssr_data_block += new_segs << sbi->log_blocks_per_seg;
+
+	}
+	sbi->free_ssr_data_block -= *count;
+normal:
 	spin_unlock(&sbi->stat_lock);
 
 	if (unlikely(release)) {
@@ -1887,6 +1927,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, false))
 		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		valid_block_count += sbi->unusable_block_count;
 
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
@@ -1899,6 +1941,17 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 		goto enospc;
 	}
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		if (unlikely(!sbi->free_ssr_node_block)) {
+			if (unlikely(!sbi->free_segments)) {
+				spin_unlock(&sbi->stat_lock);
+				goto enospc;
+			}
+			sbi->free_segments--;
+		}
+		sbi->free_ssr_node_block--;
+	}
+
 	sbi->total_valid_node_count++;
 	sbi->total_valid_block_count++;
 	spin_unlock(&sbi->stat_lock);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3a5c35fa06039..20124f5d287b8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -150,6 +150,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	enum cp_reason_type cp_reason = CP_NO_NEEDED;
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return CP_NO_NEEDED;
+
 	if (!S_ISREG(inode->i_mode))
 		cp_reason = CP_NON_REGULAR;
 	else if (inode->i_nlink != 1)
@@ -2070,6 +2073,9 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return -EINVAL;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2112,6 +2118,9 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 		return -EINVAL;
 	}
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return -EINVAL;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2147,6 +2156,12 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		f2fs_msg(sbi->sb, KERN_INFO,
+			"Skipping Checkpoint. Checkpoints currently disabled.");
+		return -EINVAL;
+	}
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2513,6 +2528,9 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return -EINVAL;
+
 	if (copy_from_user(&range, (struct f2fs_flush_device __user *)arg,
 							sizeof(range)))
 		return -EFAULT;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fe0da3e05ef14..1326f5b6aa99d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -60,6 +60,9 @@ static int gc_thread_func(void *data)
 		}
 #endif
 
+		if (test_opt(sbi, DISABLE_CHECKPOINT))
+			goto do_balance;
+
 		if (!sb_start_write_trylock(sbi->sb))
 			continue;
 
@@ -105,6 +108,7 @@ static int gc_thread_func(void *data)
 		trace_f2fs_background_gc(sbi->sb, wait_ms,
 				prefree_segments(sbi), free_segments(sbi));
 
+do_balance:
 		/* balancing f2fs's metadata periodically */
 		f2fs_balance_fs_bg(sbi);
 next:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 17354089b4ab2..3d5d8098d4ead 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -179,6 +179,10 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
 		return false;
 	if (sbi->gc_mode == GC_URGENT)
 		return true;
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return true;
+	if (sbi->gc_mode == GC_URGENT)
+		return true;
 
 	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
 			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
@@ -485,6 +489,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 * We should do GC or end up with checkpoint, if there are so many dirty
 	 * dir/node pages without enough free segments.
 	 */
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return;
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		mutex_lock(&sbi->gc_mutex);
 		f2fs_gc(sbi, false, false, NULL_SEGNO);
@@ -525,8 +531,10 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			f2fs_sync_dirty_inodes(sbi, FILE_INODE);
 			blk_finish_plug(&plug);
 		}
-		f2fs_sync_fs(sbi->sb, true);
-		stat_inc_bg_cp_count(sbi->stat_info);
+		if (!test_opt(sbi, DISABLE_CHECKPOINT)) {
+			f2fs_sync_fs(sbi->sb, true);
+			stat_inc_bg_cp_count(sbi->stat_info);
+		}
 	}
 }
 
@@ -741,8 +749,8 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 	return ret;
 }
 
-static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
-		enum dirty_type dirty_type)
+void __locate_dirty_segment(struct f2fs_sb_info *sbi,
+		unsigned int segno, enum dirty_type dirty_type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 
@@ -766,8 +774,8 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 	}
 }
 
-static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
-		enum dirty_type dirty_type)
+void __remove_dirty_segment(struct f2fs_sb_info *sbi,
+		unsigned int segno, enum dirty_type dirty_type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 
@@ -787,6 +795,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 	}
 }
 
+
 /*
  * Should not occur error such as -ENOMEM.
  * Adding dirty entry into seglist is not critical operation.
@@ -795,7 +804,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned short valid_blocks;
+	unsigned short valid_blocks, ckpt_valid_blocks;
 
 	if (segno == NULL_SEGNO || IS_CURSEG(sbi, segno))
 		return;
@@ -803,8 +812,10 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_lock(&dirty_i->seglist_lock);
 
 	valid_blocks = get_valid_blocks(sbi, segno, false);
+	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno);
 
-	if (valid_blocks == 0) {
+	if (valid_blocks == 0 && (ckpt_valid_blocks == sbi->blocks_per_seg ||
+					!test_opt(sbi, DISABLE_CHECKPOINT))) {
 		__locate_dirty_segment(sbi, segno, PRE);
 		__remove_dirty_segment(sbi, segno, DIRTY);
 	} else if (valid_blocks < sbi->blocks_per_seg) {
@@ -1926,7 +1937,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			sbi->discard_blks--;
 
 		/* don't overwrite by SSR to keep node chain */
-		if (IS_NODESEG(se->type)) {
+		if (IS_NODESEG(se->type) &&
+				!test_opt(sbi, DISABLE_CHECKPOINT)) {
 			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
 				se->ckpt_valid_blocks++;
 		}
@@ -1948,6 +1960,25 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_bug_on(sbi, 1);
 			se->valid_blocks++;
 			del = 0;
+		} else {
+			/* If checkpoints are off, we must not reuse data that
+			 * was used in the previous checkpoint. If it was used
+			 * before, we must track that to know how much space we
+			 * really have
+			 */
+			if (f2fs_test_bit(offset, se->ckpt_valid_map)) {
+				spin_lock(&sbi->stat_lock);
+				sbi->unusable_block_count++;
+				spin_unlock(&sbi->stat_lock);
+			} else {
+				spin_lock(&sbi->stat_lock);
+				if (IS_DATASEG(se->type))
+					sbi->free_ssr_data_block++;
+				else
+					sbi->free_ssr_node_block++;
+				spin_unlock(&sbi->stat_lock);
+			}
+
 		}
 
 		if (f2fs_discard_en(sbi) &&
@@ -2237,7 +2268,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 		return SIT_I(sbi)->last_victim[ALLOC_NEXT];
 
 	/* find segments from 0 to reuse freed segments */
-	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
+	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE
+			|| test_opt(sbi, DISABLE_CHECKPOINT))
 		return 0;
 
 	return CURSEG_I(sbi, type)->segno;
@@ -2389,7 +2421,8 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
 					type == CURSEG_WARM_NODE)
 		new_curseg(sbi, type, false);
-	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
+	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type) &&
+			!test_opt(sbi, DISABLE_CHECKPOINT))
 		new_curseg(sbi, type, false);
 	else if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
 		change_curseg(sbi, type);
@@ -3568,6 +3601,9 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			sit_i->dirty_sentries--;
 			ses->entry_cnt--;
 		}
+		spin_lock(&sbi->stat_lock);
+		sbi->unusable_block_count = 0;
+		spin_unlock(&sbi->stat_lock);
 
 		if (to_journal)
 			up_write(&curseg->journal_rwsem);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 50495515f0a0d..37222e133d52a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -342,6 +342,12 @@ static inline unsigned int get_valid_blocks(struct f2fs_sb_info *sbi,
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
@@ -524,6 +530,26 @@ static inline unsigned int dirty_segments(struct f2fs_sb_info *sbi)
 		DIRTY_I(sbi)->nr_dirty[DIRTY_COLD_NODE];
 }
 
+void __locate_dirty_segment(struct f2fs_sb_info *sbi,
+		unsigned int segno, enum dirty_type dirty_type);
+
+void __remove_dirty_segment(struct f2fs_sb_info *sbi,
+		unsigned int segno, enum dirty_type dirty_type);
+
+/* This moves currently empty dirty blocks to prefree. Must hold seglist_lock */
+static inline void dirty_to_prefree(struct f2fs_sb_info *sbi)
+{
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	unsigned int segno;
+
+	for_each_set_bit(segno, dirty_i->dirty_segmap[DIRTY], MAIN_SEGS(sbi)) {
+		if (!get_valid_blocks(sbi, segno, false)) {
+			__locate_dirty_segment(sbi, segno, PRE);
+			__remove_dirty_segment(sbi, segno, DIRTY);
+		}
+	}
+}
+
 static inline int overprovision_segments(struct f2fs_sb_info *sbi)
 {
 	return SM_I(sbi)->ovp_segments;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7187885da2515..7568ae00319cb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -132,6 +132,7 @@ enum {
 	Opt_alloc,
 	Opt_fsync,
 	Opt_test_dummy_encryption,
+	Opt_checkpoint,
 	Opt_err,
 };
 
@@ -189,6 +190,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
+	{Opt_checkpoint, "checkpoint=%s"},
 	{Opt_err, NULL},
 };
 
@@ -764,6 +766,23 @@ static int parse_options(struct super_block *sb, char *options)
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
@@ -809,6 +828,12 @@ static int parse_options(struct super_block *sb, char *options)
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
@@ -996,8 +1021,9 @@ static void f2fs_put_super(struct super_block *sb)
 	 * But, the previous checkpoint was not done by umount, it needs to do
 	 * clean checkpoint again.
 	 */
-	if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
-			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+	if ((is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
+			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) &&
+			!test_opt(sbi, DISABLE_CHECKPOINT)) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
@@ -1007,7 +1033,8 @@ static void f2fs_put_super(struct super_block *sb)
 	/* be sure to wait for any on-going discard commands */
 	dropped = f2fs_wait_discard_bios(sbi);
 
-	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped) {
+	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped &&
+			!test_opt(sbi, DISABLE_CHECKPOINT)) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
@@ -1064,6 +1091,8 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return 0;
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return 0;
 
 	trace_f2fs_sync_fs(sb, sync);
 
@@ -1162,7 +1191,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
-						sbi->current_reserved_blocks;
+						sbi->current_reserved_blocks -
+						sbi->unusable_block_count;
 	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
 		buf->f_bavail = buf->f_bfree -
 				F2FS_OPTION(sbi).root_reserved_blocks;
@@ -1338,6 +1368,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
 		seq_printf(seq, ",alloc_mode=%s", "reuse");
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		seq_puts(seq, ",checkpoint=disable");
+
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
@@ -1365,6 +1398,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, INLINE_DENTRY);
 	set_opt(sbi, EXTENT_CACHE);
 	set_opt(sbi, NOHEAP);
+	clear_opt(sbi, DISABLE_CHECKPOINT);
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
 	if (blk_queue_discard(bdev_get_queue(sbi->sb->s_bdev)))
@@ -1387,6 +1421,60 @@ static void default_options(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_QUOTA
 static int f2fs_enable_quotas(struct super_block *sb);
 #endif
+
+static void f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct cp_control cpc;
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	unsigned int segno;
+	int type;
+
+	set_sbi_flag(sbi, SBI_CP_DISABLED);
+
+	cpc.reason = CP_PAUSE;
+
+	mutex_lock(&sbi->gc_mutex);
+	f2fs_write_checkpoint(sbi, &cpc);
+
+	mutex_lock(&dirty_i->seglist_lock);
+	for (type = 0; type < NR_CURSEG_TYPE; type++) {
+		for_each_set_bit(segno, dirty_i->dirty_segmap[type],
+							MAIN_SEGS(sbi)) {
+			if (IS_DATASEG(type))
+				sbi->free_ssr_data_block +=
+					get_valid_blocks(sbi, segno, false);
+			else
+				sbi->free_ssr_node_block +=
+					get_valid_blocks(sbi, segno, false);
+		}
+	}
+	sbi->free_segments = FREE_I(sbi)->free_segments;
+	mutex_unlock(&dirty_i->seglist_lock);
+	mutex_unlock(&sbi->gc_mutex);
+}
+
+static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct super_block *sb = sbi->sb;
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+
+	clear_sbi_flag(sbi, SBI_CP_DISABLED);
+	writeback_inodes_sb(sb, WB_REASON_SYNC);
+	sync_inodes_sb(sb);
+
+	mutex_lock(&dirty_i->seglist_lock);
+	dirty_to_prefree(sbi);
+	sbi->free_segments = 0;
+	sbi->free_ssr_data_block = 0;
+	sbi->free_ssr_node_block = 0;
+	mutex_unlock(&dirty_i->seglist_lock);
+
+	set_sbi_flag(sbi, SBI_IS_DIRTY);
+	set_sbi_flag(sbi, SBI_IS_CLOSE);
+	f2fs_sync_fs(sb, 1);
+	clear_sbi_flag(sbi, SBI_IS_CLOSE);
+}
+
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -1396,6 +1484,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
+	bool disable_checkpoint = test_opt(sbi, DISABLE_CHECKPOINT);
+	bool checkpoint_changed;
 #ifdef CONFIG_QUOTA
 	int i, j;
 #endif
@@ -1440,6 +1530,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	err = parse_options(sb, data);
 	if (err)
 		goto restore_opts;
+	checkpoint_changed =
+			disable_checkpoint != test_opt(sbi, DISABLE_CHECKPOINT);
 
 	/*
 	 * Previous and new state of filesystem is RO,
@@ -1501,6 +1593,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		clear_sbi_flag(sbi, SBI_IS_CLOSE);
 	}
 
+	if (checkpoint_changed) {
+		if (test_opt(sbi, DISABLE_CHECKPOINT))
+			f2fs_disable_checkpoint(sbi);
+		else
+			f2fs_enable_checkpoint(sbi);
+	}
+
 	/*
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
@@ -2987,7 +3086,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_meta;
 
 	/* recover fsynced data */
-	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
+	if (!test_opt(sbi, DISABLE_ROLL_FORWARD) &&
+			!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 		/*
 		 * mount should be failed, when device has readonly mode, and
 		 * previous checkpoint was not done by clean system shutdown.
@@ -3053,6 +3153,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 				cur_cp_version(F2FS_CKPT(sbi)));
 	f2fs_update_time(sbi, CP_TIME);
 	f2fs_update_time(sbi, REQ_TIME);
+
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		f2fs_disable_checkpoint(sbi);
+	else if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+		f2fs_enable_checkpoint(sbi);
+
 	return 0;
 
 free_meta:
-- 
2.18.0.233.g985f88cf7e-goog

