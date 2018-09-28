Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5DBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E2220657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK0aF5dF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E2220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeI2ACN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbeI2ACM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:02:12 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55311206B7;
        Fri, 28 Sep 2018 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538156242;
        bh=0Y9gCKZfPErOXSGSuAgy9ma8A2lZP+u0CLGMb2JenXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK0aF5dF/yHu8R5hL5S2pWGocZGiQje7ik/r5Ij0gUU5mzcR3jG3wQjrmWWd5Xzzy
         Vpux530h1PYxfvzZafQrIAFQ4mnNFfiZ6x5nVefBtOYkMKT9h1fqfTjeNNHpTS/Yws
         zYpqT6uPLqmENvmwG3/HiFzFehkEF/TdXUf8/Ikc=
Date:   Fri, 28 Sep 2018 10:37:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
Message-ID: <20180928173721.GB64391@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180919223819.GA79681@jaegeuk-macbookpro.roam.corp.google.com>
 <157abebb-80e7-d32d-3102-69ddfc5892f2@huawei.com>
 <20180920214213.GD35918@jaegeuk-macbookpro.roam.corp.google.com>
 <0c98ab72-9bc4-093d-707f-9c59a38fc7c7@huawei.com>
 <20180926002909.GC3829@jaegeuk-macbookpro.roam.corp.google.com>
 <b45beb50-c814-5fb4-63da-060871e33553@huawei.com>
 <20180926014418.GE3829@jaegeuk-macbookpro.roam.corp.google.com>
 <e1e855e5-2aaf-6560-d69d-2b7b0f60404e@huawei.com>
 <20180926020921.GG3829@jaegeuk-macbookpro.roam.corp.google.com>
 <d4279226-ca5c-8905-f6e9-c660c3aad6a0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4279226-ca5c-8905-f6e9-c660c3aad6a0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27, Chao Yu wrote:
> On 2018/9/26 10:09, Jaegeuk Kim wrote:
> > Oh, yeah. :P
> > I started to run all my tests with this. Let me see what will happen.
> 
> Any updates of this test?

Not a good result. I'm trying to fix some bug in your patch.
Could you take a look at this?

---
 fs/f2fs/checkpoint.c |  8 ++++++++
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/gc.c         |  4 ++++
 fs/f2fs/super.c      | 12 +++++++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 524b87667cf4..b4b1586c683c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1494,6 +1494,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	unsigned long long ckpt_ver;
+	bool need_up = false;
 	int err = 0;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
@@ -1506,6 +1507,11 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		f2fs_msg(sbi->sb, KERN_WARNING,
 				"Start checkpoint disabled!");
 	}
+	if (!is_sbi_flag_set(sbi, SBI_IS_MOUNT) &&
+			!is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
+		need_up = true;
+		down_read(&sbi->sb->s_umount);
+	}
 	mutex_lock(&sbi->cp_mutex);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
@@ -1582,6 +1588,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
 out:
 	mutex_unlock(&sbi->cp_mutex);
+	if (need_up)
+		up_read(&sbi->sb->s_umount);
 	return err;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 57c829dd107e..461656aed78a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1089,6 +1089,7 @@ struct inode_management {
 enum {
 	SBI_IS_DIRTY,				/* dirty flag for checkpoint */
 	SBI_IS_CLOSE,				/* specify unmounting */
+	SBI_IS_MOUNT,				/* specify mounting */
 	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
 	SBI_POR_DOING,				/* recovery is doing or not */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index adaf5a695b12..ee6dbd72ad8a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -55,6 +55,9 @@ static int gc_thread_func(void *data)
 			f2fs_stop_checkpoint(sbi, false);
 		}
 
+		if (!down_read_trylock(&sbi->sb->s_umount))
+			continue;
+
 		if (!sb_start_write_trylock(sbi->sb))
 			continue;
 
@@ -104,6 +107,7 @@ static int gc_thread_func(void *data)
 		f2fs_balance_fs_bg(sbi);
 next:
 		sb_end_write(sbi->sb);
+		up_read(&sbi->sb->s_umount);
 
 	} while (!kthread_should_stop());
 	return 0;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1d89d5e9e829..603386525336 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1534,6 +1534,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 #endif
+	set_sbi_flag(sbi, SBI_IS_MOUNT);
 
 	/* recover superblocks we couldn't write due to previous RO mount */
 	if (!(*flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
@@ -1653,6 +1654,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
 	limit_reserve_root(sbi);
+	clear_sbi_flag(sbi, SBI_IS_MOUNT);
 	return 0;
 restore_gc:
 	if (need_restart_gc) {
@@ -1672,6 +1674,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 #endif
 	sbi->mount_opt = org_mount_opt;
 	sb->s_flags = old_sb_flags;
+	clear_sbi_flag(sbi, SBI_IS_MOUNT);
 	return err;
 }
 
@@ -1705,6 +1708,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 				congestion_wait(BLK_RW_ASYNC, HZ/50);
 				goto repeat;
 			}
+			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 			return PTR_ERR(page);
 		}
 
@@ -1716,6 +1720,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 		}
 		if (unlikely(!PageUptodate(page))) {
 			f2fs_put_page(page, 1);
+			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 			return -EIO;
 		}
 
@@ -1757,6 +1762,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 				congestion_wait(BLK_RW_ASYNC, HZ/50);
 				goto retry;
 			}
+			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 			break;
 		}
 
@@ -1793,7 +1799,6 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
 
 static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
 {
-
 	if (is_set_ckpt_flags(sbi, CP_QUOTA_NEED_FSCK_FLAG)) {
 		f2fs_msg(sbi->sb, KERN_ERR,
 			"quota sysfile may be corrupted, skip loading it");
@@ -3151,6 +3156,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
+	set_sbi_flag(sbi, SBI_IS_MOUNT);
+
 	err = init_percpu_info(sbi);
 	if (err)
 		goto free_bio_info;
@@ -3369,6 +3376,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 				cur_cp_version(F2FS_CKPT(sbi)));
 	f2fs_update_time(sbi, CP_TIME);
 	f2fs_update_time(sbi, REQ_TIME);
+
+	clear_sbi_flag(sbi, SBI_IS_MOUNT);
 	return 0;
 
 free_meta:
@@ -3433,6 +3442,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		shrink_dcache_sb(sb);
 		goto try_onemore;
 	}
+	clear_sbi_flag(sbi, SBI_IS_MOUNT);
 	return err;
 }
 
-- 
2.19.0.605.g01d371f741-goog

