Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C394C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E02F2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E02F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeIHB4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeIHB4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 018D9FE6;
        Fri,  7 Sep 2018 21:13:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.18 009/145] mmc: block: Fix unsupported parallel dispatch of requests
Date:   Fri,  7 Sep 2018 23:07:55 +0200
Message-Id: <20180907210904.396876455@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 26caddf274cf1e89fd4ce44ab2b8dbc7a7f97681 upstream.

The mmc block driver does not support parallel dispatch of requests. In
normal circumstances, all requests are anyway funneled through a single
work item, so parallel dispatch never happens. However it can happen if
there is no elevator.

Fix that by detecting if a dispatch is in progress and returning busy
(BLK_STS_RESOURCE) in that case

Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/queue.c |   12 +++++++-----
 drivers/mmc/core/queue.h |    1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -238,10 +238,6 @@ static void mmc_mq_exit_request(struct b
 	mmc_exit_request(mq->queue, req);
 }
 
-/*
- * We use BLK_MQ_F_BLOCKING and have only 1 hardware queue, which means requests
- * will not be dispatched in parallel.
- */
 static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 				    const struct blk_mq_queue_data *bd)
 {
@@ -264,7 +260,7 @@ static blk_status_t mmc_mq_queue_rq(stru
 
 	spin_lock_irq(q->queue_lock);
 
-	if (mq->recovery_needed) {
+	if (mq->recovery_needed || mq->busy) {
 		spin_unlock_irq(q->queue_lock);
 		return BLK_STS_RESOURCE;
 	}
@@ -291,6 +287,9 @@ static blk_status_t mmc_mq_queue_rq(stru
 		break;
 	}
 
+	/* Parallel dispatch of requests is not supported at the moment */
+	mq->busy = true;
+
 	mq->in_flight[issue_type] += 1;
 	get_card = (mmc_tot_in_flight(mq) == 1);
 	cqe_retune_ok = (mmc_cqe_qcnt(mq) == 1);
@@ -333,9 +332,12 @@ static blk_status_t mmc_mq_queue_rq(stru
 		mq->in_flight[issue_type] -= 1;
 		if (mmc_tot_in_flight(mq) == 0)
 			put_card = true;
+		mq->busy = false;
 		spin_unlock_irq(q->queue_lock);
 		if (put_card)
 			mmc_put_card(card, &mq->ctx);
+	} else {
+		WRITE_ONCE(mq->busy, false);
 	}
 
 	return ret;
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -81,6 +81,7 @@ struct mmc_queue {
 	unsigned int		cqe_busy;
 #define MMC_CQE_DCMD_BUSY	BIT(0)
 #define MMC_CQE_QUEUE_FULL	BIT(1)
+	bool			busy;
 	bool			use_cqe;
 	bool			recovery_needed;
 	bool			in_recovery;


