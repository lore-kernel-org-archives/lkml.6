Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeCKG0F (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 01:26:05 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54344 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbeCKG0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 01:26:04 -0500
X-Google-Smtp-Source: AG47ELs58nYtXjr7LnCcAQHFEiTClNAjzdXHFzi6roebhbKd0qlqGWTZlex0EIzucO9ytqVmKyhDvg==
From: Jason Vas Dias <jason.vas.dias@gmail.com>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4.16-rc4 1/1] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
Date: Sun, 11 Mar 2018 06:25:56 +0000
Message-ID: <h8pngmbv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2B6QA5W015213


  Currently the VDSO does not handle
     clock_gettime( CLOCK_MONOTONIC_RAW, &ts )
  on Intel / AMD - it calls
     vdso_fallback_gettime()
  for this clock, which issues a syscall, having an unacceptably high
  latency (minimum measurable time or time between measurements)
  of 300-700ns on 2 2.8-3.9ghz Haswell x86_64 Family'_'Model : 06_3C
  machines under various versions of Linux.
     
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


  Best Regards,
     Jason Vas Dias  .
     
---
diff -up linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc4linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c
--- linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc4 2018-03-04 22:54:11.000000000 +0000
+++ linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c	2018-03-11 05:08:31.137681337 +0000
@@ -182,6 +182,29 @@ notrace static u64 vread_tsc(void)
 	return last;
 }
 
+notrace static u64 vread_tsc_raw(void)
+{
+        u64 tsc, last+        if( likely( gtod->has_rdtscp ) ) {
+                u32     tsc_lo, tsc_hi,
+                        tsc_cpu __attribute__((unused));
+                asm volatile
+                ( "rdtscp"
+                /* ^- has built-in cancellation point / pipeline stall"barrier" */
+                : "¬_lo)
+                , "Ü_hi)
+                , "Ì_cpu)
+                ); // since all variables 32-bit, eax, edx, ecx used - NOT rax, rdx, rcx                 
+                tsc      _lo) & 0xffffffffUL);
+        } else {
+                tsc      +        }
+	if (likely(tsc >+		return tsc;        
+        asm volatile ("");                                
+        return last;
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
+	if (gtod->vclock_mode +		cycles +#ifdef CONFIG_PARAVIRT_CLOCK
+	else if (gtod->vclock_mode +		cycles +#endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+	else if (gtod->vclock_mode +		cycles +#endif
+	else
+		return 0;
+	v +	return v * gtod->raw_mult;
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
+		seq +		mode +		ts->tv_sec +		ns +		ns ++		ns >>+	} while (unlikely(gtod_read_retry(gtod, seq)));
+
+	ts->tv_sec ++	ts->tv_nsec +
+	return mode;
+}
+
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
 	unsigned long seq;
@@ -277,6 +342,10 @@ notrace int __vdso_clock_gettime(clockid
 		if (do_monotonic(ts)  			goto fallback;
 		break;
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(ts) +			goto fallback;
+		break;
 	case CLOCK_REALTIME_COARSE:
 		do_realtime_coarse(ts);
 		break;
diff -up linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c.4.16-rc4 linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c
--- linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c.4.16-rc4 2018-03-04 22:54:11.000000000 +0000
+++ linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c 2018-03-11 05:10:57.371197747 +0000
@@ -16,6 +16,7 @@
 #include <linux/timekeeper_internal.h>
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
+#include <asm/cpufeature.h>
 
 int vclocks_used __read_mostly;
 
@@ -45,6 +46,12 @@ void update_vsyscall(struct timekeeper *
 	vdata->mult		 	vdata->shift		 
+	vdata->raw_cycle_last   +	vdata->raw_mask         +	vdata->raw_mult         +	vdata->raw_shift	+	vdata->has_rdtscp	+
 	vdata->wall_time_sec		 	vdata->wall_time_snsec		 
@@ -74,5 +81,8 @@ void update_vsyscall(struct timekeeper *
 		vdata->monotonic_time_coarse_sec++;
 	}
 
+	vdata->monotonic_time_raw_sec  +	vdata->monotonic_time_raw_nsec +
 	gtod_write_end(vdata);
 }
diff -up linux-4.16-rc4/arch/x86/include/asm/vgtod.h.4.16-rc4 linux-4.16-rc4/arch/x86/include/asm/vgtod.h
--- linux-4.16-rc4/arch/x86/include/asm/vgtod.h.4.16-rc4 2018-03-04 22:54:11.000000000 +0000
+++ linux-4.16-rc4/arch/x86/include/asm/vgtod.h	2018-03-11 05:12:35.916338703 +0000
@@ -22,6 +22,11 @@ struct vsyscall_gtod_data {
 	u64	mask;
 	u32	mult;
 	u32	shift;
+	u64	raw_cycle_last;
+	u64     raw_mask;
+	u32     raw_mult;
+	u32     raw_shift;
+	u32     has_rdtscp;
 
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
