Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeFETIm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:08:42 -0400
Received: from foss.arm.com ([217.140.101.70]:60452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbeFETIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:08:40 -0400
From: Jeremy Linton <jeremy.linton@arm.com>
To: Sudeep.Holla@arm.com
Cc: Will.Deacon@arm.com, Catalin.Marinas@arm.com, Robin.Murphy@arm.com,
        Morten.Rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-acpi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] arm64: topology: Avoid checking numa mask for scheduler MC selection
Date: Tue,  5 Jun 2018 14:08:37 -0500
Message-Id: <20180605190837.493505-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numa mask subset check has problems if !CONFIG_NUMA, over hotplug
operations or during early boot. Lets disable the NUMA siblings checks
for the time being, as NUMA in socket machines have LLC's that will
assure that the scheduler topology isn't "borken".

Futher, as a defensive mechanism during hotplug, lets assure that the
LLC siblings are also masked.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/topology.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 7415c166281f..f845a8617812 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -215,13 +215,8 @@ EXPORT_SYMBOL_GPL(cpu_topology);
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
-	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
+	const cpumask_t *core_mask = &cpu_topology[cpu].core_sibling;
 
-	/* Find the smaller of NUMA, core or LLC siblings */
-	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
-		/* not numa in package, lets use the package siblings */
-		core_mask = &cpu_topology[cpu].core_sibling;
-	}
 	if (cpu_topology[cpu].llc_id != -1) {
 		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
 			core_mask = &cpu_topology[cpu].llc_siblings;
@@ -239,8 +234,10 @@ static void update_siblings_masks(unsigned int cpuid)
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->llc_id == cpu_topo->llc_id)
+		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
 			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
+			cpumask_set_cpu(cpuid, &cpu_topo->llc_siblings);
+		}
 
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
-- 
2.14.3
