Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2552C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FEE2148C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FEE2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJMB35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbeJMB35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:29:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5391880F8D;
        Fri, 12 Oct 2018 17:56:18 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74F2082779;
        Fri, 12 Oct 2018 17:56:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v13 02/11] cpuset: Define data structures to support scheduling partition
Date:   Fri, 12 Oct 2018 13:55:42 -0400
Message-Id: <1539366951-8498-3-git-send-email-longman@redhat.com>
In-Reply-To: <1539366951-8498-1-git-send-email-longman@redhat.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 12 Oct 2018 17:56:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From a cpuset point of view, a scheduling partition is a group of
cpusets with their own set of exclusive CPUs that are not shared by
other tasks outside the scheduling partition.

In the legacy hierarchy, scheduling partitions are supported indirectly
via the right use of the load balancing and the exclusive CPUs flag
which is not intuitive and can be hard to use.

To fully support the concept of scheduling partitions in the default
hierarchy, we need to add some new field into the cpuset structure as
well as a new tmpmasks structure that is used to pre-allocate cpumasks
at the top level cpuset functions to avoid memory allocation in inner
functions as memory allocation failure in those inner functions may
cause a cpuset to have inconsistent states.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2b5c447..29a2bdc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -110,6 +110,13 @@ struct cpuset {
 	nodemask_t effective_mems;
 
 	/*
+	 * CPUs allocated to child sub-partitions (default hierarchy only)
+	 * - CPUs granted by the parent = effective_cpus U subparts_cpus
+	 * - effective_cpus and subparts_cpus are mutually exclusive.
+	 */
+	cpumask_var_t subparts_cpus;
+
+	/*
 	 * This is old Memory Nodes tasks took on.
 	 *
 	 * - top_cpuset.old_mems_allowed is initialized to mems_allowed.
@@ -134,6 +141,30 @@ struct cpuset {
 
 	/* for custom sched domain */
 	int relax_domain_level;
+
+	/* number of CPUs in subparts_cpus */
+	int nr_subparts_cpus;
+
+	/* partition root state */
+	int partition_root_state;
+};
+
+/*
+ * Partition root states:
+ *
+ *   0 - not a partition root
+ *   1 - partition root
+ */
+#define PRS_DISABLED		0
+#define PRS_ENABLED		1
+
+/*
+ * Temporary cpumasks for working with partitions that are passed among
+ * functions to avoid memory allocation in inner functions.
+ */
+struct tmpmasks {
+	cpumask_var_t addmask, delmask;	/* For partition root */
+	cpumask_var_t new_cpus;		/* For update_cpumasks_hier() */
 };
 
 static inline struct cpuset *css_cs(struct cgroup_subsys_state *css)
@@ -218,9 +249,15 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+static inline int is_partition_root(const struct cpuset *cs)
+{
+	return cs->partition_root_state;
+}
+
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
+	.partition_root_state = PRS_ENABLED,
 };
 
 /**
-- 
1.8.3.1

