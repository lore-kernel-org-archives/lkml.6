Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2705BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAC020856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAC020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGRRTQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:19:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730897AbeGRRTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:19:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEBAC40AC6DE;
        Wed, 18 Jul 2018 16:40:31 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A57212026D69;
        Wed, 18 Jul 2018 16:40:31 +0000 (UTC)
Subject: Re: [PATCH v2] locking/rwsem: Take read lock immediate if queue empty
 with no writer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Mark Ray <mark.ray@hpe.com>,
        Joe Mario <jmario@redhat.com>,
        Scott Norton <scott.norton@hpe.com>
References: <1531506653-5244-1-git-send-email-longman@redhat.com>
 <20180718161639.GT2494@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d9a125b2-3421-9c11-ff30-78812e42edc5@redhat.com>
Date:   Wed, 18 Jul 2018 12:40:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180718161639.GT2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 18 Jul 2018 16:40:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 18 Jul 2018 16:40:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 12:16 PM, Peter Zijlstra wrote:
> On Fri, Jul 13, 2018 at 02:30:53PM -0400, Waiman Long wrote:
>> It was discovered that a constant stream of readers might cause the
>> count to go negative most of the time after an initial trigger by a
>> writer even if no writer was present afterward. As a result, most of the
>> readers would have to go through the slowpath reducing their performance.
> I'm slightly confused, what happens to trigger this?
>
> (also, I'm forever confused by the whole BIAS scheme)

As I said before, an occasional writer among a stream of incoming
readers can cause this problem.

>
>> To avoid that from happening, an additional check is added to detect
>> the special case that the reader in the critical section is the only
>> one in the wait queue and no writer is present. When that happens, it
>> can just have the lock and return immediately without further action.
>> Other incoming readers won't see a waiter is present and be forced
>> into the slowpath.

The last sentence above is the key. It is what the other incoming
readers observe that cause the vicious cycle. See below.

>>
>> The additional code is in the slowpath and so should not have an impact
>> on rwsem performance. However, in the special case listed above, it may
>> greatly improve performance.
>
>> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
>> index 3064c50..bf0570e 100644
>> --- a/kernel/locking/rwsem-xadd.c
>> +++ b/kernel/locking/rwsem-xadd.c
>> @@ -233,8 +233,19 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
> your diff function thingy is busted, this is in fact
> __rwsem_down_read_failed_common you're patching.

Yes, I am patching __rwsem_down_read_failed_common().
>
>>  	waiter.type = RWSEM_WAITING_FOR_READ;
>>  
>>  	raw_spin_lock_irq(&sem->wait_lock);
>> -	if (list_empty(&sem->wait_list))
>> +	if (list_empty(&sem->wait_list)) {
>> +		/*
>> +		 * In the unlikely event that the task is the only one in
>> +		 * the wait queue and a writer isn't present, it can have
>> +		 * the lock and return immediately without going through
>> +		 * the remaining slowpath code.
>> +		 */
>> +		if (unlikely(atomic_long_read(&sem->count) >= 0)) {
>> +			raw_spin_unlock_irq(&sem->wait_lock);
>> +			return sem;
>> +		}
>>  		adjustment += RWSEM_WAITING_BIAS;
>> +	}
>>  	list_add_tail(&waiter.list, &sem->wait_list);
> So without this, we would add ourselves to the list and then immediately
> call __rwsem_mark_wake() on ourselves and fall through the wait-loop, ow
> what?

The key here is that we don't want other incoming readers to observe
that there are waiters in the wait queue and hence have to go into the
slowpath until the single waiter in the queue is sure that it probably
will need to go to sleep if there is writer.

With a constant stream of incoming readers, a major portion of them will
observe the a negative count and be serialized to enter the slowpath.
There are certainly other readers that do not observe the negative count
in the in between period after one reader clear the count in the unlock
path and a waiter set the count to negative again. Those readers can go
ahead and do the read in parallel. But it is the serialized readers that
cause the performance loss and the observation of spinlock contention in
the perf output.

It is the constant stream of incoming readers that sustain the spinlock
queue and the repeated clearing and negative setting of the count.

I can reword the commit log and comment with a v3 patch if you think
that is helpful.

Cheers,
Longman



