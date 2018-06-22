Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D77C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5717424996
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5717424996
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeFVWuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:50:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:22310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754563AbeFVWmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843393"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 15/41] x86/intel_rdt: Display resource groups' allocations' size in bytes
Date:   Fri, 22 Jun 2018 15:42:06 -0700
Message-Id: <cc0058014c30adb88ca7d1a5abfadacbfb5edd0d.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schemata file displays the allocations associated with each domain of
each resource. The syntax of this file reflects the capacity bitmask (CBM)
of the actual allocation. In order to determine the actual size of an
allocation the user needs to dig through three different files to query the
variables needed to compute it (the cache size, the CBM length, and the
schemata).

Introduce a new file "size" associated with each resource group that will
mirror the schemata file syntax and display the size in bytes of each
allocation.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/4dbd77fceeaddf9e1649f1c69aa45d223e60d58e.1527593970.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt.h          |  2 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 81 ++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 68d398bc2942..8bbb047bf37c 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -467,6 +467,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
 bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 _cbm, int closid, bool exclusive);
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
+				  u32 cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 542316dd9ee2..6519b69e6791 100644
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
+				seq_putc(s, ';');
+			cbm = d->ctrl_val[rdtgrp->closid];
+			size = rdtgroup_cbm_to_size(r, d, cbm);
+			seq_printf(s, "%d=%u", d->id, size);
+			sep = true;
+		}
+		seq_putc(s, '\n');
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
2.17.0

