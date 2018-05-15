Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeEOG5x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:57:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37435 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeEOG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:57:51 -0400
X-Google-Smtp-Source: AB8JxZp/1T6mySIuj0Spxrd7SroZ9/QB4cpzM6bes4ze7ezCQoYZQByyyo9I+kM5A5kvOQUORxGJEw==
Date: Tue, 15 May 2018 08:57:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 8/9] perf/breakpoint: Split breakpoint "check" and
 "commit"
Message-ID: <20180515065747.GA626@gmail.com>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
 <1525634395-23380-9-git-send-email-frederic@kernel.org>
 <20180509091703.GH12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509091703.GH12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, May 06, 2018 at 09:19:54PM +0200, Frederic Weisbecker wrote:
> >  arch/arm/include/asm/hw_breakpoint.h     |  5 ++++-
> >  arch/arm/kernel/hw_breakpoint.c          | 22 +++-------------------
> >  arch/arm64/include/asm/hw_breakpoint.h   |  5 ++++-
> >  arch/arm64/kernel/hw_breakpoint.c        | 22 +++-------------------
> >  arch/powerpc/include/asm/hw_breakpoint.h |  5 ++++-
> >  arch/powerpc/kernel/hw_breakpoint.c      | 22 +++-------------------
> >  arch/sh/include/asm/hw_breakpoint.h      |  5 ++++-
> >  arch/sh/kernel/hw_breakpoint.c           | 22 +++-------------------
> >  arch/x86/include/asm/hw_breakpoint.h     |  5 ++++-
> >  arch/x86/kernel/hw_breakpoint.c          | 23 +++--------------------
> >  arch/xtensa/include/asm/hw_breakpoint.h  |  5 ++++-
> >  arch/xtensa/kernel/hw_breakpoint.c       | 22 +++-------------------
> 
> Because of those ^,
> 
> >  kernel/events/hw_breakpoint.c            | 11 ++++++-----
> 
> would it not make sense to have a prelimenary patch doing something
> like:
> 
> __weak int hw_breakpoint_arch_check(struct perf_event *bp)
> {
> 	return arch_validate_hwbkpt_settings(bp);
> }
> 
> __weak void hw_breakpoint_arch_commit(struct perf_event *bp)
> {
> }
> 
> combined with this bit:
> 
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index 6e28d28..6896ceeb 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -402,11 +402,12 @@ int dbg_release_bp_slot(struct perf_event *bp)
> >  
> >  static int validate_hw_breakpoint(struct perf_event *bp)
> >  {
> > -	int ret;
> > +	int err;
> >  
> > -	ret = arch_validate_hwbkpt_settings(bp);
> > -	if (ret)
> > -		return ret;
> > +	err = hw_breakpoint_arch_check(bp, &bp->attr);
> > +	if (err)
> > +		return err;
> > +	hw_breakpoint_arch_commit(bp);
> >  
> >  	if (arch_check_bp_in_kernelspace(bp)) {
> >  		if (bp->attr.exclude_kernel)
> 
> And then convert the archs over one by one, and at the end remove the
> weak thingies entirely?

Makes sense.

The rest looks good to me - Frederic, once you implement Peter's uggestion I 
suspect this series can be applied.

Thanks,

	Ingo
