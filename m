Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeFELGl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:06:41 -0400
Received: from ozlabs.org ([203.11.71.1]:45461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751570AbeFELGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:06:40 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 04/12] powerpc: Implement hw_breakpoint_arch_parse()
In-Reply-To: <20180601144607.GA31501@lerouge>
References: <1526697950-7091-1-git-send-email-frederic@kernel.org> <1526697950-7091-5-git-send-email-frederic@kernel.org> <87fu2hstf3.fsf@concordia.ellerman.id.au> <20180525140556.GD22082@lerouge> <87in783tl0.fsf@concordia.ellerman.id.au> <20180601144607.GA31501@lerouge>
Date: Tue, 05 Jun 2018 21:06:36 +1000
Message-ID: <878t7to5kz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> On Mon, May 28, 2018 at 09:31:07PM +1000, Michael Ellerman wrote:
>> Frederic Weisbecker <frederic@kernel.org> writes:
>> 
>> > On Thu, May 24, 2018 at 12:01:52PM +1000, Michael Ellerman wrote:
>> >> Frederic Weisbecker <frederic@kernel.org> writes:
>> >> 
>> >> > diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
>> >> > index 348cac9..fba6527 100644
>> >> > --- a/arch/powerpc/kernel/hw_breakpoint.c
>> >> > +++ b/arch/powerpc/kernel/hw_breakpoint.c
>> >> > @@ -139,30 +139,31 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
>> >> >  /*
>> >> >   * Validate the arch-specific HW Breakpoint register settings
>> >> >   */
>> >> > -int arch_validate_hwbkpt_settings(struct perf_event *bp)
>> >> > +int hw_breakpoint_arch_parse(struct perf_event *bp,
>> >> > +			     struct perf_event_attr *attr,
>> >> > +			     struct arch_hw_breakpoint *hw)
>> >> 
>> >> I think the semantics here are that we are reading from bp/attr and
>> >> writing to hw?
>> >> 
>> >> If so would some sprinkling of const on the first two parameters help
>> >> make that clearer?
>> >
>> > I seem to remember there was an issue with that due to the various functions
>> > we call that need to be converted to take const as well. I thought I would
>> > do it in a seperate series but actually it should be no big deal to do it
>> > on this one.
>> 
>> Yeah, that does sometimes snowball out of control.
>> 
>> > Let me try that and respin.
>> 
>> Cool. It would be nice to have, but obviously not crucial.
>
> So I managed to constify the perf_event_attr parameter but not the struct perf_event *bp
> because the task target is fetched from it on is_compat_bp() on ARM64. I could constify it
> all the way up to test_ti_thread_flag() but the thread info can only be retrieved through
> a call to task_thread_info() and that's where the qualifier control ends. The const can not
> be passed there and we can't afford to constify the function either, I fear, as it is used
> everywhere for any purpose, including thread_info modifications.

Thanks for trying. 1 out of 2 const parameters is better than none :)

cheers
