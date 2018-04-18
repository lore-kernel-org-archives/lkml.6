Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbeDRPpv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:45:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753186AbeDRPpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:45:49 -0400
Date: Wed, 18 Apr 2018 10:45:48 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ORC unwinder bad backtrace
Message-ID: <20180418154548.eh5oq5inz3l3agyu@treble>
References: <20180418135438.GC27475@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418135438.GC27475@bombadil.infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 06:54:38AM -0700, Matthew Wilcox wrote:
> f81061192 <pte_clear.constprop.18>:
> ...
> ffffffff810611bf:       90                      nop
> ffffffff810611c0 <perf_trace_x86_exceptions>:
> 
> I suspect an off-by-one error; you don't really mean to point to the
> byte before perf_trace_x86_exception, you mean to point to byte 0 of
> perf_trace_x86_exception.
> 
> I'm going to archive up this compilation in case there's anything useful
> I can extract for you from it later.

Thanks for reporting this.  So there are really two issues:

1) The question marks mean the ORC unwinder got confused (and had to
   fall back to the crude "just print all text addresses on the stack").
   This is the real issue.

2) As you found, what should be "perf_trace_x86_exceptions+0x0" is
   actually printed as "pte_clear.constprop.18+0x2e".  I don't think
   this is fixable, because this is printed by the oops fallback code
   which just blindly prints out all the text addresses it finds on the
   stack when the unwinder fails.  It can't know whether the address was
   a call return address (the usual case) or was something else (in this
   case I suspect it's just a function pointer which just happens to be
   on the stack), so it assumes the former, and prints it accordingly.
   This isn't fixable per se -- but it will be "fixed" when we fix #1,
   which will give a deterministic stack trace instead of using the dumb
   fallback code.

Is it possible for you to copy the vmlinux somewhere?  That would be the
easiest option for debugging.

Otherwise I may ask for some specifics for you to gather from it.

Is it recreatable?  Once I come up with a fix, it would be helpful to
test with the same scenario.

Also has the root cause of the stack recursion been found?  It looks
like the perf_trace_x86_exceptions() tracepoint code is doing something
bad.

-- 
Josh
