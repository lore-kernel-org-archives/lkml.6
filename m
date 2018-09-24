Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF7CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5219F21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5219F21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbeIXS0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:26:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbeIXS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:26:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7CBBC108B;
        Mon, 24 Sep 2018 12:24:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 154/173] blk-mq: only attempt to merge bio if there is rq in sw queue
Date:   Mon, 24 Sep 2018 13:53:08 +0200
Message-Id: <20180924113126.619573489@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b04f50ab8a74129b3041a2836c33c916be3c6667 ]

Only attempt to merge bio iff the ctx->rq_list isn't empty, because:

1) for high-performance SSD, most of times dispatch may succeed, then
there may be nothing left in ctx->rq_list, so don't try to merge over
sw queue if it is empty, then we can save one acquiring of ctx->lock

2) we can't expect good merge performance on per-cpu sw queue, and missing
one merge on sw queue won't be a big deal since tasks can be scheduled from
one CPU to another.

Cc: Laurence Oberman <loberman@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq-sched.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -236,7 +236,8 @@ bool __blk_mq_sched_bio_merge(struct req
 		return e->type->ops.mq.bio_merge(hctx, bio);
 	}
 
-	if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
+	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
+			!list_empty_careful(&ctx->rq_list)) {
 		/* default per sw-queue merge */
 		spin_lock(&ctx->lock);
 		ret = blk_mq_attempt_merge(q, ctx, bio);


