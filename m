Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDCPzO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:55:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43385 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbeDCPzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:55:13 -0400
Date: Tue, 3 Apr 2018 17:55:09 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, thp: do not invoke oom killer on thp charges
Message-ID: <20180403155509.GD5501@dhcp22.suse.cz>
References: <20180321205928.22240-1-mhocko@kernel.org>
 <20180403145853.GB21411@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403145853.GB21411@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-04-18 10:58:53, Johannes Weiner wrote:
> On Wed, Mar 21, 2018 at 09:59:28PM +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > David has noticed that THP memcg charge can trigger the oom killer
> > since 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and
> > madvised allocations"). We have used an explicit __GFP_NORETRY
> > previously which ruled the OOM killer automagically.
> > 
> > Memcg charge path should be semantically compliant with the allocation
> > path and that means that if we do not trigger the OOM killer for costly
> > orders which should do the same in the memcg charge path as well.
> > Otherwise we are forcing callers to distinguish the two and use
> > different gfp masks which is both non-intuitive and bug prone. Not to
> > mention the maintenance burden.
> > 
> > Teach mem_cgroup_oom to bail out on costly order requests to fix the THP
> > issue as well as any other costly OOM eligible allocations to be added
> > in future.
> > 
> > Fixes: 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and madvised allocations")
> > Reported-by: David Rientjes <rientjes@google.com>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> I also prefer this fix over having separate OOM behaviors (which is
> user-visible, and not just about technical ability to satisfy the
> allocation) between the allocator and memcg.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I will repost the patch with the currently merged THP specific handling
reverted (see below). While 9d3c3354bb85 might have been an appropriate
quick fix, we shouldn't keep it longterm for 4.17+ IMHO.

Does you ack apply to that patch as well?
---
>From 3e1b127dd6107a0e51654e90d9faef7f196f5a10 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 21 Mar 2018 10:10:37 +0100
Subject: [PATCH] memcg, thp: do not invoke oom killer on thp charges

David has noticed that THP memcg charge can trigger the oom killer
since 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and
madvised allocations"). We have used an explicit __GFP_NORETRY
previously which ruled the OOM killer automagically.

Memcg charge path should be semantically compliant with the allocation
path and that means that if we do not trigger the OOM killer for
costly orders which should do the same in the memcg charge path as
well.  Otherwise we are forcing callers to distinguish the two and use
different gfp masks which is both non-intuitive and bug prone. As soon
as we get a costly high order kmalloc user we even do not have any means
to tell the memcg specific gfp mask to prevent from OOM because the
charging is deep within guts of the slab allocator.

The unexpected memcg OOM on THP has already been fixed upstream by
9d3c3354bb85 ("mm, thp: do not cause memcg oom for thp") but this is
one-off fix rather than a generic solution. Teach mem_cgroup_oom to bail
out on costly order requests to fix the THP issue as well as any other
costly OOM eligible allocations to be added in future.

Also revert 9d3c3354bb85 because special gfp for THP is no longer
needed.

Fixes: 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and madvised allocations")
Reported-by: David Rientjes <rientjes@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/huge_memory.c | 5 ++---
 mm/khugepaged.c  | 8 ++------
 mm/memcontrol.c  | 2 +-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2297dd9cc7c3..0cc62405de9c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -555,8 +555,7 @@ static int __do_huge_pmd_anonymous_page(struct vm_fault *vmf, struct page *page,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, gfp | __GFP_NORETRY, &memcg,
-				  true)) {
+	if (mem_cgroup_try_charge(page, vma->vm_mm, gfp, &memcg, true)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
@@ -1317,7 +1316,7 @@ int do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 	}
 
 	if (unlikely(mem_cgroup_try_charge(new_page, vma->vm_mm,
-				huge_gfp | __GFP_NORETRY, &memcg, true))) {
+					huge_gfp, &memcg, true))) {
 		put_page(new_page);
 		split_huge_pmd(vma, vmf->pmd, vmf->address);
 		if (page)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 214e614b62b0..b7e2268dfc9a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -960,9 +960,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 		goto out_nolock;
 	}
 
-	/* Do not oom kill for khugepaged charges */
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp | __GFP_NORETRY,
-					   &memcg, true))) {
+	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg, true))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
@@ -1321,9 +1319,7 @@ static void collapse_shmem(struct mm_struct *mm,
 		goto out;
 	}
 
-	/* Do not oom kill for khugepaged charges */
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp | __GFP_NORETRY,
-					   &memcg, true))) {
+	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg, true))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d1a917b5b7b7..08accbcd1a18 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1493,7 +1493,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 
 static void mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 {
-	if (!current->memcg_may_oom)
+	if (!current->memcg_may_oom || order > PAGE_ALLOC_COSTLY_ORDER)
 		return;
 	/*
 	 * We are in the middle of the charge context here, so we
-- 
2.16.3


-- 
Michal Hocko
SUSE Labs
