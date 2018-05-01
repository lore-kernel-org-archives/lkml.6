Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbeEANkX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:40:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752009AbeEANkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:40:22 -0400
Date: Tue, 1 May 2018 08:40:20 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Suboptimal inline heuristics due to non-code sections
Message-ID: <20180501134020.fonel3x6plea5xdt@treble>
References: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 06:50:14AM +0000, Nadav Amit wrote:
> When gcc considers the size of a function for inlining decisions, it
> apparently considers *all* sections. Since the kernel extensively uses
> sections for things other than code (e.g., exception-table, bug-table), the
> optimality of these decisions seem questionable to me.
> 
> The objtool’s sections may be the most extreme case, as these sections are
> discarded, while their size still appears to be considered by the inlining
> heuristics. It may be beneficial not to consider (some) the other sections
> as well, as they do not affect code-caching but only increase the kernel
> size.
> 
> To illustrate the issue, consider the function copy_overflow():
> 
>    0xffffffff819315e0 <+0>:	push   %rbp
>    0xffffffff819315e1 <+1>:	mov    %rsi,%rdx
>    0xffffffff819315e4 <+4>:	mov    %edi,%esi
>    0xffffffff819315e6 <+6>:	mov    $0xffffffff820bc4b8,%rdi
>    0xffffffff819315ed <+13>:	mov    %rsp,%rbp
>    0xffffffff819315f0 <+16>:	callq  0xffffffff81089b70 <__warn_printk>
>    0xffffffff819315f5 <+21>:	ud2    
>    0xffffffff819315f7 <+23>:	pop    %rbp
>    0xffffffff819315f8 <+24>:	retq   
> 
> This function seems to me as a great candidate for inlining. Yet, in my 4.16
> build (using gcc 7.2), I get 38 non-inlined instances of this function in
> vmlinux. Forcing CONFIG_STACK_VALIDATION to be disabled reduces the number
> non-inlined instances to 35. Removing, in addition, the data which is saved
> in the __bug_table makes all the instances of the function to be inlined.
> 
> Obviously this certain function can be set as __always_inline, but the inline
> heuristics seems to me as wrongfully biased. 
> 
> What do you think?
> 
> Is there a way to make gcc to ignore sections for its inlining heuristics?

Good find.

Playing around with one of the affected files (crypto/af_alg.o), if I
make the .discard.reachable section empty by removing the text reference
from the annotate_reachable() macro, then copy_overflow() still isn't
inlined.

But if I remove the section completely by removing the
pushsection/popsection, then copy_overflow() gets inlined.

So GCC's inlining decisions are somehow influenced by the existence of
some random empty section.  This definitely seems like a GCC bug to me.

-- 
Josh
