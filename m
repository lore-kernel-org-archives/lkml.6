Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeAaXPA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:15:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51796 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeAaXEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:04:37 -0500
From: daniel.m.jordan@oracle.com
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
Subject: [RFC PATCH v1 06/13] mm: add lru_[un]lock_all APIs
Date: Wed, 31 Jan 2018 18:04:06 -0500
Message-Id: <20180131230413.27653-7-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=958
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310283
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add heavy locking API's for the few cases that a thread needs exclusive
access to an LRU list.  This locks lru_lock as well as every lock in
lru_batch_locks.

This API will be used often at first, in scaffolding code, to ease the
transition from using lru_lock to the batch locking scheme.  Later it
will be rarely needed.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/mm_inline.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ec8b966a1c76..1f1657c75b1b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -178,6 +178,38 @@ static __always_inline void move_page_to_lru_list_tail(struct page *page,
 	__add_page_to_lru_list_tail(page, lruvec, lru);
 }
 
+static __always_inline void lru_lock_all(struct pglist_data *pgdat,
+					 unsigned long *flags)
+{
+	size_t i;
+
+	if (flags)
+		local_irq_save(*flags);
+	else
+		local_irq_disable();
+
+	for (i = 0; i < NUM_LRU_BATCH_LOCKS; ++i)
+		spin_lock(&pgdat->lru_batch_locks[i].lock);
+
+	spin_lock(&pgdat->lru_lock);
+}
+
+static __always_inline void lru_unlock_all(struct pglist_data *pgdat,
+					   unsigned long *flags)
+{
+	int i;
+
+	spin_unlock(&pgdat->lru_lock);
+
+	for (i = NUM_LRU_BATCH_LOCKS - 1; i >= 0; --i)
+		spin_unlock(&pgdat->lru_batch_locks[i].lock);
+
+	if (flags)
+		local_irq_restore(*flags);
+	else
+		local_irq_enable();
+}
+
 /**
  * page_lru_base_type - which LRU list type should a page be on?
  * @page: the page to test
-- 
2.16.1
