Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E141C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4366B206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="pr00AxmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4366B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbeIHCZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:53 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23044 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbeIHCZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356577; x=1567892577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qbo2tRBsA24neJorN0C3RRPRL0VsEZKsQ1z2jlpDL80=;
  b=pr00AxmDA7XP5BKLz5CPm1+dNzyteVhvX5Z9GFRzcqteKKyr9Jq3y/rP
   HcNeSZcO5tDmQU4uI36Bu+Z7jSAMBfqtAYbiq46ITsPl5DhxeZa8vrOt4
   Sn+tfHfsSDyd/duQcCk4VTAS8+MiQtyvu8tiWLLqcmjVtVXGwQ6bsLEKv
   4=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243261"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:57 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lgp3w005088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:54 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgokQ027762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:50 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgnZC027761;
        Fri, 7 Sep 2018 23:42:49 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 50/60] cosched: Propagate load changes across hierarchy levels
Date:   Fri,  7 Sep 2018 23:40:37 +0200
Message-Id: <20180907214047.26914-51-jschoenh@amazon.de>
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

The weight of an SD-SE is defined to be the average weight of all
runqueues that are represented by the SD-SE. Hence, its weight
should change whenever one of the child runqueues changes its
weight. However, as these are two different hierarchy levels,
they are protected by different locks. To reduce lock contention,
we want to avoid holding higher level locks for prolonged amounts
of time, if possible.

Therefore, we update an aggregated weight -- sdrq->sdse_load --
in a lock-free manner during enqueue and dequeue in the lower level,
and once we actually get the higher level lock, we perform the actual
SD-SE weight adjustment via update_sdse_load().

At some point in the future (the code isn't there yet), this will
allow software combining, where not all CPUs have to walk up the
full hierarchy on enqueue/dequeue.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0dc4d289497c..1eee262ecf88 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2740,6 +2740,10 @@ static inline void account_numa_dequeue(struct rq *rq, struct task_struct *p)
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+#ifdef CONFIG_COSCHEDULING
+	if (!cfs_rq->sdrq.is_root && !cfs_rq->throttled)
+		atomic64_add(se->load.weight, &cfs_rq->sdrq.sd_parent->sdse_load);
+#endif
 	update_load_add(&cfs_rq->load, se->load.weight);
 	if (!parent_entity(se) || is_sd_se(parent_entity(se)))
 		update_load_add(&hrq_of(cfs_rq)->load, se->load.weight);
@@ -2757,6 +2761,10 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+#ifdef CONFIG_COSCHEDULING
+	if (!cfs_rq->sdrq.is_root && !cfs_rq->throttled)
+		atomic64_sub(se->load.weight, &cfs_rq->sdrq.sd_parent->sdse_load);
+#endif
 	update_load_sub(&cfs_rq->load, se->load.weight);
 	if (!parent_entity(se) || is_sd_se(parent_entity(se)))
 		update_load_sub(&hrq_of(cfs_rq)->load, se->load.weight);
@@ -3083,6 +3091,35 @@ static inline void update_cfs_group(struct sched_entity *se)
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_COSCHEDULING
+static void update_sdse_load(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct sdrq *sdrq = &cfs_rq->sdrq;
+	unsigned long load;
+
+	if (!is_sd_se(se))
+		return;
+
+	/* FIXME: the load calculation assumes a homogeneous topology */
+	load = atomic64_read(&sdrq->sdse_load);
+
+	if (!list_empty(&sdrq->children)) {
+		struct sdrq *entry;
+
+		entry = list_first_entry(&sdrq->children, struct sdrq, siblings);
+		load *= entry->data->span_weight;
+	}
+
+	load /= sdrq->data->span_weight;
+
+	/* FIXME: Use a proper runnable */
+	reweight_entity(cfs_rq, se, load, load);
+}
+#else /* !CONFIG_COSCHEDULING */
+static void update_sdse_load(struct sched_entity *se) { }
+#endif /* !CONFIG_COSCHEDULING */
+
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 {
 	struct rq *rq = hrq_of(cfs_rq);
@@ -4527,6 +4564,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	se = cfs_rq->my_se;
 
+#ifdef CONFIG_COSCHEDULING
+	if (!cfs_rq->sdrq.is_root && !cfs_rq->throttled)
+		atomic64_sub(cfs_rq->load.weight,
+			     &cfs_rq->sdrq.sd_parent->sdse_load);
+#endif
 	/* freeze hierarchy runnable averages while throttled */
 	rcu_read_lock();
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
@@ -4538,6 +4580,8 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
 		rq_chain_lock(&rc, se);
+		update_sdse_load(se);
+
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
 			break;
@@ -4590,6 +4634,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	se = cfs_rq->my_se;
 
 	cfs_rq->throttled = 0;
+#ifdef CONFIG_COSCHEDULING
+	if (!cfs_rq->sdrq.is_root && !cfs_rq->throttled)
+		atomic64_add(cfs_rq->load.weight,
+			     &cfs_rq->sdrq.sd_parent->sdse_load);
+#endif
 
 	update_rq_clock(rq);
 
@@ -4608,6 +4657,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
 		rq_chain_lock(&rc, se);
+		update_sdse_load(se);
 		if (se->on_rq)
 			enqueue = 0;
 
@@ -5152,6 +5202,7 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
 		rq_chain_lock(&rc, se);
+		update_sdse_load(se);
 		if (se->on_rq)
 			break;
 		cfs_rq = cfs_rq_of(se);
@@ -5173,6 +5224,7 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 	for_each_sched_entity(se) {
 		/* FIXME: taking locks up to the top is bad */
 		rq_chain_lock(&rc, se);
+		update_sdse_load(se);
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running += task_delta;
 
@@ -5235,6 +5287,7 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
 		rq_chain_lock(&rc, se);
+		update_sdse_load(se);
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
@@ -5269,6 +5322,7 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 	for_each_sched_entity(se) {
 		/* FIXME: taking locks up to the top is bad */
 		rq_chain_lock(&rc, se);
+		update_sdse_load(se);
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running -= task_delta;
 
@@ -9897,6 +9951,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 	for_each_sched_entity(se) {
 		rq_chain_lock(&rc, se);
+		update_sdse_load(se);
 		cfs_rq = cfs_rq_of(se);
 
 		if (cfs_rq_throttled(cfs_rq))
-- 
2.9.3.1.gcba166c.dirty

