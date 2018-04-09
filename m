Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeDINcx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:32:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752250AbeDINcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:32:50 -0400
Subject: Re: [PATCH] locking/rwsem: Add up_write_non_owner() for
 percpu_up_write()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
References: <1522852646-2196-1-git-send-email-longman@redhat.com>
 <20180409112013.GA23240@redhat.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <38c89c59-5ff0-20df-2628-880db397006e@redhat.com>
Date: Mon, 9 Apr 2018 09:32:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180409112013.GA23240@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 07:20 AM, Oleg Nesterov wrote:
> On 04/04, Waiman Long wrote:
>> --- a/kernel/locking/percpu-rwsem.c
>> +++ b/kernel/locking/percpu-rwsem.c
>> @@ -179,8 +179,10 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
>>  
>>  	/*
>>  	 * Release the write lock, this will allow readers back in the game.
>> +	 * percpu_up_write() may be called from a task different from the one
>> +	 * taking the lock.
>>  	 */
>> -	up_write(&sem->rw_sem);
>> +	up_write_non_owner(&sem->rw_sem);
>>  
>>  	/*
>>  	 * Once this completes (at least one RCU-sched grace period hence) the
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 30465a2..140d5ef 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -222,4 +222,17 @@ void up_read_non_owner(struct rw_semaphore *sem)
>>  
>>  #endif
>>  
>> +#ifdef CONFIG_DEBUG_RWSEMS
>> +/*
>> + * release a write lock from a different task
>> + */
>> +void up_write_non_owner(struct rw_semaphore *sem)
>> +{
>> +	rwsem_release(&sem->dep_map, 1, _RET_IP_);
>> +	DEBUG_RWSEMS_WARN_ON(!sem->owner || (sem->owner == RWSEM_READER_OWNED));
>>  
>> +	rwsem_clear_owner(sem);
>> +	__up_write(sem);
>> +}
> Hmm. Can you look at lockdep_sb_freeze_release() and lockdep_sb_freeze_acquire()?

These 2 functions are there to deal with the lockdep code.

> At first glance, it would be much better to set sem->owner = current in
> percpu_rwsem_acquire(), no?

The primary purpose of the owner field is to enable optimistic spinning
to improve locking performance. So it needs to be set during an
up_write() call.

My rwsem debug patch does use it also to check for consistency in the
use of lock/unlock call. Anyway, I don't think it is right to set it
again in percpu_rwsem_acquire() if there is no guarantee that the task
that call percpu_rwsem_acquire will be the one that will do the unlock.

I am wondering if it makes sense to do optimistic spinning in the case
of percpu_rwsem where the unlocker may be a different task. We could set
a special code for writer owned lock, but don't do optimistic spinning
in this case.

Cheers,
Longman
