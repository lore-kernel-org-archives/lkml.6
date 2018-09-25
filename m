Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A64C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851022086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851022086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeIYSLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:11:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36128 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeIYSLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:11:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so11398188pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1i4++f7u22QigBJDl/7wRgReroUW5liEf0zg2YEWt1w=;
        b=dSxQDnsAmjAcbdLmaXxEre2BGg5CK1BPgkTOkSppp/UpWB7RXoGPCAcIE6EpGePTW1
         2+3TBrOf75xFWcGWfy23v8JA5Rcbomg0MbI9FaWuIwqQabzslmVICLioYAZ0xhnchi6+
         INy74wv1dVKq1YWv3g1TyCo10W5vjpajc4Cpv/NkazsWqCnyGZNe2/68pVdPYs4Hpk+z
         4SdWSnhVUEzVNZSAhzFJz3VJV9sUVp0bicxqB7LJXO+VC7RahngZiYRjabYBy+ctt9lR
         +tSvo3wHCNNPl+tNWQAvMlIlKUl21zs3OAi6kW3syT9+3XZT+a14nJZbv9KrejVvWvXh
         AwRg==
X-Gm-Message-State: ABuFfohuyxmVWxMZkzgcY/CfGNZFcVQZZiQYh7sWq8+xyU5oMwACixAl
        znWOD3QJuvgasl2lcTpTNLQ=
X-Google-Smtp-Source: ACcGV60D7x90SBZYFav22al51jbKqfH6lIv3lMdBZnuLyzxm9X1yzYyaBujNAuYqpjelFKl1tNz57w==
X-Received: by 2002:a62:9992:: with SMTP id t18-v6mr753093pfk.239.1537877029791;
        Tue, 25 Sep 2018 05:03:49 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h132-v6sm3657449pfc.100.2018.09.25.05.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:03:49 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/2] mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask
Date:   Tue, 25 Sep 2018 14:03:26 +0200
Message-Id: <20180925120326.24392-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180925120326.24392-1-mhocko@kernel.org>
References: <20180925120326.24392-1-mhocko@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

THP allocation mode is quite complex and it depends on the defrag
mode. This complexity is hidden in alloc_hugepage_direct_gfpmask from a
large part currently. The NUMA special casing (namely __GFP_THISNODE) is
however independent and placed in alloc_pages_vma currently. This both
adds an unnecessary branch to all vma based page allocation requests and
it makes the code more complex unnecessarily as well. Not to mention
that e.g. shmem THP used to do the node reclaiming unconditionally
regardless of the defrag mode until recently. This was not only
unexpected behavior but it was also hardly a good default behavior and I
strongly suspect it was just a side effect of the code sharing more than
a deliberate decision which suggests that such a layering is wrong.

Get rid of the thp special casing from alloc_pages_vma and move the logic
to alloc_hugepage_direct_gfpmask. __GFP_THISNODE is applied to
the resulting gfp mask only when the direct reclaim is not requested and
when there is no explicit numa binding to preserve the current logic.

This allows for removing alloc_hugepage_vma as well.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/gfp.h       | 12 +++-----
 include/linux/mempolicy.h |  2 ++
 mm/huge_memory.c          | 38 +++++++++++++++++------
 mm/mempolicy.c            | 63 +++------------------------------------
 mm/shmem.c                |  2 +-
 5 files changed, 40 insertions(+), 77 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 24bcc5eec6b4..76f8db0b0e71 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -510,22 +510,18 @@ alloc_pages(gfp_t gfp_mask, unsigned int order)
 }
 extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 			struct vm_area_struct *vma, unsigned long addr,
-			int node, bool hugepage);
-#define alloc_hugepage_vma(gfp_mask, vma, addr, order)	\
-	alloc_pages_vma(gfp_mask, order, vma, addr, numa_node_id(), true)
+			int node);
 #else
 #define alloc_pages(gfp_mask, order) \
 		alloc_pages_node(numa_node_id(), gfp_mask, order)
-#define alloc_pages_vma(gfp_mask, order, vma, addr, node, false)\
-	alloc_pages(gfp_mask, order)
-#define alloc_hugepage_vma(gfp_mask, vma, addr, order)	\
+#define alloc_pages_vma(gfp_mask, order, vma, addr, node)\
 	alloc_pages(gfp_mask, order)
 #endif
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 #define alloc_page_vma(gfp_mask, vma, addr)			\
-	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
+	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id())
 #define alloc_page_vma_node(gfp_mask, vma, addr, node)		\
-	alloc_pages_vma(gfp_mask, 0, vma, addr, node, false)
+	alloc_pages_vma(gfp_mask, 0, vma, addr, node)
 
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5228c62af416..bac395f1d00a 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -139,6 +139,8 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		unsigned long addr);
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+						unsigned long addr);
 bool vma_policy_mof(struct vm_area_struct *vma);
 
 extern void numa_default_policy(void);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c3bc7e9c9a2a..c0bcede31930 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -629,21 +629,40 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
  *	    available
  * never: never stall for any thp allocation
  */
-static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
+static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
+	gfp_t this_node = 0;
+
+#ifdef CONFIG_NUMA
+	struct mempolicy *pol;
+	/*
+	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
+	 * specified, to express a general desire to stay on the current
+	 * node for optimistic allocation attempts. If the defrag mode
+	 * and/or madvise hint requires the direct reclaim then we prefer
+	 * to fallback to other node rather than node reclaim because that
+	 * can lead to excessive reclaim even though there is free memory
+	 * on other nodes. We expect that NUMA preferences are specified
+	 * by memory policies.
+	 */
+	pol = get_vma_policy(vma, addr);
+	if (pol->mode != MPOL_BIND)
+		this_node = __GFP_THISNODE;
+	mpol_cond_put(pol);
+#endif
 
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
 		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM;
+		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM | this_node;
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
 		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-							     __GFP_KSWAPD_RECLAIM);
+							     __GFP_KSWAPD_RECLAIM | this_node);
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
 		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-							     0);
-	return GFP_TRANSHUGE_LIGHT;
+							     this_node);
+	return GFP_TRANSHUGE_LIGHT | this_node;
 }
 
 /* Caller must hold page table lock. */
@@ -715,8 +734,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			pte_free(vma->vm_mm, pgtable);
 		return ret;
 	}
-	gfp = alloc_hugepage_direct_gfpmask(vma);
-	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
+	gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
+	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, vma, haddr, numa_node_id());
 	if (unlikely(!page)) {
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
@@ -1290,8 +1309,9 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 alloc:
 	if (transparent_hugepage_enabled(vma) &&
 	    !transparent_hugepage_debug_cow()) {
-		huge_gfp = alloc_hugepage_direct_gfpmask(vma);
-		new_page = alloc_hugepage_vma(huge_gfp, vma, haddr, HPAGE_PMD_ORDER);
+		huge_gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
+		new_page = alloc_pages_vma(huge_gfp, HPAGE_PMD_ORDER, vma,
+				haddr, numa_node_id());
 	} else
 		new_page = NULL;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 149b6f4cf023..b7b564751165 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1102,8 +1102,8 @@ static struct page *new_page(struct page *page, unsigned long start)
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
-		thp = alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
-					 HPAGE_PMD_ORDER);
+		thp = alloc_pages_vma(GFP_TRANSHUGE, HPAGE_PMD_ORDER, vma,
+				address, numa_node_id());
 		if (!thp)
 			return NULL;
 		prep_transhuge_page(thp);
@@ -1648,7 +1648,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * freeing by another task.  It is the caller's responsibility to free the
  * extra reference for shared policies.
  */
-static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 						unsigned long addr)
 {
 	struct mempolicy *pol = __get_vma_policy(vma, addr);
@@ -1997,7 +1997,6 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
  * 	@vma:  Pointer to VMA or NULL if not available.
  *	@addr: Virtual Address of the allocation. Must be inside the VMA.
  *	@node: Which node to prefer for allocation (modulo policy).
- *	@hugepage: for hugepages try only the preferred node if possible
  *
  * 	This function allocates a page from the kernel page pool and applies
  *	a NUMA policy associated with the VMA or the current process.
@@ -2008,7 +2007,7 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
  */
 struct page *
 alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr, int node, bool hugepage)
+		unsigned long addr, int node)
 {
 	struct mempolicy *pol;
 	struct page *page;
@@ -2026,60 +2025,6 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		goto out;
 	}
 
-	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
-		int hpage_node = node;
-
-		/*
-		 * For hugepage allocation and non-interleave policy which
-		 * allows the current node (or other explicitly preferred
-		 * node) we only try to allocate from the current/preferred
-		 * node and don't fall back to other nodes, as the cost of
-		 * remote accesses would likely offset THP benefits.
-		 *
-		 * If the policy is interleave, or does not allow the current
-		 * node in its nodemask, we allocate the standard way.
-		 */
-		if (pol->mode == MPOL_PREFERRED &&
-						!(pol->flags & MPOL_F_LOCAL))
-			hpage_node = pol->v.preferred_node;
-
-		nmask = policy_nodemask(gfp, pol);
-		if (!nmask || node_isset(hpage_node, *nmask)) {
-			mpol_cond_put(pol);
-			/*
-			 * We cannot invoke reclaim if __GFP_THISNODE
-			 * is set. Invoking reclaim with
-			 * __GFP_THISNODE set, would cause THP
-			 * allocations to trigger heavy swapping
-			 * despite there may be tons of free memory
-			 * (including potentially plenty of THP
-			 * already available in the buddy) on all the
-			 * other NUMA nodes.
-			 *
-			 * At most we could invoke compaction when
-			 * __GFP_THISNODE is set (but we would need to
-			 * refrain from invoking reclaim even if
-			 * compaction returned COMPACT_SKIPPED because
-			 * there wasn't not enough memory to succeed
-			 * compaction). For now just avoid
-			 * __GFP_THISNODE instead of limiting the
-			 * allocation path to a strict and single
-			 * compaction invocation.
-			 *
-			 * Supposedly if direct reclaim was enabled by
-			 * the caller, the app prefers THP regardless
-			 * of the node it comes from so this would be
-			 * more desiderable behavior than only
-			 * providing THP originated from the local
-			 * node in such case.
-			 */
-			if (!(gfp & __GFP_DIRECT_RECLAIM))
-				gfp |= __GFP_THISNODE;
-			page = __alloc_pages_node(hpage_node, gfp, order);
-			goto out;
-		}
-	}
-
 	nmask = policy_nodemask(gfp, pol);
 	preferred_nid = policy_node(gfp, pol, node);
 	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
diff --git a/mm/shmem.c b/mm/shmem.c
index 0376c124b043..371e291f5d4b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1473,7 +1473,7 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 
 	shmem_pseudo_vma_init(&pvma, info, hindex);
 	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
-			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
+			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id());
 	shmem_pseudo_vma_destroy(&pvma);
 	if (page)
 		prep_transhuge_page(page);
-- 
2.18.0

