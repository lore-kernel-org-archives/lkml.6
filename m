Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBQK0W (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:26:22 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32855 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeBQK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:26:20 -0500
X-Google-Smtp-Source: AH8x226osgV8lXDQ5JPwDtgGTFbA+yF4WM+0uXzfouQpi4CHAY+PVojfT8H97JP5IFhcdPbn5tC2zA==
Date: Sat, 17 Feb 2018 11:26:16 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Woodhouse <dwmw2@infradead.org>, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180217102616.vcwatxsgj2vunlew@gmail.com>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <c77b3da9-136d-9988-119f-e94c86fd34a3@linux.intel.com>
 <1518808600.7876.49.camel@infradead.org>
 <66f94cb1-8160-56e0-680c-2e847ae05893@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f94cb1-8160-56e0-680c-2e847ae05893@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> On 02/16/2018 11:16 AM, David Woodhouse wrote:
> > On Fri, 2018-02-16 at 10:44 -0800, Tim Chen wrote:
> >>
> >> I encountered hang on a machine but not others when using the above
> >> macro.  It is probably an alignment thing with ALTERNATIVE as the
> >> problem went
> >> away after I made the change below:
> >>
> >> Tim
> >>
> >> diff --git a/arch/x86/include/asm/nospec-branch.h
> >> b/arch/x86/include/asm/nospec-branch.h
> >> index 8f2ff74..0f65bd2 100644
> >> --- a/arch/x86/include/asm/nospec-branch.h
> >> +++ b/arch/x86/include/asm/nospec-branch.h
> >> @@ -148,6 +148,7 @@ extern char __indirect_thunk_end[];
> >>  
> >>  #define alternative_msr_write(_msr, _val, _feature)            \
> >>         asm volatile(ALTERNATIVE("",                            \
> >> +                               ".align 16\n\t"                \
> >>                                 "movl %[msr], %%ecx\n\t"       \
> >>                                 "movl %[val], %%eax\n\t"       \
> >>                                 "movl $0, %%edx\n\t"           \
> > 
> > That's weird. Note that .align in an altinstr section isn't actually
> > going to do what you'd expect; the oldinstr and altinstr sections
> > aren't necessarily aligned the same, so however many NOPs it inserts
> > into the alternative, might be deliberately *misaligning* it in the
> > code that actually gets executed.
> > 
> > Are you sure you're not running a kernel where the alternatives code
> > would turn that alternative which *starts* with a NOP, into *all* NOPs?
> > 
> 
> I rebuild the kernel again without the align. I'm no longer
> seeing the issue again on that machine that had an issue earlier.  
> So let's ignore this for now as I can't reproduce the problem.
> 
> It should be other issues causing the hang I saw earlier.

Note that PeterZ was struggling with intermittent boot hangs yesterday as well, 
which hangs came and went during severeal (fruitless) bisection attempts. Then at 
a certain point the hangs went away altogether.

The symptoms for both his and your hangs are consistent with an alignment 
dependent bug.

My other guess is that it's perhaps somehow microcode related?

I'm not seeing any hangs myself, on various test systems.

Thanks,

	Ingo
