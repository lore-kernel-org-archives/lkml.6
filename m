Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D83C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB689208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB689208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeH0S2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:28:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727725AbeH0S2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C3A840776D5;
        Mon, 27 Aug 2018 14:41:42 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E2D52027EA0;
        Mon, 27 Aug 2018 14:41:42 +0000 (UTC)
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
Subject: [PATCH v12 9/9] cpuset: Support forced turning off of partition flag
Date:   Mon, 27 Aug 2018 10:41:24 -0400
Message-Id: <1535380884-31308-10-git-send-email-longman@redhat.com>
In-Reply-To: <1535380884-31308-1-git-send-email-longman@redhat.com>
References: <1535380884-31308-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 14:41:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 14:41:42 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpuset allows arbitrary modification of cpu list in "cpuset.cpus"
even if the requested CPUs won't be granted in "cpuset.cpus.effective"
as restricted by its parent. However, the validate_change() function
will inhibit removal of CPUs that have been used in child cpusets.

Being a partition root, however, limits the kind of cpu list
modification that is allowed. Adding CPUs is not allowed if the new
CPUs are not in the parent's effective cpu list that can be put into
"cpuset.cpus.reserved". In addition, a child partition cannot exhaust
all the parent's effective CPUs.

Because of the implicit cpu exclusive nature of the partition root,
cpu changes that break that cpu exclusivity will not be allowed. Other
changes that break the conditions of being a partition root is generally
allowed. However, the partition flag of the cpuset as well those of
the descendant partitions will be forcefully turned off.

Removing CPUs from a partition root is generally allowed as long as
there is at least one CPU left with no conflicts with child cpusets,
if present. If all the CPUs are removed, the partition flag will be
forced off as well.

The partition flag clearing code is being extracted out from
update_reserved_cpumask() into a new clear_partition_flag() function
so that the new code can be called recursively in the case of forced
turning off with minimal stack footprint.

Sched domains have to be rebuilt whenever a forced turning off of the
partition flag happens.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  45 +++++++----
 kernel/cgroup/cpuset.c                  | 136 +++++++++++++++++++++++++++-----
 2 files changed, 144 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 655e54e..1f63ccf 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1695,27 +1695,40 @@ Cpuset Interface Files
 	Setting this flag will take the CPUs away from the effective
 	CPUs of the parent cgroup.  That is why this flag has to be set
 	and owned by the parent.  Once it is set, this flag cannot be
-	cleared if there are any child cgroups with cpuset enabled.
+	explicitly cleared if there are any child cgroups with cpuset
+	enabled.
 
 	A parent partition root cgroup cannot distribute all its CPUs to
         its child partition root cgroups.  There must be at least one cpu
         left in the parent partition root cgroup.
 
-	In a partition root, changes to "cpuset.cpus" is allowed as long
-	as the first condition above as well as the following two
-	additional conditions are true.
-
-	1) Any added CPUs must be a proper subset of the parent's
-	   "cpuset.cpus.effective".
-	2) No CPU that has been distributed to child partition roots is
-	   is deleted.
-
-	When all the CPUs allocated to a partition are offlined, the
-	partition will be temporaily gone and all the tasks in it will
-	be migrated to another one that belongs to the parent of the
-	partition root.  This is a destructive operation and all the
-	existing CPU affinity that is narrower than the cpuset itself
-	will be lost.
+	In a partition root, removing CPUs from "cpuset.cpus" is allowed
+	as long as none of the removed CPUs are used by any of the
+	child cpusets, if defined.  However, if the CPU removal cause
+	its effective CPU list to become empty, the kernel will have
+	no choice but to forcefully turn off the partition flag of the
+	current cpuset as well as any descendant partitions underneath it.
+	This is a destructive operation and the partition states will
+	not be restored even when the CPUs are added back later on.
+
+	Adding CPUs to "cpuset.cpus" of a partition root is generally
+	allowed.  Because of the cpu exclusivity nature of a partition
+	root, CPU changes that break the cpu exclusivity will not be
+	permitted.  For other CPU changes that break either one of the
+	first three conditions of being a partition root listed above,
+	it will cause the same forced turning off of the partition flag
+	as discussed before.
+
+	The act of forcefully clearing the partition flag by making
+	changes to "cpuset.cpus" is generally not recommended.	A warning
+	message will be printed when that happens.
+
+	CPU offlining is handled differently as it won't cause a forced
+	turning off the partition flag. When all the CPUs allocated to
+	a partition are offlined, the partition will be temporaily gone
+	and all the tasks in it will be migrated to the parent partition.
+	This is a destructive operation and all the existing CPU affinity
+	that is narrower than the cpuset itself will be lost.
 
 	When any of those offlined CPUs is onlined again, a new partition
 	will be re-created and the tasks will be migrated back.
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d8970b4..5f2e942 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -313,6 +313,11 @@ static inline int is_spread_slab(const struct cpuset *cs)
 static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
 
 /*
+ * Sched domains need to be rebuilt after forced off of partition flag.
+ */
+static bool force_rebuild_sched_domains;
+
+/*
  * Cgroup v2 behavior is used when on default hierarchy or the
  * cgroup_v2_mode flag is set.
  */
@@ -1002,8 +1007,77 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
 	}
 	rcu_read_unlock();
 
-	if (need_rebuild_sched_domains)
+	if (need_rebuild_sched_domains || force_rebuild_sched_domains) {
 		rebuild_sched_domains_locked();
+		force_rebuild_sched_domains = false;
+	}
+}
+
+/**
+ * clear_partition_flag - Clear the partition flag of cpuset
+ * @cpuset: The cpuset to be cleared
+ * @forced: The forced turning off flag
+ * Return: 0 if successful, an error code otherwise
+ *
+ * Handles the turning off the sched.partition flag either when explicitly
+ * cleared by user or implicitly turned off by removing CPUs.
+ *
+ * Setting of partition flag is handled by update_reserved_cpumask().
+ * Called with cpuset_mutex held.
+ */
+static int clear_partition_flag(struct cpuset *cpuset, bool forced)
+{
+	struct cpuset *parent = parent_cs(cpuset);
+
+	WARN_ON_ONCE(!is_partition_root(cpuset));
+
+	/*
+	 * Normal partition flag clearing isn't allowed if sub-partition
+	 * is present.
+	 */
+	if (!forced && cpuset->nr_reserved)
+		return -EBUSY;
+
+	if (forced && cpuset->nr_reserved) {
+		struct cpuset *child;
+		struct cgroup_subsys_state *pos_css;
+
+		/*
+		 * Recursively call clear_partition_flag() if necessary.
+		 */
+		rcu_read_lock();
+		cpuset_for_each_child(child, pos_css, cpuset) {
+			if (is_partition_root(child))
+				clear_partition_flag(child, true);
+		}
+		rcu_read_unlock();
+		WARN_ON_ONCE(cpuset->nr_reserved);
+	}
+
+	if (forced) {
+		/* Forced clearing isn't recommended */
+		pr_warn("cpuset: sched.partition flag of ");
+		pr_cont_cgroup_name(cpuset->css.cgroup);
+		pr_cont(" is turned off!\n");
+		clear_bit(CS_PARTITION_ROOT, &cpuset->flags);
+		clear_bit(CS_CPU_EXCLUSIVE, &cpuset->flags);
+		force_rebuild_sched_domains = true;
+	}
+
+	/*
+	 * Remove cpus_allowed of current cpuset from parent's reserved_cpus.
+	 */
+	spin_lock_irq(&callback_lock);
+	cpumask_andnot(parent->reserved_cpus,
+		       parent->reserved_cpus, cpuset->cpus_allowed);
+	cpumask_or(parent->effective_cpus,
+		   parent->effective_cpus, cpuset->effective_cpus);
+	parent->nr_reserved = cpumask_weight(parent->reserved_cpus);
+	spin_unlock_irq(&callback_lock);
+
+	if (!parent->nr_reserved)
+		free_cpumask_var(parent->reserved_cpus);
+	return 0;
 }
 
 /**
@@ -1019,15 +1093,17 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
  * if preset.
  *
  * Adding CPUs to "cpuset.cpus" is generally allowed. However, if the
- * addition causes the cpuset to exceed the capability offered by its
- * parent, that addition will not be allowed.
+ * addition or removal causes the cpuset to exceed the capability offered
+ * by its parent or its constraint of being a partition root, the cpu
+ * list change will cause a forced turning-off of the partition flag.
  *
  * Because of the implicit cpu exclusive nature of a partition root,
- * cpumask changes tht violates the cpu exclusivity rule will not be
- * permitted.
+ * cpumask changes that violates the cpu exclusivity rule will not be
+ * permitted. One will have to turn off the partition flag before
+ * making the CPU changes.
  *
- * If the sched.partition flag changes, either the oldmask (0=>1) or the
- * newmask (1=>0) will be NULL.
+ * If the sched.partition flag is being set, the oldmask will be NULL.
+ * The newmask will never be NULL.
  *
  * Called with cpuset_mutex held.
  */
@@ -1042,17 +1118,25 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 
 	/*
 	 * The parent must be a partition root.
-	 * The new cpumask, if present, must not be empty.
 	 */
-	if (!is_partition_root(parent) ||
-	   (newmask && cpumask_empty(newmask)))
+	if (!is_partition_root(parent))
 		return -EINVAL;
 
 	/*
-	 * A sched.partition state change is not allowed if there are
+	 * If the newmask is empty or it is the same as the reserved_cpus,
+	 * we will have to turn off the partition flag.
+	 */
+	if (cpumask_empty(newmask) || (cpuset->nr_reserved &&
+	    cpumask_equal(newmask, cpuset->reserved_cpus))) {
+		clear_partition_flag(cpuset, true);
+		return 0;
+	}
+
+	/*
+	 * Turning on sched.partition is not allowed if there are
 	 * online children.
 	 */
-	if ((!oldmask || !newmask) && css_has_online_children(&cpuset->css))
+	if (!oldmask && css_has_online_children(&cpuset->css))
 		return -EBUSY;
 
 	if (!zalloc_cpumask_var(&addmask, GFP_KERNEL))
@@ -1076,30 +1160,40 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 	 * addmask = newmask & ~oldmask
 	 * delmask = oldmask & ~newmask
 	 */
-	if (oldmask && newmask) {
+	if (oldmask) {
 		adding   = cpumask_andnot(addmask, newmask, oldmask);
 		deleting = cpumask_andnot(delmask, oldmask, newmask);
 		if (!adding && !deleting)
 			goto out_ok;
-	} else if (newmask) {
+	} else {
 		adding = true;
 		cpumask_copy(addmask, newmask);
-	} else if (oldmask) {
-		deleting = true;
-		cpumask_copy(delmask, oldmask);
 	}
 
 	/*
-	 * The cpus to be added must be a proper subset of the parent's
+	 * The cpus to be added should be a proper subset of the parent's
 	 * effective_cpus mask but not in the reserved_cpus mask.
 	 */
 	if (adding) {
+		bool error = false;
+
 		if (!cpumask_subset(addmask, parent->effective_cpus) ||
 		     cpumask_equal(addmask, parent->effective_cpus))
-			goto out;
+			error = true;
 		if (parent->nr_reserved &&
 		    cpumask_intersects(parent->reserved_cpus, addmask))
-			goto out;
+			error = true;
+		/*
+		 * Error condition isn't allowed when turning on the flag.
+		 * An error condition when changing cpu list will cause
+		 * a forced turning-off of the partition flag.
+		 */
+		if (error) {
+			if (!oldmask)
+				goto out;
+			clear_partition_flag(cpuset, true);
+			return 0;
+		}
 	}
 
 	/*
@@ -1551,7 +1645,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	if (partition_flag_changed) {
 		err = turning_on
 		    ? update_reserved_cpumask(cs, NULL, cs->cpus_allowed)
-		    : update_reserved_cpumask(cs, cs->cpus_allowed, NULL);
+		    : clear_partition_flag(cs, false);
 		if (err < 0)
 			goto out;
 		/*
-- 
1.8.3.1

