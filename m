Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E7FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E072A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EuSjevSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E072A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIFMjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:39:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53563 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbeIFMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536221197; x=1567757197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=H3tTVkcIInVG4ipEeTEmFLSN8+I1/nuKkSbiicUJTHE=;
  b=EuSjevSnQ7HgbHWOfBE3t/9tmI0BuLRFy9tIYPCOPz30tcTHoha43mRq
   7q9rpMCfy/JqQJmG30j3hY8JtXibnxHelWOQ204a3iT9LhgWSo+hppmsg
   M0BpvhZ5vzq0NEAudIJvceaKZFxz6J8Ve3KIW6TN/iBj81hugAt4TK/IX
   UX/Fn2cOztlAIAXqtieg49O4Tke+zESLZ8bpHjGgO0OQv7wWyjdE697az
   n17/toSqU3j+XzzFAESvu4wAAecYuAyTmvYK0wqgPbzvMxOVY19eeslAf
   kkjeJizR3fkBqHhLntimA5U3pNlIbDN4fMkPh1Ty7CZCwujIfB02E6R0W
   A==;
X-IronPort-AV: E=Sophos;i="5.53,337,1531756800"; 
   d="scan'208";a="186673968"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2018 16:06:37 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Sep 2018 00:52:14 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2018 01:05:39 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v3 10/12] RISC-V: Add logical CPU indexing for RISC-V
Date:   Thu,  6 Sep 2018 01:05:33 -0700
Message-Id: <1536221135-182613-11-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, both linux cpu id and hardware cpu id are same.
This is not recommended as it will lead to discontinuous cpu
indexing in Linux. Moreover, kdump kernel will run from CPU0
which would be absent if we follow existing scheme.

Implement a logical mapping between Linux cpu id and hardware
cpuid to decouple these two. Always mark the boot processor as
cpu0 and all other cpus get the logical cpu id based on their
booting order.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by  : Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/smp.h | 24 +++++++++++++++++++++++-
 arch/riscv/kernel/setup.c    |  4 ++++
 arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 85d7619e..fce312ce 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -18,6 +18,13 @@
 #include <linux/irqreturn.h>
 #include <linux/thread_info.h>
 
+#define INVALID_HARTID ULONG_MAX
+/*
+ * Mapping between linux logical cpu index and hartid.
+ */
+extern unsigned long __cpuid_to_hardid_map[NR_CPUS];
+#define cpuid_to_hardid_map(cpu)    __cpuid_to_hardid_map[cpu]
+
 #ifdef CONFIG_SMP
 
 /* SMP initialization hook for setup_arch */
@@ -29,12 +36,27 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 /* Hook for the generic smp_call_function_single() routine. */
 void arch_send_call_function_single_ipi(int cpu);
 
+int riscv_hartid_to_cpuid(int hartid);
+void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
+
 /*
  * Obtains the hart ID of the currently executing task.  This relies on
  * THREAD_INFO_IN_TASK, but we define that unconditionally.
  */
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
-#endif /* CONFIG_SMP */
+#else
+
+static inline int riscv_hartid_to_cpuid(int hartid)
+{
+	return 0;
+}
 
+static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
+					      struct cpumask *out)
+{
+	cpumask_set_cpu(cpuid_to_hardid_map(0), out);
+}
+
+#endif /* CONFIG_SMP */
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index db20dc63..eef1b1a6 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -82,6 +82,10 @@ EXPORT_SYMBOL(empty_zero_page);
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
 
+unsigned long __cpuid_to_hardid_map[NR_CPUS] = {
+	[0 ... NR_CPUS-1] = INVALID_HARTID
+};
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 906fe21e..5aba0107 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -38,7 +38,26 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
+int riscv_hartid_to_cpuid(int hartid)
+{
+	int i = -1;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpuid_to_hardid_map(i) == hartid)
+			return i;
+
+	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
+	BUG();
+	return i;
+}
 
+void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
+{
+	int cpu;
+
+	for_each_cpu(cpu, in)
+		cpumask_set_cpu(cpuid_to_hardid_map(cpu), out);
+}
 /* Unsupported */
 int setup_profiling_timer(unsigned int multiplier)
 {
-- 
2.7.4

