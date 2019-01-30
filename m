Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC272C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810992184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfA3SbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:31:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732323AbfA3SbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:31:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0UIUwml2528416
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 30 Jan 2019 10:30:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0UIUvTq2528413;
        Wed, 30 Jan 2019 10:30:57 -0800
Date:   Wed, 30 Jan 2019 10:30:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-b284909abad48b07d3071a9fc9b5692b3e64914b@git.kernel.org>
Cc:     jpoimboe@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, jmario@redhat.com, peterz@infradead.org,
        imammedo@redhat.com, jikos@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, jikos@kernel.org,
          imammedo@redhat.com, peterz@infradead.org, jmario@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          jpoimboe@redhat.com
In-Reply-To: <e3a85d585da28cc333ecbc1e78ee9216e6da9396.1548794349.git.jpoimboe@redhat.com>
References: <e3a85d585da28cc333ecbc1e78ee9216e6da9396.1548794349.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] cpu/hotplug: Fix "SMT disabled by BIOS" detection
 for KVM
Git-Commit-ID: b284909abad48b07d3071a9fc9b5692b3e64914b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b284909abad48b07d3071a9fc9b5692b3e64914b
Gitweb:     https://git.kernel.org/tip/b284909abad48b07d3071a9fc9b5692b3e64914b
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 30 Jan 2019 07:13:58 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 30 Jan 2019 19:27:00 +0100

cpu/hotplug: Fix "SMT disabled by BIOS" detection for KVM

With the following commit:

  73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")

... the hotplug code attempted to detect when SMT was disabled by BIOS,
in which case it reported SMT as permanently disabled.  However, that
code broke a virt hotplug scenario, where the guest is booted with only
primary CPU threads, and a sibling is brought online later.

The problem is that there doesn't seem to be a way to reliably
distinguish between the HW "SMT disabled by BIOS" case and the virt
"sibling not yet brought online" case.  So the above-mentioned commit
was a bit misguided, as it permanently disabled SMT for both cases,
preventing future virt sibling hotplugs.

Going back and reviewing the original problems which were attempted to
be solved by that commit, when SMT was disabled in BIOS:

  1) /sys/devices/system/cpu/smt/control showed "on" instead of
     "notsupported"; and

  2) vmx_vm_init() was incorrectly showing the L1TF_MSG_SMT warning.

I'd propose that we instead consider #1 above to not actually be a
problem.  Because, at least in the virt case, it's possible that SMT
wasn't disabled by BIOS and a sibling thread could be brought online
later.  So it makes sense to just always default the smt control to "on"
to allow for that possibility (assuming cpuid indicates that the CPU
supports SMT).

The real problem is #2, which has a simple fix: change vmx_vm_init() to
query the actual current SMT state -- i.e., whether any siblings are
currently online -- instead of looking at the SMT "control" sysfs value.

So fix it by:

  a) reverting the original "fix" and its followup fix:

     73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")
     bc2d8d262cba ("cpu/hotplug: Fix SMT supported evaluation")

     and

  b) changing vmx_vm_init() to query the actual current SMT state --
     instead of the sysfs control value -- to determine whether the L1TF
     warning is needed.  This also requires the 'sched_smt_present'
     variable to exported, instead of 'cpu_smt_control'.

Fixes: 73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")
Reported-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joe Mario <jmario@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/e3a85d585da28cc333ecbc1e78ee9216e6da9396.1548794349.git.jpoimboe@redhat.com

---
 arch/x86/kernel/cpu/bugs.c |  2 +-
 arch/x86/kvm/vmx/vmx.c     |  3 ++-
 include/linux/cpu.h        |  2 --
 kernel/cpu.c               | 33 ++++-----------------------------
 kernel/sched/fair.c        |  1 +
 kernel/smp.c               |  2 --
 6 files changed, 8 insertions(+), 35 deletions(-)

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
index c0c7f64573ed..d1c6d152da89 100644
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
