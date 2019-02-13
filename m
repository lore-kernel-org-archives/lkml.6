Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A056AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7848E21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfBMDXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:23:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:14522 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfBMDXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:23:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 19:23:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,364,1544515200"; 
   d="scan'208";a="115769977"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2019 19:23:39 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap operations
References: <20190211083846.18888-1-ying.huang@intel.com>
        <20190211190646.j6pdxqirc56inbbe@ca-dmjordan1.us.oracle.com>
        <20190212032121.GA2723@andrea> <874l99ld05.fsf@yhuang-dev.intel.com>
        <997d210f-8706-7dc1-b1bb-abcc2db2ddd1@linux.intel.com>
Date:   Wed, 13 Feb 2019 11:23:38 +0800
In-Reply-To: <997d210f-8706-7dc1-b1bb-abcc2db2ddd1@linux.intel.com> (Tim
        Chen's message of "Tue, 12 Feb 2019 09:58:11 -0800")
Message-ID: <87lg2kid6t.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen <tim.c.chen@linux.intel.com> writes:

> On 2/11/19 10:47 PM, Huang, Ying wrote:
>> Andrea Parri <andrea.parri@amarulasolutions.com> writes:
>> 
>>>>> +	if (!si)
>>>>> +		goto bad_nofile;
>>>>> +
>>>>> +	preempt_disable();
>>>>> +	if (!(si->flags & SWP_VALID))
>>>>> +		goto unlock_out;
>>>>
>>>> After Hugh alluded to barriers, it seems the read of SWP_VALID could be
>>>> reordered with the write in preempt_disable at runtime.  Without smp_mb()
>>>> between the two, couldn't this happen, however unlikely a race it is?
>>>>
>>>> CPU0                                CPU1
>>>>
>>>> __swap_duplicate()
>>>>     get_swap_device()
>>>>         // sees SWP_VALID set
>>>>                                    swapoff
>>>>                                        p->flags &= ~SWP_VALID;
>>>>                                        spin_unlock(&p->lock); // pair w/ smp_mb
>>>>                                        ...
>>>>                                        stop_machine(...)
>>>>                                        p->swap_map = NULL;
>>>>         preempt_disable()
>>>>     read NULL p->swap_map
>>>
>>>
>>> I don't think that that smp_mb() is necessary.  I elaborate:
>>>
>>> An important piece of information, I think, that is missing in the
>>> diagram above is the stopper thread which executes the work queued
>>> by stop_machine().  We have two cases to consider, that is,
>>>
>>>   1) the stopper is "executed before" the preempt-disable section
>>>
>>> 	CPU0
>>>
>>> 	cpu_stopper_thread()
>>> 	...
>>> 	preempt_disable()
>>> 	...
>>> 	preempt_enable()
>>>
>>>   2) the stopper is "executed after" the preempt-disable section
>>>
>>> 	CPU0
>>>
>>> 	preempt_disable()
>>> 	...
>>> 	preempt_enable()
>>> 	...
>>> 	cpu_stopper_thread()
>>>
>>> Notice that the reads from p->flags and p->swap_map in CPU0 cannot
>>> cross cpu_stopper_thread().  The claim is that CPU0 sees SWP_VALID
>>> unset in (1) and that it sees a non-NULL p->swap_map in (2).
>>>
>>> I consider the two cases separately:
>>>
>>>   1) CPU1 unsets SPW_VALID, it locks the stopper's lock, and it
>>>      queues the stopper work; CPU0 locks the stopper's lock, it
>>>      dequeues this work, and it reads from p->flags.
>>>
>>>      Diagrammatically, we have the following MP-like pattern:
>>>
>>> 	CPU0				CPU1
>>>
>>> 	lock(stopper->lock)		p->flags &= ~SPW_VALID
>>> 	get @work			lock(stopper->lock)
>>> 	unlock(stopper->lock)		add @work
>>> 	reads p->flags 			unlock(stopper->lock)
>>>
>>>      where CPU0 must see SPW_VALID unset (if CPU0 sees the work
>>>      added by CPU1).
>>>
>>>   2) CPU0 reads from p->swap_map, it locks the completion lock,
>>>      and it signals completion; CPU1 locks the completion lock,
>>>      it checks for completion, and it writes to p->swap_map.
>>>
>>>      (If CPU0 doesn't signal the completion, or CPU1 doesn't see
>>>      the completion, then CPU1 will have to iterate the read and
>>>      to postpone the control-dependent write to p->swap_map.)
>>>
>>>      Diagrammatically, we have the following LB-like pattern:
>>>
>>> 	CPU0				CPU1
>>>
>>> 	reads p->swap_map		lock(completion)
>>> 	lock(completion)		read completion->done
>>> 	completion->done++		unlock(completion)
>>> 	unlock(completion)		p->swap_map = NULL
>>>
>>>      where CPU0 must see a non-NULL p->swap_map if CPU1 sees the
>>>      completion from CPU0.
>>>
>>> Does this make sense?
>> 
>> Thanks a lot for detailed explanation!
>
> This is certainly a non-trivial explanation of why memory barrier is not
> needed.  Can we put it in the commit log and mention something in
> comments on why we don't need memory barrier?

Good idea!  Will do this.

Best Regards,
Huang, Ying

> Thanks.
>
> Tim
