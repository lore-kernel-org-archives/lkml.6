Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeDRJtg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:49:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33341 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeDRJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:49:34 -0400
X-Google-Smtp-Source: AIpwx4+S/EUrJ8ganmQqIu4d0VjFYoTjOO0AwzQBZdmHjn/AjhwvnBxi74jkTbRLsRZP32xUIuOltQ==
Date: Wed, 18 Apr 2018 17:49:09 +0800
From: Wang YanQing <udknight@gmail.com>
To: daniel@iogearbox.net, ast@kernel.org, illusionist.neo@gmail.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net
Subject: Re: [PATCH] bpf, x86_32: add eBPF JIT compiler for ia32 (x86_32)
Message-ID: <20180418094909.GA4993@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, daniel@iogearbox.net,
        ast@kernel.org, illusionist.neo@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
References: <20180418093118.GA4184@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418093118.GA4184@udknight>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 05:31:18PM +0800, Wang YanQing wrote:
> The JIT compiler emits ia32 bit instructions. Currently, It supports
> eBPF only. Classic BPF is supported because of the conversion by BPF core.
> 
> Almost all instructions from eBPF ISA supported except the following:
> BPF_ALU64 | BPF_DIV | BPF_K
> BPF_ALU64 | BPF_DIV | BPF_X
> BPF_ALU64 | BPF_MOD | BPF_K
> BPF_ALU64 | BPF_MOD | BPF_X
> BPF_STX | BPF_XADD | BPF_W
> BPF_STX | BPF_XADD | BPF_DW
> 
> It doesn't support BPF_JMP|BPF_CALL with BPF_PSEUDO_CALL too.
> 
> IA32 has few general purpose registers, EAX|EDX|ECX|EBX|ESI|EDI,
> and for these six registers, we can't treat all of them as real
> general purpose registers:
> MUL instructions need EAX:EDX, shift instructions need ECX, ESI|EDI
> for string manipulation instructions.
> 
> So I decide to use stack to emulate all eBPF 64 registers, this will
> simplify the implementation very much, because we don't need to face
> the flexible memory address modes on ia32, for example, we don't need
> to write below codes for one BPF_ADD instruction:
> if (src_reg is a register && dst_reg is a register)
> {
>    //one instruction encoding for ADD instruction
> } else if (only src is a register)
> {
>    //another different instruction encoding for ADD instruction
> } else if (only dst is a register)
> {
>    //another different instruction encoding for ADD instruction
> } else
> {
>    //src and dst are all on stack.
>    //another different instruction encoding for ADD instruction
> }
> 
> If you think above if-else-else-else isn't so painful, try to think
> it for BPF_ALU64|BPF_*SHIFT* instruction:)
> 
> Tested on my PC(Intel(R) Core(TM) i5-5200U CPU) and virtualbox.
> 
> Testing results on i5-5200U:
> 
> 1) test_bpf: Summary: 349 PASSED, 0 FAILED, [319/341 JIT'ed]
> 2) test_progs: Summary: 81 PASSED, 2 FAILED.
>    test_progs report "libbpf: incorrect bpf_call opcode" for
>    test_l4lb_noinline and test_xdp_noinline, because there is
>    no llvm-6.0 on my machine, and current implementation doesn't
>    support BPF_CALL, so I think we can ignore it.
> 3) test_lpm: OK
> 4) test_lru_map: OK
> 5) test_verifier: Summary: 823 PASSED, 5 FAILED
>    test_verifier report "invalid bpf_context access off=68 size=1/2/4/8"
>    for all the 5 FAILED testcases, and test_verifier report them when
>    we turn off the jit, so I think the jit can do nothing to fix them.
> 
> Above tests are all done with following flags enabled discretely:
> bpf_jit_enable=1 and bpf_jit_harden=2
> 
> Below are some numbers for this jit implementation:
> Note:
>   I run test_progs 100 times in loop for every testcase, the numbers
>   are in format: total/times=avg. The numbers that test_bpf report
>   almost show the same relation.
> 
> a:jit_enable=0 and jit_harden=0            b:jit_enable=1 and jit_harden=0
>   test_pkt_access:PASS:ipv4:15622/100=156  test_pkt_access:PASS:ipv4:10057/100=100
>   test_pkt_access:PASS:ipv6:9130/100=91    test_pkt_access:PASS:ipv6:5055/100=50
>   test_xdp:PASS:ipv4:240198/100=2401       test_xdp:PASS:ipv4:145945/100=1459
>   test_xdp:PASS:ipv6:137326/100=1373       test_xdp:PASS:ipv6:67337/100=673
>   test_l4lb:PASS:ipv4:61100/100=611        test_l4lb:PASS:ipv4:38137/100=381
>   test_l4lb:PASS:ipv6:101000/100=1010      test_l4lb:PASS:ipv6:57779/100=577
> 
> c:jit_enable=0 and jit_harden=2            b:jit_enable=1 and jit_harden=2
>   test_pkt_access:PASS:ipv4:15214/100=152  test_pkt_access:PASS:ipv4:12650/100=126
>   test_pkt_access:PASS:ipv6:9132/100=91    test_pkt_access:PASS:ipv6:7074/100=70
>   test_xdp:PASS:ipv4:237252/100=2372       test_xdp:PASS:ipv4:147211/100=1472
>   test_xdp:PASS:ipv6:135977/100=1359       test_xdp:PASS:ipv6:85783/100=857
>   test_l4lb:PASS:ipv4:61324/100=613        test_l4lb:PASS:ipv4:53222/100=532
>   test_l4lb:PASS:ipv6:100833/100=1008      test_l4lb:PASS:ipv6:76322/100=763
> 
> Yes, the numbers are pretty without turn on jit_harden, if we want to speedup
> jit_harden, then we need to move BPF_REG_AX to *real* register instead of stack
> emulation, but If we do it, we need to face all the pain I describe above. We
> can do it in next step.
> 
> See Documentation/networking/filter.txt for more information.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  arch/x86/Kconfig                     |    2 +-
>  arch/x86/include/asm/nospec-branch.h |   26 +-
>  arch/x86/net/Makefile                |   10 +-
>  arch/x86/net/bpf_jit32.S             |  147 +++
>  arch/x86/net/bpf_jit_comp32.c        | 2239 ++++++++++++++++++++++++++++++++++
>  5 files changed, 2419 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/net/bpf_jit32.S
>  create mode 100644 arch/x86/net/bpf_jit_comp32.c
Add CC to davem@davemloft.net
