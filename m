Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754447AbeAaXFu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:05:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60126 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeAaXFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:05:44 -0500
From: daniel.m.jordan@oracle.com
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
Subject: [RFC PATCH v1 12/13] mm: split up release_pages into non-sentinel and sentinel passes
Date: Wed, 31 Jan 2018 18:04:12 -0500
Message-Id: <20180131230413.27653-13-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310283
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common case in release_pages is for the 'pages' list to be in roughly
the same order as they are in their LRU.  With LRU batch locking, when a
sentinel page is removed, an adjacent non-sentinel page must be promoted
to a sentinel page to follow the locking scheme.  So we can get behavior
where nearly every page in the 'pages' array is treated as a sentinel
page, hurting the scalability of this approach.

To address this, split up release_pages into non-sentinel and sentinel
passes so that the non-sentinel pages can be locked with an LRU batch
lock before the sentinel pages are removed.

For the prototype, just use a bitmap and a temporary outer loop to
implement this.

Performance numbers from a single microbenchmark at this point in the
series are included in the next patch.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/swap.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index fae766e035a4..a302224293ad 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -731,6 +731,7 @@ void lru_add_drain_all(void)
 	put_online_cpus();
 }
 
+#define LRU_BITMAP_SIZE	512
 /**
  * release_pages - batched put_page()
  * @pages: array of pages to release
@@ -742,16 +743,32 @@ void lru_add_drain_all(void)
  */
 void release_pages(struct page **pages, int nr)
 {
-	int i;
+	int h, i;
 	LIST_HEAD(pages_to_free);
 	struct pglist_data *locked_pgdat = NULL;
 	spinlock_t *locked_lru_batch = NULL;
 	struct lruvec *lruvec;
 	unsigned long uninitialized_var(flags);
+	DECLARE_BITMAP(lru_bitmap, LRU_BITMAP_SIZE);
+
+	VM_BUG_ON(nr > LRU_BITMAP_SIZE);
 
+	bitmap_zero(lru_bitmap, nr);
+
+	for (h = 0; h < 2; h++) {
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
 
+		if (h == 0) {
+			if (PageLRU(page) && page->lru_sentinel) {
+				bitmap_set(lru_bitmap, i, 1);
+				continue;
+			}
+		} else {
+			if (!test_bit(i, lru_bitmap))
+				continue;
+		}
+
 		if (is_huge_zero_page(page))
 			continue;
 
@@ -798,6 +815,7 @@ void release_pages(struct page **pages, int nr)
 
 		list_add(&page->lru, &pages_to_free);
 	}
+	}
 	if (locked_lru_batch) {
 		lru_batch_unlock(NULL, &locked_lru_batch, &locked_pgdat,
 				 &flags);
-- 
2.16.1
