Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6472ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8222121537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8222121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeI0B3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:38 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25069 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbeI0B3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:37 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:05 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 784F7B05DE;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 05/20] vmw_balloon: remove sleeping allocations
Date:   Wed, 26 Sep 2018 12:13:21 -0700
Message-ID: <20180926191336.101885-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting the allocations between sleeping and non-sleeping made some
sort of sense as long as rate-limiting was enabled. Now that it is
removed, we need to decide - either we want sleeping allocations or not.

Since no other Linux balloon driver (hv, Xen, virtio) uses sleeping
allocations, use the same approach.

We do distinguish, however, between 2MB allocations and 4kB allocations
and prevent reclamation on 2MB. In both cases, we avoid using emergency
low-memory pools, as it may cause undesired effects.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 67 ++++++++++----------------------------
 1 file changed, 18 insertions(+), 49 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 7af70fc988b9..952308997499 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -37,20 +37,20 @@ MODULE_ALIAS("vmware_vmmemctl");
 MODULE_LICENSE("GPL");
 
 /*
- * Use __GFP_HIGHMEM to allow pages from HIGHMEM zone. We don't
- * allow wait (__GFP_RECLAIM) for NOSLEEP page allocations. Use
- * __GFP_NOWARN, to suppress page allocation failure warnings.
+ * Use __GFP_HIGHMEM to allow pages from HIGHMEM zone. We don't allow wait
+ * (__GFP_RECLAIM) for huge page allocations. Use __GFP_NOWARN, to suppress page
+ * allocation failure warnings. Disallow access to emergency low-memory pools.
  */
-#define VMW_PAGE_ALLOC_NOSLEEP		(__GFP_HIGHMEM|__GFP_NOWARN)
+#define VMW_HUGE_PAGE_ALLOC_FLAGS	(__GFP_HIGHMEM|__GFP_NOWARN|	\
+					 __GFP_NOMEMALLOC)
 
 /*
- * Use GFP_HIGHUSER when executing in a separate kernel thread
- * context and allocation can sleep.  This is less stressful to
- * the guest memory system, since it allows the thread to block
- * while memory is reclaimed, and won't take pages from emergency
- * low-memory pools.
+ * Use __GFP_HIGHMEM to allow pages from HIGHMEM zone. We allow lightweight
+ * reclamation (__GFP_NORETRY). Use __GFP_NOWARN, to suppress page allocation
+ * failure warnings. Disallow access to emergency low-memory pools.
  */
-#define VMW_PAGE_ALLOC_CANSLEEP		(GFP_HIGHUSER)
+#define VMW_PAGE_ALLOC_FLAGS		(__GFP_HIGHMEM|__GFP_NOWARN|	\
+					 __GFP_NOMEMALLOC|__GFP_NORETRY)
 
 /* Maximum number of refused pages we accumulate during inflation cycle */
 #define VMW_BALLOON_MAX_REFUSED		16
@@ -151,8 +151,6 @@ struct vmballoon_stats {
 	/* allocation statistics */
 	unsigned int alloc[VMW_BALLOON_NUM_PAGE_SIZES];
 	unsigned int alloc_fail[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int sleep_alloc;
-	unsigned int sleep_alloc_fail;
 	unsigned int refused_alloc[VMW_BALLOON_NUM_PAGE_SIZES];
 	unsigned int refused_free[VMW_BALLOON_NUM_PAGE_SIZES];
 	unsigned int free[VMW_BALLOON_NUM_PAGE_SIZES];
@@ -442,12 +440,13 @@ static int vmballoon_send_batched_lock(struct vmballoon *b,
 	return 1;
 }
 
-static struct page *vmballoon_alloc_page(gfp_t flags, bool is_2m_page)
+static struct page *vmballoon_alloc_page(bool is_2m_page)
 {
 	if (is_2m_page)
-		return alloc_pages(flags, VMW_BALLOON_2M_SHIFT);
+		return alloc_pages(VMW_HUGE_PAGE_ALLOC_FLAGS,
+				   VMW_BALLOON_2M_SHIFT);
 
-	return alloc_page(flags);
+	return alloc_page(VMW_PAGE_ALLOC_FLAGS);
 }
 
 static void vmballoon_free_page(struct page *page, bool is_2m_page)
@@ -701,7 +700,6 @@ static void vmballoon_inflate(struct vmballoon *b)
 {
 	unsigned int num_pages = 0;
 	int error = 0;
-	gfp_t flags = VMW_PAGE_ALLOC_NOSLEEP;
 	bool is_2m_pages;
 
 	pr_debug("%s - size: %d, target %d\n", __func__, b->size, b->target);
@@ -734,15 +732,10 @@ static void vmballoon_inflate(struct vmballoon *b)
 		< b->target) {
 		struct page *page;
 
-		if (flags == VMW_PAGE_ALLOC_NOSLEEP)
-			STATS_INC(b->stats.alloc[is_2m_pages]);
-		else
-			STATS_INC(b->stats.sleep_alloc);
-
-		page = vmballoon_alloc_page(flags, is_2m_pages);
+		STATS_INC(b->stats.alloc[is_2m_pages]);
+		page = vmballoon_alloc_page(is_2m_pages);
 		if (!page) {
 			STATS_INC(b->stats.alloc_fail[is_2m_pages]);
-
 			if (is_2m_pages) {
 				b->ops->lock(b, num_pages, true);
 
@@ -756,29 +749,7 @@ static void vmballoon_inflate(struct vmballoon *b)
 				is_2m_pages = false;
 				continue;
 			}
-
-			if (flags == VMW_PAGE_ALLOC_CANSLEEP) {
-				/*
-				 * CANSLEEP page allocation failed, so guest
-				 * is under severe memory pressure. We just log
-				 * the event, but do not stop the inflation
-				 * due to its negative impact on performance.
-				 */
-				STATS_INC(b->stats.sleep_alloc_fail);
-				break;
-			}
-
-			/*
-			 * NOSLEEP page allocation failed, so the guest is
-			 * under memory pressure. Slowing down page alloctions
-			 * seems to be reasonable, but doing so might actually
-			 * cause the hypervisor to throttle us down, resulting
-			 * in degraded performance. We will count on the
-			 * scheduler and standard memory management mechanisms
-			 * for now.
-			 */
-			flags = VMW_PAGE_ALLOC_CANSLEEP;
-			continue;
+			break;
 		}
 
 		b->ops->add_page(b, num_pages++, page);
@@ -1044,8 +1015,7 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 		   "timer:              %8u\n"
 		   "doorbell:           %8u\n"
 		   "prim2mAlloc:        %8u (%4u failed)\n"
-		   "primNoSleepAlloc:   %8u (%4u failed)\n"
-		   "primCanSleepAlloc:  %8u (%4u failed)\n"
+		   "prim4kAlloc:        %8u (%4u failed)\n"
 		   "prim2mFree:         %8u\n"
 		   "primFree:           %8u\n"
 		   "err2mAlloc:         %8u\n"
@@ -1056,7 +1026,6 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 		   stats->doorbell,
 		   stats->alloc[true], stats->alloc_fail[true],
 		   stats->alloc[false], stats->alloc_fail[false],
-		   stats->sleep_alloc, stats->sleep_alloc_fail,
 		   stats->free[true],
 		   stats->free[false],
 		   stats->refused_alloc[true], stats->refused_alloc[false],
-- 
2.17.1

