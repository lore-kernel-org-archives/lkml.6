Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B70EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1C72087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CO9bk4sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1C72087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeH1M1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:27:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54531 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeH1M0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535445407; x=1566981407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tgBdJfwkIUVdiDXkWPcaVmbM4K05l2zAk+lCOoJwScM=;
  b=CO9bk4smqf1PleW28N+DGgCn6dhedf7R4aHS4HNGHpMEvt2jq3kkbpXV
   5H+gJpnug2sEF1wdElzqLQ2KosMSfcx36P5FLeFk1+8r/HeXwqUQDs+RY
   PDg2i+R4QuEMSerWVRaAYmGyYebSNqTUIyi1wEdGj/3yyMNSsYbWEX6db
   X6SIWIyV01x+I5YFSkRRAIiUItISS/WiPuIh9C8DmfIGNS07y8NAjXh1i
   f1CnkvvV8XxbyaUdWOd89x1INq2k/2AGrbzpkOeSDcK5zodW6W8kYYME+
   Fcy62lEK2N9vk8fVHaL2qNhcScuGs9sZ8mgncwPlBBj+IcMVX9aUnsTQJ
   w==;
X-IronPort-AV: E=Sophos;i="5.53,298,1531756800"; 
   d="scan'208";a="185994292"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2018 16:36:46 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Aug 2018 01:23:08 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Aug 2018 01:36:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, damein@vger.kernel.org
Subject: [PATCH v2 1/3] RISC-V: Add logical CPU indexing for RISC-V
Date:   Tue, 28 Aug 2018 01:36:08 -0700
Message-Id: <1535445370-19004-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
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
 arch/riscv/include/asm/smp.h | 18 +++++++++++++++++-
 arch/riscv/kernel/setup.c    |  2 ++
 arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 36016845..a5c257b3 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -22,6 +22,13 @@
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
 
+#define INVALID_HARTID -1
+/*
+ * Mapping between linux logical cpu index and hartid.
+ */
+extern unsigned long __cpu_logical_map[NR_CPUS];
+#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
+
 #ifdef CONFIG_SMP
 
 /* SMP initialization hook for setup_arch */
@@ -33,6 +40,8 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 /* Hook for the generic smp_call_function_single() routine. */
 void arch_send_call_function_single_ipi(int cpu);
 
+int riscv_hartid_to_cpuid(int hartid);
+void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 /*
  * This is particularly ugly: it appears we can't actually get the definition
  * of task_struct here, but we need access to the CPU this task is running on.
@@ -41,6 +50,13 @@ void arch_send_call_function_single_ipi(int cpu);
  */
 #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
 
-#endif /* CONFIG_SMP */
+#else
+
+static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
+static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
+				       struct cpumask *out) {
+	cpumask_set_cpu(cpu_logical_map(0), out);
+}
 
+#endif /* CONFIG_SMP */
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index db20dc63..7b52b4cd 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -82,6 +82,8 @@ EXPORT_SYMBOL(empty_zero_page);
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
 
+unsigned long __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HARTID };
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 906fe21e..9b288c9a 100644
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
 
+void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
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

