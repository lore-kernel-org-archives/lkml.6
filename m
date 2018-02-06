Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeBFAHL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:07:11 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54173 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752023AbeBFAHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:07:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SxlBK4R_1517875596;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Cc: gavin.dg@linux.alibaba.com, yang.shi@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: fix potential clearing to referenced flag in page_idle_clear_pte_refs_one()
Date: Tue,  6 Feb 2018 08:06:36 +0800
Message-Id: <1517875596-76350-1-git-send-email-yang.shi@linux.alibaba.com>
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

So, here just break pvmw walk once referenced PTE is found if the page
is a part of THP.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
---
 mm/page_idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 0a49374..da6024f 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -67,6 +67,14 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
 		if (pvmw.pte) {
 			referenced = ptep_clear_young_notify(vma, addr,
 					pvmw.pte);
+			/*
+			 * For PTE-mapped THP, one sub page is referenced,
+			 * the whole THP is referenced.
+			 */
+			if (referenced && PageTransCompound(pvmw.page)) {
+				page_vma_mapped_walk_done(&pvmw);
+				break;
+			}
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			referenced = pmdp_clear_young_notify(vma, addr,
 					pvmw.pmd);
-- 
1.8.3.1
