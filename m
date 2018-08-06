Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E47AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D9221A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D9221A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeHFNnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:43:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:33674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728515AbeHFNnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:43:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D506AAE7B;
        Mon,  6 Aug 2018 11:34:18 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/4] xen/blkback: don't keep persistent grants too long
Date:   Mon,  6 Aug 2018 13:33:59 +0200
Message-Id: <20180806113403.24728-2-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180806113403.24728-1-jgross@suse.com>
References: <20180806113403.24728-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Persistent grants are allocated until a threshold per ring is being
reached. Those grants won't be freed until the ring is being destroyed
meaning there will be resources kept busy which might no longer be
used.

Instead of freeing only persistent grants until the threshold is
reached add a timestamp and remove all persistent grants not having
been in use for a minute.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkback/blkback.c | 77 +++++++++++++++++++++++--------------
 drivers/block/xen-blkback/common.h  |  1 +
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index b55b245e8052..485e3ecab144 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -84,6 +84,18 @@ MODULE_PARM_DESC(max_persistent_grants,
                  "Maximum number of grants to map persistently");
 
 /*
+ * How long a persistent grant is allowed to remain allocated without being in
+ * use. The time is in seconds, 0 means indefinitely long.
+ */
+
+unsigned int xen_blkif_pgrant_timeout = 60;
+module_param_named(persistent_grant_unused_seconds, xen_blkif_pgrant_timeout,
+		   uint, 0644);
+MODULE_PARM_DESC(persistent_grant_unused_seconds,
+		 "Time in seconds an unused persistent grant is allowed to "
+		 "remain allocated. Default is 60, 0 means unlimited.");
+
+/*
  * Maximum number of rings/queues blkback supports, allow as many queues as there
  * are CPUs if user has not specified a value.
  */
@@ -123,6 +135,13 @@ module_param(log_stats, int, 0644);
 /* Number of free pages to remove on each call to gnttab_free_pages */
 #define NUM_BATCH_FREE_PAGES 10
 
+static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
+{
+	return xen_blkif_pgrant_timeout &&
+	       (jiffies - persistent_gnt->last_used >=
+		HZ * xen_blkif_pgrant_timeout);
+}
+
 static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
 {
 	unsigned long flags;
@@ -278,6 +297,7 @@ static void put_persistent_gnt(struct xen_blkif_ring *ring,
 {
 	if(!test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
 		pr_alert_ratelimited("freeing a grant already unused\n");
+	persistent_gnt->last_used = jiffies;
 	set_bit(PERSISTENT_GNT_WAS_ACTIVE, persistent_gnt->flags);
 	clear_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags);
 	atomic_dec(&ring->persistent_gnt_in_use);
@@ -374,23 +394,23 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
 	bool scan_used = false, clean_used = false;
 	struct rb_root *root;
 
-	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
-	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
-	    !ring->blkif->vbd.overflow_max_grants)) {
-		goto out;
-	}
-
 	if (work_busy(&ring->persistent_purge_work)) {
 		pr_alert_ratelimited("Scheduled work from previous purge is still busy, cannot purge list\n");
 		goto out;
 	}
 
-	num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
-	num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants + num_clean;
-	num_clean = min(ring->persistent_gnt_c, num_clean);
-	if ((num_clean == 0) ||
-	    (num_clean > (ring->persistent_gnt_c - atomic_read(&ring->persistent_gnt_in_use))))
-		goto out;
+	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
+	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
+	    !ring->blkif->vbd.overflow_max_grants)) {
+		num_clean = 0;
+	} else {
+		num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
+		num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants +
+			    num_clean;
+		num_clean = min(ring->persistent_gnt_c, num_clean);
+		pr_debug("Going to purge at least %u persistent grants\n",
+			 num_clean);
+	}
 
 	/*
 	 * At this point, we can assure that there will be no calls
@@ -401,9 +421,7 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
          * number of grants.
 	 */
 
-	total = num_clean;
-
-	pr_debug("Going to purge %u persistent grants\n", num_clean);
+	total = 0;
 
 	BUG_ON(!list_empty(&ring->persistent_purge_list));
 	root = &ring->persistent_gnts;
@@ -419,39 +437,42 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
 
 		if (test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
 			continue;
-		if (!scan_used &&
+		if (!scan_used && !persistent_gnt_timeout(persistent_gnt) &&
 		    (test_bit(PERSISTENT_GNT_WAS_ACTIVE, persistent_gnt->flags)))
 			continue;
+		if (scan_used && total >= num_clean)
+			continue;
 
 		rb_erase(&persistent_gnt->node, root);
 		list_add(&persistent_gnt->remove_node,
 			 &ring->persistent_purge_list);
-		if (--num_clean == 0)
-			goto finished;
+		total++;
 	}
 	/*
-	 * If we get here it means we also need to start cleaning
+	 * Check whether we also need to start cleaning
 	 * grants that were used since last purge in order to cope
 	 * with the requested num
 	 */
-	if (!scan_used && !clean_used) {
-		pr_debug("Still missing %u purged frames\n", num_clean);
+	if (!scan_used && !clean_used && total < num_clean) {
+		pr_debug("Still missing %u purged frames\n", num_clean - total);
 		scan_used = true;
 		goto purge_list;
 	}
-finished:
-	if (!clean_used) {
+
+	if (!clean_used && num_clean) {
 		pr_debug("Finished scanning for grants to clean, removing used flag\n");
 		clean_used = true;
 		goto purge_list;
 	}
 
-	ring->persistent_gnt_c -= (total - num_clean);
-	ring->blkif->vbd.overflow_max_grants = 0;
+	if (total) {
+		ring->persistent_gnt_c -= total;
+		ring->blkif->vbd.overflow_max_grants = 0;
 
-	/* We can defer this work */
-	schedule_work(&ring->persistent_purge_work);
-	pr_debug("Purged %u/%u\n", (total - num_clean), total);
+		/* We can defer this work */
+		schedule_work(&ring->persistent_purge_work);
+		pr_debug("Purged %u/%u\n", num_clean, total);
+	}
 
 out:
 	return;
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index ecb35fe8ca8d..26710602d463 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -250,6 +250,7 @@ struct persistent_gnt {
 	struct page *page;
 	grant_ref_t gnt;
 	grant_handle_t handle;
+	unsigned long last_used;
 	DECLARE_BITMAP(flags, PERSISTENT_GNT_FLAGS_SIZE);
 	struct rb_node node;
 	struct list_head remove_node;
-- 
2.13.7

