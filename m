Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCLJOf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:14:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55187 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCLJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:14:33 -0400
X-Google-Smtp-Source: AG47ELtQeW22hnFSRQcN/iMnTg2Q1Mh16P4uSPpgNEpYa0ydsWePXi0s4VEr4QCzdzRZXdRzScLK9Q==
From: Jason Vas Dias <jason.vas.dias@gmail.com>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
Date: Mon, 12 Mar 2018 09:14:28 +0000
Message-ID: <y3ixhczv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Currently the VDSO does not handle
     clock_gettime( CLOCK_MONOTONIC_RAW, &ts )
  on Intel / AMD - it calls
     vdso_fallback_gettime()
  for this clock, which issues a syscall, having an unacceptably high
  latency (minimum measurable time or time between measurements)
  of 300-700ns on 2 2.8-3.9ghz Haswell x86_64 Family'_'Model : 06_3C
  machines under various versions of Linux.

  Sometimes, particularly when correlating elapsed time to performance
  counter values,  code needs to know elapsed time from the perspective
  of the CPU no matter how "hot" / fast or "cold" / slow it might be
  running wrt NTP / PTP ; when code needs this, the latencies with
  a syscall are often unacceptably high.

  I reported this as Bug #198161 :
    'https://bugzilla.kernel.org/show_bug.cgi?id=198961'
  and in previous posts with subjects matching 'CLOCK_MONOTONIC_RAW' .
     
  This patch handles CLOCK_MONOTONIC_RAW clock_gettime() in the VDSO ,
  by exporting the raw clock calibration, last cycles, last xtime_nsec,
  and last raw_sec value in the vsyscall_gtod_data during vsyscall_update() .

  Now the new do_monotonic_raw() function in the vDSO has a latency of @ 24ns
  on average, and the test program:
   tools/testing/selftest/timers/inconsistency-check.c
  succeeds with arguments: '-c 4 -t 120' or any arbitrary -t value.

  The patch is against Linus' latest 4.16-rc5 tree,
  current HEAD of :
    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  .

  This patch affects only files:

   arch/x86/include/asm/msr.h
   arch/x86/include/asm/vgtod.h
   arch/x86/entry/vdso/vclock_gettime.c
   arch/x86/entry/vsyscall/vsyscall_gtod.c
   
  This is the second patch in the series,
  which adds use of rdtscp .

  Best Regards,
     Jason Vas Dias  .
     
---
diff -up linux-4.16-rc5/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc5-p1 linux-4.16-rc5/arch/x86/entry/vdso/vclock_gettime.c
--- linux-4.16-rc5/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc5-p1	2018-03-12 08:12:17.110120433 +0000
+++ linux-4.16-rc5/arch/x86/entry/vdso/vclock_gettime.c	2018-03-12 08:59:21.135475862 +0000
@@ -187,7 +187,7 @@ notrace static u64 vread_tsc_raw(void)
 	u64 tsc
 	  , last = gtod->raw_cycle_last;
 
-	tsc	      = rdtsc_ordered();
+	tsc = gtod->has_rdtscp ? rdtscp((void*)0UL) : rdtsc_ordered();
 	if (likely(tsc >= last))
 		return tsc;
 	asm volatile ("");
diff -up linux-4.16-rc5/arch/x86/entry/vsyscall/vsyscall_gtod.c.4.16-rc5-p1 linux-4.16-rc5/arch/x86/entry/vsyscall/vsyscall_gtod.c
--- linux-4.16-rc5/arch/x86/entry/vsyscall/vsyscall_gtod.c.4.16-rc5-p1	2018-03-12 07:58:07.974214168 +0000
+++ linux-4.16-rc5/arch/x86/entry/vsyscall/vsyscall_gtod.c	2018-03-12 08:54:07.490267640 +0000
@@ -16,6 +16,7 @@
 #include <linux/timekeeper_internal.h>
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
+#include <cpufeatures.h>
 
 int vclocks_used __read_mostly;
 
@@ -49,6 +50,7 @@ void update_vsyscall(struct timekeeper *
 	vdata->raw_mask		= tk->tkr_raw.mask;
 	vdata->raw_mult		= tk->tkr_raw.mult;
 	vdata->raw_shift	= tk->tkr_raw.shift;
+	vdata->has_rdtscp       = static_cpu_has(X86_FEATURE_RDTSCP);
 
 	vdata->wall_time_sec		= tk->xtime_sec;
 	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
diff -up linux-4.16-rc5/arch/x86/include/asm/msr.h.4.16-rc5-p1 linux-4.16-rc5/arch/x86/include/asm/msr.h
--- linux-4.16-rc5/arch/x86/include/asm/msr.h.4.16-rc5-p1	2018-03-12 00:25:09.000000000 +0000
+++ linux-4.16-rc5/arch/x86/include/asm/msr.h	2018-03-12 09:06:03.902728749 +0000
@@ -218,6 +218,36 @@ static __always_inline unsigned long lon
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
+		( "rdtscp"
+			:   "=a" (tsc_lo)
+			  , "=d" (tsc_hi)
+			  , "=c" (tsc_cpu)
+		);
+	if ( unlikely(cpu_out != ((void*)0)) )
+		*cpu_out = tsc_cpu;
+	return ((((u64)tsc_hi) << 32) |
+		(((u64)tsc_lo) & 0x0ffffffffULL )
+	       );
+}
+
 /* Deprecated, keep it for a cycle for easier merging: */
 #define rdtscll(now)	do { (now) = rdtsc_ordered(); } while (0)
 
diff -up linux-4.16-rc5/arch/x86/include/asm/vgtod.h.4.16-rc5-p1 linux-4.16-rc5/arch/x86/include/asm/vgtod.h
--- linux-4.16-rc5/arch/x86/include/asm/vgtod.h.4.16-rc5-p1	2018-03-12 07:44:17.910539760 +0000
+++ linux-4.16-rc5/arch/x86/include/asm/vgtod.h	2018-03-12 08:51:48.204845624 +0000
@@ -26,6 +26,7 @@ struct vsyscall_gtod_data {
 	u64	raw_mask;
 	u32	raw_mult;
 	u32	raw_shift;
+	u32     has_rdtscp;
 
 	/* open coded 'struct timespec' */
 	u64		wall_time_snsec;
---
