Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934633AbeEIJR2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:17:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934203AbeEIJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:17:26 -0400
Date: Wed, 9 May 2018 11:17:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 8/9] perf/breakpoint: Split breakpoint "check" and
 "commit"
Message-ID: <20180509091703.GH12217@hirez.programming.kicks-ass.net>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
 <1525634395-23380-9-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525634395-23380-9-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 09:19:54PM +0200, Frederic Weisbecker wrote:
>  arch/arm/include/asm/hw_breakpoint.h     |  5 ++++-
>  arch/arm/kernel/hw_breakpoint.c          | 22 +++-------------------
>  arch/arm64/include/asm/hw_breakpoint.h   |  5 ++++-
>  arch/arm64/kernel/hw_breakpoint.c        | 22 +++-------------------
>  arch/powerpc/include/asm/hw_breakpoint.h |  5 ++++-
>  arch/powerpc/kernel/hw_breakpoint.c      | 22 +++-------------------
>  arch/sh/include/asm/hw_breakpoint.h      |  5 ++++-
>  arch/sh/kernel/hw_breakpoint.c           | 22 +++-------------------
>  arch/x86/include/asm/hw_breakpoint.h     |  5 ++++-
>  arch/x86/kernel/hw_breakpoint.c          | 23 +++--------------------
>  arch/xtensa/include/asm/hw_breakpoint.h  |  5 ++++-
>  arch/xtensa/kernel/hw_breakpoint.c       | 22 +++-------------------

Because of those ^,

>  kernel/events/hw_breakpoint.c            | 11 ++++++-----

would it not make sense to have a prelimenary patch doing something
like:

__weak int hw_breakpoint_arch_check(struct perf_event *bp)
{
	return arch_validate_hwbkpt_settings(bp);
}

__weak void hw_breakpoint_arch_commit(struct perf_event *bp)
{
}

combined with this bit:

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 6e28d28..6896ceeb 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -402,11 +402,12 @@ int dbg_release_bp_slot(struct perf_event *bp)
>  
>  static int validate_hw_breakpoint(struct perf_event *bp)
>  {
> -	int ret;
> +	int err;
>  
> -	ret = arch_validate_hwbkpt_settings(bp);
> -	if (ret)
> -		return ret;
> +	err = hw_breakpoint_arch_check(bp, &bp->attr);
> +	if (err)
> +		return err;
> +	hw_breakpoint_arch_commit(bp);
>  
>  	if (arch_check_bp_in_kernelspace(bp)) {
>  		if (bp->attr.exclude_kernel)

And then convert the archs over one by one, and at the end remove the
weak thingies entirely?
