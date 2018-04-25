Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeDYSNL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:13:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:41720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932183AbeDYSMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243703"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 20/39] x86/intel_rdt: Protect against resource group changes during locking
Date: Wed, 25 Apr 2018 03:09:56 -0700
Message-Id: <4c6f684afb75373ea212881edb11a071d3ca7a99.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We intend to modify file permissions to make the "tasks", "cpus", and
"cpus_list" not accessible to the user when cache pseudo-locking in
progress. Even so, it is still possible for the user to force the file
permissions (using chmod) to make them writeable. Similarly, directory
permissions will be modified to prevent future monitor group creation
but the user can override these restrictions also.

Add additional checks to the files we intend to restrict to ensure that
no modifications from user space are attempted while setting up a
pseudo-locking or after a pseudo-locked region is set up.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 10 +++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 32 +++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 15291ca02daf..f6740218a751 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -273,6 +273,16 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 	rdt_last_cmd_clear();
 
+	/*
+	 * No changes to pseudo-locked region allowed. It has to be removed
+	 * and re-created instead.
+	 */
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("resource group is pseudo-locked\n");
+		goto out;
+	}
+
 	for_each_alloc_enabled_rdt_resource(r) {
 		list_for_each_entry(dom, &r->domains, list)
 			dom->have_new_ctrl = false;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 4d63934e6f68..01ffa4641bf8 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -449,6 +449,13 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 		goto unlock;
 	}
 
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
+	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		goto unlock;
+	}
+
 	if (is_cpu_list(of))
 		ret = cpulist_parse(buf, newmask);
 	else
@@ -651,13 +658,22 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
 		return -EINVAL;
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
 	rdt_last_cmd_clear();
 
-	if (rdtgrp)
-		ret = rdtgroup_move_task(pid, rdtgrp, of);
-	else
-		ret = -ENOENT;
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
+	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		goto unlock;
+	}
+
+	ret = rdtgroup_move_task(pid, rdtgrp, of);
 
+unlock:
 	rdtgroup_kn_unlock(of->kn);
 
 	return ret ?: nbytes;
@@ -2228,6 +2244,14 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	if (rtype == RDTMON_GROUP &&
+	    (prdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+	     prdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("pseudo-locking in progress\n");
+		goto out_unlock;
+	}
+
 	/* allocate the rdtgroup. */
 	rdtgrp = kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
 	if (!rdtgrp) {
-- 
2.13.6
