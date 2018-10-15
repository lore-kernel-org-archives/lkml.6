Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE965C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7786E208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7786E208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJPERd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeJPERc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:17:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 657903001AC1;
        Mon, 15 Oct 2018 20:30:41 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6EBA768A1;
        Mon, 15 Oct 2018 20:30:39 +0000 (UTC)
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
Subject: [PATCH v14 07/12] cpuset: Make CPU hotplug work with partition
Date:   Mon, 15 Oct 2018 16:29:32 -0400
Message-Id: <1539635377-22335-8-git-send-email-longman@redhat.com>
In-Reply-To: <1539635377-22335-1-git-send-email-longman@redhat.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 15 Oct 2018 20:30:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a cpu hotplug event (CPU online or offline), the partitions
may need to be reconfigured and regenerated. So code is added to the
hotplug functions to make them work with new subparts_cpus mask to
compute the right effective_cpus for each of the affected cpusets.
It may also change the state of a partition root from real one to an
erroneous one or vice versa.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 131 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 116 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 596e0b16fb96..2e9fab21ea57 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -113,6 +113,9 @@ struct cpuset {
 	 * CPUs allocated to child sub-partitions (default hierarchy only)
 	 * - CPUs granted by the parent = effective_cpus U subparts_cpus
 	 * - effective_cpus and subparts_cpus are mutually exclusive.
+	 *
+	 * effective_cpus contains only onlined CPUs, but subparts_cpus
+	 * may have offlined ones.
 	 */
 	cpumask_var_t subparts_cpus;
 
@@ -994,7 +997,9 @@ static void update_tasks_cpumask(struct cpuset *cs)
  * @parent: the parent cpuset
  *
  * If the parent has subpartition CPUs, include them in the list of
- * allowable CPUs in computing the new effective_cpus mask.
+ * allowable CPUs in computing the new effective_cpus mask. Since offlined
+ * CPUs are not removed from subparts_cpus, we have to use cpu_active_mask
+ * to mask those out.
  */
 static void compute_effective_cpumask(struct cpumask *new_cpus,
 				      struct cpuset *cs, struct cpuset *parent)
@@ -1003,6 +1008,7 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
 		cpumask_or(new_cpus, parent->effective_cpus,
 			   parent->subparts_cpus);
 		cpumask_and(new_cpus, new_cpus, cs->cpus_allowed);
+		cpumask_and(new_cpus, new_cpus, cpu_active_mask);
 	} else {
 		cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
 	}
@@ -1125,9 +1131,20 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		/*
 		 * Return error if the new effective_cpus could become empty.
 		 */
-		if (adding && !deleting &&
-		    cpumask_equal(parent->effective_cpus, tmp->addmask))
-			return -EINVAL;
+		if (adding &&
+		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
+			if (!deleting)
+				return -EINVAL;
+			/*
+			 * As some of the CPUs in subparts_cpus might have
+			 * been offlined, we need to compute the real delmask
+			 * to confirm that.
+			 */
+			if (!cpumask_and(tmp->addmask, tmp->delmask,
+					 cpu_active_mask))
+				return -EINVAL;
+			cpumask_copy(tmp->addmask, parent->effective_cpus);
+		}
 	} else {
 		/*
 		 * partcmd_update w/o newmask:
@@ -1197,6 +1214,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	if (deleting) {
 		cpumask_andnot(parent->subparts_cpus,
 			       parent->subparts_cpus, tmp->delmask);
+		/*
+		 * Some of the CPUs in subparts_cpus might have been offlined.
+		 */
+		cpumask_and(tmp->delmask, tmp->delmask, cpu_active_mask);
 		cpumask_or(parent->effective_cpus,
 			   parent->effective_cpus, tmp->delmask);
 	}
@@ -2858,20 +2879,29 @@ hotplug_update_tasks(struct cpuset *cs,
 		update_tasks_nodemask(cs);
 }
 
+static bool force_rebuild;
+
+void cpuset_force_rebuild(void)
+{
+	force_rebuild = true;
+}
+
 /**
  * cpuset_hotplug_update_tasks - update tasks in a cpuset for hotunplug
  * @cs: cpuset in interest
+ * @tmp: the tmpmasks structure pointer
  *
  * Compare @cs's cpu and mem masks against top_cpuset and if some have gone
  * offline, update @cs accordingly.  If @cs ends up with no CPU or memory,
  * all its tasks are moved to the nearest ancestor with both resources.
  */
-static void cpuset_hotplug_update_tasks(struct cpuset *cs)
+static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 {
 	static cpumask_t new_cpus;
 	static nodemask_t new_mems;
 	bool cpus_updated;
 	bool mems_updated;
+	struct cpuset *parent;
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
 
@@ -2886,9 +2916,60 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs)
 		goto retry;
 	}
 
-	cpumask_and(&new_cpus, cs->cpus_allowed, parent_cs(cs)->effective_cpus);
-	nodes_and(new_mems, cs->mems_allowed, parent_cs(cs)->effective_mems);
+	parent =  parent_cs(cs);
+	compute_effective_cpumask(&new_cpus, cs, parent);
+	nodes_and(new_mems, cs->mems_allowed, parent->effective_mems);
+
+	if (cs->nr_subparts_cpus)
+		/*
+		 * Make sure that CPUs allocated to child partitions
+		 * do not show up in effective_cpus.
+		 */
+		cpumask_andnot(&new_cpus, &new_cpus, cs->subparts_cpus);
+
+	if (!tmp || !cs->partition_root_state)
+		goto update_tasks;
+
+	/*
+	 * In the unlikely event that a partition root has empty
+	 * effective_cpus or its parent becomes erroneous, we have to
+	 * transition it to the erroneous state.
+	 */
+	if (is_partition_root(cs) && (cpumask_empty(&new_cpus) ||
+	   (parent->partition_root_state == PRS_ERROR))) {
+		if (cs->nr_subparts_cpus) {
+			cs->nr_subparts_cpus = 0;
+			cpumask_clear(cs->subparts_cpus);
+			compute_effective_cpumask(&new_cpus, cs, parent);
+		}
 
+		/*
+		 * If the effective_cpus is empty because the child
+		 * partitions take away all the CPUs, we can keep
+		 * the current partition and let the child partitions
+		 * fight for available CPUs.
+		 */
+		if ((parent->partition_root_state == PRS_ERROR) ||
+		     cpumask_empty(&new_cpus)) {
+			update_parent_subparts_cpumask(cs, partcmd_disable,
+						       NULL, tmp);
+			cs->partition_root_state = PRS_ERROR;
+		}
+		cpuset_force_rebuild();
+	}
+
+	/*
+	 * On the other hand, an erroneous partition root may be transitioned
+	 * back to a regular one or a partition root with no CPU allocated
+	 * from the parent may change to erroneous.
+	 */
+	if (is_partition_root(parent) &&
+	   ((cs->partition_root_state == PRS_ERROR) ||
+	    !cpumask_intersects(&new_cpus, parent->subparts_cpus)) &&
+	     update_parent_subparts_cpumask(cs, partcmd_update, NULL, tmp))
+		cpuset_force_rebuild();
+
+update_tasks:
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
 	mems_updated = !nodes_equal(new_mems, cs->effective_mems);
 
@@ -2902,13 +2983,6 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs)
 	mutex_unlock(&cpuset_mutex);
 }
 
-static bool force_rebuild;
-
-void cpuset_force_rebuild(void)
-{
-	force_rebuild = true;
-}
-
 /**
  * cpuset_hotplug_workfn - handle CPU/memory hotunplug for a cpuset
  *
@@ -2931,6 +3005,10 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	static nodemask_t new_mems;
 	bool cpus_updated, mems_updated;
 	bool on_dfl = is_in_v2_mode();
+	struct tmpmasks tmp, *ptmp = NULL;
+
+	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
+		ptmp = &tmp;
 
 	mutex_lock(&cpuset_mutex);
 
@@ -2938,6 +3016,11 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	cpumask_copy(&new_cpus, cpu_active_mask);
 	new_mems = node_states[N_MEMORY];
 
+	/*
+	 * If subparts_cpus is populated, it is likely that the check below
+	 * will produce a false positive on cpus_updated when the cpu list
+	 * isn't changed. It is extra work, but it is better to be safe.
+	 */
 	cpus_updated = !cpumask_equal(top_cpuset.effective_cpus, &new_cpus);
 	mems_updated = !nodes_equal(top_cpuset.effective_mems, new_mems);
 
@@ -2946,6 +3029,22 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
+		/*
+		 * Make sure that CPUs allocated to child partitions
+		 * do not show up in effective_cpus. If no CPU is left,
+		 * we clear the subparts_cpus & let the child partitions
+		 * fight for the CPUs again.
+		 */
+		if (top_cpuset.nr_subparts_cpus) {
+			if (cpumask_subset(&new_cpus,
+					   top_cpuset.subparts_cpus)) {
+				top_cpuset.nr_subparts_cpus = 0;
+				cpumask_clear(top_cpuset.subparts_cpus);
+			} else {
+				cpumask_andnot(&new_cpus, &new_cpus,
+					       top_cpuset.subparts_cpus);
+			}
+		}
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
 		spin_unlock_irq(&callback_lock);
 		/* we don't mess with cpumasks of tasks in top_cpuset */
@@ -2974,7 +3073,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 				continue;
 			rcu_read_unlock();
 
-			cpuset_hotplug_update_tasks(cs);
+			cpuset_hotplug_update_tasks(cs, ptmp);
 
 			rcu_read_lock();
 			css_put(&cs->css);
@@ -2987,6 +3086,8 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		force_rebuild = false;
 		rebuild_sched_domains();
 	}
+
+	free_cpumasks(NULL, ptmp);
 }
 
 void cpuset_update_active_cpus(void)
-- 
2.18.0

