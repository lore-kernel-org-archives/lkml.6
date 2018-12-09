Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E538C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080C920661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080C920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeLIWBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:01:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35964 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbeLIVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:34 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72x-0002im-5O; Sun, 09 Dec 2018 21:55:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72j-0003bc-8k; Sun, 09 Dec 2018 21:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jens Axboe" <axboe@fb.com>,
        "Christoph Hellwig" <hch@lst.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.411520608@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 265/328] bcache: don't embed 'return' statements in
 closure macros
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

From: Jens Axboe <axboe@fb.com>

commit 77b5a08427e87514c33730afc18cd02c9475e2c3 upstream.

This is horribly confusing, it breaks the flow of the code without
it being apparent in the caller.

Signed-off-by: Jens Axboe <axboe@fb.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/closure.h |  3 ---
 drivers/md/bcache/io.c      |  1 +
 drivers/md/bcache/journal.c |  2 ++
 drivers/md/bcache/request.c | 14 +++++++++++---
 4 files changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -320,7 +320,6 @@ static inline void closure_wake_up(struc
 do {									\
 	set_closure_fn(_cl, _fn, _wq);					\
 	closure_sub(_cl, CLOSURE_RUNNING + 1);				\
-	return;								\
 } while (0)
 
 /**
@@ -349,7 +348,6 @@ do {									\
 do {									\
 	set_closure_fn(_cl, _fn, _wq);					\
 	closure_queue(_cl);						\
-	return;								\
 } while (0)
 
 /**
@@ -365,7 +363,6 @@ do {									\
 do {									\
 	set_closure_fn(_cl, _destructor, NULL);				\
 	closure_sub(_cl, CLOSURE_RUNNING - CLOSURE_DESTRUCTOR + 1);	\
-	return;								\
 } while (0)
 
 /**
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -105,6 +105,7 @@ void bch_generic_make_request(struct bio
 	} while (n != bio);
 
 	continue_at(&s->cl, bch_bio_submit_split_done, NULL);
+	return;
 submit:
 	generic_make_request(bio);
 }
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -586,12 +586,14 @@ static void journal_write_unlocked(struc
 
 	if (!w->need_write) {
 		closure_return_with_destructor(cl, journal_write_unlock);
+		return;
 	} else if (journal_full(&c->journal)) {
 		journal_reclaim(c);
 		spin_unlock(&c->journal.lock);
 
 		btree_flush_write(c);
 		continue_at(cl, journal_write, system_wq);
+		return;
 	}
 
 	c->journal.blocks_free -= set_blocks(w->data, block_bytes(c));
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -87,8 +87,10 @@ static void bch_data_insert_keys(struct
 	if (journal_ref)
 		atomic_dec_bug(journal_ref);
 
-	if (!op->insert_data_done)
+	if (!op->insert_data_done) {
 		continue_at(cl, bch_data_insert_start, op->wq);
+		return;
+	}
 
 	bch_keylist_free(&op->insert_keys);
 	closure_return(cl);
@@ -215,8 +217,10 @@ static void bch_data_insert_start(struct
 		/* 1 for the device pointer and 1 for the chksum */
 		if (bch_keylist_realloc(&op->insert_keys,
 					3 + (op->csum ? 1 : 0),
-					op->c))
+					op->c)) {
 			continue_at(cl, bch_data_insert_keys, op->wq);
+			return;
+		}
 
 		k = op->insert_keys.top;
 		bkey_init(k);
@@ -254,6 +258,7 @@ static void bch_data_insert_start(struct
 
 	op->insert_data_done = true;
 	continue_at(cl, bch_data_insert_keys, op->wq);
+	return;
 err:
 	/* bch_alloc_sectors() blocks if s->writeback = true */
 	BUG_ON(op->writeback);
@@ -568,8 +573,10 @@ static void cache_lookup(struct closure
 	ret = bch_btree_map_keys(&s->op, s->iop.c,
 				 &KEY(s->iop.inode, bio->bi_iter.bi_sector, 0),
 				 cache_lookup_fn, MAP_END_KEY);
-	if (ret == -EAGAIN)
+	if (ret == -EAGAIN) {
 		continue_at(cl, cache_lookup, bcache_wq);
+		return;
+	}
 
 	closure_return(cl);
 }
@@ -1095,6 +1102,7 @@ static void flash_dev_make_request(struc
 		continue_at_nobarrier(&s->cl,
 				      flash_dev_nodata,
 				      bcache_wq);
+		return;
 	} else if (rw) {
 		bch_keybuf_check_overlapping(&s->iop.c->moving_gc_keys,
 					&KEY(d->id, bio->bi_iter.bi_sector, 0),

