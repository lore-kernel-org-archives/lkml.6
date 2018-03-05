Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeCEC7Y (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:59:24 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44121 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeCEC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:59:23 -0500
X-Google-Smtp-Source: AG47ELuYsV1jlpspEdZ7GgEnXKccbJBD3yKYAe+uYA2hcowtc7yZbE8UqOtORRrGiyyyOxGyuohTYopVUByIsBcHs1E=
MIME-Version: 1.0
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Mon, 5 Mar 2018 02:59:21 +0000
Message-ID: <CALyZvKx=kOaUqTWFK5gZXNTcY9+jCaKRqaH6VAJAOXmp-JJ2Bg@mail.gmail.com>
Subject: [PATCH v4.15.7 1/1] on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
 and export 'tsc_calibration' pointer
To: x86@kernel.org, linux-kernel@vger.kernel.org, andi@firstfloor.org,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel / AMD platforms, when the clock source is TSC,
this makes the VDSO support
    clock_gettime(CLOCK_MONOTONIC_RAW, &timespec)
calls by issuing a 'rdtscp' instruction and doing performing
conversion of the value according to kernel TSC calibration
'mult' and 'shift' values in the vsyscall_gtod_data structure :
  ...
    tsc  = rdtscp();
    tsc   *= gtod->mult;
    tsc >>=gtod->shift;
    ts->tv_sec = __iter_div_u64_rem( tsc, 1000000000UL, &tsc->tv_nsec );
  ...
 instead of calling vdso_fallback_gtod()  for CLOCK_MONOTONIC_RAW
 clockid_t values.

It also provides a new function in the VDSO :

struct linux_timestamp_conversion
{ u32  mult;
  u32  shift;
};
extern
  const struct linux_timestamp_conversion *
  __vdso_linux_tsc_calibration(void);

which can be used by user-space rdtsc / rdtscp issuers
by using code such as in
   tools/testing/selftests/vDSO/parse_vdso.c
to call vdso_sym("LINUX_2.6", "__vdso_linux_tsc_calibration"),
which returns a pointer to the function in the VDSO, which
returns the address of the 'mult' field in the vsyscall_gtod_data.

Thus user-space programs can use rdtscp and interpret its return values
in exactly the same way the kernel would, but without entering the kernel.

 As pointed out in Bug # 198961 :
   https://bugzilla.kernel.org/show_bug.cgi?id=198961
 which contains extra test programs and the full story behind this change,
 using CLOCK_MONOTONIC_RAW without the patch results in
 a minimum measurable time (latency) of @ 300 - 700ns because of
 the syscall used by vdso_fallback_gtod() .

With the patch, the latency falls to @ 100ns .

The latency would be @ 16 - 32 ns  if the do_monotonic_raw()
handler could record its previous TSC value and seconds return value
somewhere, but since the VDSO has no data region or writable page,
of course it cannot . Hence, to enable effective use of TSC by user
space programs, Linux must provide a way for them to discover the
calibration mult and shift values the kernel uses for the clock source ;
only by doing so can user-space get values that are comparable to
kernel generated values.

And I'd really like to know: why does the gtod->mult value change ?
After TSC calibration, it and the shift are calculated to render the
best approximation of a nanoseconds value from the TSC value.

The TSC is MEANT to be monotonic and to continue in sleep states
on modern Intel CPUs . So why does the gtod->mult change ?

But the mult value does change.  Currently there is no way for
user-space programs
to discover that such a change has occurred, or when . With this very
tiny simple
patch, they could know instantly when such changes occur, and could implement
TSC readers that perform the full conversion with latencies of 15-30ns
(on my CPU).

Here is the patch:

BEGIN PATCH :

diff --git a/arch/x86/entry/vdso/vclock_gettime.c
b/arch/x86/entry/vdso/vclock_gettime.c
index f19856d..63f5f18 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -246,6 +246,28 @@ notrace static int __always_inline
do_monotonic(struct timespec *ts)
 	return mode;
 }

+notrace static int __always_inline do_monotonic_raw( struct timespec *ts)
+{
+        volatile u32 tsc_lo=0, tsc_hi=0, tsc_cpu=0; // so same instrs
generated for 64-bit as for 32-bit builds
+        u64 ns;
+        register u64 tsc=0;
+        if (gtod->vclock_mode == VCLOCK_TSC)
+        { asm volatile
+            ( "rdtscp"
+            : "=a" (tsc_lo)
+            , "=d" (tsc_hi)
+            , "=c" (tsc_cpu)
+            ); // : eax, edx, ecx used - NOT rax, rdx, rcx
+	  tsc     = ((((u64)tsc_hi) & 0xffffffffUL) << 32) | (((u64)tsc_lo)
& 0xffffffffUL);
+	  tsc    *= gtod->mult;
+	  tsc   >>= gtod->shift;
+	  ts->tv_sec  = __iter_div_u64_rem(tsc, NSEC_PER_SEC, &ns);
+	  ts->tv_nsec = ns;
+	  return VCLOCK_TSC;
+        }
+        return VCLOCK_NONE;
+}
+
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
 	unsigned long seq;
@@ -277,6 +299,10 @@ notrace int __vdso_clock_gettime(clockid_t clock,
struct timespec *ts)
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
@@ -326,3 +352,25 @@ notrace time_t __vdso_time(time_t *t)
 }
 time_t time(time_t *t)
 	__attribute__((weak, alias("__vdso_time")));
+
+
+struct linux_timestamp_conversion
+{ u32  mult;
+  u32  shift;
+};
+
+extern
+  const struct linux_timestamp_conversion *
+  __vdso_linux_tsc_calibration(void);
+
+notrace
+  const struct linux_timestamp_conversion *
+  __vdso_linux_tsc_calibration(void)
+{ if( gtod->vclock_mode == VCLOCK_TSC )
+    return ((struct linux_timestamp_conversion*) &gtod->mult);
+  return 0UL;
+}
+
+const struct linux_timestamp_conversion *
+  linux_tsc_calibration(void) __attribute((weak,
alias("__vdso_linux_tsc_calibration")));
+
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index d3a2dce..41a2ca5 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -24,7 +24,9 @@ VERSION {
 		getcpu;
 		__vdso_getcpu;
 		time;
-		__vdso_time;
+	        __vdso_time;
+                linux_tsc_calibration;
+		__vdso_linux_tsc_calibration;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 422764a..d53bd73 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -25,7 +25,8 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
-		__vdso_time;
+	        __vdso_time;
+                __vdso_linux_tsc_calibration;
 	};

 	LINUX_2.5 {
diff --git a/arch/x86/entry/vdso/vdsox32.lds.S
b/arch/x86/entry/vdso/vdsox32.lds.S
index 05cd1c5..fb13b16 100644
--- a/arch/x86/entry/vdso/vdsox32.lds.S
+++ b/arch/x86/entry/vdso/vdsox32.lds.S
@@ -20,7 +20,8 @@ VERSION {
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_getcpu;
-		__vdso_time;
+	        __vdso_time;
+                __vdso_linux_tsc_calibration;
 	local: *;
 	};
 }


: END PATCH

This patch is Attachment #274527 to Bug #198961 :
https://bugzilla.kernel.org/attachment.cgi?id=274527&action=diff

and here is an example of its usage, which must be linked with
object compiled from  tools/testing/selftests/vDSO/parse_vdso.c :

BEGIN EXAMPLE

#include <time.h>
#include <sys/auxv.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>

#include ".../path_to_kernel/tools/testing/selftests/vDSO/parse_vdso.c"

typedef
struct lnx_tsc_calibration_s
{ unsigned int mult, shift;
} LnxTSCCalibration_t;

void clock_get_time_raw( struct timespec *ts , const
LnxTSCCalibration_t * tsc_cal, unsigned long *last_tsc, unsigned long
*last_sec)
{ volatile unsigned int  tsc_lo=0, tsc_hi=0, tsc_cpu=0; // so same
instrs generated for 64-bit as for 32-bit builds
  register unsigned long tsc=0;
  asm volatile
  ( "rdtscp"
  : "=a" (tsc_lo)
  , "=d" (tsc_hi)
  , "=c" (tsc_cpu)
  ); // : eax, edx, ecx used - NOT rax, rdx, rcx
  tsc     = ((((unsigned long)tsc_hi) & 0xffffffffUL) << 32) |
(((unsigned long)tsc_lo) & 0xffffffffUL);
  tsc    *= tsc_cal->mult;
  tsc   >>= tsc_cal->shift;
  if ( last_tsc && *last_tsc && last_sec )
  { register unsigned long tsc_diff = tsc - *last_tsc;
    if ( tsc_diff > 999999999UL )
    { ts->tv_sec  = tsc / 1000000000;
      ts->tv_nsec = tsc % 1000000000;
    }else
    { ts->tv_sec = *last_sec;
      ts->tv_nsec = tsc_diff;
    }
    *last_tsc = tsc;
    *last_sec = ts->tv_sec;
  }else
  { ts->tv_sec  = tsc / 1000000000;
    ts->tv_nsec = tsc % 1000000000;
  }
}

#ifndef N_SAMPLES
#define N_SAMPLES 100
#endif

int main( int argc, const char *const* argv , const char **const envp )
{
  register unsigned long sysinfo_ehdr = getauxval( AT_SYSINFO_EHDR );
  if( 0 == sysinfo_ehdr )
  { fprintf(stderr,"getauxval failed: %d : '%s'.\n", errno, strerror(errno));
    return 1;
  }
  vdso_init_from_sysinfo_ehdr( sysinfo_ehdr );
  if ( ! vdso_info.valid )
  { fprintf(stderr,"vdso_init_from_sysinfo_ehdr failed\n");
    return 1;
  }
  const struct lnx_tsc_calibration_s*
    (*linux_tsc_cal)(void) = vdso_sym("LINUX_2.6",
"__vdso_linux_tsc_calibration");
  if( linux_tsc_cal == 0UL )
  { fprintf(stderr,"vdso_sym failed\n");
    return 1;
  }
  const struct lnx_tsc_calibration_s *clock_source = (*linux_tsc_cal)();
  fprintf(stderr,"Got TSC calibration @ %p: mult: %u shift: %u\n",
          (void*)clock_source, clock_source->mult, clock_source->shift
         );
#define TS2NS(_TS_) ((((unsigned long
long)(_TS_).tv_sec)*1000000000ULL) + (((unsigned long
long)((_TS_).tv_nsec))))
  struct timespec t_s;
  unsigned long last_tsc=0, last_seconds=0;
  clock_get_time_raw( &t_s, clock_source, &last_tsc, &last_seconds );
  unsigned long long
    sample [ N_SAMPLES ]
  , t1, t2
  , t_start = TS2NS(t_s);
  unsigned int s=0;
  do
  { clock_get_time_raw( &t_s, clock_source, &last_tsc, &last_seconds);
    t1 = TS2NS(t_s);
    clock_get_time_raw( &t_s, clock_source, &last_tsc, &last_seconds);
    t2 = TS2NS(t_s);
    sample [ s ] = t2 - t1;
  }while(++s < N_SAMPLES);
  unsigned long long sum = 0;
  for(s = 0; s < N_SAMPLES; s+=1)
    sum += sample[s];
  fprintf(stderr,"sum: %llu\n",sum);
  unsigned long long avg_ns = sum / N_SAMPLES;
  t1=(t2 - t_start);
  fprintf(stderr,
	  "Total time: %1.1llu.%9.9lluS - Average Latency: %1.1llu.%9.9lluS\n",
          t1/1000000000,       t1-((t1/1000000000)*1000000000),
          avg_ns/1000000000,   avg_ns-((avg_ns/1000000000)*1000000000)
	  );	
  return 0;
}

: END EXAMPLE

EXAMPLE Usage :
$ gcc -std=gnu11 -o t_vdso_tsc t_vdso_tsc.c
$ ./t_vdso_tsc
Got TSC calibration @ 0x7ffdb9be5098: mult: 5798705 shift: 24
sum: 2222
Total time: 0.000004859S - Average Latency: 0.000000022S

Latencies are typically @ 15 - 30 ns .

That multiplication and shift really doesn't leave very many
significant seconds bits!

Please, can the VDSO include some similar functionality to NOT always
enter the kernel for CLOCK_MONOTONIC_RAW , and to export a pointer to
the LIVE (kernel updated) gtod->mult and gtod->shift values somehow .

The documentation states for CLOCK_MONOTONIC_RAW that it is the
same as CLOCK_MONOTONIC except it is NOT subject to NTP adjustments .
This is very far from the case currently, without a patch like the one above.

And the kernel should not restrict user-space programs to only being able
to either measure an NTP adjusted time value, or a time value
difference of greater
than 1000ns with any accuracy, on a modern Intel CPU whose TSC ticks 2.8 times
per nanosecond (picosecond resolution is theoretically possible).

Please, include something like the above patch in future Linux versions.

Thanks & Best Regards,
Jason Vas Dias <jason.vas.dias@gmail.com>
