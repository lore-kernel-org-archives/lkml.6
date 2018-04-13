Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbeDMNWn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:22:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754094AbeDMNWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:22:41 -0400
Date: Fri, 13 Apr 2018 15:22:37 +0200
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: brouer@redhat.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Subject: Build error for samples/bpf/ due to commit d0266046ad54 ("x86:
 Remove FAST_FEATURE_TESTS")
Message-ID: <20180413152237.3727911f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Your commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS") broke build
for several samples/bpf programs. I'm unsure what the best way forward
is to unbreak these...

The issue is that these samples are build with LLVM/clang (which
doesn't like 'asm goto' constructs).  And they end up including
arch/x86/include/asm/cpufeature.h via a long include path, see build
examples below (through different path to include/linux/thread_info.h).

Maybe Alexei or Daniel have an idea how to work around this?
As tools/testing/selftests/bpf/ does not seem to fail!?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

Build error#1:
--------------
clang  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h  -Isamples/bpf \
        -I./tools/testing/selftests/bpf/ \
        -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
        -D__TARGET_ARCH_x86 -Wno-compare-distinct-pointer-types \
        -Wno-gnu-variable-sized-type-not-at-end \
        -Wno-address-of-packed-member -Wno-tautological-compare \
        -Wno-unknown-warning-option  \
        -O2 -emit-llvm -c samples/bpf/sockex2_kern.c -o -| llc -march=bpf -filetype=obj -o samples/bpf/sockex2_kern.o
In file included from samples/bpf/sockex2_kern.c:3:
In file included from ./include/uapi/linux/in.h:24:
In file included from ./include/linux/socket.h:8:
In file included from ./include/linux/uio.h:13:
In file included from ./include/linux/thread_info.h:38:
In file included from ./arch/x86/include/asm/thread_info.h:53:
./arch/x86/include/asm/cpufeature.h:150:2: error: 'asm goto' constructs are not supported yet
        asm_volatile_goto("1: jmp 6f\n"
        ^
./include/linux/compiler-gcc.h:290:42: note: expanded from macro 'asm_volatile_goto'
#define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                         ^


Build error#2:
--------------
clang  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h  -Isamples/bpf \
        -I./tools/testing/selftests/bpf/ \
        -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
        -D__TARGET_ARCH_x86 -Wno-compare-distinct-pointer-types \
        -Wno-gnu-variable-sized-type-not-at-end \
        -Wno-address-of-packed-member -Wno-tautological-compare \
        -Wno-unknown-warning-option  \
        -O2 -emit-llvm -c samples/bpf/tracex1_kern.c -o -| llc -march=bpf -filetype=obj -o samples/bpf/tracex1_kern.o
In file included from samples/bpf/tracex1_kern.c:7:
In file included from ./include/linux/skbuff.h:19:
In file included from ./include/linux/time.h:6:
In file included from ./include/linux/seqlock.h:36:
In file included from ./include/linux/spinlock.h:51:
In file included from ./include/linux/preempt.h:81:
In file included from ./arch/x86/include/asm/preempt.h:7:
In file included from ./include/linux/thread_info.h:38:
In file included from ./arch/x86/include/asm/thread_info.h:53:
./arch/x86/include/asm/cpufeature.h:150:2: error: 'asm goto' constructs are not supported yet
        asm_volatile_goto("1: jmp 6f\n"
        ^
./include/linux/compiler-gcc.h:290:42: note: expanded from macro 'asm_volatile_goto'
#define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                         ^


Build error#3:
--------------
clang  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86
/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h  -Isamples/bpf \
        -I./tools/testing/selftests/bpf/ \
        -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
        -D__TARGET_ARCH_x86 -Wno-compare-distinct-pointer-types \
        -Wno-gnu-variable-sized-type-not-at-end \
        -Wno-address-of-packed-member -Wno-tautological-compare \
        -Wno-unknown-warning-option  \
        -O2 -emit-llvm -c samples/bpf/xdp1_kern.c -o -| llc -march=bpf -filetype=obj -o samples/bpf/xdp1_kern.o
In file included from samples/bpf/xdp1_kern.c:9:
In file included from ./include/linux/in.h:23:
In file included from ./include/uapi/linux/in.h:24:
In file included from ./include/linux/socket.h:8:
In file included from ./include/linux/uio.h:13:
In file included from ./include/linux/thread_info.h:38:
In file included from ./arch/x86/include/asm/thread_info.h:53:
./arch/x86/include/asm/cpufeature.h:150:2: error: 'asm goto' constructs are not supported yet
        asm_volatile_goto("1: jmp 6f\n"
        ^
./include/linux/compiler-gcc.h:290:42: note: expanded from macro 'asm_volatile_goto'
#define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
