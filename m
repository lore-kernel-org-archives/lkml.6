Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5866C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B4420851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B4420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeLELQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:16:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:58090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbeLELQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:16:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73962AE3D;
        Wed,  5 Dec 2018 11:16:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Dec 2018 12:16:46 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
In-Reply-To: <45bce871-edfd-c402-acde-2e57e80cc522@akamai.com>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <45bce871-edfd-c402-acde-2e57e80cc522@akamai.com>
Message-ID: <38cc83144a2ec332dead4e21214ea068@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-04 18:23, Jason Baron wrote:
> On 12/3/18 6:02 AM, Roman Penyaev wrote:

[...]

>> 
>>  	ep_set_busy_poll_napi_id(epi);
>> 
>> @@ -1156,8 +1187,8 @@ static int ep_poll_callback(wait_queue_entry_t 
>> *wait, unsigned mode, int sync, v
>>  	 */
>>  	if (unlikely(ep->ovflist != EP_UNACTIVE_PTR)) {
>>  		if (epi->next == EP_UNACTIVE_PTR) {
>> -			epi->next = ep->ovflist;
>> -			ep->ovflist = epi;
>> +			/* Atomically exchange tail */
>> +			epi->next = xchg(&ep->ovflist, epi);
> 
> This also relies on the fact that the same epi can't be added to the
> list in parallel, because the wait queue doing the wakeup will have the
> wait_queue_head lock. That was a little confusing for me b/c we only 
> had
> the read_lock() above.

Yes, that is indeed not obvious path, but wq is locked by 
wake_up_*_poll()
call or caller of wake_up_locked_poll() has to be sure wq.lock is taken.

I'll add an explicit comment here, thanks for pointing out.

> 
>>  			if (epi->ws) {
>>  				/*
>>  				 * Activate ep->ws since epi->ws may get
>> @@ -1172,7 +1203,7 @@ static int ep_poll_callback(wait_queue_entry_t 
>> *wait, unsigned mode, int sync, v
>> 
>>  	/* If this file is already in the ready list we exit soon */
>>  	if (!ep_is_linked(epi)) {
>> -		list_add_tail(&epi->rdllink, &ep->rdllist);
>> +		list_add_tail_lockless(&epi->rdllink, &ep->rdllist);
>>  		ep_pm_stay_awake_rcu(epi);
>>  	}
> 
> same for this.

... and an explicit comment here.

> 
>> 
>> @@ -1197,13 +1228,13 @@ static int ep_poll_callback(wait_queue_entry_t 
>> *wait, unsigned mode, int sync, v
>>  				break;
>>  			}
>>  		}
>> -		wake_up_locked(&ep->wq);
>> +		wake_up(&ep->wq);
> 
> why the switch here to the locked() variant? Shouldn't the 'reader'
> side, in this case which takes the rwlock for write see all updates in 
> a
> coherent state at this point?

lockdep inside __wake_up_common expects wq_head->lock is taken, and
seems this is not a good idea to leave wq naked on wake up path,
when several CPUs can enter wake function.  Although 
default_wake_function
is protected by spinlock inside try_to_wake_up(), but for example
autoremove_wake_function() can't be called concurrently for the same wq
(it removes wq entry from the list).  Also in case of bookmarks
__wake_up_common adds an entry to the list, thus can't be called without
any locks.

I understand you concern and you are right saying that read side sees
wq entries as stable, but that will work only if __wake_up_common does
not modify anything, that is seems true now, but of course it is
too scary to rely on that in the future.

> 
>>  	}
>>  	if (waitqueue_active(&ep->poll_wait))
>>  		pwake++;
>> 
>>  out_unlock:
>> -	spin_unlock_irqrestore(&ep->wq.lock, flags);
>> +	read_unlock_irqrestore(&ep->lock, flags);
>> 
>>  	/* We have to call this outside the lock */
>>  	if (pwake)
>> @@ -1489,7 +1520,7 @@ static int ep_insert(struct eventpoll *ep, const 
>> struct epoll_event *event,
>>  		goto error_remove_epi;
>> 
>>  	/* We have to drop the new item inside our item list to keep track 
>> of it */
>> -	spin_lock_irq(&ep->wq.lock);
>> +	write_lock_irq(&ep->lock);
>> 
>>  	/* record NAPI ID of new item if present */
>>  	ep_set_busy_poll_napi_id(epi);
>> @@ -1501,12 +1532,12 @@ static int ep_insert(struct eventpoll *ep, 
>> const struct epoll_event *event,
>> 
>>  		/* Notify waiting tasks that events are available */
>>  		if (waitqueue_active(&ep->wq))
>> -			wake_up_locked(&ep->wq);
>> +			wake_up(&ep->wq);
> 
> is this necessary to switch as well? Is this to make lockdep happy?
> Looks like there are few more conversions too below...

Yes, necessary, wq.lock should be taken.

--
Roman

