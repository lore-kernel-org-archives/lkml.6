Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeCKTqe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:46:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50932 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932161AbeCKTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:46:33 -0400
X-Google-Smtp-Source: AG47ELuEIG8jJTpktZ43sqG2is4wFYjPKnCuMf+hc3Bjb0y79j7cX3TsfeQ3s3kMC7pcGNmCnxEQTg==
From: Jason Vas Dias <jason.vas.dias@gmail.com>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4.16-rc4 1/1] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
Date: Sun, 11 Mar 2018 19:46:26 +0000
Message-ID: <po4az97x.fsf@gmail.com>
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

  The patch is against Linus' latest 4.16-rc4 tree,
  current HEAD of :
    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  .

  The patch affects only files:
  
   arch/x86/include/asm/vgtod.h
   arch/x86/entry/vdso/vclock_gettime.c
   arch/x86/entry/vsyscall/vsyscall_gtod.c


  This is a resend of the original patch fixing indentation issues
  after installation of emacs Lisp cc-mode hooks in
      Documentation/coding-style.rst
  and calling 'indent-region' and 'tabify' (whitespace only changes) -
  SORRY !
  (and even after that, somehow 2 '\t\n's got left in vgtod.h -
   now removed - sorry again!) .

  Best Regards,
     Jason Vas Dias  .

  PATCH:
---     
diff -up linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc4 linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c
--- linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc4	2018-03-04 22:54:11.000000000 +0000
+++ linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c	2018-03-11 19:00:04.630019100 +0000
@@ -182,6 +182,29 @@ notrace static u64 vread_tsc(void)
 	return last;
 }
 
+notrace static u64 vread_tsc_raw(void)
+{
+	u64 tsc, last=gtod->raw_cycle_last;
+	if( likely( gtod->has_rdtscp ) ) {
+		u32	tsc_lo, tsc_hi,
+			tsc_cpu __attribute__((unused));
+		asm volatile
+			( "rdtscp"
+				/* ^- has built-in cancellation point / pipeline stall"barrier" */
+				:   "=a" (tsc_lo)
+				  , "=d" (tsc_hi)
+				  , "=c" (tsc_cpu)
+			); // since all variables 32-bit, eax, edx, ecx used - NOT rax, rdx, rcx
+		tsc	= ((((u64)tsc_hi) & 0xffffffffUL) << 32) | (((u64)tsc_lo) & 0xffffffffUL);
+	} else {
+		tsc	= rdtsc_ordered();
+	}
+	if (likely(tsc >= last))
+		return tsc;
+	asm volatile ("");
+	return last;
+}
+
 notrace static inline u64 vgetsns(int *mode)
 {
 	u64 v;
@@ -203,6 +226,27 @@ notrace static inline u64 vgetsns(int *m
 	return v * gtod->mult;
 }
 
+notrace static inline u64 vgetsns_raw(int *mode)
+{
+	u64 v;
+	cycles_t cycles;
+
+	if (gtod->vclock_mode == VCLOCK_TSC)
+		cycles = vread_tsc_raw();
+#ifdef CONFIG_PARAVIRT_CLOCK
+	else if (gtod->vclock_mode == VCLOCK_PVCLOCK)
+		cycles = vread_pvclock(mode);
+#endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+	else if (gtod->vclock_mode == VCLOCK_HVCLOCK)
+		cycles = vread_hvclock(mode);
+#endif
+	else
+		return 0;
+	v = (cycles - gtod->raw_cycle_last) & gtod->raw_mask;
+	return v * gtod->raw_mult;
+}
+
 /* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
 notrace static int __always_inline do_realtime(struct timespec *ts)
 {
@@ -246,6 +290,27 @@ notrace static int __always_inline do_mo
 	return mode;
 }
 
+notrace static int __always_inline do_monotonic_raw( struct timespec *ts)
+{
+	unsigned long seq;
+	u64 ns;
+	int mode;
+
+	do {
+		seq = gtod_read_begin(gtod);
+		mode = gtod->vclock_mode;
+		ts->tv_sec = gtod->monotonic_time_raw_sec;
+		ns = gtod->monotonic_time_raw_nsec;
+		ns += vgetsns_raw(&mode);
+		ns >>= gtod->raw_shift;
+	} while (unlikely(gtod_read_retry(gtod, seq)));
+
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return mode;
+}
+
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
 	unsigned long seq;
@@ -277,6 +342,10 @@ notrace int __vdso_clock_gettime(clockid
 		if (do_monotonic(ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(ts) == VCLOCK_NONE)
+			goto fallback;
+		break;
 	case CLOCK_REALTIME_COARSE:
 		do_realtime_coarse(ts);
 		break;
diff -up linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c.4.16-rc4 linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c
--- linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c.4.16-rc4	2018-03-04 22:54:11.000000000 +0000
+++ linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c	2018-03-11 19:06:36.584178867 +0000
@@ -16,6 +16,7 @@
 #include <linux/timekeeper_internal.h>
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
+#include <asm/cpufeature.h>
 
 int vclocks_used __read_mostly;
 
@@ -45,6 +46,12 @@ void update_vsyscall(struct timekeeper *
 	vdata->mult		= tk->tkr_mono.mult;
 	vdata->shift		= tk->tkr_mono.shift;
 
+	vdata->raw_cycle_last	= tk->tkr_raw.cycle_last;
+	vdata->raw_mask		= tk->tkr_raw.mask;
+	vdata->raw_mult		= tk->tkr_raw.mult;
+	vdata->raw_shift	= tk->tkr_raw.shift;
+	vdata->has_rdtscp	= static_cpu_has(X86_FEATURE_RDTSCP);
+
 	vdata->wall_time_sec		= tk->xtime_sec;
 	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
 
@@ -74,5 +81,8 @@ void update_vsyscall(struct timekeeper *
 		vdata->monotonic_time_coarse_sec++;
 	}
 
+	vdata->monotonic_time_raw_sec  = tk->raw_sec;
+	vdata->monotonic_time_raw_nsec = tk->tkr_raw.xtime_nsec;
+
 	gtod_write_end(vdata);
 }
diff -up linux-4.16-rc4/arch/x86/include/asm/vgtod.h.4.16-rc4 linux-4.16-rc4/arch/x86/include/asm/vgtod.h
--- linux-4.16-rc4/arch/x86/include/asm/vgtod.h.4.16-rc4	2018-03-04 22:54:11.000000000 +0000
+++ linux-4.16-rc4/arch/x86/include/asm/vgtod.h	2018-03-11 19:34:39.290617098 +0000
@@ -22,6 +22,11 @@ struct vsyscall_gtod_data {
 	u64	mask;
 	u32	mult;
 	u32	shift;
+	u64	raw_cycle_last;
+	u64	raw_mask;
+	u32	raw_mult;
+	u32	raw_shift;
+	u32	has_rdtscp;
 
 	/* open coded 'struct timespec' */
 	u64		wall_time_snsec;
@@ -32,6 +37,8 @@ struct vsyscall_gtod_data {
 	gtod_long_t	wall_time_coarse_nsec;
 	gtod_long_t	monotonic_time_coarse_sec;
 	gtod_long_t	monotonic_time_coarse_nsec;
+	gtod_long_t	monotonic_time_raw_sec;
+	gtod_long_t	monotonic_time_raw_nsec;
 
 	int		tz_minuteswest;
 	int		tz_dsttime;
---
