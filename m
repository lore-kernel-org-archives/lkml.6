Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F56206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="AdZHTMwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F56206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeIHC3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:19 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:38194 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeIHC3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356780; x=1567892780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xiA9e/0TVd+Bdu43gcIQLAmuMtJ63yHOesR7OpWU3bM=;
  b=AdZHTMwghe/Oqv3PqwOk30Ds3lVLRTUQMZSzKW8sTX2U7zPLYlVfIH7A
   4QNP4g7tsH1IrqVKhR2/h/1Q2+VfA0q/isa962AAwKoiL3qF2FhtqV/C4
   hO36emvzw++2jGEchgLRQBzIYN8Yg6v9qQCLXu4dVF3jxgbrXj8JE7ESU
   w=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="752286792"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:45 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lg2rm034611
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:05 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lg1CR027380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:01 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lg0SS027373;
        Fri, 7 Sep 2018 23:42:00 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 23/60] cosched: Add core data structures for coscheduling
Date:   Fri,  7 Sep 2018 23:40:10 +0200
Message-Id: <20180907214047.26914-24-jschoenh@amazon.de>
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

For coscheduling, we will set up hierarchical runqueues that correspond
to larger fractions of the system. They will be organized along the
scheduling domains.

Although it is overkill at the moment, we keep a full struct rq per
scheduling domain. The existing code is so used to pass struct rq
around, that it would be a large refactoring effort to concentrate the
actually needed fields of struct rq in a smaller structure. Also, we
will probably need more fields in the future.

Extend struct rq and struct cfs_rq with extra structs encapsulating
all purely coscheduling related fields: struct sdrq_data and struct
sdrq, respectively.

Extend struct task_group, so that we can keep track of the hierarchy
and how this task_group should behave. We can now distinguish between
regular task groups and scheduled task groups. The former work as usual,
while the latter actively utilize the hierarchical aspect and represent
SEs of a lower hierarchy level at a higher level within the parent task
group, causing SEs at the lower level to get coscheduled.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/sched.h | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b36e61914a42..1bce6061ac45 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -368,6 +368,27 @@ struct task_group {
 #endif
 #endif
 
+#ifdef CONFIG_COSCHEDULING
+	/*
+	 * References the top of this task-group's RQ hierarchy. This is
+	 * static and does not change. It is used as entry-point to traverse
+	 * the structure on creation/destruction.
+	 */
+	struct cfs_rq *top_cfsrq;
+
+	/* Protects .scheduled from concurrent modifications */
+	raw_spinlock_t lock;
+
+	/*
+	 * Indicates the level at which this task group is scheduled:
+	 * 0 == bottom level == regular task group
+	 * >0 == scheduled task group
+	 *
+	 * Modifications are (for now) requested by the user.
+	 */
+	int scheduled;
+#endif
+
 #ifdef CONFIG_RT_GROUP_SCHED
 	struct sched_rt_entity	**rt_se;
 	struct rt_rq		**rt_rq;
@@ -485,6 +506,120 @@ struct rq_flags {
 #endif
 };
 
+#ifdef CONFIG_COSCHEDULING
+struct sdrq_data {
+	/*
+	 * Leader for this part of the hierarchy.
+	 *
+	 * The leader CPU is responsible for scheduling decisions and any
+	 * required maintenance.
+	 *
+	 * Leadership is variable and may be taken while the hierarchy level
+	 * is locked.
+	 */
+	int leader;
+
+	/* Height within the hierarchy: leaf == 0, parent == child + 1 */
+	int level;
+
+	/* Parent runqueue */
+	struct sdrq_data *parent;
+
+	/*
+	 * SD-RQ from which SEs get selected.
+	 *
+	 * This is set by the parent's leader and defines the current
+	 * schedulable subset of tasks within this part of the hierarchy.
+	 */
+	struct sdrq *current_sdrq;
+
+	/* CPUs making up this part of the hierarchy */
+	const struct cpumask *span;
+
+	/* Number of CPUs within this part of the hierarchy */
+	unsigned int span_weight;
+
+	/*
+	 * Determines if the corresponding SD-RQs are to be allocated on
+	 * a specific NUMA node.
+	 */
+	int numa_node;
+
+	/* Storage for rq_flags, when we need to lock multiple runqueues. */
+	struct rq_flags rf;
+
+	/* Do we have the parent runqueue locked? */
+	bool parent_locked;
+
+	/*
+	 * In case the CPU has been forced into idle, the idle_se references the
+	 * scheduling entity responsible for this. Only used on bottom level at
+	 * the moment.
+	 */
+	struct sched_entity *idle_se;
+};
+
+struct sdrq {
+	/* Common information for all SD-RQs at the same position */
+	struct sdrq_data *data;
+
+	/* SD hierarchy */
+	struct sdrq *sd_parent;		/* parent of this node */
+	struct list_head children;	/* children of this node */
+	struct list_head siblings;	/* link to parent's children list */
+
+	/*
+	 * is_root == 1 => link via tg_se into tg_parent->cfs_rq
+	 * is_root == 0 => link via sd_parent->sd_se into sd_parent->cfs_rq
+	 */
+	int is_root;
+
+	/*
+	 * SD-SE: an SE to be enqueued in .cfs_rq to represent this
+	 * node's children in order to make their members schedulable.
+	 *
+	 * In the bottom layer .sd_se has to be NULL for various if-conditions
+	 * and loop terminations. On other layers .sd_se points to .__sd_se.
+	 *
+	 * .__sd_se is unused within the bottom layer.
+	 */
+	struct sched_entity *sd_se;
+	struct sched_entity __sd_se;
+
+	/* Accumulated load of all SD-children */
+	atomic64_t sdse_load;
+
+	/*
+	 * Reference to the SD-runqueue at the same hierarchical position
+	 * in the parent task group.
+	 */
+	struct sdrq *tg_parent;
+	struct list_head tg_children;	/* child TGs of this node */
+	struct list_head tg_siblings;	/* link to parent's children list */
+
+	/*
+	 * TG-SE: a SE to be enqueued in .tg_parent->cfs_rq.
+	 *
+	 * In the case of a regular TG it is enqueued if .cfs_rq is not empty.
+	 * In the case of a scheduled TG it is enqueued if .cfs_rq is not empty
+	 * and this SD-RQ acts as a root SD within its TG.
+	 *
+	 * .tg_se takes over the role of .cfs_rq->my_se and points to the same
+	 * SE over its life-time, while .cfs_rq->my_se now points to either the
+	 * TG-SE or the SD-SE (or NULL in the parts of the root task group).
+	 */
+	struct sched_entity *tg_se;
+
+	/*
+	 * CFS runqueue of this SD runqueue.
+	 *
+	 * FIXME: Now that struct sdrq is embedded in struct cfs_rq, we could
+	 *        drop this.
+	 */
+	struct cfs_rq *cfs_rq;
+};
+#endif /* CONFIG_COSCHEDULING */
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
@@ -544,6 +679,12 @@ struct cfs_rq {
 	u64			last_h_load_update;
 	struct sched_entity	*h_load_next;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+
+#ifdef CONFIG_COSCHEDULING
+	/* Extra info needed for hierarchical scheduling */
+	struct sdrq sdrq;
+#endif
+
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -817,6 +958,11 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+#ifdef CONFIG_COSCHEDULING
+	/* Extra information for hierarchical scheduling */
+	struct sdrq_data sdrq_data;
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;
@@ -935,6 +1081,11 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+
+#ifdef CONFIG_COSCHEDULING
+	/* Top level runqueue for this sched_domain */
+	struct rq rq;
+#endif
 };
 
 static inline int cpu_of(struct rq *rq)
-- 
2.9.3.1.gcba166c.dirty

