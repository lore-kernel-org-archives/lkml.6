Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDFRgO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:36:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38999 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeDFRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:36:12 -0400
X-Google-Smtp-Source: AIpwx49H0YOEs2vXtKlm0bpkPi8kog5D/Nr+7vbI3nDhKHfH5Zs6CIe87wj5Tc40DF5Nz8/yK9rUHg==
From: Shakeel Butt <shakeelb@google.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] Re: [PATCH v3 1/2] mm: memcg: remote memcg charging for kmem allocations
Date: Fri,  6 Apr 2018 10:36:01 -0700
Message-Id: <20180406173601.126152-1-shakeelb@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180315174941.GN23100@dhcp22.suse.cz>
References: <20180315174941.GN23100@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 10:49 AM, Michal Hocko <mhocko@kernel.org> wrote:
> Charging path is still a _hot path_. Especially when the kmem accounting
> is enabled by default. You cannot simply downplay the overhead. We have
> _one_ user but all users should pay the price. This is simply hard to
> justify. Maybe we can thing of something that would put the  burden on
> the charging context?

What do you think of the following?

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d3ea8799a2c..205043283716 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -701,6 +701,20 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return memcg;
 }
 
+static __always_inline struct mem_cgroup *get_mem_cgroup(
+				struct mem_cgroup *memcg, struct mm_struct *mm)
+{
+	if (unlikely(memcg)) {
+		rcu_read_lock();
+		if (css_tryget_online(&memcg->css)) {
+			rcu_read_unlock();
+			return memcg;
+		}
+		rcu_read_unlock();
+	}
+	return get_mem_cgroup_from_mm(mm);
+}
+
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
@@ -2119,15 +2133,6 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 }
 
 #ifndef CONFIG_SLOB
-static struct mem_cgroup *get_mem_cgroup(struct mem_cgroup *memcg)
-{
-	rcu_read_lock();
-	if (!css_tryget_online(&memcg->css))
-		memcg = NULL;
-	rcu_read_unlock();
-	return memcg;
-}
-
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
@@ -2257,7 +2262,7 @@ static inline bool memcg_kmem_bypass(void)
  */
 struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
 {
-	struct mem_cgroup *memcg = NULL;
+	struct mem_cgroup *memcg;
 	struct kmem_cache *memcg_cachep;
 	int kmemcg_id;
 
@@ -2269,10 +2274,7 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
 	if (current->memcg_kmem_skip_account)
 		return cachep;
 
-	if (current->target_memcg)
-		memcg = get_mem_cgroup(current->target_memcg);
-	if (!memcg)
-		memcg = get_mem_cgroup_from_mm(current->mm);
+	memcg = get_mem_cgroup(current->target_memcg, current->mm);
 	kmemcg_id = READ_ONCE(memcg->kmemcg_id);
 	if (kmemcg_id < 0)
 		goto out;
@@ -2350,16 +2352,13 @@ int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
  */
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
 {
-	struct mem_cgroup *memcg = NULL;
+	struct mem_cgroup *memcg;
 	int ret = 0;
 
 	if (memcg_kmem_bypass())
 		return 0;
 
-	if (current->target_memcg)
-		memcg = get_mem_cgroup(current->target_memcg);
-	if (!memcg)
-		memcg = get_mem_cgroup_from_mm(current->mm);
+	memcg = get_mem_cgroup(current->target_memcg, current->mm);
 	if (!mem_cgroup_is_root(memcg)) {
 		ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
 		if (!ret)
-- 
2.17.0.484.g0c8726318c-goog
