Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E87C6787F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5938C2148C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5938C2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeJMBaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:30:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbeJMBaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:30:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 962F47F6C8;
        Fri, 12 Oct 2018 17:56:26 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D717A82F6E;
        Fri, 12 Oct 2018 17:56:21 +0000 (UTC)
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
Subject: [PATCH v13 05/11] cpuset: Add an error state to cpuset.sched.partition
Date:   Fri, 12 Oct 2018 13:55:45 -0400
Message-Id: <1539366951-8498-6-git-send-email-longman@redhat.com>
In-Reply-To: <1539366951-8498-1-git-send-email-longman@redhat.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 12 Oct 2018 17:56:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling error returned by update_parent_subparts_cpumask() in
update_cpumasks_hier() is problematic as the states may become
inconsistent. To avoid that and increase flexibility in handling other
error cases, a new error state (-1) is added to the partition_root_state
flag. This new error state is set internally and user cannot write this
value to "cpuset.sched.partition".

In this error state, the partition root becomes an erroneous one. It is
no longer a real partition root, but the CS_CPU_EXCLUSIVE flag will
still be set as it can be changed back to a real one if appropriate
change happens later on.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 146 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 123 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9c2e73c..12ec61d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -153,10 +153,19 @@ struct cpuset {
  * Partition root states:
  *
  *   0 - not a partition root
+ *
  *   1 - partition root
+ *
+ *  -1 - erroneous partition root
+ *       None of the cpus in cpus_allowed can be put into the parent's
+ *       subparts_cpus. In this case, the cpuset is not a real partition
+ *       root anymore.  However, the CPU_EXCLUSIVE bit will still be set
+ *       and the cpuset can be restored back to a partition root if the
+ *       parent cpuset can give more CPUs back to this child cpuset.
  */
 #define PRS_DISABLED		0
 #define PRS_ENABLED		1
+#define PRS_ERROR		-1
 
 /*
  * Temporary cpumasks for working with partitions that are passed among
@@ -251,7 +260,7 @@ static inline int is_spread_slab(const struct cpuset *cs)
 
 static inline int is_partition_root(const struct cpuset *cs)
 {
-	return cs->partition_root_state;
+	return cs->partition_root_state > 0;
 }
 
 static struct cpuset top_cpuset = {
@@ -1015,9 +1024,12 @@ enum subparts_cmd {
  *
  * For partcmd_update, if the optional newmask is specified, the cpu
  * list is to be changed from cpus_allowed to newmask. Otherwise,
- * cpus_allowed is assumed to remain the same.  The function will return
- * 1 if changes to parent's subparts_cpus and effective_cpus happen or 0
- * otherwise. In case of error, an error code will be returned.
+ * cpus_allowed is assumed to remain the same. The cpuset should either
+ * be a partition root or an erroneous partition root. The partition root
+ * state may change if newmask is NULL and none of the requested CPUs can
+ * be granted by the parent. The function will return 1 if changes to
+ * parent's subparts_cpus and effective_cpus happen or 0 otherwise.
+ * Error code should only be returned when newmask is non-NULL.
  *
  * The partcmd_enable and partcmd_disable commands are used by
  * update_prstate(). The partcmd_update command is used by
@@ -1042,6 +1054,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	struct cpuset *parent = parent_cs(cpuset);
 	int adding;	/* Moving cpus from effective_cpus to subparts_cpus */
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
+	bool part_error = false;	/* Partition error? */
 
 	/*
 	 * The parent must be a partition root.
@@ -1108,13 +1121,48 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		 * addmask = cpus_allowed & parent->effectiveb_cpus
 		 *
 		 * Note that parent's subparts_cpus may have been
-		 * pre-shrunk in case the CPUs granted to the parent
-		 * by the grandparent changes. So no deletion is needed.
+		 * pre-shrunk in case there is a change in the cpu list.
+		 * So no deletion is needed.
 		 */
 		adding = cpumask_and(tmp->addmask, cpuset->cpus_allowed,
 				     parent->effective_cpus);
-		if (cpumask_equal(tmp->addmask, parent->effective_cpus))
-			return -EINVAL;
+		part_error = cpumask_equal(tmp->addmask,
+					   parent->effective_cpus);
+	}
+
+	if (cmd == partcmd_update) {
+		int prev_prs = cpuset->partition_root_state;
+
+		/*
+		 * Check for possible transition between PRS_ENABLED
+		 * and PRS_ERROR.
+		 */
+		switch (cpuset->partition_root_state) {
+		case PRS_ENABLED:
+			if (part_error)
+				cpuset->partition_root_state = PRS_ERROR;
+			break;
+		case PRS_ERROR:
+			if (!part_error)
+				cpuset->partition_root_state = PRS_ENABLED;
+			break;
+		}
+		/*
+		 * Set part_error if previously in erroneous state.
+		 */
+		part_error = (prev_prs == PRS_ERROR);
+	}
+
+	if (!part_error && (cpuset->partition_root_state == PRS_ERROR))
+		return 0;	/* Nothing need to be done */
+
+	if (cpuset->partition_root_state == PRS_ERROR) {
+		/*
+		 * Remove all its cpus from parent's subparts_cpus.
+		 */
+		adding = false;
+		deleting = cpumask_and(tmp->delmask, cpuset->cpus_allowed,
+				       parent->subparts_cpus);
 	}
 
 	if (!adding && !deleting)
@@ -1166,28 +1214,21 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
 		struct cpuset *parent = parent_cs(cp);
-		bool cs_empty;
 
 		compute_effective_cpumask(tmp->new_cpus, cp, parent);
-		cs_empty = cpumask_empty(tmp->new_cpus);
-
-		/*
-		 * A partition root cannot have empty effective_cpus
-		 */
-		WARN_ON_ONCE(cs_empty && is_partition_root(cp));
 
 		/*
 		 * If it becomes empty, inherit the effective mask of the
 		 * parent, which is guaranteed to have some CPUs.
 		 */
-		if (is_in_v2_mode() && cs_empty)
+		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus))
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 
 		/*
 		 * Skip the whole subtree if the cpumask remains the same
 		 * and has no partition root state.
 		 */
-		if (!is_partition_root(cp) &&
+		if (!cp->partition_root_state &&
 		    cpumask_equal(tmp->new_cpus, cp->effective_cpus)) {
 			pos_css = css_rightmost_descendant(pos_css);
 			continue;
@@ -1199,11 +1240,39 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		 * update_tasks_cpumask() again for tasks in the parent
 		 * cpuset if the parent's subparts_cpus changes.
 		 */
-		if ((cp != cs) && cp->partition_root_state &&
-		    update_parent_subparts_cpumask(cp, partcmd_update,
-						   NULL, tmp)) {
-			if (parent != &top_cpuset)
-				update_tasks_cpumask(parent);
+		if ((cp != cs) && cp->partition_root_state) {
+			switch (parent->partition_root_state) {
+			case PRS_DISABLED:
+				/*
+				 * If parent is not a partition root or an
+				 * erroneous partition root, clear the state
+				 * state and the CS_CPU_EXCLUSIVE flag.
+				 */
+				WARN_ON_ONCE(cp->partition_root_state
+					     != PRS_ERROR);
+				cp->partition_root_state = 0;
+				spin_lock_irq(&callback_lock);
+				clear_bit(CS_CPU_EXCLUSIVE, &cp->flags);
+				spin_unlock_irq(&callback_lock);
+				break;
+
+			case PRS_ENABLED:
+				if (update_parent_subparts_cpumask(cp,
+					partcmd_update, NULL, tmp))
+					update_tasks_cpumask(parent);
+				break;
+
+			case PRS_ERROR:
+				/*
+				 * When parent is erroneous, it has to be too.
+				 */
+				cp->partition_root_state = PRS_ERROR;
+				if (cp->nr_subparts_cpus) {
+					cp->nr_subparts_cpus = 0;
+					cpumask_clear(cp->subparts_cpus);
+				}
+				break;
+			}
 		}
 
 		if (!css_tryget_online(&cp->css))
@@ -1213,13 +1282,33 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		spin_lock_irq(&callback_lock);
 
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
-		if (cp->nr_subparts_cpus) {
+		if (cp->nr_subparts_cpus &&
+		   (cp->partition_root_state != PRS_ENABLED)) {
+			cp->nr_subparts_cpus = 0;
+			cpumask_clear(cp->subparts_cpus);
+		} else if (cp->nr_subparts_cpus) {
 			/*
 			 * Make sure that effective_cpus & subparts_cpus
 			 * are mutually exclusive.
+			 *
+			 * In the unlikely event that effective_cpus
+			 * becomes empty. we clear cp->nr_subparts_cpus and
+			 * let its child partition roots to compete for
+			 * CPUs again.
 			 */
 			cpumask_andnot(cp->effective_cpus, cp->effective_cpus,
 				       cp->subparts_cpus);
+			if (cpumask_empty(cp->effective_cpus)) {
+				cpumask_copy(cp->effective_cpus, tmp->new_cpus);
+				cpumask_clear(cp->subparts_cpus);
+				cp->nr_subparts_cpus = 0;
+			} else if (!cpumask_subset(cp->subparts_cpus,
+						   tmp->new_cpus)) {
+				cpumask_andnot(cp->subparts_cpus,
+					cp->subparts_cpus, tmp->new_cpus);
+				cp->nr_subparts_cpus
+					= cpumask_weight(cp->subparts_cpus);
+			}
 		}
 		spin_unlock_irq(&callback_lock);
 
@@ -1724,6 +1813,17 @@ static int update_prstate(struct cpuset *cs, int val)
 		}
 		cs->partition_root_state = PRS_ENABLED;
 	} else {
+		/*
+		 * Turning off partition root will clear the
+		 * CS_CPU_EXCLUSIVE bit.
+		 */
+		if (cs->partition_root_state == PRS_ERROR) {
+			cs->partition_root_state = 0;
+			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
+			err = 0;
+			goto out;
+		}
+
 		err = update_parent_subparts_cpumask(cs, partcmd_disable,
 						     NULL, &tmp);
 		if (err)
-- 
1.8.3.1

