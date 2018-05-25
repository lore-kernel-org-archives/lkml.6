Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967880AbeEYSzK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:55:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40410 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967543AbeEYSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:55:08 -0400
X-Google-Smtp-Source: AB8JxZpixhlaWx8a+2loowbMSVsLJbAfViCz4jkcAoAC2cPp+ahK7YS7CKV1dXt2LEZUsY8+txs3sA==
From: Shakeel Butt <shakeelb@google.com>
To: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Linux MM <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] memcg: force charge kmem counter too
Date: Fri, 25 May 2018 11:55:01 -0700
Message-Id: <20180525185501.82098-1-shakeelb@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on several conditions the kernel can decide to force charge an
allocation for a memcg i.e. overcharge memcg->memory and memcg->memsw
counters. Do the same for memcg->kmem counter too. In cgroup-v1, this
bug can cause a __GFP_NOFAIL kmem allocation fail if an explicit limit
on kmem counter is set and reached.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab5673dbfc4e..0a88f824c550 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1893,6 +1893,18 @@ void mem_cgroup_handle_over_high(void)
 	current->memcg_nr_pages_over_high = 0;
 }
 
+/*
+ * Based on try_charge() force charge conditions.
+ */
+static inline bool should_force_charge(gfp_t gfp_mask)
+{
+	return (unlikely(tsk_is_oom_victim(current) ||
+			 fatal_signal_pending(current) ||
+			 current->flags & PF_EXITING ||
+			 current->flags & PF_MEMALLOC ||
+			 gfp_mask & __GFP_NOFAIL));
+}
+
 static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		      unsigned int nr_pages)
 {
@@ -2008,6 +2020,8 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * The allocation either can't fail or will lead to more memory
 	 * being freed very soon.  Allow memory usage go over the limit
 	 * temporarily by force charging it.
+	 *
+	 * NOTE: Please keep the should_force_charge() conditions in sync.
 	 */
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
@@ -2331,8 +2345,11 @@ int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
 	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
-		cancel_charge(memcg, nr_pages);
-		return -ENOMEM;
+		if (!should_force_charge(gfp)) {
+			cancel_charge(memcg, nr_pages);
+			return -ENOMEM;
+		}
+		page_counter_charge(&memcg->kmem, nr_pages);
 	}
 
 	page->mem_cgroup = memcg;
-- 
2.17.0.921.gf22659ad46-goog
