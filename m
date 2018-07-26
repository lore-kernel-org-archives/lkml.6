Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7218C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7668620673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JWIIkjqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7668620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbeGZPzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:55:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P4Rqed+KAh7yMJ/d3cUDc00ima69YKzvyZRItCJtLPQ=; b=JWIIkjqF9ijX8vTvFRaYQrPIh
        m/u76qGHNLYGzNj5UcFN0dI9Qj3BElwKaUGL/53ezMb15tjeXh4g8tS5rfoos7q1iZ36tp+43VjqT
        GXrz40h5SdzGtN586rGWAX3nO83Ja5Bknhe5UWFdAgPUMLr3fepmLnG1LXOYXJr44kteQ0degl9sc
        wi0LNprgh1c43YFhC8dK9NftPQE0CfR4Rxh+VYQBgcemCB0ctnT6QGqDVlAz/FxVkFiTJuK2ks5Ve
        LNm0PCdE2DHB4WR+bNi1oBs6WIPvVV7oC+LxR9yCiUAb2BJITuZxDn5icxvBhcYrRL3FaOxXknjwy
        OohQlYdkQ==;
Received: from 213-225-8-157.nat.highway.a1.net ([213.225.8.157] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fihOu-0005uD-Qf; Thu, 26 Jul 2018 14:37:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>
Subject: [PATCH 9/9] clocksource: new RISC-V SBI timer driver
Date:   Thu, 26 Jul 2018 16:37:23 +0200
Message-Id: <20180726143723.16585-10-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726143723.16585-1-hch@lst.de>
References: <20180726143723.16585-1-hch@lst.de>
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
[hch: remove dead code, add SPDX tags, minor cleanups, merged
 hotplug cpu and other improvements from Atish]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/smp.h      |   3 -
 arch/riscv/kernel/irq.c           |   3 +
 arch/riscv/kernel/smpboot.c       |   1 -
 arch/riscv/kernel/time.c          |   8 +-
 drivers/clocksource/Kconfig       |  10 +++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/riscv_timer.c | 121 ++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h        |   1 +
 8 files changed, 137 insertions(+), 11 deletions(-)
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
index 1bb01dc2d0f1..94e9ca18f5fa 100644
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
 static long __init timebase_frequency(void)
 {
 	struct device_node *cpu;
@@ -43,5 +37,5 @@ void __init time_init(void)
 {
 	riscv_timebase = timebase_frequency();
 	lpj_fine = riscv_timebase / HZ;
-	init_clockevent();
+	timer_probe();
 }
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd88ec15..a57083efaae8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -609,4 +609,14 @@ config ATCPIT100_TIMER
 	help
 	  This option enables support for the Andestech ATCPIT100 timers.
 
+config RISCV_TIMER
+	bool "Timer for the RISC-V platform"
+	depends on RISCV || COMPILE_TEST
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
index 000000000000..146156448bdd
--- /dev/null
+++ b/drivers/clocksource/riscv_timer.c
@@ -0,0 +1,121 @@
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
+#define MINDELTA 100
+#define MAXDELTA 0x7fffffff
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
+ * It is guarnteed that all the timers across all the harts are synchronized
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
+static int timer_riscv_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
+
+	ce->cpumask = cpumask_of(cpu);
+	clockevents_config_and_register(ce, riscv_timebase, MINDELTA, MAXDELTA);
+	csr_set(sie, SIE_STIE);
+	return 0;
+}
+
+static int timer_riscv_dying_cpu(unsigned int cpu)
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
+static int hart_of_timer(struct device_node *dev)
+{
+	u32 hart;
+
+	if (!dev)
+		return -1;
+	if (!of_device_is_compatible(dev, "riscv"))
+		return -1;
+	if (of_property_read_u32(dev, "reg", &hart))
+		return -1;
+
+	return hart;
+}
+
+static int __init timer_riscv_init_dt(struct device_node *n)
+{
+	int cpu_id = hart_of_timer(n), error;
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
+			 timer_riscv_starting_cpu, timer_riscv_dying_cpu);
+	if (error)
+		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
+		       error, cpu_id);
+	return error;
+}
+
+TIMER_OF_DECLARE(riscv_timer, "riscv", timer_riscv_init_dt);
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

