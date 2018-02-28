Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELtYknmik7ju0XhxB6GyQO9bFtokAMfo+NFjIE4G/AJWJB+IGFZC5ay/6GTzN7IEWnD1VQqh
ARC-Seal: i=1; a=rsa-sha256; t=1519855654; cv=none;
        d=google.com; s=arc-20160816;
        b=Ck4R7AAhqSh2BnEVbvi7xd0sRwGyfkM48Bz/TQRv8ySr/ZqeTjV099I0dC7016hrJG
         jUJKFqmgo0Dsg/6AkYRMr52/J3bnaURCGLdb0wnQQSXw8f47eYyZ2pi5o+RE2teMLxx9
         jOnUPjmXDlUkkP6f/E2Vv6qPCqWcqFdJwSCnvjg3Gq+RQpluahDWR8yF2b1SCpQhaAhx
         UIP5tB0JwZiNLH5xsEf63t7VMYzIzcqMsTkGLOYZ7oAV9N6NStaX8mmlBVLooSs8BX8b
         gOpvjC4hWhuCwL0baN8Nh5rFxM+/ROu/b1xbnmouBezLNDT0I6wSUzu8FUnppsNNbqiO
         da9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=m0LYSuwtP8U45Z7etrtHPtxdE00Z7mP4oopiGZ57PWA=;
        b=U1uR8NXiO4zRHeTQfa/2bmbk7MTurmaFJCG+7GrFcZkiRmwoQw7mgWxD7mOTkxw3rF
         8UL6c9hharWRH0O3ujiVcKoPcELcnTfSLrPOrHOfCL7aBn/30ZViRpya0mJIYynbqD8x
         o93rMubei51wEng/dNShb3GbpdBjnZe2k4VWXbw2Vhi2LAOKjfKbFJ52Xgh44OaHcTI8
         7usXPRIRXzuJjULL9jh9+6ecZZrRLqrjmp839QyuyjvPpRL1C6Yte9I1OEL2tkZhU5pz
         P0WOO9aXuz4ER7mjxLITFWz5OwpCtRSybBOifAEVGaQyoqrEa+XcQk5M6eL8FVbwOj+L
         fL0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	lorenzo.pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	dietmar.eggemann@arm.com,
	morten.rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain from core_siblings
Date: Wed, 28 Feb 2018 16:06:19 -0600
Message-Id: <20180228220619.6992-14-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684162193428124?=
X-GMAIL-MSGID: =?utf-8?q?1593684162193428124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we have an accurate view of the physical topology
we need to represent it correctly to the scheduler. In the
case of NUMA in socket, we need to assure that the sched domain
we build for the MC layer isn't larger than the DIE above it.
To do this correctly, we should really base that on the cache
topology immediately below the NUMA node (for NUMA in socket)
or below the physical package for normal NUMA configurations.

This patch creates a set of early cache_siblings masks, then
when the scheduler requests the coregroup mask we pick the
smaller of the physical package siblings, or the numa siblings
and locate the largest cache which is an entire subset of
those siblings. If we are unable to find a proper subset of
cores then we retain the original behavior and return the
core_sibling list.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/topology.h |  5 +++
 arch/arm64/kernel/topology.c      | 64 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 6b10459e6905..08db3e4e44e1 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -4,12 +4,17 @@
 
 #include <linux/cpumask.h>
 
+#define MAX_CACHE_CHECKS 4
+
 struct cpu_topology {
 	int thread_id;
 	int core_id;
 	int package_id;
+	int cache_id[MAX_CACHE_CHECKS];
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
+	cpumask_t cache_siblings[MAX_CACHE_CHECKS];
+	int cache_level;
 };
 
 extern struct cpu_topology cpu_topology[NR_CPUS];
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index bd1aae438a31..1809dc9d347c 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -212,8 +212,42 @@ static int __init parse_dt_topology(void)
 struct cpu_topology cpu_topology[NR_CPUS];
 EXPORT_SYMBOL_GPL(cpu_topology);
 
+static void find_llc_topology_for_cpu(int cpu)
+{
+	/* first determine if we are a NUMA in package */
+	const cpumask_t *node_mask = cpumask_of_node(cpu_to_node(cpu));
+	int indx;
+
+	if (!cpumask_subset(node_mask, &cpu_topology[cpu].core_sibling)) {
+		/* not numa in package, lets use the package siblings */
+		node_mask = &cpu_topology[cpu].core_sibling;
+	}
+
+	/*
+	 * node_mask should represent the smallest package/numa grouping
+	 * lets search for the largest cache smaller than the node_mask.
+	 */
+	for (indx = 0; indx < MAX_CACHE_CHECKS; indx++) {
+		cpumask_t *cache_sibs = &cpu_topology[cpu].cache_siblings[indx];
+
+		if (cpu_topology[cpu].cache_id[indx] < 0)
+			continue;
+
+		if (cpumask_subset(cache_sibs, node_mask))
+			cpu_topology[cpu].cache_level = indx;
+	}
+}
+
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
+	int *llc = &cpu_topology[cpu].cache_level;
+
+	if (*llc == -1)
+		find_llc_topology_for_cpu(cpu);
+
+	if (*llc != -1)
+		return &cpu_topology[cpu].cache_siblings[*llc];
+
 	return &cpu_topology[cpu].core_sibling;
 }
 
@@ -221,6 +255,7 @@ static void update_siblings_masks(unsigned int cpuid)
 {
 	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
 	int cpu;
+	int idx;
 
 	/* update core and thread sibling masks */
 	for_each_possible_cpu(cpu) {
@@ -229,6 +264,16 @@ static void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
+		for (idx = 0; idx < MAX_CACHE_CHECKS; idx++) {
+			cpumask_t *lsib;
+			int cput_id = cpuid_topo->cache_id[idx];
+
+			if (cput_id == cpu_topo->cache_id[idx]) {
+				lsib = &cpuid_topo->cache_siblings[idx];
+				cpumask_set_cpu(cpu, lsib);
+			}
+		}
+
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
 		if (cpu != cpuid)
 			cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
@@ -286,10 +331,18 @@ static void __init reset_cpu_topology(void)
 
 	for_each_possible_cpu(cpu) {
 		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
+		int idx;
 
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id = 0;
 		cpu_topo->package_id = -1;
+		cpu_topo->cache_level = -1;
+
+		for (idx = 0; idx < MAX_CACHE_CHECKS; idx++) {
+			cpu_topo->cache_id[idx] = -1;
+			cpumask_clear(&cpu_topo->cache_siblings[idx]);
+			cpumask_set_cpu(cpu, &cpu_topo->cache_siblings[idx]);
+		}
 
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
@@ -311,6 +364,9 @@ static int __init parse_acpi_topology(void)
 	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
 
 	for_each_possible_cpu(cpu) {
+		int tidx = 0;
+		int i;
+
 		topology_id = find_acpi_cpu_topology(cpu, 0);
 		if (topology_id < 0)
 			return topology_id;
@@ -325,6 +381,14 @@ static int __init parse_acpi_topology(void)
 		}
 		topology_id = find_acpi_cpu_topology_package(cpu);
 		cpu_topology[cpu].package_id = topology_id;
+
+		for (i = 0; i < MAX_CACHE_CHECKS; i++) {
+			topology_id = find_acpi_cpu_cache_topology(cpu, i + 1);
+			if (topology_id > 0) {
+				cpu_topology[cpu].cache_id[tidx] = topology_id;
+				tidx++;
+			}
+		}
 	}
 
 	return 0;
-- 
2.13.6
