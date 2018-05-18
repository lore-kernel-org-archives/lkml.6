Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeERHt4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:49:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40889 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERHtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:49:51 -0400
X-Google-Smtp-Source: AB8JxZqRkWT5mjyzzbuwmvDNqxY9jRYFQ4uCRfOlNmVDEIMWdgGRgdohJl6I+IH7PD1mq6LFWiN8Kg==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 01/10] mm: pagecache add lock
Date: Fri, 18 May 2018 03:49:00 -0400
Message-Id: <20180518074918.13816-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a per address space lock around adding pages to the pagecache - making it
possible for fallocate INSERT_RANGE/COLLAPSE_RANGE to work correctly, and also
hopefully making truncate and dio a bit saner.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/inode.c            |  1 +
 include/linux/fs.h    | 23 +++++++++++
 include/linux/sched.h |  4 ++
 init/init_task.c      |  1 +
 mm/filemap.c          | 91 ++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ef362364d3..e7aaa39adb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -350,6 +350,7 @@ void address_space_init_once(struct address_space *mapping)
 {
 	memset(mapping, 0, sizeof(*mapping));
 	INIT_RADIX_TREE(&mapping->page_tree, GFP_ATOMIC | __GFP_ACCOUNT);
+	pagecache_lock_init(&mapping->add_lock);
 	spin_lock_init(&mapping->tree_lock);
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->private_list);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c6baf76761..18d2886a44 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -388,9 +388,32 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
 				struct page *page, void *fsdata);
 
+/*
+ * Two-state lock - can be taken for add or block - both states are shared,
+ * like read side of rwsem, but conflict with other state:
+ */
+struct pagecache_lock {
+	atomic_long_t		v;
+	wait_queue_head_t	wait;
+};
+
+static inline void pagecache_lock_init(struct pagecache_lock *lock)
+{
+	atomic_long_set(&lock->v, 0);
+	init_waitqueue_head(&lock->wait);
+}
+
+void pagecache_add_put(struct pagecache_lock *);
+void pagecache_add_get(struct pagecache_lock *);
+void __pagecache_block_put(struct pagecache_lock *);
+void __pagecache_block_get(struct pagecache_lock *);
+void pagecache_block_put(struct pagecache_lock *);
+void pagecache_block_get(struct pagecache_lock *);
+
 struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
+	struct pagecache_lock	add_lock;	/* protects adding new pages */
 	spinlock_t		tree_lock;	/* and lock protecting it */
 	atomic_t		i_mmap_writable;/* count VM_SHARED mappings */
 	struct rb_root_cached	i_mmap;		/* tree of private and shared mappings */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b161ef8a90..e58465f61a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -40,6 +40,7 @@ struct io_context;
 struct mempolicy;
 struct nameidata;
 struct nsproxy;
+struct pagecache_lock;
 struct perf_event_context;
 struct pid_namespace;
 struct pipe_inode_info;
@@ -865,6 +866,9 @@ struct task_struct {
 	unsigned int			in_ubsan;
 #endif
 
+	/* currently held lock, for avoiding recursing in fault path: */
+	struct pagecache_lock *pagecache_lock;
+
 	/* Journalling filesystem info: */
 	void				*journal_info;
 
diff --git a/init/init_task.c b/init/init_task.c
index 3ac6e754cf..308d46eef9 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -106,6 +106,7 @@ struct task_struct init_task
 	},
 	.blocked	= {{0}},
 	.alloc_lock	= __SPIN_LOCK_UNLOCKED(init_task.alloc_lock),
+	.pagecache_lock = NULL,
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
diff --git a/mm/filemap.c b/mm/filemap.c
index 693f62212a..31dd888785 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -111,6 +111,73 @@
  *   ->tasklist_lock            (memory_failure, collect_procs_ao)
  */
 
+static void __pagecache_lock_put(struct pagecache_lock *lock, long i)
+{
+	BUG_ON(atomic_long_read(&lock->v) == 0);
+
+	if (atomic_long_sub_return_release(i, &lock->v) == 0)
+		wake_up_all(&lock->wait);
+}
+
+static bool __pagecache_lock_tryget(struct pagecache_lock *lock, long i)
+{
+	long v = atomic_long_read(&lock->v), old;
+
+	do {
+		old = v;
+
+		if (i > 0 ? v < 0 : v > 0)
+			return false;
+	} while ((v = atomic_long_cmpxchg_acquire(&lock->v,
+					old, old + i)) != old);
+	return true;
+}
+
+static void __pagecache_lock_get(struct pagecache_lock *lock, long i)
+{
+	wait_event(lock->wait, __pagecache_lock_tryget(lock, i));
+}
+
+void pagecache_add_put(struct pagecache_lock *lock)
+{
+	__pagecache_lock_put(lock, 1);
+}
+EXPORT_SYMBOL(pagecache_add_put);
+
+void pagecache_add_get(struct pagecache_lock *lock)
+{
+	__pagecache_lock_get(lock, 1);
+}
+EXPORT_SYMBOL(pagecache_add_get);
+
+void __pagecache_block_put(struct pagecache_lock *lock)
+{
+	__pagecache_lock_put(lock, -1);
+}
+EXPORT_SYMBOL(__pagecache_block_put);
+
+void __pagecache_block_get(struct pagecache_lock *lock)
+{
+	__pagecache_lock_get(lock, -1);
+}
+EXPORT_SYMBOL(__pagecache_block_get);
+
+void pagecache_block_put(struct pagecache_lock *lock)
+{
+	BUG_ON(current->pagecache_lock != lock);
+	current->pagecache_lock = NULL;
+	__pagecache_lock_put(lock, -1);
+}
+EXPORT_SYMBOL(pagecache_block_put);
+
+void pagecache_block_get(struct pagecache_lock *lock)
+{
+	__pagecache_lock_get(lock, -1);
+	BUG_ON(current->pagecache_lock);
+	current->pagecache_lock = lock;
+}
+EXPORT_SYMBOL(pagecache_block_get);
+
 static int page_cache_tree_insert(struct address_space *mapping,
 				  struct page *page, void **shadowp)
 {
@@ -834,18 +901,21 @@ static int __add_to_page_cache_locked(struct page *page,
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
 
+	if (current->pagecache_lock != &mapping->add_lock)
+		pagecache_add_get(&mapping->add_lock);
+
 	if (!huge) {
 		error = mem_cgroup_try_charge(page, current->mm,
 					      gfp_mask, &memcg, false);
 		if (error)
-			return error;
+			goto err;
 	}
 
 	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
 	if (error) {
 		if (!huge)
 			mem_cgroup_cancel_charge(page, memcg, false);
-		return error;
+		goto err;
 	}
 
 	get_page(page);
@@ -865,7 +935,11 @@ static int __add_to_page_cache_locked(struct page *page,
 	if (!huge)
 		mem_cgroup_commit_charge(page, memcg, false, false);
 	trace_mm_filemap_add_to_page_cache(page);
-	return 0;
+err:
+	if (current->pagecache_lock != &mapping->add_lock)
+		pagecache_add_put(&mapping->add_lock);
+
+	return error;
 err_insert:
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
@@ -873,7 +947,7 @@ static int __add_to_page_cache_locked(struct page *page,
 	if (!huge)
 		mem_cgroup_cancel_charge(page, memcg, false);
 	put_page(page);
-	return error;
+	goto err;
 }
 
 /**
@@ -2511,7 +2585,14 @@ int filemap_fault(struct vm_fault *vmf)
 	 * Do we have something in the page cache already?
 	 */
 	page = find_get_page(mapping, offset);
-	if (likely(page) && !(vmf->flags & FAULT_FLAG_TRIED)) {
+	if (unlikely(current->pagecache_lock == &mapping->add_lock)) {
+		/*
+		 * fault from e.g. dio -> get_user_pages() - _don't_ want to do
+		 * readahead, only read in page we need:
+		 */
+		if (!page)
+			goto no_cached_page;
+	} else if (likely(page) && !(vmf->flags & FAULT_FLAG_TRIED)) {
 		/*
 		 * We found the page, so try async readahead before
 		 * waiting for the lock.
-- 
2.17.0
