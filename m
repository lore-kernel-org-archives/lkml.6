Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF15C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6FB24BD4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6FB24BD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeFWMUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:20:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeFWMUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:20:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCK3lL464982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:20:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCK3pW464978;
        Sat, 23 Jun 2018 05:20:03 -0700
Date:   Sat, 23 Jun 2018 05:20:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-63657c1cdf89a37d3b69471ad4e5b55c77e86d3f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        reinette.chatre@intel.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, reinette.chatre@intel.com
In-Reply-To: <b120f71ced30116bcc6c6f651e8a7906ae6b903d.1529706536.git.reinette.chatre@intel.com>
References: <b120f71ced30116bcc6c6f651e8a7906ae6b903d.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Support enter/exit of locksetup mode
Git-Commit-ID: 63657c1cdf89a37d3b69471ad4e5b55c77e86d3f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  63657c1cdf89a37d3b69471ad4e5b55c77e86d3f
Gitweb:     https://git.kernel.org/tip/63657c1cdf89a37d3b69471ad4e5b55c77e86d3f
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:16 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:47 +0200

x86/intel_rdt: Support enter/exit of locksetup mode

The locksetup mode is the way in which the user communicates that the
resource group will be used for a pseudo-locked region. Locksetup mode
should thus ensure that all restrictions on a resource group are met before
locksetup mode can be entered. The resource group should also be configured
to ensure that it cannot be modified in unsupported ways when a
pseudo-locked region.

Introduce the support where the request for entering locksetup mode can be
validated. This includes: CDP is not active, no cpus or tasks are assigned
to the resource group, monitoring is not in progress on the resource
group. Once the resource group is determined ready for a pseudo-locked
region it is configured to not allow future changes to these properties.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/b120f71ced30116bcc6c6f651e8a7906ae6b903d.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h             |   2 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 187 +++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index f3dcbcd03dfa..338fe47396a5 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -501,6 +501,8 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
 				  u32 cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
+int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
+int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
 void closid_free(int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 8693dbe602a2..ce8243c87877 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -11,8 +11,48 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/slab.h>
 #include "intel_rdt.h"
 
+/**
+ * pseudo_lock_init - Initialize a pseudo-lock region
+ * @rdtgrp: resource group to which new pseudo-locked region will belong
+ *
+ * A pseudo-locked region is associated with a resource group. When this
+ * association is created the pseudo-locked region is initialized. The
+ * details of the pseudo-locked region are not known at this time so only
+ * allocation is done and association established.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static int pseudo_lock_init(struct rdtgroup *rdtgrp)
+{
+	struct pseudo_lock_region *plr;
+
+	plr = kzalloc(sizeof(*plr), GFP_KERNEL);
+	if (!plr)
+		return -ENOMEM;
+
+	rdtgrp->plr = plr;
+	return 0;
+}
+
+/**
+ * pseudo_lock_free - Free a pseudo-locked region
+ * @rdtgrp: resource group to which pseudo-locked region belonged
+ *
+ * The pseudo-locked region's resources have already been released, or not
+ * yet created at this point. Now it can be freed and disassociated from the
+ * resource group.
+ *
+ * Return: void
+ */
+static void pseudo_lock_free(struct rdtgroup *rdtgrp)
+{
+	kfree(rdtgrp->plr);
+	rdtgrp->plr = NULL;
+}
+
 /**
  * rdtgroup_monitor_in_progress - Test if monitoring in progress
  * @r: resource group being queried
@@ -20,8 +60,7 @@
  * Return: 1 if monitor groups have been created for this resource
  * group, 0 otherwise.
  */
-static int __attribute__ ((unused))
-rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
+static int rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
 {
 	return !list_empty(&rdtgrp->mon.crdtgrp_list);
 }
@@ -41,8 +80,7 @@ rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
  * the state of the mode of these files will be uncertain when a failure
  * occurs.
  */
-static int __attribute__ ((unused))
-rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
+static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
@@ -89,8 +127,7 @@ out:
  * again but the state of the mode of these files will be uncertain when
  * a failure occurs.
  */
-static int __attribute__ ((unused))
-rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
+static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
@@ -124,3 +161,141 @@ err_tasks:
 out:
 	return ret;
 }
+
+/**
+ * rdtgroup_locksetup_enter - Resource group enters locksetup mode
+ * @rdtgrp: resource group requested to enter locksetup mode
+ *
+ * A resource group enters locksetup mode to reflect that it would be used
+ * to represent a pseudo-locked region and is in the process of being set
+ * up to do so. A resource group used for a pseudo-locked region would
+ * lose the closid associated with it so we cannot allow it to have any
+ * tasks or cpus assigned nor permit tasks or cpus to be assigned in the
+ * future. Monitoring of a pseudo-locked region is not allowed either.
+ *
+ * The above and more restrictions on a pseudo-locked region are checked
+ * for and enforced before the resource group enters the locksetup mode.
+ *
+ * Returns: 0 if the resource group successfully entered locksetup mode, <0
+ * on failure. On failure the last_cmd_status buffer is updated with text to
+ * communicate details of failure to the user.
+ */
+int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	/*
+	 * The default resource group can neither be removed nor lose the
+	 * default closid associated with it.
+	 */
+	if (rdtgrp == &rdtgroup_default) {
+		rdt_last_cmd_puts("cannot pseudo-lock default group\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Cache Pseudo-locking not supported when CDP is enabled.
+	 *
+	 * Some things to consider if you would like to enable this
+	 * support (using L3 CDP as example):
+	 * - When CDP is enabled two separate resources are exposed,
+	 *   L3DATA and L3CODE, but they are actually on the same cache.
+	 *   The implication for pseudo-locking is that if a
+	 *   pseudo-locked region is created on a domain of one
+	 *   resource (eg. L3CODE), then a pseudo-locked region cannot
+	 *   be created on that same domain of the other resource
+	 *   (eg. L3DATA). This is because the creation of a
+	 *   pseudo-locked region involves a call to wbinvd that will
+	 *   affect all cache allocations on particular domain.
+	 * - Considering the previous, it may be possible to only
+	 *   expose one of the CDP resources to pseudo-locking and
+	 *   hide the other. For example, we could consider to only
+	 *   expose L3DATA and since the L3 cache is unified it is
+	 *   still possible to place instructions there are execute it.
+	 * - If only one region is exposed to pseudo-locking we should
+	 *   still keep in mind that availability of a portion of cache
+	 *   for pseudo-locking should take into account both resources.
+	 *   Similarly, if a pseudo-locked region is created in one
+	 *   resource, the portion of cache used by it should be made
+	 *   unavailable to all future allocations from both resources.
+	 */
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled ||
+	    rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled) {
+		rdt_last_cmd_puts("CDP enabled\n");
+		return -EINVAL;
+	}
+
+	if (rdtgroup_monitor_in_progress(rdtgrp)) {
+		rdt_last_cmd_puts("monitoring in progress\n");
+		return -EINVAL;
+	}
+
+	if (rdtgroup_tasks_assigned(rdtgrp)) {
+		rdt_last_cmd_puts("tasks assigned to resource group\n");
+		return -EINVAL;
+	}
+
+	if (!cpumask_empty(&rdtgrp->cpu_mask)) {
+		rdt_last_cmd_puts("CPUs assigned to resource group\n");
+		return -EINVAL;
+	}
+
+	if (rdtgroup_locksetup_user_restrict(rdtgrp)) {
+		rdt_last_cmd_puts("unable to modify resctrl permissions\n");
+		return -EIO;
+	}
+
+	ret = pseudo_lock_init(rdtgrp);
+	if (ret) {
+		rdt_last_cmd_puts("unable to init pseudo-lock region\n");
+		goto out_release;
+	}
+
+	/*
+	 * If this system is capable of monitoring a rmid would have been
+	 * allocated when the control group was created. This is not needed
+	 * anymore when this group would be used for pseudo-locking. This
+	 * is safe to call on platforms not capable of monitoring.
+	 */
+	free_rmid(rdtgrp->mon.rmid);
+
+	ret = 0;
+	goto out;
+
+out_release:
+	rdtgroup_locksetup_user_restore(rdtgrp);
+out:
+	return ret;
+}
+
+/**
+ * rdtgroup_locksetup_exit - resource group exist locksetup mode
+ * @rdtgrp: resource group
+ *
+ * When a resource group exits locksetup mode the earlier restrictions are
+ * lifted.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	if (rdt_mon_capable) {
+		ret = alloc_rmid();
+		if (ret < 0) {
+			rdt_last_cmd_puts("out of RMIDs\n");
+			return ret;
+		}
+		rdtgrp->mon.rmid = ret;
+	}
+
+	ret = rdtgroup_locksetup_user_restore(rdtgrp);
+	if (ret) {
+		free_rmid(rdtgrp->mon.rmid);
+		return ret;
+	}
+
+	pseudo_lock_free(rdtgrp);
+	return 0;
+}
