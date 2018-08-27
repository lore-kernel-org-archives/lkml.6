Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A133FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC84208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC84208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeH0S2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:28:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727611AbeH0S2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F67440241E8;
        Mon, 27 Aug 2018 14:41:40 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B84402027EA3;
        Mon, 27 Aug 2018 14:41:39 +0000 (UTC)
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
Subject: [PATCH v12 4/9] cpuset: Allow changes to cpus in a partition root
Date:   Mon, 27 Aug 2018 10:41:19 -0400
Message-Id: <1535380884-31308-5-git-send-email-longman@redhat.com>
In-Reply-To: <1535380884-31308-1-git-send-email-longman@redhat.com>
References: <1535380884-31308-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 14:41:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 14:41:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch introduces a new partition flag, but won't allow
changes made to "cpuset.cpus" once the flag is on. That may be too
restrictive in some use cases. So this restiction is now relaxed to
allow changes made to the "cpuset.cpus" file with some constraints:

 1) The new set of cpus must still be exclusive.
 2) Newly added cpus must be a subset of the parent effective_cpus.
 3) None of the deleted cpus can be one of those allocated to a child
    partition roots, if present.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  9 +++++
 kernel/cgroup/cpuset.c                  | 61 ++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5e33d25..a5fc335 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1701,6 +1701,15 @@ Cpuset Interface Files
         its child partition root cgroups.  There must be at least one cpu
         left in the parent partition root cgroup.
 
+	In a partition root, changes to "cpuset.cpus" is allowed as long
+	as the first condition above as well as the following two
+	additional conditions are true.
+
+	1) Any added CPUs must be a proper subset of the parent's
+	   "cpuset.cpus.effective".
+	2) No CPU that has been distributed to child partition roots is
+	   is deleted.
+
 
 Device controller
 -----------------
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d9e821c..56e0931 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -957,6 +957,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
 
 		spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, new_cpus);
+		if (cp->nr_reserved)
+			cpumask_andnot(cp->effective_cpus, cp->effective_cpus,
+				       cp->reserved_cpus);
 		spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
@@ -984,8 +987,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
 /**
  * update_reserved_cpumask - update the reserved_cpus mask of parent cpuset
  * @cpuset:  The cpuset that requests CPU reservation
- * @delmask: The old reserved cpumask to be removed from the parent
- * @addmask: The new reserved cpumask to be added to the parent
+ * @oldmask: The old reserved cpumask to be removed from the parent
+ * @newmask: The new reserved cpumask to be added to the parent
  * Return: 0 if successful, an error code otherwise
  *
  * Removing CPUs from a partition root may not be allowed by the
@@ -1001,15 +1004,17 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
  * cpumask changes tht violates the cpu exclusivity rule will not be
  * permitted.
  *
- * If the sched.partition flag changes, either the delmask (0=>1) or the
- * addmask (1=>0) will be NULL.
+ * If the sched.partition flag changes, either the oldmask (0=>1) or the
+ * newmask (1=>0) will be NULL.
  *
  * Called with cpuset_mutex held.
  */
 static int update_reserved_cpumask(struct cpuset *cpuset,
-	struct cpumask *delmask, struct cpumask *addmask)
+	struct cpumask *oldmask, struct cpumask *newmask)
 {
 	int retval;
+	int adding, deleting;
+	cpumask_var_t addmask, delmask;
 	struct cpuset *parent = parent_cs(cpuset);
 	int old_count = parent->nr_reserved;
 
@@ -1018,16 +1023,23 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 	 * The new cpumask, if present, must not be empty.
 	 */
 	if (!is_partition_root(parent) ||
-	   (addmask && cpumask_empty(addmask)))
+	   (newmask && cpumask_empty(newmask)))
 		return -EINVAL;
 
 	/*
 	 * A sched.partition state change is not allowed if there are
 	 * online children.
 	 */
-	if (css_has_online_children(&cpuset->css))
+	if ((!oldmask || !newmask) && css_has_online_children(&cpuset->css))
 		return -EBUSY;
 
+	if (!zalloc_cpumask_var(&addmask, GFP_KERNEL))
+		return -ENOMEM;
+	if (!zalloc_cpumask_var(&delmask, GFP_KERNEL)) {
+		free_cpumask_var(addmask);
+		return -ENOMEM;
+	}
+
 	if (!old_count) {
 		if (!zalloc_cpumask_var(&parent->reserved_cpus, GFP_KERNEL)) {
 			retval = -ENOMEM;
@@ -1037,12 +1049,29 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 	}
 
 	retval = -EBUSY;
+	adding = deleting = false;
+	/*
+	 * addmask = newmask & ~oldmask
+	 * delmask = oldmask & ~newmask
+	 */
+	if (oldmask && newmask) {
+		adding   = cpumask_andnot(addmask, newmask, oldmask);
+		deleting = cpumask_andnot(delmask, oldmask, newmask);
+		if (!adding && !deleting)
+			goto out_ok;
+	} else if (newmask) {
+		adding = true;
+		cpumask_copy(addmask, newmask);
+	} else if (oldmask) {
+		deleting = true;
+		cpumask_copy(delmask, oldmask);
+	}
 
 	/*
 	 * The cpus to be added must be a proper subset of the parent's
 	 * effective_cpus mask but not in the reserved_cpus mask.
 	 */
-	if (addmask) {
+	if (adding) {
 		if (!cpumask_subset(addmask, parent->effective_cpus) ||
 		     cpumask_equal(addmask, parent->effective_cpus))
 			goto out;
@@ -1057,13 +1086,13 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 	 * and newly deleted ones will be added back if they are online.
 	 */
 	spin_lock_irq(&callback_lock);
-	if (addmask) {
+	if (adding) {
 		cpumask_or(parent->reserved_cpus,
 			   parent->reserved_cpus, addmask);
 		cpumask_andnot(parent->effective_cpus,
 			       parent->effective_cpus, addmask);
 	}
-	if (delmask) {
+	if (deleting) {
 		cpumask_andnot(parent->reserved_cpus,
 			       parent->reserved_cpus, delmask);
 		cpumask_or(parent->effective_cpus,
@@ -1072,8 +1101,12 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 
 	parent->nr_reserved = cpumask_weight(parent->reserved_cpus);
 	spin_unlock_irq(&callback_lock);
+
+out_ok:
 	retval = 0;
 out:
+	free_cpumask_var(addmask);
+	free_cpumask_var(delmask);
 	if (old_count && !parent->nr_reserved)
 		free_cpumask_var(parent->reserved_cpus);
 
@@ -1121,8 +1154,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		return retval;
 
-	if (is_partition_root(cs))
-		return -EBUSY;
+	if (is_partition_root(cs)) {
+		retval = update_reserved_cpumask(cs, cs->cpus_allowed,
+						 trialcs->cpus_allowed);
+		if (retval < 0)
+			return retval;
+	}
 
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
-- 
1.8.3.1

