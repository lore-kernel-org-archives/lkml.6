Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162159AbeE1KgB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162136AbeE1Kfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:35:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 214/329] mm, thp: do not cause memcg oom for thp
Date: Mon, 28 May 2018 12:02:23 +0200
Message-Id: <20180528100259.976572800@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rientjes <rientjes@google.com>

[ Upstream commit 9d3c3354bb85bab4d865fe95039443f09a4c8394 ]

Commit 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and
madvised allocations") changed the page allocator to no longer detect
thp allocations based on __GFP_NORETRY.

It did not, however, modify the mem cgroup try_charge() path to avoid
oom kill for either khugepaged collapsing or thp faulting.  It is never
expected to oom kill a process to allocate a hugepage for thp; reclaim
is governed by the thp defrag mode and MADV_HUGEPAGE, but allocations
(and charging) should fallback instead of oom killing processes.

Link: http://lkml.kernel.org/r/alpine.DEB.2.20.1803191409420.124411@chino.kir.corp.google.com
Fixes: 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and madvised allocations")
Signed-off-by: David Rientjes <rientjes@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/huge_memory.c |    5 +++--
 mm/khugepaged.c  |    8 ++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -542,7 +542,8 @@ static int __do_huge_pmd_anonymous_page(
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, gfp, &memcg, true)) {
+	if (mem_cgroup_try_charge(page, vma->vm_mm, gfp | __GFP_NORETRY, &memcg,
+				  true)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
@@ -1060,7 +1061,7 @@ alloc:
 	}
 
 	if (unlikely(mem_cgroup_try_charge(new_page, vma->vm_mm,
-					huge_gfp, &memcg, true))) {
+				huge_gfp | __GFP_NORETRY, &memcg, true))) {
 		put_page(new_page);
 		split_huge_pmd(vma, fe->pmd, fe->address);
 		if (page)
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -963,7 +963,9 @@ static void collapse_huge_page(struct mm
 		goto out_nolock;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg, true))) {
+	/* Do not oom kill for khugepaged charges */
+	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp | __GFP_NORETRY,
+					   &memcg, true))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
@@ -1323,7 +1325,9 @@ static void collapse_shmem(struct mm_str
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp, &memcg, true))) {
+	/* Do not oom kill for khugepaged charges */
+	if (unlikely(mem_cgroup_try_charge(new_page, mm, gfp | __GFP_NORETRY,
+					   &memcg, true))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
