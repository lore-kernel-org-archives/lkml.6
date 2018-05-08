Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeEHB2N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:28:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:40866 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753108AbeEHB2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:28:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,376,1520924400";
   d="scan'208";a="37590221"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrei Vagin <avagin@openvz.org>, Michal Hocko <mhocko@suse.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Daniel Colascione <dancol@google.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH -mm] mm, pagemap: Hide swap entry for unprivileged users
Date: Tue,  8 May 2018 09:27:45 +0800
Message-Id: <20180508012745.7238-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In ab676b7d6fbf ("pagemap: do not leak physical addresses to
non-privileged userspace"), the /proc/PID/pagemap is restricted to be
readable only by CAP_SYS_ADMIN to address some security issue.  In
1c90308e7a77 ("pagemap: hide physical addresses from non-privileged
users"), the restriction is relieved to make /proc/PID/pagemap
readable, but hide the physical addresses for non-privileged users.
But the swap entries are readable for non-privileged users too.  This
has some security issues.  For example, for page under migrating, the
swap entry has physical address information.  So, in this patch, the
swap entries are hided for non-privileged users too.

Fixes: 1c90308e7a77 ("pagemap: hide physical addresses from non-privileged users")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 fs/proc/task_mmu.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index a20c6e495bb2..ff947fdd7c71 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1258,8 +1258,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		entry = pte_to_swp_entry(pte);
-		frame = swp_type(entry) |
-			(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
+		if (pm->show_pfn)
+			frame = swp_type(entry) |
+				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
 		flags |= PM_SWAP;
 		if (is_migration_entry(entry))
 			page = migration_entry_to_page(entry);
@@ -1310,11 +1311,14 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		else if (is_swap_pmd(pmd)) {
 			swp_entry_t entry = pmd_to_swp_entry(pmd);
-			unsigned long offset = swp_offset(entry);
+			unsigned long offset;
 
-			offset += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-			frame = swp_type(entry) |
-				(offset << MAX_SWAPFILES_SHIFT);
+			if (pm->show_pfn) {
+				offset = swp_offset(entry) +
+					((addr & ~PMD_MASK) >> PAGE_SHIFT);
+				frame = swp_type(entry) |
+					(offset << MAX_SWAPFILES_SHIFT);
+			}
 			flags |= PM_SWAP;
 			if (pmd_swp_soft_dirty(pmd))
 				flags |= PM_SOFT_DIRTY;
@@ -1332,10 +1336,12 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			err = add_to_pagemap(addr, &pme, pm);
 			if (err)
 				break;
-			if (pm->show_pfn && (flags & PM_PRESENT))
-				frame++;
-			else if (flags & PM_SWAP)
-				frame += (1 << MAX_SWAPFILES_SHIFT);
+			if (pm->show_pfn) {
+				if (flags & PM_PRESENT)
+					frame++;
+				else if (flags & PM_SWAP)
+					frame += (1 << MAX_SWAPFILES_SHIFT);
+			}
 		}
 		spin_unlock(ptl);
 		return err;
-- 
2.17.0
