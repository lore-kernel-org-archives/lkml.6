Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCLQm1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:42:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751344AbeCLQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:42:26 -0400
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, aarcange@redhat.com, minchan@kernel.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org, hughd@google.com,
        pholasek@redhat.com, borntraeger@de.ibm.com,
        gerald.schaefer@de.ibm.com
Subject: [PATCH v1 1/1] mm/ksm: fix interaction with THP
Date: Mon, 12 Mar 2018 17:42:17 +0100
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18031216-0020-0000-0000-00000402741D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031216-0021-0000-0000-00004296C5A3
Message-Id: <1520872937-15351-1-git-send-email-imbrenda@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803120189
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

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 mm/ksm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 293721f..7a826fa 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2001,7 +2001,7 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
 	struct page *kpage;
 	unsigned int checksum;
 	int err;
-	bool max_page_sharing_bypass = false;
+	bool split, max_page_sharing_bypass = false;
 
 	stable_node = page_stable_node(page);
 	if (stable_node) {
@@ -2084,6 +2084,8 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
 	if (tree_rmap_item) {
 		kpage = try_to_merge_two_pages(rmap_item, page,
 						tree_rmap_item, tree_page);
+		split = PageTransCompound(page) && PageTransCompound(tree_page)
+			&& compound_head(page) == compound_head(tree_page);
 		put_page(tree_page);
 		if (kpage) {
 			/*
@@ -2110,6 +2112,11 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
 				break_cow(tree_rmap_item);
 				break_cow(rmap_item);
 			}
+		} else if (split) {
+			if (!trylock_page(page))
+				return;
+			split_huge_page(page);
+			unlock_page(page);
 		}
 	}
 }
-- 
2.7.4
