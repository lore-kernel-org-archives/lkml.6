Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeFAOcg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbeFAOca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:32:30 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 02/12] perf/breakpoint: Pass arch breakpoint struct to arch_check_bp_in_kernelspace()
Date: Fri,  1 Jun 2018 16:31:55 +0200
Message-Id: <1527863526-32677-3-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527863526-32677-1-git-send-email-frederic@kernel.org>
References: <1527863526-32677-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't pass the breakpoint directly on arch_check_bp_in_kernelspace()
anymore because its architecture internal datas (struct arch_hw_breakpoint)
are not yet filled by the time we call the function, and most
implementation need this backend to be up to date. So arrange the
function to take the probing struct instead.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
---
 arch/arm/include/asm/hw_breakpoint.h     |  2 +-
 arch/arm/kernel/hw_breakpoint.c          | 11 +++--
 arch/arm64/include/asm/hw_breakpoint.h   |  2 +-
 arch/arm64/kernel/hw_breakpoint.c        |  9 ++--
 arch/powerpc/include/asm/hw_breakpoint.h |  2 +-
 arch/powerpc/kernel/hw_breakpoint.c      |  6 +--
 arch/sh/include/asm/hw_breakpoint.h      |  2 +-
 arch/sh/kernel/hw_breakpoint.c           |  9 ++--
 arch/x86/include/asm/hw_breakpoint.h     |  2 +-
 arch/x86/kernel/hw_breakpoint.c          | 71 +++++++++++++++++---------------
 arch/xtensa/include/asm/hw_breakpoint.h  |  2 +-
 arch/xtensa/kernel/hw_breakpoint.c       |  7 ++--
 kernel/events/hw_breakpoint.c            |  2 +-
 13 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index e46e4e7..d5a0f52 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -117,7 +117,7 @@ struct pmu;
 
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type);
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 629e251..385dcf4 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -456,14 +456,13 @@ static int get_hbp_len(u8 hbp_len)
 /*
  * Check whether bp virtual address is in kernel space.
  */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
 	unsigned int len;
 	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	va = info->address;
-	len = get_hbp_len(info->ctrl.len);
+	va = hw->address;
+	len = get_hbp_len(hw->ctrl.len);
 
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
@@ -576,7 +575,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 
 	/* Privilege */
 	info->ctrl.privilege = ARM_BREAKPOINT_USER;
-	if (arch_check_bp_in_kernelspace(bp))
+	if (arch_check_bp_in_kernelspace(info))
 		info->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
 
 	/* Enabled? */
@@ -640,7 +639,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 			return -EINVAL;
 
 		/* We don't allow mismatch breakpoints in kernel space. */
-		if (arch_check_bp_in_kernelspace(bp))
+		if (arch_check_bp_in_kernelspace(info))
 			return -EPERM;
 
 		/*
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 4177076..9f4a3d4 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -124,7 +124,7 @@ struct pmu;
 
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type, int *offset);
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 74bb56f..92c6973 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -344,14 +344,13 @@ static int get_hbp_len(u8 hbp_len)
 /*
  * Check whether bp virtual address is in kernel space.
  */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
 	unsigned int len;
 	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	va = info->address;
-	len = get_hbp_len(info->ctrl.len);
+	va = hw->address;
+	len = get_hbp_len(hw->ctrl.len);
 
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
@@ -503,7 +502,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * Note that we disallow combined EL0/EL1 breakpoints because
 	 * that would complicate the stepping code.
 	 */
-	if (arch_check_bp_in_kernelspace(bp))
+	if (arch_check_bp_in_kernelspace(info))
 		info->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
 	else
 		info->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 8e7b097..4d0b1bf 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -60,7 +60,7 @@ struct perf_sample_data;
 
 extern int hw_breakpoint_slots(int type);
 extern int arch_bp_generic_fields(int type, int *gen_bp_type);
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 4c1012b..348cac9 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -119,11 +119,9 @@ void arch_unregister_hw_breakpoint(struct perf_event *bp)
 /*
  * Check for virtual address in kernel space.
  */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
-	return is_kernel_addr(info->address);
+	return is_kernel_addr(hw->address);
 }
 
 int arch_bp_generic_fields(int type, int *gen_bp_type)
diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index 7431c17..8a88ed0 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -54,7 +54,7 @@ static inline int hw_breakpoint_slots(int type)
 }
 
 /* arch/sh/kernel/hw_breakpoint.c */
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index afe9657..713699b 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -124,14 +124,13 @@ static int get_hbp_len(u16 hbp_len)
 /*
  * Check for virtual address in kernel space.
  */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
 	unsigned int len;
 	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	va = info->address;
-	len = get_hbp_len(info->len);
+	va = hw->address;
+	len = get_hbp_len(hw->len);
 
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
@@ -346,7 +345,7 @@ static int __kprobes hw_breakpoint_handler(struct die_args *args)
 		perf_bp_event(bp, args->regs);
 
 		/* Deliver the signal to userspace */
-		if (!arch_check_bp_in_kernelspace(bp)) {
+		if (!arch_check_bp_in_kernelspace(&bp->hw.info)) {
 			siginfo_t info;
 
 			info.si_signo = args->signr;
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index f59c398..7892459 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -52,7 +52,7 @@ static inline int hw_breakpoint_slots(int type)
 struct perf_event;
 struct pmu;
 
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 8771766..c433791 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -169,28 +169,29 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 		set_dr_addr_mask(0, i);
 }
 
-/*
- * Check for virtual address in kernel space.
- */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+static int arch_bp_generic_len(int x86_len)
 {
-	unsigned int len;
-	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
-	va = info->address;
-	len = bp->attr.bp_len;
-
-	/*
-	 * We don't need to worry about va + len - 1 overflowing:
-	 * we already require that va is aligned to a multiple of len.
-	 */
-	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
+	switch (x86_len) {
+	case X86_BREAKPOINT_LEN_1:
+		return HW_BREAKPOINT_LEN_1;
+	case X86_BREAKPOINT_LEN_2:
+		return HW_BREAKPOINT_LEN_2;
+	case X86_BREAKPOINT_LEN_4:
+		return HW_BREAKPOINT_LEN_4;
+#ifdef CONFIG_X86_64
+	case X86_BREAKPOINT_LEN_8:
+		return HW_BREAKPOINT_LEN_8;
+#endif
+	default:
+		return -EINVAL;
+	}
 }
 
 int arch_bp_generic_fields(int x86_len, int x86_type,
 			   int *gen_len, int *gen_type)
 {
+	int len;
+
 	/* Type */
 	switch (x86_type) {
 	case X86_BREAKPOINT_EXECUTE:
@@ -211,28 +212,32 @@ int arch_bp_generic_fields(int x86_len, int x86_type,
 	}
 
 	/* Len */
-	switch (x86_len) {
-	case X86_BREAKPOINT_LEN_1:
-		*gen_len = HW_BREAKPOINT_LEN_1;
-		break;
-	case X86_BREAKPOINT_LEN_2:
-		*gen_len = HW_BREAKPOINT_LEN_2;
-		break;
-	case X86_BREAKPOINT_LEN_4:
-		*gen_len = HW_BREAKPOINT_LEN_4;
-		break;
-#ifdef CONFIG_X86_64
-	case X86_BREAKPOINT_LEN_8:
-		*gen_len = HW_BREAKPOINT_LEN_8;
-		break;
-#endif
-	default:
+	len = arch_bp_generic_len(x86_len);
+	if (len < 0)
 		return -EINVAL;
-	}
+	*gen_len = len;
 
 	return 0;
 }
 
+/*
+ * Check for virtual address in kernel space.
+ */
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
+{
+	unsigned long va;
+	int len;
+
+	va = hw->address;
+	len = arch_bp_generic_len(hw->len);
+	WARN_ON_ONCE(len < 0);
+
+	/*
+	 * We don't need to worry about va + len - 1 overflowing:
+	 * we already require that va is aligned to a multiple of len.
+	 */
+	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
+}
 
 static int arch_build_bp_info(struct perf_event *bp)
 {
diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
index dbe3053b..2525bf6 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -35,7 +35,7 @@ struct pt_regs;
 struct task_struct;
 
 int hw_breakpoint_slots(int type);
-int arch_check_bp_in_kernelspace(struct perf_event *bp);
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 int arch_validate_hwbkpt_settings(struct perf_event *bp);
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data);
diff --git a/arch/xtensa/kernel/hw_breakpoint.c b/arch/xtensa/kernel/hw_breakpoint.c
index b35656a..6e34c38 100644
--- a/arch/xtensa/kernel/hw_breakpoint.c
+++ b/arch/xtensa/kernel/hw_breakpoint.c
@@ -33,14 +33,13 @@ int hw_breakpoint_slots(int type)
 	}
 }
 
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
 	unsigned int len;
 	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	va = info->address;
-	len = bp->attr.bp_len;
+	va = hw->address;
+	len = hw->len;
 
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 314e2a9..89fe94c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -427,7 +427,7 @@ static int hw_breakpoint_parse(struct perf_event *bp,
 	if (err)
 		return err;
 
-	if (arch_check_bp_in_kernelspace(bp)) {
+	if (arch_check_bp_in_kernelspace(hw)) {
 		if (attr->exclude_kernel)
 			return -EINVAL;
 		/*
-- 
2.7.4
