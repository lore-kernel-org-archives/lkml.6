Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E82C6787F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A89721477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A89721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJMBaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeJMBaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:30:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F592C04BD2E;
        Fri, 12 Oct 2018 17:56:39 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94792831B3;
        Fri, 12 Oct 2018 17:56:37 +0000 (UTC)
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
Subject: [PATCH v13 08/11] cpuset: Make generate_sched_domains() work with partition
Date:   Fri, 12 Oct 2018 13:55:48 -0400
Message-Id: <1539366951-8498-9-git-send-email-longman@redhat.com>
In-Reply-To: <1539366951-8498-1-git-send-email-longman@redhat.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Oct 2018 17:56:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generate_sched_domains() function is modified to make it work
correctly with the newly introduced subparts_cpus mask for scheduling
domains generation.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 578e6ae..c52074e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -763,13 +763,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	int ndoms = 0;		/* number of sched domains in result */
 	int nslot;		/* next empty doms[] struct cpumask slot */
 	struct cgroup_subsys_state *pos_css;
+	bool root_load_balance = is_sched_load_balance(&top_cpuset);
 
 	doms = NULL;
 	dattr = NULL;
 	csa = NULL;
 
 	/* Special case for the 99% of systems with one, full, sched domain */
-	if (is_sched_load_balance(&top_cpuset)) {
+	if (root_load_balance && !top_cpuset.nr_subparts_cpus) {
 		ndoms = 1;
 		doms = alloc_sched_domains(ndoms);
 		if (!doms)
@@ -792,6 +793,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	csn = 0;
 
 	rcu_read_lock();
+	if (root_load_balance)
+		csa[csn++] = &top_cpuset;
 	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
 		if (cp == &top_cpuset)
 			continue;
@@ -802,6 +805,9 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		 * parent's cpus, so just skip them, and then we call
 		 * update_domain_attr_tree() to calc relax_domain_level of
 		 * the corresponding sched domain.
+		 *
+		 * If root is load-balancing, we can skip @cp if it
+		 * is a subset of the root's effective_cpus.
 		 */
 		if (!cpumask_empty(cp->cpus_allowed) &&
 		    !(is_sched_load_balance(cp) &&
@@ -809,11 +815,16 @@ static int generate_sched_domains(cpumask_var_t **domains,
 					 housekeeping_cpumask(HK_FLAG_DOMAIN))))
 			continue;
 
+		if (root_load_balance &&
+		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
+			continue;
+
 		if (is_sched_load_balance(cp))
 			csa[csn++] = cp;
 
-		/* skip @cp's subtree */
-		pos_css = css_rightmost_descendant(pos_css);
+		/* skip @cp's subtree if not a partition root */
+		if (!is_partition_root(cp))
+			pos_css = css_rightmost_descendant(pos_css);
 	}
 	rcu_read_unlock();
 
@@ -941,7 +952,12 @@ static void rebuild_sched_domains_locked(void)
 	 * passing doms with offlined cpu to partition_sched_domains().
 	 * Anyways, hotplug work item will rebuild sched domains.
 	 */
-	if (!cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
+	if (!top_cpuset.nr_subparts_cpus &&
+	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
+		goto out;
+
+	if (top_cpuset.nr_subparts_cpus &&
+	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
 		goto out;
 
 	/* Generate domain masks and attrs */
@@ -1356,11 +1372,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		update_tasks_cpumask(cp);
 
 		/*
-		 * If the effective cpumask of any non-empty cpuset is changed,
-		 * we need to rebuild sched domains.
+		 * On legacy hierarchy, if the effective cpumask of any non-
+		 * empty cpuset is changed, we need to rebuild sched domains.
+		 * On default hierarchy, the cpuset needs to be a partition
+		 * root as well.
 		 */
 		if (!cpumask_empty(cp->cpus_allowed) &&
-		    is_sched_load_balance(cp))
+		    is_sched_load_balance(cp) &&
+		   (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+		    is_partition_root(cp)))
 			need_rebuild_sched_domains = true;
 
 		rcu_read_lock();
-- 
1.8.3.1

