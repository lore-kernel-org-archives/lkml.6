Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE4E2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfAGNDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:03:08 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:37102 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbfAGNDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 8F9B21844B;
        Mon,  7 Jan 2019 14:03:01 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id RbzXBgy2OCTx; Mon,  7 Jan 2019 14:03:00 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 2C43C18351;
        Mon,  7 Jan 2019 14:03:00 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 145381A065;
        Mon,  7 Jan 2019 14:03:00 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07D8E1A064;
        Mon,  7 Jan 2019 14:03:00 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Mon,  7 Jan 2019 14:02:59 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id EF72B1C75;
        Mon,  7 Jan 2019 14:02:59 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id EB0458017A; Mon,  7 Jan 2019 14:02:59 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] drop_caches: Allow unmapping pages
Date:   Mon,  7 Jan 2019 14:02:39 +0100
Message-Id: <20190107130239.3417-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop_caches does not drop pages which are currently mapped.  Add an
option to try to unmap and drop even these pages.  This provides a
simple way to obtain a rough estimate of how many file pages are used in
a particular use case: drop everything and check how much gets read
back.

 # cat /proc/meminfo | grep file
 Active(file):      16608 kB
 Inactive(file):    23424 kB
 # echo 3 > /proc/sys/vm/drop_caches && cat /proc/meminfo | grep file
 Active(file):      10624 kB
 Inactive(file):    15060 kB
 # echo 11 > /proc/sys/vm/drop_caches && cat /proc/meminfo | grep file
 Active(file):        240 kB
 Inactive(file):     2344 kB

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 Documentation/sysctl/vm.txt |  4 ++++
 fs/drop_caches.c            |  3 ++-
 include/linux/fs.h          | 10 ++++++++--
 kernel/sysctl.c             |  4 ++--
 mm/truncate.c               | 39 ++++++++++++++++++++++++-------------
 5 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 187ce4f599a2..6ea06c2c973b 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -222,6 +222,10 @@ To increase the number of objects freed by this operation, the user may run
 number of dirty objects on the system and create more candidates to be
 dropped.
 
+By default, pages which are currently mapped are not dropped from the
+pagecache.  If you want to unmap and drop these pages too, echo 9 or 11 instead
+of 1 or 3 respectively (set bit 4).
+
 This file is not a means to control the growth of the various kernel caches
 (inodes, dentries, pagecache, etc...)  These objects are automatically
 reclaimed by the kernel when memory is needed elsewhere on the system.
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 82377017130f..9faaa1e3a672 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -17,6 +17,7 @@ int sysctl_drop_caches;
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
+	bool unmap = sysctl_drop_caches & 8;
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
@@ -30,7 +31,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
-		invalidate_mapping_pages(inode->i_mapping, 0, -1);
+		__invalidate_mapping_pages(inode->i_mapping, 0, -1, unmap);
 		iput(toput_inode);
 		toput_inode = inode;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 811c77743dad..503e176654ce 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2675,8 +2675,14 @@ extern int check_disk_change(struct block_device *);
 extern int __invalidate_device(struct block_device *, bool);
 extern int invalidate_partition(struct gendisk *, int);
 #endif
-unsigned long invalidate_mapping_pages(struct address_space *mapping,
-					pgoff_t start, pgoff_t end);
+unsigned long __invalidate_mapping_pages(struct address_space *mapping,
+					pgoff_t start, pgoff_t end, bool unmap);
+
+static inline unsigned long invalidate_mapping_pages(struct address_space *mapping,
+						     pgoff_t start, pgoff_t end)
+{
+	return __invalidate_mapping_pages(mapping, start, end, false);
+}
 
 static inline void invalidate_remote_inode(struct inode *inode)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..f12c2a8d84fb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -125,7 +125,7 @@ static int __maybe_unused neg_one = -1;
 static int zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
-static int __maybe_unused four = 4;
+static int __maybe_unused fifteen = 15;
 static unsigned long one_ul = 1;
 static int one_hundred = 100;
 static int one_thousand = 1000;
@@ -1431,7 +1431,7 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= drop_caches_sysctl_handler,
 		.extra1		= &one,
-		.extra2		= &four,
+		.extra2		= &fifteen,
 	},
 #ifdef CONFIG_COMPACTION
 	{
diff --git a/mm/truncate.c b/mm/truncate.c
index 798e7ccfb030..613b02e02146 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -245,6 +245,22 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page)
 }
 EXPORT_SYMBOL(generic_error_remove_page);
 
+static int __invalidate_inode_page(struct page *page, bool unmap)
+{
+	struct address_space *mapping = page_mapping(page);
+	if (!mapping)
+		return 0;
+	if (PageDirty(page) || PageWriteback(page))
+		return 0;
+	if (page_mapped(page)) {
+		if (!unmap)
+			return 0;
+		if (!try_to_unmap(page, TTU_IGNORE_ACCESS))
+			return 0;
+	}
+	return invalidate_complete_page(mapping, page);
+}
+
 /*
  * Safely invalidate one page from its pagecache mapping.
  * It only drops clean, unused pages. The page must be locked.
@@ -253,16 +269,10 @@ EXPORT_SYMBOL(generic_error_remove_page);
  */
 int invalidate_inode_page(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
-	if (!mapping)
-		return 0;
-	if (PageDirty(page) || PageWriteback(page))
-		return 0;
-	if (page_mapped(page))
-		return 0;
-	return invalidate_complete_page(mapping, page);
+	return __invalidate_inode_page(page, false);
 }
 
+
 /**
  * truncate_inode_pages_range - truncate range of pages specified by start & end byte offsets
  * @mapping: mapping to truncate
@@ -532,16 +542,17 @@ EXPORT_SYMBOL(truncate_inode_pages_final);
  * @mapping: the address_space which holds the pages to invalidate
  * @start: the offset 'from' which to invalidate
  * @end: the offset 'to' which to invalidate (inclusive)
+ * @unmap: try to unmap pages
  *
  * This function only removes the unlocked pages, if you want to
  * remove all the pages of one inode, you must call truncate_inode_pages.
  *
  * invalidate_mapping_pages() will not block on IO activity. It will not
- * invalidate pages which are dirty, locked, under writeback or mapped into
- * pagetables.
+ * invalidate pages which are dirty, locked, under writeback or, if unmap is
+ * false, mapped into pagetables.
  */
-unsigned long invalidate_mapping_pages(struct address_space *mapping,
-		pgoff_t start, pgoff_t end)
+unsigned long __invalidate_mapping_pages(struct address_space *mapping,
+		pgoff_t start, pgoff_t end, bool unmap)
 {
 	pgoff_t indices[PAGEVEC_SIZE];
 	struct pagevec pvec;
@@ -591,7 +602,7 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 				}
 			}
 
-			ret = invalidate_inode_page(page);
+			ret = __invalidate_inode_page(page, unmap);
 			unlock_page(page);
 			/*
 			 * Invalidation is a hint that the page is no longer
@@ -608,7 +619,7 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 	}
 	return count;
 }
-EXPORT_SYMBOL(invalidate_mapping_pages);
+EXPORT_SYMBOL(__invalidate_mapping_pages);
 
 /*
  * This is like invalidate_complete_page(), except it ignores the page's
-- 
2.20.0

