Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeCNEUo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:20:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51590 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753214AbeCNEUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 00:20:39 -0400
X-Google-Smtp-Source: AG47ELsf4lVzeF8+sGRkwGGm7dLbUv0YVjiE9smq8JPR/4PmSKTyIz/X+qo8eFfOc8x0U0FmEk+fpA==
From: jason.vas.dias@gmail.com
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: [PATCH v4.16-rc5 3/3] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
Date: Wed, 14 Mar 2018 04:20:22 +0000
Message-Id: <1521001222-10712-4-git-send-email-jason.vas.dias@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1521001222-10712-1-git-send-email-jason.vas.dias@gmail.com>
References: <1521001222-10712-1-git-send-email-jason.vas.dias@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 2c46675..772988c 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -21,6 +21,7 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <uapi/asm/vdso_tsc_calibration.h>
 
 #define gtod (&VVAR(vsyscall_gtod_data))
 
@@ -184,7 +185,7 @@ notrace static u64 vread_tsc(void)
 
 notrace static u64 vread_tsc_raw(void)
 {
-	u64 tsc  = (gtod->has_rdtscp ? rdtscp((void*)0) : rdtsc_ordered())
+	u64 tsc  = (gtod->has_rdtscp ? rdtscp((void *)0) : rdtsc_ordered())
 	  , last = gtod->raw_cycle_last;
 
 	if (likely(tsc >= last))
@@ -383,3 +384,21 @@ notrace time_t __vdso_time(time_t *t)
 }
 time_t time(time_t *t)
 	__attribute__((weak, alias("__vdso_time")));
+
+unsigned int __vdso_linux_tsc_calibration(
+	struct linux_tsc_calibration_s *tsc_cal);
+
+notrace	unsigned int
+__vdso_linux_tsc_calibration(struct linux_tsc_calibration_s *tsc_cal)
+{
+	if ((gtod->vclock_mode == VCLOCK_TSC) && (tsc_cal != ((void *)0UL))) {
+		tsc_cal->tsc_khz = gtod->tsc_khz;
+		tsc_cal->mult    = gtod->raw_mult;
+		tsc_cal->shift   = gtod->raw_shift;
+		return 1;
+	}
+	return 0;
+}
+
+unsigned int linux_tsc_calibration(struct linux_tsc_calibration_s *tsc_cal)
+	__attribute((weak, alias("__vdso_linux_tsc_calibration")));
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index d3a2dce..e0b5cce 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -25,6 +25,8 @@ VERSION {
 		__vdso_getcpu;
 		time;
 		__vdso_time;
+		linux_tsc_calibration;
+		__vdso_linux_tsc_calibration;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 422764a..17fd07f 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -26,6 +26,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
+		__vdso_linux_tsc_calibration;
 	};
 
 	LINUX_2.5 {
diff --git a/arch/x86/entry/vdso/vdsox32.lds.S b/arch/x86/entry/vdso/vdsox32.lds.S
index 05cd1c5..7acac71 100644
--- a/arch/x86/entry/vdso/vdsox32.lds.S
+++ b/arch/x86/entry/vdso/vdsox32.lds.S
@@ -21,6 +21,7 @@ VERSION {
 		__vdso_gettimeofday;
 		__vdso_getcpu;
 		__vdso_time;
+		__vdso_linux_tsc_calibration;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index 0327a95..692562a 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -53,6 +53,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdata->raw_mult		= tk->tkr_raw.mult;
 	vdata->raw_shift	= tk->tkr_raw.shift;
 	vdata->has_rdtscp	= static_cpu_has(X86_FEATURE_RDTSCP);
+	vdata->tsc_khz          = tsc_khz;
 
 	vdata->wall_time_sec		= tk->xtime_sec;
 	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index a5ff704..c7b2ed2 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -227,7 +227,7 @@ static __always_inline unsigned long long rdtsc_ordered(void)
  * the number (Intel CPU ID) of the CPU that the task is currently running on.
  * As does EAX_EDT_RET, this uses the "open-coded asm" style to
  * force the compiler + assembler to always use (eax, edx, ecx) registers,
- * NOT whole (rax, rdx, rcx) on x86_64 , because only 32-bit 
+ * NOT whole (rax, rdx, rcx) on x86_64 , because only 32-bit
  * variables are used - exactly the same code should be generated
  * for this instruction on 32-bit as on 64-bit when this asm stanza is used.
  * See: SDM , Vol #2, RDTSCP instruction.
@@ -236,15 +236,15 @@ static __always_inline u64 rdtscp(u32 *cpu_out)
 {
 	u32	tsc_lo, tsc_hi, tsc_cpu;
 	asm volatile
-	( "rdtscp"
+	("rdtscp"
 		:   "=a" (tsc_lo)
 		  , "=d" (tsc_hi)
 		  , "=c" (tsc_cpu)
 	); // : eax, edx, ecx used - NOT rax, rdx, rcx
-	if (unlikely(cpu_out != ((void*)0)))
+	if (unlikely(cpu_out != ((void *)0)))
 		*cpu_out = tsc_cpu;
 	return ((((u64)tsc_hi) << 32) |
-		(((u64)tsc_lo) & 0x0ffffffffULL )
+		(((u64)tsc_lo) & 0x0ffffffffULL)
 	       );
 }
 
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index e7e4804..75078fc 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -27,6 +27,7 @@ struct vsyscall_gtod_data {
 	u32	raw_mult;
 	u32	raw_shift;
 	u32     has_rdtscp;
+	u32     tsc_khz;
 
 	/* open coded 'struct timespec' */
 	u64		wall_time_snsec;
diff --git a/arch/x86/include/uapi/asm/vdso_tsc_calibration.h b/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
new file mode 100644
index 0000000..8ca3090
--- /dev/null
+++ b/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_X86_VDSO_TSC_CALIBRATION_H
+#define _ASM_X86_VDSO_TSC_CALIBRATION_H
+/*
+ * Programs that want to use rdtsc / rdtscp instructions
+ * from user-space can make use of the Linux kernel TSC calibration
+ * by calling :
+ *    __vdso_linux_tsc_calibration(struct linux_tsc_calibration_s *);
+ * ( one has to resolve this symbol as in
+ *   tools/testing/selftests/vDSO/parse_vdso.c
+ * )
+ * which fills in a structure
+ * with the following layout :
+ */
+
+/** struct linux_tsc_calibration_s -
+ * mult:    amount to multiply 64-bit TSC value by
+ * shift:   the right shift to apply to (mult*TSC) yielding nanoseconds
+ * tsc_khz: the calibrated TSC frequency in KHz from which previous
+ *          members calculated
+ */
+struct linux_tsc_calibration_s {
+
+	unsigned int mult;
+	unsigned int shift;
+	unsigned int tsc_khz;
+
+};
+
+/* To use:
+ *
+ *  static unsigned
+ *  (*linux_tsc_cal)(struct linux_tsc_calibration_s *linux_tsc_cal) =
+ *    vdso_sym("LINUX_2.6", "__vdso_linux_tsc_calibration");
+ *  if( linux_tsc_cal == 0UL )
+ *  { fprintf(stderr,
+ *    "the patch providing __vdso_linux_tsc_calibration "
+ *    "is not applied to the kernel.\n");
+ *    return ERROR;
+ *  }
+ *  static struct linux_tsc_calibration clock_source={0};
+ *  if((clock_source.mult==0) && ! (*linux_tsc_cal)(&clock_source) )
+ *    fprintf(stderr,"TSC is not the system clocksource.\n");
+ *  unsigned int tsc_lo, tsc_hi, tsc_cpu;
+ *  asm volatile
+ *  ( "rdtscp" : (=a) tsc_hi,  (=d) tsc_lo, (=c) tsc_cpu );
+ *  unsigned long tsc = (((unsigned long)tsc_hi) << 32) | tsc_lo;
+ *  unsigned long nanoseconds =
+ *   (( clock_source . mult ) * tsc ) >> (clock_source . shift);
+ *
+ *  nanoseconds is now TSC value converted to nanoseconds,
+ *  according to Linux' clocksource calibration values.
+ *  Incidentally, 'tsc_cpu' is the number of the CPU the task is running on.
+ *
+ * But better results are obtained by applying this to the difference (delta)
+ * and adding this to some previous timespec value:
+ *   static u64 previous_tsc=0, previous_nsec=0, previous_sec=0;
+ *   u64  tsc      = rdtscp();
+ *   u64  delta    = tsc - previous_tsc;
+ *   u64  nsec     = ((delta * clock_source.mult) + previous_nsec )
+ *	           >> clock_source.shift;
+ *   ts->tv_sec    = previous_sec + (nsec / NSEC_PER_SEC);
+ *   ts->tv_nsec   = nsec % NSEC_PER_SEC;
+ *   previous_tsc  = tsc
+ *   previous_sec  = ts->tv_sec;
+ *   previous_nsec = ts->tv_nsec << clock_source.shift;
+ *   return ts;
+ * This is broadly like the approach taken by Linux kernel & in VDSO .
+ *
+ * Or, in user-space, with floating point, one could use the rdtscp value as
+ * number of picoseconds :
+ *     u64 ns = lround( ((double)rdtscp())
+ *            / (((double)clock_source.tsc_khz) / 1e3) );
+ * (ie. if tsc_khz is 3000 , there are 3 tsc ticks per nanosecond, so divide
+ *  tsc ticks by 3).
+ *
+ * There should actually be very little difference between the two values
+ * obtained : (@ 0.02%)
+ * by either method.
+ */
+
+#endif
