Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932259AbeDYSM4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:12:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:41709 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755758AbeDYSMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243676"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 14/39] x86/intel_rdt: Display resource groups' allocations' size in bytes
Date: Wed, 25 Apr 2018 03:09:50 -0700
Message-Id: <416e380483ff0e2ed765c3b2b2958c133e618562.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schemata file displays the allocations associated with each domain
of each resource. The syntax of this file reflects the capacity bitmask
(CBM) of the actual allocation. In order to determine the actual size of
an allocation the user needs to dig through three different files to query
the variables needed to compute it (the cache size, the CBM length, and
the schemata).

Introduce a new file "size" associated with each resource group that
will mirror the schemata file syntax and display the size in bytes of
each allocation.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          |  2 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 81 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index e48ff4e62757..6658608330fb 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -452,6 +452,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
 int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 			  u32 _cbm, int closid, bool exclusive);
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
+				  u32 cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index e6aafd351b20..9337f72983ec 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -20,6 +20,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
@@ -1016,6 +1017,78 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+/**
+ * rdtgroup_cbm_to_size - Translate CBM to size in bytes
+ * @r: RDT resource to which @d belongs.
+ * @d: RDT domain instance.
+ * @cbm: bitmask for which the size should be computed.
+ *
+ * The bitmask provided associated with the RDT domain instance @d will be
+ * translated into how many bytes it represents. The size in bytes is
+ * computed by first dividing the total cache size by the CBM length to
+ * determine how many bytes each bit in the bitmask represents. The result
+ * is multiplied with the number of bits set in the bitmask.
+ */
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
+				  struct rdt_domain *d, u32 cbm)
+{
+	struct cpu_cacheinfo *ci;
+	unsigned int size = 0;
+	int num_b, i;
+
+	num_b = bitmap_weight((unsigned long *)&cbm, r->cache.cbm_len);
+	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == r->cache_level) {
+			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
+			break;
+		}
+	}
+
+	return size;
+}
+
+/**
+ * rdtgroup_size_show - Display size in bytes of allocated regions
+ *
+ * The "size" file mirrors the layout of the "schemata" file, printing the
+ * size in bytes of each region instead of the capacity bitmask.
+ *
+ */
+static int rdtgroup_size_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+	unsigned int size;
+	bool sep = false;
+	u32 cbm;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		seq_printf(s, "%*s:", max_name_width, r->name);
+		list_for_each_entry(d, &r->domains, list) {
+			if (sep)
+				seq_puts(s, ";");
+			cbm = d->ctrl_val[rdtgrp->closid];
+			size = rdtgroup_cbm_to_size(r, d, cbm);
+			seq_printf(s, "%d=%u", d->id, size);
+			sep = true;
+		}
+		seq_puts(s, "\n");
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1144,6 +1217,14 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_mode_show,
 		.fflags		= RF_CTRL_BASE,
 	},
+	{
+		.name		= "size",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_size_show,
+		.fflags		= RF_CTRL_BASE,
+	},
+
 };
 
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
-- 
2.13.6
