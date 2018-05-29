Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966923AbeE2VBS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:01:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:46446 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937158AbeE2VBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:01:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127750"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 27/38] x86/intel_rdt: Add utilities to test pseudo-locked region possibility
Date: Tue, 29 May 2018 05:57:52 -0700
Message-Id: <3a7d6cc8dee86c3fbcc3bd8988b4dc80b44582fa.1527593971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pseudo-locked region does not have a class of service associated with
it and thus not tracked in the array of control values maintained as
part of the domain. Even so, when the user provides a new bitmask for
another resource group it needs to be checked for interference with
existing pseudo-locked regions.

Additionally only one pseudo-locked region can be created in any cache
hierarchy.

Introduce two utilities in support of above scenarios: (1) a utility
that can be used to test if a given capacity bitmask overlaps with any
pseudo-locked regions associated with a particular cache instance, (2) a
utility that can be used to test if a pseudo-locked region exists within
a particular cache hierarchy.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  2 ++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 55 +++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 12b006178d3a..119645c83e27 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -503,6 +503,8 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, u32 _cbm);
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
 void closid_free(int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index ce8243c87877..0d2177a0bc60 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -299,3 +299,58 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 	pseudo_lock_free(rdtgrp);
 	return 0;
 }
+
+/**
+ * rdtgroup_cbm_overlaps_pseudo_locked - Test if CBM or portion is pseudo-locked
+ * @d: RDT domain
+ * @_cbm: CBM to test
+ *
+ * @d represents a cache instance and @_cbm a capacity bitmask that is
+ * considered for it. Determine if @_cbm overlaps with any existing
+ * pseudo-locked region on @d.
+ *
+ * Return: true if @_cbm overlaps with pseudo-locked region on @d, false
+ * otherwise.
+ */
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, u32 _cbm)
+{
+	unsigned long *cbm = (unsigned long *)&_cbm;
+	unsigned long *cbm_b;
+	unsigned int cbm_len;
+
+	if (d->plr) {
+		cbm_len = d->plr->r->cache.cbm_len;
+		cbm_b = (unsigned long *)&d->plr->cbm;
+		if (bitmap_intersects(cbm, cbm_b, cbm_len))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * rdtgroup_pseudo_locked_in_hierarchy - Pseudo-locked region in cache hierarchy
+ * @d: RDT domain under test
+ *
+ * The setup of a pseudo-locked region affects all cache instances within
+ * the hierarchy of the region. It is thus essential to know if any
+ * pseudo-locked regions exist within a cache hierarchy to prevent any
+ * attempts to create new pseudo-locked regions in the same hierarchy.
+ *
+ * Return: true if a pseudo-locked region exists in the hierarchy of @d,
+ * false otherwise.
+ */
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
+{
+	struct rdt_resource *r;
+	struct rdt_domain *d_i;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d_i, &r->domains, list) {
+			if (d_i != d &&
+			    cpumask_intersects(&d_i->cpu_mask, &d->cpu_mask))
+				return true;
+		}
+	}
+	return false;
+}
-- 
2.13.6
