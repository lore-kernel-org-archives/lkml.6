Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE8EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7729A204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="JemBSRrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7729A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbeIHCdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:33:31 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:59880 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbeIHCZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356558; x=1567892558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypT4unnrpml18pW4pr4MW6+rnP3rjdqXp20S1XEu3Gc=;
  b=JemBSRrWe2Eha9E5XibmKrj3ZS7aRpkihO2wCOao9RRNeu2K/jA547cb
   vbMjZ54hhusgy9Ha6c4/4TsgWFFru3ic1ZQvuP+mRRXxM1lHACfpOdgGq
   8BtBCOt+zc186ZpV31Ti98Hu4IuEzRbjYNAK8X9EAeLUUQ286ZWFH1Go+
   Q=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696509982"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:38 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgVV5124422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:34 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgTq5027611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:30 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgTSe027610;
        Fri, 7 Sep 2018 23:42:29 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 39/60] cosched: Adjust task group management for hierarchical runqueues
Date:   Fri,  7 Sep 2018 23:40:26 +0200
Message-Id: <20180907214047.26914-40-jschoenh@amazon.de>
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

Provide variants of the task group CFS traversal constructs that also
reach the hierarchical runqueues. Adjust task group management functions
where necessary.

The most changes are in alloc_fair_sched_group(), where we now need to
be a bit more careful during initialization.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/cosched.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c    | 47 ++++++++++++++++++++++++++++------
 kernel/sched/sched.h   | 17 +++++++++++++
 3 files changed, 124 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index 48394050ec34..b897319d046c 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -10,6 +10,63 @@
 
 #include "sched.h"
 
+/*****************************************************************************
+ * Task group traversal
+ *****************************************************************************/
+
+static struct sdrq *leftmost_sdrq(struct sdrq *sdrq)
+{
+	while (!list_empty(&sdrq->children))
+		sdrq = list_first_entry(&sdrq->children, struct sdrq, siblings);
+	return sdrq;
+}
+
+struct cfs_rq *taskgroup_first_cfsrq(struct task_group *tg)
+{
+	if (!tg->top_cfsrq)
+		return NULL;
+	return leftmost_sdrq(&tg->top_cfsrq->sdrq)->cfs_rq;
+}
+
+struct cfs_rq *taskgroup_next_cfsrq(struct task_group *tg, struct cfs_rq *cfs)
+{
+	struct sdrq *sdrq = &cfs->sdrq;
+	struct sdrq *parent = sdrq->sd_parent;
+
+	if (cfs == tg->top_cfsrq)
+		return NULL;
+
+	list_for_each_entry_continue(sdrq, &parent->children, siblings)
+		return leftmost_sdrq(sdrq)->cfs_rq;
+
+	return parent->cfs_rq;
+}
+
+struct cfs_rq *taskgroup_first_cfsrq_topdown(struct task_group *tg)
+{
+	return tg->top_cfsrq;
+}
+
+struct cfs_rq *taskgroup_next_cfsrq_topdown(struct task_group *tg,
+					    struct cfs_rq *cfs)
+{
+	struct sdrq *sdrq = &cfs->sdrq;
+	struct sdrq *parent = sdrq->sd_parent;
+
+	if (!list_empty(&sdrq->children)) {
+		sdrq = list_first_entry(&sdrq->children, struct sdrq, siblings);
+		return sdrq->cfs_rq;
+	}
+
+	while (sdrq != &tg->top_cfsrq->sdrq) {
+		list_for_each_entry_continue(sdrq, &parent->children, siblings)
+			return sdrq->cfs_rq;
+		sdrq = parent;
+		parent = sdrq->sd_parent;
+	}
+	return NULL;
+}
+
 static int mask_to_node(const struct cpumask *span)
 {
 	int node = cpu_to_node(cpumask_first(span));
@@ -427,3 +484,14 @@ void cosched_init_hierarchy(void)
 		list_add_tail(&sdrq->siblings, &sdrq->sd_parent->children);
 	}
 }
+
+/*****************************************************************************
+ * Task group management functions
+ *****************************************************************************/
+
+void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs_rq,
+		       struct cfs_rq *sd_parent, struct cfs_rq *tg_parent)
+{
+	init_sdrq(tg, &cfs_rq->sdrq, sd_parent ? &sd_parent->sdrq : NULL,
+		  &tg_parent->sdrq, tg_parent->sdrq.data);
+}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33e3f759eb99..f72a72c8c3b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9895,10 +9895,29 @@ void free_fair_sched_group(struct task_group *tg)
 	kfree(tg->cfs_rq);
 }
 
+#ifdef CONFIG_COSCHEDULING
+static struct cfs_rq *find_sd_parent(struct cfs_rq *sd_parent,
+				     struct cfs_rq *tg_parent)
+{
+	if (!sd_parent)
+		return NULL;
+
+	while (sd_parent->sdrq.tg_parent != tg_parent->sdrq.sd_parent)
+		sd_parent = sd_parent->sdrq.sd_parent->cfs_rq;
+	return sd_parent;
+}
+#else
+static struct cfs_rq *find_sd_parent(struct cfs_rq *sd_parent,
+				     struct cfs_rq *tg_parent)
+{
+	return NULL;
+}
+#endif
+
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 {
 	struct sched_entity *se;
-	struct cfs_rq *cfs_rq, *pcfs_rq;
+	struct cfs_rq *cfs_rq = NULL, *pcfs_rq;
 
 	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
 	if (!tg->cfs_rq)
@@ -9908,18 +9927,30 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
-	taskgroup_for_each_cfsrq(parent, pcfs_rq) {
-		struct rq *rq = rq_of(pcfs_rq);
-		int node = cpu_to_node(cpu_of(rq));
+#ifdef CONFIG_COSCHEDULING
+	raw_spin_lock_init(&tg->lock);
+#endif
+
+	taskgroup_for_each_cfsrq_topdown(parent, pcfs_rq) {
+		struct rq *rq = hrq_of(pcfs_rq);
+		int node = node_of(rq);
+		struct cfs_rq *sdcfs_rq = find_sd_parent(cfs_rq, pcfs_rq);
 
 		cfs_rq = kzalloc_node(sizeof(*cfs_rq), GFP_KERNEL, node);
 		se = kzalloc_node(sizeof(*se), GFP_KERNEL, node);
 		if (!cfs_rq || !se)
 			goto err_free;
 
-		tg->cfs_rq[cpu_of(rq)] = cfs_rq;
+#ifdef CONFIG_COSCHEDULING
+		if (!sdcfs_rq)
+			tg->top_cfsrq = cfs_rq;
+#endif
+		if (is_cpu_rq(rq))
+			tg->cfs_rq[cpu_of(rq)] = cfs_rq;
+
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, rq, pcfs_rq);
+		cosched_init_sdrq(tg, cfs_rq, sdcfs_rq, pcfs_rq);
 	}
 
 	return 1;
@@ -9938,7 +9969,7 @@ void online_fair_sched_group(struct task_group *tg)
 	struct rq *rq;
 
 	taskgroup_for_each_cfsrq(tg, cfs) {
-		rq = rq_of(cfs);
+		rq = hrq_of(cfs);
 		se = cfs->my_se;
 
 		raw_spin_lock_irq(&rq->lock);
@@ -9964,9 +9995,9 @@ void unregister_fair_sched_group(struct task_group *tg)
 		if (!cfs->on_list)
 			continue;
 
-		raw_spin_lock_irqsave(&rq_of(cfs)->lock, flags);
+		raw_spin_lock_irqsave(&hrq_of(cfs)->lock, flags);
 		list_del_leaf_cfs_rq(cfs);
-		raw_spin_unlock_irqrestore(&rq_of(cfs)->lock, flags);
+		raw_spin_unlock_irqrestore(&hrq_of(cfs)->lock, flags);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bc3631b8b955..38b4500095ca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1109,6 +1109,17 @@ static inline int cpu_of(struct rq *rq)
 	     (cfs) = (ncfs), \
 		(ncfs) = (cfs) ? taskgroup_next_cfsrq(tg, cfs) : NULL)
 
+#ifdef CONFIG_COSCHEDULING
+#define taskgroup_for_each_cfsrq_topdown(tg, cfs) \
+	for ((cfs) = taskgroup_first_cfsrq_topdown(tg); (cfs); \
+	     (cfs) = taskgroup_next_cfsrq_topdown(tg, cfs))
+struct cfs_rq *taskgroup_first_cfsrq(struct task_group *tg);
+struct cfs_rq *taskgroup_next_cfsrq(struct task_group *tg, struct cfs_rq *cfs);
+struct cfs_rq *taskgroup_first_cfsrq_topdown(struct task_group *tg);
+struct cfs_rq *taskgroup_next_cfsrq_topdown(struct task_group *tg,
+					    struct cfs_rq *cfs);
+#else /* !CONFIG_COSCHEDULING */
+#define taskgroup_for_each_cfsrq_topdown taskgroup_for_each_cfsrq
 static inline struct cfs_rq *taskgroup_first_cfsrq(struct task_group *tg)
 {
 	int cpu = cpumask_first(cpu_possible_mask);
@@ -1127,6 +1138,7 @@ static inline struct cfs_rq *taskgroup_next_cfsrq(struct task_group *tg,
 		return NULL;
 	return tg->cfs_rq[cpu];
 }
+#endif /* !CONFIG_COSCHEDULING */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_COSCHEDULING
@@ -1181,10 +1193,15 @@ static inline bool is_sd_se(struct sched_entity *se)
 void cosched_init_bottom(void);
 void cosched_init_topology(void);
 void cosched_init_hierarchy(void);
+void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs,
+		       struct cfs_rq *sd_parent, struct cfs_rq *tg_parent);
 #else /* !CONFIG_COSCHEDULING */
 static inline void cosched_init_bottom(void) { }
 static inline void cosched_init_topology(void) { }
 static inline void cosched_init_hierarchy(void) { }
+static inline void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs,
+				     struct cfs_rq *sd_parent,
+				     struct cfs_rq *tg_parent) { }
 #endif /* !CONFIG_COSCHEDULING */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.9.3.1.gcba166c.dirty

