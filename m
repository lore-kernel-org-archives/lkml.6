Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeCZIfT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:35:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeCZIfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:35:18 -0400
Date: Mon, 26 Mar 2018 10:35:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/3] sched/core: update preempt_notifier_key to modern api
Message-ID: <20180326083513.GI4043@hirez.programming.kicks-ass.net>
References: <20180325191056.24598-1-dave@stgolabs.net>
 <20180325191056.24598-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325191056.24598-4-dave@stgolabs.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 12:10:56PM -0700, Davidlohr Bueso wrote:
> No changes in refcount semantics -- key init is false; replace
> 
> static_key_slow_inc|dec   with   static_branch_inc|dec
> static_key_false          with   static_branch_unlikely
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  kernel/sched/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 757d5a251ca4..311451e58c3c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2462,17 +2462,17 @@ void wake_up_new_task(struct task_struct *p)
>  
>  #ifdef CONFIG_PREEMPT_NOTIFIERS
>  
> -static struct static_key preempt_notifier_key = STATIC_KEY_INIT_FALSE;
> +DEFINE_STATIC_KEY_FALSE(preempt_notifier_key);

and again..
