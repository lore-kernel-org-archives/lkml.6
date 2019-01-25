Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C5C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154EC218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAYQhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:37:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfAYQhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:37:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 899849FDF3;
        Fri, 25 Jan 2019 16:37:00 +0000 (UTC)
Received: from treble (ovpn-120-227.rdu2.redhat.com [10.10.120.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B835984ED;
        Fri, 25 Jan 2019 16:36:59 +0000 (UTC)
Date:   Fri, 25 Jan 2019 10:36:57 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joe Mario <jmario@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: cpu/hotplug: broken sibling thread hotplug
Message-ID: <20190125163657.rqbykfn7ebpclc2z@treble>
References: <20190124165713.2b0b37ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124165713.2b0b37ed@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 25 Jan 2019 16:37:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:57:13PM +0100, Igor Mammedov wrote:
> In case guest is booted with one CPU present and then later
> a sibling CPU is hotplugged [1], it stays offline since SMT
> is disabled.
> 
> Bisects to
>  73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")
> which used __max_smt_threads to decide disabling SMT and in
> case [1] only primary CPU thread is present hence SMT
> is disabled.
> 
> Later bc2d8d262cba (cpu/hotplug: Fix SMT supported evaluation),
> rewrites code path but evaluation criteria still depends on
> sibling thread being present at boot time, so problem persist.
> 
> 1) QEMU -smp 1,sockets=2,cores=1,threads=2 -monitor stdio ...
>    # hotplug sibling thread
>    (qemu) device_add qemu64-x86_64-cpu,socket-id=0,core-id=0,thread-id=1
> 
> I've failed to find reasoning behind statement:
>   "
>   cpu/hotplug: detect SMT disabled by BIOS
> 
>     If SMT is disabled in BIOS, the CPU code doesn't properly detect it.
>   "
> 
> Question is 
>  1: why cpu_smt_check_topology_early() at check_bugs()
> wasn't sufficient to detect SMT disabled in BIOS and
>  2: why side-effect of present at boot siblings were used
>     to keep SMT enabled?

Hi Igor,

Thanks for reporting this.

The original problems with SMT disabled in BIOS were:

1) /sys/devices/system/cpu/smt showed "on"; and

2) vmx_vm_init() was incorrectly showing the L1TF_MSG_SMT warning.

So 73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS") was
intended to fix that, by reporting SMT as permanently disabled, when the
BIOS has done so.

The problem is, I don't think there's a way to detect a difference
between the HW "SMT disabled by BIOS" case and the virt "Sibling not yet
plugged in" case.

I'd propose that we consider #1 above to *not* be a problem.  Because in
the virt case, it's possible that a sibling thread can be brought online
later.  So it makes sense to default with smt control "on" to allow for
that possibility.

The real problem is #2.  Which is a simple fix: change vmx_vm_init() to
query the current SMT state with sched_smt_active(), instead of looking
at the "control" sysfs value.

How about this patch?  It's just a revert of 73d5e2b47264 and
bc2d8d262cba, plus the 1-line vmx_vm_init() change.  If it looks ok to
you, I can clean it up and submit an official version.

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 453e66291e38..2a4db86c2780 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -70,7 +70,7 @@ void __init check_bugs(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_check_topology_early();
+	cpu_smt_check_topology();
 
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 886ad6db0926..494f32ae6e6f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11102,7 +11102,7 @@ static int vmx_vm_init(struct kvm *kvm)
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
index d7c2e48ed10d..240fb4ab3f38 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -360,8 +360,6 @@ void __weak arch_smt_update(void) { }
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 EXPORT_SYMBOL_GPL(cpu_smt_control);
 
-static bool cpu_smt_available __read_mostly;
-
 void __init cpu_smt_disable(bool force)
 {
 	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
@@ -378,25 +376,11 @@ void __init cpu_smt_disable(bool force)
 
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
 
@@ -409,18 +393,10 @@ early_param("nosmt", smt_cmdline_disable);
 
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
diff --git a/kernel/smp.c b/kernel/smp.c
index d86eec5f51c1..084c8b3a2681 100644
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


