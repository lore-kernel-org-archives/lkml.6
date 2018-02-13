Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966332AbeBMXwr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:52:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:53394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966179AbeBMXtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822317"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 07/22] x86/intel_rdt: Connect pseudo-locking directory to operations
Date: Tue, 13 Feb 2018 07:46:51 -0800
Message-Id: <98b002182bf81fb75346edcf80588ba85f35c74b.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a dependent of RDT/CAT we hook up the pseudo-locking files
initialization to that of RDT/CAT. The initial operations of mkdir/rmdir
used to create pseudo-locked regions are now hooked up also.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 5698d66b6892..24d2def37797 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1244,13 +1244,19 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 		goto out_cdp;
 	}
 
+	ret = rdt_pseudo_lock_fs_init(rdtgroup_default.kn);
+	if (ret) {
+		dentry = ERR_PTR(ret);
+		goto out_info;
+	}
+
 	if (rdt_mon_capable) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
 					  NULL, "mon_groups",
 					  &kn_mongrp);
 		if (ret) {
 			dentry = ERR_PTR(ret);
-			goto out_info;
+			goto out_psl;
 		}
 		kernfs_get(kn_mongrp);
 
@@ -1291,6 +1297,8 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 out_mongrp:
 	if (rdt_mon_capable)
 		kernfs_remove(kn_mongrp);
+out_psl:
+	rdt_pseudo_lock_fs_remove();
 out_info:
 	kernfs_remove(kn_info);
 out_cdp:
@@ -1439,6 +1447,7 @@ static void rmdir_all_sub(void)
 	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
 	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
 
+	rdt_pseudo_lock_fs_remove();
 	kernfs_remove(kn_info);
 	kernfs_remove(kn_mongrp);
 	kernfs_remove(kn_mondata);
@@ -1861,6 +1870,9 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	if (strchr(name, '\n'))
 		return -EINVAL;
 
+	if (parent_kn == pseudo_lock_kn)
+		return rdt_pseudo_lock_mkdir(name, mode);
+
 	/*
 	 * If the parent directory is the root directory and RDT
 	 * allocation is supported, add a control and monitoring
@@ -1970,6 +1982,9 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	cpumask_var_t tmpmask;
 	int ret = 0;
 
+	if (parent_kn == pseudo_lock_kn)
+		return rdt_pseudo_lock_rmdir(kn);
+
 	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
-- 
2.13.6
