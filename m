Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6204C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7884820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeKJCJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:09:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbeKJCJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:09:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43198C058CD8;
        Fri,  9 Nov 2018 16:28:10 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 284B7101962F;
        Fri,  9 Nov 2018 16:28:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH V8 16/18] block: don't use bio->bi_vcnt to figure out segment number
Date:   Sat, 10 Nov 2018 00:26:08 +0800
Message-Id: <20181109162610.18981-17-ming.lei@redhat.com>
In-Reply-To: <20181109162610.18981-1-ming.lei@redhat.com>
References: <20181109162610.18981-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 09 Nov 2018 16:28:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is wrong to use bio->bi_vcnt to figure out how many segments
there are in the bio even though CLONED flag isn't set on this bio,
because this bio may be splitted or advanced.

So always use bio_segments() in blk_recount_segments(), and it shouldn't
cause any performance loss now because the physical segment number is figured
out in blk_queue_split() and BIO_SEG_VALID is set meantime since
bdced438acd83ad83a6c ("block: setup bi_phys_segments after splitting").

Fixes: 7f60dcaaf91 ("block: blk-merge: fix blk_recount_segments()")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index cb9f49bcfd36..153a659fde74 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -429,13 +429,7 @@ void blk_recalc_rq_segments(struct request *rq)
 
 void blk_recount_segments(struct request_queue *q, struct bio *bio)
 {
-	unsigned short seg_cnt;
-
-	/* estimate segment number by bi_vcnt for non-cloned bio */
-	if (bio_flagged(bio, BIO_CLONED))
-		seg_cnt = bio_segments(bio);
-	else
-		seg_cnt = bio->bi_vcnt;
+	unsigned short seg_cnt = bio_segments(bio);
 
 	if (test_bit(QUEUE_FLAG_NO_SG_MERGE, &q->queue_flags) &&
 			(seg_cnt < queue_max_segments(q)))
-- 
2.9.5

