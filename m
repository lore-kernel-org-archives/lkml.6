Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030F5C64EBA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF432208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O4Ajf74L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF432208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeJCCAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:00:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61573 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeJCCAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507713; x=1570043713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XkHB0PFioUjaEN+xmb1y3meqxTOBFcjUD87BCOD5eac=;
  b=O4Ajf74LGVN75hWFv3PrrEh1YEeZtfiNJKaM5h5sbNTQcZvD6r1c3s8s
   lWP4T4UmleW8QYLfwCfWtXRJ3IPjNYGquOhORykIWvOl791f2N0u55MAD
   cP9tzToVoBVl2GiIliIi3vSh7PBHNc6SwBcLtEgGTJwgyeXGOf9TQaK6k
   AeUtDfnTSxZ4lPNyLVmm2PGHlRvztf0ktuJuD3vJXdMTrsMu+n9z1T50t
   cb99VACgkoYqS7DhDnG9pHQj/H5fJRHpfMjXxpNIN3W1caAYIOAM5aX5e
   N5pa0aee4mFVfZ6XZWTY7k1cYFQ+F0wXsBxN9dVhdshTzAHz35nJ8VPZL
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="91076765"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:52 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 14/14] RISC-V: Show IPI stats
Date:   Tue,  2 Oct 2018 12:15:07 -0700
Message-Id: <1538507707-22299-15-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
References: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup@brainfault.org>

This patch provides arch_show_interrupts() implementation to
show IPI stats via /proc/interrupts.

Now the contents of /proc/interrupts" will look like below:
           CPU0       CPU1       CPU2       CPU3
  8:         17          7          6         14  SiFive PLIC   8  virtio0
 10:         10         10          9         11  SiFive PLIC  10  ttyS0
IPI0:       170        673        251         79  Rescheduling interrupts
IPI1:         1         12         27          1  Function call interrupts

Signed-off-by: Anup Patel <anup@brainfault.org>
[Atish - Fixed checkpatch errors]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Changes since v2:
 - Remove use of IPI_CALL_WAKEUP because it's being removed

Changes since v1:
 - Add stub inline show_ipi_stats() function for !CONFIG_SMP
 - Make ipi_names[] dynamically sized at compile time
 - Minor beautification of ipi_names[] using tabs
---
 arch/riscv/include/asm/smp.h |  9 +++++++++
 arch/riscv/kernel/irq.c      |  8 ++++++++
 arch/riscv/kernel/smp.c      | 39 ++++++++++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 47fd61df..41aa73b4 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -25,8 +25,13 @@
 extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
 #define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
 
+struct seq_file;
+
 #ifdef CONFIG_SMP
 
+/* print IPI stats */
+void show_ipi_stats(struct seq_file *p, int prec);
+
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
@@ -47,6 +52,10 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
 #else
 
+static inline void show_ipi_stats(struct seq_file *p, int prec)
+{
+}
+
 static inline int riscv_hartid_to_cpuid(int hartid)
 {
 	return 0;
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index ca459331..48e6b7db 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -8,6 +8,8 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
+#include <linux/seq_file.h>
+#include <asm/smp.h>
 
 /*
  * Possible interrupt causes:
@@ -24,6 +26,12 @@
  */
 #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
 
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+	show_ipi_stats(p, prec);
+	return 0;
+}
+
 asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 4eac0094..57b1383e 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -22,22 +22,24 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-/* A collection of single bit ipi messages.  */
-static struct {
-	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
-
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_MAX
 };
 
+/* A collection of single bit ipi messages.  */
+static struct {
+	unsigned long stats[IPI_MAX] ____cacheline_aligned;
+	unsigned long bits ____cacheline_aligned;
+} ipi_data[NR_CPUS] __cacheline_aligned;
+
 int riscv_hartid_to_cpuid(int hartid)
 {
 	int i = -1;
@@ -67,6 +69,7 @@ int setup_profiling_timer(unsigned int multiplier)
 void riscv_software_interrupt(void)
 {
 	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
+	unsigned long *stats = ipi_data[smp_processor_id()].stats;
 
 	/* Clear pending IPI */
 	csr_clear(sip, SIE_SSIE);
@@ -81,11 +84,15 @@ void riscv_software_interrupt(void)
 		if (ops == 0)
 			return;
 
-		if (ops & (1 << IPI_RESCHEDULE))
+		if (ops & (1 << IPI_RESCHEDULE)) {
+			stats[IPI_RESCHEDULE]++;
 			scheduler_ipi();
+		}
 
-		if (ops & (1 << IPI_CALL_FUNC))
+		if (ops & (1 << IPI_CALL_FUNC)) {
+			stats[IPI_CALL_FUNC]++;
 			generic_smp_call_function_interrupt();
+		}
 
 		BUG_ON((ops >> IPI_MAX) != 0);
 
@@ -111,6 +118,24 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 	sbi_send_ipi(cpumask_bits(&hartid_mask));
 }
 
+static const char * const ipi_names[] = {
+	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
+	[IPI_CALL_FUNC]		= "Function call interrupts",
+};
+
+void show_ipi_stats(struct seq_file *p, int prec)
+{
+	unsigned int cpu, i;
+
+	for (i = 0; i < IPI_MAX; i++) {
+		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
+			   prec >= 4 ? " " : "");
+		for_each_online_cpu(cpu)
+			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
+		seq_printf(p, " %s\n", ipi_names[i]);
+	}
+}
+
 void arch_send_call_function_ipi_mask(struct cpumask *mask)
 {
 	send_ipi_message(mask, IPI_CALL_FUNC);
-- 
2.7.4

