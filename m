Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755217AbeDCKqD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:46:03 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38107 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754893AbeDCKqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:46:02 -0400
X-Google-Smtp-Source: AIpwx4/QiLnXsCJ69D8rqnoWCrejWHSFoe3jzA79GvQ8tl7nHI1HjPUSiHsBg+lqUpS+v4fVMxQpug==
Date: Tue, 3 Apr 2018 12:45:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, peterz@infradead.org,
        mingo@elte.hu, ak@linux.intel.com, kan.liang@intel.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf/x86/intel: move regs->flags EXACT bit init
Message-ID: <20180403104558.ejcyn4hskpfe6v6n@gmail.com>
References: <1522741649-13904-1-git-send-email-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522741649-13904-1-git-send-email-eranian@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephane Eranian <eranian@google.com> wrote:

> This patch removes a redundant store on regs->flags introduced
> by commit:
> 
> 71eb9ee9596d ("perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CPUs")
> 
> We were clearing the PERF_EFLAGS_EXACT but it was overwritten by
> regs->flags = pebs->flags later on.
> 
> The PERF_EFLAGS_EXACT is a software flag using bit 3 of regs->flags.
> X86 marks this bit as Reserved. To make sure this bit is zero before
> we do any IP processing, we clear it explicitly.
> 
> Patch also removes the following assignment:
> 	regs->flags = pebs->flags | (regs->flags & PERF_EFLAGS_VM);
> 
> Because there is no regs->flags to preserve anymore because
> set_linear_ip() is not called until later.
> 
> Patch also clarifies comment for intel_pmu_pebs_fixup_ip().
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/intel/ds.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index da6780122786..41b44a4fff51 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1153,7 +1153,6 @@ static void setup_pebs_sample_data(struct perf_event *event,
>  	if (pebs == NULL)
>  		return;
>  
> -	regs->flags &= ~PERF_EFLAGS_EXACT;
>  	sample_type = event->attr.sample_type;
>  	dsrc = sample_type & PERF_SAMPLE_DATA_SRC;
>  
> @@ -1197,7 +1196,13 @@ static void setup_pebs_sample_data(struct perf_event *event,
>  	 * and PMI.
>  	 */
>  	*regs = *iregs;
> -	regs->flags = pebs->flags;
> +
> +	/*
> +	 * initialize regs_>flags from pebs
> +	 * clear exact bit (which uses Reserved bit 3),
> +	 * i.e, do not rely on it being zero.
> +	 */
> +	regs->flags = pebs->flags & ~PERF_EFLAGS_EXACT;

Please use consistent capitalization and spelling to make comments more readable:

s/initialize
 /Initialize

s/pebs
 /PEBS

s/i.e
 /i.e.

Also, please put a comma after 'PEBS', to make it more clear what the sentence 
says.

> -		/* Haswell and later have the eventing IP, so use it: */
> +		/* Haswell and later have the eventing IP, so use it */

So that's a step backwards in readability ...

> -			/* Otherwise use PEBS off-by-1 IP: */
> +			/* Otherwise use PEBS off-by-1 IP */

Ditto.

>  			set_linear_ip(regs, pebs->ip);
>  
> -			/* ... and try to fix it up using the LBR entries: */
> +			/*
> +			 * ... and try to fix it up using the LBR entries
> +			 * if successful, regs->ip modified and regs patch
> +			 * via set_linear_ip()
> +			 */
>  			if (intel_pmu_pebs_fixup_ip(regs))
>  				regs->flags |= PERF_EFLAGS_EXACT;

And it's unclear to me what this tries to say:

   "try to fix it up using the LBR entries if successful",

or:

   "try to fix it up using the LBR entries, and if successful, regs->ip modified 
    and regs patch via set_linear_ip()",

?

Please improve readability.

Thanks,

	Ingo
