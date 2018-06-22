Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A120C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AE6245A3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AE6245A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754866AbeFVWpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:45:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:22312 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754692AbeFVWmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843432"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:48 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 28/41] x86/intel_rdt: Add utilities to test pseudo-locked region possibility
Date:   Fri, 22 Jun 2018 15:42:19 -0700
Message-Id: <b8e31dbdcf22ddf71df46072647b47e7558abb32.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/59b96030bd839dbc474bbac217f9879e45579e52.1527847599.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt.h             |  2 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 74 +++++++++++++++++++++
 2 files changed, 76 insertions(+)

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
index ce8243c87877..b145a7386b10 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -299,3 +299,77 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
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
+ * Return: true if a pseudo-locked region exists in the hierarchy of @d or
+ *         if it is not possible to test due to memory allocation issue,
+ *         false otherwise.
+ */
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
+{
+	cpumask_var_t cpu_with_psl;
+	struct rdt_resource *r;
+	struct rdt_domain *d_i;
+	bool ret = false;
+
+	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
+		return true;
+
+	/*
+	 * First determine which cpus have pseudo-locked regions
+	 * associated with them.
+	 */
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d_i, &r->domains, list) {
+			if (d_i->plr)
+				cpumask_or(cpu_with_psl, cpu_with_psl,
+					   &d_i->cpu_mask);
+		}
+	}
+
+	/*
+	 * Next test if new pseudo-locked region would intersect with
+	 * existing region.
+	 */
+	if (cpumask_intersects(&d->cpu_mask, cpu_with_psl))
+		ret = true;
+
+	free_cpumask_var(cpu_with_psl);
+	return ret;
+}
-- 
2.17.0

