Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D04C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF7024D9F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRzh8Rl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF7024D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935140AbeFYTs5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:48:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38347 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755652AbeFYTsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:48:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id a5-v6so6154027edt.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iLVhnU7LLoCaW4lOc7bzsWA0oIfhsKCR8yo/rG/4vtQ=;
        b=jRzh8Rl354+2+iZbrVEHzLsd1duus/ZS5O6jIQ+p1pxzC9wHX+zuj+94kLUJpY1yrm
         QKHL7b+HP248NHwrZNO8xoyz5VJ2BIkET+81pbCDsdIfbRxaW5TGOKXQwu+wtfMNKs+A
         mtOrBdtKl78Omr5rkKAedrxrDDwx7qzzXGFI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iLVhnU7LLoCaW4lOc7bzsWA0oIfhsKCR8yo/rG/4vtQ=;
        b=iHeJ46PR5dhEHGeXjgEBt5DC73QwYgEGNLaeuL1tM8CIapA/ppn8WhvGTh4zIMGAdJ
         AK9hBzhOKnntyJuEHO1m/M6OWKFcHPhXdPCFzyF02pvAaCMLNSO6Hf/I1zXgErDbG3P/
         HXY+rhlI9e798gyKu6L+iOaPwXAOnlXNt27Ayg6JN5gT/o7nqPDtMZjeXVMhH1mi4aWn
         /kRuTl+HBcWzW43Q2NnWsP579KjfQ0QFvznEXvOq1vZXUuyapYwxM2d5dhfl/AxoLFIY
         RaXlW820mDCJI2JJ47Wc/mKelhehAa8i+mhnfZa1vhAHknWnibBsuMF3+Qsv7wAYKgPP
         bpSA==
X-Gm-Message-State: APt69E0qk6XcdJbSXNnQX6w3yPKLTeILR5jAWkaV0jng70WDlD667oG/
        NxMOBwk4mFmXjeqfLZ5OEw/TKw==
X-Google-Smtp-Source: ADUXVKK7PC8VGam7EvSijqQzXYNCE3gP1QpK1+fe6O98jRqF/S0S9iKdi80eS+oz+GYnNhp4Ct9J4A==
X-Received: by 2002:a50:a985:: with SMTP id n5-v6mr12610487edc.263.1529956101299;
        Mon, 25 Jun 2018 12:48:21 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id d11-v6sm17553edh.61.2018.06.25.12.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:48:20 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 1/4] block, bfq: add/remove entity weights correctly
Date:   Mon, 25 Jun 2018 21:48:03 +0200
Message-Id: <20180625194806.7619-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180625194806.7619-1-paolo.valente@linaro.org>
References: <20180625194806.7619-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To keep I/O throughput high as often as possible, BFQ performs
I/O-dispatch plugging (aka device idling) only when beneficial exactly
for throughput, or when needed for service guarantees (low latency,
fairness). An important case where the latter condition holds is when
the scenario is 'asymmetric' in terms of weights: i.e., when some
bfq_queue or whole group of queues has a higher weight, and thus has
to receive more service, than other queues or groups. Without dispatch
plugging, lower-weight queues/groups may unjustly steal bandwidth to
higher-weight queues/groups.

To detect asymmetric scenarios, BFQ checks some sufficient
conditions. One of these conditions is that active groups have
different weights. BFQ controls this condition by maintaining a
special set of unique weights of active groups
(group_weights_tree). To this purpose, in the function
bfq_active_insert/bfq_active_extract BFQ adds/removes the weight of a
group to/from this set.

Unfortunately, the function bfq_active_extract may happen to be
invoked also for a group that is still active (to preserve the correct
update of the next queue to serve, see comments in function
bfq_no_longer_next_in_service() for details). In this case, removing
the weight of the group makes the set group_weights_tree
inconsistent. Service-guarantee violations follow.

This commit addresses this issue by moving group_weights_tree
insertions from their previous location (in bfq_active_insert) into
the function __bfq_activate_entity, and by moving group_weights_tree
extractions from bfq_active_extract to when the entity that represents
a group remains throughly idle, i.e., with no request either enqueued
or dispatched.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 block/bfq-iosched.h |  7 +++++--
 block/bfq-wf2q.c    | 24 +++++++++++++-----------
 3 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 495b9ddb3355..3f32e88c7e9b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -742,8 +742,9 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_entity *entity,
  * See the comments to the function bfq_weights_tree_add() for considerations
  * about overhead.
  */
-void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_entity *entity,
-			     struct rb_root *root)
+void __bfq_weights_tree_remove(struct bfq_data *bfqd,
+			       struct bfq_entity *entity,
+			       struct rb_root *root)
 {
 	if (!entity->weight_counter)
 		return;
@@ -759,6 +760,43 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_entity *entity,
 	entity->weight_counter = NULL;
 }
 
+/*
+ * Invoke __bfq_weights_tree_remove on bfqq and all its inactive
+ * parent entities.
+ */
+void bfq_weights_tree_remove(struct bfq_data *bfqd,
+			     struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = bfqq->entity.parent;
+
+	__bfq_weights_tree_remove(bfqd, &bfqq->entity,
+				  &bfqd->queue_weights_tree);
+
+	for_each_entity(entity) {
+		struct bfq_sched_data *sd = entity->my_sched_data;
+
+		if (sd->next_in_service || sd->in_service_entity) {
+			/*
+			 * entity is still active, because either
+			 * next_in_service or in_service_entity is not
+			 * NULL (see the comments on the definition of
+			 * next_in_service for details on why
+			 * in_service_entity must be checked too).
+			 *
+			 * As a consequence, the weight of entity is
+			 * not to be removed. In addition, if entity
+			 * is active, then its parent entities are
+			 * active as well, and thus their weights are
+			 * not to be removed either. In the end, this
+			 * loop must stop here.
+			 */
+			break;
+		}
+		__bfq_weights_tree_remove(bfqd, entity,
+					  &bfqd->group_weights_tree);
+	}
+}
+
 /*
  * Return expired entry, or NULL to just start from scratch in rbtree.
  */
@@ -4582,8 +4620,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 		 */
 		bfqq->budget_timeout = jiffies;
 
-		bfq_weights_tree_remove(bfqd, &bfqq->entity,
-					&bfqd->queue_weights_tree);
+		bfq_weights_tree_remove(bfqd, bfqq);
 	}
 
 	now_ns = ktime_get_ns();
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 0f712e03b035..a8a2e5aca4d4 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -827,8 +827,11 @@ struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
 void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_entity *entity,
 			  struct rb_root *root);
-void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_entity *entity,
-			     struct rb_root *root);
+void __bfq_weights_tree_remove(struct bfq_data *bfqd,
+			       struct bfq_entity *entity,
+			       struct rb_root *root);
+void bfq_weights_tree_remove(struct bfq_data *bfqd,
+			     struct bfq_queue *bfqq);
 void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		     bool compensate, enum bfqq_expiration reason);
 void bfq_put_queue(struct bfq_queue *bfqq);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 4498c43245e2..58cf38fcee05 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -499,9 +499,6 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	else /* bfq_group */
-		bfq_weights_tree_add(bfqd, entity, &bfqd->group_weights_tree);
-
 	if (bfqg != bfqd->root_group)
 		bfqg->active_entities++;
 #endif
@@ -601,10 +598,6 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	else /* bfq_group */
-		bfq_weights_tree_remove(bfqd, entity,
-					&bfqd->group_weights_tree);
-
 	if (bfqg != bfqd->root_group)
 		bfqg->active_entities--;
 #endif
@@ -799,7 +792,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		if (prev_weight != new_weight) {
 			root = bfqq ? &bfqd->queue_weights_tree :
 				      &bfqd->group_weights_tree;
-			bfq_weights_tree_remove(bfqd, entity, root);
+			__bfq_weights_tree_remove(bfqd, entity, root);
 		}
 		entity->weight = new_weight;
 		/*
@@ -971,7 +964,7 @@ static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
  * one of its children receives a new request.
  *
  * Basically, this function updates the timestamps of entity and
- * inserts entity into its active tree, ater possibly extracting it
+ * inserts entity into its active tree, after possibly extracting it
  * from its idle tree.
  */
 static void __bfq_activate_entity(struct bfq_entity *entity,
@@ -1015,6 +1008,16 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 		entity->on_st = true;
 	}
 
+#ifdef BFQ_GROUP_IOSCHED_ENABLED
+	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
+		struct bfq_group *bfqg =
+			container_of(entity, struct bfq_group, entity);
+
+		bfq_weights_tree_add(bfqg->bfqd, entity,
+				     &bfqd->group_weights_tree);
+	}
+#endif
+
 	bfq_update_fin_time_enqueue(entity, st, backshifted);
 }
 
@@ -1664,8 +1667,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	bfqd->busy_queues--;
 
 	if (!bfqq->dispatched)
-		bfq_weights_tree_remove(bfqd, &bfqq->entity,
-					&bfqd->queue_weights_tree);
+		bfq_weights_tree_remove(bfqd, bfqq);
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues--;
-- 
2.16.1

