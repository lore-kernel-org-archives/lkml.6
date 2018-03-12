Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeCLFo1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 01:44:27 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35657 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeCLFoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 01:44:25 -0400
X-Google-Smtp-Source: AG47ELtnQYAnObVre1eONuDUWSAg5mqVaCaXLTVGyhV+fXQK0y4ScuIgPRAbLpyk7PZun4BR7z0h5w==
From: Jason Vas Dias <jason.vas.dias@gmail.com>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
Date: Mon, 12 Mar 2018 05:44:19 +0000
Message-ID: <ina1j1ak.fsf@gmail.com>
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
  
   arch/x86/include/asm/vgtod.h
   arch/x86/entry/vdso/vclock_gettime.c
   arch/x86/entry/vdso/vdso.lds.S
   arch/x86/entry/vdso/vdsox32.lds.S
   arch/x86/entry/vdso/vdso32/vdso32.lds.S      
   arch/x86/entry/vsyscall/vsyscall_gtod.c
   
  This is a second patch in the series, 
  which adds a record of the calibrated tsc frequency to the VDSO,
  and a new header:
    uapi/asm/vdso_tsc_calibration.h
  which defines a structure :
    struct linux_tsc_calibration { u32 tsc_khz, mult, shift ; };
  and a getter function in the VDSO that can optionally be used
  by user-space code to implement sub-nanosecond precision clocks .
  This second patch is entirely optional but I think greatly
  expands the scope of user-space TSC readers .

  Oops, previous version of this second patch
  mistakenly copied the changed part of vclock_gettime.c.

  Best Regards,
     Jason Vas Dias  .
     
diff -up linux-4.16-rc5/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc5-p1 linux-4.16-rc5/arch/x86/entry/vdso/vclock_gettime.c
--- linux-4.16-rc5/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc5-p1	2018-03-12 04:29:27.296982872 +0000
+++ linux-4.16-rc5/arch/x86/entry/vdso/vclock_gettime.c	2018-03-12 05:38:53.019891195 +0000
@@ -21,6 +21,7 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <uapi/asm/vdso_tsc_calibration.h>
 
 #define gtod (&VVAR(vsyscall_gtod_data))
 
@@ -385,3 +386,22 @@ notrace time_t __vdso_time(time_t *t)
 }
 time_t time(time_t *t)
 	__attribute__((weak, alias("__vdso_time")));
+
+extern unsigned
+__vdso_linux_tsc_calibration(struct linux_tsc_calibration *);
+
+notrace	unsigned
+__vdso_linux_tsc_calibration(struct linux_tsc_calibration *tsc_cal)
+{
+	if ( (gtod->vclock_mode == VCLOCK_TSC) && (tsc_cal != ((void*)0UL)) )
+	{
+		tsc_cal -> tsc_khz = gtod->tsc_khz;
+		tsc_cal -> mult    = gtod->raw_mult;
+		tsc_cal -> shift   = gtod->raw_shift;
+		return 1;
+	}
+	return 0;
+}
+
+unsigned linux_tsc_calibration(void)
+	__attribute((weak, alias("__vdso_linux_tsc_calibration")));
diff -up linux-4.16-rc5/arch/x86/entry/vdso/vdso.lds.S.4.16-rc5-p1 linux-4.16-rc5/arch/x86/entry/vdso/vdso.lds.S
--- linux-4.16-rc5/arch/x86/entry/vdso/vdso.lds.S.4.16-rc5-p1	2018-03-12 00:25:09.000000000 +0000
+++ linux-4.16-rc5/arch/x86/entry/vdso/vdso.lds.S	2018-03-12 05:18:36.380673342 +0000
@@ -25,6 +25,8 @@ VERSION {
 		__vdso_getcpu;
 		time;
 		__vdso_time;
+		linux_tsc_calibration;
+		__vdso_linux_tsc_calibration;
 	local: *;
 	};
 }
diff -up linux-4.16-rc5/arch/x86/entry/vdso/vdso32/vdso32.lds.S.4.16-rc5-p1 linux-4.16-rc5/arch/x86/entry/vdso/vdso32/vdso32.lds.S
--- linux-4.16-rc5/arch/x86/entry/vdso/vdso32/vdso32.lds.S.4.16-rc5-p1	2018-03-12 00:25:09.000000000 +0000
+++ linux-4.16-rc5/arch/x86/entry/vdso/vdso32/vdso32.lds.S	2018-03-12 05:19:10.765022295 +0000
@@ -26,6 +26,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
+		__vdso_linux_tsc_calibration;
 	};
 
 	LINUX_2.5 {
diff -up linux-4.16-rc5/arch/x86/entry/vdso/vdsox32.lds.S.4.16-rc5-p1 linux-4.16-rc5/arch/x86/entry/vdso/vdsox32.lds.S
--- linux-4.16-rc5/arch/x86/entry/vdso/vdsox32.lds.S.4.16-rc5-p1	2018-03-12 00:25:09.000000000 +0000
+++ linux-4.16-rc5/arch/x86/entry/vdso/vdsox32.lds.S	2018-03-12 05:18:51.626827852 +0000
@@ -21,6 +21,7 @@ VERSION {
 		__vdso_gettimeofday;
 		__vdso_getcpu;
 		__vdso_time;
+		__vdso_linux_tsc_calibration;
 	local: *;
 	};
 }
diff -up linux-4.16-rc5/arch/x86/entry/vsyscall/vsyscall_gtod.c.4.16-rc5-p1 linux-4.16-rc5/arch/x86/entry/vsyscall/vsyscall_gtod.c
--- linux-4.16-rc5/arch/x86/entry/vsyscall/vsyscall_gtod.c.4.16-rc5-p1	2018-03-12 04:23:10.005141993 +0000
+++ linux-4.16-rc5/arch/x86/entry/vsyscall/vsyscall_gtod.c	2018-03-12 05:07:09.246115115 +0000
@@ -18,6 +18,8 @@
 #include <asm/vvar.h>
 #include <asm/cpufeature.h>
 
+extern unsigned tsc_khz;
+
 int vclocks_used __read_mostly;
 
 DEFINE_VVAR(struct vsyscall_gtod_data, vsyscall_gtod_data);
@@ -51,6 +53,7 @@ void update_vsyscall(struct timekeeper *
 	vdata->raw_mult		= tk->tkr_raw.mult;
 	vdata->raw_shift	= tk->tkr_raw.shift;
 	vdata->has_rdtscp	= static_cpu_has(X86_FEATURE_RDTSCP);
+	vdata->tsc_khz          = tsc_khz;
 
 	vdata->wall_time_sec		= tk->xtime_sec;
 	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
diff -up linux-4.16-rc5/arch/x86/include/asm/vgtod.h.4.16-rc5-p1 linux-4.16-rc5/arch/x86/include/asm/vgtod.h
--- linux-4.16-rc5/arch/x86/include/asm/vgtod.h.4.16-rc5-p1	2018-03-12 04:23:10.006142006 +0000
+++ linux-4.16-rc5/arch/x86/include/asm/vgtod.h	2018-03-12 05:03:37.312278324 +0000
@@ -27,6 +27,7 @@ struct vsyscall_gtod_data {
 	u32	raw_mult;
 	u32	raw_shift;
 	u32	has_rdtscp;
+	u32     tsc_khz;
 
 	/* open coded 'struct timespec' */
 	u64		wall_time_snsec;
diff -up linux-4.16-rc5/arch/x86/include/uapi/asm/vdso_tsc_calibration.h.4.16-rc5-p1 linux-4.16-rc5/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
--- linux-4.16-rc5/arch/x86/include/uapi/asm/vdso_tsc_calibration.h.4.16-rc5-p1	2018-03-12 05:13:26.014607615 +0000
+++ linux-4.16-rc5/arch/x86/include/uapi/asm/vdso_tsc_calibration.h	2018-03-11 20:47:05.409960497 +0000
@@ -0,0 +1,73 @@
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
+/** struct linux_tsc_calibration -
+ * mult:    amount to multiply 64-bit TSC value by
+ * shift:   the right shift to apply to (mult*TSC) yielding nanoseconds
+ * tsc_khz: the calibrated TSC frequency in KHz from which previous members calculated
+ */
+struct linux_tsc_calibration
+{
+        unsigned int mult;
+        unsigned int shift;
+        unsigned int tsc_khz;
+};
+
+/* To use:
+ *
+ *  static unsigned
+ *  (*linux_tsc_cal)(struct linux_tsc_calibration *linux_tsc_cal) = vdso_sym("LINUX_2.6", "__vdso_linux_tsc_calibration");
+ *  if( linux_tsc_cal == 0UL )
+ *  { fprintf(stderr,"the patch providing __vdso_linux_tsc_calibration is not applied to the kernel.\n");
+ *    return ERROR;
+ *  }
+ *  static const struct linux_tsc_calibration *clock_source=(void*)0UL;
+ *  if( ! (*linux_tsc_cal)(&clock_source) )
+ *    fprintf(stderr,"TSC is not the system clocksource.\n");
+ *  unsigned int tsc_lo, tsc_hi, tsc_cpu;
+ *  asm volatile
+ *  ( "rdtscp" : (=a) tsc_hi,  (=d) tsc_lo, (=c) tsc_cpu );
+ *  unsigned long tsc = (((unsigned long)tsc_hi) << 32) | tsc_lo;
+ *  unsigned long nanoseconds =
+ *   (( clock_source -> mult ) * tsc ) >> (clock_source -> shift);
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
+ *   u64  nsec     = ((delta * clock_source->mult) + previous_nsec )
+ *	           >> clock_source->shift;
+ *   ts->tv_sec    = previous_sec + (nsec / NSEC_PER_SEC);
+ *   ts->tv_nsec   = nsec % NSEC_PER_SEC;
+ *   previous_tsc  = tsc
+ *   previous_sec  = ts->tv_sec;
+ *   previous_nsec = ts->tv_nsec << clock_source->shift;
+ *   return ts;
+ * This is the approach taken by Linux kernel & in VDSO .
+ *
+ * Or, in user-space, with floating point, one could use the rdtscp value as number of picoseconds :
+ *     u64 ns = lround( ((double)rdtscp()) / (((double)clock_source->tsc_khz) / 1e3) );
+ * (ie. if tsc_khz is 3000 , there are 3 tsc ticks per nanosecond, so divide tsc ticks by 3).
+ *
+ * There should actually be very little difference between the two values obtained (@ 0.02% )
+ * by either method.
+ */
+
+#endif
