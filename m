Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935384AbeEJKtf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:49:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935279AbeEJKtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:49:31 -0400
Date: Thu, 10 May 2018 12:49:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yonghong Song <yhs@fb.com>
Cc: peterz@infradead.org, mingo@kernel.org, torvalds@linux-foundation.org,
        ast@fb.com, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        x86@kernel.org, netdev@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
Message-ID: <20180510104908.GA16130@pd.tnic>
References: <20180504033119.2130788-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504033119.2130788-1-yhs@fb.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:31:19PM -0700, Yonghong Song wrote:
> Commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
> removed X86_FAST_FEATURE_TESTS and make macro static_cpu_has() always
> use __always_inline function _static_cpu_has() funciton.
> The static_cpu_has() uses gcc feature asm goto construct,
> which is not supported by clang.
> 
> Issues
> ======
> 
> Currently, for BPF programs written in C, the only widely-supported
> compiler is clang. Because of clang lacking support
> of asm goto construct, if you try to compile
> bpf programs under samples/bpf/,
>    $ make -j20 && make headers_install && make samples/bpf/
> you will see a lot of failures like below:
> 
>   clang  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include \
>          -I/home/yhs/work/bpf-next/arch/x86/include \
>          -I./arch/x86/include/generated  -I/home/yhs/work/bpf-next/include \
>          -I./include -I/home/yhs/work/bpf-next/arch/x86/include/uapi \
>          -I./arch/x86/include/generated/uapi \
>          -I/home/yhs/work/bpf-next/include/uapi -I./include/generated/uapi \
>          -include /home/yhs/work/bpf-next/include/linux/kconfig.h
>          -Isamples/bpf \
> 	 -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/ \
> 	 -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
> 	 -D__TARGET_ARCH_x86 -Wno-compare-distinct-pointer-types \
> 	 -Wno-gnu-variable-sized-type-not-at-end \
> 	 -Wno-address-of-packed-member -Wno-tautological-compare \
> 	 -Wno-unknown-warning-option  \
> 	 -O2 -emit-llvm -c /home/yhs/work/bpf-next/samples/bpf/xdp_redirect_cpu_kern.c \
>          -o -| llc -march=bpf -filetype=obj -o samples/bpf/xdp_redirect_cpu_kern.o
>   In file included from /home/yhs/work/bpf-next/samples/bpf/xdp_redirect_cpu_kern.c:10:

This is not the kernel's problem.

Fix the samples to build successfully like the rest of the things in
tools/ use kernel machinery and undefine/redefine stuff so that it
builds. For example, tools/include/asm/alternative-asm.h redefines two
macros. So do something along those lines.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
