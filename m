Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A17C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E501206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ddAAeSgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E501206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeIHC1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:07 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:20100 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeIHC1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356651; x=1567892651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VvCsnpX45hl3V2NAYGkcNlumSkE11F8CMi8cQ3FQvPI=;
  b=ddAAeSgl4KNuOsKgMuFlsTILnfVAn8h4dbPto2DqyiqrXH18hDcU4arz
   OX50Ex4zNwtNfHYOsP7Y0qXaa/Xp6i75WvqbY98eVGbZPQcoEe9RWOCjm
   qEWY2xcyzff3laYC+5FBUOj4eesn4h3JbaiMQWTTFGSzjZlD8iyZI9Ime
   E=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696510144"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:10 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lg4X9067576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:06 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lg2ol027391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:03 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lg265027387;
        Fri, 7 Sep 2018 23:42:02 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 24/60] cosched: Do minimal pre-SMP coscheduler initialization
Date:   Fri,  7 Sep 2018 23:40:11 +0200
Message-Id: <20180907214047.26914-25-jschoenh@amazon.de>
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

The scheduler is operational before we have the necessary information
about scheduling domains, which would allow us to set up the runqueue
hierarchy. Because of that, we have to postpone the "real"
initialization a bit. We cannot not totally skip all initialization,
though, because all the adapted scheduler code paths do not really
like NULL pointers within the extended coscheduling related data
structures.

Perform a minimal setup of the coscheduling data structures at the
bottom level (i.e., CPU level), so that all traversals terminate
correctly. There is no hierarchy yet.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c    |  2 ++
 kernel/sched/cosched.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |  6 ++++
 3 files changed, 93 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 48e37c3baed1..a235b6041cb5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6058,6 +6058,8 @@ void __init sched_init(void)
 		atomic_set(&rq->nr_iowait, 0);
 	}
 
+	cosched_init_bottom();
+
 	set_load_weight(&init_task, false);
 
 	/*
diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index 3bd4557ca5b7..03ba86676b90 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -7,3 +7,88 @@
  */
 
 #include "sched.h"
+
+static int mask_to_node(const struct cpumask *span)
+{
+	int node = cpu_to_node(cpumask_first(span));
+
+	if (cpumask_subset(span, cpumask_of_node(node)))
+		return node;
+
+	return NUMA_NO_NODE;
+}
+
+static void init_sdrq_data(struct sdrq_data *data, struct sdrq_data *parent,
+			   const struct cpumask *span, int level)
+{
+	struct rq *rq = container_of(data, struct rq, sdrq_data);
+	int cpu = cpumask_first(span);
+	int weight = cpumask_weight(span);
+
+	data->numa_node = weight == 1 ? cpu_to_node(cpu) : mask_to_node(span);
+	data->leader = cpu;
+	data->level = level >= 0 ? level : parent->level - 1;
+	data->parent = parent;
+	data->span = span;
+	data->span_weight = weight;
+	data->current_sdrq = &rq->cfs.sdrq;
+
+	/*
+	 * Bottom level runqueues have already been initialized and are live,
+	 * do not initialize them again.
+	 */
+	if (!data->level)
+		return;
+
+	/* Initialize the subset of struct rq in which we are interested. */
+	raw_spin_lock_init(&rq->lock);
+	rq->cpu = cpu;
+	INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
+	rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+}
+
+static void init_sdrq(struct task_group *tg, struct sdrq *sdrq,
+		      struct sdrq *sd_parent, struct sdrq *tg_parent,
+		      struct sdrq_data *data)
+{
+	struct rq *rq = container_of(data, struct rq, sdrq_data);
+	struct cfs_rq *cfs_rq = container_of(sdrq, struct cfs_rq, sdrq);
+
+	/* Attention: tg->parent may not yet be set. Check tg_parent instead. */
+
+	sdrq->sd_parent = sd_parent;
+	sdrq->tg_parent = tg_parent;
+	sdrq->data = data;
+	sdrq->is_root = 1;
+	sdrq->cfs_rq = cfs_rq;
+	sdrq->tg_se = cfs_rq->my_se;
+
+	INIT_LIST_HEAD(&sdrq->tg_children);
+	INIT_LIST_HEAD(&sdrq->children);
+	if (sd_parent)
+		list_add_tail(&sdrq->siblings, &sd_parent->children);
+
+	/*
+	 * If we are not at the bottom level in hierarchy, we need to setup
+	 * a SD-SE, so that the level below us can be represented within this
+	 * level.
+	 */
+	if (data->level) {
+		sdrq->sd_se = &sdrq->__sd_se;
+		init_tg_cfs_entry(tg, NULL, sdrq->sd_se, rq, sdrq->cfs_rq);
+	}
+}
+
+void cosched_init_bottom(void)
+{
+	int cpu;
+
+	raw_spin_lock_init(&root_task_group.lock);
+	for_each_possible_cpu(cpu) {
+		struct sdrq_data *data = &cpu_rq(cpu)->sdrq_data;
+		struct sdrq *sdrq = &root_task_group.cfs_rq[cpu]->sdrq;
+
+		init_sdrq_data(data, NULL, cpumask_of(cpu), 0);
+		init_sdrq(&root_task_group, sdrq, NULL, NULL, data);
+	}
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1bce6061ac45..21b7c6cf8b87 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1129,6 +1129,12 @@ static inline struct cfs_rq *taskgroup_next_cfsrq(struct task_group *tg,
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_COSCHEDULING
+void cosched_init_bottom(void);
+#else /* !CONFIG_COSCHEDULING */
+static inline void cosched_init_bottom(void) { }
+#endif /* !CONFIG_COSCHEDULING */
+
 #ifdef CONFIG_SCHED_SMT
 
 extern struct static_key_false sched_smt_present;
-- 
2.9.3.1.gcba166c.dirty

