Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeDZBnT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:43:19 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45147 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeDZBnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:43:15 -0400
X-Google-Smtp-Source: AB8JxZp1zh8ozVmLTkrttHQZE+0MIjehHpxLUZ5NCphnkqVq+Ue/R1iNq83HNrDiw/O0/4U0xGpTFQ==
Date: Thu, 26 Apr 2018 09:43:13 +0800
From: Wang YanQing <udknight@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, illusionist.neo@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, davem@davemloft.net, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bpf, x86_32: add eBPF JIT compiler for ia32
Message-ID: <20180426014313.GA23526@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        illusionist.neo@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, davem@davemloft.net, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180419155420.GA5468@udknight>
 <20e1eabd-e821-8240-cb4c-6da253c49585@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e1eabd-e821-8240-cb4c-6da253c49585@iogearbox.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 02:11:16AM +0200, Daniel Borkmann wrote:
> On 04/19/2018 05:54 PM, Wang YanQing wrote:
> > Testing results on i5-5200U:
> > 
> > 1) test_bpf: Summary: 349 PASSED, 0 FAILED, [319/341 JIT'ed]
> > 2) test_progs: Summary: 81 PASSED, 2 FAILED.
> >    test_progs report "libbpf: incorrect bpf_call opcode" for
> >    test_l4lb_noinline and test_xdp_noinline, because there is
> >    no llvm-6.0 on my machine, and current implementation doesn't
> >    support BPF_PSEUDO_CALL, so I think we can ignore the two failed
> >    testcases.
> > 3) test_lpm: OK
> > 4) test_lru_map: OK
> > 5) test_verifier: Summary: 823 PASSED, 5 FAILED
> >    test_verifier report "invalid bpf_context access off=68 size=1/2/4/8"
> >    for all the 5 FAILED testcases with/without jit, we need to fix the
> >    failed testcases themself instead of this jit.
> 
> Can you elaborate further on these? Looks like this definitely needs
> fixing on 32 bit. Would be great to get a better understanding of the
> underlying bug(s) and properly fix them.
> 
Hi Daniel Borkmann, here is the detailed log for failed testcases.

linux: Gentoo 32 bit
llvm:
    ~ # llc  --version
    LLVM (http://llvm.org/):
    LLVM version 4.0.1
    Optimized build.
    Default target: i686-pc-linux-gnu
    Host CPU: broadwell
    
    Registered Targets:
    amdgcn  - AMD GCN GPUs
    bpf     - BPF (host endian)
    bpfeb   - BPF (big endian)
    bpfel   - BPF (little endian)
    nvptx   - NVIDIA PTX 32-bit
    nvptx64 - NVIDIA PTX 64-bit
    r600    - AMD GPUs HD2XXX-HD6XXX
    x86     - 32-bit X86: Pentium-Pro and above
    x86-64  - 64-bit X86: EM64T and AMD64
    
    ~ # clang --version
    clang version 4.0.1 (tags/RELEASE_401/final)
    Target: i686-pc-linux-gnu
    Thread model: posix
    InstalledDir: /usr/lib/llvm/4/bin

kernel version:4.16.2
test program:test_verifier in kselftest
condition:bpf_jit_enable=0,bpf_jit_harden=0

log:
#172/p unpriv: spill/fill of different pointers ldx FAIL
Unexpected error message!
0: (bf) r6 = r10
1: (07) r6 += -8
2: (15) if r1 == 0x0 goto pc+3
R1=ctx(id=0,off=0,imm=0) R6=fp-8,call_-1 R10=fp0,call_-1
3: (bf) r2 = r10
4: (07) r2 += -76
5: (7b) *(u64 *)(r6 +0) = r2
6: (55) if r1 != 0x0 goto pc+1
R1=ctx(id=0,off=0,imm=0) R2=fp-76,call_-1 R6=fp-8,call_-1 R10=fp0,call_-1 fp-8=fp
7: (7b) *(u64 *)(r6 +0) = r1
8: (79) r1 = *(u64 *)(r6 +0)
9: (79) r1 = *(u64 *)(r1 +68)
invalid bpf_context access off=68 size=8

#378/p check bpf_perf_event_data->sample_period byte load permitted FAIL
Failed to load prog 'Permission denied'!
0: (b7) r0 = 0
1: (71) r0 = *(u8 *)(r1 +68)
invalid bpf_context access off=68 size=1
#379/p check bpf_perf_event_data->sample_period half load permitted FAIL
Failed to load prog 'Permission denied'!
0: (b7) r0 = 0
1: (69) r0 = *(u16 *)(r1 +68)
invalid bpf_context access off=68 size=2
#380/p check bpf_perf_event_data->sample_period word load permitted FAIL
Failed to load prog 'Permission denied'!
0: (b7) r0 = 0
1: (61) r0 = *(u32 *)(r1 +68)
invalid bpf_context access off=68 size=4
#381/p check bpf_perf_event_data->sample_period dword load permitted FAIL
Failed to load prog 'Permission denied'!
0: (b7) r0 = 0
1: (79) r0 = *(u64 *)(r1 +68)
invalid bpf_context access off=68 size=8


test program:test_progs
condition:bpf_jit_enable=0,bpf_jit_harden=0

bpf # ./test_progs
test_pkt_access:PASS:ipv4 53 nsec
test_pkt_access:PASS:ipv6 47 nsec
test_xdp:PASS:ipv4 1281 nsec
test_xdp:PASS:ipv6 749 nsec
test_l4lb:PASS:ipv4 427 nsec
test_l4lb:PASS:ipv6 562 nsec
libbpf: incorrect bpf_call opcode <= caused by ./test_l4lb_noinline.o in function test_l4lb_all 
libbpf: incorrect bpf_call opcode <= caused by ././test_xdp_noinline.o in function test_xdp_noinline


Thanks.
