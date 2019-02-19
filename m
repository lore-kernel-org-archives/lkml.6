Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249C3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A4E21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfBSUBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:8744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbfBSUA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918062"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:00:57 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 02/10] perf/x86/intel/cstate: Apply "domain" for cstate
Date:   Tue, 19 Feb 2019 12:00:03 -0800
Message-Id: <1550606411-5313-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There are duplicate codes implemented to support different scopes of
counters. Apply the new concept, "domain", for cstate to reduce the
redundancy.

Add struct cstate_pmus to store the PMU related information. Each
available type needs a dedicated cstate_pmus, which is allocated
in cstate_probe_msr().
Remove hardcode cstate_core_pmu and cstate_pkg_pmu. The PMU information
can be found via domain type now.
Cleanup the codes in cstate_pmu_event_init(), cstate_get_attr_cpumask()
and cstate_init().

The format attrs are the same for PACKAGE_DOMAIN and CORE_DOMAIN.
Remove the duplicate codes.

The cpu_mask of a domain type can be retrieved from the common
functions. Cleanup cstate_cpu_init/exit, and remove duplicate codes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 341 ++++++++++++++++++++++-------------------
 1 file changed, 184 insertions(+), 157 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index d2e7807..5f71606 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -96,6 +96,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
+#include "../domain.h"
 
 MODULE_LICENSE("GPL");
 
@@ -110,14 +111,15 @@ static ssize_t __cstate_##_var##_show(struct kobject *kobj,	\
 static struct kobj_attribute format_attr_##_var =		\
 	__ATTR(_name, 0444, __cstate_##_var##_show, NULL)
 
-static ssize_t cstate_get_attr_cpumask(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf);
-
 /* Model -> events mapping */
 struct cstate_model {
-	unsigned long		core_events;
-	unsigned long		pkg_events;
+	union {
+		unsigned long	events[DOMAIN_TYPE_MAX];
+		struct {
+			unsigned long	pkg_events;
+			unsigned long	core_events;
+		};
+	};
 	unsigned long		quirks;
 };
 
@@ -130,10 +132,17 @@ struct perf_cstate_msr {
 	struct	perf_pmu_events_attr *attr;
 };
 
+struct cstate_pmus {
+	struct pmu		pmu;
+	struct domain_type	type;
+	int			event_max;
+	struct perf_cstate_msr	*msrs;
+	struct attribute	**attrs;
+	cpumask_t		cpu_mask;
+};
+static struct cstate_pmus *cstate_pmus[DOMAIN_TYPE_MAX];
 
 /* cstate_core PMU */
-static struct pmu cstate_core_pmu;
-static bool has_cstate_core;
 
 enum perf_cstate_core_events {
 	PERF_CSTATE_CORE_C1_RES = 0,
@@ -166,17 +175,33 @@ static struct attribute_group core_events_attr_group = {
 };
 
 DEFINE_CSTATE_FORMAT_ATTR(core_event, event, "config:0-63");
-static struct attribute *core_format_attrs[] = {
+static struct attribute *format_attrs[] = {
 	&format_attr_core_event.attr,
 	NULL,
 };
 
-static struct attribute_group core_format_attr_group = {
+static struct attribute_group format_attr_group = {
 	.name = "format",
-	.attrs = core_format_attrs,
+	.attrs = format_attrs,
 };
 
-static cpumask_t cstate_core_cpu_mask;
+static ssize_t cstate_get_attr_cpumask(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct cstate_pmus *pmus;
+	int i;
+
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		pmus = cstate_pmus[i];
+		if (!pmus || &pmus->pmu != pmu)
+			continue;
+		return cpumap_print_to_pagebuf(true, buf, &pmus->cpu_mask);
+	}
+	return 0;
+}
+
 static DEVICE_ATTR(cpumask, S_IRUGO, cstate_get_attr_cpumask, NULL);
 
 static struct attribute *cstate_cpumask_attrs[] = {
@@ -190,15 +215,12 @@ static struct attribute_group cpumask_attr_group = {
 
 static const struct attribute_group *core_attr_groups[] = {
 	&core_events_attr_group,
-	&core_format_attr_group,
+	&format_attr_group,
 	&cpumask_attr_group,
 	NULL,
 };
 
 /* cstate_pkg PMU */
-static struct pmu cstate_pkg_pmu;
-static bool has_cstate_pkg;
-
 enum perf_cstate_pkg_events {
 	PERF_CSTATE_PKG_C2_RES = 0,
 	PERF_CSTATE_PKG_C3_RES,
@@ -238,44 +260,24 @@ static struct attribute_group pkg_events_attr_group = {
 	.attrs = pkg_events_attrs,
 };
 
-DEFINE_CSTATE_FORMAT_ATTR(pkg_event, event, "config:0-63");
-static struct attribute *pkg_format_attrs[] = {
-	&format_attr_pkg_event.attr,
-	NULL,
-};
-static struct attribute_group pkg_format_attr_group = {
-	.name = "format",
-	.attrs = pkg_format_attrs,
-};
-
-static cpumask_t cstate_pkg_cpu_mask;
-
 static const struct attribute_group *pkg_attr_groups[] = {
 	&pkg_events_attr_group,
-	&pkg_format_attr_group,
+	&format_attr_group,
 	&cpumask_attr_group,
 	NULL,
 };
 
-static ssize_t cstate_get_attr_cpumask(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct pmu *pmu = dev_get_drvdata(dev);
-
-	if (pmu == &cstate_core_pmu)
-		return cpumap_print_to_pagebuf(true, buf, &cstate_core_cpu_mask);
-	else if (pmu == &cstate_pkg_pmu)
-		return cpumap_print_to_pagebuf(true, buf, &cstate_pkg_cpu_mask);
-	else
-		return 0;
-}
-
 static int cstate_pmu_event_init(struct perf_event *event)
 {
+	const struct cpumask *cpu_mask;
 	u64 cfg = event->attr.config;
+	struct cstate_pmus *pmus;
 	int cpu;
 
+	pmus = container_of(event->pmu, struct cstate_pmus, pmu);
+	if (!pmus)
+		return -ENOENT;
+
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
@@ -292,26 +294,19 @@ static int cstate_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	if (event->pmu == &cstate_core_pmu) {
-		if (cfg >= PERF_CSTATE_CORE_EVENT_MAX)
-			return -EINVAL;
-		if (!core_msr[cfg].attr)
-			return -EINVAL;
-		event->hw.event_base = core_msr[cfg].msr;
-		cpu = cpumask_any_and(&cstate_core_cpu_mask,
-				      topology_sibling_cpumask(event->cpu));
-	} else if (event->pmu == &cstate_pkg_pmu) {
-		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
-			return -EINVAL;
-		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
-		if (!pkg_msr[cfg].attr)
-			return -EINVAL;
-		event->hw.event_base = pkg_msr[cfg].msr;
-		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
-				      topology_core_cpumask(event->cpu));
-	} else {
-		return -ENOENT;
-	}
+	if (cfg >= pmus->event_max)
+		return -EINVAL;
+
+	cfg = array_index_nospec((unsigned long)cfg, pmus->event_max);
+	if (!pmus->msrs[cfg].attr)
+		return -EINVAL;
+
+	event->hw.event_base = pmus->msrs[cfg].msr;
+
+	cpu_mask = get_domain_cpu_mask(event->cpu, &pmus->type);
+	if (!cpu_mask)
+		return -ENODEV;
+	cpu = cpumask_any_and(&pmus->cpu_mask, cpu_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -ENODEV;
@@ -375,85 +370,61 @@ static int cstate_pmu_event_add(struct perf_event *event, int mode)
  */
 static int cstate_cpu_exit(unsigned int cpu)
 {
+	const struct cpumask *cpu_mask;
+	struct cstate_pmus *pmus;
 	unsigned int target;
+	int i;
 
-	if (has_cstate_core &&
-	    cpumask_test_and_clear_cpu(cpu, &cstate_core_cpu_mask)) {
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!cstate_pmus[i])
+			continue;
 
-		target = cpumask_any_but(topology_sibling_cpumask(cpu), cpu);
-		/* Migrate events if there is a valid target */
-		if (target < nr_cpu_ids) {
-			cpumask_set_cpu(target, &cstate_core_cpu_mask);
-			perf_pmu_migrate_context(&cstate_core_pmu, cpu, target);
-		}
-	}
+		cpu_mask = get_domain_cpu_mask(cpu, &cstate_pmus[i]->type);
+		if (!cpu_mask)
+			continue;
 
-	if (has_cstate_pkg &&
-	    cpumask_test_and_clear_cpu(cpu, &cstate_pkg_cpu_mask)) {
+		pmus = cstate_pmus[i];
+		if (!cpumask_test_and_clear_cpu(cpu, &pmus->cpu_mask))
+			continue;
 
-		target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+		target = cpumask_any_but(cpu_mask, cpu);
 		/* Migrate events if there is a valid target */
 		if (target < nr_cpu_ids) {
-			cpumask_set_cpu(target, &cstate_pkg_cpu_mask);
-			perf_pmu_migrate_context(&cstate_pkg_pmu, cpu, target);
+			cpumask_set_cpu(target, &pmus->cpu_mask);
+			perf_pmu_migrate_context(&pmus->pmu, cpu, target);
 		}
 	}
+
 	return 0;
 }
 
 static int cstate_cpu_init(unsigned int cpu)
 {
+	const struct cpumask *cpu_mask;
+	struct cstate_pmus *pmus;
 	unsigned int target;
+	int i;
 
-	/*
-	 * If this is the first online thread of that core, set it in
-	 * the core cpu mask as the designated reader.
-	 */
-	target = cpumask_any_and(&cstate_core_cpu_mask,
-				 topology_sibling_cpumask(cpu));
-
-	if (has_cstate_core && target >= nr_cpu_ids)
-		cpumask_set_cpu(cpu, &cstate_core_cpu_mask);
-
-	/*
-	 * If this is the first online thread of that package, set it
-	 * in the package cpu mask as the designated reader.
-	 */
-	target = cpumask_any_and(&cstate_pkg_cpu_mask,
-				 topology_core_cpumask(cpu));
-	if (has_cstate_pkg && target >= nr_cpu_ids)
-		cpumask_set_cpu(cpu, &cstate_pkg_cpu_mask);
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!cstate_pmus[i])
+			continue;
 
-	return 0;
-}
+		cpu_mask = get_domain_cpu_mask(cpu, &cstate_pmus[i]->type);
+		if (!cpu_mask)
+			continue;
 
-static struct pmu cstate_core_pmu = {
-	.attr_groups	= core_attr_groups,
-	.name		= "cstate_core",
-	.task_ctx_nr	= perf_invalid_context,
-	.event_init	= cstate_pmu_event_init,
-	.add		= cstate_pmu_event_add,
-	.del		= cstate_pmu_event_del,
-	.start		= cstate_pmu_event_start,
-	.stop		= cstate_pmu_event_stop,
-	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
-	.module		= THIS_MODULE,
-};
+		pmus = cstate_pmus[i];
+		/*
+		 * If this is the first online thread of that core, set it in
+		 * the core cpu mask as the designated reader.
+		 */
+		target = cpumask_any_and(&pmus->cpu_mask, cpu_mask);
 
-static struct pmu cstate_pkg_pmu = {
-	.attr_groups	= pkg_attr_groups,
-	.name		= "cstate_pkg",
-	.task_ctx_nr	= perf_invalid_context,
-	.event_init	= cstate_pmu_event_init,
-	.add		= cstate_pmu_event_add,
-	.del		= cstate_pmu_event_del,
-	.start		= cstate_pmu_event_start,
-	.stop		= cstate_pmu_event_stop,
-	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
-	.module		= THIS_MODULE,
-};
+		if (target >= nr_cpu_ids)
+			cpumask_set_cpu(cpu, &pmus->cpu_mask);
+	}
+	return 0;
+}
 
 static const struct cstate_model nhm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C3_RES) |
@@ -592,14 +563,28 @@ MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
  * Probe the cstate events and insert the available one into sysfs attrs
  * Return false if there are no available events.
  */
-static bool __init cstate_probe_msr(const unsigned long evmsk, int max,
-                                   struct perf_cstate_msr *msr,
-                                   struct attribute **attrs)
+static bool __init cstate_probe_msr(const unsigned long evmsk,
+				    enum domain_types type)
 {
+	struct perf_cstate_msr *msr;
+	struct attribute **attrs;
+	struct cstate_pmus *pmus;
 	bool found = false;
 	unsigned int bit;
+	int max;
 	u64 val;
 
+	if (type == PACKAGE_DOMAIN) {
+		max = PERF_CSTATE_PKG_EVENT_MAX;
+		msr = pkg_msr;
+		attrs = pkg_events_attrs;
+	} else if (type == CORE_DOMAIN) {
+		max = PERF_CSTATE_CORE_EVENT_MAX;
+		msr = core_msr;
+		attrs = core_events_attrs;
+	} else
+		return false;
+
 	for (bit = 0; bit < max; bit++) {
 		if (test_bit(bit, &evmsk) && !rdmsrl_safe(msr[bit].msr, &val)) {
 			*attrs++ = &msr[bit].attr->attr.attr;
@@ -610,11 +595,32 @@ static bool __init cstate_probe_msr(const unsigned long evmsk, int max,
 	}
 	*attrs = NULL;
 
-	return found;
+	if (!found)
+		return false;
+
+	pmus = kzalloc(sizeof(struct cstate_pmus), GFP_KERNEL);
+	if (!pmus)
+		return false;
+
+	pmus->type.type = type;
+	if (domain_type_init(&pmus->type)) {
+		kfree(pmus);
+		return false;
+	}
+	pmus->event_max = max;
+	pmus->msrs = msr;
+	pmus->attrs = attrs;
+
+	cstate_pmus[type] = pmus;
+
+	return true;
 }
 
 static int __init cstate_probe(const struct cstate_model *cm)
 {
+	bool found = false;
+	enum domain_types i;
+
 	/* SLM has different MSR for PKG C6 */
 	if (cm->quirks & SLM_PKG_C6_USE_C7_MSR)
 		pkg_msr[PERF_CSTATE_PKG_C6_RES].msr = MSR_PKG_C7_RESIDENCY;
@@ -624,58 +630,79 @@ static int __init cstate_probe(const struct cstate_model *cm)
 		pkg_msr[PERF_CSTATE_CORE_C6_RES].msr = MSR_KNL_CORE_C6_RESIDENCY;
 
 
-	has_cstate_core = cstate_probe_msr(cm->core_events,
-					   PERF_CSTATE_CORE_EVENT_MAX,
-					   core_msr, core_events_attrs);
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!cm->events[i])
+			continue;
 
-	has_cstate_pkg = cstate_probe_msr(cm->pkg_events,
-					  PERF_CSTATE_PKG_EVENT_MAX,
-					  pkg_msr, pkg_events_attrs);
-
-	return (has_cstate_core || has_cstate_pkg) ? 0 : -ENODEV;
+		if (cstate_probe_msr(cm->events[i], i))
+			found = true;
+	}
+	return found ? 0 : -ENODEV;
 }
 
 static inline void cstate_cleanup(void)
 {
+	int i;
+
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_CSTATE_ONLINE);
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_CSTATE_STARTING);
 
-	if (has_cstate_core)
-		perf_pmu_unregister(&cstate_core_pmu);
-
-	if (has_cstate_pkg)
-		perf_pmu_unregister(&cstate_pkg_pmu);
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!cstate_pmus[i])
+			continue;
+		perf_pmu_unregister(&cstate_pmus[i]->pmu);
+		kfree(cstate_pmus[i]);
+		cstate_pmus[i] = NULL;
+	}
 }
 
 static int __init cstate_init(void)
 {
-	int err;
+	struct pmu *pmu;
+	char name[DOMAIN_NAME_LEN];
+	int i, err = 0;
 
 	cpuhp_setup_state(CPUHP_AP_PERF_X86_CSTATE_STARTING,
 			  "perf/x86/cstate:starting", cstate_cpu_init, NULL);
 	cpuhp_setup_state(CPUHP_AP_PERF_X86_CSTATE_ONLINE,
 			  "perf/x86/cstate:online", NULL, cstate_cpu_exit);
 
-	if (has_cstate_core) {
-		err = perf_pmu_register(&cstate_core_pmu, cstate_core_pmu.name, -1);
-		if (err) {
-			has_cstate_core = false;
-			pr_info("Failed to register cstate core pmu\n");
-			cstate_cleanup();
-			return err;
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!cstate_pmus[i])
+			continue;
+		pmu = &cstate_pmus[i]->pmu;
+
+		if (i == PACKAGE_DOMAIN)
+			pmu->attr_groups = pkg_attr_groups;
+		else if (i == CORE_DOMAIN)
+			pmu->attr_groups = core_attr_groups;
+
+		pmu->task_ctx_nr = perf_invalid_context;
+		pmu->event_init = cstate_pmu_event_init;
+		pmu->add = cstate_pmu_event_add;
+		pmu->del = cstate_pmu_event_del;
+		pmu->start = cstate_pmu_event_start;
+		pmu->stop = cstate_pmu_event_stop;
+		pmu->read = cstate_pmu_event_update;
+		pmu->capabilities = PERF_PMU_CAP_NO_INTERRUPT;
+		pmu->module = THIS_MODULE;
+
+		err = snprintf(name, DOMAIN_NAME_LEN, "cstate_%s",
+			       cstate_pmus[i]->type.postfix);
+		if (err < 0) {
+			kfree(cstate_pmus[i]);
+			cstate_pmus[i] = NULL;
+			continue;
 		}
-	}
-
-	if (has_cstate_pkg) {
-		err = perf_pmu_register(&cstate_pkg_pmu, cstate_pkg_pmu.name, -1);
+		err = perf_pmu_register(pmu, name, -1);
 		if (err) {
-			has_cstate_pkg = false;
-			pr_info("Failed to register cstate pkg pmu\n");
-			cstate_cleanup();
-			return err;
+			kfree(cstate_pmus[i]);
+			cstate_pmus[i] = NULL;
+			pr_info("Failed to register %s pmu\n", name);
 		}
 	}
-	return 0;
+
+	return err;
 }
 
 static int __init cstate_pmu_init(void)
-- 
2.7.4

