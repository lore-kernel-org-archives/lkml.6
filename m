Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeFEOfN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:35:13 -0400
Received: from foss.arm.com ([217.140.101.70]:56730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbeFEOfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:35:12 -0400
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/3] Revert "arm64: topology: divorce MC scheduling domain from core_siblings"
Date: Tue,  5 Jun 2018 15:35:02 +0100
Message-Id: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 37c3ec2d810f87eac73822f76b30391a83bded19.

Currently on ARM64 platforms, we don't update the CPU topology masks
on each hotplug operation. However, the updates to cpu_coregroup_mask
done as part of ACPI PPTT support, in particular the commit being
reverted makes use of cpumask_of_node which returns the cpu_oneline_mask
instead of core_sibling as core_sibling masks are not updated for CPU
hotplug operations and the comparision to find NUMA in package or LLC
siblings fails.

This often leads to system hang or crash during CPU hotplug and system
suspend operation. This is mostly observed on HMP systems where the
CPU compute capacities are different and ends up in different scheduler
domains. Since cpumask_of_node is returned instead core_sibling, the
scheduler is confused with incorrect cpumasks(e.g. one CPU in two
different sched domains at the same time) on CPU hotplug.

The original commit is technically correct and since it depends on the
not yet supported feature, let's revert this for now. We can put it back
once we have the support for CPU topology masks update on hotplug merged.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/topology.h |  2 --
 arch/arm64/kernel/topology.c      | 36 +-----------------------------------
 2 files changed, 1 insertion(+), 37 deletions(-)

v1->v2:
	- Updated commit log to describe the observations made as a
	  consequence of the issue as suggested by Geert's

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index df48212f767b..6b10459e6905 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -8,10 +8,8 @@ struct cpu_topology {
 	int thread_id;
 	int core_id;
 	int package_id;
-	int llc_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
-	cpumask_t llc_siblings;
 };
 
 extern struct cpu_topology cpu_topology[NR_CPUS];
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 7415c166281f..047d98e68502 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -13,7 +13,6 @@
 
 #include <linux/acpi.h>
 #include <linux/arch_topology.h>
-#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
@@ -215,19 +214,7 @@ EXPORT_SYMBOL_GPL(cpu_topology);
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
-	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
-
-	/* Find the smaller of NUMA, core or LLC siblings */
-	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
-		/* not numa in package, lets use the package siblings */
-		core_mask = &cpu_topology[cpu].core_sibling;
-	}
-	if (cpu_topology[cpu].llc_id != -1) {
-		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
-			core_mask = &cpu_topology[cpu].llc_siblings;
-	}
-
-	return core_mask;
+	return &cpu_topology[cpu].core_sibling;
 }
 
 static void update_siblings_masks(unsigned int cpuid)
@@ -239,9 +226,6 @@ static void update_siblings_masks(unsigned int cpuid)
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->llc_id == cpu_topo->llc_id)
-			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
-
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
@@ -307,10 +291,6 @@ static void __init reset_cpu_topology(void)
 		cpu_topo->core_id = 0;
 		cpu_topo->package_id = -1;
 
-		cpu_topo->llc_id = -1;
-		cpumask_clear(&cpu_topo->llc_siblings);
-		cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
-
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
 		cpumask_clear(&cpu_topo->thread_sibling);
@@ -331,8 +311,6 @@ static int __init parse_acpi_topology(void)
 	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
 
 	for_each_possible_cpu(cpu) {
-		int i, cache_id;
-
 		topology_id = find_acpi_cpu_topology(cpu, 0);
 		if (topology_id < 0)
 			return topology_id;
@@ -347,18 +325,6 @@ static int __init parse_acpi_topology(void)
 		}
 		topology_id = find_acpi_cpu_topology_package(cpu);
 		cpu_topology[cpu].package_id = topology_id;
-
-		i = acpi_find_last_cache_level(cpu);
-
-		if (i > 0) {
-			/*
-			 * this is the only part of cpu_topology that has
-			 * a direct relationship with the cache topology
-			 */
-			cache_id = find_acpi_cpu_cache_topology(cpu, i);
-			if (cache_id > 0)
-				cpu_topology[cpu].llc_id = cache_id;
-		}
 	}
 
 	return 0;
-- 
2.7.4
