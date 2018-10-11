Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1521EC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FFA2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mybar7+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FFA2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeJKWw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:52:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeJKWw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zDQDVCi8Di9JQkzbI0uxB8wEC2JCUaCCLu4pZ4L5JXI=; b=mybar7+HMlohojNxTWywb7mIp
        0lZr79TmJYkZY+jT8CNs18bs5xftAkGXbyWWeh+6ZQiOUJVAVDh3gG+NBKnVHz64vLRu0VY8AAuVf
        aUNT3FZ+SGu4yWN5svsNGG4o2yf05IlycILDQKfjaj+HofxC1cCBlEn5EOiIpc4QqiJV238QtBtVe
        J8BraONSlKPzmiKiXJgXcOssZOJXzvasq4r5nXAIp8LYy9d9d+s6Edm/ySaZN9PqnB/V9kRyQqH5f
        Lwbsab2GfaO99wUBQq9n/WvxIaH4MjyW3lHyO4DiB6LaBDjo02TMfuDrANP4OOPKMDgRFTspHBhwp
        Ar37ceE3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAcpM-0008VT-OO; Thu, 11 Oct 2018 15:24:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E7122027E199; Thu, 11 Oct 2018 17:24:38 +0200 (CEST)
Date:   Thu, 11 Oct 2018 17:24:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/tsc: use real seqcount_latch in cyc2ns_read_begin()
Message-ID: <20181011152438.GM9848@hirez.programming.kicks-ass.net>
References: <20181011003336.168941-1-edumazet@google.com>
 <20181011073133.GZ5663@hirez.programming.kicks-ass.net>
 <20181011084047.GA9885@hirez.programming.kicks-ass.net>
 <CANn89iJdztFEMzeCoXu9J4X6roKKx+fuPkwzi9N9G7aiO=_=FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJdztFEMzeCoXu9J4X6roKKx+fuPkwzi9N9G7aiO=_=FQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:00:42AM -0700, Eric Dumazet wrote:
> Yes, but the code size is bigger (I have looked at the disassembly)
> 
> All these %gs plus offset add up

> Total length : 0xA7 bytes

effective length: 0x78 bytes

> 00000000000002a0 <native_sched_clock>:
>      2a0: 4c 8d 54 24 08        lea    0x8(%rsp),%r10
>      2a5: 48 83 e4 f0          and    $0xfffffffffffffff0,%rsp
>      2a9: 41 ff 72 f8          pushq  -0x8(%r10)
>      2ad: 55                    push   %rbp
>      2ae: 48 89 e5              mov    %rsp,%rbp
>      2b1: 41 52                push   %r10

       2b3: 66 66 66 66 90	k8_nop5_atomic

>      2b8: 0f 31                rdtsc
>      2ba: 48 c1 e2 20          shl    $0x20,%rdx
>      2be: 48 09 c2              or     %rax,%rdx
>      2c1: 49 89 d2              mov    %rdx,%r10
>      2c4: 49 c7 c1 00 00 00 00 mov    $0x0,%r9
> 		2c7: R_X86_64_32S .data..percpu..shared_aligned
>      2cb: 65 8b 05 00 00 00 00 mov    %gs:0x0(%rip),%eax        # 2d2
> <native_sched_clock+0x32>
> 		2ce: R_X86_64_PC32 .data..percpu..shared_aligned+0x1c
>      2d2: 89 c1                mov    %eax,%ecx
>      2d4: 83 e1 01              and    $0x1,%ecx
>      2d7: 48 c1 e1 04          shl    $0x4,%rcx
>      2db: 4c 01 c9              add    %r9,%rcx
>      2de: 65 48 8b 79 08        mov    %gs:0x8(%rcx),%rdi
>      2e3: 65 8b 31              mov    %gs:(%rcx),%esi
>      2e6: 65 8b 49 04          mov    %gs:0x4(%rcx),%ecx
>      2ea: 65 44 8b 05 00 00 00 mov    %gs:0x0(%rip),%r8d        # 2f2
> <native_sched_clock+0x52>
>      2f1: 00
> 		2ee: R_X86_64_PC32 .data..percpu..shared_aligned+0x1c
>      2f2: 44 39 c0              cmp    %r8d,%eax
>      2f5: 75 d4                jne    2cb <native_sched_clock+0x2b>
>      2f7: 89 f6                mov    %esi,%esi
>      2f9: 48 89 f0              mov    %rsi,%rax
>      2fc: 49 f7 e2              mul    %r10
>      2ff: 48 0f ad d0          shrd   %cl,%rdx,%rax
>      303: 48 d3 ea              shr    %cl,%rdx
>      306: f6 c1 40              test   $0x40,%cl
>      309: 48 0f 45 c2          cmovne %rdx,%rax
>      30d: 48 01 f8              add    %rdi,%rax
>      310: 41 5a                pop    %r10
>      312: 5d                    pop    %rbp
>      313: 49 8d 62 f8          lea    -0x8(%r10),%rsp
>      317: c3                    retq
> 
> New version :
> 
> Total length = 0x91 bytes

effective: 0x71

> 
> 00000000000002a0 <native_sched_clock>:
>      2a0: 4c 8d 54 24 08        lea    0x8(%rsp),%r10
>      2a5: 48 83 e4 f0          and    $0xfffffffffffffff0,%rsp
>      2a9: 41 ff 72 f8          pushq  -0x8(%r10)
>      2ad: 55                    push   %rbp
>      2ae: 48 89 e5              mov    %rsp,%rbp
>      2b1: 41 52                push   %r10

       2b3: 66 66 66 66 90	k8_nop5_atomic

>      2b8: 0f 31                rdtsc
>      2ba: 48 c1 e2 20          shl    $0x20,%rdx
>      2be: 48 09 c2              or     %rax,%rdx
>      2c1: 49 89 d1              mov    %rdx,%r9
>      2c4: 49 c7 c0 00 00 00 00 mov    $0x0,%r8
>		2c7: R_X86_64_32S .data..percpu..shared_aligned
>      2cb: 65 4c 03 05 00 00 00 add    %gs:0x0(%rip),%r8        # 2d3
> <native_sched_clock+0x33>
>      2d2: 00
>		2cf: R_X86_64_PC32 this_cpu_off-0x4
>      2d3: 41 8b 40 20          mov    0x20(%r8),%eax
>      2d7: 89 c6                mov    %eax,%esi
>      2d9: 83 e6 01              and    $0x1,%esi
>      2dc: 48 c1 e6 04          shl    $0x4,%rsi
>      2e0: 4c 01 c6              add    %r8,%rsi
>      2e3: 8b 3e                mov    (%rsi),%edi
>      2e5: 8b 4e 04              mov    0x4(%rsi),%ecx
>      2e8: 48 8b 76 08          mov    0x8(%rsi),%rsi
>      2ec: 41 3b 40 20          cmp    0x20(%r8),%eax
>      2f0: 75 e1                jne    2d3 <native_sched_clock+0x33>
>      2f2: 48 89 f8              mov    %rdi,%rax
>      2f5: 49 f7 e1              mul    %r9
>      2f8: 48 0f ad d0          shrd   %cl,%rdx,%rax
>      2fc: 48 d3 ea              shr    %cl,%rdx
>      2ff: f6 c1 40              test   $0x40,%cl
>      302: 48 0f 45 c2          cmovne %rdx,%rax
>      306: 48 01 f0              add    %rsi,%rax
>      309: 41 5a                pop    %r10
>      30b: 5d                    pop    %rbp
>      30c: 49 8d 62 f8          lea    -0x8(%r10),%rsp
>      310: c3                    retq

Ah, right you are. But my version only touches the one cacheline,
whereas yours will do that extra cpu offset load, which might or might
not be hot.

Difficult..

You have some weird stack setup though.. mine doesn't have that:

$ objdump -dr defconfig-build/arch/x86/kernel/tsc.o | awk '/<native_sched_clock>:$/ {p=1} /^$/ {p=0} {if (p) print $0}'
0000000000000b00 <native_sched_clock>:
b00:   55                      push   %rbp
b01:   48 89 e5                mov    %rsp,%rbp
b04:   66 66 66 66 90          k8_nop5_atomic
b09:   0f 31                   rdtsc
b0b:   48 c1 e2 20             shl    $0x20,%rdx
b0f:   48 09 c2                or     %rax,%rdx
b12:   49 89 d2                mov    %rdx,%r10
b15:   49 c7 c1 00 00 00 00    mov    $0x0,%r9
		b18: R_X86_64_32S       .data..percpu..shared_aligned
b1c:   65 8b 05 00 00 00 00    mov    %gs:0x0(%rip),%eax        # b23 <native_sched_clock+0x23>
		b1f: R_X86_64_PC32      .data..percpu..shared_aligned+0x1c
b23:   89 c1                   mov    %eax,%ecx
b25:   83 e1 01                and    $0x1,%ecx
b28:   48 c1 e1 04             shl    $0x4,%rcx
b2c:   4c 01 c9                add    %r9,%rcx
b2f:   65 48 8b 79 08          mov    %gs:0x8(%rcx),%rdi
b34:   65 8b 31                mov    %gs:(%rcx),%esi
b37:   65 8b 49 04             mov    %gs:0x4(%rcx),%ecx
b3b:   65 44 8b 05 00 00 00    mov    %gs:0x0(%rip),%r8d        # b43 <native_sched_clock+0x43>
b42:   00
		b3f: R_X86_64_PC32      .data..percpu..shared_aligned+0x1c
b43:   44 39 c0                cmp    %r8d,%eax
b46:   75 d4                   jne    b1c <native_sched_clock+0x1c>
b48:   89 f6                   mov    %esi,%esi
b4a:   48 89 f0                mov    %rsi,%rax
b4d:   49 f7 e2                mul    %r10
b50:   48 0f ad d0             shrd   %cl,%rdx,%rax
b54:   48 d3 ea                shr    %cl,%rdx
b57:   f6 c1 40                test   $0x40,%cl
b5a:   48 0f 45 c2             cmovne %rdx,%rax
b5e:   48 01 f8                add    %rdi,%rax
b61:   5d                      pop    %rbp
b62:   c3                      retq

Which gets me to 0x62 effective bytes.



