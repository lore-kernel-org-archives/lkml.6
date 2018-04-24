Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDXOtP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:49:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbeDXOtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:49:12 -0400
Subject: Re: [PATCH] locking/rwsem: Synchronize task state & waiter->task of
 readers
To: Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <1523380938-19462-1-git-send-email-longman@redhat.com>
 <6c112ecb-d662-b1fc-152a-32060ec46dae@redhat.com>
 <20180423205514.GA5876@andrea>
 <20180424091510.GB4064@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <801fea56-90f3-4965-b24b-fa88ac8d16ce@redhat.com>
Date: Tue, 24 Apr 2018 10:49:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180424091510.GB4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 05:15 AM, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 10:55:14PM +0200, Andrea Parri wrote:
>>>> +	/*
>>>> +	 * To avoid missed wakeup of reader, we need to make sure
>>>> +	 * that task state and waiter->task are properly synchronized.
>>>> +	 *
>>>> +	 *     wakeup		      sleep
>>>> +	 *     ------		      -----
>>>> +	 * __rwsem_mark_wake:	rwsem_down_read_failed*:
>>>> +	 *   [S] waiter->task	  [S] set_current_state(state)
>>>> +	 *	 MB		      MB
>>>> +	 * try_to_wake_up:
>>>> +	 *   [L] state		  [L] waiter->task
>>>> +	 *
>>>> +	 * For the wakeup path, the original lock release-acquire pair
>>>> +	 * does not provide enough guarantee of proper synchronization.
>>>> +	 */
>>>> +	smp_mb();
>>>> +
>>>>  	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
>>>>  	if (list_empty(&sem->wait_list)) {
>>>>  		/* hit end of list above */
>> try_to_wake_up() does:
>>
>> 	raw_spin_lock_irqsave(&p->pi_lock, flags);
>> 	smp_mb__after_spinlock();
>> 	if (!(p->state & state))
>>
>> My understanding is that this smp_mb__after_spinlock() provides us with
>> the guarantee you described above.  The smp_mb__after_spinlock() should
>> represent a 'cheaper way' to provide such a guarantee.
> Right, I don't see what problem is being fixed here either. The scenario
> in the comment is already closed by the smp_mb__after_spinlock() you
> mention.
>
> And it is fine to rely on that, we do in other places.

Right, I missed the smp_mb__after_spinlock(). So the upstream code is
fine after all. Sorry for the noise.

Cheers,
Longman
