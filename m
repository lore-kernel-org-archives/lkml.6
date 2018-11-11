Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC53C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68892148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68892148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeKLGGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:06:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53178 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbeKLGGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:06:03 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000oO-4I; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001QI-2B; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Omar Sandoval" <osandov@fb.com>,
        "Jens Axboe" <axboe@kernel.dk>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.126192692@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 053/366] sbitmap: fix race in wait batch accounting
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit c854ab5773be1c1a0d3cef0c3a3261f2c48ab7f8 upstream.

If we have multiple callers of sbq_wake_up(), we can end up in a
situation where the wait_cnt will continually go more and more
negative. Consider the case where our wake batch is 1, hence
wait_cnt will start out as 1.

wait_cnt == 1

CPU0				CPU1
atomic_dec_return(), cnt == 0
				atomic_dec_return(), cnt == -1
				cmpxchg(-1, 0) (succeeds)
				[wait_cnt now 0]
cmpxchg(0, 1) (fails)

This ends up with wait_cnt being 0, we'll wakeup immediately
next time. Going through the same loop as above again, and
we'll have wait_cnt -1.

For the case where we have a larger wake batch, the only
difference is that the starting point will be higher. We'll
still end up with continually smaller batch wakeups, which
defeats the purpose of the rolling wakeups.

Always reset the wait_cnt to the batch value. Then it doesn't
matter who wins the race. But ensure that whomever does win
the race is the one that increments the ws index and wakes up
our batch count, loser gets to call __sbq_wake_up() again to
account his wakeups towards the next active wait state index.

Fixes: 6c0ca7ae292a ("sbitmap: fix wakeup hang after sbq resize")
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[bwh: Backported to 3.16:
 - Rename almost everything
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 block/blk-mq-tag.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -336,42 +336,58 @@ static struct bt_wait_state *bt_wake_ptr
 	return NULL;
 }
 
-static void bt_clear_tag(struct blk_mq_bitmap_tags *bt, unsigned int tag)
+static bool __bt_wake_up(struct blk_mq_bitmap_tags *bt)
 {
-	const int index = TAG_TO_INDEX(bt, tag);
 	struct bt_wait_state *bs;
 	unsigned int wake_batch;
 	int wait_cnt;
 
-	clear_bit(TAG_TO_BIT(bt, tag), &bt->map[index].word);
-
 	/* Ensure that the wait list checks occur after clear_bit(). */
 	smp_mb();
 
 	bs = bt_wake_ptr(bt);
 	if (!bs)
-		return;
+		return false;
 
 	wait_cnt = atomic_dec_return(&bs->wait_cnt);
 	if (wait_cnt <= 0) {
+		int ret;
+
 		wake_batch = ACCESS_ONCE(bt->wake_cnt);
+
 		/*
 		 * Pairs with the memory barrier in bt_update_count() to
 		 * ensure that we see the batch size update before the wait
 		 * count is reset.
 		 */
 		smp_mb__before_atomic();
+
 		/*
-		 * If there are concurrent callers to bt_clear_tag(), the last
-		 * one to decrement the wait count below zero will bump it back
-		 * up. If there is a concurrent resize, the count reset will
-		 * either cause the cmpxchg to fail or overwrite after the
-		 * cmpxchg.
+		 * For concurrent callers of this, the one that failed the
+		 * atomic_cmpxhcg() race should call this function again
+		 * to wakeup a new batch on a different 'bs'.
 		 */
-		atomic_cmpxchg(&bs->wait_cnt, wait_cnt, wait_cnt + wake_batch);
-		bt_index_atomic_inc(&bt->wake_index);
-		wake_up(&bs->wait);
+		ret = atomic_cmpxchg(&bs->wait_cnt, wait_cnt, wake_batch);
+		if (ret == wait_cnt) {
+			bt_index_atomic_inc(&bt->wake_index);
+			wake_up(&bs->wait);
+			return false;
+		}
+
+		return true;
 	}
+
+	return false;
+}
+
+static void bt_clear_tag(struct blk_mq_bitmap_tags *bt, unsigned int tag)
+{
+	const int index = TAG_TO_INDEX(bt, tag);
+
+	clear_bit(TAG_TO_BIT(bt, tag), &bt->map[index].word);
+
+	while (__bt_wake_up(bt))
+		;
 }
 
 static void __blk_mq_put_tag(struct blk_mq_tags *tags, unsigned int tag)

