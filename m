Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00AD206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Gmc4kXIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00AD206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeIHCat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:30:49 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:13592 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbeIHC2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356719; x=1567892719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JuawJiTCHFeQ9uVf7eMsprlZCsPurTbGgekNnh+kC34=;
  b=Gmc4kXISricILiVV/1gnmOYUBCoBCnGSJE1CDS9Ks+bFynxvfIZeiCdT
   M1CUkkoVyPsdpLCQrN0eb4Yxwpxj3MOJ0E2UE6LkLsMoFqsX/0jPw9Vti
   94QEhNR8aOeTV+n98ILQvkItME1fxyZcBTma7XL5Gs1OtVO4xY4ywL67l
   M=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="629734550"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:42 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LflfA015919
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:49 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lfjl7027292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:45 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfihC027291;
        Fri, 7 Sep 2018 23:41:44 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 17/60] sched: Introduce and use generic task group CFS traversal functions
Date:   Fri,  7 Sep 2018 23:40:04 +0200
Message-Id: <20180907214047.26914-18-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Task group management has to iterate over all CFS runqueues within the
task group. Currently, this uses for_each_possible_cpu() loops and
accesses tg->cfs_rq[] directly. This does not adjust well to the
upcoming addition of coscheduling, where we will have additional CFS
runqueues.

Introduce more general traversal loop constructs, which will extend
nicely to coscheduling. Rewrite task group management functions to
make use of these new loop constructs. Except for the function
alloc_fair_sched_group(), the changes are mostly cosmetic.
alloc_fair_sched_group() now iterates over the parent group to
create a new group.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c  | 64 +++++++++++++++++++++++-----------------------------
 kernel/sched/sched.h | 31 +++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 82cdd75e88b9..9f63ac37f5ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9805,16 +9805,13 @@ static void task_change_group_fair(struct task_struct *p, int type)
 
 void free_fair_sched_group(struct task_group *tg)
 {
-	int i;
+	struct cfs_rq *cfs, *ncfs;
 
 	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
-	if (!tg->cfs_rq)
-		return;
-
-	for_each_possible_cpu(i) {
-		kfree(tg->cfs_rq[i]->my_se);
-		kfree(tg->cfs_rq[i]);
+	taskgroup_for_each_cfsrq_safe(tg, cfs, ncfs) {
+		kfree(cfs->my_se);
+		kfree(cfs);
 	}
 
 	kfree(tg->cfs_rq);
@@ -9823,8 +9820,7 @@ void free_fair_sched_group(struct task_group *tg)
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 {
 	struct sched_entity *se;
-	struct cfs_rq *cfs_rq;
-	int i;
+	struct cfs_rq *cfs_rq, *pcfs_rq;
 
 	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
 	if (!tg->cfs_rq)
@@ -9834,26 +9830,25 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
-	for_each_possible_cpu(i) {
-		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
-				      GFP_KERNEL, cpu_to_node(i));
-		if (!cfs_rq)
-			goto err;
+	taskgroup_for_each_cfsrq(parent, pcfs_rq) {
+		struct rq *rq = rq_of(pcfs_rq);
+		int node = cpu_to_node(cpu_of(rq));
 
-		se = kzalloc_node(sizeof(struct sched_entity),
-				  GFP_KERNEL, cpu_to_node(i));
-		if (!se)
-			goto err_free_rq;
+		cfs_rq = kzalloc_node(sizeof(*cfs_rq), GFP_KERNEL, node);
+		se = kzalloc_node(sizeof(*se), GFP_KERNEL, node);
+		if (!cfs_rq || !se)
+			goto err_free;
 
-		tg->cfs_rq[i] = cfs_rq;
+		tg->cfs_rq[cpu_of(rq)] = cfs_rq;
 		init_cfs_rq(cfs_rq);
-		init_tg_cfs_entry(tg, cfs_rq, se, cpu_rq(i), parent->cfs_rq[i]);
+		init_tg_cfs_entry(tg, cfs_rq, se, rq, pcfs_rq);
 	}
 
 	return 1;
 
-err_free_rq:
+err_free:
 	kfree(cfs_rq);
+	kfree(se);
 err:
 	return 0;
 }
@@ -9861,17 +9856,17 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 void online_fair_sched_group(struct task_group *tg)
 {
 	struct sched_entity *se;
+	struct cfs_rq *cfs;
 	struct rq *rq;
-	int i;
 
-	for_each_possible_cpu(i) {
-		rq = cpu_rq(i);
-		se = tg->cfs_rq[i]->my_se;
+	taskgroup_for_each_cfsrq(tg, cfs) {
+		rq = rq_of(cfs);
+		se = cfs->my_se;
 
 		raw_spin_lock_irq(&rq->lock);
 		update_rq_clock(rq);
 		attach_entity_cfs_rq(se);
-		sync_throttle(tg->cfs_rq[i]);
+		sync_throttle(cfs);
 		raw_spin_unlock_irq(&rq->lock);
 	}
 }
@@ -9879,24 +9874,21 @@ void online_fair_sched_group(struct task_group *tg)
 void unregister_fair_sched_group(struct task_group *tg)
 {
 	unsigned long flags;
-	struct rq *rq;
-	int cpu;
+	struct cfs_rq *cfs;
 
-	for_each_possible_cpu(cpu) {
-		remove_entity_load_avg(tg->cfs_rq[cpu]->my_se);
+	taskgroup_for_each_cfsrq(tg, cfs) {
+		remove_entity_load_avg(cfs->my_se);
 
 		/*
 		 * Only empty task groups can be destroyed; so we can speculatively
 		 * check on_list without danger of it being re-added.
 		 */
-		if (!tg->cfs_rq[cpu]->on_list)
+		if (!cfs->on_list)
 			continue;
 
-		rq = cpu_rq(cpu);
-
-		raw_spin_lock_irqsave(&rq->lock, flags);
-		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_lock_irqsave(&rq_of(cfs)->lock, flags);
+		list_del_leaf_cfs_rq(cfs);
+		raw_spin_unlock_irqrestore(&rq_of(cfs)->lock, flags);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cd3a32ce8fc6..9ecbb57049a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -946,6 +946,37 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+#define taskgroup_for_each_cfsrq(tg, cfs) \
+	for ((cfs) = taskgroup_first_cfsrq(tg); (cfs); \
+	     (cfs) = taskgroup_next_cfsrq(tg, cfs))
+
+#define taskgroup_for_each_cfsrq_safe(tg, cfs, ncfs) \
+	for ((cfs) = taskgroup_first_cfsrq(tg), \
+		(ncfs) = (cfs) ? taskgroup_next_cfsrq(tg, cfs) : NULL; \
+	     (cfs); \
+	     (cfs) = (ncfs), \
+		(ncfs) = (cfs) ? taskgroup_next_cfsrq(tg, cfs) : NULL)
+
+static inline struct cfs_rq *taskgroup_first_cfsrq(struct task_group *tg)
+{
+	int cpu = cpumask_first(cpu_possible_mask);
+
+	if (!tg->cfs_rq)
+		return NULL;
+	return tg->cfs_rq[cpu];
+}
+
+static inline struct cfs_rq *taskgroup_next_cfsrq(struct task_group *tg,
+						  struct cfs_rq *cfs)
+{
+	int cpu = cpumask_next(cpu_of(cfs->rq), cpu_possible_mask);
+
+	if (cpu >= nr_cpu_ids)
+		return NULL;
+	return tg->cfs_rq[cpu];
+}
+#endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_SCHED_SMT
 
-- 
2.9.3.1.gcba166c.dirty

