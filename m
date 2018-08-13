Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A08C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D250621738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D250621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeHNAXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:23:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbeHNAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:23:35 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LfjTe-1gDsaT14yg-00pJgF; Mon, 13 Aug 2018 23:39:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yunlei He <heyunlei@huawei.com>,
        Sheng Yong <shengyong1@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: rework fault injection handling to avoid a warning
Date:   Mon, 13 Aug 2018 23:38:06 +0200
Message-Id: <20180813213909.3125189-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:diP2IcA7E12MclYIJgoa0rSKo2uR9wKAPQdoaspMvkO7cZr+6AI
 pNvoGJ+lTHoKj4LwH8k6+XrCWRkjjGz5Ezf/m9mgOMYWEXRrPfpy5y14i5ucSK732gLnrQn
 mTivVloZIGGd5MrA461+u/MorSYSPWvz39GgOdeP+Px1rmJDml/8GTvFosx6GUoaL/gDERw
 3Sl0qZGftPhu1VeXa7TOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gohXrnkntRU=:w9ZoYFb1BS4IJmJOSl58Dd
 YxnsCmSYdz+ys9ciLUVL3v29wp6Ce7ldZRcG6GStahNneEPWlZ6h/sgIuoCydh9Nhj7bvyAf6
 27WnIVv5iL/0G9xockGLmYeZx20FOAHHTZAhKxltwAceznY5A3uf7c0a6Atd4xy185X3Hr97G
 ERngQUSt6tgiYHqEswczhOp9TNviFoBca2ngn/5bk10YjTBq5DXJjl476P0veOG+OzwwEj9sh
 OEmL2nQ7JbwpMD+Yr/SOci/Q1AepX1Y7KSVjZm2JgwDi2VVG/VZUnAy4YBMEJghipqftNon3E
 zcrlnIXYGDm3eR0+/AM1t8cxALba3o2kVcxGhFMu2dgEQ6VmZJFei1AyNEFkoV0h/41nqWQUU
 1MSmyp8PhzBgRIBj3CLZOlEaUk0whrunTv8H/3/TpmWdHqLiHhsvMYI12Y55N4Wbz9QpZBfWK
 a4SbQUC02vllF/r8CQsbmIjJZJt1qMNKHxPk9TeALBoLGwb7yawliBMs6gFmyhYDcZ+jm+72e
 6hymC0aCFXB+j6H5yIvB/aQRI71TuKBubAKMaE1ly2hhsmrueODdppSiN5/n4YNiY+IGkmhK2
 9rPHZIqhy3cn4++dtBlehbkdvTe4nje8QppSXF6O2dm4ijwA3FlMMjnEzLuhCqtFiDBlLW6CS
 TvUrJDIV4WDniCsPjpyKtxYco6uMFN/PZCUof+iujPybVig6GvR/iJ15CDdlmE0q6Ap4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_F2FS_FAULT_INJECTION is disabled, we get a warning about an
unused label:

fs/f2fs/segment.c: In function '__submit_discard_cmd':
fs/f2fs/segment.c:1059:1: error: label 'submit' defined but not used [-Werror=unused-label]

This could be fixed by adding another #ifdef around it, but the more
reliable way of doing this seems to be to remove the other #ifdefs
where that is easily possible.

By defining time_to_inject() as a trivial stub, most of the checks for
CONFIG_F2FS_FAULT_INJECTION can go away. This also leads to nicer
formatting of the code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/checkpoint.c |  3 +--
 fs/f2fs/data.c       |  2 --
 fs/f2fs/dir.c        |  3 +--
 fs/f2fs/f2fs.h       | 50 ++++++++++++++++++++++----------------------
 fs/f2fs/file.c       |  3 +--
 fs/f2fs/gc.c         |  2 --
 fs/f2fs/inode.c      |  3 +--
 fs/f2fs/node.c       |  3 +--
 fs/f2fs/recovery.c   |  5 ++---
 fs/f2fs/segment.c    |  4 ----
 10 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3ab7a00c0641..e8b6b89bddb8 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -555,13 +555,12 @@ int f2fs_acquire_orphan_inode(struct f2fs_sb_info *sbi)
 
 	spin_lock(&im->ino_lock);
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_ORPHAN)) {
 		spin_unlock(&im->ino_lock);
 		f2fs_show_injection_info(FAULT_ORPHAN);
 		return -ENOSPC;
 	}
-#endif
+
 	if (unlikely(im->ino_num >= sbi->max_orphans))
 		err = -ENOSPC;
 	else
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 67dc5fd8d4d5..773f82bbb618 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -126,12 +126,10 @@ static bool f2fs_bio_post_read_required(struct bio *bio)
 
 static void f2fs_read_end_io(struct bio *bio)
 {
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)), FAULT_IO)) {
 		f2fs_show_injection_info(FAULT_IO);
 		bio->bi_status = BLK_STS_IOERR;
 	}
-#endif
 
 	if (f2fs_bio_post_read_required(bio)) {
 		struct bio_post_read_ctx *ctx = bio->bi_private;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9c2a23242f64..01006085904a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -517,12 +517,11 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 	}
 
 start:
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(F2FS_I_SB(dir), FAULT_DIR_DEPTH)) {
 		f2fs_show_injection_info(FAULT_DIR_DEPTH);
 		return -ENOSPC;
 	}
-#endif
+
 	if (unlikely(current_depth == MAX_DIR_HASH_DEPTH))
 		return -ENOSPC;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a8ae1c73d3b3..8d2086e2571b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -41,7 +41,6 @@
 	} while (0)
 #endif
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 enum {
 	FAULT_KMALLOC,
 	FAULT_KVMALLOC,
@@ -60,6 +59,7 @@ enum {
 	FAULT_MAX,
 };
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
 #define F2FS_ALL_FAULT_TYPE		((1 << FAULT_MAX) - 1)
 
 struct f2fs_fault_info {
@@ -1326,6 +1326,12 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 	}
 	return false;
 }
+#else
+#define f2fs_show_injection_info(type) do { } while (0)
+static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
+{
+	return false;
+}
 #endif
 
 /* For write statistics. Suppose sector size is 512 bytes,
@@ -1678,13 +1684,12 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_BLOCK)) {
 		f2fs_show_injection_info(FAULT_BLOCK);
 		release = *count;
 		goto enospc;
 	}
-#endif
+
 	/*
 	 * let's increase this in prior to actual block count change in order
 	 * for f2fs_sync_file to avoid data races when deciding checkpoint.
@@ -1893,12 +1898,10 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 			return ret;
 	}
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_BLOCK)) {
 		f2fs_show_injection_info(FAULT_BLOCK);
 		goto enospc;
 	}
-#endif
 
 	spin_lock(&sbi->stat_lock);
 
@@ -1983,22 +1986,23 @@ static inline s64 valid_inode_count(struct f2fs_sb_info *sbi)
 static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 						pgoff_t index, bool for_write)
 {
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	struct page *page;
 
-	if (!for_write)
-		page = find_get_page_flags(mapping, index,
-						FGP_LOCK | FGP_ACCESSED);
-	else
-		page = find_lock_page(mapping, index);
-	if (page)
-		return page;
+	if (IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION)) {
+		if (!for_write)
+			page = find_get_page_flags(mapping, index,
+							FGP_LOCK | FGP_ACCESSED);
+		else
+			page = find_lock_page(mapping, index);
+		if (page)
+			return page;
 
-	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC)) {
-		f2fs_show_injection_info(FAULT_PAGE_ALLOC);
-		return NULL;
+		if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC)) {
+			f2fs_show_injection_info(FAULT_PAGE_ALLOC);
+			return NULL;
+		}
 	}
-#endif
+
 	if (!for_write)
 		return grab_cache_page(mapping, index);
 	return grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
@@ -2008,12 +2012,11 @@ static inline struct page *f2fs_pagecache_get_page(
 				struct address_space *mapping, pgoff_t index,
 				int fgp_flags, gfp_t gfp_mask)
 {
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET)) {
 		f2fs_show_injection_info(FAULT_PAGE_GET);
 		return NULL;
 	}
-#endif
+
 	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
 }
 
@@ -2078,12 +2081,11 @@ static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
 			bio = bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
 		return bio;
 	}
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
 		f2fs_show_injection_info(FAULT_ALLOC_BIO);
 		return NULL;
 	}
-#endif
+
 	return bio_alloc(GFP_KERNEL, npages);
 }
 
@@ -2618,12 +2620,11 @@ static inline bool f2fs_may_extent_tree(struct inode *inode)
 static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_KMALLOC)) {
 		f2fs_show_injection_info(FAULT_KMALLOC);
 		return NULL;
 	}
-#endif
+
 	return kmalloc(size, flags);
 }
 
@@ -2636,12 +2637,11 @@ static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
 static inline void *f2fs_kvmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_KVMALLOC)) {
 		f2fs_show_injection_info(FAULT_KVMALLOC);
 		return NULL;
 	}
-#endif
+
 	return kvmalloc(size, flags);
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 560751adba01..6f14e7d16e9d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -668,12 +668,11 @@ int f2fs_truncate(struct inode *inode)
 
 	trace_f2fs_truncate(inode);
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
 		f2fs_show_injection_info(FAULT_TRUNCATE);
 		return -EIO;
 	}
-#endif
+
 	/* we should check inline_data size */
 	if (!f2fs_may_inline_data(inode)) {
 		err = f2fs_convert_inline_inode(inode);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 87a6b4675987..c598ae5ecbfa 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -53,12 +53,10 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 		if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
 			f2fs_show_injection_info(FAULT_CHECKPOINT);
 			f2fs_stop_checkpoint(sbi, false);
 		}
-#endif
 
 		if (!sb_start_write_trylock(sbi->sb))
 			continue;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index fc2c98b9e255..6908896a1950 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -659,12 +659,11 @@ void f2fs_evict_inode(struct inode *inode)
 	if (F2FS_HAS_BLOCKS(inode))
 		err = f2fs_truncate(inode);
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
 		f2fs_show_injection_info(FAULT_EVICT_INODE);
 		err = -EIO;
 	}
-#endif
+
 	if (!err) {
 		f2fs_lock_op(sbi);
 		err = f2fs_remove_inode_page(inode);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3c93f6cbc3cd..0bae5eda056a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2321,12 +2321,11 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
 retry:
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
 		f2fs_show_injection_info(FAULT_ALLOC_NID);
 		return false;
 	}
-#endif
+
 	spin_lock(&nm_i->nid_list_lock);
 
 	if (unlikely(nm_i->available_nids == 0)) {
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 64e5a59a270a..95511ed11a22 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -518,10 +518,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			if (src == NULL_ADDR) {
 				err = f2fs_reserve_new_block(&dn);
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-				while (err)
+				while (err &&
+				       IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
 					err = f2fs_reserve_new_block(&dn);
-#endif
 				/* We should not get -ENOSPC */
 				f2fs_bug_on(sbi, err);
 				if (err)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 43f127b48447..41769c77b7cc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -474,12 +474,10 @@ int f2fs_commit_inmem_pages(struct inode *inode)
  */
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
 		f2fs_show_injection_info(FAULT_CHECKPOINT);
 		f2fs_stop_checkpoint(sbi, false);
 	}
-#endif
 
 	/* balance_fs_bg is able to be pending */
 	if (need && excess_cached_nats(sbi))
@@ -1045,13 +1043,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		dc->len += len;
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
 			f2fs_show_injection_info(FAULT_DISCARD);
 			err = -EIO;
 			goto submit;
 		}
-#endif
 		err = __blkdev_issue_discard(bdev,
 					SECTOR_FROM_BLOCK(start),
 					SECTOR_FROM_BLOCK(len),
-- 
2.18.0

