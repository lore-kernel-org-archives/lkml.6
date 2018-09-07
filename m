Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465A62075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465A62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeIGRrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:47:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39632 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeIGRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:47:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so11485616edi.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 06:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8M1ZvpyrpneZFEgfvGdMc167gTui74N3+i/EkXb6QbM=;
        b=sn2uZAZ7eFhRn6UC6++2TqK/kGhbfnEtrPJHuU3yJa1KFaOQtZL0JCe967aWt+vRK9
         DyeXL8pCgQtoiV+LDV0mQbE6k4bY4hZlie2aQ2aZpARdolb4IXqi3cgIveJBWKWckY32
         ubXomBwXGfUzFJ8gxwebO05LbMlkbdtcHKkDfT8dVWJfAA4v1bFKopdRsLjTnPXU8dtQ
         GNyJT+mkknPEj4CYh7mIiWDpDlGNmSQkmrxfVAwO35jGYF/jDdo9b6fyIcjbJHZN4lAQ
         naPbo4SBLzwlopVGyIHX/EqF90wBheEp1Lkmmi4X0mv0SGPjktaSJj1KVloDv2ZFtXEE
         RKkw==
X-Gm-Message-State: APzg51BCbTYFVu3xuENMsvrG99mYvmkowpvc2CAjT9DAMW1VT3NlU9JO
        4hEs6sla3VJqWp4D7Ma4PZc=
X-Google-Smtp-Source: ANB0VdZXs39rcJ0f8okEBh/8PNIAVtmcJmZ6926nfz5hqOoO2dlWcYoctNjX3dyMy6exi/373dTpPw==
X-Received: by 2002:a50:ac56:: with SMTP id w22-v6mr8750515edc.211.1536325575273;
        Fri, 07 Sep 2018 06:06:15 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d56-v6sm3972940edb.7.2018.09.07.06.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 06:06:14 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings
Date:   Fri,  7 Sep 2018 15:05:50 +0200
Message-Id: <20180907130550.11885-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Andrea has noticed [1] that a THP allocation might be really disruptive
when allocated on NUMA system with the local node full or hard to
reclaim. Stefan has posted an allocation stall report on 4.12 based
SLES kernel which suggests the same issue:
[245513.362669] kvm: page allocation stalls for 194572ms, order:9, mode:0x4740ca(__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|__GFP_MOVABLE|__GFP_DIRECT_RECLAIM), nodemask=(null)
[245513.363983] kvm cpuset=/ mems_allowed=0-1
[245513.364604] CPU: 10 PID: 84752 Comm: kvm Tainted: G        W 4.12.0+98-ph <a href="/view.php?id=1" title="[geschlossen] Integration Ramdisk" class="resolved">0000001</a> SLE15 (unreleased)
[245513.365258] Hardware name: Supermicro SYS-1029P-WTRT/X11DDW-NT, BIOS 2.0 12/05/2017
[245513.365905] Call Trace:
[245513.366535]  dump_stack+0x5c/0x84
[245513.367148]  warn_alloc+0xe0/0x180
[245513.367769]  __alloc_pages_slowpath+0x820/0xc90
[245513.368406]  ? __slab_free+0xa9/0x2f0
[245513.369048]  ? __slab_free+0xa9/0x2f0
[245513.369671]  __alloc_pages_nodemask+0x1cc/0x210
[245513.370300]  alloc_pages_vma+0x1e5/0x280
[245513.370921]  do_huge_pmd_wp_page+0x83f/0xf00
[245513.371554]  ? set_huge_zero_page.isra.52.part.53+0x9b/0xb0
[245513.372184]  ? do_huge_pmd_anonymous_page+0x631/0x6d0
[245513.372812]  __handle_mm_fault+0x93d/0x1060
[245513.373439]  handle_mm_fault+0xc6/0x1b0
[245513.374042]  __do_page_fault+0x230/0x430
[245513.374679]  ? get_vtime_delta+0x13/0xb0
[245513.375411]  do_page_fault+0x2a/0x70
[245513.376145]  ? page_fault+0x65/0x80
[245513.376882]  page_fault+0x7b/0x80
[...]
[245513.382056] Mem-Info:
[245513.382634] active_anon:126315487 inactive_anon:1612476 isolated_anon:5
                 active_file:60183 inactive_file:245285 isolated_file:0
                 unevictable:15657 dirty:286 writeback:1 unstable:0
                 slab_reclaimable:75543 slab_unreclaimable:2509111
                 mapped:81814 shmem:31764 pagetables:370616 bounce:0
                 free:32294031 free_pcp:6233 free_cma:0
[245513.386615] Node 0 active_anon:254680388kB inactive_anon:1112760kB active_file:240648kB inactive_file:981168kB unevictable:13368kB isolated(anon):0kB isolated(file):0kB mapped:280240kB dirty:1144kB writeback:0kB shmem:95832kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 81225728kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[245513.388650] Node 1 active_anon:250583072kB inactive_anon:5337144kB active_file:84kB inactive_file:0kB unevictable:49260kB isolated(anon):20kB isolated(file):0kB mapped:47016kB dirty:0kB writeback:4kB shmem:31224kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 31897600kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no

The defrag mode is "madvise" and from the above report it is clear that
the THP has been allocated for MADV_HUGEPAGA vma.

Andrea has identified that the main source of the problem is
__GFP_THISNODE usage:

: The problem is that direct compaction combined with the NUMA
: __GFP_THISNODE logic in mempolicy.c is telling reclaim to swap very
: hard the local node, instead of failing the allocation if there's no
: THP available in the local node.
:
: Such logic was ok until __GFP_THISNODE was added to the THP allocation
: path even with MPOL_DEFAULT.
:
: The idea behind the __GFP_THISNODE addition, is that it is better to
: provide local memory in PAGE_SIZE units than to use remote NUMA THP
: backed memory. That largely depends on the remote latency though, on
: threadrippers for example the overhead is relatively low in my
: experience.
:
: The combination of __GFP_THISNODE and __GFP_DIRECT_RECLAIM results in
: extremely slow qemu startup with vfio, if the VM is larger than the
: size of one host NUMA node. This is because it will try very hard to
: unsuccessfully swapout get_user_pages pinned pages as result of the
: __GFP_THISNODE being set, instead of falling back to PAGE_SIZE
: allocations and instead of trying to allocate THP on other nodes (it
: would be even worse without vfio type1 GUP pins of course, except it'd
: be swapping heavily instead).

Fix this by removing __GFP_THISNODE handling from alloc_pages_vma where
it doesn't belong and move it to alloc_hugepage_direct_gfpmask where we
juggle gfp flags for different allocation modes. The rationale is that
__GFP_THISNODE is helpful in relaxed defrag modes because falling back
to a different node might be more harmful than the benefit of a large page.
If the user really requires THP (e.g. by MADV_HUGEPAGE) then the THP has
a higher priority than local NUMA placement.

Be careful when the vma has an explicit numa binding though, because
__GFP_THISNODE is not playing well with it. We want to follow the
explicit numa policy rather than enforce a node which happens to be
local to the cpu we are running on.

[1] http://lkml.kernel.org/r/20180820032204.9591-1-aarcange@redhat.com

Fixes: 5265047ac301 ("mm, thp: really limit transparent hugepage allocation to local node")
Reported-by: Stefan Priebe <s.priebe@profihost.ag>
Debugged-by: Andrea Arcangeli <aarcange@redhat.com>
Tested-by: Stefan Priebe <s.priebe@profihost.ag>
Tested-by: Zi Yan <zi.yan@cs.rutgers.edu>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi,
this is a follow up for [1]. Anrea has proposed two approaches to solve
the regression. This is an alternative implementation of the second
approach [2]. The reason for an alternative approach is that I strongly
believe that all the subtle THP gfp manipulation should be at a single
place (alloc_hugepage_direct_gfpmask) rather than spread in multiple
places with additional fixup. There is one notable difference to [2]
and that is defrag=allways behavior where I am preserving the original
behavior. The reason for that is that defrag=always has always had
tendency to stall and reclaim and we have addressed that by defining a
new default defrag mode. We can discuss this behavior later but I
believe the default mode and a regression noticed by multiple users
should be closed regardless. Hence this patch.

[2] http://lkml.kernel.org/r/20180820032640.9896-2-aarcange@redhat.com

 include/linux/mempolicy.h |  2 ++
 mm/huge_memory.c          | 26 ++++++++++++++++++--------
 mm/mempolicy.c            | 28 +---------------------------
 3 files changed, 21 insertions(+), 35 deletions(-)

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
index c3bc7e9c9a2a..56c9aac4dc86 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -629,21 +629,31 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
  *	    available
  * never: never stall for any thp allocation
  */
-static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
+static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
+	gfp_t this_node = 0;
+	struct mempolicy *pol;
+
+#ifdef CONFIG_NUMA
+	/* __GFP_THISNODE makes sense only if there is no explicit binding */
+	pol = get_vma_policy(vma, addr);
+	if (pol->mode != MPOL_BIND)
+		this_node = __GFP_THISNODE;
+	mpol_cond_put(pol);
+#endif
 
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
+		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY | this_node);
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
@@ -715,7 +725,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			pte_free(vma->vm_mm, pgtable);
 		return ret;
 	}
-	gfp = alloc_hugepage_direct_gfpmask(vma);
+	gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
 	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
 	if (unlikely(!page)) {
 		count_vm_event(THP_FAULT_FALLBACK);
@@ -1290,7 +1300,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 alloc:
 	if (transparent_hugepage_enabled(vma) &&
 	    !transparent_hugepage_debug_cow()) {
-		huge_gfp = alloc_hugepage_direct_gfpmask(vma);
+		huge_gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
 		new_page = alloc_hugepage_vma(huge_gfp, vma, haddr, HPAGE_PMD_ORDER);
 	} else
 		new_page = NULL;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index da858f794eb6..75bbfc3d6233 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1648,7 +1648,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * freeing by another task.  It is the caller's responsibility to free the
  * extra reference for shared policies.
  */
-static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 						unsigned long addr)
 {
 	struct mempolicy *pol = __get_vma_policy(vma, addr);
@@ -2026,32 +2026,6 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
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
-			page = __alloc_pages_node(hpage_node,
-						gfp | __GFP_THISNODE, order);
-			goto out;
-		}
-	}
-
 	nmask = policy_nodemask(gfp, pol);
 	preferred_nid = policy_node(gfp, pol, node);
 	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
-- 
2.18.0

