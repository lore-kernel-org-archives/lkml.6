Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAF48601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933483AbeFFQiw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:38:52 -0400
Received: from foss.arm.com ([217.140.101.70]:42946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932971AbeFFQiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:38:51 -0400
From: Jeremy Linton <jeremy.linton@arm.com>
To: Sudeep.Holla@arm.com
Cc: Will.Deacon@arm.com, Catalin.Marinas@arm.com, Robin.Murphy@arm.com,
        Morten.Rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-acpi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2] arm64: topology: Avoid checking numa mask for scheduler MC selection
Date: Wed,  6 Jun 2018 11:38:46 -0500
Message-Id: <20180606163846.495725-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numa mask subset check can often lead to system hang or crash during
CPU hotplug and system suspend operation if NUMA is disabled. This is
mostly observed on HMP systems where the CPU compute capacities are
different and ends up in different scheduler domains. Since
cpumask_of_node is returned instead core_sibling, the scheduler is
confused with incorrect cpumasks(e.g. one CPU in two different sched
domains at the same time) on CPU hotplug.

Lets disable the NUMA siblings checks for the time being, as NUMA in
socket machines have LLC's that will assure that the scheduler topology
isn't "borken".

The NUMA check exists to assure that if a LLC within a socket crosses
NUMA nodes/chiplets the scheduler domains remain consistent. This code will
likely have to be re-enabled in the near future once the NUMA mask story
is sorted.  At the moment its not necessary because the NUMA in socket
machines LLC's are contained within the NUMA domains.

Further, as a defensive mechanism during hot-plug, lets assure that the
LLC siblings are also masked.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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
