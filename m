Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40122C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC20A20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC20A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeKZMY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 07:24:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbeKZMY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 07:24:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FC0181DE5;
        Mon, 26 Nov 2018 01:31:57 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-176.rdu2.redhat.com [10.10.120.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B4032D0A3;
        Mon, 26 Nov 2018 01:31:54 +0000 (UTC)
Subject: Re: [PATCH v4] debugobjects: scale the static pool size
To:     Qian Cai <cai@gmx.us>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, arnd@arndb.de,
        linux kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20181120232810.2503-1-cai@gmx.us>
 <20181121021157.3061-1-cai@gmx.us>
 <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
 <EAB01918-727E-4E6F-AC7F-0417CA469D5A@gmx.us>
 <211af3b2-bc56-2d1b-c6c2-f6853797a7a1@gmx.us>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <473f6a6e-1a14-d07c-b0f0-4d96e3232d1a@redhat.com>
Date:   Sun, 25 Nov 2018 20:31:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <211af3b2-bc56-2d1b-c6c2-f6853797a7a1@gmx.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 26 Nov 2018 01:31:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/2018 03:42 PM, Qian Cai wrote:
>
>
> On 11/23/18 10:01 PM, Qian Cai wrote:
>>
>>
>>> On Nov 22, 2018, at 4:56 PM, Thomas Gleixner <tglx@linutronix.de>
>>> wrote:
>>>
>>> On Tue, 20 Nov 2018, Qian Cai wrote:
>>>
>>> Looking deeper at that.
>>>
>>>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>>>> index 70935ed91125..140571aa483c 100644
>>>> --- a/lib/debugobjects.c
>>>> +++ b/lib/debugobjects.c
>>>> @@ -23,9 +23,81 @@
>>>> #define ODEBUG_HASH_BITS    14
>>>> #define ODEBUG_HASH_SIZE    (1 << ODEBUG_HASH_BITS)
>>>>
>>>> -#define ODEBUG_POOL_SIZE    1024
>>>> +#define ODEBUG_DEFAULT_POOL    512
>>>> #define ODEBUG_POOL_MIN_LEVEL    256
>>>>
>>>> +/*
>>>> + * Some debug objects are allocated during the early boot.
>>>> Enabling some options
>>>> + * like timers or workqueue objects may increase the size required
>>>> significantly
>>>> + * with large number of CPUs. For example (as today, 20 Nov. 2018),
>>>> + *
>>>> + * No. CPUs x 2 (worker pool) objects:
>>>> + *
>>>> + * start_kernel
>>>> + *   workqueue_init_early
>>>> + *     init_worker_pool
>>>> + *       init_timer_key
>>>> + *         debug_object_init
>>>> + *
>>>> + * No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
>>>> + *
>>>> + * sched_init
>>>> + *   hrtick_rq_init
>>>> + *     hrtimer_init
>>>> + *
>>>> + * CONFIG_DEBUG_OBJECTS_WORK:
>>>> + * No. CPUs x 6 (workqueue) objects:
>>>> + *
>>>> + * workqueue_init_early
>>>> + *   alloc_workqueue
>>>> + *     __alloc_workqueue_key
>>>> + *       alloc_and_link_pwqs
>>>> + *         init_pwq
>>>> + *
>>>> + * Also, plus No. CPUs objects:
>>>> + *
>>>> + * perf_event_init
>>>> + *    __init_srcu_struct
>>>> + *      init_srcu_struct_fields
>>>> + *        init_srcu_struct_nodes
>>>> + *          __init_work
>>>
>>> None of the things are actually used or required _BEFORE_
>>> debug_objects_mem_init() is invoked.
>>>
>>> The reason why the call is at this place in start_kernel() is
>>> historical. It's because back in the days when debugobjects were
>>> added the
>>> memory allocator was enabled way later than today. So we can just
>>> move the
>>> debug_objects_mem_init() call right before sched_init() I think.
>>
>> Well, now that kmemleak_init() seems complains that
>> debug_objects_mem_init()
>> is called before it.
>>
>> [    0.078805] kmemleak: Cannot insert 0xc000000dff930000 into the
>> object search tree (overlaps existing)
>> [    0.078860] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3+ #3
>> [    0.078883] Call Trace:
>> [    0.078904] [c000000001c8fcd0] [c000000000c96b34]
>> dump_stack+0xe8/0x164 (unreliable)
>> [    0.078935] [c000000001c8fd20] [c000000000486e84]
>> create_object+0x344/0x380
>> [    0.078962] [c000000001c8fde0] [c000000000489544]
>> early_alloc+0x108/0x1f8
>> [    0.078989] [c000000001c8fe20] [c00000000109738c]
>> kmemleak_init+0x1d8/0x3d4
>> [    0.079016] [c000000001c8ff00] [c000000001054028]
>> start_kernel+0x5c0/0x6f8
>> [    0.079043] [c000000001c8ff90] [c00000000000ae7c]
>> start_here_common+0x1c/0x520
>> [    0.079070] kmemleak: Kernel memory leak detector disabled
>> [    0.079091] kmemleak: Object 0xc000000ffd587b68 (size 40):
>> [    0.079112] kmemleak:   comm "swapper/0", pid 0, jiffies 4294937299
>> [    0.079135] kmemleak:   min_count = -1
>> [    0.079153] kmemleak:   count = 0
>> [    0.079170] kmemleak:   flags = 0x5
>> [    0.079188] kmemleak:   checksum = 0
>> [    0.079206] kmemleak:   backtrace:
>> [    0.079227]      __debug_object_init+0x688/0x700
>> [    0.079250]      debug_object_activate+0x1e0/0x350
>> [    0.079272]      __call_rcu+0x60/0x430
>> [    0.079292]      put_object+0x60/0x80
>> [    0.079311]      kmemleak_init+0x2cc/0x3d4
>> [    0.079331]      start_kernel+0x5c0/0x6f8
>> [    0.079351]      start_here_common+0x1c/0x520
>> [    0.079380] kmemleak: Early log backtrace:
>> [    0.079399]    memblock_alloc_try_nid_raw+0x90/0xcc
>> [    0.079421]    sparse_init_nid+0x144/0x51c
>> [    0.079440]    sparse_init+0x1a0/0x238
>> [    0.079459]    initmem_init+0x1d8/0x25c
>> [    0.079498]    setup_arch+0x3e0/0x464
>> [    0.079517]    start_kernel+0xa4/0x6f8
>> [    0.079536]    start_here_common+0x1c/0x520
>>
>
> So this is an chicken-egg problem. Debug objects need kmemleak_init()
> first, so it can make use of kmemleak_ignore() for all debug objects
> in order to avoid the overlapping like the above.
>
> while (obj_pool_free < debug_objects_pool_min_level) {
>
>     new = kmem_cache_zalloc(obj_cache, gfp);
>     if (!new)
>         return;
>
>     kmemleak_ignore(new);
>
> However, there seems no way to move kmemleak_init() together this
> early in start_kernel() just before vmalloc_init() [1] because it
> looks like it depends on things like workqueue
> (schedule_work(&cleanup_work)) and rcu. Hence, it needs to be after
> workqueue_init_early() and rcu_init()
>
> Given that, maybe the best outcome is to stick to the alternative
> approach that works [1] rather messing up with the order of
> debug_objects_mem_init() in start_kernel() which seems tricky. What do
> you think?
>
> [1] https://goo.gl/18N78g
> [2] https://goo.gl/My6ig6

Could you move kmemleak_init() and debug_objects_mem_init() as far up as
possible, like before the hrtimer_init() to at least make static count
calculation as simple as possible?

Cheers,
Longman

