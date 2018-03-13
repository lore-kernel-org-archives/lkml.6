Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbeCMNnO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:43:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeCMN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:26:56 -0400
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: [PATCH v9 31/61] page cache: Convert filemap_range_has_page to XArray
Date: Tue, 13 Mar 2018 06:26:09 -0700
Message-Id: <20180313132639.17387-32-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313132639.17387-1-willy@infradead.org>
References: <20180313132639.17387-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Instead of calling find_get_pages_range() and putting any reference,
use xas_find() to iterate over any entries in the range, skipping the
shadow/swap entries.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/filemap.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 86c83014c909..9bc417913269 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -458,20 +458,30 @@ EXPORT_SYMBOL(filemap_flush);
 bool filemap_range_has_page(struct address_space *mapping,
 			   loff_t start_byte, loff_t end_byte)
 {
-	pgoff_t index = start_byte >> PAGE_SHIFT;
-	pgoff_t end = end_byte >> PAGE_SHIFT;
 	struct page *page;
+	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
+	pgoff_t max = end_byte >> PAGE_SHIFT;
 
 	if (end_byte < start_byte)
 		return false;
 
-	if (mapping->nrpages == 0)
-		return false;
+	rcu_read_lock();
+	do {
+		page = xas_find(&xas, max);
+		if (xas_retry(&xas, page))
+			continue;
+		/* Shadow entries don't count */
+		if (xa_is_value(page))
+			continue;
+		/*
+		 * We don't need to try to pin this page; we're about to
+		 * release the RCU lock anyway.  It is enough to know that
+		 * there was a page here recently.
+		 */
+	} while (0);
+	rcu_read_unlock();
 
-	if (!find_get_pages_range(mapping, &index, end, 1, &page))
-		return false;
-	put_page(page);
-	return true;
+	return page != NULL;
 }
 EXPORT_SYMBOL(filemap_range_has_page);
 
-- 
2.16.1
