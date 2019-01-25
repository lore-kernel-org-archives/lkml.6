Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F25C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE1D218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfAYRCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:02:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfAYRCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:02:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DCE6804ED;
        Fri, 25 Jan 2019 17:02:11 +0000 (UTC)
Received: from treble (ovpn-120-227.rdu2.redhat.com [10.10.120.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A65E060930;
        Fri, 25 Jan 2019 17:02:05 +0000 (UTC)
Date:   Fri, 25 Jan 2019 11:02:03 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joe Mario <jmario@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: cpu/hotplug: broken sibling thread hotplug
Message-ID: <20190125170203.2o2l27d2sytw44nl@treble>
References: <20190124165713.2b0b37ed@redhat.com>
 <20190125163657.rqbykfn7ebpclc2z@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125163657.rqbykfn7ebpclc2z@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 25 Jan 2019 17:02:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:36:57AM -0600, Josh Poimboeuf wrote:
> How about this patch?  It's just a revert of 73d5e2b47264 and
> bc2d8d262cba, plus the 1-line vmx_vm_init() change.  If it looks ok to
> you, I can clean it up and submit an official version.

This one actually compiles...


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
index f6915f10e584..e2d6fa3c60d5 100644
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
@@ -6816,7 +6817,7 @@ static int vmx_vm_init(struct kvm *kvm)
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
index 34e40ef2f6e0..05d359e4173a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -387,8 +387,6 @@ void __weak arch_smt_update(void) { }
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 EXPORT_SYMBOL_GPL(cpu_smt_control);
 
-static bool cpu_smt_available __read_mostly;
-
 void __init cpu_smt_disable(bool force)
 {
 	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
@@ -406,25 +404,11 @@ void __init cpu_smt_disable(bool force)
 
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
 
@@ -437,18 +421,10 @@ early_param("nosmt", smt_cmdline_disable);
 
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
