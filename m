Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZoB54HLpsQaoKVZ/OOWonWKg0n4MaXbppobLfrtFrZoi6OO/BMfqpe8y1IOMcNtWv6JbcNy
ARC-Seal: i=1; a=rsa-sha256; t=1526083154; cv=none;
        d=google.com; s=arc-20160816;
        b=gYDTG2p0E6tLSp5jN1w+McemhZdjHgHkE/TB/uJ2qlxT7mMuh/I9MJ06ivJbqCVXze
         LvoH+IyK+IIpdb+gy1PbX2KYSZ12oDkGgYG3cBYnkPDyezRtyg9JV+lRHwYj2J6NsMH6
         E9uVr9K1/pMcb7HnMeiotwlmY0fUbGGt49frQ7mKGsH0xTZXlR1hCb+UiXndwxrUBl+h
         w3fKdu1IhRPk2wgRrczTxIcME3kxZZOD7oDMBGCqouWc4S+MJx1Nhdk1pjAeK540tMga
         Ks+rWOfFWHNIHY+0q3xn+bTedjH9f3ugLKFE+Fy8k7aE69c5JxEgsJIqwXNbNyhEIA2J
         DnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KyBrSSuu0Yv83DJ7q51FP/GnEa6pLsKmNowo+Gx8QgE=;
        b=e9aR7Z8ayILyMuvGj3caxMo0n3boQBvi9qqHEb5iASBdSZqM+slge7lPN1/pHKw3F2
         Byqh4m6DYYyMnWb/UB4thPr0kWPkduVVjmSIt3YJInu3a/Z//ETHvFxZQ2S5/UDRaXd6
         m7Y19QmOjfNXCXqztvZVkqn4RS0prDJ5r6UsOThW+aegv/FW/oOrASQeyOttpZteMDeT
         INo4f1VooGaszPy9AB2bfDnwqbIbZqhIdRjBwsgKukB7THa0rPgA/q0uNO5NaM78otUI
         acqoe0qwnj8ao0A4OoAJTgZplMi+szWK4KPFwQi54GBfyoERYnhAUIpGp+5hPn5DSiTZ
         RhQQ==
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
Subject: [PATCH v9 10/12] arm64: topology: enable ACPI/PPTT based CPU topology
Date: Fri, 11 May 2018 18:58:05 -0500
Message-Id: <20180511235807.30834-11-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214169340244599?=
X-GMAIL-MSGID: =?utf-8?q?1600214169340244599?=
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
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm64/kernel/topology.c | 45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index dc18b1e53194..047d98e68502 100644
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
+	if (!acpi_disabled && parse_acpi_topology())
+		reset_cpu_topology();
+	else if (of_have_populated_dt() && parse_dt_topology())
 		reset_cpu_topology();
 }
-- 
2.13.6
