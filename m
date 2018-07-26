Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD24520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD24520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeGZIrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:47:09 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60810 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbeGZIrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:47:09 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 57F34C761B9189448E38;
        Thu, 26 Jul 2018 15:31:31 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6Q7VRZF089824;
        Thu, 26 Jul 2018 15:31:27 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072615313446-1934739 ;
          Thu, 26 Jul 2018 15:31:34 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        hillf.zj@alibaba-inc.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, n-horiguchi@ah.jp.nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH v2] mm: fix page_freeze_refs and page_unfreeze_refs in comments.
Date:   Thu, 26 Jul 2018 15:30:26 +0800
Message-Id: <1532590226-106038-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-26 15:31:34,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-26 15:31:15,
        Serialize complete at 2018-07-26 15:31:15
X-MAIL: mse01.zte.com.cn w6Q7VRZF089824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_freeze_refs/page_unfreeze_refs have already been relplaced by
page_ref_freeze/page_ref_unfreeze , but they are not modified in
the comments.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
v1: fix comments in vmscan.
v2: fix other two places and fix typoes.

 mm/ksm.c            | 4 ++--
 mm/memory-failure.c | 2 +-
 mm/vmscan.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index a6d43cf..4c39cb67 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -703,7 +703,7 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
 	 * We cannot do anything with the page while its refcount is 0.
 	 * Usually 0 means free, or tail of a higher-order page: in which
 	 * case this node is no longer referenced, and should be freed;
-	 * however, it might mean that the page is under page_freeze_refs().
+	 * however, it might mean that the page is under page_ref_freeze().
 	 * The __remove_mapping() case is easy, again the node is now stale;
 	 * but if page is swapcache in migrate_page_move_mapping(), it might
 	 * still be our page, in which case it's essential to keep the node.
@@ -714,7 +714,7 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
 		 * work here too.  We have chosen the !PageSwapCache test to
 		 * optimize the common case, when the page is or is about to
 		 * be freed: PageSwapCache is cleared (under spin_lock_irq)
-		 * in the freeze_refs section of __remove_mapping(); but Anon
+		 * in the ref_freeze section of __remove_mapping(); but Anon
 		 * page->mapping reset to NULL later, in free_pages_prepare().
 		 */
 		if (!PageSwapCache(page))
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9d142b9..c83a174 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1167,7 +1167,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 *    R/W the page; let's pray that the page has been
 	 *    used and will be freed some time later.
 	 * In fact it's dangerous to directly bump up page count from 0,
-	 * that may make page_freeze_refs()/page_unfreeze_refs() mismatch.
+	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
 	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
 		if (is_free_buddy_page(p)) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f8..02d0c20 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -744,7 +744,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		refcount = 2;
 	if (!page_ref_freeze(page, refcount))
 		goto cannot_free;
-	/* note: atomic_cmpxchg in page_freeze_refs provides the smp_rmb */
+	/* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */
 	if (unlikely(PageDirty(page))) {
 		page_ref_unfreeze(page, refcount);
 		goto cannot_free;
-- 
2.7.4

