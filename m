Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DD2222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405064AbfBNCiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:38:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfBNCiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:38:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9014DC049D67;
        Thu, 14 Feb 2019 02:38:10 +0000 (UTC)
Received: from sky.random (ovpn-120-178.rdu2.redhat.com [10.10.120.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97FC25D6B3;
        Thu, 14 Feb 2019 02:38:06 +0000 (UTC)
Date:   Wed, 13 Feb 2019 21:38:05 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap
 operations
Message-ID: <20190214023805.GA19090@redhat.com>
References: <20190211083846.18888-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211083846.18888-1-ying.huang@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 14 Feb 2019 02:38:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Mon, Feb 11, 2019 at 04:38:46PM +0800, Huang, Ying wrote:
> @@ -2386,7 +2463,17 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>  	frontswap_init(p->type, frontswap_map);
>  	spin_lock(&swap_lock);
>  	spin_lock(&p->lock);
> -	 _enable_swap_info(p, prio, swap_map, cluster_info);
> +	setup_swap_info(p, prio, swap_map, cluster_info);
> +	spin_unlock(&p->lock);
> +	spin_unlock(&swap_lock);
> +	/*
> +	 * Guarantee swap_map, cluster_info, etc. fields are used
> +	 * between get/put_swap_device() only if SWP_VALID bit is set
> +	 */
> +	stop_machine(swap_onoff_stop, NULL, cpu_online_mask);

Should cpu_online_mask be read while holding cpus_read_lock?

	cpus_read_lock();
	err = __stop_machine(swap_onoff_stop, NULL, cpu_online_mask);
	cpus_read_unlock();

I missed what the exact motivation was for the switch from
rcu_read_lock()/syncrhonize_rcu() to preempt_disable()/stop_machine().

It looks like the above stop_machine all it does is to reach a
quiescent point, when you've RCU that already can reach the quiescent
point without an explicit stop_machine.

The reason both implementations are basically looking the same is that
stop_machine dummy call of swap_onoff_stop() { /* noop */ } will only
reach a quiescent point faster than RCU, but it's otherwise
functionally identical to RCU, but it's extremely more expensive. If
it wasn't functionally identical stop_machine() couldn't be used as a
drop in replacement of synchronize_sched() in the previous patch.

I don't see the point of worrying about the synchronize_rcu latency in
swapoff when RCU is basically identical and not more complex.

So to be clear, I'm not against stop_machine() but with stop_machine()
method invoked in all CPUs, you can actually do more than RCU and you
can remove real locking not just reach a quiescent point.

With stop_machine() the code would need reshuffling around so that the
actual p->swap_map = NULL happens inside stop_machine, not outside
like with RCU.

With RCU all code stays concurrent at all times, simply the race is
controlled, as opposed with stop_machine() you can make fully
serialize and run like in UP temporarily (vs all preempt_disable()
section at least).

For example nr_swapfiles could in theory become a constant under
preempt_disable() with stop_machine() without having to take a
swap_lock.

swap_onoff_stop can be implemented like this:

enum {
	FIRST_STOP_MACHINE_INIT,
	FIRST_STOP_MACHINE_START,
	FIRST_STOP_MACHINE_END,
};
static int first_stop_machine;
static int swap_onoff_stop(void *data)
{
	struct swap_stop_machine *swsm = (struct swap_stop_machine *)data;
	int first;

	first = cmpxchg(&first_stop_machine, FIRST_STOP_MACHINE_INIT,
			FIRST_STOP_MACHINE_START);
	if (first == FIRST_STOP_MACHINE_INIT) {
		swsm->p->swap_map = NULL;
		/* add more stuff here until swap_lock goes away */
		smp_wmb();
		WRITE_ONCE(first_stop_machine, FIRST_STOP_MACHINE_END);
	} else {
		do {
			cpu_relax();
		} while (READ_ONCE(first_stop_machine) !=
			 FIRST_STOP_MACHINE_END);
		smp_rmb();
	}

	return 0;
}

stop_machine invoked with a method like above, will guarantee while we
set p->swap_map to NULL (and while we do nr_swapfiles++) nothing else
can run, no even interrupts, so some lock may just disappear. Only NMI
and SMI could possibly run concurrently with the swsm->p->swap_map =
NULL operation.

If we've to keep swap_onoff_stop() a dummy function run on all CPUs
just to reach a quiescent point, then I don't see why
the synchronize_rcu() (or synchronize_sched or synchronize_kernel or
whatever it is called right now, but still RCU) solution isn't
preferable.

Thanks,
Andrea
