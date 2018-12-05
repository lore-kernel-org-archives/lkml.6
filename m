Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B230DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D28A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D28A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeLENza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:55:30 -0500
Received: from mail5.windriver.com ([192.103.53.11]:57052 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbeLENz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:55:29 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB5DriM4004206
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 5 Dec 2018 05:54:00 -0800
Received: from [128.224.162.162] (128.224.162.162) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 5 Dec
 2018 05:53:41 -0800
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <catalin.marinas@arm.com>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <40a63aa5-edb6-4673-b4cc-1bc10e7b3953@windriver.com>
 <20181130181956.eewrlaabtceekzyu@linutronix.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <e7795912-7d93-8f4e-b997-67c4ac1f3549@windriver.com>
Date:   Wed, 5 Dec 2018 21:53:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130181956.eewrlaabtceekzyu@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.162]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/1 02:19, Sebastian Andrzej Siewior wrote:
> On 2018-11-24 22:26:46 [+0800], He Zhe wrote:
>> On latest v4.19.1-rt3, both of the call traces can be reproduced with kmemleak
>> enabied. And none can be reproduced with kmemleak disabled.
> okay. So it needs attention.
>
>> On latest mainline tree, none can be reproduced no matter kmemleak is enabled
>> or disabled.
>>
>> I don't get why kfree from a preempt-disabled section should cause a warning
>> without kmemleak, since kfree can't sleep.
> it might. It will acquire a sleeping lock if it has go down to the
> memory allocator to actually give memory back.

Got it. Thanks.

>
>> If I understand correctly, the call trace above is caused by trying to schedule
>> after preemption is disabled, which cannot be reached in mainline kernel. So
>> we might need to turn to use raw lock to keep preemption disabled.
> The buddy-allocator runs with spin locks so it is okay on !RT. So you
> can use kfree() with disabled preemption or disabled interrupts.
> I don't think that we want to use raw-locks in the buddy-allocator.

For call trace 1:

I went through the calling paths inside kfree() and found that there have already
been things using raw lock in it as follow.

1) in the path of kfree() itself
kfree -> slab_free -> do_slab_free -> __slab_free -> raw_spin_lock_irqsave

2) in the path of CONFIG_DEBUG_OBJECTS_FREE
kfree -> slab_free -> slab_free_freelist_hook -> slab_free_hook -> debug_check_no_obj_freed -> __debug_check_no_obj_freed -> raw_spin_lock_irqsave

3) in the path of CONFIG_LOCKDEP
kfree -> __free_pages -> free_unref_page -> free_unref_page_prepare -> free_pcp_prepare -> free_pages_prepare -> debug_check_no_locks_freed -> debug_check_no_locks_freed -> raw_local_irq_save

Since kmemleak would most likely be used to debug in environments where
we would not expect as great performance as without it, and kfree() has raw locks
in its main path and other debug function paths, I suppose it wouldn't hurt that
we change to raw locks.

>
>> >From what I reached above, this is RT-only and happens on v4.18 and v4.19.
>>
>> The call trace above is caused by grabbing kmemleak_lock and then getting
>> scheduled and then re-grabbing kmemleak_lock. Using raw lock can also solve
>> this problem.
> But this is a reader / writer lock. And if I understand the other part
> of the thread then it needs multiple readers.

For call trace 2:

I don't get what "it needs multiple readers" exactly means here.

In this call trace, the kmemleak_lock is grabbed as write lock, and then scheduled
away, and then grabbed again as write lock from another path. It's a
write->write locking, compared to the discussion in the other part of the thread.

This is essentially because kmemleak hooks on the very low level memory
allocation and free operations. After scheduled away, it can easily re-enter itself.
We need raw locks to prevent this from happening.

> Couldn't we just get rid of that kfree() or move it somewhere else?
> I mean if the free() memory on CPU-down and allocate it again CPU-up
> then we could skip that, rigth? Just allocate it and don't free it
> because the CPU will likely get up again.

For call trace 1:

I went through the CPU hotplug code and found that the allocation of the
problematic data, cpuc->shared_regs, is done in intel_pmu_cpu_prepare. And
the free is done in intel_pmu_cpu_dying. They are handlers triggered by two
different perf events.

It seems we can hardly form a convincing method that holds the data while
CPUs are off and then uses it again. raw locks would be easy and good enough.

Thanks,
Zhe

>
>> Thanks,
>> Zhe
> Sebastian
>

