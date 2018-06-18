Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80DEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2C020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2C020864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbeFREPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:15:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754455AbeFREPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:15:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A528401C7E9;
        Mon, 18 Jun 2018 04:15:06 +0000 (UTC)
Received: from llong.com (ovpn-121-11.rdu2.redhat.com [10.10.121.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B109201E288;
        Mon, 18 Jun 2018 04:15:01 +0000 (UTC)
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
Subject: [PATCH v10 5/9] cpuset: Make sure that domain roots work properly with CPU hotplug
Date:   Mon, 18 Jun 2018 12:14:04 +0800
Message-Id: <1529295249-5207-6-git-send-email-longman@redhat.com>
In-Reply-To: <1529295249-5207-1-git-send-email-longman@redhat.com>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 18 Jun 2018 04:15:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 18 Jun 2018 04:15:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a cpu hotplug event (CPU online or offline), the scheduling
domains needed to be reconfigured and regenerated. So code is added to
the hotplug functions to make them work with new reserved_cpus mask to
compute the right effective_cpus for each of the affected cpusets.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
 kernel/cgroup/cpuset.c                  | 26 ++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5ee5e77..6ef3516 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1626,6 +1626,13 @@ Cpuset Interface Files
 	2) No CPU that has been distributed to child scheduling domain
 	   roots is deleted.
 
+	When all the CPUs allocated to a scheduling domain are offlined,
+	that scheduling domain will be temporaily gone and all the
+	tasks in that scheduling domain will migrate to another one that
+	belongs to the parent of the scheduling domain root.  When any
+	of those offlined CPUs is onlined again, a new scheduling domain
+	will be re-created and the tasks will be migrated back.
+
 
 Device controller
 -----------------
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b1abe3d..26ac083 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -900,7 +900,8 @@ static void update_tasks_cpumask(struct cpuset *cs)
  * @parent: the parent cpuset
  *
  * If the parent has reserved CPUs, include them in the list of allowable
- * CPUs in computing the new effective_cpus mask.
+ * CPUs in computing the new effective_cpus mask. The cpu_active_mask is
+ * used to mask off cpus that are to be offlined.
  */
 static void compute_effective_cpumask(struct cpumask *new_cpus,
 				      struct cpuset *cs, struct cpuset *parent)
@@ -909,6 +910,7 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
 		cpumask_or(new_cpus, parent->effective_cpus,
 			   parent->reserved_cpus);
 		cpumask_and(new_cpus, new_cpus, cs->cpus_allowed);
+		cpumask_and(new_cpus, new_cpus, cpu_active_mask);
 	} else {
 		cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
 	}
@@ -2571,9 +2573,17 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs)
 		goto retry;
 	}
 
-	cpumask_and(&new_cpus, cs->cpus_allowed, parent_cs(cs)->effective_cpus);
+	compute_effective_cpumask(&new_cpus, cs, parent_cs(cs));
 	nodes_and(new_mems, cs->mems_allowed, parent_cs(cs)->effective_mems);
 
+	if (cs->nr_reserved) {
+		/*
+		 * Some of the CPUs may have been distributed to child
+		 * domain roots. So we need skip those when computing the
+		 * real effective cpus.
+		 */
+		cpumask_andnot(&new_cpus, &new_cpus, cs->reserved_cpus);
+	}
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
 	mems_updated = !nodes_equal(new_mems, cs->effective_mems);
 
@@ -2623,6 +2633,11 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	cpumask_copy(&new_cpus, cpu_active_mask);
 	new_mems = node_states[N_MEMORY];
 
+	/*
+	 * If reserved_cpus is populated, it is likely that the check below
+	 * will produce a false positive on cpus_updated when the cpu list
+	 * isn't changed. It is extra work, but it is better to be safe.
+	 */
 	cpus_updated = !cpumask_equal(top_cpuset.effective_cpus, &new_cpus);
 	mems_updated = !nodes_equal(top_cpuset.effective_mems, new_mems);
 
@@ -2631,6 +2646,13 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
+		/*
+		 * Make sure that the reserved cpus aren't in the
+		 * effective cpus.
+		 */
+		if (top_cpuset.nr_reserved)
+			cpumask_andnot(&new_cpus, &new_cpus,
+					top_cpuset.reserved_cpus);
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
 		spin_unlock_irq(&callback_lock);
 		/* we don't mess with cpumasks of tasks in top_cpuset */
-- 
1.8.3.1

