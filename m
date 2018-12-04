Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BA9C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CCB2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CCB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLDCFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 21:05:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16075 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbeLDCFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 21:05:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 08819696980F0;
        Tue,  4 Dec 2018 10:05:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Tue, 4 Dec 2018
 10:05:33 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <phillip@squashfs.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang in mem alloc
Date:   Tue, 4 Dec 2018 10:08:40 +0800
Message-ID: <20181204020840.49576-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to disable __GFP_FS in ->readpage:
* It's a read-only fs, so there will be no dirty/writeback page and
  there will be no deadlock against the caller's locked page
* It just allocates one page, so compaction will not be invoked
* It doesn't take any inode lock, so the reclamation of inode will be fine

And no __GFP_FS may lead to hang in __alloc_pages_slowpath() if a
squashfs page fault occurs in the context of a memory hogger, because
the hogger will not be killed due to the logic in __alloc_pages_may_oom().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/squashfs/file.c          |  3 ++-
 fs/squashfs/file_direct.c   |  4 +++-
 fs/squashfs/squashfs_fs_f.h | 25 +++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 fs/squashfs/squashfs_fs_f.h

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index f1c1430ae721..8603dda4a719 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -51,6 +51,7 @@
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
+#include "squashfs_fs_f.h"
 #include "squashfs.h"
 
 /*
@@ -414,7 +415,7 @@ void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
 		TRACE("bytes %d, i %d, available_bytes %d\n", bytes, i, avail);
 
 		push_page = (i == page->index) ? page :
-			grab_cache_page_nowait(page->mapping, i);
+			squashfs_grab_cache_page_nowait(page->mapping, i);
 
 		if (!push_page)
 			continue;
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 80db1b86a27c..a0fdd6215348 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -17,6 +17,7 @@
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
+#include "squashfs_fs_f.h"
 #include "squashfs.h"
 #include "page_actor.h"
 
@@ -60,7 +61,8 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	/* Try to grab all the pages covered by the Squashfs block */
 	for (missing_pages = 0, i = 0, n = start_index; i < pages; i++, n++) {
 		page[i] = (n == target_page->index) ? target_page :
-			grab_cache_page_nowait(target_page->mapping, n);
+			squashfs_grab_cache_page_nowait(
+					target_page->mapping, n);
 
 		if (page[i] == NULL) {
 			missing_pages++;
diff --git a/fs/squashfs/squashfs_fs_f.h b/fs/squashfs/squashfs_fs_f.h
new file mode 100644
index 000000000000..fc5fb7aeb27d
--- /dev/null
+++ b/fs/squashfs/squashfs_fs_f.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef SQUASHFS_FS_F
+#define SQUASHFS_FS_F
+
+/*
+ * No need to use FGP_NOFS here:
+ * 1. It's a read-only fs, so there will be no dirty/writeback page and
+ *    there will be no deadlock against the caller's locked page.
+ * 2. It just allocates one page, so compaction will not be invoked.
+ * 3. It doesn't take any inode lock, so the reclamation of inode
+ *    will be fine.
+ *
+ * And GFP_NOFS may lead to infinite loop in __alloc_pages_slowpath() if a
+ * squashfs page fault occurs in the context of a memory hogger, because
+ * the hogger will not be killed due to the logic in __alloc_pages_may_oom().
+ */
+static inline struct page *
+squashfs_grab_cache_page_nowait(struct address_space *mapping, pgoff_t index)
+{
+	return pagecache_get_page(mapping, index,
+			FGP_LOCK|FGP_CREAT|FGP_NOWAIT,
+			mapping_gfp_mask(mapping));
+}
+#endif
+
-- 
2.16.2.dirty

