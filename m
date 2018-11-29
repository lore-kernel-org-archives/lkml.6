Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65CF20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65CF20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeK2W3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:29:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:34024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbeK2W3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:29:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5752AAD65;
        Thu, 29 Nov 2018 11:24:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, david@redhat.com,
        linux-fsdevel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] fs: Don't opencode lru_to_page
Date:   Thu, 29 Nov 2018 12:48:10 +0200
Message-Id: <20181129104810.23361-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple filesystems opencode lru_to_page. Rectify this by moving the
macro from mm_inline (which is specific to lru stuff) to the more
generic mm.h header and start using the macro where appropriate.

No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lkml.kernel.org/r/20181129075301.29087-1-nborisov@suse.com
---

Hi Andrew, 

I believe mmotm is the best place for a patch like this so please take it. It 
already had a first incarnation where it was 2 patches and Michal suggested to 
squash it so here it is. 

Please take this patch
 fs/afs/file.c             | 5 +++--
 fs/btrfs/extent_io.c      | 2 +-
 fs/ceph/addr.c            | 5 ++---
 fs/cifs/file.c            | 3 ++-
 fs/ext4/readpage.c        | 2 +-
 fs/ocfs2/aops.c           | 3 ++-
 fs/orangefs/inode.c       | 2 +-
 include/linux/mm.h        | 2 ++
 include/linux/mm_inline.h | 3 ---
 mm/swap.c                 | 2 +-
 10 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index d6bc3f5d784b..323ae9912203 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -17,6 +17,7 @@
 #include <linux/writeback.h>
 #include <linux/gfp.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/mm.h>
 #include "internal.h"
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
@@ -441,7 +442,7 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	/* Count the number of contiguous pages at the front of the list.  Note
 	 * that the list goes prev-wards rather than next-wards.
 	 */
-	first = list_entry(pages->prev, struct page, lru);
+	first = lru_to_page(pages);
 	index = first->index + 1;
 	n = 1;
 	for (p = first->lru.prev; p != pages; p = p->prev) {
@@ -473,7 +474,7 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	 * page at the end of the file.
 	 */
 	do {
-		page = list_entry(pages->prev, struct page, lru);
+		page = lru_to_page(pages);
 		list_del(&page->lru);
 		index = page->index;
 		if (add_to_page_cache_lru(page, mapping, index,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 19f4b8fd654f..8332c5f4b1c3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4104,7 +4104,7 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 	u64 prev_em_start = (u64)-1;
 
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
-		page = list_entry(pages->prev, struct page, lru);
+		page = lru_to_page(pages);
 
 		prefetchw(&page->flags);
 		list_del(&page->lru);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8eade7a993c1..5d0c05e288cc 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -306,7 +306,7 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 	struct ceph_osd_client *osdc =
 		&ceph_inode_to_client(inode)->client->osdc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct page *page = list_entry(page_list->prev, struct page, lru);
+	struct page *page = lru_to_page(page_list);
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
 	u64 off;
@@ -333,8 +333,7 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 			if (got)
 				ceph_put_cap_refs(ci, got);
 			while (!list_empty(page_list)) {
-				page = list_entry(page_list->prev,
-						  struct page, lru);
+				page = lru_to_page(page_list);
 				list_del(&page->lru);
 				put_page(page);
 			}
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 74c33d5fafc8..b16a4d887d17 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -33,6 +33,7 @@
 #include <linux/mount.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+#include <linux/mm.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
@@ -3975,7 +3976,7 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
 
 	INIT_LIST_HEAD(tmplist);
 
-	page = list_entry(page_list->prev, struct page, lru);
+	page = lru_to_page(page_list);
 
 	/*
 	 * Lock the page and put it in the cache. Since no one else
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index f461d75ac049..6aa282ee455a 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -128,7 +128,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 
 		prefetchw(&page->flags);
 		if (pages) {
-			page = list_entry(pages->prev, struct page, lru);
+			page = lru_to_page(pages);
 			list_del(&page->lru);
 			if (add_to_page_cache_lru(page, mapping, page->index,
 				  readahead_gfp_mask(mapping)))
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index eb1ce30412dc..832c1759a09a 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -30,6 +30,7 @@
 #include <linux/quotaops.h>
 #include <linux/blkdev.h>
 #include <linux/uio.h>
+#include <linux/mm.h>
 
 #include <cluster/masklog.h>
 
@@ -397,7 +398,7 @@ static int ocfs2_readpages(struct file *filp, struct address_space *mapping,
 	 * Check whether a remote node truncated this file - we just
 	 * drop out in that case as it's not worth handling here.
 	 */
-	last = list_entry(pages->prev, struct page, lru);
+	last = lru_to_page(pages);
 	start = (loff_t)last->index << PAGE_SHIFT;
 	if (start >= i_size_read(inode))
 		goto out_unlock;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index fe53381b26b1..f038235c64bd 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -77,7 +77,7 @@ static int orangefs_readpages(struct file *file,
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page;
 
-		page = list_entry(pages->prev, struct page, lru);
+		page = lru_to_page(pages);
 		list_del(&page->lru);
 		if (!add_to_page_cache(page,
 				       mapping,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..47b4aa5bba93 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -146,6 +146,8 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
+#define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+
 /*
  * Linux kernel virtual memory manager primitives.
  * The idea being to have a "virtual" mm in the same way
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 10191c28fc04..04ec454d44ce 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -124,7 +124,4 @@ static __always_inline enum lru_list page_lru(struct page *page)
 	}
 	return lru;
 }
-
-#define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
-
 #endif
diff --git a/mm/swap.c b/mm/swap.c
index aa483719922e..20b9e9d99652 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -126,7 +126,7 @@ void put_pages_list(struct list_head *pages)
 	while (!list_empty(pages)) {
 		struct page *victim;
 
-		victim = list_entry(pages->prev, struct page, lru);
+		victim = lru_to_page(pages);
 		list_del(&victim->lru);
 		put_page(victim);
 	}
-- 
2.17.1

