Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeBUWiM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:38:12 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43228 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeBUWiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:38:07 -0500
X-Google-Smtp-Source: AH8x2258//92PRqdllkOO30NQvQvNmJ0/ksZJHGnpCzb3Wjg0T7Q1sLftJI7CFrrF7WctUN16MLPgA==
From: Shakeel Butt <shakeelb@google.com>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v3 1/2] mm: memcg: remote memcg charging for kmem allocations
Date: Wed, 21 Feb 2018 14:37:56 -0800
Message-Id: <20180221223757.127213-2-shakeelb@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221223757.127213-1-shakeelb@google.com>
References: <20180221223757.127213-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the memcg variant for kmalloc and kmem_cache_alloc. For
kmem_cache_alloc, the kernel switches the root kmem cache with the
memcg specific kmem cache for __GFP_ACCOUNT allocations to charge those
allocations to the memcg. However, the memcg to charge is extracted
from the current task_struct. This patch introduces the variant of kmem
cache allocation functions where the memcg can be provided explicitly
by the caller instead of deducing the memcg from the current task.

The kmalloc allocations are underlying served using the kmem caches
unless the size of the allocation request is larger than
KMALLOC_MAX_CACHE_SIZE, in which case, the kmem caches are bypassed and
the request is routed directly to page allocator. So, for __GFP_ACCOUNT
kmalloc allocations, the memcg of current task is charged. This patch
introduces memcg variant of kmalloc functions to allow callers to
provide memcg for charging.

These functions are useful for use-cases where the allocations should be
charged to the memcg different from the memcg of the caller. One such
concrete use-case is the allocations for fsnotify event objects where
the objects should be charged to the listener instead of the producer.

One requirement to call these functions is that the caller must have the
reference to the memcg. Using kmalloc_memcg and kmem_cache_alloc_memcg
implicitly assumes that the caller is requesting a __GFP_ACCOUNT
allocation.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changelog since v2:
- Merge the kmalloc_memcg patch into this patch.
- Instead of plumbing memcg throughout, use field in task_struct to pass
  the target_memcg.

Changelog since v1:
- Fixed build for SLOB

 include/linux/sched.h    |  3 +++
 include/linux/sched/mm.h | 23 +++++++++++++++++++++++
 include/linux/slab.h     | 30 ++++++++++++++++++++++++++++++
 kernel/fork.c            |  3 +++
 mm/memcontrol.c          | 23 +++++++++++++++++++----
 5 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ce5a27304b03..b91dbce4d886 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1061,6 +1061,9 @@ struct task_struct {
 
 	/* Number of pages to reclaim on returning to userland: */
 	unsigned int			memcg_nr_pages_over_high;
+
+	/* Used by memcontrol for targetted memcg charge: */
+	struct mem_cgroup		*target_memcg;
 #endif
 
 #ifdef CONFIG_UPROBES
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 9806184bb3d5..322e6ed38b7c 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -204,6 +204,29 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
 }
 
+#ifdef CONFIG_MEMCG
+static inline struct mem_cgroup *memalloc_memcg_save(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *old_memcg = current->target_memcg;
+	current->target_memcg = memcg;
+	return old_memcg;
+}
+
+static inline void memalloc_memcg_restore(struct mem_cgroup *memcg)
+{
+	current->target_memcg = memcg;
+}
+#else
+static inline struct mem_cgroup *memalloc_memcg_save(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
+
+static inline void memalloc_memcg_restore(struct mem_cgroup *memcg)
+{
+}
+#endif /* CONFIG_MEMCG */
+
 #ifdef CONFIG_MEMBARRIER
 enum {
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY		= (1U << 0),
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 231abc8976c5..73382ee354d4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -15,6 +15,7 @@
 #include <linux/gfp.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/sched/mm.h>
 
 
 /*
@@ -374,6 +375,21 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
+/*
+ * Calling kmem_cache_alloc_memcg implicitly assumes that the caller
+ * wants a __GFP_ACCOUNT allocation.
+ */
+static __always_inline void *kmem_cache_alloc_memcg(struct kmem_cache *cachep,
+						    gfp_t flags,
+						    struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *old_memcg = memalloc_memcg_save(memcg);
+	void *ptr = kmem_cache_alloc(cachep, flags | __GFP_ACCOUNT);
+
+	memalloc_memcg_restore(old_memcg);
+	return ptr;
+}
+
 #ifdef CONFIG_NUMA
 void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment __malloc;
 void *kmem_cache_alloc_node(struct kmem_cache *, gfp_t flags, int node) __assume_slab_alignment __malloc;
@@ -517,6 +533,20 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 	return __kmalloc(size, flags);
 }
 
+/*
+ * Calling kmalloc_memcg implicitly assumes that the caller wants a
+ * __GFP_ACCOUNT allocation.
+ */
+static __always_inline void *kmalloc_memcg(size_t size, gfp_t flags,
+					   struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *old_memcg = memalloc_memcg_save(memcg);
+	void *ptr = kmalloc(size, flags | __GFP_ACCOUNT);
+
+	memalloc_memcg_restore(old_memcg);
+	return ptr;
+}
+
 /*
  * Determine size used for the nth kmalloc cache.
  * return size or 0 if a kmalloc cache for that
diff --git a/kernel/fork.c b/kernel/fork.c
index 505195d26744..ce2e5ba8926c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -834,6 +834,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->fail_nth = 0;
 #endif
 
+#ifdef CONFIG_MEMCG
+	tsk->target_memcg = NULL;
+#endif
 	return tsk;
 
 free_stack:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fffe502a2c7f..346a594a2f7e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -701,6 +701,15 @@ static struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return memcg;
 }
 
+static struct mem_cgroup *get_mem_cgroup(struct mem_cgroup *memcg)
+{
+	rcu_read_lock();
+	if (!css_tryget_online(&memcg->css))
+		memcg = NULL;
+	rcu_read_unlock();
+	return memcg;
+}
+
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
@@ -2248,7 +2257,7 @@ static inline bool memcg_kmem_bypass(void)
  */
 struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
 {
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg = NULL;
 	struct kmem_cache *memcg_cachep;
 	int kmemcg_id;
 
@@ -2260,7 +2269,10 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
 	if (current->memcg_kmem_skip_account)
 		return cachep;
 
-	memcg = get_mem_cgroup_from_mm(current->mm);
+	if (current->target_memcg)
+		memcg = get_mem_cgroup(current->target_memcg);
+	if (!memcg)
+		memcg = get_mem_cgroup_from_mm(current->mm);
 	kmemcg_id = READ_ONCE(memcg->kmemcg_id);
 	if (kmemcg_id < 0)
 		goto out;
@@ -2338,13 +2350,16 @@ int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
  */
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
 {
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg = NULL;
 	int ret = 0;
 
 	if (memcg_kmem_bypass())
 		return 0;
 
-	memcg = get_mem_cgroup_from_mm(current->mm);
+	if (current->target_memcg)
+		memcg = get_mem_cgroup(current->target_memcg);
+	if (!memcg)
+		memcg = get_mem_cgroup_from_mm(current->mm);
 	if (!mem_cgroup_is_root(memcg)) {
 		ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
 		if (!ret)
-- 
2.16.1.291.g4437f3f132-goog
