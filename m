Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF91C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B0120855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544451222;
	bh=h+EPNfQHPMb1n9j/ghB75q5Z1uK1hLlG0b80INzubEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zsHbdfsuGX7KDultpK6px/sVPBWGfBCNB91Jt+sy03VOdxpMiTzGmRRggTkNwH0sI
	 34sjfIwKSb5c/B8YALmy/U5cSHR0/aUxfx5kOKlTfvlnjT3wAWovLS/ZSZELfQXjNo
	 Qi+1xM4xuUSUk5+6uhqwTeQ1dvkM4zKCAfV+Zm8I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B0120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeLJONl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:13:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:40134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727396AbeLJONk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:13:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29CD2AD8F;
        Mon, 10 Dec 2018 14:13:38 +0000 (UTC)
Date:   Mon, 10 Dec 2018 15:13:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] kernel.h: Add non_block_start/end()
Message-ID: <20181210141337.GQ1286@dhcp22.suse.cz>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
 <20181210103641.31259-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210103641.31259-3-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not see any scheduler guys Cced and it would be really great to get
their opinion here.

On Mon 10-12-18 11:36:39, Daniel Vetter wrote:
> In some special cases we must not block, but there's not a
> spinlock, preempt-off, irqs-off or similar critical section already
> that arms the might_sleep() debug checks. Add a non_block_start/end()
> pair to annotate these.
> 
> This will be used in the oom paths of mmu-notifiers, where blocking is
> not allowed to make sure there's forward progress.

Considering the only alternative would be to abuse
preempt_{disable,enable}, and that really has a different semantic, I
think this makes some sense. The cotext is preemptible but we do not
want notifier to sleep on any locks, WQ etc.

> Suggested by Michal Hocko.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  include/linux/kernel.h | 10 +++++++++-
>  include/linux/sched.h  |  4 ++++
>  kernel/sched/core.c    |  6 +++---
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d6aac75b51ba..c2cf31515b3d 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -251,7 +251,9 @@ extern int _cond_resched(void);
>   * might_sleep - annotation for functions that can sleep
>   *
>   * this macro will print a stack trace if it is executed in an atomic
> - * context (spinlock, irq-handler, ...).
> + * context (spinlock, irq-handler, ...). Additional sections where blocking is
> + * not allowed can be annotated with non_block_start() and non_block_end()
> + * pairs.
>   *
>   * This is a useful debugging help to be able to catch problems early and not
>   * be bitten later when the calling function happens to sleep when it is not
> @@ -260,6 +262,10 @@ extern int _cond_resched(void);
>  # define might_sleep() \
>  	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
>  # define sched_annotate_sleep()	(current->task_state_change = 0)
> +# define non_block_start() \
> +	do { current->non_block_count++; } while (0)
> +# define non_block_end() \
> +	do { WARN_ON(current->non_block_count-- == 0); } while (0)
>  #else
>    static inline void ___might_sleep(const char *file, int line,
>  				   int preempt_offset) { }
> @@ -267,6 +273,8 @@ extern int _cond_resched(void);
>  				   int preempt_offset) { }
>  # define might_sleep() do { might_resched(); } while (0)
>  # define sched_annotate_sleep() do { } while (0)
> +# define non_block_start() do { } while (0)
> +# define non_block_end() do { } while (0)
>  #endif
>  
>  #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ecffd4e37453..41249dbf8f27 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -916,6 +916,10 @@ struct task_struct {
>  	struct mutex_waiter		*blocked_on;
>  #endif
>  
> +#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> +	int				non_block_count;
> +#endif
> +
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	unsigned int			irq_events;
>  	unsigned long			hardirq_enable_ip;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6fedf3a98581..969d7a71f30c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6113,7 +6113,7 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  	rcu_sleep_check();
>  
>  	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
> -	     !is_idle_task(current)) ||
> +	     !is_idle_task(current) && !current->non_block_count) ||
>  	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
>  	    oops_in_progress)
>  		return;
> @@ -6129,8 +6129,8 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  		"BUG: sleeping function called from invalid context at %s:%d\n",
>  			file, line);
>  	printk(KERN_ERR
> -		"in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
> -			in_atomic(), irqs_disabled(),
> +		"in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
> +			in_atomic(), irqs_disabled(), current->non_block_count,
>  			current->pid, current->comm);
>  
>  	if (task_stack_end_corrupted(current))
> -- 
> 2.20.0.rc1
> 

-- 
Michal Hocko
SUSE Labs
