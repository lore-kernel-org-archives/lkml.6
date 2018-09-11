Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448E9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080BC206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080BC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeIKKeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:34:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:62537 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeIKKeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:34:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 22:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="262426326"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2018 22:36:26 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Yosef Lev <levyossi@icloud.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [RFC PATCH 3/9] mm: introduce smp_list_splice to prepare for concurrent LRU adds
Date:   Tue, 11 Sep 2018 13:36:10 +0800
Message-Id: <20180911053616.6894-4-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911053616.6894-1-aaron.lu@intel.com>
References: <20180911053616.6894-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

Now that we splice a local list onto the LRU, prepare for multiple tasks
doing this concurrently by adding a variant of the kernel's list
splicing API, list_splice, that's designed to work with multiple tasks.

Although there is naturally less parallelism to be gained from locking
the LRU head this way, the main benefit of doing this is to allow
removals to happen concurrently.  The way lru_lock is today, an add
needlessly blocks removal of any page but the first in the LRU.

For now, hold lru_lock as writer to serialize the adds to ensure the
function is correct for a single thread at a time.

Yosef Lev came up with this algorithm.

[aaronlu: drop LRU related code, keep only list related code]
Suggested-by: Yosef Lev <levyossi@icloud.com>
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/list.h |  1 +
 lib/list.c           | 60 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 0fd9c87dd14b..5f203fb55939 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -48,6 +48,7 @@ static inline bool __list_del_entry_valid(struct list_head *entry)
 #endif
 
 extern void smp_list_del(struct list_head *entry);
+extern void smp_list_splice(struct list_head *list, struct list_head *head);
 
 /*
  * Insert a new entry between two known consecutive entries.
diff --git a/lib/list.c b/lib/list.c
index 4d0949ea1a09..104faa144abf 100644
--- a/lib/list.c
+++ b/lib/list.c
@@ -10,17 +10,18 @@
 #include <linux/prefetch.h>
 
 /*
- * smp_list_del is a variant of list_del that allows concurrent list removals
- * under certain assumptions.  The idea is to get away from overly coarse
- * synchronization, such as using a lock to guard an entire list, which
- * serializes all operations even though those operations might be happening on
- * disjoint parts.
+ * smp_list_del and smp_list_splice are variants of list_del and list_splice,
+ * respectively, that allow concurrent list operations under certain
+ * assumptions.  The idea is to get away from overly coarse synchronization,
+ * such as using a lock to guard an entire list, which serializes all
+ * operations even though those operations might be happening on disjoint
+ * parts.
  *
  * If you want to use other functions from the list API concurrently,
  * additional synchronization may be necessary.  For example, you could use a
  * rwlock as a two-mode lock, where readers use the lock in shared mode and are
- * allowed to call smp_list_del concurrently, and writers use the lock in
- * exclusive mode and are allowed to use all list operations.
+ * allowed to call smp_list_* functions concurrently, and writers use the lock
+ * in exclusive mode and are allowed to use all list operations.
  */
 
 /**
@@ -156,3 +157,48 @@ void smp_list_del(struct list_head *entry)
 	entry->next = LIST_POISON1;
 	entry->prev = LIST_POISON2;
 }
+
+/**
+ * smp_list_splice - thread-safe splice of two lists
+ * @list: the new list to add
+ * @head: the place to add it in the first list
+ *
+ * Safely handles concurrent smp_list_splice operations onto the same list head
+ * and concurrent smp_list_del operations of any list entry except @head.
+ * Assumes that @head cannot be removed.
+ */
+void smp_list_splice(struct list_head *list, struct list_head *head)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *succ;
+
+	/*
+	 * Lock the front of @head by replacing its next pointer with NULL.
+	 * Should another thread be adding to the front, wait until it's done.
+	 */
+	succ = READ_ONCE(head->next);
+	while (succ == NULL || cmpxchg(&head->next, succ, NULL) != succ) {
+		cpu_relax();
+		succ = READ_ONCE(head->next);
+	}
+
+	first->prev = head;
+	last->next = succ;
+
+	/*
+	 * It is safe to write to succ, head's successor, because locking head
+	 * prevents succ from being removed in smp_list_del.
+	 */
+	succ->prev = last;
+
+	/*
+	 * Pairs with the implied full barrier before the cmpxchg above.
+	 * Ensures the write that unlocks the head is seen last to avoid list
+	 * corruption.
+	 */
+	smp_wmb();
+
+	/* Simultaneously complete the splice and unlock the head node. */
+	WRITE_ONCE(head->next, first);
+}
-- 
2.17.1

