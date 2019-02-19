Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0A821738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfBSUBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:8744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbfBSUA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918071"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:00:58 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 03/10] perf/x86/intel/uncore: Apply "domain" for uncore
Date:   Tue, 19 Feb 2019 12:00:04 -0800
Message-Id: <1550606411-5313-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The uncore counters are not package scope only anymore. For example,
there will be die scope counters on CLX-AP.
Apply "domain" for uncore, and make it easy to be extended later.

Add domain_type in intel_uncore_type to indicate the domain type of
uncore counters. The default is package scope domain.

Rename pkgid to domain_id for uncore box. Use domain ID to replace the
package ID.

Each type of domain has its own uncore_cpu_mask. Update
uncore_event_cpu_online/offline to apply per-domain uncore_cpu_mask.

Replace max_packages by the number of domains.

If there are more than two types of domain, using a new PMU name,
"uncore_$domain_type_$other_postfix".
Use DOMAIN_NAME_LEN to replace UNCORE_PMU_NAME_LEN.
Use more secure snprintf to replace sprintf

The uncore_extra_pci_dev is a filter register or capability register.
It is not uncore counter. It is not used on Skylake server ,and probably
not used on future platforms. The patch doesn't apply the "domain"
concept to uncore_extra_pci_dev. But it can be done later if needed.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c       | 233 ++++++++++++++++++++++++-----------
 arch/x86/events/intel/uncore.h       |   9 +-
 arch/x86/events/intel/uncore_snbep.c |   2 +-
 3 files changed, 164 insertions(+), 80 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 27a4614..f795a73 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -14,10 +14,11 @@ struct pci_driver *uncore_pci_driver;
 DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
 struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
 struct pci_extra_dev *uncore_extra_pci_dev;
-static int max_packages;
 
 /* mask of cpus that collect uncore events */
-static cpumask_t uncore_cpu_mask;
+static cpumask_t uncore_cpu_mask[DOMAIN_TYPE_MAX];
+
+static unsigned int uncore_domain_type_mask;
 
 /* constraint for the fixed counter */
 static struct event_constraint uncore_constraint_fixed =
@@ -100,13 +101,14 @@ ssize_t uncore_event_show(struct kobject *kobj,
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
 {
-	unsigned int pkgid = topology_logical_package_id(cpu);
+	unsigned int id = get_domain_id(cpu, &pmu->type->type);
+	int max = pmu->type->type.max_domains;
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return pkgid < max_packages ? pmu->boxes[pkgid] : NULL;
+	return id < max ? pmu->boxes[id] : NULL;
 }
 
 u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event)
@@ -311,7 +313,7 @@ static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 	uncore_pmu_init_hrtimer(box);
 	box->cpu = -1;
 	box->pci_phys_id = -1;
-	box->pkgid = -1;
+	box->domain_id = -1;
 
 	/* set default hrtimer timeout */
 	box->hrtimer_duration = UNCORE_PMU_HRTIMER_INTERVAL;
@@ -771,7 +773,15 @@ static int uncore_pmu_event_init(struct perf_event *event)
 static ssize_t uncore_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &uncore_cpu_mask);
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct intel_uncore_pmu *uncore_pmu;
+
+	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
+	if (uncore_pmu && uncore_pmu->type)
+		return cpumap_print_to_pagebuf(true, buf,
+					       &uncore_cpu_mask[uncore_pmu->type->type.type]);
+
+	return 0;
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
@@ -787,6 +797,8 @@ static const struct attribute_group uncore_pmu_attr_group = {
 
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 {
+	size_t len;
+	char *name;
 	int ret;
 
 	if (!pmu->type->pmu) {
@@ -806,15 +818,26 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 		pmu->pmu.attr_groups = pmu->type->attr_groups;
 	}
 
+	len = DOMAIN_NAME_LEN;
+	name = pmu->name;
+	if (hweight32(uncore_domain_type_mask) > 1)
+		ret = snprintf(name, len, "uncore_%s", pmu->type->type.postfix);
+	else
+		ret = snprintf(name, len, "uncore");
+	if (ret < 0)
+		return ret;
+
+	len -= ret;
+	name += ret;
 	if (pmu->type->num_boxes == 1) {
 		if (strlen(pmu->type->name) > 0)
-			sprintf(pmu->name, "uncore_%s", pmu->type->name);
-		else
-			sprintf(pmu->name, "uncore");
+			ret = snprintf(name, len, "_%s", pmu->type->name);
 	} else {
-		sprintf(pmu->name, "uncore_%s_%d", pmu->type->name,
-			pmu->pmu_idx);
+		ret = snprintf(name, len, "_%s_%d", pmu->type->name,
+			       pmu->pmu_idx);
 	}
+	if (ret < 0)
+		return ret;
 
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
 	if (!ret)
@@ -832,10 +855,10 @@ static void uncore_pmu_unregister(struct intel_uncore_pmu *pmu)
 
 static void uncore_free_boxes(struct intel_uncore_pmu *pmu)
 {
-	int pkg;
+	int i, nr = pmu->type->type.max_domains;
 
-	for (pkg = 0; pkg < max_packages; pkg++)
-		kfree(pmu->boxes[pkg]);
+	for (i = 0; i < nr; i++)
+		kfree(pmu->boxes[i]);
 	kfree(pmu->boxes);
 }
 
@@ -866,13 +889,21 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 {
 	struct intel_uncore_pmu *pmus;
 	size_t size;
-	int i, j;
+	int i, j, nr;
 
 	pmus = kcalloc(type->num_boxes, sizeof(*pmus), GFP_KERNEL);
 	if (!pmus)
 		return -ENOMEM;
 
-	size = max_packages * sizeof(struct intel_uncore_box *);
+	if (domain_type_init(&type->type)) {
+		kfree(pmus);
+		return -ENOMEM;
+	}
+	nr = type->type.max_domains;
+	if (nr < 0)
+		return -EINVAL;
+
+	size = nr * sizeof(struct intel_uncore_box *);
 
 	for (i = 0; i < type->num_boxes; i++) {
 		pmus[i].func_id	= setid ? i : -1;
@@ -911,6 +942,8 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 
 	type->pmu_group = &uncore_pmu_attr_group;
 
+	uncore_domain_type_mask |= (1 << type->type.type);
+
 	return 0;
 
 err:
@@ -942,25 +975,28 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
 	struct intel_uncore_box *box;
-	int phys_id, pkg, ret;
+	int phys_id, pkg, domain, ret;
 
 	phys_id = uncore_pcibus_to_physid(pdev->bus);
 	if (phys_id < 0)
 		return -ENODEV;
 
-	pkg = topology_phys_to_logical_pkg(phys_id);
-	if (pkg < 0)
-		return -EINVAL;
-
 	if (UNCORE_PCI_DEV_TYPE(id->driver_data) == UNCORE_EXTRA_PCI_DEV) {
 		int idx = UNCORE_PCI_DEV_IDX(id->driver_data);
 
+		pkg = topology_phys_to_logical_pkg(phys_id);
+		if (pkg < 0)
+			return -EINVAL;
+
 		uncore_extra_pci_dev[pkg].dev[idx] = pdev;
 		pci_set_drvdata(pdev, NULL);
 		return 0;
 	}
 
 	type = uncore_pci_uncores[UNCORE_PCI_DEV_TYPE(id->driver_data)];
+	domain = get_domain_id_from_group_id(phys_id, &type->type);
+	if (domain < 0)
+		return -EINVAL;
 
 	/*
 	 * Some platforms, e.g.  Knights Landing, use a common PCI device ID
@@ -994,7 +1030,7 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	if (WARN_ON_ONCE(pmu->boxes[pkg] != NULL))
+	if (WARN_ON_ONCE(pmu->boxes[domain] != NULL))
 		return -EINVAL;
 
 	box = uncore_alloc_box(type, NUMA_NO_NODE);
@@ -1008,13 +1044,13 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	atomic_inc(&box->refcnt);
 	box->pci_phys_id = phys_id;
-	box->pkgid = pkg;
+	box->domain_id = domain;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
 	uncore_box_init(box);
 	pci_set_drvdata(pdev, box);
 
-	pmu->boxes[pkg] = box;
+	pmu->boxes[domain] = box;
 	if (atomic_inc_return(&pmu->activeboxes) > 1)
 		return 0;
 
@@ -1022,7 +1058,7 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	ret = uncore_pmu_register(pmu);
 	if (ret) {
 		pci_set_drvdata(pdev, NULL);
-		pmu->boxes[pkg] = NULL;
+		pmu->boxes[domain] = NULL;
 		uncore_box_exit(box);
 		kfree(box);
 	}
@@ -1055,7 +1091,7 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 		return;
 
 	pci_set_drvdata(pdev, NULL);
-	pmu->boxes[box->pkgid] = NULL;
+	pmu->boxes[box->domain_id] = NULL;
 	if (atomic_dec_return(&pmu->activeboxes) == 0)
 		uncore_pmu_unregister(pmu);
 	uncore_box_exit(box);
@@ -1067,7 +1103,7 @@ static int __init uncore_pci_init(void)
 	size_t size;
 	int ret;
 
-	size = max_packages * sizeof(struct pci_extra_dev);
+	size = topology_max_packages() * sizeof(struct pci_extra_dev);
 	uncore_extra_pci_dev = kzalloc(size, GFP_KERNEL);
 	if (!uncore_extra_pci_dev) {
 		ret = -ENOMEM;
@@ -1114,11 +1150,11 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 {
 	struct intel_uncore_pmu *pmu = type->pmus;
 	struct intel_uncore_box *box;
-	int i, pkg;
+	int i, id;
 
-	pkg = topology_logical_package_id(old_cpu < 0 ? new_cpu : old_cpu);
+	id = get_domain_id(old_cpu < 0 ? new_cpu : old_cpu, &type->type);
 	for (i = 0; i < type->num_boxes; i++, pmu++) {
-		box = pmu->boxes[pkg];
+		box = pmu->boxes[id];
 		if (!box)
 			continue;
 
@@ -1139,11 +1175,37 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 	}
 }
 
-static void uncore_change_context(struct intel_uncore_type **uncores,
-				  int old_cpu, int new_cpu)
+static void uncore_change_context_offline(struct intel_uncore_type **uncores,
+					  int cpu, int *target)
 {
-	for (; *uncores; uncores++)
-		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
+	const struct cpumask *cpu_mask;
+	struct intel_uncore_type *type;
+	enum domain_types id;
+
+	for (; *uncores; uncores++) {
+		type = *uncores;
+		id = type->type.type;
+
+		if (target[id] == nr_cpu_ids) {
+
+			/* Check if existing cpu is used for collecting uncore events */
+			if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask[id]))
+				continue;
+
+			cpu_mask = get_domain_cpu_mask(cpu, &type->type);
+			if (!cpu_mask)
+				continue;
+			/* Find a new cpu to collect uncore events */
+			target[id] = cpumask_any_but(cpu_mask, cpu);
+
+			/* Migrate uncore events to the new target */
+			if (target[id] < nr_cpu_ids)
+				cpumask_set_cpu(target[id], &uncore_cpu_mask[id]);
+			else
+				target[id] = -1;
+		}
+		uncore_change_type_ctx(type, cpu, target[id]);
+	}
 }
 
 static int uncore_event_cpu_offline(unsigned int cpu)
@@ -1151,31 +1213,19 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 	struct intel_uncore_type *type, **types = uncore_msr_uncores;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, pkg, target;
+	int i, id;
+	int target[DOMAIN_TYPE_MAX] = { [0 ... DOMAIN_TYPE_MAX - 1] = nr_cpu_ids };
 
-	/* Check if exiting cpu is used for collecting uncore events */
-	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
-		goto unref;
-	/* Find a new cpu to collect uncore events */
-	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	uncore_change_context_offline(uncore_msr_uncores, cpu, target);
+	uncore_change_context_offline(uncore_pci_uncores, cpu, target);
 
-	/* Migrate uncore events to the new target */
-	if (target < nr_cpu_ids)
-		cpumask_set_cpu(target, &uncore_cpu_mask);
-	else
-		target = -1;
-
-	uncore_change_context(uncore_msr_uncores, cpu, target);
-	uncore_change_context(uncore_pci_uncores, cpu, target);
-
-unref:
 	/* Clear the references */
-	pkg = topology_logical_package_id(cpu);
 	for (; *types; types++) {
 		type = *types;
 		pmu = type->pmus;
+		id = get_domain_id(cpu, &type->type);
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[pkg];
+			box = pmu->boxes[id];
 			if (box && atomic_dec_return(&box->refcnt) == 0)
 				uncore_box_exit(box);
 		}
@@ -1183,34 +1233,78 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
+static void uncore_change_context_online(struct intel_uncore_type **uncores,
+					 int cpu, int *target)
+{
+	const struct cpumask *cpu_mask;
+	struct intel_uncore_type *type;
+	enum domain_types id;
+
+	for (; *uncores; uncores++) {
+		type = *uncores;
+		id = type->type.type;
+
+		/*
+		 * Check if there is an online cpu in the domain
+		 * which collects uncore events already.
+		 * If yes, set target[id] = -1, other uncores from
+		 * the same domain will not re-check.
+		 * If no, set target[id] = cpu, update cpu_mask
+		 */
+		if (target[id] == nr_cpu_ids) {
+			cpu_mask = get_domain_cpu_mask(cpu, &type->type);
+			if (!cpu_mask)
+				continue;
+
+			target[id] = cpumask_any_and(&uncore_cpu_mask[id], cpu_mask);
+			if (target[id] < nr_cpu_ids) {
+				target[id] = -1;
+				continue;
+			}
+			target[id] = cpu;
+			cpumask_set_cpu(cpu, &uncore_cpu_mask[id]);
+		}
+
+		/*
+		 * There is an online cpu which collects
+		 * uncore events for the domain already.
+		 */
+		if (target[id] == -1)
+			continue;
+
+		uncore_change_type_ctx(type, -1, cpu);
+	}
+}
+
 static int allocate_boxes(struct intel_uncore_type **types,
-			 unsigned int pkg, unsigned int cpu)
+			  unsigned int cpu)
 {
 	struct intel_uncore_box *box, *tmp;
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
 	LIST_HEAD(allocated);
-	int i;
+	int i, id;
 
 	/* Try to allocate all required boxes */
 	for (; *types; types++) {
 		type = *types;
 		pmu = type->pmus;
+		id = get_domain_id(cpu, &type->type);
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			if (pmu->boxes[pkg])
+			if (pmu->boxes[id])
 				continue;
 			box = uncore_alloc_box(type, cpu_to_node(cpu));
 			if (!box)
 				goto cleanup;
 			box->pmu = pmu;
-			box->pkgid = pkg;
+			box->domain_id = id;
 			list_add(&box->active_list, &allocated);
 		}
 	}
 	/* Install them in the pmus */
 	list_for_each_entry_safe(box, tmp, &allocated, active_list) {
 		list_del_init(&box->active_list);
-		box->pmu->boxes[pkg] = box;
+		box->pmu->boxes[box->domain_id] = box;
 	}
 	return 0;
 
@@ -1227,35 +1321,26 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	struct intel_uncore_type *type, **types = uncore_msr_uncores;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, ret, pkg, target;
+	int i, ret, id;
+	int target[DOMAIN_TYPE_MAX] = { [0 ... DOMAIN_TYPE_MAX - 1] = nr_cpu_ids };
 
-	pkg = topology_logical_package_id(cpu);
-	ret = allocate_boxes(types, pkg, cpu);
+	ret = allocate_boxes(types, cpu);
 	if (ret)
 		return ret;
 
 	for (; *types; types++) {
 		type = *types;
 		pmu = type->pmus;
+		id = get_domain_id(cpu, &type->type);
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[pkg];
+			box = pmu->boxes[id];
 			if (box && atomic_inc_return(&box->refcnt) == 1)
 				uncore_box_init(box);
 		}
 	}
 
-	/*
-	 * Check if there is an online cpu in the package
-	 * which collects uncore events already.
-	 */
-	target = cpumask_any_and(&uncore_cpu_mask, topology_core_cpumask(cpu));
-	if (target < nr_cpu_ids)
-		return 0;
-
-	cpumask_set_cpu(cpu, &uncore_cpu_mask);
-
-	uncore_change_context(uncore_msr_uncores, -1, cpu);
-	uncore_change_context(uncore_pci_uncores, -1, cpu);
+	uncore_change_context_online(uncore_msr_uncores, cpu, target);
+	uncore_change_context_online(uncore_pci_uncores, cpu, target);
 	return 0;
 }
 
@@ -1417,8 +1502,6 @@ static int __init intel_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
-
 	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
 	if (uncore_init->pci_init) {
 		pret = uncore_init->pci_init();
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index cb46d60..3c06e1b 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -5,8 +5,8 @@
 
 #include <linux/perf_event.h>
 #include "../perf_event.h"
+#include "../domain.h"
 
-#define UNCORE_PMU_NAME_LEN		32
 #define UNCORE_PMU_HRTIMER_INTERVAL	(60LL * NSEC_PER_SEC)
 #define UNCORE_SNB_IMC_HRTIMER_INTERVAL (5ULL * NSEC_PER_SEC)
 
@@ -44,6 +44,7 @@ struct freerunning_counters;
 
 struct intel_uncore_type {
 	const char *name;
+	struct domain_type type;
 	int num_counters;
 	int num_boxes;
 	int perf_ctr_bits;
@@ -91,7 +92,7 @@ struct intel_uncore_ops {
 
 struct intel_uncore_pmu {
 	struct pmu			pmu;
-	char				name[UNCORE_PMU_NAME_LEN];
+	char				name[DOMAIN_NAME_LEN];
 	int				pmu_idx;
 	int				func_id;
 	bool				registered;
@@ -108,7 +109,7 @@ struct intel_uncore_extra_reg {
 
 struct intel_uncore_box {
 	int pci_phys_id;
-	int pkgid;	/* Logical package ID */
+	int domain_id;
 	int n_active;	/* number of active events */
 	int n_events;
 	int cpu;	/* cpu to collect events */
@@ -467,7 +468,7 @@ static inline void uncore_box_exit(struct intel_uncore_box *box)
 
 static inline bool uncore_box_is_fake(struct intel_uncore_box *box)
 {
-	return (box->pkgid < 0);
+	return (box->domain_id < 0);
 }
 
 static inline struct intel_uncore_pmu *uncore_event_to_pmu(struct perf_event *event)
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b10e043..ba416b8 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1058,7 +1058,7 @@ static void snbep_qpi_enable_event(struct intel_uncore_box *box, struct perf_eve
 
 	if (reg1->idx != EXTRA_REG_NONE) {
 		int idx = box->pmu->pmu_idx + SNBEP_PCI_QPI_PORT0_FILTER;
-		int pkg = box->pkgid;
+		int pkg = box->domain_id;
 		struct pci_dev *filter_pdev = uncore_extra_pci_dev[pkg].dev[idx];
 
 		if (filter_pdev) {
-- 
2.7.4

