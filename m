Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeCOPX7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:23:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:31806 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932453AbeCOPX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:23:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="183051704"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/khugepaged: Convert VM_BUG_ON() to collapse fail
Date: Thu, 15 Mar 2018 18:23:53 +0300
Message-Id: <20180315152353.27989-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

khugepaged is not yet able to convert PTE-mapped huge pages back to PMD
mapped. We do not collapse such pages. See check khugepaged_scan_pmd().

But if between khugepaged_scan_pmd() and __collapse_huge_page_isolate()
somebody managed to instantiate THP in the range and then split the PMD
back to PTEs we would have a problem -- VM_BUG_ON_PAGE(PageCompound(page))
will get triggered.

It's possible since we drop mmap_sem during collapse to re-take for
write.

Replace the VM_BUG_ON() with graceful collapse fail.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: b1caa957ae6d ("khugepaged: ignore pmd tables with THP mapped with ptes")
---
 mm/khugepaged.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b7e2268dfc9a..c15da1ea7e63 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -530,7 +530,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 
-		VM_BUG_ON_PAGE(PageCompound(page), page);
+		/* TODO: teach khugepaged to collapse THP mapped with pte */
+		if (PageCompound(page)) {
+			result = SCAN_PAGE_COMPOUND;
+			goto out;
+		}
+
 		VM_BUG_ON_PAGE(!PageAnon(page), page);
 
 		/*
-- 
2.16.1
