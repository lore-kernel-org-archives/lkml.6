Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeECQZd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:25:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:58959 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeECQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:25:31 -0400
Subject: Re: [PATCH v6] bpf, x86_32: add eBPF JIT compiler for ia32
To: Wang YanQing <udknight@gmail.com>, ast@kernel.org,
        illusionist.neo@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, davem@davemloft.net, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180503061043.GA4674@udknight>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5c635081-21fb-dcc7-8840-19e122a4920a@iogearbox.net>
Date: Thu, 3 May 2018 18:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180503061043.GA4674@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 08:10 AM, Wang YanQing wrote:
> The JIT compiler emits ia32 bit instructions. Currently, It supports eBPF
> only. Classic BPF is supported because of the conversion by BPF core.
> 
> Almost all instructions from eBPF ISA supported except the following:
> BPF_ALU64 | BPF_DIV | BPF_K
> BPF_ALU64 | BPF_DIV | BPF_X
> BPF_ALU64 | BPF_MOD | BPF_K
> BPF_ALU64 | BPF_MOD | BPF_X
> BPF_STX | BPF_XADD | BPF_W
> BPF_STX | BPF_XADD | BPF_DW
> 
> It doesn't support BPF_JMP|BPF_CALL with BPF_PSEUDO_CALL at the moment.
> 
> IA32 has few general purpose registers, EAX|EDX|ECX|EBX|ESI|EDI. I use
> EAX|EDX|ECX|EBX as temporary registers to simulate instructions in eBPF
> ISA, and allocate ESI|EDI to BPF_REG_AX for constant blinding, all others
> eBPF registers, R0-R10, are simulated through scratch space on stack.
> 
> The reasons behind the hardware registers allocation policy are:
> 1:MUL need EAX:EDX, shift operation need ECX, so they aren't fit
>   for general eBPF 64bit register simulation.
> 2:We need at least 4 registers to simulate most eBPF ISA operations
>   on registers operands instead of on register&memory operands.
> 3:We need to put BPF_REG_AX on hardware registers, or constant blinding
>   will degrade jit performance heavily.
> 
> Tested on PC (Intel(R) Core(TM) i5-5200U CPU).
> Testing results on i5-5200U:
> 1) test_bpf: Summary: 349 PASSED, 0 FAILED, [319/341 JIT'ed]
> 2) test_progs: Summary: 83 PASSED, 0 FAILED.
> 3) test_lpm: OK
> 4) test_lru_map: OK
> 5) test_verifier: Summary: 828 PASSED, 0 FAILED.
> 
> Above tests are all done in following two conditions separately:
> 1:bpf_jit_enable=1 and bpf_jit_harden=0
> 2:bpf_jit_enable=1 and bpf_jit_harden=2
> 
> Below are some numbers for this jit implementation:
> Note:
>   I run test_progs in kselftest 100 times continuously for every condition,
>   the numbers are in format: total/times=avg.
>   The numbers that test_bpf reports show almost the same relation.
> 
> a:jit_enable=0 and jit_harden=0            b:jit_enable=1 and jit_harden=0
>   test_pkt_access:PASS:ipv4:15622/100=156    test_pkt_access:PASS:ipv4:10674/100=106
>   test_pkt_access:PASS:ipv6:9130/100=91      test_pkt_access:PASS:ipv6:4855/100=48
>   test_xdp:PASS:ipv4:240198/100=2401         test_xdp:PASS:ipv4:138912/100=1389
>   test_xdp:PASS:ipv6:137326/100=1373         test_xdp:PASS:ipv6:68542/100=685
>   test_l4lb:PASS:ipv4:61100/100=611          test_l4lb:PASS:ipv4:37302/100=373
>   test_l4lb:PASS:ipv6:101000/100=1010        test_l4lb:PASS:ipv6:55030/100=550
> 
> c:jit_enable=1 and jit_harden=2
>   test_pkt_access:PASS:ipv4:10558/100=105
>   test_pkt_access:PASS:ipv6:5092/100=50
>   test_xdp:PASS:ipv4:131902/100=1319
>   test_xdp:PASS:ipv6:77932/100=779
>   test_l4lb:PASS:ipv4:38924/100=389
>   test_l4lb:PASS:ipv6:57520/100=575
> 
> The numbers show we get 30%~50% improvement.
> 
> See Documentation/networking/filter.txt for more information.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Applied to bpf-next, thanks Wang!
