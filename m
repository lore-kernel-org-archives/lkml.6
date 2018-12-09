Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE782C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46A220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46A220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeLIV4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:56:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35962 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726679AbeLIVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:34 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72x-0002ii-9u; Sun, 09 Dec 2018 21:55:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72j-0003bh-AG; Sun, 09 Dec 2018 21:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jens Axboe" <axboe@fb.com>,
        "Tejun Heo" <tj@kernel.org>,
        "Bhaktipriya Shridhar" <bhaktipriya96@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.983797498@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 266/328] bcache: Remove deprecated create_workqueue
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

commit 81baf90af2dcc8259e99e2f236024524b55313fc upstream.

alloc_workqueue replaces deprecated create_workqueue().

Dedicated workqueues have been used since bcache_wq and moving_gc_wq
are workqueues for writes and are being used on a memory reclaim path.
WQ_MEM_RECLAIM has been set to ensure forward progress under memory
pressure.
Since there are only a fixed number of work items, explicit concurrency
limit is unnecessary here.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1543,7 +1543,8 @@ struct cache_set *bch_cache_set_alloc(st
 	    !(c->fill_iter = mempool_create_kmalloc_pool(1, iter_size)) ||
 	    !(c->bio_split = bioset_create(4, offsetof(struct bbio, bio))) ||
 	    !(c->uuids = alloc_bucket_pages(GFP_KERNEL, c)) ||
-	    !(c->moving_gc_wq = create_workqueue("bcache_gc")) ||
+	    !(c->moving_gc_wq = alloc_workqueue("bcache_gc",
+						WQ_MEM_RECLAIM, 0)) ||
 	    bch_journal_alloc(c) ||
 	    bch_btree_cache_alloc(c) ||
 	    bch_open_buckets_alloc(c) ||
@@ -2135,7 +2136,7 @@ static int __init bcache_init(void)
 		return bcache_major;
 	}
 
-	if (!(bcache_wq = create_workqueue("bcache")) ||
+	if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
 	    !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
 	    sysfs_create_files(bcache_kobj, files) ||
 	    bch_request_init() ||

