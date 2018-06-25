Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACD9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C1726099
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gC0vs0BK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C1726099
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965152AbeFYT4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:56:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38566 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964980AbeFYTzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:55:52 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so14868055wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iLVhnU7LLoCaW4lOc7bzsWA0oIfhsKCR8yo/rG/4vtQ=;
        b=gC0vs0BKLnoMLzo+DvIFmlFJJETL4oSycWMGTs4kiDcFHqcBCpXNl4xEbYJpKtDun6
         BAEB+CZEIHEgem7Rf6Uld9sUeUcT07GG76EA6rcwutcLihBPztdJxAykEmdVFg3E4rEx
         M9+yAXC3kgY0s766mTIyeH757wOjjXg7iwjUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iLVhnU7LLoCaW4lOc7bzsWA0oIfhsKCR8yo/rG/4vtQ=;
        b=VsX1WwBfz26p1ddDo2J5iy/My+c1dVPs4GqguiBqZWAqi86fZMDKrkmkvNgzRvK5f/
         O93I5vLQyL694Wg8AjtLvxD9haCxn4pBIfpfzgKj9gX/kEgr4jJB5b8/wAKDPERh5C3n
         /01U9W3FajQN3rLPixVO8nzdd3Bp0P9bNP57iG6bwz0onL4d07RpBtGN2XszEn3Mnf/F
         j8BxUgeLqDbqnroRjBB7lOH4rXvlu0i+ZxSRPNuk9hUcRXgdcLMqJ4YOeVJn6uqW11w1
         abru8xuYWAPzY/dtoQfsqN8UG5EyxJ6TQ2H+muRrb/RiWHTNJDH5y1fNn78ybrwd9Boh
         jbFQ==
X-Gm-Message-State: APt69E1Js82EnbpxJn1hACKuC5Vkr3LOjgQLtCiGAOboeZgbJe0tM1bD
        W3w8jT8ezl6dFwdPtAl9n9jazg==
X-Google-Smtp-Source: AAOMgpfMYTdoQnUKN0bVJzcjEBk5kWgXnuMX7qydirhYlHjzxIBboA3aQQFaj6RkCD6lQ5o2WCd0VA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3-v6mr11103777wrn.33.1529956550957;
        Mon, 25 Jun 2018 12:55:50 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id n18-v6sm29072897wrj.58.2018.06.25.12.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:55:50 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX RESEND 1/4] block, bfq: add/remove entity weights correctly
Date:   Mon, 25 Jun 2018 21:55:34 +0200
Message-Id: <20180625195537.7769-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
References: <20180625195537.7769-1-paolo.valente@linaro.org>
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

