Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbeCPNmq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:42:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751454AbeCPNmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:42:45 -0400
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, aarcange@redhat.com, minchan@kernel.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org, hughd@google.com,
        borntraeger@de.ibm.com, gerald.schaefer@de.ibm.com
Subject: [PATCH v2 1/1] mm/ksm: fix interaction with THP
Date: Fri, 16 Mar 2018 14:42:35 +0100
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18031613-0040-0000-0000-00000421F5A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031613-0041-0000-0000-000026250306
Message-Id: <1521207755-28381-1-git-send-email-imbrenda@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a corner case for KSM. When two pages belong or
belonged to the same transparent hugepage, and they should be merged,
KSM fails to split the page, and therefore no merging happens.

This bug can be reproduced by:
* making sure ksm is running (in case disabling ksmtuned)
* enabling transparent hugepages
* allocating a THP-aligned 1-THP-sized buffer
  e.g. on amd64: posix_memalign(&p, 1<<21, 1<<21)
* filling it with the same values
  e.g. memset(p, 42, 1<<21)
* performing madvise to make it mergeable
  e.g. madvise(p, 1<<21, MADV_MERGEABLE)
* waiting for KSM to perform a few scans

The expected outcome is that the all the pages get merged (1 shared and
the rest sharing); the actual outcome is that no pages get merged (1
unshared and the rest volatile)

The reason of this behaviour is that we increase the reference count
once for both pages we want to merge, but if they belong to the same
hugepage (or compound page), the reference counter used in both cases
is the one of the head of the compound page.
This means that split_huge_page will find a value of the reference
counter too high and will fail.

This patch solves this problem by testing if the two pages to merge
belong to the same hugepage when attempting to merge them. If so, the
hugepage is split safely. This means that the hugepage is not split if
not necessary.

Co-authored-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 mm/ksm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 293721f..882d6ec 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2082,8 +2082,22 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
 	tree_rmap_item =
 		unstable_tree_search_insert(rmap_item, page, &tree_page);
 	if (tree_rmap_item) {
+		bool split;
+
 		kpage = try_to_merge_two_pages(rmap_item, page,
 						tree_rmap_item, tree_page);
+		/*
+		 * If both pages we tried to merge belong to the same compound
+		 * page, then we actually ended up increasing the reference
+		 * count of the same compound page twice, and split_huge_page
+		 * failed.
+		 * Here we set a flag if that happened, and we use it later to
+		 * try split_huge_page again. Since we call put_page right
+		 * afterwards, the reference count will be correct and
+		 * split_huge_page should succeed.
+		 */
+		split = PageTransCompound(page) && PageTransCompound(tree_page)
+			&& compound_head(page) == compound_head(tree_page);
 		put_page(tree_page);
 		if (kpage) {
 			/*
@@ -2110,6 +2124,20 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
 				break_cow(tree_rmap_item);
 				break_cow(rmap_item);
 			}
+		} else if (split) {
+			/*
+			 * We are here if we tried to merge two pages and
+			 * failed because they both belonged to the same
+			 * compound page. We will split the page now, but no
+			 * merging will take place.
+			 * We do not want to add the cost of a full lock; if
+			 * the page is locked, it is better to skip it and
+			 * perhaps try again later.
+			 */
+			if (!trylock_page(page))
+				return;
+			split_huge_page(page);
+			unlock_page(page);
 		}
 	}
 }
-- 
2.7.4
