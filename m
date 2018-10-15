Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E9C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5B9208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5B9208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJPERa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:17:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeJPERa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:17:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97EC15F72C;
        Mon, 15 Oct 2018 20:30:39 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B55E3768B1;
        Mon, 15 Oct 2018 20:30:31 +0000 (UTC)
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
        Tom Hromatka <tom.hromatka@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v14 06/12] cpuset: Track cpusets that use parent's effective_cpus
Date:   Mon, 15 Oct 2018 16:29:31 -0400
Message-Id: <1539635377-22335-7-git-send-email-longman@redhat.com>
In-Reply-To: <1539635377-22335-1-git-send-email-longman@redhat.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 15 Oct 2018 20:30:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the default hierarchy, a cpuset will use the parent's effective_cpus
if none of the requested CPUs can be granted from the parent. That can
be a problem if a parent is a partition root with children partition
roots. Changes to a parent's effective_cpus list due to changes in a
child partition root may not be properly reflected in a child cpuset
that use parent's effective_cpus because the cpu_exclusive rule of a
partition root will not guard against that.

In order to avoid the mismatch, two new tracking variables are added to
the cpuset structure to track if a cpuset uses parent's effective_cpus
and the number of children cpusets that use its effective_cpus. So
whenever cpumask changes are made to a parent, it will also check to
see if it has other children cpusets that use its effective_cpus and
call update_cpumasks_hier() if that is the case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 71 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a1f6fdb6be02..596e0b16fb96 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -147,6 +147,14 @@ struct cpuset {
 
 	/* partition root state */
 	int partition_root_state;
+
+	/*
+	 * Default hierarchy only:
+	 * use_parent_ecpus - set if using parent's effective_cpus
+	 * child_ecpus_count - # of children with use_parent_ecpus set
+	 */
+	int use_parent_ecpus;
+	int child_ecpus_count;
 };
 
 /*
@@ -1227,8 +1235,17 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		 * If it becomes empty, inherit the effective mask of the
 		 * parent, which is guaranteed to have some CPUs.
 		 */
-		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus))
+		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus)) {
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
+			if (!cp->use_parent_ecpus) {
+				cp->use_parent_ecpus = true;
+				parent->child_ecpus_count++;
+			}
+		} else if (cp->use_parent_ecpus) {
+			cp->use_parent_ecpus = false;
+			WARN_ON_ONCE(!parent->child_ecpus_count);
+			parent->child_ecpus_count--;
+		}
 
 		/*
 		 * Skip the whole subtree if the cpumask remains the same
@@ -1340,6 +1357,35 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		rebuild_sched_domains_locked();
 }
 
+/**
+ * update_sibling_cpumasks - Update siblings cpumasks
+ * @parent:  Parent cpuset
+ * @cs:      Current cpuset
+ * @tmp:     Temp variables
+ */
+static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
+				    struct tmpmasks *tmp)
+{
+	struct cpuset *sibling;
+	struct cgroup_subsys_state *pos_css;
+
+	/*
+	 * Check all its siblings and call update_cpumasks_hier()
+	 * if their use_parent_ecpus flag is set in order for them
+	 * to use the right effective_cpus value.
+	 */
+	rcu_read_lock();
+	cpuset_for_each_child(sibling, pos_css, parent) {
+		if (sibling == cs)
+			continue;
+		if (!sibling->use_parent_ecpus)
+			continue;
+
+		update_cpumasks_hier(sibling, tmp);
+	}
+	rcu_read_unlock();
+}
+
 /**
  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
  * @cs: the cpuset to consider
@@ -1415,6 +1461,17 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	spin_unlock_irq(&callback_lock);
 
 	update_cpumasks_hier(cs, &tmp);
+
+	if (cs->partition_root_state) {
+		struct cpuset *parent = parent_cs(cs);
+
+		/*
+		 * For partition root, update the cpumasks of sibling
+		 * cpusets if they use parent's effective_cpus.
+		 */
+		if (parent->child_ecpus_count)
+			update_sibling_cpumasks(parent, cs, &tmp);
+	}
 	return 0;
 }
 
@@ -1851,6 +1908,9 @@ static int update_prstate(struct cpuset *cs, int val)
 	if (parent != &top_cpuset)
 		update_tasks_cpumask(parent);
 
+	if (parent->child_ecpus_count)
+		update_sibling_cpumasks(parent, cs, &tmp);
+
 	rebuild_sched_domains_locked();
 out:
 	free_cpumasks(NULL, &tmp);
@@ -2545,6 +2605,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (is_in_v2_mode()) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
+		cs->use_parent_ecpus = true;
+		parent->child_ecpus_count++;
 	}
 	spin_unlock_irq(&callback_lock);
 
@@ -2608,6 +2670,13 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	    is_sched_load_balance(cs))
 		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
+	if (cs->use_parent_ecpus) {
+		struct cpuset *parent = parent_cs(cs);
+
+		cs->use_parent_ecpus = false;
+		parent->child_ecpus_count--;
+	}
+
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-- 
2.18.0

