Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A31B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A31B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeK2Bcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:32:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbeK2Bcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:32:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEQAkZ2322773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:26:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEQ90W2322770;
        Wed, 28 Nov 2018 06:26:09 -0800
Date:   Wed, 28 Nov 2018 06:26:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a74cfffb03b73d41e08f84c2e5c87dec0ce3db9f@git.kernel.org>
Cc:     peterz@infradead.org, casey.schaufler@intel.com, luto@kernel.org,
        dwmw@amazon.co.uk, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, asit.k.mallick@intel.com,
        david.c.stewart@intel.com, hpa@zytor.com, mingo@kernel.org,
        keescook@chromium.org, aarcange@redhat.com, dave.hansen@intel.com,
        thomas.lendacky@amd.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        jkosina@suse.cz, longman9394@gmail.com, jcm@redhat.com,
        ak@linux.intel.com
Reply-To: hpa@zytor.com, david.c.stewart@intel.com,
          asit.k.mallick@intel.com, tglx@linutronix.de,
          gregkh@linuxfoundation.org, ak@linux.intel.com, jcm@redhat.com,
          longman9394@gmail.com, jkosina@suse.cz,
          linux-kernel@vger.kernel.org, arjan@linux.intel.com,
          tim.c.chen@linux.intel.com, thomas.lendacky@amd.com,
          dave.hansen@intel.com, aarcange@redhat.com, mingo@kernel.org,
          keescook@chromium.org, peterz@infradead.org,
          torvalds@linux-foundation.org, jpoimboe@redhat.com,
          luto@kernel.org, dwmw@amazon.co.uk, casey.schaufler@intel.com
In-Reply-To: <20181125185004.521974984@linutronix.de>
References: <20181125185004.521974984@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Rework SMT state change
Git-Commit-ID: a74cfffb03b73d41e08f84c2e5c87dec0ce3db9f
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

Commit-ID:  a74cfffb03b73d41e08f84c2e5c87dec0ce3db9f
Gitweb:     https://git.kernel.org/tip/a74cfffb03b73d41e08f84c2e5c87dec0ce3db9f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:39 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:07 +0100

x86/speculation: Rework SMT state change

arch_smt_update() is only called when the sysfs SMT control knob is
changed. This means that when SMT is enabled in the sysfs control knob the
system is considered to have SMT active even if all siblings are offline.

To allow finegrained control of the speculation mitigations, the actual SMT
state is more interesting than the fact that siblings could be enabled.

Rework the code, so arch_smt_update() is invoked from each individual CPU
hotplug function, and simplify the update function while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185004.521974984@linutronix.de


---
 arch/x86/kernel/cpu/bugs.c | 11 +++++------
 include/linux/sched/smt.h  |  2 ++
 kernel/cpu.c               | 15 +++++++++------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a723af0c4400..5625b323ff32 100644
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
diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
index c9e0be514110..59d3736c454c 100644
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -15,4 +15,6 @@ static __always_inline bool sched_smt_active(void)
 static inline bool sched_smt_active(void) { return false; }
 #endif
 
+void arch_smt_update(void);
+
 #endif
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3c7f3b4c453c..91d5c38eb7e5 100644
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
@@ -367,6 +368,12 @@ static void lockdep_release_cpus_lock(void)
 
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
@@ -1011,6 +1018,7 @@ out:
 	 * concurrent CPU hotplug via cpu_add_remove_lock.
 	 */
 	lockup_detector_cleanup();
+	arch_smt_update();
 	return ret;
 }
 
@@ -1139,6 +1147,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 	ret = cpuhp_up_callbacks(cpu, st, target);
 out:
 	cpus_write_unlock();
+	arch_smt_update();
 	return ret;
 }
 
@@ -2055,12 +2064,6 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
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
