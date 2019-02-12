Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0DA20869
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfBLR6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:58:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:31236 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbfBLR6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:58:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 09:58:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="115645391"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2019 09:58:12 -0800
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap
 operations
To:     "Huang, Ying" <ying.huang@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>
References: <20190211083846.18888-1-ying.huang@intel.com>
 <20190211190646.j6pdxqirc56inbbe@ca-dmjordan1.us.oracle.com>
 <20190212032121.GA2723@andrea> <874l99ld05.fsf@yhuang-dev.intel.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Message-ID: <997d210f-8706-7dc1-b1bb-abcc2db2ddd1@linux.intel.com>
Date:   Tue, 12 Feb 2019 09:58:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <874l99ld05.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 10:47 PM, Huang, Ying wrote:
> Andrea Parri <andrea.parri@amarulasolutions.com> writes:
> 
>>>> +	if (!si)
>>>> +		goto bad_nofile;
>>>> +
>>>> +	preempt_disable();
>>>> +	if (!(si->flags & SWP_VALID))
>>>> +		goto unlock_out;
>>>
>>> After Hugh alluded to barriers, it seems the read of SWP_VALID could be
>>> reordered with the write in preempt_disable at runtime.  Without smp_mb()
>>> between the two, couldn't this happen, however unlikely a race it is?
>>>
>>> CPU0                                CPU1
>>>
>>> __swap_duplicate()
>>>     get_swap_device()
>>>         // sees SWP_VALID set
>>>                                    swapoff
>>>                                        p->flags &= ~SWP_VALID;
>>>                                        spin_unlock(&p->lock); // pair w/ smp_mb
>>>                                        ...
>>>                                        stop_machine(...)
>>>                                        p->swap_map = NULL;
>>>         preempt_disable()
>>>     read NULL p->swap_map
>>
>>
>> I don't think that that smp_mb() is necessary.  I elaborate:
>>
>> An important piece of information, I think, that is missing in the
>> diagram above is the stopper thread which executes the work queued
>> by stop_machine().  We have two cases to consider, that is,
>>
>>   1) the stopper is "executed before" the preempt-disable section
>>
>> 	CPU0
>>
>> 	cpu_stopper_thread()
>> 	...
>> 	preempt_disable()
>> 	...
>> 	preempt_enable()
>>
>>   2) the stopper is "executed after" the preempt-disable section
>>
>> 	CPU0
>>
>> 	preempt_disable()
>> 	...
>> 	preempt_enable()
>> 	...
>> 	cpu_stopper_thread()
>>
>> Notice that the reads from p->flags and p->swap_map in CPU0 cannot
>> cross cpu_stopper_thread().  The claim is that CPU0 sees SWP_VALID
>> unset in (1) and that it sees a non-NULL p->swap_map in (2).
>>
>> I consider the two cases separately:
>>
>>   1) CPU1 unsets SPW_VALID, it locks the stopper's lock, and it
>>      queues the stopper work; CPU0 locks the stopper's lock, it
>>      dequeues this work, and it reads from p->flags.
>>
>>      Diagrammatically, we have the following MP-like pattern:
>>
>> 	CPU0				CPU1
>>
>> 	lock(stopper->lock)		p->flags &= ~SPW_VALID
>> 	get @work			lock(stopper->lock)
>> 	unlock(stopper->lock)		add @work
>> 	reads p->flags 			unlock(stopper->lock)
>>
>>      where CPU0 must see SPW_VALID unset (if CPU0 sees the work
>>      added by CPU1).
>>
>>   2) CPU0 reads from p->swap_map, it locks the completion lock,
>>      and it signals completion; CPU1 locks the completion lock,
>>      it checks for completion, and it writes to p->swap_map.
>>
>>      (If CPU0 doesn't signal the completion, or CPU1 doesn't see
>>      the completion, then CPU1 will have to iterate the read and
>>      to postpone the control-dependent write to p->swap_map.)
>>
>>      Diagrammatically, we have the following LB-like pattern:
>>
>> 	CPU0				CPU1
>>
>> 	reads p->swap_map		lock(completion)
>> 	lock(completion)		read completion->done
>> 	completion->done++		unlock(completion)
>> 	unlock(completion)		p->swap_map = NULL
>>
>>      where CPU0 must see a non-NULL p->swap_map if CPU1 sees the
>>      completion from CPU0.
>>
>> Does this make sense?
> 
> Thanks a lot for detailed explanation!

This is certainly a non-trivial explanation of why memory barrier is not
needed.  Can we put it in the commit log and mention something in
comments on why we don't need memory barrier?

Thanks.

Tim

