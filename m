Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0F3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAC221104
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAC221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeKLL6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbeKLL57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:57:59 -0500
Received: from vmware.local.home (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A7B20871;
        Mon, 12 Nov 2018 02:07:06 +0000 (UTC)
Date:   Sun, 11 Nov 2018 21:07:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/4] rcu: Eliminate BUG_ON() for sync.c
Message-ID: <20181111210704.7bb9946f@vmware.local.home>
In-Reply-To: <20181111193217.4010-1-paulmck@linux.ibm.com>
References: <20181111193156.GA3666@linux.ibm.com>
        <20181111193217.4010-1-paulmck@linux.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 11:32:14 -0800
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> The sync.c file has a number of calls to BUG_ON(), which panics the
> kernel, which is not a good strategy for devices (like embedded) that
> don't have a way to capture console output.  This commit therefore
> changes these BUG_ON() calls to WARN_ON_ONCE(), but does so quite naively.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/rcu/sync.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> index 3f943efcf61c..a6ba446a9693 100644
> --- a/kernel/rcu/sync.c
> +++ b/kernel/rcu/sync.c
> @@ -125,8 +125,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
>  		rsp->gp_state = GP_PENDING;
>  	spin_unlock_irq(&rsp->rss_lock);
>  
> -	BUG_ON(need_wait && need_sync);
> -
> +	WARN_ON_ONCE(need_wait && need_sync);
>  	if (need_sync) {
>  		gp_ops[rsp->gp_type].sync();
>  		rsp->gp_state = GP_PASSED;
> @@ -139,7 +138,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
>  		 * Nobody has yet been allowed the 'fast' path and thus we can
>  		 * avoid doing any sync(). The callback will get 'dropped'.
>  		 */
> -		BUG_ON(rsp->gp_state != GP_PASSED);
> +		WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
>  	}
>  }
>  
> @@ -166,8 +165,8 @@ static void rcu_sync_func(struct rcu_head *rhp)
>  	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
>  	unsigned long flags;
>  
> -	BUG_ON(rsp->gp_state != GP_PASSED);
> -	BUG_ON(rsp->cb_state == CB_IDLE);
> +	WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
> +	WARN_ON_ONCE(rsp->cb_state == CB_IDLE);
>  
>  	spin_lock_irqsave(&rsp->rss_lock, flags);
>  	if (rsp->gp_count) {
> @@ -225,7 +224,7 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
>  {
>  	int cb_state;
>  
> -	BUG_ON(rsp->gp_count);
> +	WARN_ON_ONCE(rsp->gp_count);
>  
>  	spin_lock_irq(&rsp->rss_lock);
>  	if (rsp->cb_state == CB_REPLAY)
> @@ -235,6 +234,6 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
>  
>  	if (cb_state != CB_IDLE) {
>  		gp_ops[rsp->gp_type].wait();
> -		BUG_ON(rsp->cb_state != CB_IDLE);
> +		WARN_ON_ONCE(rsp->cb_state != CB_IDLE);
>  	}
>  }

I take it that if any of these WARN_ON_ONCE() triggers, they wont cause
immediate catastrophe, and/or there's no gentle way out like you have
with the other patches exiting the function when one is hit.

-- Steve

