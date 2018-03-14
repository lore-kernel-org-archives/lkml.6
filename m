Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeCNEUm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:20:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36790 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeCNEUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 00:20:37 -0400
X-Google-Smtp-Source: AG47ELt/1QqANVQvSMBVuzBF6iTpQzqZaC/mJ0rNgQqDAOIHq/wOr1EnmsccPFR8OFKTC0YQc2dD7Q==
From: jason.vas.dias@gmail.com
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: [PATCH v4.16-rc5 2/3] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
Date: Wed, 14 Mar 2018 04:20:21 +0000
Message-Id: <1521001222-10712-3-git-send-email-jason.vas.dias@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1521001222-10712-1-git-send-email-jason.vas.dias@gmail.com>
References: <1521001222-10712-1-git-send-email-jason.vas.dias@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index fbc7371..2c46675 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -184,10 +184,9 @@ notrace static u64 vread_tsc(void)
 
 notrace static u64 vread_tsc_raw(void)
 {
-	u64 tsc
+	u64 tsc  = (gtod->has_rdtscp ? rdtscp((void*)0) : rdtsc_ordered())
 	  , last = gtod->raw_cycle_last;
 
-	tsc	      = rdtsc_ordered();
 	if (likely(tsc >= last))
 		return tsc;
 	asm volatile ("");
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index 5af7093..0327a95 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -16,6 +16,9 @@
 #include <linux/timekeeper_internal.h>
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
+#include <asm/cpufeature.h>
+
+extern unsigned tsc_khz;
 
 int vclocks_used __read_mostly;
 
@@ -49,6 +52,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdata->raw_mask		= tk->tkr_raw.mask;
 	vdata->raw_mult		= tk->tkr_raw.mult;
 	vdata->raw_shift	= tk->tkr_raw.shift;
+	vdata->has_rdtscp	= static_cpu_has(X86_FEATURE_RDTSCP);
 
 	vdata->wall_time_sec		= tk->xtime_sec;
 	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 30df295..a5ff704 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -218,6 +218,36 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	return rdtsc();
 }
 
+/**
+ * rdtscp() - read the current TSC and (optionally) CPU number, with built-in
+ *            cancellation point replacing barrier - only available
+ *            if static_cpu_has(X86_FEATURE_RDTSCP) .
+ * returns:   The 64-bit Time Stamp Counter (TSC) value.
+ * Optionally, 'cpu_out' can be non-null, and on return it will contain
+ * the number (Intel CPU ID) of the CPU that the task is currently running on.
+ * As does EAX_EDT_RET, this uses the "open-coded asm" style to
+ * force the compiler + assembler to always use (eax, edx, ecx) registers,
+ * NOT whole (rax, rdx, rcx) on x86_64 , because only 32-bit 
+ * variables are used - exactly the same code should be generated
+ * for this instruction on 32-bit as on 64-bit when this asm stanza is used.
+ * See: SDM , Vol #2, RDTSCP instruction.
+ */
+static __always_inline u64 rdtscp(u32 *cpu_out)
+{
+	u32	tsc_lo, tsc_hi, tsc_cpu;
+	asm volatile
+	( "rdtscp"
+		:   "=a" (tsc_lo)
+		  , "=d" (tsc_hi)
+		  , "=c" (tsc_cpu)
+	); // : eax, edx, ecx used - NOT rax, rdx, rcx
+	if (unlikely(cpu_out != ((void*)0)))
+		*cpu_out = tsc_cpu;
+	return ((((u64)tsc_hi) << 32) |
+		(((u64)tsc_lo) & 0x0ffffffffULL )
+	       );
+}
+
 /* Deprecated, keep it for a cycle for easier merging: */
 #define rdtscll(now)	do { (now) = rdtsc_ordered(); } while (0)
 
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 24e4d45..e7e4804 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -26,6 +26,7 @@ struct vsyscall_gtod_data {
 	u64	raw_mask;
 	u32	raw_mult;
 	u32	raw_shift;
+	u32     has_rdtscp;
 
 	/* open coded 'struct timespec' */
 	u64		wall_time_snsec;
