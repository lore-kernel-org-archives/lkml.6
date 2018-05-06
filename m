Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeEFTVO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 15:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbeEFTUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 15:20:50 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 8/9] perf/breakpoint: Split breakpoint "check" and "commit"
Date: Sun,  6 May 2018 21:19:54 +0200
Message-Id: <1525634395-23380-9-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525634395-23380-1-git-send-email-frederic@kernel.org>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_validate_hwbkpt_settings() mixes up attribute check and commit into
a single code entity. Therefore the validation may return an error due to
incorrect atributes while still leaving halfway modified architecture
breakpoint struct.

Now that we have split its logic on all archs, we can remove this
misdesigned function and call directly the arch check and commit
functions instead. This allows us to later avoid commiting
a breakpoint to architecture when its slot couldn't be allocated.

Original-patch-by: Andy Lutomirski <luto@kernel.org>
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
---
 arch/arm/include/asm/hw_breakpoint.h     |  5 ++++-
 arch/arm/kernel/hw_breakpoint.c          | 22 +++-------------------
 arch/arm64/include/asm/hw_breakpoint.h   |  5 ++++-
 arch/arm64/kernel/hw_breakpoint.c        | 22 +++-------------------
 arch/powerpc/include/asm/hw_breakpoint.h |  5 ++++-
 arch/powerpc/kernel/hw_breakpoint.c      | 22 +++-------------------
 arch/sh/include/asm/hw_breakpoint.h      |  5 ++++-
 arch/sh/kernel/hw_breakpoint.c           | 22 +++-------------------
 arch/x86/include/asm/hw_breakpoint.h     |  5 ++++-
 arch/x86/kernel/hw_breakpoint.c          | 23 +++--------------------
 arch/xtensa/include/asm/hw_breakpoint.h  |  5 ++++-
 arch/xtensa/kernel/hw_breakpoint.c       | 22 +++-------------------
 kernel/events/hw_breakpoint.c            | 11 ++++++-----
 13 files changed, 48 insertions(+), 126 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index e46e4e7..a42d3b9 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -111,6 +111,7 @@ static inline void decode_ctrl_reg(u32 reg,
 	asm volatile("mcr p14, 0, %0, " #N "," #M ", " #OP2 : : "r" (VAL));\
 } while (0)
 
+struct perf_event_attr;
 struct notifier_block;
 struct perf_event;
 struct pmu;
@@ -118,7 +119,9 @@ struct pmu;
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type);
 extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr);
+extern void hw_breakpoint_arch_commit(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 1769d3a..e14b32d 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -515,8 +515,8 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 	return 0;
 }
 
-static int hw_breakpoint_arch_check(struct perf_event *bp,
-				    const struct perf_event_attr *attr)
+int hw_breakpoint_arch_check(struct perf_event *bp,
+			     const struct perf_event_attr *attr)
 {
 	u32 offset, alignment_mask = 0x3;
 
@@ -614,7 +614,7 @@ static int hw_breakpoint_arch_check(struct perf_event *bp,
 	return 0;
 }
 
-static void hw_breakpoint_arch_commit(struct perf_event *bp)
+void hw_breakpoint_arch_commit(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event_attr *attr = &bp->attr;
@@ -679,22 +679,6 @@ static void hw_breakpoint_arch_commit(struct perf_event *bp)
 }
 
 /*
- * Validate the arch-specific HW Breakpoint register settings.
- */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int err;
-
-	err = hw_breakpoint_arch_check(bp, &bp->attr);
-	if (err)
-		return err;
-
-	hw_breakpoint_arch_commit(bp);
-
-	return 0;
-}
-
-/*
  * Enable/disable single-stepping over the breakpoint bp at address addr.
  */
 static void enable_single_step(struct perf_event *bp, u32 addr)
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 4177076..916980d 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -117,6 +117,7 @@ static inline void decode_ctrl_reg(u32 reg,
 	write_sysreg(VAL, dbg##REG##N##_el1);\
 } while (0)
 
+struct perf_event_attr;
 struct task_struct;
 struct notifier_block;
 struct perf_event;
@@ -125,7 +126,9 @@ struct pmu;
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type, int *offset);
 extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr);
+extern void hw_breakpoint_arch_commit(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index fa02995..eb254c1 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -419,8 +419,8 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 	return 0;
 }
 
-static int hw_breakpoint_arch_check(struct perf_event *bp,
-				    const struct perf_event_attr *attr)
+int hw_breakpoint_arch_check(struct perf_event *bp,
+			     const struct perf_event_attr *attr)
 {
 	u64 addr = attr->bp_addr, len = attr->bp_len;
 	u32 type = attr->bp_type;
@@ -519,7 +519,7 @@ static int hw_breakpoint_arch_check(struct perf_event *bp,
 /*
  * Construct an arch_hw_breakpoint from a perf_event.
  */
-static void hw_breakpoint_arch_commit(struct perf_event *bp)
+void hw_breakpoint_arch_commit(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event_attr *attr = &bp->attr;
@@ -625,22 +625,6 @@ static void hw_breakpoint_arch_commit(struct perf_event *bp)
 }
 
 /*
- * Validate the arch-specific HW Breakpoint register settings
- */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int err;
-
-	err = hw_breakpoint_arch_check(bp, &bp->attr);
-	if (err)
-		return err;
-
-	hw_breakpoint_arch_commit(bp);
-
-	return 0;
-}
-
-/*
  * Enable/disable all of the breakpoints active at the specified
  * exception level at the register level.
  * This is used when single-stepping after a breakpoint exception.
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 8e7b097..90d0379 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -52,6 +52,7 @@ struct arch_hw_breakpoint {
 #include <asm/reg.h>
 #include <asm/debug.h>
 
+struct perf_event_attr;
 struct perf_event;
 struct pmu;
 struct perf_sample_data;
@@ -61,7 +62,9 @@ struct perf_sample_data;
 extern int hw_breakpoint_slots(int type);
 extern int arch_bp_generic_fields(int type, int *gen_bp_type);
 extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr);
+extern void hw_breakpoint_arch_commit(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
 int arch_install_hw_breakpoint(struct perf_event *bp);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index c39fc86..38366ed 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -138,8 +138,8 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
 	return 0;
 }
 
-static int hw_breakpoint_arch_check(struct perf_event *bp,
-				    const struct perf_event_attr *attr)
+int hw_breakpoint_arch_check(struct perf_event *bp,
+			     const struct perf_event_attr *attr)
 {
 	int length_max;
 
@@ -174,7 +174,7 @@ static int hw_breakpoint_arch_check(struct perf_event *bp,
 	return 0;
 }
 
-static void hw_breakpoint_arch_commit(struct perf_event *bp)
+void hw_breakpoint_arch_commit(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event_attr *attr = &bp->attr;
@@ -197,22 +197,6 @@ static void hw_breakpoint_arch_commit(struct perf_event *bp)
 }
 
 /*
- * Validate the arch-specific HW Breakpoint register settings
- */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int err;
-
-	err = hw_breakpoint_arch_check(bp, &bp->attr);
-	if (err)
-		return err;
-
-	hw_breakpoint_arch_commit(bp);
-
-	return 0;
-}
-
-/*
  * Restores the breakpoint on the debug registers.
  * Invoke this function if it is known that the execution context is
  * about to change to cause loss of MSR_SE settings.
diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index 68384e6..d4d4c34 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -40,6 +40,7 @@ struct sh_ubc {
 	struct clk	*clk;	/* optional interface clock / MSTP bit */
 };
 
+struct perf_event_attr;
 struct perf_event;
 struct task_struct;
 struct pmu;
@@ -54,7 +55,9 @@ static inline int hw_breakpoint_slots(int type)
 
 /* arch/sh/kernel/hw_breakpoint.c */
 extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr);
+extern void hw_breakpoint_arch_commit(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index c89152f..85cbf71 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -174,8 +174,8 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
 	return 0;
 }
 
-static int hw_breakpoint_arch_check(struct perf_event *bp,
-				    const struct perf_event_attr *attr)
+int hw_breakpoint_arch_check(struct perf_event *bp,
+			     const struct perf_event_attr *attr)
 {
 	unsigned int align;
 
@@ -212,7 +212,7 @@ static int hw_breakpoint_arch_check(struct perf_event *bp,
 	return 0;
 }
 
-static void hw_breakpoint_arch_commit(struct perf_event *bp)
+void hw_breakpoint_arch_commit(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event_attr *attr = &bp->attr;
@@ -254,22 +254,6 @@ static void hw_breakpoint_arch_commit(struct perf_event *bp)
 }
 
 /*
- * Validate the arch-specific HW Breakpoint register settings
- */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int err;
-
-	err = hw_breakpoint_arch_check(bp, &bp->attr);
-	if (err)
-		return err;
-
-	hw_breakpoint_arch_commit(bp);
-
-	return 0;
-}
-
-/*
  * Release the user breakpoints used by ptrace
  */
 void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index f59c398..9b7dc36 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -49,11 +49,14 @@ static inline int hw_breakpoint_slots(int type)
 	return HBP_NUM;
 }
 
+struct perf_event_attr;
 struct perf_event;
 struct pmu;
 
 extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr);
+extern void hw_breakpoint_arch_commit(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 6960800..833aed9 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -233,8 +233,8 @@ int arch_bp_generic_fields(int x86_len, int x86_type,
 	return 0;
 }
 
-static int hw_breakpoint_arch_check(struct perf_event *bp,
-				    const struct perf_event_attr *attr)
+int hw_breakpoint_arch_check(struct perf_event *bp,
+			     const struct perf_event_attr *attr)
 {
 	unsigned int align;
 
@@ -295,7 +295,7 @@ static int hw_breakpoint_arch_check(struct perf_event *bp,
 	return 0;
 }
 
-static void hw_breakpoint_arch_commit(struct perf_event *bp)
+void hw_breakpoint_arch_commit(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event_attr *attr = &bp->attr;
@@ -354,23 +354,6 @@ static void hw_breakpoint_arch_commit(struct perf_event *bp)
 	}
 }
 
-
-/*
- * Validate the arch-specific HW Breakpoint register settings
- */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int err;
-
-	err = hw_breakpoint_arch_check(bp, &bp->attr);
-	if (err)
-		return err;
-
-	hw_breakpoint_arch_commit(bp);
-
-	return 0;
-}
-
 /*
  * Dump the debug register contents to the user.
  * We can't dump our per cpu values because it
diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
index dbe3053b..6761cea 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -30,13 +30,16 @@ struct arch_hw_breakpoint {
 	u16 type;
 };
 
+struct perf_event_attr;
 struct perf_event;
 struct pt_regs;
 struct task_struct;
 
 int hw_breakpoint_slots(int type);
 int arch_check_bp_in_kernelspace(struct perf_event *bp);
-int arch_validate_hwbkpt_settings(struct perf_event *bp);
+int hw_breakpoint_arch_check(struct perf_event *bp,
+			     const struct perf_event_attr *attr);
+void hw_breakpoint_arch_commit(struct perf_event *bp);
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data);
 
diff --git a/arch/xtensa/kernel/hw_breakpoint.c b/arch/xtensa/kernel/hw_breakpoint.c
index aae055d..015ffdd 100644
--- a/arch/xtensa/kernel/hw_breakpoint.c
+++ b/arch/xtensa/kernel/hw_breakpoint.c
@@ -45,8 +45,8 @@ int arch_check_bp_in_kernelspace(struct perf_event *bp)
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
 
-static int hw_breakpoint_arch_check(struct perf_event *bp,
-				    const struct perf_event_attr *attr)
+int hw_breakpoint_arch_check(struct perf_event *bp,
+			     const struct perf_event_attr *attr)
 {
 	/* Type */
 	switch (attr->bp_type) {
@@ -70,7 +70,7 @@ static int hw_breakpoint_arch_check(struct perf_event *bp,
 	return 0;
 }
 
-static void hw_breakpoint_arch_commit(struct perf_event *bp)
+void hw_breakpoint_arch_commit(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event_attr *attr = &bp->attr;
@@ -100,22 +100,6 @@ static void hw_breakpoint_arch_commit(struct perf_event *bp)
 	info->address = attr->bp_addr;
 }
 
-/*
- * Validate the arch-specific HW Breakpoint register settings
- */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int err;
-
-	err = hw_breakpoint_arch_check(bp, &bp->attr);
-	if (err)
-		return err;
-
-	hw_breakpoint_arch_commit(bp);
-
-	return 0;
-}
-
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data)
 {
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6e28d28..6896ceeb 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -402,11 +402,12 @@ int dbg_release_bp_slot(struct perf_event *bp)
 
 static int validate_hw_breakpoint(struct perf_event *bp)
 {
-	int ret;
+	int err;
 
-	ret = arch_validate_hwbkpt_settings(bp);
-	if (ret)
-		return ret;
+	err = hw_breakpoint_arch_check(bp, &bp->attr);
+	if (err)
+		return err;
+	hw_breakpoint_arch_commit(bp);
 
 	if (arch_check_bp_in_kernelspace(bp)) {
 		if (bp->attr.exclude_kernel)
@@ -432,7 +433,7 @@ int register_perf_hw_breakpoint(struct perf_event *bp)
 
 	ret = validate_hw_breakpoint(bp);
 
-	/* if arch_validate_hwbkpt_settings() fails then release bp slot */
+	/* if hw_breakpoint_arch_check() fails then release bp slot */
 	if (ret)
 		release_bp_slot(bp);
 
-- 
2.7.4
