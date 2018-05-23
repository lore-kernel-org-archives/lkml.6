Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933309AbeEWOZf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933284AbeEWOZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:25:22 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: detect synchronous writeback more earlier
Date: Wed, 23 May 2018 22:25:09 +0800
Message-Id: <20180523142509.17905-2-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
In-Reply-To: <20180523142509.17905-1-chao@kernel.org>
References: <20180523142509.17905-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patch changes to detect synchronous writeback more earlier before,
in order to avoid unnecessary page writeback before exiting asynchronous
writeback.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index feb4c224b305..91cbf20b448a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1919,6 +1919,13 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
 
+			/* give a priority to WB_SYNC threads */
+			if (atomic_read(&F2FS_M_SB(mapping)->wb_sync_req) &&
+					wbc->sync_mode == WB_SYNC_NONE) {
+				done = 1;
+				break;
+			}
+
 			done_index = page->index;
 retry_write:
 			lock_page(page);
@@ -1973,9 +1980,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				last_idx = page->index;
 			}
 
-			/* give a priority to WB_SYNC threads */
-			if ((atomic_read(&F2FS_M_SB(mapping)->wb_sync_req) ||
-					--wbc->nr_to_write <= 0) &&
+			if (--wbc->nr_to_write <= 0 &&
 					wbc->sync_mode == WB_SYNC_NONE) {
 				done = 1;
 				break;
-- 
2.16.2.17.g38e79b1fd
