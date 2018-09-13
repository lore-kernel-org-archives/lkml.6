Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F31C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87213204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87213204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbeIMTHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:07:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbeIMTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:07:53 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 089CAD0E;
        Thu, 13 Sep 2018 13:58:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 106/197] blk-mq: count the hctx as active before allocating tag
Date:   Thu, 13 Sep 2018 15:30:55 +0200
Message-Id: <20180913131845.790670295@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit d263ed9926823c462f99a7679e18f0c9e5b8550d ]

Currently, we count the hctx as active after allocate driver tag
successfully. If a previously inactive hctx try to get tag first
time, it may fails and need to wait. However, due to the stale tag
->active_queues, the other shared-tags users are still able to
occupy all driver tags while there is someone waiting for tag.
Consequently, even if the previously inactive hctx is waked up, it
still may not be able to get a tag and could be starved.

To fix it, we count the hctx as active before try to allocate driver
tag, then when it is waiting the tag, the other shared-tag users
will reserve budget for it.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq-tag.c |    3 +++
 block/blk-mq.c     |    8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -23,6 +23,9 @@ bool blk_mq_has_free_tags(struct blk_mq_
 
 /*
  * If a previously inactive queue goes active, bump the active user count.
+ * We need to do this before try to allocate driver tag, then even if fail
+ * to get tag when first time, the other shared-tag users could reserve
+ * budget for it.
  */
 bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -285,7 +285,7 @@ static struct request *blk_mq_rq_ctx_ini
 		rq->tag = -1;
 		rq->internal_tag = tag;
 	} else {
-		if (blk_mq_tag_busy(data->hctx)) {
+		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
 			atomic_inc(&data->hctx->nr_active);
 		}
@@ -367,6 +367,8 @@ static struct request *blk_mq_get_reques
 		if (!op_is_flush(op) && e->type->ops.mq.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.mq.limit_depth(op, data);
+	} else {
+		blk_mq_tag_busy(data->hctx);
 	}
 
 	tag = blk_mq_get_tag(data);
@@ -970,6 +972,7 @@ bool blk_mq_get_driver_tag(struct reques
 		.hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu),
 		.flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
 	};
+	bool shared;
 
 	might_sleep_if(wait);
 
@@ -979,9 +982,10 @@ bool blk_mq_get_driver_tag(struct reques
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
 		data.flags |= BLK_MQ_REQ_RESERVED;
 
+	shared = blk_mq_tag_busy(data.hctx);
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
-		if (blk_mq_tag_busy(data.hctx)) {
+		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
 			atomic_inc(&data.hctx->nr_active);
 		}


