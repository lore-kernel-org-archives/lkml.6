Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5D7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705E3214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hspqTmmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705E3214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbeHPCuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:50:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25856 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbeHPCut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534377379; x=1565913379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8SV0JD9xISdUkBeOHHNwOfZqNF36VPqj1Rts7EPD3lU=;
  b=hspqTmmtEBVDGGj+vMNB8TWikkYoz9EfwtFb4iIgwygcuCU5/L3EAgHU
   8AXIDs/kzt3n2SMlg1vGBmyPt+dzgQfqp/sutVlFOSMUxzi6SrqdSJAq6
   DPT3bq3MmAlLL/fDGLhuXf2wYkYHnkrKE7b1OTz0N+rzTy87330gDp/GI
   EmvGaOpm2unwHTMYmhZP5yuMT0NkX3oYmavQxfxDOSBHoFGj2c/s2h0ex
   RWJTrNNQwV07XVfYSgBQ27xnumWfTMCSGCsOqx7OFby6ukMzZu7JJPbQ8
   9dZL/bqo+/8E1RU+d1uHD9h7FPGfiynWrJ8b5uoB5dYBSTvTLjk9L2mhZ
   A==;
X-IronPort-AV: E=Sophos;i="5.53,245,1531756800"; 
   d="scan'208";a="88557062"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 07:56:18 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 15 Aug 2018 16:44:16 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2018 16:56:18 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com
Subject: [RFC PATCH 1/5] RISC-V: Add logical CPU indexing for RISC-V
Date:   Wed, 15 Aug 2018 16:56:13 -0700
Message-Id: <1534377377-70108-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
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
---
 arch/riscv/include/asm/smp.h | 17 ++++++++++++++++-
 arch/riscv/kernel/setup.c    |  2 ++
 arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 36016845..0763337b 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -22,6 +22,12 @@
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
 
+/*
+ * Mapping between linux logical cpu index and hartid.
+ */
+extern u64 __cpu_logical_map[NR_CPUS];
+#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
+
 #ifdef CONFIG_SMP
 
 /* SMP initialization hook for setup_arch */
@@ -33,6 +39,8 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 /* Hook for the generic smp_call_function_single() routine. */
 void arch_send_call_function_single_ipi(int cpu);
 
+int riscv_hartid_to_cpuid(int hartid);
+void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 /*
  * This is particularly ugly: it appears we can't actually get the definition
  * of task_struct here, but we need access to the CPU this task is running on.
@@ -41,6 +49,13 @@ void arch_send_call_function_single_ipi(int cpu);
  */
 #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
 
-#endif /* CONFIG_SMP */
+#else
+
+static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
+static inline void cpuid_to_hartid_mask(const struct cpumask *in,
+				       struct cpumask *out) {
+	cpumask_set_cpu(cpu_logical_map(0), out);
+}
 
+#endif /* CONFIG_SMP */
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index db20dc63..e21ed481 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -82,6 +82,8 @@ EXPORT_SYMBOL(empty_zero_page);
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
 
+u64 __cpu_logical_map[NR_CPUS];
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 906fe21e..d55379ee 100644
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
+		if (cpu_logical_map(i) == hartid)
+			return i;
+
+	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
+	BUG();
+	return i;
+}
 
+void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
+{
+	int cpu;
+
+	for_each_cpu(cpu, in)
+		cpumask_set_cpu(cpu_logical_map(cpu), out);
+}
 /* Unsupported */
 int setup_profiling_timer(unsigned int multiplier)
 {
-- 
2.7.4

