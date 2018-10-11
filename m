Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A28CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1D92087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TrMEW3/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1D92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeJKQHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:07:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeJKQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g6j3VeIq8Dup12gH7zEipE5cMK85F1IGDFIIuCiFysc=; b=TrMEW3/9i69nodwHaJ0FyPCnh
        ny0/NosV917OR9169aHWI74YoJxLNu5XtPF2K5omlbsnpQdf1H+AKAfHcD5xzMOwnUUxq7sxpqgET
        w6DFiH+pRxVCRuZI5BnWfTKUJ2Md0x5ESfa1geXk1PbwxGHfUbXk6X9suJooNn6wmWb+H6o01aoSj
        0Mj8rHUN0NbhgYUdkZqUuQlB+CtW1WWK1dHsqjXLFV+58sLuhgowMElb9LlJvEhA3NqXlRQLopToC
        jwN7Sv2sBB1PEKX4jr8RP8hUFpEbAlR+qEvkUzB1C4zJ/k0KwaB0M5nuoBQORMNMb/4kFr1fNTnzC
        TOsKATweA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAWWY-0006Do-Oj; Thu, 11 Oct 2018 08:40:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 050972027E187; Thu, 11 Oct 2018 10:40:48 +0200 (CEST)
Date:   Thu, 11 Oct 2018 10:40:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/tsc: use real seqcount_latch in cyc2ns_read_begin()
Message-ID: <20181011084047.GA9885@hirez.programming.kicks-ass.net>
References: <20181011003336.168941-1-edumazet@google.com>
 <20181011073133.GZ5663@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011073133.GZ5663@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 09:31:33AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 10, 2018 at 05:33:36PM -0700, Eric Dumazet wrote:
> > While looking at native_sched_clock() disassembly I had
> > the surprise to see the compiler (gcc 7.3 here) had
> > optimized out the loop, meaning the code is broken.
> > 
> > Using the documented and approved API not only fixes the bug,
> > it also makes the code more readable.
> > 
> > Replacing five this_cpu_read() by one this_cpu_ptr() makes
> > the generated code smaller.
> 
> Does not for me, that is, the resulting asm is actually larger
> 
> You're quite right the loop went missing; no idea wth that compiler is
> smoking (gcc-8.2 for me). In order to eliminate that loop it needs to
> think that two consecutive loads of this_cpu_read(cyc2ns.seq.sequence)
> will return the same value. But this_cpu_read() is an asm() statement,
> it _should_ not assume such.
> 
> We assume that this_cpu_read() implies READ_ONCE() in a number of
> locations, this really should not happen.
> 
> The reason it was written using this_cpu_read() is so that it can use
> %gs: prefixed instructions and avoid ever loading that percpu offset and
> doing manual address computation.
> 
> Let me prod at this with a sharp stick.

OK, so apart from the inlining being crap, which is fixed by:

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6490f618e096..638491062fea 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -57,7 +57,7 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
-void cyc2ns_read_begin(struct cyc2ns_data *data)
+void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
 
@@ -74,7 +74,7 @@ void cyc2ns_read_begin(struct cyc2ns_data *data)
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
 }
 
-void cyc2ns_read_end(void)
+void __always_inline cyc2ns_read_end(void)
 {
 	preempt_enable_notrace();
 }
@@ -103,7 +103,7 @@ void cyc2ns_read_end(void)
  *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+static __always_inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
 	unsigned long long ns;


That gets us:

native_sched_clock:
	pushq   %rbp    #
	movq    %rsp, %rbp      #,

 ... jump label ...

	rdtsc
	salq    $32, %rdx       #, tmp110
	orq     %rax, %rdx      # low, tmp110
	movl %gs:cyc2ns+32(%rip),%ecx   # cyc2ns.seq.sequence, pfo_ret__
	andl    $1, %ecx        #, idx
	salq    $4, %rcx        #, tmp116
	movl %gs:cyc2ns(%rcx),%esi      # cyc2ns.data[idx_14].cyc2ns_mul, pfo_ret__
	movl    %esi, %esi      # pfo_ret__, pfo_ret__
	movq    %rsi, %rax      # pfo_ret__, tmp133
	mulq    %rdx    # _23
	movq %gs:cyc2ns+8(%rcx),%rdi    # cyc2ns.data[idx_14].cyc2ns_offset, pfo_ret__
	addq    $cyc2ns, %rcx   #, tmp117
	movl %gs:4(%rcx),%ecx   # cyc2ns.data[idx_14].cyc2ns_shift, pfo_ret__
	shrdq   %rdx, %rax      # pfo_ret__,, tmp134
	shrq    %cl, %rdx       # pfo_ret__,
	testb   $64, %cl        #, pfo_ret__
	cmovne  %rdx, %rax      #,, tmp134
	addq    %rdi, %rax      # pfo_ret__, <retval>
	popq    %rbp    #
	ret


If we then fix the percpu mess, with:

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e9202a0de8f0..1a19d11cfbbd 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -185,22 +185,22 @@ do {									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(1)",%0"		\
+		asm volatile(op "b "__percpu_arg(1)",%0"\
 		    : "=q" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(1)",%0"		\
+		asm volatile(op "w "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(1)",%0"		\
+		asm volatile(op "l "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(1)",%0"		\
+		asm volatile(op "q "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\


That turns into:

native_sched_clock:
	pushq   %rbp    #
	movq    %rsp, %rbp      #,

 ... jump label ...

	rdtsc
	salq    $32, %rdx       #, tmp110
	orq     %rax, %rdx      # low, tmp110
	movq    %rdx, %r10      # tmp110, _23
	movq    $cyc2ns, %r9    #, tmp136
.L235:
	movl %gs:cyc2ns+32(%rip),%eax   # cyc2ns.seq.sequence, pfo_ret__
	movl    %eax, %ecx      # pfo_ret__, idx
	andl    $1, %ecx        #, idx
	salq    $4, %rcx        #, tmp116
	addq    %r9, %rcx       # tmp136, tmp117
	movq %gs:8(%rcx),%rdi   # cyc2ns.data[idx_14].cyc2ns_offset, pfo_ret__
	movl %gs:(%rcx),%esi    # cyc2ns.data[idx_14].cyc2ns_mul, pfo_ret__
	movl %gs:4(%rcx),%ecx   # cyc2ns.data[idx_14].cyc2ns_shift, pfo_ret__
	movl %gs:cyc2ns+32(%rip),%r8d   # cyc2ns.seq.sequence, pfo_ret__
	cmpl    %r8d, %eax      # pfo_ret__, pfo_ret__
	jne     .L235   #,
	movl    %esi, %esi      # pfo_ret__, pfo_ret__
	movq    %rsi, %rax      # pfo_ret__, tmp133
	mulq    %r10    # _23
	shrdq   %rdx, %rax      # pfo_ret__,, tmp134
	shrq    %cl, %rdx       # pfo_ret__,
	testb   $64, %cl        #, pfo_ret__
	cmovne  %rdx, %rax      #,, tmp134
	addq    %rdi, %rax      # pfo_ret__, <retval>
	popq    %rbp    #
	ret

which is exactly right. Except perhaps for the mess that
mul_u64_u32_shr() turns into.
