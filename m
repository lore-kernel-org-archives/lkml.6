Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeBITMP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:12:15 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57203 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752110AbeBITMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:12:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SxxDJg-_1518203521;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: kirill.shutemov@linux.intel.com, gavin.dg@linux.alibaba.com,
        akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: thp: fix potential clearing to referenced flag in page_idle_clear_pte_refs_one()
Date: Sat, 10 Feb 2018 03:12:01 +0800
Message-Id: <1518203521-81173-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PTE-mapped THP, the compound THP has not been split to normal 4K
pages yet, the whole THP is considered referenced if any one of sub
page is referenced.

When walking PTE-mapped THP by pvmw, all relevant PTEs will be checked
to retrieve referenced bit. But, the current code just returns the
result of the last PTE. If the last PTE has not referenced, the
referenced flag will be cleared.

Just did logical OR for referenced to get the correct result.

Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: adopted the suggestion from Kirill. Not use "||=" style to keep checkpatch
quiet, otherwise it reports ERROR: spaces required around that '||'

 mm/page_idle.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 0a49374..a4baec9 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -65,11 +65,15 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
-			referenced = ptep_clear_young_notify(vma, addr,
-					pvmw.pte);
+			/*
+			 * For PTE-mapped THP, one sub page is referenced,
+			 * the whole THP is referenced.
+			 */
+			referenced = referenced || ptep_clear_young_notify(vma,
+					addr, pvmw.pte);
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-			referenced = pmdp_clear_young_notify(vma, addr,
-					pvmw.pmd);
+			referenced = referenced || pmdp_clear_young_notify(vma,
+					addr, pvmw.pmd);
 		} else {
 			/* unexpected pmd-mapped page? */
 			WARN_ON_ONCE(1);
-- 
1.8.3.1
