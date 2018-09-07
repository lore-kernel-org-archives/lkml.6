Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E11C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0520720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="skmI/Sq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0520720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbeIHCZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:10 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:8260 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbeIHCZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356532; x=1567892532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F2rRjqCSyrazcP6SxM63MYp1/JsmZlCP0D9iEd0gJlE=;
  b=skmI/Sq5G0DZ7P2ty1YHhQe7DGkX1DTcrd6Nrd+ROl4Bo2wjYa3YtiY4
   OScRRZfrAhySj9IPbHAhpOdcS86rDEaTpv3NWZo5Z1+WdtE7GYVk2rZRM
   r/BRUNYHLBASUfIggXx01K8yU4w6PUnincuZWwTHBogLM/s++LWfAtMp8
   c=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243180"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:11 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lg6ZH090136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:08 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lg44Q027416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:04 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lg3Ua027398;
        Fri, 7 Sep 2018 23:42:03 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 25/60] cosched: Prepare scheduling domain topology for coscheduling
Date:   Fri,  7 Sep 2018 23:40:12 +0200
Message-Id: <20180907214047.26914-26-jschoenh@amazon.de>
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

The ability to coschedule is coupled closely to the scheduling domain
topology: all CPUs within a scheduling domain will context switch
simultaneously. In other words, each scheduling domain also defines
a synchronization domain.

That means, that we should have a wider selection of scheduling domains
than just the typical core, socket, system distinction. Otherwise, it
won't be possible to, e.g., coschedule a subset of a processor. While
synchronization domains based on hardware boundaries are exactly the
right thing when it comes to most resource contention or security
related use cases for coscheduling, it is a limiting factor when
considering coscheduling use cases around parallel programs.

On the other hand that means, that all CPUs need to have the same view
on which groups of CPUs form scheduling domains, as synchronization
domains have to be global by definition.

Introduce a function that post-processes the scheduling domain
topology just before the scheduling domains are generated. We use this
opportunity to get rid of overlapping (aka. non-global) scheduling
domains and to introduce additional levels of scheduling domains to
keep a more reasonable fan-out.

Couple the splitting of scheduling domains to a command line argument,
that is disabled by default. The splitting is not NUMA-aware and may
generate non-optimal splits at that level, when there are four or more
NUMA nodes. Doing this right at this level would require a proper
graph partitioning algorithm operating on the NUMA distance matrix.
Also, as mentioned before, not everyone needs the finer granularity.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c    |   1 +
 kernel/sched/cosched.c | 259 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |   2 +
 3 files changed, 262 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a235b6041cb5..cc801f84bf97 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5867,6 +5867,7 @@ int sched_cpu_dying(unsigned int cpu)
 void __init sched_init_smp(void)
 {
 	sched_init_numa();
+	cosched_init_topology();
 
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index 03ba86676b90..7a793aa93114 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -6,6 +6,8 @@
  * Author: Jan H. Schönherr <jschoenh@amazon.de>
  */
 
+#include <linux/moduleparam.h>
+
 #include "sched.h"
 
 static int mask_to_node(const struct cpumask *span)
@@ -92,3 +94,260 @@ void cosched_init_bottom(void)
 		init_sdrq(&root_task_group, sdrq, NULL, NULL, data);
 	}
 }
+
+static bool __read_mostly cosched_split_domains;
+
+static int __init cosched_split_domains_setup(char *str)
+{
+	cosched_split_domains = true;
+	return 0;
+}
+
+early_param("cosched_split_domains", cosched_split_domains_setup);
+
+struct sd_sdrqmask_level {
+	int groups;
+	struct cpumask **masks;
+};
+
+static struct sd_sdrqmask_level *sd_sdrqmasks;
+
+static const struct cpumask *
+sd_cpu_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return get_cpu_mask(cpu);
+}
+
+static const struct cpumask *
+sd_sdrqmask(struct sched_domain_topology_level *tl, int cpu)
+{
+	int i, nr = tl->level;
+
+	for (i = 0; i < sd_sdrqmasks[nr].groups; i++) {
+		if (cpumask_test_cpu(cpu, sd_sdrqmasks[nr].masks[i]))
+			return sd_sdrqmasks[nr].masks[i];
+	}
+
+	WARN(1, "CPU%d not in any group for level %d", cpu, nr);
+	return get_cpu_mask(cpu);
+}
+
+static int calc_agglomeration_factor(int upperweight, int lowerweight)
+{
+	int factor;
+
+	/* Only split domains if actually requested. */
+	if (!cosched_split_domains)
+		return 1;
+
+	/* Determine branching factor */
+	if (upperweight % lowerweight) {
+		pr_info("Non-homogeneous topology?! Not restructuring! (%d, %d)",
+			upperweight, lowerweight);
+		return 1;
+	}
+
+	factor = upperweight / lowerweight;
+	WARN_ON_ONCE(factor <= 0);
+
+	/* Determine number of lower groups to agglomerate */
+	if (factor <= 3)
+		return 1;
+	if (factor % 2 == 0)
+		return 2;
+	if (factor % 3 == 0)
+		return 3;
+
+	pr_info("Cannot find a suitable agglomeration. Not restructuring! (%d, %d)",
+		upperweight, lowerweight);
+	return 1;
+}
+
+/*
+ * Construct the needed masks for an intermediate level.
+ *
+ * There is the level above us, and the level below us.
+ *
+ * Both levels consist of disjoint groups, while the lower level contains
+ * multiple groups for each group of the higher level. The branching factor
+ * must be > 3, otherwise splitting is not useful.
+ *
+ * Thus, to facilitate a bottom up approach, that can later also add more
+ * than one level between two existing levels, we always group two (or
+ * three if possible) lower groups together, given that they are in
+ * the same upper group.
+ *
+ * To get deterministic results, we go through groups from left to right,
+ * ordered by their lowest numbered cpu.
+ *
+ * FIXME: This does not consider distances of NUMA nodes. They may end up
+ *        in non-optimal groups.
+ *
+ * FIXME: This only does the right thing for homogeneous topologies,
+ *        where additionally all CPUs are online.
+ */
+static int create_sdrqmask(struct sd_sdrqmask_level *current_level,
+			   struct sched_domain_topology_level *upper,
+			   struct sched_domain_topology_level *lower)
+{
+	int lowerweight, agg;
+	int i, g = 0;
+	const struct cpumask *next;
+	cpumask_var_t remaining_system, remaining_upper;
+
+	/* Determine number of lower groups to agglomerate */
+	lowerweight = cpumask_weight(lower->mask(lower, 0));
+	agg = calc_agglomeration_factor(cpumask_weight(upper->mask(upper, 0)),
+					lowerweight);
+	WARN_ON_ONCE(agg <= 1);
+
+	/* Determine number of agglomerated groups across the system */
+	current_level->groups = cpumask_weight(cpu_online_mask)
+				/ (agg * lowerweight);
+
+	/* Allocate memory for new masks and tmp vars */
+	current_level->masks = kcalloc(current_level->groups, sizeof(void *),
+				       GFP_KERNEL);
+	if (!current_level->masks)
+		return -ENOMEM;
+	if (!zalloc_cpumask_var(&remaining_system, GFP_KERNEL))
+		return -ENOMEM;
+	if (!zalloc_cpumask_var(&remaining_upper, GFP_KERNEL))
+		return -ENOMEM;
+
+	/* Go through groups in upper level, creating all agglomerated masks */
+	cpumask_copy(remaining_system, cpu_online_mask);
+
+	/* While there is an unprocessed upper group */
+	while (!cpumask_empty(remaining_system)) {
+		/* Get that group */
+		next = upper->mask(upper, cpumask_first(remaining_system));
+		cpumask_andnot(remaining_system, remaining_system, next);
+
+		cpumask_copy(remaining_upper, next);
+
+		/* While there are unprocessed lower groups */
+		while (!cpumask_empty(remaining_upper)) {
+			struct cpumask *mask = kzalloc(cpumask_size(),
+						       GFP_KERNEL);
+
+			if (!mask)
+				return -ENOMEM;
+
+			if (WARN_ON_ONCE(g == current_level->groups))
+				return -EINVAL;
+			current_level->masks[g] = mask;
+			g++;
+
+			/* Create agglomerated mask */
+			for (i = 0; i < agg; i++) {
+				WARN_ON_ONCE(cpumask_empty(remaining_upper));
+
+				next = lower->mask(lower, cpumask_first(remaining_upper));
+				cpumask_andnot(remaining_upper, remaining_upper, next);
+
+				cpumask_or(mask, mask, next);
+			}
+		}
+	}
+
+	if (WARN_ON_ONCE(g != current_level->groups))
+		return -EINVAL;
+
+	free_cpumask_var(remaining_system);
+	free_cpumask_var(remaining_upper);
+
+	return 0;
+}
+
+void cosched_init_topology(void)
+{
+	struct sched_domain_topology_level *sched_domain_topology = get_sched_topology();
+	struct sched_domain_topology_level *tl;
+	int i, agg, orig_level, levels = 0, extra_levels = 0;
+	int span, prev_span = 1;
+
+	/* Only one CPU in the system, we are finished here */
+	if (cpumask_weight(cpu_possible_mask) == 1)
+		return;
+
+	/* Determine number of additional levels */
+	for (tl = sched_domain_topology; tl->mask; tl++) {
+		/* Skip overlap levels, except for the last one */
+		if (tl->flags & SDTL_OVERLAP && tl[1].mask)
+			continue;
+
+		levels++;
+
+		/* FIXME: this assumes a homogeneous topology */
+		span = cpumask_weight(tl->mask(tl, 0));
+		for (;;) {
+			agg = calc_agglomeration_factor(span, prev_span);
+			if (agg <= 1)
+				break;
+			levels++;
+			extra_levels++;
+			prev_span *= agg;
+		}
+		prev_span = span;
+	}
+
+	/* Allocate memory for all levels plus terminators on both ends */
+	tl = kcalloc((levels + 2), sizeof(*tl), GFP_KERNEL);
+	sd_sdrqmasks = kcalloc(extra_levels, sizeof(*sd_sdrqmasks), GFP_KERNEL);
+	if (!tl || !sd_sdrqmasks)
+		return;
+
+	/* Fill in start terminator and forget about it */
+	tl->mask = sd_cpu_mask;
+	tl++;
+
+	/* Copy existing levels and add new ones */
+	prev_span = 1;
+	orig_level = 0;
+	extra_levels = 0;
+	for (i = 0; i < levels; i++) {
+		BUG_ON(!sched_domain_topology[orig_level].mask);
+
+		/* Skip overlap levels, except for the last one */
+		while (sched_domain_topology[orig_level].flags & SDTL_OVERLAP &&
+		       sched_domain_topology[orig_level + 1].mask) {
+			orig_level++;
+		}
+
+		/* Copy existing */
+		tl[i] = sched_domain_topology[orig_level];
+
+		/* Check if we must add a level */
+		/* FIXME: this assumes a homogeneous topology */
+		span = cpumask_weight(tl[i].mask(&tl[i], 0));
+		agg = calc_agglomeration_factor(span, prev_span);
+		if (agg <= 1) {
+			orig_level++;
+			prev_span = span;
+			continue;
+		}
+
+		/*
+		 * For the new level, we take the same setting as the level
+		 * above us (the one we already copied). We just give it
+		 * different set of masks.
+		 */
+		if (create_sdrqmask(&sd_sdrqmasks[extra_levels],
+				    &sched_domain_topology[orig_level],
+				    &tl[i - 1]))
+			return;
+
+		tl[i].mask = sd_sdrqmask;
+		tl[i].level = extra_levels;
+		tl[i].flags &= ~SDTL_OVERLAP;
+		tl[i].simple_mask = NULL;
+
+		extra_levels++;
+		prev_span = cpumask_weight(tl[i].mask(&tl[i], 0));
+	}
+	BUG_ON(sched_domain_topology[orig_level].mask);
+
+	/* Make permanent */
+	set_sched_topology(tl);
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 21b7c6cf8b87..ed9c526b74ee 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1131,8 +1131,10 @@ static inline struct cfs_rq *taskgroup_next_cfsrq(struct task_group *tg,
 
 #ifdef CONFIG_COSCHEDULING
 void cosched_init_bottom(void);
+void cosched_init_topology(void);
 #else /* !CONFIG_COSCHEDULING */
 static inline void cosched_init_bottom(void) { }
+static inline void cosched_init_topology(void) { }
 #endif /* !CONFIG_COSCHEDULING */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.9.3.1.gcba166c.dirty

