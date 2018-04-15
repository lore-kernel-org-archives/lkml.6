Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeDOE1r (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 00:27:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750704AbeDOE1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 00:27:46 -0400
Smtp-Origin-Hostprefix: devbig
From: Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig474.prn1.facebook.com
To: <peterz@infradead.org>, <mingo@kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC: <kernel-team@fb.com>
Smtp-Origin-Cluster: prn1c29
Subject: [PATCH v2] x86/cpufeature: guard asm_volatile_goto usage with NO_BPF_WORKAROUND
Date: Sat, 14 Apr 2018 21:27:38 -0700
Message-ID: <20180415042738.1788215-1-yhs@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-14_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
removed X86_FAST_FEATURE_TESTS and make macro static_cpu_has() always
use __always_inline function _static_cpu_has() funciton.
The static_cpu_has() uses gcc feature asm_volatile_goto construct,
which is not supported by clang.

Currently, for BPF programs written in C, the only widely-supported
compiler is clang. Because of clang lacking support
of asm_volatile_goto construct, if you try to compile
bpf programs under samples/bpf/,
   $ make -j20 && make headers_install && make samples/bpf/
you will see a lot of failures like below:

  =========================
  clang  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include \
         -I/home/yhs/work/bpf-next/arch/x86/include \
         -I./arch/x86/include/generated  -I/home/yhs/work/bpf-next/include \
         -I./include -I/home/yhs/work/bpf-next/arch/x86/include/uapi \
         -I./arch/x86/include/generated/uapi \
         -I/home/yhs/work/bpf-next/include/uapi -I./include/generated/uapi \
         -include /home/yhs/work/bpf-next/include/linux/kconfig.h
         -Isamples/bpf \
	 -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/ \
	 -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
	 -D__TARGET_ARCH_x86 -Wno-compare-distinct-pointer-types \
	 -Wno-gnu-variable-sized-type-not-at-end \
	 -Wno-address-of-packed-member -Wno-tautological-compare \
	 -Wno-unknown-warning-option  \
	 -O2 -emit-llvm -c /home/yhs/work/bpf-next/samples/bpf/xdp_redirect_cpu_kern.c \
         -o -| llc -march=bpf -filetype=obj -o samples/bpf/xdp_redirect_cpu_kern.o
  In file included from /home/yhs/work/bpf-next/samples/bpf/xdp_redirect_cpu_kern.c:10:
  In file included from /home/yhs/work/bpf-next/include/uapi/linux/in.h:24:
  In file included from /home/yhs/work/bpf-next/include/linux/socket.h:8:
  In file included from /home/yhs/work/bpf-next/include/linux/uio.h:13:
  In file included from /home/yhs/work/bpf-next/include/linux/thread_info.h:38:
  In file included from /home/yhs/work/bpf-next/arch/x86/include/asm/thread_info.h:53:
  /home/yhs/work/bpf-next/arch/x86/include/asm/cpufeature.h:150:2: error: 'asm goto' constructs are not supported yet
        asm_volatile_goto("1: jmp 6f\n"
        ^
  /home/yhs/work/bpf-next/include/linux/compiler-gcc.h:296:42: note: expanded from macro 'asm_volatile_goto'
  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                           ^
  1 error generated.
  =========================
  ...
  In file included from /home/yhs/work/bpf-next/samples/bpf/tracex4_kern.c:7:
  In file included from /home/yhs/work/bpf-next/include/linux/ptrace.h:6:
  In file included from /home/yhs/work/bpf-next/include/linux/sched.h:14:
  In file included from /home/yhs/work/bpf-next/include/linux/pid.h:5:
  In file included from /home/yhs/work/bpf-next/include/linux/rculist.h:11:
  In file included from /home/yhs/work/bpf-next/include/linux/rcupdate.h:40:
  In file included from /home/yhs/work/bpf-next/include/linux/preempt.h:81:
  In file included from /home/yhs/work/bpf-next/arch/x86/include/asm/preempt.h:7:
  In file included from /home/yhs/work/bpf-next/include/linux/thread_info.h:38:
  In file included from /home/yhs/work/bpf-next/arch/x86/include/asm/thread_info.h:53:
  /home/yhs/work/bpf-next/arch/x86/include/asm/cpufeature.h:150:2: error: 'asm goto' constructs are not supported yet
  ...
  =========================

This patch adds a preprocessor guard NO_BPF_WORKAROUND around the
asm_volatile_goto based static_cpu_has(). NO_BPF_WORKAROUND is set
at toplevel Makefile when compiler supports asm-goto. That is,
if the compiler supports asm-goto, the kernel build will use
asm-goto version of static_cpu_has().

For clang compilation for bpf programs where only header files
are accessed, NO_BPF_WORKAROUND is not defined and asm-goto version
of static_cpu_has() will not be accessed, hence the above compilation
error will disappear.

If later clang compiler starts to support asm_volatile_goto,
the change in this patch can be reverted.

Fixes: d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Makefile                          | 1 +
 arch/x86/include/asm/cpufeature.h | 5 +++++
 2 files changed, 6 insertions(+)

Changelog:
 v1 -> v2:
   Use NO_BPF_WORKAROUND macro instead of CC_HAVE_ASM_GOTO
   to make it explicit that this is a workaround.

diff --git a/Makefile b/Makefile
index c1a608a..7b81f1f 100644
--- a/Makefile
+++ b/Makefile
@@ -504,6 +504,7 @@ export RETPOLINE_CFLAGS
 ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
   CC_HAVE_ASM_GOTO := 1
   KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+  KBUILD_CFLAGS += -DNO_BPF_WORKAROUND
   KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
 endif
 
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index b27da96..638417b 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,6 +140,8 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
+/* this macro is a temporary hack for bpf until clang gains asm-goto support */
+#ifdef NO_BPF_WORKAROUND
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -195,6 +197,9 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
 		boot_cpu_has(bit) :				\
 		_static_cpu_has(bit)				\
 )
+#else
+#define static_cpu_has(bit)		boot_cpu_has(bit)
+#endif
 
 #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
 #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
-- 
2.9.5
