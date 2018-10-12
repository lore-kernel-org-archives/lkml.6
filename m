Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0857C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593662087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593662087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeJMG0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 02:26:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:47677 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbeJMG0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 02:26:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 15:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,374,1534834800"; 
   d="scan'208";a="81059035"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2018 15:52:08 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc:     gavin.hindman@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jithu Joseph <jithu.joseph@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] x86/intel_rdt: Prevent pseudo-locking from using stale pointers
Date:   Fri, 12 Oct 2018 15:51:01 -0700
Message-Id: <231f742dbb7b00a31cc104416860e27dba6b072d.1539384145.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

When the last CPU in an rdt_domain goes offline, its rdt_domain struct
gets freed. Current pseudo-locking code is unaware of this scenario
and tries to dereference the freed structure in a few places.

Add checks to prevent pseudo-locking code from doing this.

While further work is needed to seamlessly restore resource groups
(not just pseudo-locking) to their configuration when the domain is
brought back online, the immediate issue of invalid pointers is
addressed here.

Fixes: f4e80d67a5274 ("x86/intel_rdt: Resctrl files reflect pseudo-locked information")
Fixes: 443810fe61605 ("x86/intel_rdt: Create debugfs files for pseudo-locking testing")
Fixes: 746e08590b864 ("x86/intel_rdt: Create character device exposing pseudo-locked region")
Fixes: 33dc3e410a0d9 ("x86/intel_rdt: Make CPU information accessible for pseudo-locked regions")
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             |  7 ++++
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 12 +++++--
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 10 ++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 38 +++++++++++++++------
 4 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 1214f3f7ec6d..44272b7107ad 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -608,6 +608,13 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 			cancel_delayed_work(&d->cqm_limbo);
 		}
 
+		/*
+		 * rdt_domain "d" is going to be freed below, so clear
+		 * its pointer from pseudo_lock_region struct.
+		 */
+		if (d->plr)
+			d->plr->d = NULL;
+
 		kfree(d->ctrl_val);
 		kfree(d->mbps_val);
 		bitmap_free(d->rmid_busy_llc);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 0f53049719cd..27937458c231 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -404,8 +404,16 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			for_each_alloc_enabled_rdt_resource(r)
 				seq_printf(s, "%s:uninitialized\n", r->name);
 		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
-			seq_printf(s, "%s:%d=%x\n", rdtgrp->plr->r->name,
-				   rdtgrp->plr->d->id, rdtgrp->plr->cbm);
+			if (!rdtgrp->plr->d) {
+				rdt_last_cmd_clear();
+				rdt_last_cmd_puts("Cache domain offline\n");
+				ret = -ENODEV;
+			} else {
+				seq_printf(s, "%s:%d=%x\n",
+					   rdtgrp->plr->r->name,
+					   rdtgrp->plr->d->id,
+					   rdtgrp->plr->cbm);
+			}
 		} else {
 			closid = rdtgrp->closid;
 			for_each_alloc_enabled_rdt_resource(r) {
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 9d54b191964b..9c8b602bd583 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1174,6 +1174,11 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 		goto out;
 	}
 
+	if (!plr->d) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	plr->thread_done = 0;
 	cpu = cpumask_first(&plr->d->cpu_mask);
 	if (!cpu_online(cpu)) {
@@ -1494,6 +1499,11 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	plr = rdtgrp->plr;
 
+	if (!plr->d) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENODEV;
+	}
+
 	/*
 	 * Task is required to run with affinity to the cpus associated
 	 * with the pseudo-locked region. If this is not the case the task
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 5f55f8848da6..3a3ed7cf3773 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -268,17 +268,27 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
 	struct rdtgroup *rdtgrp;
+	struct cpumask *mask;
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 
 	if (rdtgrp) {
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
-				   cpumask_pr_args(&rdtgrp->plr->d->cpu_mask));
-		else
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			if (!rdtgrp->plr->d) {
+				rdt_last_cmd_clear();
+				rdt_last_cmd_puts("Cache domain offline\n");
+				ret = -ENODEV;
+			} else {
+				mask = &rdtgrp->plr->d->cpu_mask;
+				seq_printf(s, is_cpu_list(of) ?
+					   "%*pbl\n" : "%*pb\n",
+					   cpumask_pr_args(mask));
+			}
+		} else {
 			seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
 				   cpumask_pr_args(&rdtgrp->cpu_mask));
+		}
 	} else {
 		ret = -ENOENT;
 	}
@@ -1282,6 +1292,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	struct rdt_resource *r;
 	struct rdt_domain *d;
 	unsigned int size;
+	int ret = 0;
 	bool sep;
 	u32 ctrl;
 
@@ -1292,11 +1303,18 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	}
 
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
-		seq_printf(s, "%*s:", max_name_width, rdtgrp->plr->r->name);
-		size = rdtgroup_cbm_to_size(rdtgrp->plr->r,
-					    rdtgrp->plr->d,
-					    rdtgrp->plr->cbm);
-		seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
+		if (!rdtgrp->plr->d) {
+			rdt_last_cmd_clear();
+			rdt_last_cmd_puts("Cache domain offline\n");
+			ret = -ENODEV;
+		} else {
+			seq_printf(s, "%*s:", max_name_width,
+				   rdtgrp->plr->r->name);
+			size = rdtgroup_cbm_to_size(rdtgrp->plr->r,
+						    rdtgrp->plr->d,
+						    rdtgrp->plr->cbm);
+			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
+		}
 		goto out;
 	}
 
@@ -1326,7 +1344,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 out:
 	rdtgroup_kn_unlock(of->kn);
 
-	return 0;
+	return ret;
 }
 
 /* rdtgroup information files for one cache resource. */
-- 
2.17.0

