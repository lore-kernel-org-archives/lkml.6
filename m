Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E49CC282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396B9218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBCQQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:16:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfBCQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:16:09 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gqKRC-0004Ka-RK; Sun, 03 Feb 2019 17:16:07 +0100
Subject: [GIT pull] cpu hotplug updates for 5.0
Message-ID: <154921049412.12839.5997726190802534205.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
Date:   Sun, 03 Feb 2019 17:16:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp-urgent-for-linus git tree from:

       git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

Two fixes for the cpu hotplug machinery:

   - Replace the overly clever 'SMT disabled by BIOS' detection logic as it
     breaks KVM scenarios and prevents speculation control updates when the
     Hyperthreads are brought online late after boot.

   - Remove a redundant invocation of the speculation control update function.

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      cpu/hotplug: Fix "SMT disabled by BIOS" detection for KVM

Zhenzhong Duan (1):
      x86/speculation: Remove redundant arch_smt_update() invocation


 arch/x86/kernel/cpu/bugs.c |  2 +-
 arch/x86/kvm/vmx/vmx.c     |  3 ++-
 include/linux/cpu.h        |  2 --
 kernel/cpu.c               | 38 +++++---------------------------------
 kernel/sched/fair.c        |  1 +
 kernel/smp.c               |  2 --
 6 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1de0f4170178..01874d54f4fd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -71,7 +71,7 @@ void __init check_bugs(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_check_topology_early();
+	cpu_smt_check_topology();
 
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4341175339f3..95d618045001 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -26,6 +26,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/sched/smt.h>
 #include <linux/slab.h>
 #include <linux/tboot.h>
 #include <linux/trace_events.h>
@@ -6823,7 +6824,7 @@ static int vmx_vm_init(struct kvm *kvm)
 			 * Warn upon starting the first VM in a potentially
 			 * insecure environment.
 			 */
-			if (cpu_smt_control == CPU_SMT_ENABLED)
+			if (sched_smt_active())
 				pr_warn_once(L1TF_MSG_SMT);
 			if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER)
 				pr_warn_once(L1TF_MSG_L1D);
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 218df7f4d3e1..5041357d0297 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -180,12 +180,10 @@ enum cpuhp_smt_control {
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
 extern enum cpuhp_smt_control cpu_smt_control;
 extern void cpu_smt_disable(bool force);
-extern void cpu_smt_check_topology_early(void);
 extern void cpu_smt_check_topology(void);
 #else
 # define cpu_smt_control		(CPU_SMT_ENABLED)
 static inline void cpu_smt_disable(bool force) { }
-static inline void cpu_smt_check_topology_early(void) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38eb7e5..d1c6d152da89 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -376,9 +376,6 @@ void __weak arch_smt_update(void) { }
 
 #ifdef CONFIG_HOTPLUG_SMT
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
-EXPORT_SYMBOL_GPL(cpu_smt_control);
-
-static bool cpu_smt_available __read_mostly;
 
 void __init cpu_smt_disable(bool force)
 {
@@ -397,25 +394,11 @@ void __init cpu_smt_disable(bool force)
 
 /*
  * The decision whether SMT is supported can only be done after the full
- * CPU identification. Called from architecture code before non boot CPUs
- * are brought up.
- */
-void __init cpu_smt_check_topology_early(void)
-{
-	if (!topology_smt_supported())
-		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
-}
-
-/*
- * If SMT was disabled by BIOS, detect it here, after the CPUs have been
- * brought online. This ensures the smt/l1tf sysfs entries are consistent
- * with reality. cpu_smt_available is set to true during the bringup of non
- * boot CPUs when a SMT sibling is detected. Note, this may overwrite
- * cpu_smt_control's previous setting.
+ * CPU identification. Called from architecture code.
  */
 void __init cpu_smt_check_topology(void)
 {
-	if (!cpu_smt_available)
+	if (!topology_smt_supported())
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
 }
 
@@ -428,18 +411,10 @@ early_param("nosmt", smt_cmdline_disable);
 
 static inline bool cpu_smt_allowed(unsigned int cpu)
 {
-	if (topology_is_primary_thread(cpu))
+	if (cpu_smt_control == CPU_SMT_ENABLED)
 		return true;
 
-	/*
-	 * If the CPU is not a 'primary' thread and the booted_once bit is
-	 * set then the processor has SMT support. Store this information
-	 * for the late check of SMT support in cpu_smt_check_topology().
-	 */
-	if (per_cpu(cpuhp_state, cpu).booted_once)
-		cpu_smt_available = true;
-
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+	if (topology_is_primary_thread(cpu))
 		return true;
 
 	/*
@@ -2090,10 +2065,8 @@ static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		 */
 		cpuhp_offline_cpu_device(cpu);
 	}
-	if (!ret) {
+	if (!ret)
 		cpu_smt_control = ctrlval;
-		arch_smt_update();
-	}
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2104,7 +2077,6 @@ static int cpuhp_smt_enable(void)
 
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
-	arch_smt_update();
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 50aa2aba69bd..310d0637fe4b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5980,6 +5980,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 
 #ifdef CONFIG_SCHED_SMT
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
+EXPORT_SYMBOL_GPL(sched_smt_present);
 
 static inline void set_idle_cores(int cpu, int val)
 {
diff --git a/kernel/smp.c b/kernel/smp.c
index 163c451af42e..f4cf1b0bb3b8 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -584,8 +584,6 @@ void __init smp_init(void)
 		num_nodes, (num_nodes > 1 ? "s" : ""),
 		num_cpus,  (num_cpus  > 1 ? "s" : ""));
 
-	/* Final decision about SMT support */
-	cpu_smt_check_topology();
 	/* Any cleanup work */
 	smp_cpus_done(setup_max_cpus);
 }

