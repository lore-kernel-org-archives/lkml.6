Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935265AbeEIOyr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:54:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934517AbeEIOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:54:46 -0400
Date: Wed, 9 May 2018 16:54:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
Message-ID: <20180509145436.GV12217@hirez.programming.kicks-ass.net>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 06:21:36PM +0300, Alexey Budankov wrote:
> 
> Store user space frame-pointer value (BP register) into Perf trace 
> on a sample for a process so the value becomes available when 
> unwinding call stacks for functions gaining event samples.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  arch/x86/kernel/perf_regs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index e47b2dbbdef3..8d68658eff7f 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user,


>  	 * Most system calls don't save these registers, don't report them.

^^^ that worries me and is the reason for the '-1's below. However I
think with all the PTI rework this might no longer be true.

The Changelog needs to state that user_regs->bp is in fact valid and
ideally point to the commits that makes it so. Also this patch should
update that comment.

Cc Andy who keeps better track of all that than me.

>  	 */
>  	regs_user_copy->bx = -1;
> -	regs_user_copy->bp = -1;
> +	/*
> +	 * Store user space frame-pointer value on sample
> +	 * to facilitate stack unwinding for cases when
> +	 * user space executable code has such support
> +	 * enabled at compile time;
> +	 */
> +	regs_user_copy->bp = user_regs->bp;
>  	regs_user_copy->r12 = -1;
>  	regs_user_copy->r13 = -1;
>  	regs_user_copy->r14 = -1;
