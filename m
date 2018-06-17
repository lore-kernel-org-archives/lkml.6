Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43224C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20322086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mnOUCgq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20322086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934742AbeFQCHM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:07:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934051AbeFQCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=taP8BwheHg3CEkDXuvl7b4R9WQ7b3YzBrhJkOgu4qeA=; b=mnOUCgq42hLXgcqQvdSJolBa4
        M2pHHerVUVQEAix/TXoPd/ZLNBXq46cwsAlwSXV34gaKqxdjMLDbIBuoLXtyO82BlJoMu8EfMh9ux
        pU3APwkzHc+vWtyGCLTLQ0cASLWRek2CsfN52jLPIlRjl9TV8tFIG/BNt6M9s9LZtM+AhKQ7EzJAp
        Y0JCImZZCPzVXB8OH2ekbiLa4xE5a2zPEzVoiptNgLCITKe5yxa70ZBRvxCZSbxxWiBqH4a2eOYWC
        +vtRoNDpb/8Lt7UHE2Cbqt6i3VnUNVTgVl8WLCtiLvyowoAKYnhgT5Dk3nnSM+cKTl0E7N2qZ6y0Q
        a/tTBK1sw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN0C-0001S2-0j; Sun, 17 Jun 2018 02:01:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v14 54/74] memfd: Convert memfd_wait_for_pins to XArray
Date:   Sat, 16 Jun 2018 19:00:32 -0700
Message-Id: <20180617020052.4759-55-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the locking by taking the spinlock while we walk the tree on
the assumption that many acquires and releases of the lock will be worse
than holding the lock while we process an entire batch of pages.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memfd.c | 61 ++++++++++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 27069518e3c5..e7d6be725b7a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -21,7 +21,7 @@
 #include <uapi/linux/memfd.h>
 
 /*
- * We need a tag: a new tag would expand every radix_tree_node by 8 bytes,
+ * We need a tag: a new tag would expand every xa_node by 8 bytes,
  * so reuse a tag which we firmly believe is never set or cleared on tmpfs
  * or hugetlbfs because they are memory only filesystems.
  */
@@ -72,9 +72,7 @@ static void memfd_tag_pins(struct address_space *mapping)
  */
 static int memfd_wait_for_pins(struct address_space *mapping)
 {
-	struct radix_tree_iter iter;
-	void __rcu **slot;
-	pgoff_t start;
+	XA_STATE(xas, &mapping->i_pages, 0);
 	struct page *page;
 	int error, scan;
 
@@ -82,7 +80,9 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 
 	error = 0;
 	for (scan = 0; scan <= LAST_SCAN; scan++) {
-		if (!radix_tree_tagged(&mapping->i_pages, MEMFD_TAG_PINNED))
+		unsigned int tagged = 0;
+
+		if (!xas_tagged(&xas, MEMFD_TAG_PINNED))
 			break;
 
 		if (!scan)
@@ -90,45 +90,34 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 		else if (schedule_timeout_killable((HZ << scan) / 200))
 			scan = LAST_SCAN;
 
-		start = 0;
-		rcu_read_lock();
-		radix_tree_for_each_tagged(slot, &mapping->i_pages, &iter,
-					   start, MEMFD_TAG_PINNED) {
-
-			page = radix_tree_deref_slot(slot);
-			if (radix_tree_exception(page)) {
-				if (radix_tree_deref_retry(page)) {
-					slot = radix_tree_iter_retry(&iter);
-					continue;
-				}
-
-				page = NULL;
-			}
-
-			if (page &&
-			    page_count(page) - page_mapcount(page) != 1) {
-				if (scan < LAST_SCAN)
-					goto continue_resched;
-
+		xas_set(&xas, 0);
+		xas_lock_irq(&xas);
+		xas_for_each_tagged(&xas, page, ULONG_MAX, MEMFD_TAG_PINNED) {
+			bool clear = true;
+			if (xa_is_value(page))
+				continue;
+			if (page_count(page) - page_mapcount(page) != 1) {
 				/*
 				 * On the last scan, we clean up all those tags
 				 * we inserted; but make a note that we still
 				 * found pages pinned.
 				 */
-				error = -EBUSY;
+				if (scan == LAST_SCAN)
+					error = -EBUSY;
+				else
+					clear = false;
 			}
+			if (clear)
+				xas_clear_tag(&xas, MEMFD_TAG_PINNED);
+			if (++tagged % XA_CHECK_SCHED)
+				continue;
 
-			xa_lock_irq(&mapping->i_pages);
-			radix_tree_tag_clear(&mapping->i_pages,
-					     iter.index, MEMFD_TAG_PINNED);
-			xa_unlock_irq(&mapping->i_pages);
-continue_resched:
-			if (need_resched()) {
-				slot = radix_tree_iter_resume(slot, &iter);
-				cond_resched_rcu();
-			}
+			xas_pause(&xas);
+			xas_unlock_irq(&xas);
+			cond_resched();
+			xas_lock_irq(&xas);
 		}
-		rcu_read_unlock();
+		xas_unlock_irq(&xas);
 	}
 
 	return error;
-- 
2.17.1

