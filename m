Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D2521B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895886;
	bh=4ITDLNHYGlv0Ye6ZFNqgU0e9JhpLDTwG8VGN5MGDrxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dB8mDo4z6D65jChZHzFwNaHcpvjCoHRe8VqVmyXqfgHaom/TsTbTEg06GvzwaAG/r
	 Q28ZBBHmra+yDmlJOR4XOKsU+V85NBfVhEUOSM8Z56Me9VRBATq/n2tMHwtT0/FL50
	 6X9th08tF5EvqDU+eQVZetIrhkJaZLVijNCqqxt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfBKOiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbfBKOiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51EE2081B;
        Mon, 11 Feb 2019 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895880;
        bh=4ITDLNHYGlv0Ye6ZFNqgU0e9JhpLDTwG8VGN5MGDrxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqVWS6ygdryK93ot0WNhc+Aldu1IzEbNEbQ0iOAAUUzkpvsg7fXyp6PlrYBBbFx5+
         Nia453xD58cmlrGM5ojjV+DW155rpWb4bLTSkTAJCIov8WoXoH45hv1d1drVl7ZORK
         zRWP2jG+bXjzTvoVEcCjgzcvbREDIhGaR+TvHyt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joe Mario <jmario@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org
Subject: [PATCH 4.20 342/352] cpu/hotplug: Fix "SMT disabled by BIOS" detection for KVM
Date:   Mon, 11 Feb 2019 15:19:29 +0100
Message-Id: <20190211141908.953848044@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit b284909abad48b07d3071a9fc9b5692b3e64914b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 arch/x86/kvm/vmx.c         |    3 ++-
 include/linux/cpu.h        |    2 --
 kernel/cpu.c               |   33 ++++-----------------------------
 kernel/sched/fair.c        |    1 +
 kernel/smp.c               |    2 --
 6 files changed, 8 insertions(+), 35 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -69,7 +69,7 @@ void __init check_bugs(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_check_topology_early();
+	cpu_smt_check_topology();
 
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
+#include <linux/sched/smt.h>
 #include <linux/moduleparam.h>
 #include <linux/mod_devicetable.h>
 #include <linux/trace_events.h>
@@ -11643,7 +11644,7 @@ static int vmx_vm_init(struct kvm *kvm)
 			 * Warn upon starting the first VM in a potentially
 			 * insecure environment.
 			 */
-			if (cpu_smt_control == CPU_SMT_ENABLED)
+			if (sched_smt_active())
 				pr_warn_once(L1TF_MSG_SMT);
 			if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER)
 				pr_warn_once(L1TF_MSG_L1D);
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
 
@@ -428,18 +411,10 @@ early_param("nosmt", smt_cmdline_disable
 
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
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5934,6 +5934,7 @@ static inline int find_idlest_cpu(struct
 
 #ifdef CONFIG_SCHED_SMT
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
+EXPORT_SYMBOL_GPL(sched_smt_present);
 
 static inline void set_idle_cores(int cpu, int val)
 {
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


