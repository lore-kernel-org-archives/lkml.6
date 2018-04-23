Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbeDWVa7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:30:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932368AbeDWVau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:30:50 -0400
Subject: Re: [PATCH] locking/rwsem: Synchronize task state & waiter->task of
 readers
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <1523380938-19462-1-git-send-email-longman@redhat.com>
 <6c112ecb-d662-b1fc-152a-32060ec46dae@redhat.com>
 <20180423205514.GA5876@andrea>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4661980a-ad4a-1578-0b8f-5b6788912582@redhat.com>
Date: Mon, 23 Apr 2018 17:30:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180423205514.GA5876@andrea>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2018 04:55 PM, Andrea Parri wrote:
> Hi Waiman,
>
> On Mon, Apr 23, 2018 at 12:46:12PM -0400, Waiman Long wrote:
>> On 04/10/2018 01:22 PM, Waiman Long wrote:
>>> It was observed occasionally in PowerPC systems that there was reader
>>> who had not been woken up but that its waiter->task had been cleared.
> Can you provide more details about these observations?  (links to LKML
> posts, traces, applications used/micro-benchmarks, ...)

They were customers reported problems on the RHEL7 kernel. Actually, we
are not able to reproduce it in-house. From the symptom, it does look
like a memory synchronization issue which I believe is also there in the
upstream code.

>>> One probable cause of this missed wakeup may be the fact that the
>>> waiter->task and the task state have not been properly synchronized as
>>> the lock release-acquire pair of different locks in the wakeup code path
>>> does not provide a full memory barrier guarantee.
> I guess that by the "pair of different locks" you mean (sem->wait_lock,
> p->pi_lock), right?  BTW, __rwsem_down_write_failed_common() is calling
> wake_up_q() _before_ releasing the wait_lock: did you intend to exclude
> this callsite? (why?)

Yes, I am talking about sem->wait_lock and p->pi_lock.

Right, there is an alternative reader wakeup path in
__rwsem_down_write_failed_common() iin addition to unlock wakeup. I
didn't purposely exclude that, but I think it has similar issue. I will
clarify that in the next version.

>
>> So smp_store_mb()
>>> is now used to set waiter->task to NULL to provide a proper memory
>>> barrier for synchronization.
> Mmh; the patch is not introducing an smp_store_mb()... My guess is that
> you are thinking at the sequence:
>
> 	smp_store_release(&waiter->task, NULL);
> 	[...]
> 	smp_mb(); /* added with your patch */
>
> or what am I missing?

I actually thought about doing that at the beginning. The reasons why I
changed my mind were:
1) If there are multiple readers ready to be woken up, you will have to
issue multiple smp_mb instead of just 1 here.
2) smp_store_mb() is implemented with a smp_mb after the store. So it
may not be able to ensure that setting the reader waiter to nil is the
last operation seen by other CPUs as noted in the comment above
smp_store_release().

For these 2 reasons, I decide to add an extra smp_mb at the end.

Cheers,
Longman
