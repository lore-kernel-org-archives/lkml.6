Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF58C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A037221547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XcTHl2Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A037221547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbeIUMCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:02:11 -0400
Received: from m12-13.163.com ([220.181.12.13]:49064 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeIUMCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=b2d5uSng/7avURMx4E
        1zd6JSybbI6xvh7KaI6QWzlW4=; b=XcTHl2EzIBoHu2vC3kJbiU7pcaczr0dKYN
        RCT3blu7KLPcOJ0JA7N5x5Xht1QVqPN1Bvu0gZHuV5IB+Pg+M/J4q1P++1/Te1W9
        ZbNyPNFKXb5+g66kzerjVnJz8774WV1LEackcNTN5unTdVD3VzaNuLh52rok6he7
        RaY0vifKI=
Received: from localhost.localdomain (unknown [223.104.3.30])
        by smtp9 (Coremail) with SMTP id DcCowAAHKXRJjKRblgDEKA--.58179S4;
        Fri, 21 Sep 2018 14:14:34 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH] bug fix for making cache device failed
Date:   Fri, 21 Sep 2018 14:14:18 +0800
Message-Id: <20180921061418.3131-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowAAHKXRJjKRblgDEKA--.58179S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1rWr47AFyktFW5ZFWDArb_yoWrZr1DpF
        Z3JryYkF4rtw17ZrnxJr40gan8A3929anrGry3Zw1a9rn0gr1Y9F4vyF1YvrW7ZrZ8Jay3
        JrZ0yw4kGr1DtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJUU8UUUUU=
X-Originating-IP: [223.104.3.30]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiGQbI3FXlgFkZdwABsN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1)when the nbuckets of cache device is smaller than 1024, make cache device will trigger BUG_ON in kernel, add a condition to avoid this.
2)split original if condition code into separate ones to make it clearly to debug.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/super.c | 87 ++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index fa4058e4..47d122ed 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2017,6 +2017,8 @@ static int cache_alloc(struct cache *ca)
 	size_t free;
 	size_t btree_buckets;
 	struct bucket *b;
+	int ret = -ENOMEM;
+	const char *err = NULL;
 
 	__module_get(THIS_MODULE);
 	kobject_init(&ca->kobj, &bch_cache_ktype);
@@ -2034,27 +2036,82 @@ static int cache_alloc(struct cache *ca)
 	 */
 	btree_buckets = ca->sb.njournal_buckets ?: 8;
 	free = roundup_pow_of_two(ca->sb.nbuckets) >> 10;
+	if (!free) {
+		ret = -EPERM;
+		err = "ca->sb.nbuckets is too small";
+		goto err_free;
+	}
 
-	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets, GFP_KERNEL) ||
-	    !init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca), GFP_KERNEL) ||
-	    !init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL) ||
-	    !init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL) ||
-	    !init_fifo(&ca->free_inc,	free << 2, GFP_KERNEL) ||
-	    !init_heap(&ca->heap,	free << 3, GFP_KERNEL) ||
-	    !(ca->buckets	= vzalloc(array_size(sizeof(struct bucket),
-						     ca->sb.nbuckets))) ||
-	    !(ca->prio_buckets	= kzalloc(array3_size(sizeof(uint64_t),
-						      prio_buckets(ca), 2),
-					  GFP_KERNEL)) ||
-	    !(ca->disk_buckets	= alloc_bucket_pages(GFP_KERNEL, ca)))
-		return -ENOMEM;
+	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets,
+						GFP_KERNEL)) {
+		err = "ca->free[RESERVE_BTREE] alloc failed";
+		goto err_btree_alloc;
+	}
+	if (!init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca),
+							GFP_KERNEL)) {
+		err = "ca->free[RESERVE_PRIO] alloc failed";
+		goto err_prio_alloc;
+	}
+	if (!init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL)) {
+		err = "ca->free[RESERVE_MOVINGGC] alloc failed";
+		goto err_movinggc_alloc;
+	}
+	if (!init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL)) {
+		err = "ca->free[RESERVE_NONE] alloc failed";
+		goto err_none_alloc;
+	}
+	if (!init_fifo(&ca->free_inc, free << 2, GFP_KERNEL)) {
+		err = "ca->free_inc alloc failed";
+		goto err_free_inc_alloc;
+	}
+	if (!init_heap(&ca->heap, free << 3, GFP_KERNEL)) {
+		err = "ca->heap alloc failed";
+		goto err_heap_alloc;
+	}
+	if (!(ca->buckets = vzalloc(array_size(sizeof(struct bucket),
+						ca->sb.nbuckets)))) {
+		err = "ca->buckets alloc failed";
+		goto err_buckets_alloc;
+	}
+	if (!(ca->prio_buckets = kzalloc(array3_size(sizeof(uint64_t),
+						prio_buckets(ca), 2),
+							GFP_KERNEL))) {
+		err = "ca->prio_buckets alloc failed";
+		goto err_prio_buckets_alloc;
+	}
+	if (!(ca->disk_buckets = alloc_bucket_pages(GFP_KERNEL, ca))) {
+		err = "ca->disk_buckets alloc failed";
+		goto err_disk_buckets_alloc;
+	}
 
 	ca->prio_last_buckets = ca->prio_buckets + prio_buckets(ca);
 
 	for_each_bucket(b, ca)
 		atomic_set(&b->pin, 0);
-
 	return 0;
+
+err_disk_buckets_alloc:
+	kfree(ca->prio_buckets);
+err_prio_buckets_alloc:
+	vfree(ca->buckets);
+err_buckets_alloc:
+	free_heap(&ca->heap);
+err_heap_alloc:
+	free_fifo(&ca->free_inc);
+err_free_inc_alloc:
+	free_fifo(&ca->free[RESERVE_NONE]);
+err_none_alloc:
+	free_fifo(&ca->free[RESERVE_MOVINGGC]);
+err_movinggc_alloc:
+	free_fifo(&ca->free[RESERVE_PRIO]);
+err_prio_alloc:
+	free_fifo(&ca->free[RESERVE_BTREE]);
+err_btree_alloc:
+err_free:
+	module_put(THIS_MODULE);
+	if (err)
+		pr_notice("error %s: %s", ca->cache_dev_name, err);
+	return ret;
 }
 
 static int register_cache(struct cache_sb *sb, struct page *sb_page,
@@ -2080,6 +2137,8 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
 		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 		if (ret == -ENOMEM)
 			err = "cache_alloc(): -ENOMEM";
+		else if (ret == -EPERM)
+			err = "cache_alloc(): cache device is too small";
 		else
 			err = "cache_alloc(): unknown error";
 		goto err;
-- 
2.17.1


