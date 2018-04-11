Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbeDKPWS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:22:18 -0400
Received: from foss.arm.com ([217.140.101.70]:50616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752664AbeDKPWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:22:17 -0400
Date: Wed, 11 Apr 2018 16:22:12 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        boqun.feng@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] locking/qspinlock: Limit # of spins in
 _Q_PENDING_VAL wait loop
Message-ID: <20180411152211.6ggp4c3l64jij67x@armageddon.cambridge.arm.com>
References: <1523297332-22720-1-git-send-email-longman@redhat.com>
 <1523297332-22720-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523297332-22720-2-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Mon, Apr 09, 2018 at 02:08:52PM -0400, Waiman Long wrote:
> @@ -311,13 +320,19 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		return;
>  
>  	/*
> -	 * wait for in-progress pending->locked hand-overs
> +	 * wait for in-progress pending->locked hand-overs with a
> +	 * limited number of spins.
>  	 *
>  	 * 0,1,0 -> 0,0,1
>  	 */
>  	if (val == _Q_PENDING_VAL) {
> -		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
> +		int cnt = _Q_PENDING_LOOP;
> +
> +		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL) {
> +			if (!--cnt)
> +				goto queue;
>  			cpu_relax();
> +		}
>  	}

In my model, the pathological case is not this loop but the following
one (trylock || pending):

P0:					P1:
queued_spin_lock() fails		queued_spin_lock() succeeds
queued_spin_lock_slowpath()
	val == _Q_LOCKED_VAL
	new = _Q_LOCKED_VAL |
		_Q_PENDING_VAL
					queued_spin_unlock()
						lock->val == 0
	cmpxchg(&lock->val, val, new)
		fails
	val = old (0)
	repeat for (;;) loop:
	new = _Q_LOCKED_VAL
					queued_spin_lock() succeeds
						lock->val == _Q_LOCKED_VAL
	cmpxchg(&lock->val, val, new)
		fails
	val = old (_Q_LOCKED_VAL)
	repeat for (;;) loop:

	... and we are back to the P0 state above when it first entered
	the loop, hence no progress. P1 never enters slowpath.

I think the pending bounded loop in your patch is needed for a three CPU
scenario where two of them can hand over _Q_PENDING_VAL while the third
doesn't make progress. I tried modeling 3 CPUs to see but the tool still
hits the for (;;) loop case rather than pending wait loop. Maybe a
combination of Will's changes to the (trylock || pending) loop with your
bounded pending hand-over?

-- 
Catalin
