Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE62C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AADD22BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIU2yzGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AADD22BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeGFVJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeGFVJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:09:07 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D919822BEA;
        Fri,  6 Jul 2018 21:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530911346;
        bh=MYNLPu2cKVTTWFRNo5fRkef+J8W8zoqn8xPKUYIB8is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIU2yzGyqCTPxGh3DANMRWDdqlWa6T+FMqz3Ucyu7zdPtqlXQA2xVRCbJQnS5asj4
         ajH+EwJ0YEfKeRW9WMwaaWOPjIV2A8yuPTiK9xjZGySW/bvVop2lkdovEzYGOHZZlp
         JKZ6dfXb66P8/TRInbN1ty8WpXYkLZjY7bSkB9Pw=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: indicate shutdown f2fs to allow unmount successfully
Date:   Fri,  6 Jul 2018 14:09:02 -0700
Message-Id: <20180706210903.77887-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180706210903.77887-1-jaegeuk@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we shutdown f2fs, we have to flush stale pages in order to unmount
the system. In order to make stable, we need to stop fault injection as well.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/data.c       |  4 ++++
 fs/f2fs/f2fs.h       |  7 +++++++
 fs/f2fs/file.c       |  4 ++++
 fs/f2fs/inode.c      |  3 +++
 fs/f2fs/node.c       | 11 +++++++++--
 fs/f2fs/super.c      |  5 +----
 7 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ee10b40309a1..8b698bd54490 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -28,6 +28,7 @@ struct kmem_cache *f2fs_inode_entry_slab;
 
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
+	f2fs_build_fault_attr(sbi, 0);
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e8e78bb64a7..c3f9b9baf140 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1829,6 +1829,10 @@ static int __write_data_page(struct page *page, bool *submitted,
 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(page->mapping, -EIO);
+
+		if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
+			goto out;
+
 		/*
 		 * don't drop any dirty dentry pages for keeping lastest
 		 * directory structure.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3cde41fb40a1..cc1ad4c8103c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1069,6 +1069,7 @@ enum {
 	SBI_POR_DOING,				/* recovery is doing or not */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
+	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
 };
 
 enum {
@@ -3398,4 +3399,10 @@ static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
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
index e8dfda4b4fcb..5e29d4053748 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1902,6 +1902,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		}
 		if (sb) {
 			f2fs_stop_checkpoint(sbi, false);
+			set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 			thaw_bdev(sb->s_bdev, sb);
 		}
 		break;
@@ -1911,13 +1912,16 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
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
index 4c5e354a572c..8211f5c288a1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -160,6 +160,9 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
 
+	if (unlikely(is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)))
+		return true;
+
 #ifdef CONFIG_F2FS_CHECK_FS
 	if (!f2fs_enable_inode_chksum(sbi, page))
 #else
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0f076fb0d828..7293ea65f343 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1150,7 +1150,8 @@ static int read_node_page(struct page *page, int op_flags)
 
 	f2fs_get_node_info(sbi, page->index, &ni);
 
-	if (unlikely(ni.blk_addr == NULL_ADDR)) {
+	if (unlikely(ni.blk_addr == NULL_ADDR) ||
+			is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
 		ClearPageUptodate(page);
 		return -ENOENT;
 	}
@@ -1372,8 +1373,14 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 
 	trace_f2fs_writepage(page, NODE);
 
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
+			dec_page_count(sbi, F2FS_DIRTY_NODES);
+			unlock_page(page);
+			return 0;
+		}
 		goto redirty_out;
+	}
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 383e3bff7c22..5562ff05c14e 100644
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
 
@@ -1380,9 +1379,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, POSIX_ACL);
 #endif
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	f2fs_build_fault_attr(sbi, 0);
-#endif
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.17.0.441.gb46fe60e1d-goog

