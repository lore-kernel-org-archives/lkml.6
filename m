Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeBIVlO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:41:14 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36438 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750993AbeBIVlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:41:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SxxV-K2_1518212451;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Cc: gavin.dg@linux.alibaba.com, yang.shi@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm: thp: fix potential clearing to referenced flag in page_idle_clear_pte_refs_one()
Date: Sat, 10 Feb 2018 05:40:51 +0800
Message-Id: <1518212451-87134-1-git-send-email-yang.shi@linux.alibaba.com>
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

Just set referenced when ptep{pmdp}_clear_young_notify() returns true.

Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v3: Fixed the insane "||" stuff pointed out by Andrew

v2: adopted the suggestion from Kirill. Not use "||=" style to keep checkpatch
quiet, otherwise it reports ERROR: spaces required around that '||'

 mm/page_idle.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 0a49374..e412a63 100644
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
+			if (ptep_clear_young_notify(vma, addr, pvmw.pte))
+				referenced = true;
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-			referenced = pmdp_clear_young_notify(vma, addr,
-					pvmw.pmd);
+			if (pmdp_clear_young_notify(vma, addr, pvmw.pmd))
+				referenced = true;
 		} else {
 			/* unexpected pmd-mapped page? */
 			WARN_ON_ONCE(1);
-- 
1.8.3.1
