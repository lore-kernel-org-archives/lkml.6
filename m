Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2F6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9127D208A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9127D208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeGCHYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:24:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:41014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753364AbeGCHYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:24:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 835F0AE06;
        Tue,  3 Jul 2018 07:24:14 +0000 (UTC)
Date:   Tue, 3 Jul 2018 09:24:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Message-ID: <20180703072413.GD16767@dhcp22.suse.cz>
References: <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
 <20180629132638.GD5963@dhcp22.suse.cz>
 <20180630170522.GZ3593@linux.vnet.ibm.com>
 <20180702213714.GA7604@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702213714.GA7604@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 14:37:14, Paul E. McKenney wrote:
[...]
> commit d2b8d16b97ac2859919713b2d98b8a3ad22943a2
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Mon Jul 2 14:30:37 2018 -0700
> 
>     rcu: Remove OOM code
>     
>     There is reason to believe that RCU's OOM code isn't really helping
>     that much, given that the best it can hope to do is accelerate invoking
>     callbacks by a few seconds, and even then only if some CPUs have no
>     non-lazy callbacks, a condition that has been observed to be rare.
>     This commit therefore removes RCU's OOM code.  If this causes problems,
>     it can easily be reinserted.
>     
>     Reported-by: Michal Hocko <mhocko@kernel.org>
>     Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

I would also note that waiting in the notifier might be a problem on its
own because we are holding the oom_lock and the system cannot trigger
the OOM killer while we are holding it and waiting for oom_callback_wq
event. I am not familiar with the code to tell whether this can deadlock
but from a quick glance I _suspect_ that we might depend on __rcu_reclaim
and basically an arbitrary callback so no good.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3f3796b10c71..3d7ce73e7309 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1722,87 +1722,6 @@ static void rcu_idle_count_callbacks_posted(void)
>  	__this_cpu_add(rcu_dynticks.nonlazy_posted, 1);
>  }
>  
> -/*
> - * Data for flushing lazy RCU callbacks at OOM time.
> - */
> -static atomic_t oom_callback_count;
> -static DECLARE_WAIT_QUEUE_HEAD(oom_callback_wq);
> -
> -/*
> - * RCU OOM callback -- decrement the outstanding count and deliver the
> - * wake-up if we are the last one.
> - */
> -static void rcu_oom_callback(struct rcu_head *rhp)
> -{
> -	if (atomic_dec_and_test(&oom_callback_count))
> -		wake_up(&oom_callback_wq);
> -}
> -
> -/*
> - * Post an rcu_oom_notify callback on the current CPU if it has at
> - * least one lazy callback.  This will unnecessarily post callbacks
> - * to CPUs that already have a non-lazy callback at the end of their
> - * callback list, but this is an infrequent operation, so accept some
> - * extra overhead to keep things simple.
> - */
> -static void rcu_oom_notify_cpu(void *unused)
> -{
> -	struct rcu_state *rsp;
> -	struct rcu_data *rdp;
> -
> -	for_each_rcu_flavor(rsp) {
> -		rdp = raw_cpu_ptr(rsp->rda);
> -		if (rcu_segcblist_n_lazy_cbs(&rdp->cblist)) {
> -			atomic_inc(&oom_callback_count);
> -			rsp->call(&rdp->oom_head, rcu_oom_callback);
> -		}
> -	}
> -}
> -
> -/*
> - * If low on memory, ensure that each CPU has a non-lazy callback.
> - * This will wake up CPUs that have only lazy callbacks, in turn
> - * ensuring that they free up the corresponding memory in a timely manner.
> - * Because an uncertain amount of memory will be freed in some uncertain
> - * timeframe, we do not claim to have freed anything.
> - */
> -static int rcu_oom_notify(struct notifier_block *self,
> -			  unsigned long notused, void *nfreed)
> -{
> -	int cpu;
> -
> -	/* Wait for callbacks from earlier instance to complete. */
> -	wait_event(oom_callback_wq, atomic_read(&oom_callback_count) == 0);
> -	smp_mb(); /* Ensure callback reuse happens after callback invocation. */
> -
> -	/*
> -	 * Prevent premature wakeup: ensure that all increments happen
> -	 * before there is a chance of the counter reaching zero.
> -	 */
> -	atomic_set(&oom_callback_count, 1);
> -
> -	for_each_online_cpu(cpu) {
> -		smp_call_function_single(cpu, rcu_oom_notify_cpu, NULL, 1);
> -		cond_resched_tasks_rcu_qs();
> -	}
> -
> -	/* Unconditionally decrement: no need to wake ourselves up. */
> -	atomic_dec(&oom_callback_count);
> -
> -	return NOTIFY_OK;
> -}
> -
> -static struct notifier_block rcu_oom_nb = {
> -	.notifier_call = rcu_oom_notify
> -};
> -
> -static int __init rcu_register_oom_notifier(void)
> -{
> -	register_oom_notifier(&rcu_oom_nb);
> -	return 0;
> -}
> -early_initcall(rcu_register_oom_notifier);
> -
>  #endif /* #else #if !defined(CONFIG_RCU_FAST_NO_HZ) */
>  
>  #ifdef CONFIG_RCU_FAST_NO_HZ

-- 
Michal Hocko
SUSE Labs
