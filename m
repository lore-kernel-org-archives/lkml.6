Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756356AbeDYSaW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:30:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:41709 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755794AbeDYSMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243614"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 03/39] x86/intel_rdt: Associate mode with each RDT resource group
Date: Wed, 25 Apr 2018 03:09:39 -0700
Message-Id: <84237a413da43a601da0dfab061bcf11fb62d0b3.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each RDT resource group is associated with a mode that will reflect
the level of sharing of its allocations. The default, shareable, will be
associated with each resource group on creation since it is zero and
resource groups are created with kzalloc. The managing of the mode of a
resource group will follow. The default resource group always remain
though so ensure that it is reset to the default mode when the resctrl
filesystem is unmounted.

Also introduce a utility that can be used to determine the mode of a
resource group when it is searched for based on its class of service.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          |  3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index ecc32eb6a91e..e7f8561479d2 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -121,6 +121,7 @@ struct mongroup {
  * @type:			indicates type of this rdtgroup - either
  *				monitor only or ctrl_mon group
  * @mon:			mongroup related data
+ * @mode:			mode of resource group
  */
 struct rdtgroup {
 	struct kernfs_node	*kn;
@@ -131,6 +132,7 @@ struct rdtgroup {
 	atomic_t		waitcount;
 	enum rdt_group_type	type;
 	struct mongroup		mon;
+	enum rdtgrp_mode	mode;
 };
 
 /* rdtgroup.flags */
@@ -446,6 +448,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index bdab7d2f51af..4683fe2b2118 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -126,6 +126,27 @@ static void closid_free(int closid)
 	closid_free_map |= 1 << closid;
 }
 
+/**
+ * rdtgroup_mode_by_closid - Return mode of resource group with closid
+ * @closid: closid if the resource group
+ *
+ * Each resource group is associated with a @closid. Here the mode
+ * of a resource group can be queried by searching for it using its closid.
+ *
+ * Return: mode as &enum rdtgrp_mode of resource group with closid @closid
+ */
+enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
+{
+	struct rdtgroup *rdtgrp;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->closid == closid)
+			return rdtgrp->mode;
+	}
+
+	return RDT_NUM_MODES;
+}
+
 /* set uid and gid of rdtgroup dirs and files to that of the creator */
 static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
 {
@@ -1450,6 +1471,7 @@ static void rdt_kill_sb(struct super_block *sb)
 		reset_all_ctrls(r);
 	cdp_disable_all();
 	rmdir_all_sub();
+	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
-- 
2.13.6
