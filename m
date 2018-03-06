Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeCFX44 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:56:56 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44502 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbeCFX4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:56:55 -0500
X-Google-Smtp-Source: AG47ELvHsP7d4YBP1FGY9KQQLEPMxgYweb37ctoywayAlolyJJWAAgjtCTo1K13fo6KCnWOmoGQ97WNzZ7nUYyhXbik=
MIME-Version: 1.0
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Tue, 6 Mar 2018 23:56:53 +0000
Message-ID: <CALyZvKxPr1ZsRmHCuhbQJ1ZDjpe4CMXmRQKbyu8tHNf9eb5fdw@mail.gmail.com>
Subject: [PATCH v4.15.7 1/1] x86/vdso: handle clock_gettime(CLOCK_MONOTONIC_RAW,
 &ts) in VDSO
To: x86@kernel.org, linux-kernel@vger.kernel.org,
        andi <andi@firstfloor.org>, tglx@linutronix.de
Content-Type: multipart/mixed; boundary="001a1147357674ae060566c7320b"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a1147357674ae060566c7320b
Content-Type: text/plain; charset="UTF-8"

Handling clock_gettime( CLOCK_MONOTONIC_RAW, &timespec)
by calling  vdso_fallback_gettime(),  ie. syscall,  is too slow  -
latencies of  300-700ns are common on Haswell (06:3C)  CPUs .

This patch against the 4.15.7 stable branch makes the VDSO handle
clock_gettime(CLOCK_GETTIME_RAW, &ts)
by issuing rdtscp in userspace,  IFF the clock source is the TSC, and converting
it to nanoseconds using the vsyscall_gtod_data 'mult' and 'shift' fields :

      volatile u32 tsc_lo, tsc_hi, tsc_cpu;
      asm volatile( "rdtscp" : (=a) tsc_lo, (=d) tsc_hi, (=c) tsc_cpu );
      u64 tsc = (((u64)tsc_hi)<<32) | ((u64)tsc_lo);
      tsc *= gtod->mult;
      tsc >>=gtod->shift;
      /* tsc is now number of nanoseconds */
      ts->tv_sec = __iter_div_u64_rem( tsc, NSEC_PER_SEC, &ts->tv_nsec);

Use of the "open coded asm" style here actually forces the compiler to
always choose the 32-bit version of rdtscp, which sets only %eax,
%edx, and %ecx and does not clear the high bits of %rax, %rdx, and
%rdx , because the
variables are declared 32-bit  - so the same 32-bit version is used whether
the code is compiled with -m32 or -m64 ( tested using gcc 5.4.0, gcc 6.4.1 ) .

The full story and test programs are in Bug #198961 :
    https://bugzilla.kernel.org/show_bug.cgi?id=198961
.

The patched VDSO now handles clock_gettime(CLOCK_MONOTONIC_RAW, &ts)
on the same machine with a latency (minimum time that can be measured)
of
around 100ns (compared with 300-700ns before patch).

I also think it makes sense to expose pointers to the live, updated
gtod->mult and gtod->shift values somehow to userspace . Then
a userspace TSC reader could re-use previous values to avoid
the long-division in most cases and obtain latencies of 10-20ns .

Hence there is now a new method in the VDSO:
   __ vdso_linux_tsc_calibration()
which returns a pointer to a 'struct linux_tsc_calibration'
declared in a new header
   arch/x86/include/uapi/asm/vdso_tsc_calibration.h

If the clock source is NOT the TSC, this function returns NULL .
The pointer is only valid when the system clock source is the TSC .
User-space TSC readers can detect when TSC is modified with Events,
and now can detect when clock source changes from / to TSC with
this function .

The patch :

---
diff --git a/arch/x86/entry/vdso/vclock_gettime.c \
b/arch/x86/entry/vdso/vclock_gettime.c
index f19856d..e840600 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -21,6 +21,7 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <uapi/asm/vdso_tsc_calibration.h>

 #define gtod (&VVAR(vsyscall_gtod_data))

@@ -246,6 +247,29 @@ notrace static int __always_inline do_monotonic\
(struct timespec *ts)
 	return mode;
 }

+notrace static int __always_inline do_monotonic_raw( struct timespec *ts)
+{
+        volatile u32 tsc_lo=0, tsc_hi=0, tsc_cpu=0; // so same instrs
generated for 64-bit as for 32-bit builds
+        u64 ns;
+        register u64 tsc=0;
+        if (gtod->vclock_mode == VCLOCK_TSC)
+        {
+                asm volatile
+                ( "rdtscp"
+                : "=a" (tsc_lo)
+                , "=d" (tsc_hi)
+                , "=c" (tsc_cpu)
+                ); // : eax, edx, ecx used - NOT rax, rdx, rcx
+                tsc     = ((((u64)tsc_hi) & 0xffffffffUL) << 32) |
(((u64)tsc_lo) & 0xffffffffUL);
+                tsc    *= gtod->mult;
+                tsc   >>= gtod->shift;
+                ts->tv_sec  = __iter_div_u64_rem(tsc, NSEC_PER_SEC,
&ns);
+                ts->tv_nsec = ns;
+                return VCLOCK_TSC;
+        }
+        return VCLOCK_NONE;
+}
+
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
 	unsigned long seq;
@@ -277,6 +301,10 @@ notrace int __vdso_clock_gettime(clockid_t clock,
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
@@ -326,3 +354,18 @@ notrace time_t __vdso_time(time_t *t)
 }
 time_t time(time_t *t)
 	__attribute__((weak, alias("__vdso_time")));
+
+extern const struct linux_tsc_calibration *
+        __vdso_linux_tsc_calibration(void);
+
+notrace  const struct linux_tsc_calibration *
+  __vdso_linux_tsc_calibration(void)
+{
+        if( gtod->vclock_mode == VCLOCK_TSC )
+                return ((const struct linux_tsc_calibration*) &gtod->mult);
+        return 0UL;
+}
+
+const struct linux_tsc_calibration * linux_tsc_calibration(void)
+        __attribute((weak, alias("__vdso_linux_tsc_calibration")));
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
diff --git a/arch/x86/include/uapi/asm/vdso_tsc_calibration.h \
b/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
new file mode 100644
index 0000000..6febb84
--- /dev/null
+++ b/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_X86_VDSO_TSC_CALIBRATION_H
+#define _ASM_X86_VDSO_TSC_CALIBRATION_H
+/*
+ * Programs that want to use rdtsc / rdtscp instructions
+ * from user-space can make use of the Linux kernel TSC calibration
+ * by calling :
+ *    __vdso_linux_tsc_calibration(void);
+ * ( one has to resolve this symbol as in
+ *   tools/testing/selftests/vDSO/parse_vdso.c
+ * )
+ * which returns a pointer into the read-only
+ * vvar_page (the vsyscall_gtod_data structure),
+ * with the following layout :
+ */
+
+struct linux_tsc_calibration
+{
+        unsigned int mult;   /* amount to multiply 64-bit TSC value by */
+
+        unsigned int shift;  /* the right shift to apply to
(mult*TSC) yielding \
 nanoseconds */
+};
+
+/* To use:
+ *
+ *  static const struct lnx_tsc_calibration_s*
+ *  (*linux_tsc_cal)(void) = vdso_sym("LINUX_2.6",
"__vdso_linux_tsc_calibration");
+ *  if( linux_tsc_cal == 0UL )
+ *  { fprintf(stderr,"the patch providing __vdso_linux_tsc_calibration is not \
  applied    to the kernel.\n");
+ *    return ERROR;
+ *  }
+ *  static const struct lnx_tsc_calibration_s *clock_source =
(*linux_tsc_cal)();
+ *  if( clock_source == ((void*)0UL))
+ *    fprintf(stderr,"TSC is not the system clocksource.\n");
+ *  volatile unsigned int tsc_lo, tsc_hi, tsc_cpu;
+ *  asm volatile
+ *  ( "rdtscp" : (=a) tsc_hi,  (=d) tsc_lo, (=c) tsc_cpu );
+ *  unsigned long tsc = (((unsigned long)tsc_hi) << 32) | tsc_lo;
+ *  unsigned long nanoseconds =
+ *   (( clock_source -> mult ) * tsc ) >> (clock_source -> shift);
+ *
+ *  nanoseconds is now TSC value converted to nanoseconds,
+ *  according to Linux' clocksource calibration values.
+ *
+ */
+
+#endif
---

--001a1147357674ae060566c7320b
Content-Type: application/octet-stream;
	name="vdso_vclock_gettime_userspace_tsc_4.15.7.patch"
Content-Disposition: attachment;
	filename="vdso_vclock_gettime_userspace_tsc_4.15.7.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYyBiL2FyY2gv
eDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYwppbmRleCBmMTk4NTZkLi5lODQwNjAwIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3ZjbG9ja19nZXR0aW1lLmMKKysrIGIvYXJj
aC94ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5jCkBAIC0yMSw2ICsyMSw3IEBACiAjaW5j
bHVkZSA8bGludXgvbWF0aDY0Lmg+CiAjaW5jbHVkZSA8bGludXgvdGltZS5oPgogI2luY2x1ZGUg
PGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPHVhcGkvYXNtL3Zkc29fdHNjX2NhbGlicmF0aW9u
Lmg+CiAKICNkZWZpbmUgZ3RvZCAoJlZWQVIodnN5c2NhbGxfZ3RvZF9kYXRhKSkKIApAQCAtMjQ2
LDYgKzI0NywyOSBAQCBub3RyYWNlIHN0YXRpYyBpbnQgX19hbHdheXNfaW5saW5lIGRvX21vbm90
b25pYyhzdHJ1Y3QgdGltZXNwZWMgKnRzKQogCXJldHVybiBtb2RlOwogfQogCitub3RyYWNlIHN0
YXRpYyBpbnQgX19hbHdheXNfaW5saW5lIGRvX21vbm90b25pY19yYXcoIHN0cnVjdCB0aW1lc3Bl
YyAqdHMpCit7ICAgICAgIAorICAgICAgICB2b2xhdGlsZSB1MzIgdHNjX2xvPTAsIHRzY19oaT0w
LCB0c2NfY3B1PTA7IC8vIHNvIHNhbWUgaW5zdHJzIGdlbmVyYXRlZCBmb3IgNjQtYml0IGFzIGZv
ciAzMi1iaXQgYnVpbGRzCisgICAgICAgIHU2NCBuczsKKyAgICAgICAgcmVnaXN0ZXIgdTY0IHRz
Yz0wOworICAgICAgICBpZiAoZ3RvZC0+dmNsb2NrX21vZGUgPT0gVkNMT0NLX1RTQykKKyAgICAg
ICAgeworICAgICAgICAgICAgICAgIGFzbSB2b2xhdGlsZQorICAgICAgICAgICAgICAgICggInJk
dHNjcCIKKyAgICAgICAgICAgICAgICA6ICI9YSIgKHRzY19sbykKKyAgICAgICAgICAgICAgICAs
ICI9ZCIgKHRzY19oaSkKKyAgICAgICAgICAgICAgICAsICI9YyIgKHRzY19jcHUpCisgICAgICAg
ICAgICAgICAgKTsgLy8gOiBlYXgsIGVkeCwgZWN4IHVzZWQgLSBOT1QgcmF4LCByZHgsIHJjeAor
ICAgICAgICAgICAgICAgIHRzYyAgICAgPSAoKCgodTY0KXRzY19oaSkgJiAweGZmZmZmZmZmVUwp
IDw8IDMyKSB8ICgoKHU2NCl0c2NfbG8pICYgMHhmZmZmZmZmZlVMKTsKKyAgICAgICAgICAgICAg
ICB0c2MgICAgKj0gZ3RvZC0+bXVsdDsKKyAgICAgICAgICAgICAgICB0c2MgICA+Pj0gZ3RvZC0+
c2hpZnQ7CisgICAgICAgICAgICAgICAgdHMtPnR2X3NlYyAgPSBfX2l0ZXJfZGl2X3U2NF9yZW0o
dHNjLCBOU0VDX1BFUl9TRUMsICZucyk7ICAgICAgICAgICAgCisgICAgICAgICAgICAgICAgdHMt
PnR2X25zZWMgPSBuczsgICAgICAgICAgCisgICAgICAgICAgICAgICAgcmV0dXJuIFZDTE9DS19U
U0M7ICAgICAgICAgICAgICAgIAorICAgICAgICB9CisgICAgICAgIHJldHVybiBWQ0xPQ0tfTk9O
RTsKK30KKwogbm90cmFjZSBzdGF0aWMgdm9pZCBkb19yZWFsdGltZV9jb2Fyc2Uoc3RydWN0IHRp
bWVzcGVjICp0cykKIHsKIAl1bnNpZ25lZCBsb25nIHNlcTsKQEAgLTI3Nyw2ICszMDEsMTAgQEAg
bm90cmFjZSBpbnQgX192ZHNvX2Nsb2NrX2dldHRpbWUoY2xvY2tpZF90IGNsb2NrLCBzdHJ1Y3Qg
dGltZXNwZWMgKnRzKQogCQlpZiAoZG9fbW9ub3RvbmljKHRzKSA9PSBWQ0xPQ0tfTk9ORSkKIAkJ
CWdvdG8gZmFsbGJhY2s7CiAJCWJyZWFrOworCWNhc2UgQ0xPQ0tfTU9OT1RPTklDX1JBVzoKKwkJ
aWYgKGRvX21vbm90b25pY19yYXcodHMpID09IFZDTE9DS19OT05FKQorCQkJZ290byBmYWxsYmFj
azsKKwkJYnJlYWs7CiAJY2FzZSBDTE9DS19SRUFMVElNRV9DT0FSU0U6CiAJCWRvX3JlYWx0aW1l
X2NvYXJzZSh0cyk7CiAJCWJyZWFrOwpAQCAtMzI2LDMgKzM1NCwxOCBAQCBub3RyYWNlIHRpbWVf
dCBfX3Zkc29fdGltZSh0aW1lX3QgKnQpCiB9CiB0aW1lX3QgdGltZSh0aW1lX3QgKnQpCiAJX19h
dHRyaWJ1dGVfXygod2VhaywgYWxpYXMoIl9fdmRzb190aW1lIikpKTsKKworZXh0ZXJuIGNvbnN0
IHN0cnVjdCBsaW51eF90c2NfY2FsaWJyYXRpb24gKgorICAgICAgICBfX3Zkc29fbGludXhfdHNj
X2NhbGlicmF0aW9uKHZvaWQpOworCitub3RyYWNlICBjb25zdCBzdHJ1Y3QgbGludXhfdHNjX2Nh
bGlicmF0aW9uICoKKyAgX192ZHNvX2xpbnV4X3RzY19jYWxpYnJhdGlvbih2b2lkKQoreworICAg
ICAgICBpZiggZ3RvZC0+dmNsb2NrX21vZGUgPT0gVkNMT0NLX1RTQyApIAorICAgICAgICAgICAg
ICAgIHJldHVybiAoKGNvbnN0IHN0cnVjdCBsaW51eF90c2NfY2FsaWJyYXRpb24qKSAmZ3RvZC0+
bXVsdCk7CisgICAgICAgIHJldHVybiAwVUw7Cit9CisKK2NvbnN0IHN0cnVjdCBsaW51eF90c2Nf
Y2FsaWJyYXRpb24gKiBsaW51eF90c2NfY2FsaWJyYXRpb24odm9pZCkKKyAgICAgICAgX19hdHRy
aWJ1dGUoKHdlYWssIGFsaWFzKCJfX3Zkc29fbGludXhfdHNjX2NhbGlicmF0aW9uIikpKTsKKwpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvLmxkcy5TIGIvYXJjaC94ODYvZW50
cnkvdmRzby92ZHNvLmxkcy5TCmluZGV4IGQzYTJkY2UuLjQxYTJjYTUgMTAwNjQ0Ci0tLSBhL2Fy
Y2gveDg2L2VudHJ5L3Zkc28vdmRzby5sZHMuUworKysgYi9hcmNoL3g4Ni9lbnRyeS92ZHNvL3Zk
c28ubGRzLlMKQEAgLTI0LDcgKzI0LDkgQEAgVkVSU0lPTiB7CiAJCWdldGNwdTsKIAkJX192ZHNv
X2dldGNwdTsKIAkJdGltZTsKLQkJX192ZHNvX3RpbWU7CisJICAgICAgICBfX3Zkc29fdGltZTsK
KyAgICAgICAgICAgICAgICBsaW51eF90c2NfY2FsaWJyYXRpb247CisJCV9fdmRzb19saW51eF90
c2NfY2FsaWJyYXRpb247CiAJbG9jYWw6ICo7CiAJfTsKIH0KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2VudHJ5L3Zkc28vdmRzbzMyL3Zkc28zMi5sZHMuUyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmRz
bzMyL3Zkc28zMi5sZHMuUwppbmRleCA0MjI3NjRhLi5kNTNiZDczIDEwMDY0NAotLS0gYS9hcmNo
L3g4Ni9lbnRyeS92ZHNvL3Zkc28zMi92ZHNvMzIubGRzLlMKKysrIGIvYXJjaC94ODYvZW50cnkv
dmRzby92ZHNvMzIvdmRzbzMyLmxkcy5TCkBAIC0yNSw3ICsyNSw4IEBAIFZFUlNJT04KIAlnbG9i
YWw6CiAJCV9fdmRzb19jbG9ja19nZXR0aW1lOwogCQlfX3Zkc29fZ2V0dGltZW9mZGF5OwotCQlf
X3Zkc29fdGltZTsKKwkgICAgICAgIF9fdmRzb190aW1lOworICAgICAgICAgICAgICAgIF9fdmRz
b19saW51eF90c2NfY2FsaWJyYXRpb247CiAJfTsKIAogCUxJTlVYXzIuNSB7CmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc294MzIubGRzLlMgYi9hcmNoL3g4Ni9lbnRyeS92ZHNv
L3Zkc294MzIubGRzLlMKaW5kZXggMDVjZDFjNS4uZmIxM2IxNiAxMDA2NDQKLS0tIGEvYXJjaC94
ODYvZW50cnkvdmRzby92ZHNveDMyLmxkcy5TCisrKyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmRz
b3gzMi5sZHMuUwpAQCAtMjAsNyArMjAsOCBAQCBWRVJTSU9OIHsKIAkJX192ZHNvX2Nsb2NrX2dl
dHRpbWU7CiAJCV9fdmRzb19nZXR0aW1lb2ZkYXk7CiAJCV9fdmRzb19nZXRjcHU7Ci0JCV9fdmRz
b190aW1lOworCSAgICAgICAgX192ZHNvX3RpbWU7CisgICAgICAgICAgICAgICAgX192ZHNvX2xp
bnV4X3RzY19jYWxpYnJhdGlvbjsKIAlsb2NhbDogKjsKIAl9OwogfQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvaW5jbHVkZS91YXBpL2FzbS92ZHNvX3RzY19jYWxpYnJhdGlvbi5oIGIvYXJjaC94ODYv
aW5jbHVkZS91YXBpL2FzbS92ZHNvX3RzY19jYWxpYnJhdGlvbi5oCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAuLjZmZWJiODQKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL3VhcGkvYXNtL3Zkc29fdHNjX2NhbGlicmF0aW9uLmgKQEAgLTAsMCArMSw0NyBAQAor
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgV0lUSCBMaW51eC1zeXNjYWxsLW5v
dGUgKi8KKyNpZm5kZWYgX0FTTV9YODZfVkRTT19UU0NfQ0FMSUJSQVRJT05fSAorI2RlZmluZSBf
QVNNX1g4Nl9WRFNPX1RTQ19DQUxJQlJBVElPTl9ICisvKiAKKyAqIFByb2dyYW1zIHRoYXQgd2Fu
dCB0byB1c2UgcmR0c2MgLyByZHRzY3AgaW5zdHJ1Y3Rpb25zCisgKiBmcm9tIHVzZXItc3BhY2Ug
Y2FuIG1ha2UgdXNlIG9mIHRoZSBMaW51eCBrZXJuZWwgVFNDIGNhbGlicmF0aW9uCisgKiBieSBj
YWxsaW5nIDoKKyAqICAgIF9fdmRzb19saW51eF90c2NfY2FsaWJyYXRpb24odm9pZCk7CisgKiAo
IG9uZSBoYXMgdG8gcmVzb2x2ZSB0aGlzIHN5bWJvbCBhcyBpbiAKKyAqICAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdkRTTy9wYXJzZV92ZHNvLmMKKyAqICkKKyAqIHdoaWNoIHJldHVybnMgYSBw
b2ludGVyIGludG8gdGhlIHJlYWQtb25seQorICogdnZhcl9wYWdlICh0aGUgdnN5c2NhbGxfZ3Rv
ZF9kYXRhIHN0cnVjdHVyZSksCisgKiB3aXRoIHRoZSBmb2xsb3dpbmcgbGF5b3V0IDoKKyAqLwor
CitzdHJ1Y3QgbGludXhfdHNjX2NhbGlicmF0aW9uCit7CisgICAgICAgIHVuc2lnbmVkIGludCBt
dWx0OyAgIC8qIGFtb3VudCB0byBtdWx0aXBseSA2NC1iaXQgVFNDIHZhbHVlIGJ5ICovCisKKyAg
ICAgICAgdW5zaWduZWQgaW50IHNoaWZ0OyAgLyogdGhlIHJpZ2h0IHNoaWZ0IHRvIGFwcGx5IHRv
IChtdWx0KlRTQykgeWllbGRpbmcgbmFub3NlY29uZHMgKi8gCit9OworCisvKiBUbyB1c2U6Cisg
KgorICogIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbG54X3RzY19jYWxpYnJhdGlvbl9zKgorICogICgq
bGludXhfdHNjX2NhbCkodm9pZCkgPSB2ZHNvX3N5bSgiTElOVVhfMi42IiwgIl9fdmRzb19saW51
eF90c2NfY2FsaWJyYXRpb24iKTsKKyAqICBpZiggbGludXhfdHNjX2NhbCA9PSAwVUwgKQorICog
IHsgZnByaW50ZihzdGRlcnIsInRoZSBwYXRjaCBwcm92aWRpbmcgX192ZHNvX2xpbnV4X3RzY19j
YWxpYnJhdGlvbiBpcyBub3QgYXBwbGllZCB0byB0aGUga2VybmVsLlxuIik7CisgKiAgICByZXR1
cm4gRVJST1I7CisgKiAgfQorICogIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbG54X3RzY19jYWxpYnJh
dGlvbl9zICpjbG9ja19zb3VyY2UgPSAoKmxpbnV4X3RzY19jYWwpKCk7CisgKiAgaWYoIGNsb2Nr
X3NvdXJjZSA9PSAoKHZvaWQqKTBVTCkpCisgKiAgICBmcHJpbnRmKHN0ZGVyciwiVFNDIGlzIG5v
dCB0aGUgc3lzdGVtIGNsb2Nrc291cmNlLlxuIik7CisgKiAgdm9sYXRpbGUgdW5zaWduZWQgaW50
IHRzY19sbywgdHNjX2hpLCB0c2NfY3B1OworICogIGFzbSB2b2xhdGlsZQorICogICggInJkdHNj
cCIgOiAoPWEpIHRzY19oaSwgICg9ZCkgdHNjX2xvLCAoPWMpIHRzY19jcHUgKTsKKyAqICB1bnNp
Z25lZCBsb25nIHRzYyA9ICgoKHVuc2lnbmVkIGxvbmcpdHNjX2hpKSA8PCAzMikgfCB0c2NfbG87
CisgKiAgdW5zaWduZWQgbG9uZyBuYW5vc2Vjb25kcyA9CisgKiAgICgoIGNsb2NrX3NvdXJjZSAt
PiBtdWx0ICkgKiB0c2MgKSA+PiAoY2xvY2tfc291cmNlIC0+IHNoaWZ0KTsKKyAqICAKKyAqICBu
YW5vc2Vjb25kcyBpcyBub3cgVFNDIHZhbHVlIGNvbnZlcnRlZCB0byBuYW5vc2Vjb25kcywgCisg
KiAgYWNjb3JkaW5nIHRvIExpbnV4JyBjbG9ja3NvdXJjZSBjYWxpYnJhdGlvbiB2YWx1ZXMuIAor
ICogIAorICovCisKKyNlbmRpZgo=
--001a1147357674ae060566c7320b--
