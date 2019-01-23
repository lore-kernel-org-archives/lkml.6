Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0598C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868DA218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfAWXxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:53:04 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46711 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfAWXxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:53:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TIsDp.m_1548287573;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TIsDp.m_1548287573)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jan 2019 07:52:59 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, hughd@google.com, aarcange@redhat.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: ksm: do not block on page lock when searching stable tree
Date:   Thu, 24 Jan 2019 07:52:53 +0800
Message-Id: <1548287573-15084-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksmd need search stable tree to look for the suitable KSM page, but the
KSM page might be locked for a while due to i.e. KSM page rmap walk.
Basically it is not a big deal since commit 2c653d0ee2ae
("ksm: introduce ksm_max_page_sharing per page deduplication limit"),
since max_page_sharing limits the number of shared KSM pages.

But it still sounds not worth waiting for the lock, the page can be skip,
then try to merge it in the next scan to avoid potential stall if its
content is still intact.

Introduce async mode to get_ksm_page() to not block on page lock, like
what try_to_merge_one_page() does.

Return -EBUSY if trylock fails, since NULL means not find suitable KSM
page, which is a valid case.

With the default max_page_sharing setting (256), there is almost no
observed change comparing lock vs trylock.

However, with ksm02 of LTP, the reduced ksmd full scan time can be
observed, which has set max_page_sharing to 786432.  With lock version,
ksmd may tak 10s - 11s to run two full scans, with trylock version ksmd
may take 8s - 11s to run two full scans.  And, the number of
pages_sharing and pages_to_scan keep same.  Basically, this change has
no harm.

Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
Hi folks,

This patch was with "mm: vmscan: skip KSM page in direct reclaim if priority
is low" in the initial submission.  Then Hugh and Andrea pointed out commit
2c653d0ee2ae ("ksm: introduce ksm_max_page_sharing per page deduplication
limit") is good enough for limiting the number of shared KSM page to prevent
from softlock when walking ksm page rmap.  This commit does solve the problem.
So, the series was dropped by Andrew from -mm tree.

However, I thought the second patch (this one) still sounds useful.  So, I did
some test and resubmit it.  The first version was reviewed by Krill Tkhai, so
I keep his Reviewed-by tag since there is no change to the patch except the
commit log.

So, would you please reconsider this patch?

v2: Updated the commit log to reflect some test result and latest discussion

 mm/ksm.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 6c48ad1..f66405c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -668,7 +668,7 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
 }
 
 /*
- * get_ksm_page: checks if the page indicated by the stable node
+ * __get_ksm_page: checks if the page indicated by the stable node
  * is still its ksm page, despite having held no reference to it.
  * In which case we can trust the content of the page, and it
  * returns the gotten page; but if the page has now been zapped,
@@ -686,7 +686,8 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
  * a page to put something that might look like our key in page->mapping.
  * is on its way to being freed; but it is an anomaly to bear in mind.
  */
-static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
+static struct page *__get_ksm_page(struct stable_node *stable_node,
+				   bool lock_it, bool async)
 {
 	struct page *page;
 	void *expected_mapping;
@@ -729,7 +730,14 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
 	}
 
 	if (lock_it) {
-		lock_page(page);
+		if (async) {
+			if (!trylock_page(page)) {
+				put_page(page);
+				return ERR_PTR(-EBUSY);
+			}
+		} else
+			lock_page(page);
+
 		if (READ_ONCE(page->mapping) != expected_mapping) {
 			unlock_page(page);
 			put_page(page);
@@ -752,6 +760,11 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
 	return NULL;
 }
 
+static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
+{
+	return __get_ksm_page(stable_node, lock_it, false);
+}
+
 /*
  * Removing rmap_item from stable or unstable tree.
  * This function will clean the information from the stable/unstable tree.
@@ -1673,7 +1686,11 @@ static struct page *stable_tree_search(struct page *page)
 			 * It would be more elegant to return stable_node
 			 * than kpage, but that involves more changes.
 			 */
-			tree_page = get_ksm_page(stable_node_dup, true);
+			tree_page = __get_ksm_page(stable_node_dup, true, true);
+
+			if (PTR_ERR(tree_page) == -EBUSY)
+				return ERR_PTR(-EBUSY);
+
 			if (unlikely(!tree_page))
 				/*
 				 * The tree may have been rebalanced,
@@ -2060,6 +2077,10 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
 
 	/* We first start with searching the page inside the stable tree */
 	kpage = stable_tree_search(page);
+
+	if (PTR_ERR(kpage) == -EBUSY)
+		return;
+
 	if (kpage == page && rmap_item->head == stable_node) {
 		put_page(kpage);
 		return;
-- 
1.8.3.1

