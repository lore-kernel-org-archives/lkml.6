Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeDDQXO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:23:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeDDQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:23:11 -0400
Date: Wed, 4 Apr 2018 18:23:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] lockdep: Do not record irq state in
 debug_check_no_locks_freed()
Message-ID: <20180404162305.GK4043@hirez.programming.kicks-ass.net>
References: <20180404121904.6713fb9d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404121904.6713fb9d@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 12:19:04PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> While debugging where things were going wrong with mapping
> enabling/disabling interrupts with the lockdep state and actual real
> enabling and disabling interrupts, I had to silent the irq
> disabling/enabling in debug_check_no_locks_freed() because it was
> always showing up as it was called before the splat was.
> 
> Use raw_local_irq_save/restore() for debug_check_no_locks_freed() as it
> hides useful information about where interrupts were used incorrectly
> last.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 89b5f83f1969..8c145dc1315b 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4407,7 +4407,7 @@ void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
>  	if (unlikely(!debug_locks))
>  		return;
>  
> -	local_irq_save(flags);
> +	raw_local_irq_save(flags);
>  	for (i = 0; i < curr->lockdep_depth; i++) {
>  		hlock = curr->held_locks + i;
>  
> @@ -4418,7 +4418,7 @@ void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
>  		print_freed_lock_bug(curr, mem_from, mem_from + mem_len, hlock);
>  		break;
>  	}
> -	local_irq_restore(flags);
> +	raw_local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL_GPL(debug_check_no_locks_freed);

Makes sense, could you convert all of them just to make sure there
aren't any left?
