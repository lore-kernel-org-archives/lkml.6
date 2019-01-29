Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D319C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D745E2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/8rgA1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfA2LHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45596 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfA2LHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so21506279wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ui0RozgVj782eZenovCwcdQYstEPpPQMeO8MT0fjT5o=;
        b=L/8rgA1a0X/Tzr6jFJ7LPCtro61Yhi/kU9AXGI8zscrdDCQQoDzxOAgtOlxQEJmkqQ
         Im3eeKa7fN2xw9GQceKjWdHYXTC11GBPY67zB3gdzRXMhhAjAD6CISk+xyKiBEO5cAtj
         amn9Kk1fJqkf9621GzFX8GpON9gGM72ruLoC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ui0RozgVj782eZenovCwcdQYstEPpPQMeO8MT0fjT5o=;
        b=EbYvGDpai0a6O1sH7u2t3Q/OXeKlRlcjpTQjya8P7AGde2s0gSwc5CATx3uSLJZncu
         nGFj/lRNlTOJFb57+U7Sy/QOSfHZaFvAoro8od7g4Ax4RZhAPpIvDMTjeDLWz4e/xoQ0
         uK3OyKK4VAKs2scNogN+w5xYjd7mjkoEE6d0nZcc06e15gg4Ic6VlQE5VgsaKyn1aNuK
         WSG4usSoNExrGYbrYHhnSZd01RSjhO+9AIIikNTfDk0t+XugnXM3J8U7B6M50bJpQlEs
         mH0VNOcdEC8lLhtdgfA6JyZcd9JJUC2X4lXbAkRMvjxhtyLFnds2hxgYMCYrprEvl1p8
         k1nA==
X-Gm-Message-State: AJcUukea3OhXGo/58R1pftbd5wxn2EQgZyWzqK1ORSqXbxfE9muDb5Eu
        osNPlMA1zkIf9mcerjC+LOew3Q==
X-Google-Smtp-Source: ALg8bN5t0xmEieYTRN0u2FYyM7D646ckc7BUkQGUXiRkGgk2ntuTucSJK2cHBiDVXduWjX/bG7M3vw==
X-Received: by 2002:adf:8068:: with SMTP id 95mr26094476wrk.181.1548760030187;
        Tue, 29 Jan 2019 03:07:10 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:09 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 10/14] block, bfq: fix queue removal from weights tree
Date:   Tue, 29 Jan 2019 12:06:34 +0100
Message-Id: <20190129110638.12652-11-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfq maintains an ordered list, through a red-black tree, of unique
weights of active bfq_queues. This list is used to detect whether
there are active queues with differentiated weights. The weight of a
queue is removed from the list when both the following two conditions
become true:
(1) the bfq_queue is flagged as inactive
(2) the has no in-flight request any longer;

Unfortunately, in the rare cases where condition (2) becomes true
before condition (1), the removal fails, because the function to
remove the weight of the queue (bfq_weights_tree_remove) is rightly
invoked in the path that deactivates the bfq_queue, but mistakenly
invoked *before* the function that actually performs the deactivation
(bfq_deactivate_bfqq).

This commits moves the invocation of bfq_weights_tree_remove for
condition (1) to after bfq_deactivate_bfqq. As a consequence of this
move, it is necessary to add a further reference to the queue when the
weight of a queue is added, because the queue might otherwise be freed
before bfq_weights_tree_remove is invoked. This commit adds this
reference and makes all related modifications.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 17 +++++++++++++----
 block/bfq-wf2q.c    |  6 +++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 12228af16198..bf585ad29bb5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -754,6 +754,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 inc_counter:
 	bfqq->weight_counter->num_active++;
+	bfqq->ref++;
 }
 
 /*
@@ -778,6 +779,7 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 
 reset_entity_pointer:
 	bfqq->weight_counter = NULL;
+	bfq_put_queue(bfqq);
 }
 
 /*
@@ -789,9 +791,6 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 {
 	struct bfq_entity *entity = bfqq->entity.parent;
 
-	__bfq_weights_tree_remove(bfqd, bfqq,
-				  &bfqd->queue_weights_tree);
-
 	for_each_entity(entity) {
 		struct bfq_sched_data *sd = entity->my_sched_data;
 
@@ -825,6 +824,15 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			bfqd->num_groups_with_pending_reqs--;
 		}
 	}
+
+	/*
+	 * Next function is invoked last, because it causes bfqq to be
+	 * freed if the following holds: bfqq is not in service and
+	 * has no dispatched request. DO NOT use bfqq after the next
+	 * function invocation.
+	 */
+	__bfq_weights_tree_remove(bfqd, bfqq,
+				  &bfqd->queue_weights_tree);
 }
 
 /*
@@ -1020,7 +1028,8 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 
 static int bfqq_process_refs(struct bfq_queue *bfqq)
 {
-	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st;
+	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st -
+		(bfqq->weight_counter != NULL);
 }
 
 /* Empty burst list and add just bfqq (see comments on bfq_handle_burst) */
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index ce37d709a34f..63311d1ff1ed 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1673,15 +1673,15 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
 
-	if (!bfqq->dispatched)
-		bfq_weights_tree_remove(bfqd, bfqq);
-
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues--;
 
 	bfqg_stats_update_dequeue(bfqq_group(bfqq));
 
 	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
+
+	if (!bfqq->dispatched)
+		bfq_weights_tree_remove(bfqd, bfqq);
 }
 
 /*
-- 
2.20.1

