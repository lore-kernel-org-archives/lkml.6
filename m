Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeDMVuA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:50:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43223 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeDMVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:49:35 -0400
X-IronPort-AV: E=Sophos;i="5.48,446,1517846400";
   d="scan'208";a="75828833"
From: Atish Patra <atish.patra@wdc.com>
To: palmer@sifive.com, linux-riscv@lists.infradead.org
Cc: albert@sifive.com, tglx@linutronix.de, mjc@sifive.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] RISCV: Register clocksource and events correctly
Date: Fri, 13 Apr 2018 14:49:33 -0700
Message-Id: <1523656174-249811-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523656174-249811-1-git-send-email-atish.patra@wdc.com>
References: <1523656174-249811-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, timer_probe() is called for every cpu and clocksource
is registered multiple times for each cpu which is wrong.

Probe timer only once during init and register the clock source at
that time. Move the clock event registration cpu online notification
callback. Take this opportunity to remove redundant functions as well.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/smp.h      |  2 +-
 arch/riscv/kernel/time.c          |  9 +-------
 drivers/clocksource/riscv_timer.c | 44 ++++++++++++++++++++++++++-------------
 include/linux/cpuhotplug.h        |  1 +
 4 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 85e4220..01b8df8 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -25,7 +25,7 @@
 #ifdef CONFIG_SMP
 
 /* SMP initialization hook for setup_arch */
-void __init init_clockevent(void);
+void init_clockevent(void);
 
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 67709cb..bcd3e76 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -39,13 +39,6 @@ void riscv_timer_interrupt(void)
 #endif
 }
 
-void __init init_clockevent(void)
-{
-	timer_probe();
-	csr_set(sie, SIE_STIE);
-}
-
-
 static long __init timebase_frequency(void)
 {
 	struct device_node *cpu;
@@ -65,5 +58,5 @@ void __init time_init(void)
 {
 	riscv_timebase = timebase_frequency();
 	lpj_fine = riscv_timebase / HZ;
-	init_clockevent();
+	timer_probe();
 }
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 59a734c..8b45af2 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/timer_riscv.h>
 #include <linux/sched_clock.h>
+#include <linux/cpu.h>
 #include <asm/sbi.h>
 
 #define MINDELTA 100
@@ -71,16 +72,6 @@ DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
 	.read = rdtime,
 };
 
-void timer_riscv_init(int cpu_id,
-		      unsigned long riscv_timebase,
-		      int (*next)(unsigned long, struct clock_event_device*))
-{
-	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu_id);
-
-	ce->cpumask = cpumask_of(cpu_id);
-	clockevents_config_and_register(ce, riscv_timebase, MINDELTA, MAXDELTA);
-}
-
 static int hart_of_timer(struct device_node *dev)
 {
 	u32 hart;
@@ -100,21 +91,44 @@ static u64 notrace timer_riscv_sched_read(void)
 	return get_cycles64();
 }
 
+static int timer_riscv_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
+
+	ce->cpumask = cpumask_of(cpu);
+	clockevents_config_and_register(ce, riscv_timebase, MINDELTA, MAXDELTA);
+	/* Enable timer interrupt for this cpu */
+	csr_set(sie, SIE_STIE);
+
+	return 0;
+}
+
+static int timer_riscv_dying_cpu(unsigned int cpu)
+{
+	/* Disable timer interrupt for this cpu */
+	csr_clear(sie, SIE_STIE);
+
+	return 0;
+}
+
 static int __init timer_riscv_init_dt(struct device_node *n)
 {
+	int err = 0;
 	int cpu_id = hart_of_timer(n);
-	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu_id);
 	struct clocksource *cs = per_cpu_ptr(&riscv_clocksource, cpu_id);
 
 	if (cpu_id == smp_processor_id()) {
 		clocksource_register_hz(cs, riscv_timebase);
 		sched_clock_register(timer_riscv_sched_read, 64, riscv_timebase);
 
-		ce->cpumask = cpumask_of(cpu_id);
-		clockevents_config_and_register(ce, riscv_timebase, MINDELTA, MAXDELTA);
+		err = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
+			 "clockevents/riscv/timer:starting",
+			 timer_riscv_starting_cpu, timer_riscv_dying_cpu);
+		if (err)
+			pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
+			       err, cpu_id);
 	}
-
-	return 0;
+	return err;
 }
 
 TIMER_OF_DECLARE(riscv_timer, "riscv", timer_riscv_init_dt);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1a32e55..c68f924 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -126,6 +126,7 @@ enum cpuhp_state {
 	CPUHP_AP_MARCO_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
+	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
-- 
2.7.4
