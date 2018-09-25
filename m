Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34C7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8152D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W47ty21G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8152D20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeIYOsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:48:35 -0400
Received: from m12-15.163.com ([220.181.12.15]:34556 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbeIYOsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=joEwteYbQavuRdJIkP
        mVRvkOVSv36H3+qWdhQVo4GHA=; b=W47ty21G48DfBWjVYx4eXScHhPcQ94qc0N
        B6FWK2cbCQReKLZx6x12Rd0CkvQ5m8CH4RhAL9t0Y1KeuwGcjibmbmHUxEl0K0wR
        xRJd4eSeEoSMcAcgwqHmzejQRXQnKCxDqW4OBf7DyCOybrQkHfwn1ETf7pt7nkqU
        cq4WbmliI=
Received: from localhost.localdomain (unknown [117.136.0.174])
        by smtp11 (Coremail) with SMTP id D8CowAD3_x_I9KlbfoA4IQ--.20159S4;
        Tue, 25 Sep 2018 16:41:44 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH 3/3] split original if condition code in function bch_cache_set_alloc
Date:   Tue, 25 Sep 2018 16:41:42 +0800
Message-Id: <20180925084142.8764-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowAD3_x_I9KlbfoA4IQ--.20159S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF45WF1DCry8JF45CryrCrg_yoWruF48pF
        Zru34fArWrXw43tr1Yyr409F95C3yIgayUW3y7X34rZrsIkr1rKr1vyry5ZrW5AFZrGa13
        CFn5K348ur1DJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2GQDUUUUU=
X-Originating-IP: [117.136.0.174]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiNRfM3FrPMemFpAAAse
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove bch_cache_set_unregister because we have not registerd right now

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/super.c | 102 ++++++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 20 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 47d122ed..13a128eb 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1658,9 +1658,13 @@ void bch_cache_set_unregister(struct cache_set *c)
 struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 {
 	int iter_size;
+	const char *err = NULL;
+
 	struct cache_set *c = kzalloc(sizeof(struct cache_set), GFP_KERNEL);
-	if (!c)
-		return NULL;
+	if (!c) {
+		err = "cache_set alloc failed";
+		goto err_cache_set_alloc;
+	}
 
 	__module_get(THIS_MODULE);
 	closure_init(&c->cl, NULL);
@@ -1715,22 +1719,55 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	iter_size = (sb->bucket_size / sb->block_size + 1) *
 		sizeof(struct btree_iter_set);
 
-	if (!(c->devices = kcalloc(c->nr_uuids, sizeof(void *), GFP_KERNEL)) ||
-	    mempool_init_slab_pool(&c->search, 32, bch_search_cache) ||
-	    mempool_init_kmalloc_pool(&c->bio_meta, 2,
-				      sizeof(struct bbio) + sizeof(struct bio_vec) *
-				      bucket_pages(c)) ||
-	    mempool_init_kmalloc_pool(&c->fill_iter, 1, iter_size) ||
-	    bioset_init(&c->bio_split, 4, offsetof(struct bbio, bio),
-			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER) ||
-	    !(c->uuids = alloc_bucket_pages(GFP_KERNEL, c)) ||
-	    !(c->moving_gc_wq = alloc_workqueue("bcache_gc",
-						WQ_MEM_RECLAIM, 0)) ||
-	    bch_journal_alloc(c) ||
-	    bch_btree_cache_alloc(c) ||
-	    bch_open_buckets_alloc(c) ||
-	    bch_bset_sort_state_init(&c->sort, ilog2(c->btree_pages)))
-		goto err;
+	if (!(c->devices = kcalloc(c->nr_uuids, sizeof(void *), GFP_KERNEL))) {
+		err = "c->devices alloc failed";
+		goto err_devices_alloc;
+	}
+	if (mempool_init_slab_pool(&c->search, 32, bch_search_cache)) {
+		err = "c->search alloc failed";
+		goto err_search_alloc;
+	}	
+	if (mempool_init_kmalloc_pool(&c->bio_meta, 2,
+			sizeof(struct bbio) + sizeof(struct bio_vec) *
+						bucket_pages(c))) {
+		err = "c->bio_meta alloc failed";
+		goto err_bio_meta_alloc;
+	}
+	if (mempool_init_kmalloc_pool(&c->fill_iter, 1, iter_size)) {
+		err = "c->fill_iter alloc failed";
+		goto err_fill_iter_alloc;
+	}
+	if (bioset_init(&c->bio_split, 4, offsetof(struct bbio, bio),
+			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER)) {
+		err = "c->bio_split init failed";
+		goto err_bio_split_init;
+	}
+	if (!(c->uuids = alloc_bucket_pages(GFP_KERNEL, c))) {
+		err = "c->uuids alloc failed";
+		goto err_uuids_alloc;
+	}
+	if (!(c->moving_gc_wq = alloc_workqueue("bcache_gc",
+						WQ_MEM_RECLAIM, 0))) {
+		err = "c->moving_gc_wq alloc failed";
+		goto err_moving_gc_wq_alloc;
+	}
+	if (bch_journal_alloc(c)) {
+		err = "bch_journal_alloc failed";
+		goto err_bch_journal_alloc;
+
+	}
+	if (bch_btree_cache_alloc(c)) {
+		err = "bch_btree_cache_alloc failed";
+		goto err_bch_btree_cache_alloc;
+	}
+	if (bch_open_buckets_alloc(c)) {
+		err = "bch_open_buckets_alloc failed";
+		goto err_bch_open_buckets_alloc;
+	}
+	if (bch_bset_sort_state_init(&c->sort, ilog2(c->btree_pages))) {
+		err = "bch_bset_sort_state_init failed";
+		goto err_bch_bset_sort_state_init;
+	}
 
 	c->congested_read_threshold_us	= 2000;
 	c->congested_write_threshold_us	= 20000;
@@ -1738,8 +1775,33 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	WARN_ON(test_and_clear_bit(CACHE_SET_IO_DISABLE, &c->flags));
 
 	return c;
-err:
-	bch_cache_set_unregister(c);
+
+err_bch_bset_sort_state_init:
+	bch_open_buckets_free(c);
+err_bch_open_buckets_alloc:
+	bch_btree_cache_free(c);
+err_bch_btree_cache_alloc:
+	bch_journal_free(c);
+err_bch_journal_alloc:
+	destroy_workqueue(c->moving_gc_wq);
+err_moving_gc_wq_alloc:
+	free_pages((unsigned long) c->uuids, ilog2(bucket_pages(c)));
+err_uuids_alloc:
+	bioset_exit(&c->bio_split);
+err_bio_split_init:
+	mempool_exit(&c->fill_iter);
+err_fill_iter_alloc:
+	mempool_exit(&c->bio_meta);
+err_bio_meta_alloc:
+	mempool_exit(&c->search);
+err_search_alloc:
+	kfree(c->devices);
+err_devices_alloc:
+	kfree(c);
+	module_put(THIS_MODULE);
+err_cache_set_alloc:
+        if (err)
+                pr_notice("error cache set %s: %s", c->sb.set_uuid, err);	
 	return NULL;
 }
 
-- 
2.17.1


