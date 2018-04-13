Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeDMPH3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:07:29 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:39202 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeDMPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:07:27 -0400
X-Google-Smtp-Source: AIpwx4/ybyHYocA22OjeRSFbUsrhjXrv9OY+okm0LK5u4Dzf7K0JunOgiFvgkQVoPhqZXVGIWsLb/Q==
Date: Fri, 13 Apr 2018 08:07:24 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Subject: Re: Build error for samples/bpf/ due to commit d0266046ad54 ("x86:
 Remove FAST_FEATURE_TESTS")
Message-ID: <20180413150722.33kja5rfgv2a4cpr@ast-mbp>
References: <20180413152237.3727911f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413152237.3727911f@redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 03:22:37PM +0200, Jesper Dangaard Brouer wrote:
> Hi Peter,
> 
> Your commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS") broke build
> for several samples/bpf programs. I'm unsure what the best way forward
> is to unbreak these...
> 
> The issue is that these samples are build with LLVM/clang (which
> doesn't like 'asm goto' constructs).  And they end up including
> arch/x86/include/asm/cpufeature.h via a long include path, see build
> examples below (through different path to include/linux/thread_info.h).
> 
> Maybe Alexei or Daniel have an idea how to work around this?
> As tools/testing/selftests/bpf/ does not seem to fail!?

Right. All of bpf tracing and samples/bpf/ broke.
Here is the proposed fix that we're asking Peter to apply and send to Linus asap.
https://lkml.org/lkml/2018/4/10/825

> Build error#1:
> --------------
> clang  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h  -Isamples/bpf \
>         -I./tools/testing/selftests/bpf/ \
>         -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
>         -D__TARGET_ARCH_x86 -Wno-compare-distinct-pointer-types \
>         -Wno-gnu-variable-sized-type-not-at-end \
>         -Wno-address-of-packed-member -Wno-tautological-compare \
>         -Wno-unknown-warning-option  \
>         -O2 -emit-llvm -c samples/bpf/sockex2_kern.c -o -| llc -march=bpf -filetype=obj -o samples/bpf/sockex2_kern.o
> In file included from samples/bpf/sockex2_kern.c:3:
> In file included from ./include/uapi/linux/in.h:24:
> In file included from ./include/linux/socket.h:8:
> In file included from ./include/linux/uio.h:13:
> In file included from ./include/linux/thread_info.h:38:
> In file included from ./arch/x86/include/asm/thread_info.h:53:
> ./arch/x86/include/asm/cpufeature.h:150:2: error: 'asm goto' constructs are not supported yet
>         asm_volatile_goto("1: jmp 6f\n"
>         ^
> ./include/linux/compiler-gcc.h:290:42: note: expanded from macro 'asm_volatile_goto'
> #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
