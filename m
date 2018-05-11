Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZp0eI0EYhTsum2NpSksND3XiqJUBFDUd9bQ62R3YZrEMFBBllSu9JF8BqHvCOPxwUkAy0+S
ARC-Seal: i=1; a=rsa-sha256; t=1526083158; cv=none;
        d=google.com; s=arc-20160816;
        b=A0PcblNQAHgU58t7DE5rDorGibQTbo4YzvG6GmjdUFQ3H/PCquMG1uoMJ+CFYIHcAF
         lbNZu5Bh3R7wJuLNC64oDsrz/xt/gtduJe3VHOldRCs4NNbdv7V+VuTS8qSSrq8DGVw4
         EX/yuhmEkXxy6UDn0TU/Xtt6+oazdXHhdpnFPUBUx3JYm93DEv5y6IHVpIiZPU7L9Kyb
         5QdQMzVy8v5G7A3LyGxL2LBaZRTnU+gvxi0Jos8zszD15i2N3TghvpRIbgTvHCxgPLv7
         LeAPy9iKRg8cFHGulgEE5xVoTMJgBl4W/OidZq8WABFn8AT7auebYfU+ArsGgtDKjBNA
         l1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QRk3kFoVZgka0h2mcirXDy+5SPxfSIQCltqey94HzkA=;
        b=dPpeyLwDKldPnaf2cVpjlHt4gdGm69INXodlOwNFDYxeogcFg+J9nW3+8bxWd+YAr0
         4oKmYw6/PNPaQ/C24dNaWX81VOdBC744xjohItjSGS2jTftO1oUKClAfqmkh4OvgO8Ag
         mYnQ+cgbULDjp/iF/3Q9aOKJbrisGnOBwJOaWmE78tlE8gEEkXWpejOoBOm8YExXdTwI
         6TM8QmYEuxJE7p1H9XmxBWhY7XUb77aIDw5bqTkSELk9rm6p3NE7FszjJ61fmKuV57DW
         urt6fYU03rHQlAiJOHOtrr0crQwCEXrCfTtI9ElMJj1B0aJ09Lckunn6oQgeTHYDP3r6
         JJpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	Will.Deacon@arm.com,
	Catalin.Marinas@arm.com,
	gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	Dietmar.Eggemann@arm.com,
	Morten.Rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	jhugo@codeaurora.org,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v9 12/12] arm64: topology: divorce MC scheduling domain from core_siblings
Date: Fri, 11 May 2018 18:58:07 -0500
Message-Id: <20180511235807.30834-13-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214173807906985?=
X-GMAIL-MSGID: =?utf-8?q?1600214173807906985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we have an accurate view of the physical topology
we need to represent it correctly to the scheduler. Generally MC
should equal the LLC in the system, but there are a number of
special cases that need to be dealt with.

In the case of NUMA in socket, we need to assure that the sched
domain we build for the MC layer isn't larger than the DIE above it.
Similarly for LLC's that might exist in cross socket interconnect or
directory hardware we need to assure that MC is shrunk to the socket
or NUMA node.

This patch builds a sibling mask for the LLC, and then picks the
smallest of LLC, socket siblings, or NUMA node siblings, which
gives us the behavior described above. This is ever so slightly
different than the similar alternative where we look for a cache
layer less than or equal to the socket/NUMA siblings.

The logic to pick the MC layer affects all arm64 machines, but
only changes the behavior for DT/MPIDR systems if the NUMA domain
is smaller than the core siblings (generally set to the cluster).
Potentially this fixes a possible bug in DT systems, but really
it only affects ACPI systems where the core siblings is correctly
set to the socket siblings. Thus all currently available ACPI
systems should have MC equal to LLC, including the NUMA in socket
machines where the LLC is partitioned between the NUMA nodes.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm64/include/asm/topology.h |  2 ++
 arch/arm64/kernel/topology.c      | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 6b10459e6905..df48212f767b 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -8,8 +8,10 @@ struct cpu_topology {
 	int thread_id;
 	int core_id;
 	int package_id;
+	int llc_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
+	cpumask_t llc_siblings;
 };
 
 extern struct cpu_topology cpu_topology[NR_CPUS];
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 047d98e68502..7415c166281f 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -13,6 +13,7 @@
 
 #include <linux/acpi.h>
 #include <linux/arch_topology.h>
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
@@ -214,7 +215,19 @@ EXPORT_SYMBOL_GPL(cpu_topology);
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
-	return &cpu_topology[cpu].core_sibling;
+	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
+
+	/* Find the smaller of NUMA, core or LLC siblings */
+	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
+		/* not numa in package, lets use the package siblings */
+		core_mask = &cpu_topology[cpu].core_sibling;
+	}
+	if (cpu_topology[cpu].llc_id != -1) {
+		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
+			core_mask = &cpu_topology[cpu].llc_siblings;
+	}
+
+	return core_mask;
 }
 
 static void update_siblings_masks(unsigned int cpuid)
@@ -226,6 +239,9 @@ static void update_siblings_masks(unsigned int cpuid)
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
+		if (cpuid_topo->llc_id == cpu_topo->llc_id)
+			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
+
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
@@ -291,6 +307,10 @@ static void __init reset_cpu_topology(void)
 		cpu_topo->core_id = 0;
 		cpu_topo->package_id = -1;
 
+		cpu_topo->llc_id = -1;
+		cpumask_clear(&cpu_topo->llc_siblings);
+		cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
+
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
 		cpumask_clear(&cpu_topo->thread_sibling);
@@ -311,6 +331,8 @@ static int __init parse_acpi_topology(void)
 	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
 
 	for_each_possible_cpu(cpu) {
+		int i, cache_id;
+
 		topology_id = find_acpi_cpu_topology(cpu, 0);
 		if (topology_id < 0)
 			return topology_id;
@@ -325,6 +347,18 @@ static int __init parse_acpi_topology(void)
 		}
 		topology_id = find_acpi_cpu_topology_package(cpu);
 		cpu_topology[cpu].package_id = topology_id;
+
+		i = acpi_find_last_cache_level(cpu);
+
+		if (i > 0) {
+			/*
+			 * this is the only part of cpu_topology that has
+			 * a direct relationship with the cache topology
+			 */
+			cache_id = find_acpi_cpu_cache_topology(cpu, i);
+			if (cache_id > 0)
+				cpu_topology[cpu].llc_id = cache_id;
+		}
 	}
 
 	return 0;
-- 
2.13.6
