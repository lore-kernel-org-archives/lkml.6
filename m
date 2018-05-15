Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeEORwK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:52:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753306AbeEORwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:52:07 -0400
Subject: Re: [PATCH v3 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-2-git-send-email-longman@redhat.com>
 <20180515174837.GL12217@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4d823d09-b41c-2f86-40b7-f110bf30afd8@redhat.com>
Date: Tue, 15 May 2018 13:52:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180515174837.GL12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 01:48 PM, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 01:38:03PM -0400, Waiman Long wrote:
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 30465a2..b7208e1 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -130,7 +130,8 @@ void up_read(struct rw_semaphore *sem)
>>  void up_write(struct rw_semaphore *sem)
>>  {
>>  	rwsem_release(&sem->dep_map, 1, _RET_IP_);
>> -	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
>> +	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
>> +			     !rwsem_has_anonymous_owner(sem->owner));
> Why? Don't we always do percpu_rwsem_acquire() before up?
>

This is to allow an unlock to happen in the unknown owner state. Yes, it
is not necessary to fix the percpu-rwsem problem. It is there just in
case a rwsem will be released in that state in the future.

Cheers,
Longman
