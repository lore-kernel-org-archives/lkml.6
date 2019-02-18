Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40C2204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498843;
	bh=l+m4a8ddwfslpPgU6B/qnhMAG0w0BsjXSRUy3zTV1cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nvLpRyp07jv0CqukSnz6MqqD0Uca8rxFmSE3LhLTT+LmWvJr7oxtOrL5E9e4KVmdh
	 0e/jXFMcB8BoieqzjUs3m2vaiCSE5VH6iQd1M5RuEy+IBjQP8pvkTe+nQoc2cLm2pk
	 hrlh2bFbNKCqiMdtFk9DF7PDdtNBdrn7K/FSscXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbfBROHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:07:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390081AbfBROHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E57721902;
        Mon, 18 Feb 2019 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498839;
        bh=l+m4a8ddwfslpPgU6B/qnhMAG0w0BsjXSRUy3zTV1cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoNL9+kusor8iE4DL3VOc4nGGTd68Ar51B2b4O+wjmSf/T0xKz6ylVDwxtyCrUvIF
         rvALxDz33TwoDr31x/od4a4SGbJBXExdTABMM3yjIsnpyPxgaqVdxVFCXZcvrLa3aP
         /ORfrd2RBNelANyFqnz+giFiXFB1gxj2dY8eDp/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Joe Thornber <ejt@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.4 138/143] dm thin: fix bug where bio that overwrites thin block ignores FUA
Date:   Mon, 18 Feb 2019 14:44:26 +0100
Message-Id: <20190218133534.017054671@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikos Tsironis <ntsironis@arrikto.com>

commit 4ae280b4ee3463fa57bbe6eede26b97daff8a0f1 upstream.

When provisioning a new data block for a virtual block, either because
the block was previously unallocated or because we are breaking sharing,
if the whole block of data is being overwritten the bio that triggered
the provisioning is issued immediately, skipping copying or zeroing of
the data block.

When this bio completes the new mapping is inserted in to the pool's
metadata by process_prepared_mapping(), where the bio completion is
signaled to the upper layers.

This completion is signaled without first committing the metadata.  If
the bio in question has the REQ_FUA flag set and the system crashes
right after its completion and before the next metadata commit, then the
write is lost despite the REQ_FUA flag requiring that I/O completion for
this request must only be signaled after the data has been committed to
non-volatile storage.

Fix this by deferring the completion of overwrite bios, with the REQ_FUA
flag set, until after the metadata has been committed.

Cc: stable@vger.kernel.org
Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Acked-by: Joe Thornber <ejt@redhat.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -256,6 +256,7 @@ struct pool {
 
 	spinlock_t lock;
 	struct bio_list deferred_flush_bios;
+	struct bio_list deferred_flush_completions;
 	struct list_head prepared_mappings;
 	struct list_head prepared_discards;
 	struct list_head active_thins;
@@ -920,6 +921,39 @@ static void process_prepared_mapping_fai
 	mempool_free(m, m->tc->pool->mapping_pool);
 }
 
+static void complete_overwrite_bio(struct thin_c *tc, struct bio *bio)
+{
+	struct pool *pool = tc->pool;
+	unsigned long flags;
+
+	/*
+	 * If the bio has the REQ_FUA flag set we must commit the metadata
+	 * before signaling its completion.
+	 */
+	if (!bio_triggers_commit(tc, bio)) {
+		bio_endio(bio);
+		return;
+	}
+
+	/*
+	 * Complete bio with an error if earlier I/O caused changes to the
+	 * metadata that can't be committed, e.g, due to I/O errors on the
+	 * metadata device.
+	 */
+	if (dm_thin_aborted_changes(tc->td)) {
+		bio_io_error(bio);
+		return;
+	}
+
+	/*
+	 * Batch together any bios that trigger commits and then issue a
+	 * single commit for them in process_deferred_bios().
+	 */
+	spin_lock_irqsave(&pool->lock, flags);
+	bio_list_add(&pool->deferred_flush_completions, bio);
+	spin_unlock_irqrestore(&pool->lock, flags);
+}
+
 static void process_prepared_mapping(struct dm_thin_new_mapping *m)
 {
 	struct thin_c *tc = m->tc;
@@ -952,7 +986,7 @@ static void process_prepared_mapping(str
 	 */
 	if (bio) {
 		inc_remap_and_issue_cell(tc, m->cell, m->data_block);
-		bio_endio(bio);
+		complete_overwrite_bio(tc, bio);
 	} else {
 		inc_all_io_entry(tc->pool, m->cell->holder);
 		remap_and_issue(tc, m->cell->holder, m->data_block);
@@ -2228,7 +2262,7 @@ static void process_deferred_bios(struct
 {
 	unsigned long flags;
 	struct bio *bio;
-	struct bio_list bios;
+	struct bio_list bios, bio_completions;
 	struct thin_c *tc;
 
 	tc = get_first_thin(pool);
@@ -2239,26 +2273,36 @@ static void process_deferred_bios(struct
 	}
 
 	/*
-	 * If there are any deferred flush bios, we must commit
-	 * the metadata before issuing them.
+	 * If there are any deferred flush bios, we must commit the metadata
+	 * before issuing them or signaling their completion.
 	 */
 	bio_list_init(&bios);
+	bio_list_init(&bio_completions);
+
 	spin_lock_irqsave(&pool->lock, flags);
 	bio_list_merge(&bios, &pool->deferred_flush_bios);
 	bio_list_init(&pool->deferred_flush_bios);
+
+	bio_list_merge(&bio_completions, &pool->deferred_flush_completions);
+	bio_list_init(&pool->deferred_flush_completions);
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-	if (bio_list_empty(&bios) &&
+	if (bio_list_empty(&bios) && bio_list_empty(&bio_completions) &&
 	    !(dm_pool_changed_this_transaction(pool->pmd) && need_commit_due_to_time(pool)))
 		return;
 
 	if (commit(pool)) {
+		bio_list_merge(&bios, &bio_completions);
+
 		while ((bio = bio_list_pop(&bios)))
 			bio_io_error(bio);
 		return;
 	}
 	pool->last_commit_jiffies = jiffies;
 
+	while ((bio = bio_list_pop(&bio_completions)))
+		bio_endio(bio);
+
 	while ((bio = bio_list_pop(&bios)))
 		generic_make_request(bio);
 }
@@ -2885,6 +2929,7 @@ static struct pool *pool_create(struct m
 	INIT_DELAYED_WORK(&pool->no_space_timeout, do_no_space_timeout);
 	spin_lock_init(&pool->lock);
 	bio_list_init(&pool->deferred_flush_bios);
+	bio_list_init(&pool->deferred_flush_completions);
 	INIT_LIST_HEAD(&pool->prepared_mappings);
 	INIT_LIST_HEAD(&pool->prepared_discards);
 	INIT_LIST_HEAD(&pool->active_thins);


