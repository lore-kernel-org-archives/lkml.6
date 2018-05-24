Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935562AbeEXB4I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:56:08 -0400
Received: from ozlabs.org ([203.11.71.1]:37561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935218AbeEXB4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:56:05 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH 01/12] perf/breakpoint: Split attribute parse and commit
In-Reply-To: <1526697950-7091-2-git-send-email-frederic@kernel.org>
References: <1526697950-7091-1-git-send-email-frederic@kernel.org> <1526697950-7091-2-git-send-email-frederic@kernel.org>
Date: Thu, 24 May 2018 11:56:01 +1000
Message-ID: <87h8mxstou.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 6e28d28..51320c2 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -424,19 +443,22 @@ static int validate_hw_breakpoint(struct perf_event *bp)
>  
>  int register_perf_hw_breakpoint(struct perf_event *bp)
>  {
> -	int ret;
> +	struct arch_hw_breakpoint hw;
> +	int err;
>  
> -	ret = reserve_bp_slot(bp);
> -	if (ret)
> -		return ret;
> +	err = reserve_bp_slot(bp);
> +	if (err)
> +		return err;
>  
> -	ret = validate_hw_breakpoint(bp);
> -
> -	/* if arch_validate_hwbkpt_settings() fails then release bp slot */
> -	if (ret)
> +	err = hw_breakpoint_parse(bp, &bp->attr, &hw);

Is there a good reason we pass bp and bp->attr? (I assume so)

That added to the confusion in the existing code I think.

cheers
