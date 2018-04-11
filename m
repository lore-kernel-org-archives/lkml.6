Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeDKSGP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:06:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750734AbeDKSGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:06:14 -0400
Subject: Re: [PATCH 2/2] locking/qspinlock: Limit # of spins in _Q_PENDING_VAL
 wait loop
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        boqun.feng@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <1523297332-22720-1-git-send-email-longman@redhat.com>
 <1523297332-22720-2-git-send-email-longman@redhat.com>
 <20180411152211.6ggp4c3l64jij67x@armageddon.cambridge.arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <91b5ac4c-116b-5f1c-af88-1251db126fd4@redhat.com>
Date: Wed, 11 Apr 2018 14:06:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180411152211.6ggp4c3l64jij67x@armageddon.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 11:22 AM, Catalin Marinas wrote:
> Hi Waiman,
>
> On Mon, Apr 09, 2018 at 02:08:52PM -0400, Waiman Long wrote:
>> @@ -311,13 +320,19 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>  		return;
>>  
>>  	/*
>> -	 * wait for in-progress pending->locked hand-overs
>> +	 * wait for in-progress pending->locked hand-overs with a
>> +	 * limited number of spins.
>>  	 *
>>  	 * 0,1,0 -> 0,0,1
>>  	 */
>>  	if (val == _Q_PENDING_VAL) {
>> -		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
>> +		int cnt = _Q_PENDING_LOOP;
>> +
>> +		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL) {
>> +			if (!--cnt)
>> +				goto queue;
>>  			cpu_relax();
>> +		}
>>  	}
> In my model, the pathological case is not this loop but the following
> one (trylock || pending):
>
> P0:					P1:
> queued_spin_lock() fails		queued_spin_lock() succeeds
> queued_spin_lock_slowpath()
> 	val == _Q_LOCKED_VAL
> 	new = _Q_LOCKED_VAL |
> 		_Q_PENDING_VAL
> 					queued_spin_unlock()
> 						lock->val == 0
> 	cmpxchg(&lock->val, val, new)
> 		fails
> 	val = old (0)
> 	repeat for (;;) loop:
> 	new = _Q_LOCKED_VAL
> 					queued_spin_lock() succeeds
> 						lock->val == _Q_LOCKED_VAL
> 	cmpxchg(&lock->val, val, new)
> 		fails
> 	val = old (_Q_LOCKED_VAL)
> 	repeat for (;;) loop:
>
> 	... and we are back to the P0 state above when it first entered
> 	the loop, hence no progress. P1 never enters slowpath.

I don't see any problem in removing this second loop. Thanks for running
tool to check for problem.

-Longman
