Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98740ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F5B208D4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0dfPdeYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F5B208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbeGOBcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 21:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731952AbeGOBcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 21:32:23 -0400
Received: from localhost (unknown [104.132.152.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C679208CE;
        Sun, 15 Jul 2018 01:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531617084;
        bh=Xl8Grt0KL7jQZ69Uclmuu5P9egkDbiQez39+rg1g5tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dfPdeYHitZrtEKoijLOFsBbpJUvxpP3X93E5fNLElvS8OAvbA6GG4owxr6aZMO+6
         ESLo3e/0CI9/NdA/gCOlXP2W43MHF9WCwrf+xM6GEJbkdu0+d4Lrn86dcZeUR3+q0H
         Hlbz0FATR5d2NwasMUX/Jk74SyQS70rr3pp86psc=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: indicate shutdown f2fs to allow unmount successfully
Date:   Sun, 15 Jul 2018 10:11:12 +0900
Message-Id: <20180715011112.11475-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180715011112.11475-1-jaegeuk@kernel.org>
References: <20180715011112.11475-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we shutdown f2fs, we have to flush stale pages in order to unmount
the system. In order to make stable, we need to stop fault injection as well.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 1 +
 fs/f2fs/f2fs.h       | 7 +++++++
 fs/f2fs/file.c       | 4 ++++
 fs/f2fs/inode.c      | 3 +++
 fs/f2fs/node.c       | 3 ++-
 fs/f2fs/super.c      | 5 +----
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 37ec0f16448e..3837fd6505f4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -28,6 +28,7 @@ struct kmem_cache *f2fs_inode_entry_slab;
 
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
+	f2fs_build_fault_attr(sbi, 0);
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1d5c8d543eda..a3a62600f0bc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1066,6 +1066,7 @@ enum {
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_DISABLE_ATOMIC_WRITE,		/* turn off atomic write */
+	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
 };
 
 enum {
@@ -3373,4 +3374,10 @@ static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
 			F2FS_I_SB(inode)->s_ndevs);
 }
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate);
+#else
+#define f2fs_build_fault_attr(sbi, rate)		do { } while (0)
+#endif
+
 #endif
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b029a4ed3bb0..e84c5288c60b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1893,6 +1893,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		}
 		if (sb) {
 			f2fs_stop_checkpoint(sbi, false);
+			set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 			thaw_bdev(sb->s_bdev, sb);
 		}
 		break;
@@ -1902,13 +1903,16 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		if (ret)
 			goto out;
 		f2fs_stop_checkpoint(sbi, false);
+		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
 		f2fs_stop_checkpoint(sbi, false);
+		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_METAFLUSH:
 		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
 		f2fs_stop_checkpoint(sbi, false);
+		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f121c864f4c0..f91dd017a65c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -159,6 +159,9 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)))
+		return true;
+
 	if (!f2fs_enable_inode_chksum(sbi, page) ||
 			PageDirty(page) || PageWriteback(page))
 		return true;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b0267d3823b4..1061dd18b09c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1146,7 +1146,8 @@ static int read_node_page(struct page *page, int op_flags)
 
 	f2fs_get_node_info(sbi, page->index, &ni);
 
-	if (unlikely(ni.blk_addr == NULL_ADDR)) {
+	if (unlikely(ni.blk_addr == NULL_ADDR) ||
+			is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
 		ClearPageUptodate(page);
 		return -ENOENT;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1dc6809fac38..1cb5d1e4fcfd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -57,8 +57,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_CHECKPOINT]	= "checkpoint error",
 };
 
-static void f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
-						unsigned int rate)
+void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate)
 {
 	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
@@ -1379,9 +1378,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, POSIX_ACL);
 #endif
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	f2fs_build_fault_attr(sbi, 0);
-#endif
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.17.0.441.gb46fe60e1d-goog

