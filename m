Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A714C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9D22086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBBFVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 00:21:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:23424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfBBFVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 00:21:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 21:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="scan'208";a="271934506"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2019 21:21:21 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Michael Chan" <michael.chan@broadcom.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Ricardo Neri" <ricardo.neri@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 10/10] x86/split_lock: Handle #AC exception for split lock
Date:   Fri,  1 Feb 2019 21:14:51 -0800
Message-Id: <1549084491-57808-11-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be different considerations on how to handle #AC for split lock,
e.g. how to handle system hang caused by split lock issue in firmware,
how to emulate faulting instruction, etc. We use a simple method to
handle user and kernel split lock and may extend the method in the future.

When #AC exception for split lock is triggered from user process, the
process is killed by SIGBUS. To execute the process properly, user
application developer needs to fix the split lock issue.

When #AC exception for split lock is triggered from a kernel instruction,
disable #AC for split lock on local CPU and warn the split lock issue.
After the exception, the faulting instruction will be executed and kernel
execution continues. #AC for split lock is only disabled on the local CPU
not globally. It will be re-enabled if the CPU is offline and then online.

Kernel developer should check the warning, which contains helpful faulting
address, context, and callstack info, and fix the split lock issue
one by one. Then further split lock may be captured and fixed.

After bit 29 in MSR_TEST_CTL is set as one in kernel, firmware inherits
the setting when firmware is executed in S4, S5, run time services, SMI,
etc. Split lock issue in firmware triggers #AC and may hang the system
depending on how firmware handles the #AC. It's up to firmware developer
to fix the split lock issues in firmware.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h       |  2 ++
 arch/x86/include/asm/msr-index.h |  4 ++++
 arch/x86/kernel/cpu/intel.c      | 25 +++++++++++++++++++++++++
 arch/x86/kernel/setup.c          |  3 +++
 arch/x86/kernel/smpboot.c        |  3 +++
 arch/x86/kernel/traps.c          | 30 +++++++++++++++++++++++++++++-
 6 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..21792b295a61 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,6 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+void set_ac_split_lock(void);
+bool do_ac_split_lock(struct pt_regs *regs);
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8e40c2446fd1..74cf8a0f1512 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -39,6 +39,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTL				0x00000033
+#define TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT	29
+#define TEST_CTL_ENABLE_AC_SPLIT_LOCK		BIT(29)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07fe7df5..d813fd64ecef 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1029,3 +1029,28 @@ static const struct cpu_dev intel_cpu_dev = {
 
 cpu_dev_register(intel_cpu_dev);
 
+/* #AC handler for split lock is called by generic #AC handler. */
+bool do_ac_split_lock(struct pt_regs *regs)
+{
+	/* Generic #AC handler will handle split lock in user. */
+	if (user_mode(regs))
+		return false;
+
+	/*
+	 * On split lock in kernel, warn and disable #AC for split lock on
+	 * current CPU.
+	 */
+	msr_clear_bit(MSR_TEST_CTL, TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT);
+
+	WARN_ONCE(1, "A split lock issue is detected.\n");
+
+	return true;
+}
+
+void set_ac_split_lock(void)
+{
+	if (boot_cpu_has(X86_FEATURE_AC_SPLIT_LOCK)) {
+		msr_set_bit(MSR_TEST_CTL, TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT);
+		pr_info_once("#AC for split lock is enabled\n");
+	}
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a527cd9..7517debc8f61 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -961,6 +961,9 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	/* Set up #AC for split lock at the earliest phase. */
+	set_ac_split_lock();
+
 	if (efi_enabled(EFI_BOOT))
 		efi_memblock_x86_reserve_range();
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ccd1f2a8e557..3ef843045564 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -231,6 +231,9 @@ static void notrace start_secondary(void *unused)
 #endif
 	load_current_idt();
 	cpu_init();
+
+	set_ac_split_lock();
+
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
 	smp_callin();
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9b7c4ca8f0a7..f3cadf2d177f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/cpu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -292,9 +293,36 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
-DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
 #undef IP
 
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
+{
+	unsigned int trapnr = X86_TRAP_AC;
+	char str[] = "alignment check";
+	int signr = SIGBUS;
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
+		do_trap(trapnr, signr, str, regs, error_code, BUS_ADRALN, NULL);
+	}
+}
+
 #ifdef CONFIG_VMAP_STACK
 __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
-- 
2.7.4

