Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834C721564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834C721564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbeHBTmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:42:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387422AbeHBTmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:42:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B66B440241FD;
        Thu,  2 Aug 2018 17:49:59 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36C71215670D;
        Thu,  2 Aug 2018 17:49:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] blk-mq: move blk_mq_request_started() into header file
Date:   Fri,  3 Aug 2018 01:49:36 +0800
Message-Id: <20180802174937.15444-2-ming.lei@redhat.com>
In-Reply-To: <20180802174937.15444-1-ming.lei@redhat.com>
References: <20180802174937.15444-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 17:49:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 17:49:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define it as static inline given it might be called in fast path.

Suggested-by: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matt Hart <matthew.hart@linaro.org>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: John Garry <john.garry@huawei.com>
Cc: Hannes Reinecke <hare@suse.com>,
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         |  6 ------
 block/blk-mq.h         |  9 ---------
 include/linux/blk-mq.h | 15 ++++++++++++++-
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c92ce06fd565..7afd1c925fa8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -619,12 +619,6 @@ void blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-int blk_mq_request_started(struct request *rq)
-{
-	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
-}
-EXPORT_SYMBOL_GPL(blk_mq_request_started);
-
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9497b47e2526..18bc448b61a3 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -90,15 +90,6 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
-/**
- * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
- * @rq: target request.
- */
-static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
-{
-	return READ_ONCE(rq->state);
-}
-
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..cc0359b83fb8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -250,7 +250,6 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 }
 
 
-int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
@@ -303,6 +302,20 @@ static inline bool blk_mq_mark_complete(struct request *rq)
 			MQ_RQ_IN_FLIGHT;
 }
 
+/**
+ * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
+ * @rq: target request.
+ */
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
+{
+	return READ_ONCE(rq->state);
+}
+
+static inline int blk_mq_request_started(struct request *rq)
+{
+	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
+}
+
 /*
  * Driver command data is immediately after the request. So subtract request
  * size to get back to the original request, add request size to get the PDU.
-- 
2.9.5

