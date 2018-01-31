Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755832AbeAaXMg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:12:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52692 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeAaXFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:05:22 -0500
From: daniel.m.jordan@oracle.com
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
Subject: [RFC PATCH v1 10/13] mm: add LRU batch lock API's
Date: Wed, 31 Jan 2018 18:04:10 -0500
Message-Id: <20180131230413.27653-11-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310283
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the LRU batch locking API's themselves.  This adds the final piece
of infrastructure necessary for locking batches on an LRU list.

The API's lock a specific page on the LRU list, taking only the
appropriate LRU batch lock for a non-sentinel page and taking the
node's/memcg's lru_lock in addition for a sentinel page.

These interfaces are designed for performance: they minimize the number
of times we needlessly drop and then reacquire the same lock(s) when
used in a loop.  They're difficult to use but will do for a prototype.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/mm_inline.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 1f1657c75b1b..11d9fcf93f2b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -210,6 +210,64 @@ static __always_inline void lru_unlock_all(struct pglist_data *pgdat,
 		local_irq_enable();
 }
 
+static __always_inline spinlock_t *page_lru_batch_lock(struct page *page)
+{
+	return &page_pgdat(page)->lru_batch_locks[page->lru_batch].lock;
+}
+
+/**
+ * lru_batch_lock - lock an LRU list batch
+ */
+static __always_inline void lru_batch_lock(struct page *page,
+					   spinlock_t **locked_lru_batch,
+					   struct pglist_data **locked_pgdat,
+					   unsigned long *flags)
+{
+	spinlock_t *lru_batch = page_lru_batch_lock(page);
+	struct pglist_data *pgdat = page_pgdat(page);
+
+	VM_BUG_ON(*locked_pgdat && !page->lru_sentinel);
+
+	if (lru_batch != *locked_lru_batch) {
+		VM_BUG_ON(*locked_pgdat);
+		VM_BUG_ON(*locked_lru_batch);
+		spin_lock_irqsave(lru_batch, *flags);
+		*locked_lru_batch = lru_batch;
+		if (page->lru_sentinel) {
+			spin_lock(&pgdat->lru_lock);
+			*locked_pgdat = pgdat;
+		}
+	} else if (!*locked_pgdat && page->lru_sentinel) {
+		spin_lock(&pgdat->lru_lock);
+		*locked_pgdat = pgdat;
+	}
+}
+
+/**
+ * lru_batch_unlock - unlock an LRU list batch
+ */
+static __always_inline void lru_batch_unlock(struct page *page,
+					     spinlock_t **locked_lru_batch,
+					     struct pglist_data **locked_pgdat,
+					     unsigned long *flags)
+{
+	spinlock_t *lru_batch = (page) ? page_lru_batch_lock(page) : NULL;
+
+	VM_BUG_ON(!*locked_lru_batch);
+
+	if (lru_batch != *locked_lru_batch) {
+		if (*locked_pgdat) {
+			spin_unlock(&(*locked_pgdat)->lru_lock);
+			*locked_pgdat = NULL;
+		}
+		spin_unlock_irqrestore(*locked_lru_batch, *flags);
+		*locked_lru_batch = NULL;
+	} else if (*locked_pgdat && !page->lru_sentinel) {
+		spin_unlock(&(*locked_pgdat)->lru_lock);
+		*locked_pgdat = NULL;
+	}
+}
+
 /**
  * page_lru_base_type - which LRU list type should a page be on?
  * @page: the page to test
-- 
2.16.1
