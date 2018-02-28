Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeB1MSS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:18:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48588 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752230AbeB1MSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:18:17 -0500
Date: Wed, 28 Feb 2018 12:18:10 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Detect early free of a live mm
Message-ID: <20180228121809.ztpcjb3256tj6tct@lakrids.cambridge.arm.com>
References: <20180228121458.2230-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228121458.2230-1-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh, I messed up Peter's email when sending this out. please
s/infraded/infradead/ if replying to the first mail.

Sorry about that.

Mark.

On Wed, Feb 28, 2018 at 12:14:58PM +0000, Mark Rutland wrote:
> KASAN splats indicate that in some cases we free a live mm, then
> continue to access it, with potentially disastrous results. This is
> likely due to a mismatched mmdrop() somewhere in the kernel, but so far
> the culprit remains elusive.
> 
> Let's have __mmdrop() verify that the mm isn't live for the current
> task, similar to the existing check for init_mm. This way, we can catch
> this class of issue earlier, and without requiring KASAN.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Peter Zijlstra <peterz@infraded.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/fork.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Hi,
> 
> For context, we're seeing an intermittent use-after-free of an mm on
> arm64 [1], where it looks like an mm has been freed earlier than
> expected. So far KASAN has only caught legitimate mmdrop() uses, where
> mm_count is presumably already bogus.
> 
> Mark.
> 
> [1] https://lkml.kernel.org/r/20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index e5d9d405ae4e..6922d93551b8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -595,6 +595,8 @@ static void check_mm(struct mm_struct *mm)
>  void __mmdrop(struct mm_struct *mm)
>  {
>  	BUG_ON(mm == &init_mm);
> +	BUG_ON(mm == current->mm);
> +	BUG_ON(mm == current->active_mm);
>  	mm_free_pgd(mm);
>  	destroy_context(mm);
>  	hmm_mm_destroy(mm);
> -- 
> 2.11.0
> 
