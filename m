Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELvpxzsu07d1UCQutL62+ttxFVOeIQBGYJkHtBBj4CMBAeLWVintNpQvLYmfPefR/7quLXMv
ARC-Seal: i=1; a=rsa-sha256; t=1519855651; cv=none;
        d=google.com; s=arc-20160816;
        b=CaHPOE6KZEh0mTz6Dl86nvAzbJKXzKo3dERyW/VuNKOzlmuK8nCUZfY0pSIfJN7dRU
         zFDcGscjtQzHidAw9LQPuP166/AcquDe0GV0be2uHwXDNyv+xeVnSSKx4PM3npnecFI4
         yKhFKIpGqgElGrdjCbFvjmaurgnH8PBiVWYcnlrO5rPuncPGZBbxgzdPW3pGM/m2289s
         Q5cnJtqNTbuG/m4eQlsHn1Uwo4hHFFFeQVxEv8LrwMFwR2pQl077fn8GTtPgX2y/z3dh
         IfTzW2n+h2HlSokZcWm2vCBtHbu5++KE2nTOXYwr1sK5T9B7fsxTiLx/TqGETbK6drRJ
         sivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=67hBQw3N45mpT2AFRrevGfvDZ7Szd+8j6rHJTDYfm7A=;
        b=HkBAKXoqu8nRn3CG8jKmkASSSAoeSdUaHZIphidDauvq1LLgmK1wW9pjc0tKFE/l0u
         fsJMejGWNmiYVirZ/IXnmr9rPTmRfm4+sR4qgfouukQQQfx5adU8ru80V9E3eZPuG64u
         te3Rb7wenr+BEQ19SC8vdiyvVvfQbQ2uUrRSPN+K0w2tE8OT0c2lbbh2XKLKg32n9ZMn
         CO/Y3IOEsH57e/3J1DrToxKzTW/xetQHJg/x7ay3lh6vsREUbUj2muVLP51js9VEQ/6F
         6twQiJAGiHikn9p9Ykn8iKQ7pSe751WTKsATz1PRvxCZp9jI2yfu+GZNeCLj0/msTSES
         5YMQ==
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
Subject: [PATCH v7 11/13] arm64: topology: enable ACPI/PPTT based CPU topology
Date: Wed, 28 Feb 2018 16:06:17 -0600
Message-Id: <20180228220619.6992-12-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684159410206150?=
X-GMAIL-MSGID: =?utf-8?q?1593684159410206150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Propagate the topology information from the PPTT tree to the
cpu_topology array. We can get the thread id, core_id and
cluster_id by assuming certain levels of the PPTT tree correspond
to those concepts. The package_id is flagged in the tree and can be
found by calling find_acpi_cpu_topology_package() which terminates
its search when it finds an ACPI node flagged as the physical
package. If the tree doesn't contain enough levels to represent
all of the requested levels then the root node will be returned
for all subsequent levels.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/topology.c | 45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index dc18b1e53194..bd1aae438a31 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -22,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
 #include <linux/string.h>
 
 #include <asm/cpu.h>
@@ -296,6 +298,45 @@ static void __init reset_cpu_topology(void)
 	}
 }
 
+#ifdef CONFIG_ACPI
+/*
+ * Propagate the topology information of the processor_topology_node tree to the
+ * cpu_topology array.
+ */
+static int __init parse_acpi_topology(void)
+{
+	bool is_threaded;
+	int cpu, topology_id;
+
+	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
+
+	for_each_possible_cpu(cpu) {
+		topology_id = find_acpi_cpu_topology(cpu, 0);
+		if (topology_id < 0)
+			return topology_id;
+
+		if (is_threaded) {
+			cpu_topology[cpu].thread_id = topology_id;
+			topology_id = find_acpi_cpu_topology(cpu, 1);
+			cpu_topology[cpu].core_id   = topology_id;
+		} else {
+			cpu_topology[cpu].thread_id  = -1;
+			cpu_topology[cpu].core_id    = topology_id;
+		}
+		topology_id = find_acpi_cpu_topology_package(cpu);
+		cpu_topology[cpu].package_id = topology_id;
+	}
+
+	return 0;
+}
+
+#else
+static inline int __init parse_acpi_topology(void)
+{
+	return -EINVAL;
+}
+#endif
+
 void __init init_cpu_topology(void)
 {
 	reset_cpu_topology();
@@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
 	 * Discard anything that was parsed if we hit an error so we
 	 * don't use partial information.
 	 */
-	if (of_have_populated_dt() && parse_dt_topology())
+	if ((!acpi_disabled) && parse_acpi_topology())
+		reset_cpu_topology();
+	else if (of_have_populated_dt() && parse_dt_topology())
 		reset_cpu_topology();
 }
-- 
2.13.6
