Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30259C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9E0217BF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XBHbwVgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9E0217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeHDKXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 06:23:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDKXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 06:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Ek7WWh5ShInMQ28slfdtf/tBTg+jZFaSpL99WJ5lto=; b=XBHbwVgD96AqBZ6j3YHBC9Dkr
        Mo+op4tYADTSnRa+e4zUuLb3hVHRjjfwLcT7DA+ox18bWk1MCdlcc5taqzEqAvN8d/Jitzu8mQNcm
        c/jrNL95/o51YxNbOhKqMWhl1FkOWr77mByDIjn0mo2Wx3QPTaz6P9z4r31gKSWxlCNhmZ83y3OIt
        ORzWCfn9ceuOIQNZl7SHmud1GKetMkCZBToy3Con/E1p005NJbp7hjZG1rIIHxaKAXeqYWsD5RGmU
        bK9JNYpRRcr5i+DNd1xNHQgHw643jnfjtR5gRfiBSjufTPbLOw+bjji6LdVYF5kQZlMP0sPcdSJms
        W+ja1y9Ow==;
Received: from [46.125.249.69] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flrqm-0003pv-TK; Sat, 04 Aug 2018 08:23:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>
Subject: [PATCH 8/8] clocksource: new RISC-V SBI timer driver
Date:   Sat,  4 Aug 2018 10:23:19 +0200
Message-Id: <20180804082319.5711-9-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082319.5711-1-hch@lst.de>
References: <20180804082319.5711-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

The RISC-V ISA defines a per-hart real-time clock and timer, which is
present on all systems.  The clock is accessed via the 'rdtime'
pseudo-instruction (which reads a CSR), and the timer is set via an SBI
call.

Contains various improvements from Atish Patra <atish.patra@wdc.com>.

Signed-off-by: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
[hch: remove dead code, add SPDX tags, used riscv_of_processor_hart(),
 minor cleanups, merged  hotplug cpu support and other improvements
 from Atish]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/smp.h      |   3 -
 arch/riscv/kernel/irq.c           |   3 +
 arch/riscv/kernel/smpboot.c       |   1 -
 arch/riscv/kernel/time.c          |   9 +--
 drivers/clocksource/Kconfig       |  11 ++++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/riscv_timer.c | 105 ++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h        |   1 +
 8 files changed, 122 insertions(+), 12 deletions(-)
 create mode 100644 drivers/clocksource/riscv_timer.c

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index c9395fff246f..36016845461d 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -24,9 +24,6 @@
 
 #ifdef CONFIG_SMP
 
-/* SMP initialization hook for setup_arch */
-void __init init_clockevent(void);
-
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index ab5f3e22c7cc..0cfac48a1272 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -30,6 +30,9 @@ asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
 
 	irq_enter();
 	switch (cause & ~INTERRUPT_CAUSE_FLAG) {
+	case INTERRUPT_CAUSE_TIMER:
+		riscv_timer_interrupt();
+		break;
 #ifdef CONFIG_SMP
 	case INTERRUPT_CAUSE_SOFTWARE:
 		/*
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index f741458c5a3f..56abab6a9812 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -104,7 +104,6 @@ asmlinkage void __init smp_callin(void)
 	current->active_mm = mm;
 
 	trap_init();
-	init_clockevent();
 	notify_cpu_starting(smp_processor_id());
 	set_cpu_online(smp_processor_id(), 1);
 	local_flush_tlb_all();
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 0df9b2cbd645..1911c8f6b8a6 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -18,12 +18,6 @@
 
 unsigned long riscv_timebase;
 
-void __init init_clockevent(void)
-{
-	timer_probe();
-	csr_set(sie, SIE_STIE);
-}
-
 void __init time_init(void)
 {
 	struct device_node *cpu;
@@ -35,6 +29,5 @@ void __init time_init(void)
 	riscv_timebase = prop;
 
 	lpj_fine = riscv_timebase / HZ;
-
-	init_clockevent();
+	timer_probe();
 }
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd88ec15..a11f4ba98b05 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -609,4 +609,15 @@ config ATCPIT100_TIMER
 	help
 	  This option enables support for the Andestech ATCPIT100 timers.
 
+config RISCV_TIMER
+	bool "Timer for the RISC-V platform"
+	depends on RISCV
+	default y
+	select TIMER_PROBE
+	select TIMER_OF
+	help
+	  This enables the per-hart timer built into all RISC-V systems, which
+	  is accessed via both the SBI and the rdcycle instruction.  This is
+	  required for all RISC-V systems.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 00caf37e52f9..ded31f720bd9 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
+obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
new file mode 100644
index 000000000000..4e8b347e43e2
--- /dev/null
+++ b/drivers/clocksource/riscv_timer.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ */
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <asm/sbi.h>
+
+/*
+ * All RISC-V systems have a timer attached to every hart.  These timers can be
+ * read by the 'rdcycle' pseudo instruction, and can use the SBI to setup
+ * events.  In order to abstract the architecture-specific timer reading and
+ * setting functions away from the clock event insertion code, we provide
+ * function pointers to the clockevent subsystem that perform two basic
+ * operations: rdtime() reads the timer on the current CPU, and
+ * next_event(delta) sets the next timer event to 'delta' cycles in the future.
+ * As the timers are inherently a per-cpu resource, these callbacks perform
+ * operations on the current hart.  There is guaranteed to be exactly one timer
+ * per hart on all RISC-V systems.
+ */
+
+static int riscv_clock_next_event(unsigned long delta,
+		struct clock_event_device *ce)
+{
+	csr_set(sie, SIE_STIE);
+	sbi_set_timer(get_cycles64() + delta);
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
+	.name			= "riscv_timer_clockevent",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 100,
+	.set_next_event		= riscv_clock_next_event,
+};
+
+/*
+ * It is guaranteed that all the timers across all the harts are synchronized
+ * within one tick of each other, so while this could technically go
+ * backwards when hopping between CPUs, practically it won't happen.
+ */
+static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
+{
+	return get_cycles64();
+}
+
+static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
+	.name		= "riscv_clocksource",
+	.rating		= 300,
+	.mask		= CLOCKSOURCE_MASK(BITS_PER_LONG),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.read		= riscv_clocksource_rdtime,
+};
+
+static int riscv_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
+
+	ce->cpumask = cpumask_of(cpu);
+	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
+
+	csr_set(sie, SIE_STIE);
+	return 0;
+}
+
+static int riscv_timer_dying_cpu(unsigned int cpu)
+{
+	csr_clear(sie, SIE_STIE);
+	return 0;
+}
+
+/* called directly from the low-level interrupt handler */
+void riscv_timer_interrupt(void)
+{
+	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
+
+	csr_clear(sie, SIE_STIE);
+	evdev->event_handler(evdev);
+}
+
+static int __init riscv_timer_init_dt(struct device_node *n)
+{
+	int cpu_id = riscv_of_processor_hart(n), error;
+	struct clocksource *cs;
+
+	if (cpu_id != smp_processor_id())
+		return 0;
+
+	cs = per_cpu_ptr(&riscv_clocksource, cpu_id);
+	clocksource_register_hz(cs, riscv_timebase);
+
+	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
+			 "clockevents/riscv/timer:starting",
+			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
+	if (error)
+		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
+		       error, cpu_id);
+	return error;
+}
+
+TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 8796ba387152..554c27f6cfbd 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -125,6 +125,7 @@ enum cpuhp_state {
 	CPUHP_AP_MARCO_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
+	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
-- 
2.18.0

