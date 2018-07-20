Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF77ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD8420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD8420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbeGTNbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389610AbeGTNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:31 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44D46D18;
        Fri, 20 Jul 2018 12:39:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.17 078/101] block: dont use blocking queue entered for recursive bio submits
Date:   Fri, 20 Jul 2018 14:14:24 +0200
Message-Id: <20180720121426.586282917@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit cd4a4ae4683dc2e09380118e205e057896dcda2b upstream.

If we end up splitting a bio and the queue goes away between
the initial submission and the later split submission, then we
can block forever in blk_queue_enter() waiting for the reference
to drop to zero. This will never happen, since we already hold
a reference.

Mark a split bio as already having entered the queue, so we can
just use the live non-blocking queue enter variant.

Thanks to Tetsuo Handa for the analysis.

Reported-by: syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c          |    4 +++-
 block/blk-merge.c         |   10 ++++++++++
 include/linux/blk_types.h |    2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2392,7 +2392,9 @@ blk_qc_t generic_make_request(struct bio
 
 	if (bio->bi_opf & REQ_NOWAIT)
 		flags = BLK_MQ_REQ_NOWAIT;
-	if (blk_queue_enter(q, flags) < 0) {
+	if (bio_flagged(bio, BIO_QUEUE_ENTERED))
+		blk_queue_enter_live(q);
+	else if (blk_queue_enter(q, flags) < 0) {
 		if (!blk_queue_dying(q) && (bio->bi_opf & REQ_NOWAIT))
 			bio_wouldblock_error(bio);
 		else
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -210,6 +210,16 @@ void blk_queue_split(struct request_queu
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
 
+		/*
+		 * Since we're recursing into make_request here, ensure
+		 * that we mark this bio as already having entered the queue.
+		 * If not, and the queue is going away, we can get stuck
+		 * forever on waiting for the queue reference to drop. But
+		 * that will never happen, as we're already holding a
+		 * reference to it.
+		 */
+		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
+
 		bio_chain(split, *bio);
 		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
 		generic_make_request(*bio);
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -186,6 +186,8 @@ struct bio {
 				 * throttling rules. Don't do it again. */
 #define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
 				 * of this bio. */
+#define BIO_QUEUE_ENTERED 11	/* can use blk_queue_enter_live() */
+
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
 /*


