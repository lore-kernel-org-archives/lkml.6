Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 71999C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27699208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27699208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964890AbeFMVKu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:10:50 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:49469 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935852AbeFMVJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:09:17 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Jun 2018 14:08:50 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id F3756409C0;
        Wed, 13 Jun 2018 14:09:15 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 5/7] vmw_balloon: remove inflation rate limiting
Date:   Wed, 13 Jun 2018 06:54:10 -0700
Message-ID: <20180613135412.81660-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613135412.81660-1-namit@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 33d268ed0019 ("VMware balloon: Do not limit the amount of
frees and allocations in non-sleep mode."), the allocations are not
increased, and therefore balloon inflation rate limiting is in practice
broken.

While we can restore rate limiting, in practice we see that it can
result in adverse effect, as the hypervisor throttles down the VM if it
does not respond well enough, or alternatively causes it to perform very
poorly as the host swaps out the VM memory. Throttling the VM down can
even have a cascading effect, in which the VM reclaims memory even
slower and consequentially throttled down even further.

We therefore remove all the rate limiting mechanisms, including the slow
allocation cycles, as they are likely to do more harm than good.

Fixes: 33d268ed0019 ("VMware balloon: Do not limit the amount of frees and allocations in non-sleep mode.")

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 92 +++++---------------------------------
 1 file changed, 11 insertions(+), 81 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index e7cfc85f6961..400a1ccefc8e 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -54,25 +54,6 @@ MODULE_ALIAS("dmi:*:svnVMware*:*");
 MODULE_ALIAS("vmware_vmmemctl");
 MODULE_LICENSE("GPL");
 
-/*
- * Various constants controlling rate of inflaint/deflating balloon,
- * measured in pages.
- */
-
-/*
- * Rates of memory allocaton when guest experiences memory pressure
- * (driver performs sleeping allocations).
- */
-#define VMW_BALLOON_RATE_ALLOC_MIN	512U
-#define VMW_BALLOON_RATE_ALLOC_MAX	2048U
-#define VMW_BALLOON_RATE_ALLOC_INC	16U
-
-/*
- * When guest is under memory pressure, use a reduced page allocation
- * rate for next several cycles.
- */
-#define VMW_BALLOON_SLOW_CYCLES		4
-
 /*
  * Use __GFP_HIGHMEM to allow pages from HIGHMEM zone. We don't
  * allow wait (__GFP_RECLAIM) for NOSLEEP page allocations. Use
@@ -284,12 +265,6 @@ struct vmballoon {
 	/* reset flag */
 	bool reset_required;
 
-	/* adjustment rates (pages per second) */
-	unsigned int rate_alloc;
-
-	/* slowdown page allocations for next few cycles */
-	unsigned int slow_allocation_cycles;
-
 	unsigned long capabilities;
 
 	struct vmballoon_batch_page *batch_page;
@@ -797,8 +772,6 @@ static void vmballoon_add_batched_page(struct vmballoon *b, int idx,
  */
 static void vmballoon_inflate(struct vmballoon *b)
 {
-	unsigned rate;
-	unsigned int allocations = 0;
 	unsigned int num_pages = 0;
 	int error = 0;
 	gfp_t flags = VMW_PAGE_ALLOC_NOSLEEP;
@@ -825,17 +798,9 @@ static void vmballoon_inflate(struct vmballoon *b)
 	 * Start with no sleep allocation rate which may be higher
 	 * than sleeping allocation rate.
 	 */
-	if (b->slow_allocation_cycles) {
-		rate = b->rate_alloc;
-		is_2m_pages = false;
-	} else {
-		rate = UINT_MAX;
-		is_2m_pages =
-			b->supported_page_sizes == VMW_BALLOON_NUM_PAGE_SIZES;
-	}
+	is_2m_pages = b->supported_page_sizes == VMW_BALLOON_NUM_PAGE_SIZES;
 
-	pr_debug("%s - goal: %d, no-sleep rate: %u, sleep rate: %d\n",
-		 __func__, b->target - b->size, rate, b->rate_alloc);
+	pr_debug("%s - goal: %d",  __func__, b->target - b->size);
 
 	while (!b->reset_required &&
 		b->size + num_pages * vmballoon_page_size(is_2m_pages)
@@ -868,31 +833,24 @@ static void vmballoon_inflate(struct vmballoon *b)
 			if (flags == VMW_PAGE_ALLOC_CANSLEEP) {
 				/*
 				 * CANSLEEP page allocation failed, so guest
-				 * is under severe memory pressure. Quickly
-				 * decrease allocation rate.
+				 * is under severe memory pressure. We just log
+				 * the event, but do not stop the inflation
+				 * due to its negative impact on performance.
 				 */
-				b->rate_alloc = max(b->rate_alloc / 2,
-						    VMW_BALLOON_RATE_ALLOC_MIN);
 				STATS_INC(b->stats.sleep_alloc_fail);
 				break;
 			}
 
 			/*
 			 * NOSLEEP page allocation failed, so the guest is
-			 * under memory pressure. Let us slow down page
-			 * allocations for next few cycles so that the guest
-			 * gets out of memory pressure. Also, if we already
-			 * allocated b->rate_alloc pages, let's pause,
-			 * otherwise switch to sleeping allocations.
+			 * under memory pressure. Slowing down page alloctions
+			 * seems to be reasonable, but doing so might actually
+			 * cause the hypervisor to throttle us down, resulting
+			 * in degraded performance. We will count on the
+			 * scheduler and standard memory management mechanisms
+			 * for now.
 			 */
-			b->slow_allocation_cycles = VMW_BALLOON_SLOW_CYCLES;
-
-			if (allocations >= b->rate_alloc)
-				break;
-
 			flags = VMW_PAGE_ALLOC_CANSLEEP;
-			/* Lower rate for sleeping allocations. */
-			rate = b->rate_alloc;
 			continue;
 		}
 
@@ -906,28 +864,11 @@ static void vmballoon_inflate(struct vmballoon *b)
 		}
 
 		cond_resched();
-
-		if (allocations >= rate) {
-			/* We allocated enough pages, let's take a break. */
-			break;
-		}
 	}
 
 	if (num_pages > 0)
 		b->ops->lock(b, num_pages, is_2m_pages, &b->target);
 
-	/*
-	 * We reached our goal without failures so try increasing
-	 * allocation rate.
-	 */
-	if (error == 0 && allocations >= b->rate_alloc) {
-		unsigned int mult = allocations / b->rate_alloc;
-
-		b->rate_alloc =
-			min(b->rate_alloc + mult * VMW_BALLOON_RATE_ALLOC_INC,
-			    VMW_BALLOON_RATE_ALLOC_MAX);
-	}
-
 	vmballoon_release_refused_pages(b, true);
 	vmballoon_release_refused_pages(b, false);
 }
@@ -1122,9 +1063,6 @@ static void vmballoon_work(struct work_struct *work)
 	if (b->reset_required)
 		vmballoon_reset(b);
 
-	if (b->slow_allocation_cycles > 0)
-		b->slow_allocation_cycles--;
-
 	if (!b->reset_required && vmballoon_send_get_target(b, &target)) {
 		/* update target, adjust size */
 		b->target = target;
@@ -1168,11 +1106,6 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 		   "current:            %8d pages\n",
 		   b->target, b->size);
 
-	/* format rate info */
-	seq_printf(f,
-		   "rateSleepAlloc:     %8d pages/sec\n",
-		   b->rate_alloc);
-
 	seq_printf(f,
 		   "\n"
 		   "timer:              %8u\n"
@@ -1279,9 +1212,6 @@ static int __init vmballoon_init(void)
 		INIT_LIST_HEAD(&balloon.page_sizes[is_2m_pages].refused_pages);
 	}
 
-	/* initialize rates */
-	balloon.rate_alloc = VMW_BALLOON_RATE_ALLOC_MAX;
-
 	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
 
 	error = vmballoon_debugfs_init(&balloon);
-- 
2.17.0

