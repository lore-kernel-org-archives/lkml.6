Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF39EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1D42083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1D42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeIYWom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeIYWom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:44:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 044CF3001D26;
        Tue, 25 Sep 2018 16:36:25 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4A305D6A9;
        Tue, 25 Sep 2018 16:36:23 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] debugobjects: Disable lockdep tracking of
 debugobjects internal locks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, chuhu@redhat.com
References: <1537886469-18227-1-git-send-email-longman@redhat.com>
 <1537886469-18227-3-git-send-email-longman@redhat.com>
 <20180925153241.GD29985@hirez.programming.kicks-ass.net>
 <e3275861-6fbe-70c6-c005-2bfe80cbba0b@redhat.com>
 <20180925163150.GE29985@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e6dc78dc-fdd5-81b7-9a6a-c3e0f02286cc@redhat.com>
Date:   Tue, 25 Sep 2018 12:36:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180925163150.GE29985@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 25 Sep 2018 16:36:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 12:31 PM, Peter Zijlstra wrote:
> On Tue, Sep 25, 2018 at 12:20:05PM -0400, Waiman Long wrote:
>> On 09/25/2018 11:32 AM, Peter Zijlstra wrote:
>>> On Tue, Sep 25, 2018 at 10:41:09AM -0400, Waiman Long wrote:
>>>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>>>> index 70935ed91125..68d72ed9ca22 100644
>>>> --- a/lib/debugobjects.c
>>>> +++ b/lib/debugobjects.c
>>>> @@ -1106,8 +1106,15 @@ void __init debug_objects_early_init(void)
>>>>  {
>>>>  	int i;
>>>>  
>>>> -	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
>>>> +	/*
>>>> +	 * We don't need lockdep to verify correctness of debugobjects
>>>> +	 * internal locks.
>>>> +	 */
>>>> +	lockdep_set_novalidate_class(&pool_lock);
>>>> +	for (i = 0; i < ODEBUG_HASH_SIZE; i++) {
>>>>  		raw_spin_lock_init(&obj_hash[i].lock);
>>>> +		lockdep_set_novalidate_class(&obj_hash[i].lock);
>>>> +	}
>>>>  
>>>>  	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
>>>>  		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
>>> NAK, we do not _EVER_ set novalidate if it can at all be avoided.
>>>
>>> If there is a severe performance problem with lockdep, try and cure
>>> that. But really, who runs lockdep kernels on 8 sockets?
>> We do. It is part of our testing process to run both production and
>> debug kernels on a variety of different machines to see if anything
>> breaks. Some of them just happen to be 8-socket systems.
>>
>> The internal locks in the debugobjects code don't interact with other
>> locks at all as memory allocation isn't called with those lock held. So
>> disabling lockdep for those locks won't materially affect the accuracy
>> of the lockdep code.
>>
>> How about the ability to declare a class of locks as terminal in the
>> sense that no further lock acquisition is allowed while holding a
>> terminal lock? That will allow the the lockdep code to fast track the
>> handling of those locks and hopefully prevent hard lockup problem like that.
> Who guarantees they stay leaf locks? What if someone mucks up the
> debugobject locking because its Monday morning and they haven't had
> their coffee yet. You want lockdep to catch all that.

Lockdep will need to do checking to guarantee that.

> Also, where is the performance benefit here. The normal lock_acquire
> path doesn't change gobal state (it will not see new lock ordering in
> 99%+ of the cases).
>
> Typically we only push the lock on the task local lock stack, compute
> the new hash, and do the hash lookup, find it already exists and return.
>
> So what is the expensive part, and can we do something about that?

I will need to do some experimentation to find out. Will update this
thread with my finding.

Cheers,
Longman

