Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbeCKHJE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 03:09:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55711 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeCKHJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 03:09:03 -0400
X-Google-Smtp-Source: AG47ELtKWO+L87OPyLfVAcmSgY5webcv46KzKEjS6yYd5lQkU6nWPbiHihrIN0WtmrwDfWv45kabOA==
From: Jason Vas Dias <jason.vas.dias@gmail.com>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Fwd: [PATCH v4.15.7 1/1] on Intel, VDSO should handle CLOCK_MONOTONIC_RAW and export 'tsc_calibration' pointer
Date: Sun, 11 Mar 2018 07:08:56 +0000
Message-ID: <8tazgkc7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Thomas -

Thanks very much for your help & guidance in previous mail:

RE: On 08/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> The right way to do that is to put the raw conversion values and the raw
> seconds base value into the vdso data and implement the counterpart of
> getrawmonotonic64(). And if that is done, then it can be done for _ALL_
> clocksources which support VDSO access and not just for the TSC.
>

I have done this now with a new patch, sent in mail with subject :
  
'[PATCH v4.16-rc4 1/1] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW' 

which should address all the concerns you raise.

> I already  know how that works, really.

I never doubted or meant to impugn that !

I am beginning to know a little how that works also, thanks in great
part to your help last week - thanks for your patience.

I was impatient last week to get access to low latency timers for a work
project, and was trying to read the unadjusted clock .

> instead of making completely false claims about the correctness of the kernel
> timekeeping infrastructure.

I really didn't mean to make any such claims - I'm sorry if I did .  I was just trying
to say that by the time the results of clock_gettime(CLOCK_MONOTONIC_RAW,&ts) were
available to the caller they were not of much use because of the
latencies often dwarfing the time differences .

Anyway, I hope sometime you will consider putting such a patch in the
kernel.

I have developed a verson for ARM also, but that depends on making
CNTPCT + CNTFRQ registers readable in user-space, which is not meant
to be secure and is not normally done , but does work - but it is
against the Texas Instruments (ti-linux) kernel and can be enabled
with a new KConfig option, and brings latencies down from > 300ns
to < 20ns . Maybe I should post that also to kernel.org, or to
ti.com ?

I have a separate patch for the vdso_tsc_calibration export of the
tsc_khz and calibration which no longer returns pointers into the VDSO -
I can post this as a patch if you like.

Thanks & Best Regards,
Jason Vas Dias <jason.vas.dias@gmail.com>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=vdso_monotonic_raw-v4.16-rc4.patch
Content-Description: Patch against v4.16-rc4 to implement
 CLOCK_MONOTONIC_RAW in VDSO

diff -up linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc4 linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c
--- linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc4	2018-03-04 22:54:11.000000000 +0000
+++ linux-4.16-rc4/arch/x86/entry/vdso/vclock_gettime.c	2018-03-11 05:08:31.137681337 +0000
@@ -182,6 +182,29 @@ notrace static u64 vread_tsc(void)
 	return last;
 }
 
+notrace static u64 vread_tsc_raw(void)
+{
+        u64 tsc, last=gtod->raw_cycle_last;
+        if( likely( gtod->has_rdtscp ) ) {
+                u32     tsc_lo, tsc_hi,
+                        tsc_cpu __attribute__((unused));
+                asm volatile
+                ( "rdtscp"
+                /* ^- has built-in cancellation point / pipeline stall "barrier" */
+                : "=a" (tsc_lo)
+                , "=d" (tsc_hi)
+                , "=c" (tsc_cpu)
+                ); // since all variables 32-bit, eax, edx, ecx used - NOT rax, rdx, rcx                 
+                tsc      = ((((u64)tsc_hi) & 0xffffffffUL) << 32) | (((u64)tsc_lo) & 0xffffffffUL);
+        } else {
+                tsc      = rdtsc_ordered();
+        }
+	if (likely(tsc >= last))
+		return tsc;        
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
+++ linux-4.16-rc4/arch/x86/entry/vsyscall/vsyscall_gtod.c	2018-03-11 05:10:57.371197747 +0000
@@ -16,6 +16,7 @@
 #include <linux/timekeeper_internal.h>
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
+#include <asm/cpufeature.h>
 
 int vclocks_used __read_mostly;
 
@@ -45,6 +46,12 @@ void update_vsyscall(struct timekeeper *
 	vdata->mult		= tk->tkr_mono.mult;
 	vdata->shift		= tk->tkr_mono.shift;
 
+	vdata->raw_cycle_last   = tk->tkr_raw.cycle_last;
+	vdata->raw_mask         = tk->tkr_raw.mask;
+	vdata->raw_mult         = tk->tkr_raw.mult;
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

--=-=-=--
