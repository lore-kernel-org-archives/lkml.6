Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeEDDbY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:31:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751236AbeEDDbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:31:22 -0400
Smtp-Origin-Hostprefix: devbig
From: Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig474.prn1.facebook.com
To: <peterz@infradead.org>, <mingo@kernel.org>,
        <torvalds@linux-foundation.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <netdev@vger.kernel.org>
CC: <kernel-team@fb.com>
Smtp-Origin-Cluster: prn1c29
Subject: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting asm goto
Date: Thu, 3 May 2018 20:31:19 -0700
Message-ID: <20180504033119.2130788-1-yhs@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
removed X86_FAST_FEATURE_TESTS and make macro static_cpu_has() always
use __always_inline function _static_cpu_has() funciton.
The static_cpu_has() uses gcc feature asm goto construct,
which is not supported by clang.

Issues
======

Currently, for BPF programs written in C, the only widely-supported
compiler is clang. Because of clang lacking support
of asm goto construct, if you try to compile
bpf programs under samples/bpf/,
   $ make -j20 && make headers_install && make samples/bpf/
you will see a lot of failures like below:

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

In the above, bpf compilation looks like below
  clang -target <native_arch> ... -emit-llvm -c -o - | llc -march=bpf ...
The clang compilation targets the native architecture and generates the LLVM IR bytecode, and
the llc compilation takes the IR bytecode and generates bpf instructions.

If kernel header files accessed by bpf program have asm goto construct, e.g.,
arch/x86/include/asm/cpufeature.h, the "clang -target <native_arch> ..."
compilation will fail as clang does not support asm goto yet.

Solution
=========

The solution proposed in this patch does not need user space change.
When the kernel detects the compiler has asm goto support,
it sets CC_HAVE_ASM_GOTO, the patch added the additional marco definition
__NO_CLANG_BPF_HACK. In arch/x86/include/asm/cpufeature.h, the
asm goto construct is accessed only if __NO_CLANG_BPF_HACK is defined.
This should not impact kernel compilation functionality since
for x86, we have
  ifndef CC_HAVE_ASM_GOTO
    $(error Compiler lacks asm-goto support.)
  endif
So __NO_CLANG_BPF_HACK should be always defined during kernel compilation
targeting x86.

User space code which compiles bpf program does not have
__NO_CLANG_BPF_HACK defined so it will go to alternate path
which avoids asm goto.

This approach is preferred since the already deployed bcc scripts, or
any other bpf applicaitons utilizing LLVM JIT compilation functionality,
will continue work with the new kernel without re-compilation and
re-deployment.

Note that this is a hack in the kernel to workaround bpf compilation issue.
The hack will be removed once clang starts to support asm goto.

Fixes: d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Makefile                          | 1 +
 arch/x86/include/asm/cpufeature.h | 5 +++++
 2 files changed, 6 insertions(+)

Changelog:
 v2 -> v3:
   . Changed macro name from NO_BPF_WORKAROUND to __NO_CLANG_BPF_HACK.
     Explained the solution in more details.
 v1 -> v2:
   . Use NO_BPF_WORKAROUND macro instead of CC_HAVE_ASM_GOTO
     to make it explicit that this is a workaround.

Peter,

Could you take a look at this patch revision and give your opinion?
More and more people hit this issue and have to manually work around it.
It would be good if this can be resolved soon.

Thanks!

diff --git a/Makefile b/Makefile
index 83b6c54..cfd8759 100644
--- a/Makefile
+++ b/Makefile
@@ -504,6 +504,7 @@ export RETPOLINE_CFLAGS
 ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
   CC_HAVE_ASM_GOTO := 1
   KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+  KBUILD_CFLAGS += -D__NO_CLANG_BPF_HACK
   KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
 endif
 
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index b27da96..42edd5d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,6 +140,8 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
+/* this macro is a temporary hack for bpf until clang gains asm-goto support */
+#ifdef __NO_CLANG_BPF_HACK
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
