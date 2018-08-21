Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CD7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD31320894
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwSUM4aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD31320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeHUFj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:39:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45386 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUFj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:39:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so7708132pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 19:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9IYl/jB6M5fP19Kfx406BBMzQfunyndgrOZVefOCCs=;
        b=UwSUM4aOKCkNbgL8ed9oIVit16GmvmIn7+SdaDPzeOhIda/uKftQH0XX6Kq/MM279A
         2Q8C/W15JgLHERDbF9j21XsEyj5GH6+0b8s17BkuJqs+a8/Kw2GV55mNpmIOjjiGWT0Q
         bfhmFdI2oODrx1Zb8dipG9Q/Hcx9WVr2XgqzViwg52Cwr//HRTit7FogP1nlZFb/EfPL
         584BLJo605wbJJGVPPhysR+LS/3aSujE5PWo3gkCkdAtpNS3ECXJVRM1h/fUd70W4ITR
         dULcpirXq5UVrCYMaH1tCPuY49Nvdpvs/53/bLxuIPvUQ8iEehvVidIQXvY7Tb7lyOpa
         Auxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9IYl/jB6M5fP19Kfx406BBMzQfunyndgrOZVefOCCs=;
        b=DTx6jTdobiE96tfiEpqEdtjXF8089Vc1RTKzQrMd536Pq+BCxGPzZa1rgVWl697sd7
         yTiT/+CCjUrFqlKlCOuboH7pvEEUlP0pmtwkkhbBRa8qR+AHIXxgxYyK2Tb/Z63VvrV/
         ljRYSKQGj9h3O6lV5YR5zp7IW/oAJRHurfRigo7BUlh5J0xMAbez2LJsur/ezYVIgfMy
         WWi1RcDSyJKv3/FBY/N7h01+DAe1+wD31muTFO6kDNJ3HiivCG81t2guImZtsRlyNZKI
         BE4NHbZ/9ak+yfjXZOppdKMoERK0vMZERv6m7QkezDhyoMO13sKWgyl+u7AB1/uOcjAm
         b74g==
X-Gm-Message-State: AOUpUlGoQFB5oFGWlLf4hmOvvFLYAwwM79UMsGdy4skXBECHrYcRpyZT
        j5LriRDf6dPUBTlM/Ks4qkst4A==
X-Google-Smtp-Source: AA+uWPzRzXOUq8zwmkKZb2KwpHll47BxyBbIrW25PMAPbe6jWm4uba62DkxH40ksqU1ux/LfF4VjOQ==
X-Received: by 2002:a65:5545:: with SMTP id t5-v6mr45615059pgr.157.1534818110822;
        Mon, 20 Aug 2018 19:21:50 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id g28-v6sm22231815pfe.41.2018.08.20.19.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 19:21:50 -0700 (PDT)
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH v4] f2fs: checkpoint disabling
Date:   Mon, 20 Aug 2018 19:21:43 -0700
Message-Id: <20180821022143.9007-1-drosen@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change-Id: I8a672396d1049315415444f001ccada0bbda7691
Signed-off-by: Daniel Rosenberg <drosen@google.com>
bug: 111306604
---
v4:
Added call to garbage collection on mounting without checkpoints enabled
to allow for a longer period of running smoothly

Disallowed mounting read-only and with checkpoints disabled

Switched tracking of free storage space to be under a separate struct for
clarity. The purpose of this tracking is to avoid some edge case
scenarios where you would normally need garbage collection to continue.

One way to hit this in testing is to fill the filesystem with folders, and
then fill the filesystem with a single large file. This causes us to have
a bunch of dirty node segments, and insufficient free segments to fill the fs
with data segments. The tracking does not need to be 100% accurate, but it
must guarantee that it does not overestimage free space. For instance, we may
inaccurately predict that we'll end up needing another data segment, but blocks
may free up to fill that request later on. This leads to us believing that an
extra segment is no longer free, and assigned data blocks, which might make us
fail a request for a new node block a little earlier under extreme cases.
One possible improvement would be to move segments that were unsused in the
previous checkpoint, and now are unused, to free blocks instead of dirty. This
would let them switch between node and data blocks. That test case would still
exist anyways in the event that you had, say, a single node block per segment.

Additionally, moved changes to tracking variables to be only within
[inc/dec]_valid_[block/node]_count, which makes the code easier to reason about
and corrects some cases the previous version misses.

 Documentation/filesystems/f2fs.txt |   5 ++
 fs/f2fs/checkpoint.c               |   5 ++
 fs/f2fs/data.c                     |  23 ++++++
 fs/f2fs/f2fs.h                     |  87 ++++++++++++++++++++
 fs/f2fs/file.c                     |  18 +++++
 fs/f2fs/gc.c                       |   4 +
 fs/f2fs/segment.c                  |  55 ++++++++++---
 fs/f2fs/segment.h                  |  26 ++++++
 fs/f2fs/super.c                    | 124 +++++++++++++++++++++++++++--
 9 files changed, 331 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index e5edd29687b50..b14f10eb3cbf2 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -211,6 +211,11 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
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
index e8b6b89bddb86..518c1a12224f2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1446,6 +1446,11 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long long ckpt_ver;
 	int err = 0;
 
+	if (unlikely(test_opt(sbi, DISABLE_CHECKPOINT))) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+				"Checkpoints disabled, but took checkpoint!");
+		WARN_ON(1);
+	}
 	mutex_lock(&sbi->cp_mutex);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 86bf3826db825..505498f8f054c 100644
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
index 96bde026636ff..f3f031dc724c9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -100,6 +100,7 @@ extern char *f2fs_fault_name[FAULT_MAX];
 #define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
 #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
+#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
@@ -178,6 +179,7 @@ enum {
 #define	CP_RECOVERY	0x00000008
 #define	CP_DISCARD	0x00000010
 #define CP_TRIMMED	0x00000020
+#define CP_PAUSE	0x00000040
 
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
@@ -1088,6 +1090,7 @@ enum {
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
+	SBI_CP_DISABLED,			/* CP was disabled last mount */
 };
 
 enum {
@@ -1127,6 +1130,13 @@ enum fsync_mode {
 #define DUMMY_ENCRYPTION_ENABLED(sbi) (0)
 #endif
 
+struct cpd_tracker {
+	block_t unusable_block_count;		/* # of blocks saved by last cp */
+	block_t unusable_ssr_blocks[2];
+	block_t free_ssr_blocks[2];
+	block_t free_segments;
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1219,6 +1229,9 @@ struct f2fs_sb_info {
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
 
+	/* Additional tracking for no checkpoint mode */
+	struct cpd_tracker cpd;
+
 	unsigned int nquota_files;		/* # of quota sysfile */
 
 	u32 s_next_generation;			/* for NFS support */
@@ -1704,6 +1717,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, true))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		avail_user_block_count -= sbi->cpd.unusable_block_count;
 
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
@@ -1717,6 +1732,38 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 			goto enospc;
 		}
 	}
+	if (likely(!test_opt(sbi, DISABLE_CHECKPOINT)))
+		goto normal;
+	if (unlikely(*count > sbi->cpd.free_ssr_blocks[DATA])) {
+		/* We'll need to pull from free. */
+		blkcnt_t needed = *count - sbi->cpd.free_ssr_blocks[DATA];
+		blkcnt_t new_segs = ((needed - 1) >>
+					sbi->log_blocks_per_seg) + 1;
+
+		/* Check if we have enough free */
+		if (unlikely(new_segs > sbi->cpd.free_segments)) {
+			blkcnt_t seg_rel, seg_diff, mask;
+
+			seg_diff = new_segs - sbi->cpd.free_segments;
+			mask = sbi->blocks_per_seg - 1;
+			seg_rel = ((needed - 1) & mask) + 1;
+			seg_rel += (seg_diff - 1) << sbi->log_blocks_per_seg;
+
+			new_segs -= seg_diff;
+			*count -= seg_rel;
+			release += seg_rel;
+			if (!*count) {
+				spin_unlock(&sbi->stat_lock);
+				goto enospc;
+			}
+		}
+
+		sbi->cpd.free_segments -= new_segs;
+		sbi->cpd.free_ssr_blocks[DATA] += new_segs << sbi->log_blocks_per_seg;
+
+	}
+	sbi->cpd.free_ssr_blocks[DATA] -= *count;
+normal:
 	spin_unlock(&sbi->stat_lock);
 
 	if (unlikely(release)) {
@@ -1742,6 +1789,22 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
 	f2fs_bug_on(sbi, inode->i_blocks < sectors);
 	sbi->total_valid_block_count -= (block_t)count;
+
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		if (sbi->cpd.unusable_ssr_blocks[DATA] > count) {
+			sbi->cpd.unusable_ssr_blocks[DATA] -= count;
+			sbi->cpd.unusable_block_count += count;
+		} else if (sbi->cpd.unusable_ssr_blocks[DATA]) {
+			sbi->cpd.free_ssr_blocks[DATA] += count -
+					sbi->cpd.unusable_ssr_blocks[DATA];
+			sbi->cpd.unusable_block_count +=
+					sbi->cpd.unusable_ssr_blocks[DATA];
+			sbi->cpd.unusable_ssr_blocks[DATA] = 0;
+		} else {
+			sbi->cpd.free_ssr_blocks[DATA] += count;
+		}
+	}
+
 	if (sbi->reserved_blocks &&
 		sbi->current_reserved_blocks < sbi->reserved_blocks)
 		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
@@ -1911,6 +1974,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, false))
 		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		valid_block_count += sbi->cpd.unusable_block_count;
 
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
@@ -1923,6 +1988,18 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 		goto enospc;
 	}
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		if (unlikely(!sbi->cpd.free_ssr_blocks[NODE])) {
+			if (unlikely(!sbi->cpd.free_segments)) {
+				spin_unlock(&sbi->stat_lock);
+				goto enospc;
+			}
+			sbi->cpd.free_segments--;
+			sbi->cpd.free_ssr_blocks[NODE] += sbi->blocks_per_seg;
+		}
+		sbi->cpd.free_ssr_blocks[NODE]--;
+	}
+
 	sbi->total_valid_node_count++;
 	sbi->total_valid_block_count++;
 	spin_unlock(&sbi->stat_lock);
@@ -1954,6 +2031,16 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 
 	sbi->total_valid_node_count--;
 	sbi->total_valid_block_count--;
+
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		if (sbi->cpd.unusable_ssr_blocks[NODE]) {
+			sbi->cpd.unusable_ssr_blocks[NODE]--;
+			sbi->cpd.unusable_block_count++;
+		} else {
+			sbi->cpd.free_ssr_blocks[NODE]++;
+		}
+	}
+
 	if (sbi->reserved_blocks &&
 		sbi->current_reserved_blocks < sbi->reserved_blocks)
 		sbi->current_reserved_blocks++;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5474aaa274b91..4d6f12be51b6e 100644
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
@@ -2085,6 +2088,9 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return -EINVAL;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2127,6 +2133,9 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 		return -EINVAL;
 	}
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return -EINVAL;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2162,6 +2171,12 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
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
@@ -2533,6 +2548,9 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return -EINVAL;
+
 	if (copy_from_user(&range, (struct f2fs_flush_device __user *)arg,
 							sizeof(range)))
 		return -EFAULT;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c598ae5ecbfa4..35c4e9bd44f6c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -58,6 +58,9 @@ static int gc_thread_func(void *data)
 			f2fs_stop_checkpoint(sbi, false);
 		}
 
+		if (test_opt(sbi, DISABLE_CHECKPOINT))
+			goto do_balance;
+
 		if (!sb_start_write_trylock(sbi->sb))
 			continue;
 
@@ -103,6 +106,7 @@ static int gc_thread_func(void *data)
 		trace_f2fs_background_gc(sbi->sb, wait_ms,
 				prefree_segments(sbi), free_segments(sbi));
 
+do_balance:
 		/* balancing f2fs's metadata periodically */
 		f2fs_balance_fs_bg(sbi);
 next:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7dcfe38e70cc1..104ad29086668 100644
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
@@ -487,6 +491,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 * We should do GC or end up with checkpoint, if there are so many dirty
 	 * dir/node pages without enough free segments.
 	 */
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return;
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		mutex_lock(&sbi->gc_mutex);
 		f2fs_gc(sbi, false, false, NULL_SEGNO);
@@ -529,8 +535,10 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
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
 
@@ -745,8 +753,8 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 	return ret;
 }
 
-static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
-		enum dirty_type dirty_type)
+void __locate_dirty_segment(struct f2fs_sb_info *sbi,
+		unsigned int segno, enum dirty_type dirty_type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 
@@ -770,8 +778,8 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 	}
 }
 
-static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
-		enum dirty_type dirty_type)
+void __remove_dirty_segment(struct f2fs_sb_info *sbi,
+		unsigned int segno, enum dirty_type dirty_type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 
@@ -791,6 +799,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 	}
 }
 
+
 /*
  * Should not occur error such as -ENOMEM.
  * Adding dirty entry into seglist is not critical operation.
@@ -799,7 +808,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned short valid_blocks;
+	unsigned short valid_blocks, ckpt_valid_blocks;
 
 	if (segno == NULL_SEGNO || IS_CURSEG(sbi, segno))
 		return;
@@ -807,8 +816,10 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_lock(&dirty_i->seglist_lock);
 
 	valid_blocks = get_valid_blocks(sbi, segno, false);
+	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno);
 
-	if (valid_blocks == 0) {
+	if (valid_blocks == 0 && (ckpt_valid_blocks == sbi->blocks_per_seg ||
+					!test_opt(sbi, DISABLE_CHECKPOINT))) {
 		__locate_dirty_segment(sbi, segno, PRE);
 		__remove_dirty_segment(sbi, segno, DIRTY);
 	} else if (valid_blocks < sbi->blocks_per_seg) {
@@ -2030,7 +2041,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			sbi->discard_blks--;
 
 		/* don't overwrite by SSR to keep node chain */
-		if (IS_NODESEG(se->type)) {
+		if (IS_NODESEG(se->type) &&
+				!test_opt(sbi, DISABLE_CHECKPOINT)) {
 			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
 				se->ckpt_valid_blocks++;
 		}
@@ -2052,6 +2064,20 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_bug_on(sbi, 1);
 			se->valid_blocks++;
 			del = 0;
+		} else if test_opt(sbi, DISABLE_CHECKPOINT) {
+			/* If checkpoints are off, we must not reuse data that
+			 * was used in the previous checkpoint. If it was used
+			 * before, we must track that to know how much space we
+			 * really have
+			 */
+			if (f2fs_test_bit(offset, se->ckpt_valid_map)) {
+				spin_lock(&sbi->stat_lock);
+				if (IS_DATASEG(se->type))
+					sbi->cpd.unusable_ssr_blocks[DATA]++;
+				else
+					sbi->cpd.unusable_ssr_blocks[NODE]++;
+				spin_unlock(&sbi->stat_lock);
+			}
 		}
 
 		if (f2fs_discard_en(sbi) &&
@@ -2341,7 +2367,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 		return SIT_I(sbi)->last_victim[ALLOC_NEXT];
 
 	/* find segments from 0 to reuse freed segments */
-	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
+	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE
+			|| test_opt(sbi, DISABLE_CHECKPOINT))
 		return 0;
 
 	return CURSEG_I(sbi, type)->segno;
@@ -2493,7 +2520,8 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
 					type == CURSEG_WARM_NODE)
 		new_curseg(sbi, type, false);
-	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
+	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type) &&
+			!test_opt(sbi, DISABLE_CHECKPOINT))
 		new_curseg(sbi, type, false);
 	else if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
 		change_curseg(sbi, type);
@@ -3684,6 +3712,11 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			sit_i->dirty_sentries--;
 			ses->entry_cnt--;
 		}
+		spin_lock(&sbi->stat_lock);
+		sbi->cpd.unusable_block_count = 0;
+		sbi->cpd.unusable_ssr_blocks[DATA] = 0;
+		sbi->cpd.unusable_ssr_blocks[NODE] = 0;
+		spin_unlock(&sbi->stat_lock);
 
 		if (to_journal)
 			up_write(&curseg->journal_rwsem);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b3d9e317ff0c1..422b0ceb1eaaf 100644
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
index 53d70b64fea1a..1ecb87e7e4636 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -138,6 +138,7 @@ enum {
 	Opt_alloc,
 	Opt_fsync,
 	Opt_test_dummy_encryption,
+	Opt_checkpoint,
 	Opt_err,
 };
 
@@ -196,6 +197,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
+	{Opt_checkpoint, "checkpoint=%s"},
 	{Opt_err, NULL},
 };
 
@@ -776,6 +778,23 @@ static int parse_options(struct super_block *sb, char *options)
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
@@ -834,6 +853,12 @@ static int parse_options(struct super_block *sb, char *options)
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
@@ -1021,8 +1046,9 @@ static void f2fs_put_super(struct super_block *sb)
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
@@ -1032,7 +1058,8 @@ static void f2fs_put_super(struct super_block *sb)
 	/* be sure to wait for any on-going discard commands */
 	dropped = f2fs_wait_discard_bios(sbi);
 
-	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped) {
+	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped &&
+			!test_opt(sbi, DISABLE_CHECKPOINT)) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
@@ -1093,6 +1120,8 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return 0;
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		return 0;
 
 	trace_f2fs_sync_fs(sb, sync);
 
@@ -1191,7 +1220,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
-						sbi->current_reserved_blocks;
+						sbi->current_reserved_blocks -
+						sbi->cpd.unusable_block_count;
 	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
 		buf->f_bavail = buf->f_bfree -
 				F2FS_OPTION(sbi).root_reserved_blocks;
@@ -1370,6 +1400,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
 		seq_printf(seq, ",alloc_mode=%s", "reuse");
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
+		seq_puts(seq, ",checkpoint=disable");
+
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
@@ -1397,6 +1430,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, INLINE_DENTRY);
 	set_opt(sbi, EXTENT_CACHE);
 	set_opt(sbi, NOHEAP);
+	clear_opt(sbi, DISABLE_CHECKPOINT);
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
 	if (blk_queue_discard(bdev_get_queue(sbi->sb->s_bdev)))
@@ -1419,6 +1453,61 @@ static void default_options(struct f2fs_sb_info *sbi)
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
+	clear_opt(sbi, DISABLE_CHECKPOINT);
+	f2fs_gc(sbi, false, false, NULL_SEGNO);
+	f2fs_write_checkpoint(sbi, &cpc);
+	set_opt(sbi, DISABLE_CHECKPOINT);
+
+	mutex_lock(&dirty_i->seglist_lock);
+	for (type = 0; type < NR_CURSEG_TYPE; type++) {
+		for_each_set_bit(segno, dirty_i->dirty_segmap[type],
+							MAIN_SEGS(sbi)) {
+			sbi->cpd.free_ssr_blocks[
+				IS_DATASEG(type) ? DATA : NODE] +=
+					sbi->blocks_per_seg -
+					get_valid_blocks(sbi, segno, false);
+		}
+	}
+	sbi->cpd.free_segments = FREE_I(sbi)->free_segments;
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
+	sbi->cpd.free_segments = 0;
+	sbi->cpd.free_ssr_blocks[DATA] = 0;
+	sbi->cpd.free_ssr_blocks[NODE] = 0;
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
@@ -1428,6 +1517,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
+	bool disable_checkpoint = test_opt(sbi, DISABLE_CHECKPOINT);
+	bool checkpoint_changed;
 #ifdef CONFIG_QUOTA
 	int i, j;
 #endif
@@ -1472,6 +1563,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	err = parse_options(sb, data);
 	if (err)
 		goto restore_opts;
+	checkpoint_changed =
+			disable_checkpoint != test_opt(sbi, DISABLE_CHECKPOINT);
 
 	/*
 	 * Previous and new state of filesystem is RO,
@@ -1505,6 +1598,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -1533,6 +1633,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -3019,7 +3126,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_meta;
 
 	/* recover fsynced data */
-	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
+	if (!test_opt(sbi, DISABLE_ROLL_FORWARD) &&
+			!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 		/*
 		 * mount should be failed, when device has readonly mode, and
 		 * previous checkpoint was not done by clean system shutdown.
@@ -3085,6 +3193,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
2.18.0.865.gffc8e1a3cd6-goog

