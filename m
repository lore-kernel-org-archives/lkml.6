Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE822C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DC62086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DC62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeIKKeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:34:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:62518 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeIKKd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:33:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 22:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="262426318"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2018 22:36:23 -0700
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
Subject: [RFC PATCH 2/9] mm: introduce smp_list_del for concurrent list entry removals
Date:   Tue, 11 Sep 2018 13:36:09 +0800
Message-Id: <20180911053616.6894-3-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911053616.6894-1-aaron.lu@intel.com>
References: <20180911053616.6894-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

Now that the LRU lock is a RW lock, lay the groundwork for fine-grained
synchronization so that multiple threads holding the lock as reader can
safely remove pages from an LRU at the same time.

Add a thread-safe variant of list_del called smp_list_del that allows
multiple threads to delete nodes from a list, and wrap this new list API
in smp_del_page_from_lru to get the LRU statistics updates right.

For bisectability's sake, call the new function only when holding
lru_lock as writer.  In the next patch, switch to taking it as reader.

The algorithm is explained in detail in the comments.  Yosef Lev
conceived of the algorithm, and this patch is heavily based on an
earlier version from him.  Thanks to Dave Dice for suggesting the
prefetch.

[aaronlu: only take list related code here]
Signed-off-by: Yosef Lev <levyossi@icloud.com>
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/list.h |   2 +
 lib/Makefile         |   2 +-
 lib/list.c           | 158 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 lib/list.c

diff --git a/include/linux/list.h b/include/linux/list.h
index de04cc5ed536..0fd9c87dd14b 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -47,6 +47,8 @@ static inline bool __list_del_entry_valid(struct list_head *entry)
 }
 #endif
 
+extern void smp_list_del(struct list_head *entry);
+
 /*
  * Insert a new entry between two known consecutive entries.
  *
diff --git a/lib/Makefile b/lib/Makefile
index ca3f7ebb900d..9527b7484653 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -38,7 +38,7 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
 	 gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o reciprocal_div.o \
-	 once.o refcount.o usercopy.o errseq.o bucket_locks.o
+	 once.o refcount.o usercopy.o errseq.o bucket_locks.o list.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/list.c b/lib/list.c
new file mode 100644
index 000000000000..4d0949ea1a09
--- /dev/null
+++ b/lib/list.c
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2017, 2018 Oracle and/or its affiliates. All rights reserved.
+ *
+ * Authors: Yosef Lev <levyossi@icloud.com>
+ *          Daniel Jordan <daniel.m.jordan@oracle.com>
+ */
+
+#include <linux/list.h>
+#include <linux/prefetch.h>
+
+/*
+ * smp_list_del is a variant of list_del that allows concurrent list removals
+ * under certain assumptions.  The idea is to get away from overly coarse
+ * synchronization, such as using a lock to guard an entire list, which
+ * serializes all operations even though those operations might be happening on
+ * disjoint parts.
+ *
+ * If you want to use other functions from the list API concurrently,
+ * additional synchronization may be necessary.  For example, you could use a
+ * rwlock as a two-mode lock, where readers use the lock in shared mode and are
+ * allowed to call smp_list_del concurrently, and writers use the lock in
+ * exclusive mode and are allowed to use all list operations.
+ */
+
+/**
+ * smp_list_del - concurrent variant of list_del
+ * @entry: entry to delete from the list
+ *
+ * Safely removes an entry from the list in the presence of other threads that
+ * may try to remove adjacent entries.  Uses the entry's next field and the
+ * predecessor entry's next field as locks to accomplish this.
+ *
+ * Assumes that no two threads may try to delete the same entry.  This
+ * assumption holds, for example, if the objects on the list are
+ * reference-counted so that an object is only removed when its refcount falls
+ * to 0.
+ *
+ * @entry's next and prev fields are poisoned on return just as with list_del.
+ */
+void smp_list_del(struct list_head *entry)
+{
+	struct list_head *succ, *pred, *pred_reread;
+
+	/*
+	 * The predecessor entry's cacheline is read before it's written, so to
+	 * avoid an unnecessary cacheline state transition, prefetch for
+	 * writing.  In the common case, the predecessor won't change.
+	 */
+	prefetchw(entry->prev);
+
+	/*
+	 * Step 1: Lock @entry E by making its next field point to its
+	 * predecessor D.  This prevents any thread from removing the
+	 * predecessor because that thread will loop in its step 4 while
+	 * E->next == D.  This also prevents any thread from removing the
+	 * successor F because that thread will see that F->prev->next != F in
+	 * the cmpxchg in its step 3.  Retry if the successor is being removed
+	 * and has already set this field to NULL in step 3.
+	 */
+	succ = READ_ONCE(entry->next);
+	pred = READ_ONCE(entry->prev);
+	while (succ == NULL || cmpxchg(&entry->next, succ, pred) != succ) {
+		/*
+		 * Reread @entry's successor because it may change until
+		 * @entry's next field is locked.  Reread the predecessor to
+		 * have a better chance of publishing the right value and avoid
+		 * entering the loop in step 2 while @entry is locked,
+		 * but this isn't required for correctness because the
+		 * predecessor is reread in step 2.
+		 */
+		cpu_relax();
+		succ = READ_ONCE(entry->next);
+		pred = READ_ONCE(entry->prev);
+	}
+
+	/*
+	 * Step 2: A racing thread may remove @entry's predecessor.  Reread and
+	 * republish @entry->prev until it does not change.  This guarantees
+	 * that the racing thread has not passed the while loop in step 4 and
+	 * has not freed the predecessor, so it is safe for this thread to
+	 * access predecessor fields in step 3.
+	 */
+	pred_reread = READ_ONCE(entry->prev);
+	while (pred != pred_reread) {
+		WRITE_ONCE(entry->next, pred_reread);
+		pred = pred_reread;
+		/*
+		 * Ensure the predecessor is published in @entry's next field
+		 * before rereading the predecessor.  Pairs with the smp_mb in
+		 * step 4.
+		 */
+		smp_mb();
+		pred_reread = READ_ONCE(entry->prev);
+	}
+
+	/*
+	 * Step 3: If the predecessor points to @entry, lock it and continue.
+	 * Otherwise, the predecessor is being removed, so loop until that
+	 * removal finishes and this thread's @entry->prev is updated, which
+	 * indicates the old predecessor has reached the loop in step 4.  Write
+	 * the new predecessor into @entry->next.  This both releases the old
+	 * predecessor from its step 4 loop and sets this thread up to lock the
+	 * new predecessor.
+	 */
+	while (pred->next != entry ||
+	       cmpxchg(&pred->next, entry, NULL) != entry) {
+		/*
+		 * The predecessor is being removed so wait for a new,
+		 * unlocked predecessor.
+		 */
+		cpu_relax();
+		pred_reread = READ_ONCE(entry->prev);
+		if (pred != pred_reread) {
+			/*
+			 * The predecessor changed, so republish it and update
+			 * it as in step 2.
+			 */
+			WRITE_ONCE(entry->next, pred_reread);
+			pred = pred_reread;
+			/* Pairs with smp_mb in step 4. */
+			smp_mb();
+		}
+	}
+
+	/*
+	 * Step 4: @entry and @entry's predecessor are both locked, so now
+	 * actually remove @entry from the list.
+	 *
+	 * It is safe to write to the successor's prev pointer because step 1
+	 * prevents the successor from being removed.
+	 */
+
+	WRITE_ONCE(succ->prev, pred);
+
+	/*
+	 * The full barrier guarantees that all changes are visible to other
+	 * threads before the entry is unlocked by the final write, pairing
+	 * with the implied full barrier before the cmpxchg in step 1.
+	 *
+	 * The barrier also guarantees that this thread writes succ->prev
+	 * before reading succ->next, pairing with a thread in step 2 or 3 that
+	 * writes entry->next before reading entry->prev, which ensures that
+	 * the one that writes second sees the update from the other.
+	 */
+	smp_mb();
+
+	while (READ_ONCE(succ->next) == entry) {
+		/* The successor is being removed, so wait for it to finish. */
+		cpu_relax();
+	}
+
+	/* Simultaneously completes the removal and unlocks the predecessor. */
+	WRITE_ONCE(pred->next, succ);
+
+	entry->next = LIST_POISON1;
+	entry->prev = LIST_POISON2;
+}
-- 
2.17.1

