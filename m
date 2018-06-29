Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB5C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3FC27FAF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3FC27FAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965273AbeF2OfC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:35:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:9675 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755249AbeF2Oeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:34:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 07:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="51490718"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2018 07:34:45 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 3/4] x86/split_lock: Handle #AC exception for split lock
Date:   Fri, 29 Jun 2018 07:33:26 -0700
Message-Id: <1530282807-66555-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be different considerations on how to handle #AC for split lock,
e.g. how to handle system hang caused by split lock issue in firmware, if
need to emulate faulting instruction, etc. We use a simple method to
handle user and kernel split lock and may extend the method in the future.

When #AC exception for split lock is triggered from user process, the
process is killed by SIGBUS. To execute the process properly, user
application developer needs to fix the split lock issue.

When #AC exception for split lock is triggered from a kernel instruction,
disable #AC for split lock on local CPU and warn the split lock issue.
After the exception, the faulting instruction will be executed and kernel
execution continues. #AC for split lock is only disabled on the local CPU
not globally. It will be re-enabled if the CPU is offline and then online.

Kernel developer should check the warning and fix the split lock issue
one by one. Then further split lock may be captured and fixed.

After bit 29 in MSR_TEST_CTL is set as one in kernel, firmware inherits
the setting when firmware is executed in S4, S5, run time services, SMI,
etc. Split lock issue in firmware triggers #AC and may hang the system
depending on how firmware handles the #AC. It's up to firmware developer
to fix the split lock issues in firmware.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h     |  2 ++
 arch/x86/kernel/cpu/test_ctl.c | 41 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/setup.c        |  2 ++
 arch/x86/kernel/smpboot.c      |  3 +++
 arch/x86/kernel/traps.c        | 32 +++++++++++++++++++++++++++++++-
 5 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index bd64380d598b..836d7e3f70c8 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -41,4 +41,6 @@ unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
 void detect_ac_split_lock(void);
+void setup_ac_split_lock(void);
+bool do_ac_split_lock(struct pt_regs *regs);
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index af1822469c94..f12e8b24215d 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -7,10 +7,17 @@
  * Author:
  *	Fenghua Yu <fenghua.yu@intel.com>
  */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/printk.h>
 #include <linux/cpufeature.h>
+#include <linux/cpu.h>
 #include <asm/msr.h>
 
+/* By default, #AC for split lock is enabled. */
+static bool enable_ac_split_lock = true;
+
 /* Detect feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
 void detect_ac_split_lock(void)
 {
@@ -44,3 +51,37 @@ void detect_ac_split_lock(void)
 	 */
 	wrmsrl(MSR_TEST_CTL, orig_val);
 }
+
+/*
+ * #AC handler for split lock is called by generic #AC handler.
+ *
+ * On split lock in kernel, warn and disable #AC for split lock on current CPU.
+ *
+ * On split lock in user process, send SIGBUS in the generic #AC handler.
+ */
+bool do_ac_split_lock(struct pt_regs *regs)
+{
+	/* Generic #AC handler will handle split lock in user. */
+	if (user_mode(regs))
+		return false;
+
+	/* Clear the split lock bit to disable the feature on local CPU. */
+	msr_clear_bit(MSR_TEST_CTL, MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT);
+
+	WARN_ONCE(1, "A split lock issue is detected. Please FIX it\n");
+
+	return true;
+}
+
+void setup_ac_split_lock(void)
+{
+	if (enable_ac_split_lock) {
+		msr_set_bit(MSR_TEST_CTL,
+			    MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT);
+		pr_info_once("#AC for split lock is enabled\n");
+	} else {
+		msr_clear_bit(MSR_TEST_CTL,
+			      MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT);
+		pr_info_once("#AC for split lock is disabled\n");
+	}
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 18de4e35a4e5..ca4ef8325dfe 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -954,6 +954,8 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	detect_ac_split_lock();
+	/* Set up #AC for split lock at the earliest phase. */
+	setup_ac_split_lock();
 
 	if (efi_enabled(EFI_BOOT))
 		efi_memblock_x86_reserve_range();
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c2f7d1d2a5c3..d6b224e6284f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -225,6 +225,9 @@ static void notrace start_secondary(void *unused)
 #endif
 	load_current_idt();
 	cpu_init();
+
+	setup_ac_split_lock();
+
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
 	smp_callin();
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e6db475164ed..dd309a7b46bd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/cpu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -318,7 +319,36 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,  "coprocessor segment overrun",coprocessor_seg
 DO_ERROR(X86_TRAP_TS,     SIGSEGV, "invalid TSS",		invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,  "segment not present",	segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,  "stack segment",		stack_segment)
-DO_ERROR(X86_TRAP_AC,     SIGBUS,  "alignment check",		alignment_check)
+
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
+{
+	unsigned int trapnr = X86_TRAP_AC;
+	char str[] = "alignment check";
+	int signr = SIGBUS;
+	siginfo_t info;
+	int ret;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
+			NOTIFY_STOP) {
+		/* #AC exception could be handled by split lock handler. */
+		ret = do_ac_split_lock(regs);
+		if (ret) {
+			cond_local_irq_enable(regs);
+
+			return;
+		}
+
+		cond_local_irq_enable(regs);
+		/*
+		 * If not processed by split lock handler, go to generic
+		 * #AC handler.
+		 */
+		do_trap(trapnr, signr, str, regs, error_code,
+			fill_trap_info(regs, signr, trapnr, &info));
+	}
+}
 
 #ifdef CONFIG_VMAP_STACK
 __visible void __noreturn handle_stack_overflow(const char *message,
-- 
2.5.0

