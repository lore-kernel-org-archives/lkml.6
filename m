Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932980AbeCOQBI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:01:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38818 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932941AbeCOQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:01:05 -0400
X-Google-Smtp-Source: AG47ELvcv1cyfXmVsnbHlnXvEeiGls+1EWDY4k2fRnvMnfWhMw9qFVWTvE3yDUAcSo9qSaBjPhhyMg==
From: jason.vas.dias@gmail.com
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: [PATCH v4.16-rc5 3/3] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
Date: Thu, 15 Mar 2018 16:00:48 +0000
Message-Id: <1521129648-20889-4-git-send-email-jason.vas.dias@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1521129648-20889-1-git-send-email-jason.vas.dias@gmail.com>
References: <1521129648-20889-1-git-send-email-jason.vas.dias@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 03f3904..61d9633 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -21,12 +21,15 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <uapi/asm/vdso_tsc_calibration.h>
 
 #define gtod (&VVAR(vsyscall_gtod_data))
 
 extern int __vdso_clock_gettime(clockid_t clock, struct timespec *ts);
 extern int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz);
 extern time_t __vdso_time(time_t *t);
+extern unsigned int __vdso_tsc_calibration(
+	struct linux_tsc_calibration_s *tsc_cal);
 
 #ifdef CONFIG_PARAVIRT_CLOCK
 extern u8 pvclock_page
@@ -383,3 +386,25 @@ notrace time_t __vdso_time(time_t *t)
 }
 time_t time(time_t *t)
 	__attribute__((weak, alias("__vdso_time")));
+
+notrace	unsigned int
+__vdso_linux_tsc_calibration(struct linux_tsc_calibration_s *tsc_cal)
+{
+	unsigned long seq;
+
+	do {
+		seq = gtod_read_begin(gtod);
+		if ((gtod->vclock_mode == VCLOCK_TSC) &&
+		    (tsc_cal != ((void *)0UL))) {
+			tsc_cal->tsc_khz = gtod->tsc_khz;
+			tsc_cal->mult    = gtod->raw_mult;
+			tsc_cal->shift   = gtod->raw_shift;
+			return 1;
+		}
+	} while (unlikely(gtod_read_retry(gtod, seq)));
+
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
diff --git a/arch/x86/include/uapi/asm/vdso_tsc_calibration.h b/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
new file mode 100644
index 0000000..ce4b5a45
--- /dev/null
+++ b/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
@@ -0,0 +1,81 @@
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
+ *  if(linux_tsc_cal == ((void *)0))
+ *  { fprintf(stderr,"the patch providing __vdso_linux_tsc_calibration"
+ *                   " is not applied to the kernel.\n");
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
+ *     u64 ns = lround(   ((double)rdtscp())
+ *                     / (((double)clock_source.tsc_khz) / 1e3)
+ *                    );
+ * (ie. if tsc_khz is 3000 , there are 3 tsc ticks per nanosecond,
+ *  so divide tsc ticks by 3).
+ *
+ * There should actually be very little difference between the two
+ * values obtained (@ 0.02% ) by either method.
+ */
+
+#endif
