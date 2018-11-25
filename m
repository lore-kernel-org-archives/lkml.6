Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2755BC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F228521473
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F228521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeKZFtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52746 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeKZFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:02 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzan-0003PR-L2; Sun, 25 Nov 2018 19:57:17 +0100
Message-Id: <20181125185004.521974984@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:39 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch V2 11/28] x86/speculation: Rework SMT state change
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Rework-SMT-state-change.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_smt_update() is only called when the sysfs SMT control knob is
changed. This means that when SMT is enabled in the sysfs control knob the
system is considered to have SMT active even if all siblings are offline.

To allow finegrained control of the speculation mitigations, the actual SMT
state is more interesting than the fact that siblings could be enabled.

Rework the code, so arch_smt_update() is invoked from each individual CPU
hotplug function, and simplify the update function while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

v1 -> v2: Adapt to new header sched/smt.h

---

 arch/x86/kernel/cpu/bugs.c |   11 +++++------
 include/linux/sched/smt.h  |    2 ++
 kernel/cpu.c               |   15 +++++++++------
 3 files changed, 16 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
+#include <linux/sched/smt.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -344,16 +345,14 @@ void arch_smt_update(void)
 		return;
 
 	mutex_lock(&spec_ctrl_mutex);
-	mask = x86_spec_ctrl_base;
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+
+	mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
+	if (sched_smt_active())
 		mask |= SPEC_CTRL_STIBP;
-	else
-		mask &= ~SPEC_CTRL_STIBP;
 
 	if (mask != x86_spec_ctrl_base) {
 		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
-				cpu_smt_control == CPU_SMT_ENABLED ?
-				"Enabling" : "Disabling");
+			mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
 		x86_spec_ctrl_base = mask;
 		on_each_cpu(update_stibp_msr, NULL, 1);
 	}
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -15,4 +15,6 @@ static __always_inline bool sched_smt_ac
 static inline bool sched_smt_active(void) { return false; }
 #endif
 
+void arch_smt_update(void);
+
 #endif
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -10,6 +10,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/task.h>
+#include <linux/sched/smt.h>
 #include <linux/unistd.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
@@ -367,6 +368,12 @@ static void lockdep_release_cpus_lock(vo
 
 #endif	/* CONFIG_HOTPLUG_CPU */
 
+/*
+ * Architectures that need SMT-specific errata handling during SMT hotplug
+ * should override this.
+ */
+void __weak arch_smt_update(void) { }
+
 #ifdef CONFIG_HOTPLUG_SMT
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 EXPORT_SYMBOL_GPL(cpu_smt_control);
@@ -1011,6 +1018,7 @@ static int __ref _cpu_down(unsigned int
 	 * concurrent CPU hotplug via cpu_add_remove_lock.
 	 */
 	lockup_detector_cleanup();
+	arch_smt_update();
 	return ret;
 }
 
@@ -1139,6 +1147,7 @@ static int _cpu_up(unsigned int cpu, int
 	ret = cpuhp_up_callbacks(cpu, st, target);
 out:
 	cpus_write_unlock();
+	arch_smt_update();
 	return ret;
 }
 
@@ -2055,12 +2064,6 @@ static void cpuhp_online_cpu_device(unsi
 	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
 
-/*
- * Architectures that need SMT-specific errata handling during SMT hotplug
- * should override this.
- */
-void __weak arch_smt_update(void) { };
-
 static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 {
 	int cpu, ret = 0;


