Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeCUWna (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:43:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41635 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbeCUWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:43:28 -0400
X-Google-Smtp-Source: AG47ELusfbvKGvLppWt5ahCNihswvXrBcrLraxE4kx8m4b8FlkRTIM7lN9MkPMczfpGSLvn5+kiFmQ==
From: Shakeel Butt <shakeelb@google.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] mm, slab: eagerly delete inactive offlined SLABs
Date: Wed, 21 Mar 2018 15:43:01 -0700
Message-Id: <20180321224301.142879-1-shakeelb@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With kmem cgroup support, high memcgs churn can leave behind a lot of
empty kmem_caches. Usually such kmem_caches will be destroyed when the
corresponding memcg gets released but the memcg release can be
arbitrarily delayed. These empty kmem_caches wastes cache_reaper's time.
So, the reaper should destroy such empty offlined kmem_caches.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/slab.c        | 18 ++++++++++++++++--
 mm/slab.h        | 15 +++++++++++++++
 mm/slab_common.c |  2 +-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 66f2db98f026..9c174a799ffb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4004,6 +4004,16 @@ static void drain_array(struct kmem_cache *cachep, struct kmem_cache_node *n,
 	slabs_destroy(cachep, &list);
 }
 
+static bool is_slab_active(struct kmem_cache *cachep)
+{
+	int node;
+	struct kmem_cache_node *n;
+
+	for_each_kmem_cache_node(cachep, node, n)
+		if (READ_ONCE(n->total_slabs) - n->free_slabs)
+			return true;
+	return false;
+}
 /**
  * cache_reap - Reclaim memory from caches.
  * @w: work descriptor
@@ -4018,7 +4028,7 @@ static void drain_array(struct kmem_cache *cachep, struct kmem_cache_node *n,
  */
 static void cache_reap(struct work_struct *w)
 {
-	struct kmem_cache *searchp;
+	struct kmem_cache *searchp, *tmp;
 	struct kmem_cache_node *n;
 	int node = numa_mem_id();
 	struct delayed_work *work = to_delayed_work(w);
@@ -4027,7 +4037,7 @@ static void cache_reap(struct work_struct *w)
 		/* Give up. Setup the next iteration. */
 		goto out;
 
-	list_for_each_entry(searchp, &slab_caches, list) {
+	list_for_each_entry_safe(searchp, tmp, &slab_caches, list) {
 		check_irq_on();
 
 		/*
@@ -4061,6 +4071,10 @@ static void cache_reap(struct work_struct *w)
 				5 * searchp->num - 1) / (5 * searchp->num));
 			STATS_ADD_REAPED(searchp, freed);
 		}
+
+		/* Eagerly delete inactive kmem_cache of an offlined memcg. */
+		if (!is_memcg_online(searchp) && !is_slab_active(searchp))
+			shutdown_cache(searchp);
 next:
 		cond_resched();
 	}
diff --git a/mm/slab.h b/mm/slab.h
index e8981e811c45..e911b10efae7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -166,6 +166,7 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 			      SLAB_TEMPORARY | \
 			      SLAB_ACCOUNT)
 
+int shutdown_cache(struct kmem_cache *s);
 int __kmem_cache_shutdown(struct kmem_cache *);
 void __kmem_cache_release(struct kmem_cache *);
 int __kmem_cache_shrink(struct kmem_cache *);
@@ -290,6 +291,15 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 	memcg_kmem_uncharge(page, order);
 }
 
+static __always_inline bool is_memcg_online(struct kmem_cache *s)
+{
+	if (!memcg_kmem_enabled())
+		return true;
+	if (is_root_cache(s))
+		return true;
+	return mem_cgroup_online(s->memcg_params.memcg);
+}
+
 extern void slab_init_memcg_params(struct kmem_cache *);
 extern void memcg_link_cache(struct kmem_cache *s);
 extern void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
@@ -342,6 +352,11 @@ static inline void memcg_uncharge_slab(struct page *page, int order,
 {
 }
 
+static inline bool is_memcg_online(struct kmem_cache *s)
+{
+	return true;
+}
+
 static inline void slab_init_memcg_params(struct kmem_cache *s)
 {
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 61ab2ca8bea7..d197e878636b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -573,7 +573,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 	}
 }
 
-static int shutdown_cache(struct kmem_cache *s)
+int shutdown_cache(struct kmem_cache *s)
 {
 	/* free asan quarantined objects */
 	kasan_cache_shutdown(s);
-- 
2.17.0.rc0.231.g781580f067-goog
