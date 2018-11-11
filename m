Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E03C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E071620811
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q6+vcbdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E071620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeKKXVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:21:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeKKXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B0pJEbeEAP14hcJGliN/6CfdDPrk4mJVLSaLQ4w+UQ8=; b=q6+vcbdftkW5rRPX9N43hqKByK
        /51KwdKR10BVjlrXsI8QetQqas9/dwIFfzRGmvZRQfdAqEKg30e5KpdA3qkVnbNkIqTB1yF7alUQ/
        5n3dt7ned7TboGGFkDxO2QaJTbMfOhuMd4mbpznXec6XaigLhDVtEUIt3VlPyVQHBje+gIl6WXJrn
        ur/qB6MblKcKS37kliDg27vmzAsbeCkLo2Xq3YSCPqRGx3lsrHr+XaefNn2+E2uXJuRIJqKv/ykDS
        qKHQ7iNpoFRJ0d/KlP3nskttwcO9JfuuE3oHU6+7v3F0y/v3Am1yWVyKsleB2VUKJLEd3VmhPJRb7
        /TgIjmhg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLpqu-0007aA-VR; Sun, 11 Nov 2018 13:32:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] block: remove bidi support
Date:   Sun, 11 Nov 2018 14:32:11 +0100
Message-Id: <20181111133211.13926-9-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111133211.13926-1-hch@lst.de>
References: <20181111133211.13926-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused now, and another field in struct request bites the dust.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c | 1 -
 block/blk-mq.c         | 3 ---
 include/linux/blkdev.h | 6 ------
 3 files changed, 10 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f021f4817b80..82f5e836fe30 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -115,7 +115,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
 	QUEUE_FLAG_NAME(BYPASS),
-	QUEUE_FLAG_NAME(BIDI),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
 	QUEUE_FLAG_NAME(FAIL_IO),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c1bb0c0b2ad8..95c858b9309e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -330,7 +330,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
-	rq->next_rq = NULL;
 
 	data->ctx->rq_dispatched[op_is_sync(op)]++;
 	refcount_set(&rq->ref, 1);
@@ -537,8 +536,6 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 		rq_qos_done(rq->q, rq);
 		rq->end_io(rq, error);
 	} else {
-		if (unlikely(blk_bidi_rq(rq)))
-			blk_mq_free_request(rq->next_rq);
 		blk_mq_free_request(rq);
 	}
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index adafeb1e0c2b..944157e78f06 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -236,9 +236,6 @@ struct request {
 	 */
 	rq_end_io_fn *end_io;
 	void *end_io_data;
-
-	/* for bidi */
-	struct request *next_rq;
 };
 
 static inline bool blk_op_is_scsi(unsigned int op)
@@ -588,7 +585,6 @@ struct request_queue {
 #define QUEUE_FLAG_STOPPED	1	/* queue is stopped */
 #define QUEUE_FLAG_DYING	2	/* queue being torn down */
 #define QUEUE_FLAG_BYPASS	3	/* act as dumb FIFO queue */
-#define QUEUE_FLAG_BIDI		4	/* queue supports bidi requests */
 #define QUEUE_FLAG_NOMERGES     5	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	6	/* complete on same CPU-group */
 #define QUEUE_FLAG_FAIL_IO	7	/* fake timeout */
@@ -663,8 +659,6 @@ static inline bool blk_account_rq(struct request *rq)
 	return (rq->rq_flags & RQF_STARTED) && !blk_rq_is_passthrough(rq);
 }
 
-#define blk_bidi_rq(rq)		((rq)->next_rq != NULL)
-
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
-- 
2.19.1

