Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D95C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9152146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9152146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeIMAfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:35:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728197AbeIMAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A96738010FDF;
        Wed, 12 Sep 2018 19:29:06 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 462F710DCF48;
        Wed, 12 Sep 2018 19:29:06 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 1/5] lib/dlock-list: Distributed and lock-protected lists
Date:   Wed, 12 Sep 2018 15:28:48 -0400
Message-Id: <1536780532-4092-2-git-send-email-longman@redhat.com>
In-Reply-To: <1536780532-4092-1-git-send-email-longman@redhat.com>
References: <1536780532-4092-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 19:29:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 19:29:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linked list is used everywhere in the Linux kernel. However, if many
threads are trying to add or delete entries into the same linked list,
it can create a performance bottleneck.

This patch introduces a new list APIs that provide a set of distributed
lists (one per CPU), each of which is protected by its own spinlock.
To the callers, however, the set of lists acts like a single
consolidated list.  This allows list entries insertion and deletion
operations to happen in parallel instead of being serialized with a
global list and lock.

List entry insertion is strictly per cpu. List deletion, however, can
happen in a cpu other than the one that did the insertion. So we still
need lock to protect the list. Because of that, there may still be
a small amount of contention when deletion is being done.

A new header file include/linux/dlock-list.h will be added with the
associated dlock_list_head and dlock_list_node structures. The following
functions are provided to manage the per-cpu list:

 1. int alloc_dlock_list_heads(struct dlock_list_heads *dlist)
 2. void free_dlock_list_heads(struct dlock_list_heads *dlist)
 3. void dlock_list_add(struct dlock_list_node *node,
		        struct dlock_list_heads *dlist)
 4. void dlock_list_del(struct dlock_list *node)

Iteration of all the list entries within a dlock list array
is done by calling either the dlist_for_each_entry() or
dlist_for_each_entry_safe() macros. They correspond to the
list_for_each_entry() and list_for_each_entry_safe() macros
respectively. The iteration states are keep in a dlock_list_iter
structure that is passed to the iteration macros.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/dlock-list.h | 242 +++++++++++++++++++++++++++++++++++++++++++++
 lib/Makefile               |   2 +-
 lib/dlock-list.c           | 234 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 477 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/dlock-list.h
 create mode 100644 lib/dlock-list.c

diff --git a/include/linux/dlock-list.h b/include/linux/dlock-list.h
new file mode 100644
index 0000000..327cb9e
--- /dev/null
+++ b/include/linux/dlock-list.h
@@ -0,0 +1,242 @@
+/*
+ * Distributed and locked list
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * (C) Copyright 2016 Hewlett-Packard Enterprise Development LP
+ * (C) Copyright 2017-2018 Red Hat, Inc.
+ *
+ * Authors: Waiman Long <longman@redhat.com>
+ */
+#ifndef __LINUX_DLOCK_LIST_H
+#define __LINUX_DLOCK_LIST_H
+
+#include <linux/spinlock.h>
+#include <linux/list.h>
+
+/*
+ * include/linux/dlock-list.h
+ *
+ * The dlock_list_head structure contains the spinlock. It is cacheline
+ * aligned to reduce contention among different CPUs. The other
+ * dlock_list_node structures contains a pointer to the head entry instead.
+ */
+struct dlock_list_head {
+	struct list_head list;
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
+struct dlock_list_heads {
+	struct dlock_list_head *heads;
+};
+
+/*
+ * dlock list node data structure
+ */
+struct dlock_list_node {
+	struct list_head list;
+	struct dlock_list_head *head;
+};
+
+/*
+ * dlock list iteration state
+ *
+ * This is an opaque data structure that may change. Users of this structure
+ * should not access the structure members directly other than using the
+ * helper functions and macros provided in this header file.
+ */
+struct dlock_list_iter {
+	int index;
+	struct dlock_list_head *head, *entry;
+};
+
+#define DLOCK_LIST_ITER_INIT(dlist)		\
+	{					\
+		.index = -1,			\
+		.head = (dlist)->heads,		\
+	}
+
+#define DEFINE_DLOCK_LIST_ITER(s, heads)	\
+	struct dlock_list_iter s = DLOCK_LIST_ITER_INIT(heads)
+
+static inline void init_dlock_list_iter(struct dlock_list_iter *iter,
+					struct dlock_list_heads *heads)
+{
+	*iter = (struct dlock_list_iter)DLOCK_LIST_ITER_INIT(heads);
+}
+
+#define DLOCK_LIST_NODE_INIT(name)		\
+	{					\
+		.list = LIST_HEAD_INIT(name)	\
+	}
+
+static inline void init_dlock_list_node(struct dlock_list_node *node)
+{
+	*node = (struct dlock_list_node)DLOCK_LIST_NODE_INIT(node->list);
+}
+
+/**
+ * dlock_list_unlock - unlock the spinlock that protects the current list
+ * @iter: Pointer to the dlock list iterator structure
+ */
+static inline void dlock_list_unlock(struct dlock_list_iter *iter)
+{
+	spin_unlock(&iter->entry->lock);
+}
+
+/**
+ * dlock_list_relock - lock the spinlock that protects the current list
+ * @iter: Pointer to the dlock list iterator structure
+ */
+static inline void dlock_list_relock(struct dlock_list_iter *iter)
+{
+	spin_lock(&iter->entry->lock);
+}
+
+/*
+ * Allocation and freeing of dlock list
+ */
+extern int  __alloc_dlock_list_heads(struct dlock_list_heads *dlist,
+				     struct lock_class_key *key);
+extern void free_dlock_list_heads(struct dlock_list_heads *dlist);
+
+/**
+ * alloc_dlock_list_head - Initialize and allocate the list of head entries.
+ * @dlist  : Pointer to the dlock_list_heads structure to be initialized
+ * Return  : 0 if successful, -ENOMEM if memory allocation error
+ */
+#define alloc_dlock_list_heads(dlist)					\
+({									\
+	static struct lock_class_key _key;				\
+	__alloc_dlock_list_heads(dlist, &_key);				\
+})
+
+/*
+ * Check if a dlock list is empty or not.
+ */
+extern bool dlock_lists_empty(struct dlock_list_heads *dlist);
+
+/*
+ * The dlock list addition and deletion functions here are not irq-safe.
+ * Special irq-safe variants will have to be added if we need them.
+ */
+extern void dlock_lists_add(struct dlock_list_node *node,
+			    struct dlock_list_heads *dlist);
+extern void dlock_lists_del(struct dlock_list_node *node);
+
+/*
+ * Find the first entry of the next available list.
+ */
+extern struct dlock_list_node *
+__dlock_list_next_list(struct dlock_list_iter *iter);
+
+/**
+ * __dlock_list_next_entry - Iterate to the next entry of the dlock list
+ * @curr : Pointer to the current dlock_list_node structure
+ * @iter : Pointer to the dlock list iterator structure
+ * Return: Pointer to the next entry or NULL if all the entries are iterated
+ *
+ * The iterator has to be properly initialized before calling this function.
+ */
+static inline struct dlock_list_node *
+__dlock_list_next_entry(struct dlock_list_node *curr,
+			struct dlock_list_iter *iter)
+{
+	/*
+	 * Find next entry
+	 */
+	if (curr)
+		curr = list_next_entry(curr, list);
+
+	if (!curr || (&curr->list == &iter->entry->list)) {
+		/*
+		 * The current list has been exhausted, try the next available
+		 * list.
+		 */
+		curr = __dlock_list_next_list(iter);
+	}
+
+	return curr;	/* Continue the iteration */
+}
+
+/**
+ * _dlock_list_next_list_entry - get first element from next list in iterator
+ * @iter  : The dlock list iterator.
+ * @pos   : A variable of the struct that is embedded in.
+ * @member: The name of the dlock_list_node within the struct.
+ * Return : Pointer to first entry or NULL if all the lists are iterated.
+ */
+#define _dlock_list_next_list_entry(iter, pos, member)			\
+	({								\
+		struct dlock_list_node *_n;				\
+		_n = __dlock_list_next_entry(NULL, iter);		\
+		_n ? list_entry(_n, typeof(*pos), member) : NULL;	\
+	})
+
+/**
+ * _dlock_list_next_entry - iterate to the next entry of the list
+ * @pos   : The type * to cursor
+ * @iter  : The dlock list iterator.
+ * @member: The name of the dlock_list_node within the struct.
+ * Return : Pointer to the next entry or NULL if all the entries are iterated.
+ *
+ * Note that pos can't be NULL.
+ */
+#define _dlock_list_next_entry(pos, iter, member)			\
+	({								\
+		struct dlock_list_node *_n;				\
+		_n = __dlock_list_next_entry(&(pos)->member, iter);	\
+		_n ? list_entry(_n, typeof(*(pos)), member) : NULL;	\
+	})
+
+/**
+ * dlist_for_each_entry - iterate over the dlock list
+ * @pos   : Type * to use as a loop cursor
+ * @iter  : The dlock list iterator
+ * @member: The name of the dlock_list_node within the struct
+ *
+ * This iteration macro isn't safe with respect to list entry removal, but
+ * it can correctly iterate newly added entries right after the current one.
+ * This iteration function is designed to be used in a while loop.
+ */
+#define dlist_for_each_entry(pos, iter, member)				\
+	for (pos = _dlock_list_next_list_entry(iter, pos, member);	\
+	     pos != NULL;						\
+	     pos = _dlock_list_next_entry(pos, iter, member))
+
+/**
+ * dlist_for_each_entry_safe - iterate over the dlock list & safe over removal
+ * @pos   : Type * to use as a loop cursor
+ * @n	  : Another type * to use as temporary storage
+ * @iter  : The dlock list iterator
+ * @member: The name of the dlock_list_node within the struct
+ *
+ * This iteration macro is safe with respect to list entry removal.
+ * However, it cannot correctly iterate newly added entries right after the
+ * current one.
+ *
+ * The call to __dlock_list_next_list() is deferred until the next entry
+ * is being iterated to avoid use-after-unlock problem.
+ */
+#define dlist_for_each_entry_safe(pos, n, iter, member)			\
+	for (pos = NULL;						\
+	    ({								\
+		if (!pos ||						\
+		   (&(pos)->member.list == &(iter)->entry->list))	\
+			pos = _dlock_list_next_list_entry(iter, pos,	\
+							  member);	\
+		if (pos)						\
+			n = list_next_entry(pos, member.list);		\
+		pos;							\
+	    });								\
+	    pos = n)
+
+#endif /* __LINUX_DLOCK_LIST_H */
diff --git a/lib/Makefile b/lib/Makefile
index ca3f7eb..040c563 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -38,7 +38,7 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
 	 gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o reciprocal_div.o \
-	 once.o refcount.o usercopy.o errseq.o bucket_locks.o
+	 once.o refcount.o usercopy.o errseq.o bucket_locks.o dlock-list.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/dlock-list.c b/lib/dlock-list.c
new file mode 100644
index 0000000..f64ea4c
--- /dev/null
+++ b/lib/dlock-list.c
@@ -0,0 +1,234 @@
+/*
+ * Distributed and locked list
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * (C) Copyright 2016 Hewlett-Packard Enterprise Development LP
+ * (C) Copyright 2017-2018 Red Hat, Inc.
+ *
+ * Authors: Waiman Long <longman@redhat.com>
+ */
+#include <linux/dlock-list.h>
+#include <linux/lockdep.h>
+#include <linux/slab.h>
+#include <linux/cpumask.h>
+
+/*
+ * The distributed and locked list is a distributed set of lists each of
+ * which is protected by its own spinlock, but acts like a single
+ * consolidated list to the callers. For scaling purpose, the number of
+ * lists used is equal to the number of possible CPUs in the system to
+ * minimize contention.
+ *
+ * However, it is possible that individual CPU numbers may be equal to
+ * or greater than the number of possible CPUs when there are holes in
+ * the CPU number list. As a result, we need to map the CPU number to a
+ * list index.
+ */
+static DEFINE_PER_CPU_READ_MOSTLY(int, cpu2idx);
+
+/*
+ * Initialize cpu2idx mapping table
+ *
+ * It is possible that a dlock-list can be allocated before the cpu2idx is
+ * initialized. In this case, all the cpus are mapped to the first entry
+ * before initialization.
+ *
+ */
+static int __init cpu2idx_init(void)
+{
+	int idx, cpu;
+
+	idx = 0;
+	for_each_possible_cpu(cpu)
+		per_cpu(cpu2idx, cpu) = idx++;
+	return 0;
+}
+postcore_initcall(cpu2idx_init);
+
+/**
+ * __alloc_dlock_list_heads - Initialize and allocate the list of head entries
+ * @dlist: Pointer to the dlock_list_heads structure to be initialized
+ * @key  : The lock class key to be used for lockdep
+ * Return: 0 if successful, -ENOMEM if memory allocation error
+ *
+ * This function does not allocate the dlock_list_heads structure itself. The
+ * callers will have to do their own memory allocation, if necessary. However,
+ * this allows embedding the dlock_list_heads structure directly into other
+ * structures.
+ *
+ * Dynamically allocated locks need to have their own special lock class
+ * to avoid lockdep warning.
+ */
+int __alloc_dlock_list_heads(struct dlock_list_heads *dlist,
+			     struct lock_class_key *key)
+{
+	int idx;
+
+	dlist->heads = kcalloc(nr_cpu_ids, sizeof(struct dlock_list_head),
+			       GFP_KERNEL);
+
+	if (!dlist->heads)
+		return -ENOMEM;
+
+	for (idx = 0; idx < nr_cpu_ids; idx++) {
+		struct dlock_list_head *head = &dlist->heads[idx];
+
+		INIT_LIST_HEAD(&head->list);
+		head->lock = __SPIN_LOCK_UNLOCKED(&head->lock);
+		lockdep_set_class(&head->lock, key);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(__alloc_dlock_list_heads);
+
+/**
+ * free_dlock_list_heads - Free all the heads entries of the dlock list
+ * @dlist: Pointer of the dlock_list_heads structure to be freed
+ *
+ * This function doesn't free the dlock_list_heads structure itself. So
+ * the caller will have to do it, if necessary.
+ */
+void free_dlock_list_heads(struct dlock_list_heads *dlist)
+{
+	kfree(dlist->heads);
+	dlist->heads = NULL;
+}
+EXPORT_SYMBOL(free_dlock_list_heads);
+
+/**
+ * dlock_lists_empty - Check if all the dlock lists are empty
+ * @dlist: Pointer to the dlock_list_heads structure
+ * Return: true if list is empty, false otherwise.
+ *
+ * This can be a pretty expensive function call. If this function is required
+ * in a performance critical path, we may have to maintain a global count
+ * of the list entries in the global dlock_list_heads structure instead.
+ */
+bool dlock_lists_empty(struct dlock_list_heads *dlist)
+{
+	int idx;
+
+	for (idx = 0; idx < nr_cpu_ids; idx++)
+		if (!list_empty(&dlist->heads[idx].list))
+			return false;
+	return true;
+}
+EXPORT_SYMBOL(dlock_lists_empty);
+
+/**
+ * dlock_lists_add - Adds a node to the given dlock list
+ * @node : The node to be added
+ * @dlist: The dlock list where the node is to be added
+ *
+ * List selection is based on the CPU being used when the dlock_list_add()
+ * function is called. However, deletion may be done by a different CPU.
+ */
+void dlock_lists_add(struct dlock_list_node *node,
+		     struct dlock_list_heads *dlist)
+{
+	struct dlock_list_head *head = &dlist->heads[this_cpu_read(cpu2idx)];
+
+	/*
+	 * There is no need to disable preemption
+	 */
+	spin_lock(&head->lock);
+	WRITE_ONCE(node->head, head);
+	list_add(&node->list, &head->list);
+	spin_unlock(&head->lock);
+}
+EXPORT_SYMBOL(dlock_lists_add);
+
+/**
+ * dlock_lists_del - Delete a node from a dlock list
+ * @node : The node to be deleted
+ *
+ * We need to check the lock pointer again after taking the lock to guard
+ * against concurrent deletion of the same node. If the lock pointer changes
+ * (becomes NULL or to a different one), we assume that the deletion was done
+ * elsewhere. A warning will be printed if this happens as it is likely to be
+ * a bug.
+ */
+void dlock_lists_del(struct dlock_list_node *node)
+{
+	struct dlock_list_head *head;
+	bool retry;
+
+	do {
+		head = READ_ONCE(node->head);
+		if (WARN_ONCE(!head, "%s: node 0x%lx has no associated head\n",
+			      __func__, (unsigned long)node))
+			return;
+
+		spin_lock(&head->lock);
+		if (likely(head == READ_ONCE(node->head))) {
+			list_del_init(&node->list);
+			WRITE_ONCE(node->head, NULL);
+			retry = false;
+		} else {
+			/*
+			 * The lock has somehow changed. Retry again if it is
+			 * not NULL. Otherwise, just ignore the delete
+			 * operation.
+			 */
+			retry = (READ_ONCE(node->head) != NULL);
+		}
+		spin_unlock(&head->lock);
+	} while (retry);
+}
+EXPORT_SYMBOL(dlock_lists_del);
+
+/**
+ * __dlock_list_next_list: Find the first entry of the next available list
+ * @dlist: Pointer to the dlock_list_heads structure
+ * @iter : Pointer to the dlock list iterator structure
+ * Return: true if the entry is found, false if all the lists exhausted
+ *
+ * The information about the next available list will be put into the iterator.
+ */
+struct dlock_list_node *__dlock_list_next_list(struct dlock_list_iter *iter)
+{
+	struct dlock_list_node *next;
+	struct dlock_list_head *head;
+
+restart:
+	if (iter->entry) {
+		spin_unlock(&iter->entry->lock);
+		iter->entry = NULL;
+	}
+
+next_list:
+	/*
+	 * Try next list
+	 */
+	if (++iter->index >= nr_cpu_ids)
+		return NULL;	/* All the entries iterated */
+
+	if (list_empty(&iter->head[iter->index].list))
+		goto next_list;
+
+	head = iter->entry = &iter->head[iter->index];
+	spin_lock(&head->lock);
+	/*
+	 * There is a slight chance that the list may become empty just
+	 * before the lock is acquired. So an additional check is
+	 * needed to make sure that a valid node will be returned.
+	 */
+	if (list_empty(&head->list))
+		goto restart;
+
+	next = list_entry(head->list.next, struct dlock_list_node,
+			  list);
+	WARN_ON_ONCE(next->head != head);
+
+	return next;
+}
+EXPORT_SYMBOL(__dlock_list_next_list);
-- 
1.8.3.1

