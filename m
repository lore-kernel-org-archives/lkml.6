Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeENSwq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:52:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:55031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbeENSwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244660"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 13/15] x86/split_lock: Trace #AC exception for split lock
Date: Mon, 14 May 2018 11:52:23 -0700
Message-Id: <1526323945-211107-14-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create two events x86_exceptions.split_lock_user to trace #AC
exception for split lock triggered from user space and
x86_exceptions.split_lock_kernel to trace #AC exception for split
lock from triggered from kernel space.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/trace/common.h     |  8 ++++++
 arch/x86/include/asm/trace/exceptions.h | 21 ++++++++++++---
 arch/x86/kernel/cpu/split_lock.c        | 46 +++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/trace/common.h
index 57c8da027d99..5e61c7348349 100644
--- a/arch/x86/include/asm/trace/common.h
+++ b/arch/x86/include/asm/trace/common.h
@@ -8,9 +8,17 @@ DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
 DECLARE_STATIC_KEY_FALSE(trace_resched_ipi_key);
 #define trace_resched_ipi_enabled()			\
 	static_branch_unlikely(&trace_resched_ipi_key)
+
+#ifdef CONFIG_SPLIT_LOCK_AC
+DECLARE_STATIC_KEY_FALSE(trace_split_lock_key);
+#define trace_split_lock_enabled()			\
+	static_branch_unlikely(&trace_split_lock_key)
+#endif
+
 #else
 static inline bool trace_pagefault_enabled(void) { return false; }
 static inline bool trace_resched_ipi_enabled(void) { return false; }
+static inline bool trace_split_lock_enabled(void) { return false; }
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
index 69615e387973..2a4ea0c70963 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -2,8 +2,8 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM exceptions
 
-#if !defined(_TRACE_PAGE_FAULT_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_PAGE_FAULT_H
+#if !defined(_TRACE_EXCEPTIONS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_EXCEPTIONS_H
 
 #include <linux/tracepoint.h>
 #include <asm/trace/common.h>
@@ -44,10 +44,25 @@ DEFINE_EVENT_FN(x86_exceptions, name,				\
 DEFINE_PAGE_FAULT_EVENT(page_fault_user);
 DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
 
+#ifdef CONFIG_SPLIT_LOCK_AC
+int trace_split_lock_reg(void);
+void trace_split_lock_unreg(void);
+
+#define DEFINE_SPLIT_LOCK_FAULT_EVENT(name)			\
+DEFINE_EVENT_FN(x86_exceptions, name,				\
+	TP_PROTO(unsigned long address,	struct pt_regs *regs,	\
+		 unsigned long error_code),			\
+	TP_ARGS(address, regs, error_code),			\
+	trace_split_lock_reg, trace_split_lock_unreg)
+
+DEFINE_SPLIT_LOCK_FAULT_EVENT(split_lock_user);
+DEFINE_SPLIT_LOCK_FAULT_EVENT(split_lock_kernel);
+#endif
+
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE exceptions
-#endif /*  _TRACE_PAGE_FAULT_H */
+#endif /*  _TRACE_EXCEPTIONS_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index 020af331594d..948a7fa948a2 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -15,6 +15,8 @@
 #include <linux/cpu.h>
 #include <linux/reboot.h>
 #include <linux/syscore_ops.h>
+#include <asm-generic/kprobes.h>
+#include <asm/trace/exceptions.h>
 #include <asm/msr.h>
 
 static bool split_lock_ac_supported;
@@ -45,6 +47,8 @@ static const char * const user_modes[USER_MODE_LAST] = {
 	[USER_MODE_RE_EXECUTE] = "re-execute",
 };
 
+DEFINE_STATIC_KEY_FALSE(trace_split_lock_key);
+
 /*
  * On processors not supporting #AC exception for split lock feature,
  * MSR_TEST_CTL may not exist or MSR_TEST_CTL exists but the bit 29 is
@@ -116,6 +120,20 @@ static __init int setup_split_lock_ac(char *str)
 }
 __setup("split_lock_ac=", setup_split_lock_ac);
 
+int trace_split_lock_reg(void)
+{
+	if (split_lock_ac_supported)
+		static_branch_inc(&trace_split_lock_key);
+
+	return 0;
+}
+
+void trace_split_lock_unreg(void)
+{
+	if (split_lock_ac_supported)
+		static_branch_dec(&trace_split_lock_key);
+}
+
 static bool _setup_split_lock(int split_lock_ac_val)
 {
 	u32 l, h;
@@ -268,6 +286,31 @@ static bool re_execute(struct pt_regs *regs)
 	return false;
 }
 
+static nokprobe_inline void
+trace_split_lock_entries(unsigned long address, struct pt_regs *regs,
+			 unsigned long error_code)
+{
+	/*
+	 * If either CR0.AM or EFLAGS.AC is zero in user, the #AC must
+	 * come from split lock. Trace the #AC in split_lock_user event.
+	 *
+	 * For other cases, the #AC could be from split lock or from
+	 * generic cache line misalignment. Don't trace the #AC. In
+	 * theory, that means some split lock events may not be traced.
+	 * But usually EFLAGS.AC is not set for user process; so this
+	 * is not big issue.
+	 */
+	if (user_mode(regs) && (cr0_am(regs) == 0 || eflags_ac(regs) == 0))
+		trace_split_lock_user(address, regs, error_code);
+
+	/*
+	 * Only split lock can trigger #AC from kernel. Trace the #AC in
+	 * split_lock_kernel event.
+	 */
+	if (!user_mode(regs))
+		trace_split_lock_kernel(address, regs, error_code);
+}
+
 /*
  * #AC handler for kernel split lock is called by generic #AC handler.
  *
@@ -280,6 +323,9 @@ bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
 	unsigned long address = read_cr2(); /* Get the faulting address */
 	int this_cpu = smp_processor_id();
 
+	if (trace_split_lock_enabled())
+		trace_split_lock_entries(address, regs, error_code);
+
 	if (!re_execute(regs))
 		return false;
 
-- 
2.5.0
