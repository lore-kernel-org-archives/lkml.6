Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx499ww/0t7Aw1ZPg9EGCZrvpf/2W63UX6NfuPiNo0IUuK32/H5arcgb2jOZ9gjESy6Xa86yD
ARC-Seal: i=1; a=rsa-sha256; t=1524702384; cv=none;
        d=google.com; s=arc-20160816;
        b=Y0EKPc2ibWve40DcAYfQ2p/upZb1Hbn2IYXnVurgbH2ixRD5KCX2pKxhn+zY9k8GY0
         jl5etgH/0Znbqug1HU+YENboKkyn+u8N7W4bG1nRtzxbwgyyI8tvzXtTR/0zDOqDHcJK
         5oZrn2atm2cpGOkfeb52RZD7C1qOStEgk1N0XPQZYY8h8INmLFl4qcS+ifHym2WEk6A1
         vQseZLEt5HaoNU0f38jihCamj9q/72lsV3YacipA1hGlbUriJE721aFXP3kfTwsCO3GF
         JolLyPj0uNgS6SxkIkApensPdAx4X92NFBe6O+MQmnRIpxPJW91yVMzDoIRog/cYiQug
         250Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PhFEXSYnZbMr/gGvLgB/gN1hj8ffNpA+gkOhEgXSZsI=;
        b=pLS1HuZFk9FlV7Hd8qzXnQ+fwvCMcBS7CTLa2kpKHDGAYQAYmav+B3rD7H6AU80+vo
         UGoiQqXUYhTMHb7++0iQVsQz3c7xyJWl37Q9XWajyRdU+j4CORp4BUB7Vv/vVxUJXxQs
         QHL0uF5ro+EJLAS7+mse87bY0AgIRpd4ZzBY0MKNEu51opF1aRikuGzdltSJ4+VXqYOh
         4cj874x9HMx4CsZz5bO7s7BzGyqNiIGzDRj38XVbgQFEgVWSvNSeFQlwflibvPAjvBj1
         qSJAMGR35sWz0esw0v4LHxVr58+/b3Cq6cgOg7KEKI4XJfZMZhOhQ4QHlTYYI90lKiTk
         15HA==
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
	jhugo@qti.qualcomm.com,
	timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU topology
Date: Wed, 25 Apr 2018 18:31:19 -0500
Message-Id: <20180425233121.13270-12-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766328036390506?=
X-GMAIL-MSGID: =?utf-8?q?1598766328036390506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Propagate the topology information from the PPTT tree to the
cpu_topology array. We can get the thread id and core_id by assuming
certain levels of the PPTT tree correspond to those concepts.
The package_id is flagged in the tree and can be found by calling
find_acpi_cpu_topology_package() which terminates
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
