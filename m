Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F66C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFCA217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLRKwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:52:13 -0500
Received: from mail1.windriver.com ([147.11.146.13]:59864 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:52:13 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wBIApkIq018587
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Dec 2018 02:51:47 -0800 (PST)
Received: from [128.224.162.162] (128.224.162.162) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 18 Dec
 2018 02:51:46 -0800
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <catalin.marinas@arm.com>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <40a63aa5-edb6-4673-b4cc-1bc10e7b3953@windriver.com>
 <20181130181956.eewrlaabtceekzyu@linutronix.de>
 <e7795912-7d93-8f4e-b997-67c4ac1f3549@windriver.com>
 <20181205191400.qrhim3m3ak5hcsuh@linutronix.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <16ac893a-a080-18a5-e636-7b7668d978b0@windriver.com>
Date:   Tue, 18 Dec 2018 18:51:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205191400.qrhim3m3ak5hcsuh@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.162]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/6 03:14, Sebastian Andrzej Siewior wrote:
> On 2018-12-05 21:53:37 [+0800], He Zhe wrote:
>> For call trace 1:
> …
>> Since kmemleak would most likely be used to debug in environments where
>> we would not expect as great performance as without it, and kfree() has raw locks
>> in its main path and other debug function paths, I suppose it wouldn't hurt that
>> we change to raw locks.
> okay.
>
>>>> >From what I reached above, this is RT-only and happens on v4.18 and v4.19.
>>>>
>>>> The call trace above is caused by grabbing kmemleak_lock and then getting
>>>> scheduled and then re-grabbing kmemleak_lock. Using raw lock can also solve
>>>> this problem.
>>> But this is a reader / writer lock. And if I understand the other part
>>> of the thread then it needs multiple readers.
>> For call trace 2:
>>
>> I don't get what "it needs multiple readers" exactly means here.
>>
>> In this call trace, the kmemleak_lock is grabbed as write lock, and then scheduled
>> away, and then grabbed again as write lock from another path. It's a
>> write->write locking, compared to the discussion in the other part of the thread.
>>
>> This is essentially because kmemleak hooks on the very low level memory
>> allocation and free operations. After scheduled away, it can easily re-enter itself.
>> We need raw locks to prevent this from happening.
> With raw locks you wouldn't have multiple readers at the same time.
> Maybe you wouldn't have recursion but since you can't have multiple
> readers you would add lock contention where was none (because you could
> have two readers at the same time).

Sorry for slow reply.

OK. I understand your concern finally. At the commit log said, I wanted to use raw
rwlock but didn't find the DEFINE helper for it. Thinking it would not be expected to
have great performance, I turn to use raw spinlock instead. And yes, this would
introduce worse performance.

Maybe I miss the reason, but why don't we have rwlock_types_raw.h to define raw
rwlock helper for RT? With that, we can cleanly replace kmemleak_lock with a raw
rwlock.

Or should we just define a raw rwlock using basic type, like arch_rwlock_t, only in
kmemleak?

>
>>> Couldn't we just get rid of that kfree() or move it somewhere else?
>>> I mean if the free() memory on CPU-down and allocate it again CPU-up
>>> then we could skip that, rigth? Just allocate it and don't free it
>>> because the CPU will likely get up again.
>> For call trace 1:
>>
>> I went through the CPU hotplug code and found that the allocation of the
>> problematic data, cpuc->shared_regs, is done in intel_pmu_cpu_prepare. And
>> the free is done in intel_pmu_cpu_dying. They are handlers triggered by two
>> different perf events.
>>
>> It seems we can hardly form a convincing method that holds the data while
>> CPUs are off and then uses it again. raw locks would be easy and good enough.
> Why not allocate the memory in intel_pmu_cpu_prepare() if it is not
> already there (otherwise skip the allocation) and in
> intel_pmu_cpu_dying() not free it. It looks easy.

Thanks for your suggestion. I've sent the change for call trace 1 to mainline
mailing list. Hopefully it can be accepted.

Zhe

>
>> Thanks,
>> Zhe
> Sebastian
>

