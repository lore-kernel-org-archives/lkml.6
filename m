Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22C421738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfBSUBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:8744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbfBSUA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:00:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918077"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:00:59 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 04/10] perf/x86/intel/rapl: Apply "domain" for RAPL
Date:   Tue, 19 Feb 2019 12:00:05 -0800
Message-Id: <1550606411-5313-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The RAPL counters are not package scope only anymore. For example, there
will be die scope RAPL counters on CLX-AP.
Apply "domain" for RAPL, and make it easy to be extended later.

Each type of domain needs a dedicated rapl_pmus. The struct rapl_pmus is
modified accordingly.
 - The fixed counters may be different among different domain types.
   Move rapl_cntr_mask to struct rapl_pmus.
 - The CPU mask may be different among different domain types as well.
   Move rapl_cpu_mask to struct rapl_pmus. Also update
   rapl_cpu_online/offline accordingly.
 - Replace maxpkg by the number of domain

Rename rapl_pmu_events_group to rapl_pkg_pmu_events_group for domains of
PACKAGE_DOMAIN type.

Added PMU name in rapl_advertise() to distinguish between different type
of domain.

Extend intel_rapl_init_fun to support events from different type of
domain.

If there are more than two types of domain on a machine, using new PMU
name, "power_$domain_type", otherwise, still use "power".

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/rapl.c | 306 +++++++++++++++++++++++++++++++------------
 1 file changed, 224 insertions(+), 82 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 91039ff..c1ba09c 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -57,6 +57,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
+#include "../domain.h"
 
 MODULE_LICENSE("GPL");
 
@@ -148,26 +149,31 @@ struct rapl_pmu {
 
 struct rapl_pmus {
 	struct pmu		pmu;
-	unsigned int		maxpkg;
+	struct domain_type	type;
+	unsigned int		rapl_cntr_mask;
+	cpumask_t		rapl_cpu_mask;
 	struct rapl_pmu		*pmus[];
 };
 
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
-static struct rapl_pmus *rapl_pmus;
-static cpumask_t rapl_cpu_mask;
-static unsigned int rapl_cntr_mask;
+static struct rapl_pmus *rapl_pmus[DOMAIN_TYPE_MAX];
 static u64 rapl_timer_ms;
+static unsigned int rapl_domain_type_mask;
 
-static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
+static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu,
+					       struct rapl_pmus *pmus)
 {
-	unsigned int pkgid = topology_logical_package_id(cpu);
+	unsigned int id = get_domain_id(cpu, &pmus->type);
+
+	if (!pmus)
+		return NULL;
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return pkgid < rapl_pmus->maxpkg ? rapl_pmus->pmus[pkgid] : NULL;
+	return id < pmus->type.max_domains ? pmus->pmus[id] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -350,10 +356,15 @@ static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, msr, ret = 0;
+	struct rapl_pmus *pmus;
 	struct rapl_pmu *pmu;
 
+	pmus = container_of(event->pmu, struct rapl_pmus, pmu);
+	if (!pmus)
+		return -ENOENT;
+
 	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus->pmu.type)
+	if (event->attr.type != pmus->pmu.type)
 		return -ENOENT;
 
 	/* check only supported bits are set */
@@ -393,7 +404,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 	/* check event supported */
-	if (!(rapl_cntr_mask & (1 << bit)))
+	if (!(pmus->rapl_cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -407,7 +418,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	pmu = cpu_to_rapl_pmu(event->cpu);
+	pmu = cpu_to_rapl_pmu(event->cpu, pmus);
 	if (!pmu)
 		return -EINVAL;
 	event->cpu = pmu->cpu;
@@ -425,9 +436,21 @@ static void rapl_pmu_event_read(struct perf_event *event)
 }
 
 static ssize_t rapl_get_attr_cpumask(struct device *dev,
-				struct device_attribute *attr, char *buf)
+					 struct device_attribute *attr,
+					 char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &rapl_cpu_mask);
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct rapl_pmus *pmus;
+	int i;
+
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		pmus = rapl_pmus[i];
+		if (!pmus || &pmus->pmu != pmu)
+			continue;
+
+		return cpumap_print_to_pagebuf(true, buf, &pmus->rapl_cpu_mask);
+	}
+	return 0;
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
@@ -543,7 +566,7 @@ static struct attribute *rapl_events_knl_attr[] = {
 	NULL,
 };
 
-static struct attribute_group rapl_pmu_events_group = {
+static struct attribute_group rapl_pkg_pmu_events_group = {
 	.name = "events",
 	.attrs = NULL, /* patched at runtime */
 };
@@ -559,39 +582,63 @@ static struct attribute_group rapl_pmu_format_group = {
 	.attrs = rapl_formats_attr,
 };
 
-static const struct attribute_group *rapl_attr_groups[] = {
+static const struct attribute_group *rapl_pkg_attr_groups[] = {
 	&rapl_pmu_attr_group,
 	&rapl_pmu_format_group,
-	&rapl_pmu_events_group,
+	&rapl_pkg_pmu_events_group,
 	NULL,
 };
 
-static int rapl_cpu_offline(unsigned int cpu)
+static int __rapl_cpu_offline(unsigned int cpu, struct rapl_pmus *pmus)
 {
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
+	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu, pmus);
+	const struct cpumask *cpu_mask;
 	int target;
 
+	if (!pmus)
+		return -1;
+
 	/* Check if exiting cpu is used for collecting rapl events */
-	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
+	if (!cpumask_test_and_clear_cpu(cpu, &pmus->rapl_cpu_mask))
 		return 0;
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	cpu_mask = get_domain_cpu_mask(cpu, &pmus->type);
+	if (!cpu_mask)
+		return -1;
+	target = cpumask_any_but(cpu_mask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
-		cpumask_set_cpu(target, &rapl_cpu_mask);
+		cpumask_set_cpu(target, &pmus->rapl_cpu_mask);
 		pmu->cpu = target;
 		perf_pmu_migrate_context(pmu->pmu, cpu, target);
 	}
 	return 0;
 }
 
-static int rapl_cpu_online(unsigned int cpu)
+static int rapl_cpu_offline(unsigned int cpu)
 {
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
-	int target;
+	int i;
+
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!rapl_pmus[i])
+			continue;
+
+		__rapl_cpu_offline(cpu, rapl_pmus[i]);
+	}
+	return 0;
+}
+
+static int __rapl_cpu_online(unsigned int cpu, struct rapl_pmus *pmus)
+{
+	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu, pmus);
+	const struct cpumask *cpu_mask;
+	int target, id;
+
+	if (!pmus)
+		return -EINVAL;
 
 	if (!pmu) {
 		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
@@ -600,26 +647,47 @@ static int rapl_cpu_online(unsigned int cpu)
 
 		raw_spin_lock_init(&pmu->lock);
 		INIT_LIST_HEAD(&pmu->active_list);
-		pmu->pmu = &rapl_pmus->pmu;
+		pmu->pmu = &pmus->pmu;
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_package_id(cpu)] = pmu;
+		id = get_domain_id(cpu, &pmus->type);
+		if (id < 0) {
+			kfree(pmu);
+			return -EINVAL;
+		}
+		pmus->pmus[id] = pmu;
 	}
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_core_cpumask(cpu));
+	cpu_mask = get_domain_cpu_mask(cpu, &pmus->type);
+	if (!cpu_mask)
+		return -1;
+	target = cpumask_any_and(&pmus->rapl_cpu_mask, cpu_mask);
 	if (target < nr_cpu_ids)
 		return 0;
 
-	cpumask_set_cpu(cpu, &rapl_cpu_mask);
+	cpumask_set_cpu(cpu, &pmus->rapl_cpu_mask);
 	pmu->cpu = cpu;
 	return 0;
 }
 
+static int rapl_cpu_online(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!rapl_pmus[i])
+			continue;
+
+		__rapl_cpu_online(cpu, rapl_pmus[i]);
+	}
+	return 0;
+}
+
 static int rapl_check_hw_unit(bool apply_quirk)
 {
 	u64 msr_rapl_power_unit_bits;
@@ -657,94 +725,163 @@ static int rapl_check_hw_unit(bool apply_quirk)
 
 static void __init rapl_advertise(void)
 {
-	int i;
-
-	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_cntr_mask), rapl_timer_ms);
-
-	for (i = 0; i < NR_RAPL_DOMAINS; i++) {
-		if (rapl_cntr_mask & (1 << i)) {
-			pr_info("hw unit of domain %s 2^-%d Joules\n",
-				rapl_domain_names[i], rapl_hw_unit[i]);
+	int i, j;
+
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!rapl_pmus[i])
+			continue;
+
+		pr_info("%s: API unit is 2^-32 Joules, "
+			"%d fixed counters, %llu ms ovfl timer\n",
+			rapl_pmus[i]->pmu.name,
+			hweight32(rapl_pmus[i]->rapl_cntr_mask),
+			rapl_timer_ms);
+
+		for (j = 0; j < NR_RAPL_DOMAINS; j++) {
+			if (rapl_pmus[i]->rapl_cntr_mask & (1 << j)) {
+				pr_info("hw unit of domain %s 2^-%d Joules\n",
+					rapl_domain_names[j], rapl_hw_unit[j]);
+			}
 		}
 	}
 }
 
 static void cleanup_rapl_pmus(void)
 {
-	int i;
-
-	for (i = 0; i < rapl_pmus->maxpkg; i++)
-		kfree(rapl_pmus->pmus[i]);
-	kfree(rapl_pmus);
+	int i, j;
+
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!rapl_pmus[i])
+			continue;
+		for (j = 0; j < rapl_pmus[i]->type.max_domains; j++)
+			kfree(rapl_pmus[i]->pmus[j]);
+		kfree(rapl_pmus[i]);
+		rapl_pmus[i] = NULL;
+	}
 }
 
-static int __init init_rapl_pmus(void)
+struct intel_rapl_events {
+	int cntr_mask;
+	struct attribute **attrs;
+};
+
+struct intel_rapl_init_fun {
+	bool apply_quirk;
+	const struct intel_rapl_events events[DOMAIN_TYPE_MAX];
+};
+
+static int __init init_rapl_pmus(const struct intel_rapl_events *events,
+				 enum domain_types type)
 {
-	int maxpkg = topology_max_packages();
+	struct domain_type domain_type;
+	struct rapl_pmus *pmus;
 	size_t size;
 
-	size = sizeof(*rapl_pmus) + maxpkg * sizeof(struct rapl_pmu *);
-	rapl_pmus = kzalloc(size, GFP_KERNEL);
-	if (!rapl_pmus)
+	domain_type.type = type;
+	if (domain_type_init(&domain_type))
+		return -ENODEV;
+
+	size = sizeof(struct rapl_pmus) + domain_type.max_domains * sizeof(struct rapl_pmu *);
+	pmus = kzalloc(size, GFP_KERNEL);
+	if (!pmus)
 		return -ENOMEM;
 
-	rapl_pmus->maxpkg		= maxpkg;
-	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
-	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;
-	rapl_pmus->pmu.event_init	= rapl_pmu_event_init;
-	rapl_pmus->pmu.add		= rapl_pmu_event_add;
-	rapl_pmus->pmu.del		= rapl_pmu_event_del;
-	rapl_pmus->pmu.start		= rapl_pmu_event_start;
-	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
-	rapl_pmus->pmu.read		= rapl_pmu_event_read;
-	rapl_pmus->pmu.module		= THIS_MODULE;
+	memcpy(&pmus->type, &domain_type, sizeof(struct domain_type));
+	pmus->rapl_cntr_mask = events->cntr_mask;
+	if (type == PACKAGE_DOMAIN) {
+		rapl_pkg_pmu_events_group.attrs = events->attrs;
+		pmus->pmu.attr_groups = rapl_pkg_attr_groups;
+	}
+	pmus->pmu.task_ctx_nr = perf_invalid_context;
+	pmus->pmu.event_init = rapl_pmu_event_init;
+	pmus->pmu.add = rapl_pmu_event_add;
+	pmus->pmu.del = rapl_pmu_event_del;
+	pmus->pmu.start = rapl_pmu_event_start;
+	pmus->pmu.stop = rapl_pmu_event_stop;
+	pmus->pmu.read = rapl_pmu_event_read;
+	pmus->pmu.module = THIS_MODULE;
+
+	rapl_pmus[type] = pmus;
 	return 0;
 }
 
+static int __init rapl_pmus_register(void)
+{
+	bool registered = false;
+	char name[DOMAIN_NAME_LEN];
+	int i, ret;
+
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!rapl_pmus[i])
+			continue;
+
+		if (hweight32(rapl_domain_type_mask) > 1)
+			ret = snprintf(name, DOMAIN_NAME_LEN, "power_%s",
+				       rapl_pmus[i]->type.postfix);
+		else
+			ret = snprintf(name, DOMAIN_NAME_LEN, "power");
+		if (ret < 0)
+			continue;
+		ret = perf_pmu_register(&rapl_pmus[i]->pmu, name, -1);
+		if (ret) {
+			kfree(rapl_pmus[i]);
+			rapl_pmus[i] = NULL;
+			continue;
+		}
+		registered = true;
+	}
+
+	return registered ? 0 : -1;
+}
+
+static void rapl_pmus_unregister(void)
+{
+	int i;
+
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!rapl_pmus[i])
+			continue;
+		perf_pmu_unregister(&rapl_pmus[i]->pmu);
+	}
+}
+
 #define X86_RAPL_MODEL_MATCH(model, init)	\
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&init }
 
-struct intel_rapl_init_fun {
-	bool apply_quirk;
-	int cntr_mask;
-	struct attribute **attrs;
-};
-
 static const struct intel_rapl_init_fun snb_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_CLN,
-	.attrs = rapl_events_cln_attr,
+	.events[PACKAGE_DOMAIN].cntr_mask = RAPL_IDX_CLN,
+	.events[PACKAGE_DOMAIN].attrs = rapl_events_cln_attr,
 };
 
 static const struct intel_rapl_init_fun hsx_rapl_init __initconst = {
 	.apply_quirk = true,
-	.cntr_mask = RAPL_IDX_SRV,
-	.attrs = rapl_events_srv_attr,
+	.events[PACKAGE_DOMAIN].cntr_mask = RAPL_IDX_SRV,
+	.events[PACKAGE_DOMAIN].attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun hsw_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_HSW,
-	.attrs = rapl_events_hsw_attr,
+	.events[PACKAGE_DOMAIN].cntr_mask = RAPL_IDX_HSW,
+	.events[PACKAGE_DOMAIN].attrs = rapl_events_hsw_attr,
 };
 
 static const struct intel_rapl_init_fun snbep_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_SRV,
-	.attrs = rapl_events_srv_attr,
+	.events[PACKAGE_DOMAIN].cntr_mask = RAPL_IDX_SRV,
+	.events[PACKAGE_DOMAIN].attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun knl_rapl_init __initconst = {
 	.apply_quirk = true,
-	.cntr_mask = RAPL_IDX_KNL,
-	.attrs = rapl_events_knl_attr,
+	.events[PACKAGE_DOMAIN].cntr_mask = RAPL_IDX_KNL,
+	.events[PACKAGE_DOMAIN].attrs = rapl_events_knl_attr,
 };
 
 static const struct intel_rapl_init_fun skl_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_SKL_CLN,
-	.attrs = rapl_events_skl_attr,
+	.events[PACKAGE_DOMAIN].cntr_mask = RAPL_IDX_SKL_CLN,
+	.events[PACKAGE_DOMAIN].attrs = rapl_events_skl_attr,
 };
 
 static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
@@ -790,7 +927,7 @@ static int __init rapl_pmu_init(void)
 	const struct x86_cpu_id *id;
 	struct intel_rapl_init_fun *rapl_init;
 	bool apply_quirk;
-	int ret;
+	int i, ret;
 
 	id = x86_match_cpu(rapl_cpu_match);
 	if (!id)
@@ -798,16 +935,21 @@ static int __init rapl_pmu_init(void)
 
 	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
 	apply_quirk = rapl_init->apply_quirk;
-	rapl_cntr_mask = rapl_init->cntr_mask;
-	rapl_pmu_events_group.attrs = rapl_init->attrs;
 
 	ret = rapl_check_hw_unit(apply_quirk);
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus();
-	if (ret)
-		return ret;
+	for (i = 0; i < DOMAIN_TYPE_MAX; i++) {
+		if (!rapl_init->events[i].cntr_mask)
+			continue;
+		ret = init_rapl_pmus(&rapl_init->events[i], i);
+		if (ret)
+			continue;
+		rapl_domain_type_mask |= (1 << i);
+	}
+	if (hweight32(rapl_domain_type_mask) == 0)
+		return -ENODEV;
 
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
@@ -818,7 +960,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		goto out;
 
-	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
+	ret = rapl_pmus_register();
 	if (ret)
 		goto out1;
 
@@ -837,7 +979,7 @@ module_init(rapl_pmu_init);
 static void __exit intel_rapl_exit(void)
 {
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
-	perf_pmu_unregister(&rapl_pmus->pmu);
+	rapl_pmus_unregister();
 	cleanup_rapl_pmus();
 }
 module_exit(intel_rapl_exit);
-- 
2.7.4

