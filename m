Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeDQUQ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 16:16:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752043AbeDQUQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 16:16:56 -0400
Date: Tue, 17 Apr 2018 15:16:55 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] x86/dumpstack: Cleanups and user opcode bytes Code:
 section, v2
Message-ID: <20180417201655.szlq2oxur4mg24uh@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <CA+55aFyvwdG49eCgX9Bs9UGEo4VWgS7dY6ZuEkBuugxTR58GnA@mail.gmail.com>
 <20180417144042.GB20840@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417144042.GB20840@pd.tnic>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 04:40:42PM +0200, Borislav Petkov wrote:
> On Thu, Mar 15, 2018 at 10:51:06AM -0700, Linus Torvalds wrote:
> > This version looks ok to me. I'm sure there's room for tweaking here,
> > but I'm not seeing anything alarming.
> 
> So I'm redoing the series ontop of 17-rc1 and I see a *lot* of output
> during testing. For example:
> 
> 1) is from the userspace fault, 2) is the panic from sysrq but then you have 3)
> which is
> 
> 	WARN_ON_ONCE(!cpu_online(new_cpu));
> 
> in set_task_cpu() and to top it all off, we have 4) coming from
> native_smp_send_reschedule():
> 
> static void native_smp_send_reschedule(int cpu)
> {
>         if (unlikely(cpu_is_offline(cpu))) {
>                 WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
> 
> so all the "fine tuning" we did to try to fit the most important splat
> on the screen is for shit because those loud WARNs simply pushed it all
> up into oblivion.
> 
> And the executive summary and registers are just as worthless in such a
> case.
> 
> We could start thinking about caching all that data from the very first
> splat, when we're not tainted yet and dump it last but then we can't
> even know what is going out last.
> 
> Not only because we can't guess from where stuff might warn and what
> could execute - the below splats case-in-point - also, and more
> importantly, we don't know how much of that data would actually go out
> as there are no guarantees *when* the machine will die and stop spewing
> to the serial port.
> 
> So maybe the most important splat coming out first is maybe a good thing
> because it has a higher chance of coming out before the box locks up
> completely.
> 
> So I guess we should keep hoping that serial console works and keeps on
> working...
> 
> Hmmm.

I don't think the stack tracing code could do anything better here.  #3
and #4 seem like an issue with the scheduler, it doesn't realize the
rest of the CPUs have all been taken offline due to the panic().

-- 
Josh
