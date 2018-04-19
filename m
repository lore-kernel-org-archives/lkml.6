Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbeDSVFZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 17:05:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752153AbeDSVFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 17:05:24 -0400
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        akpm@linux-foundation.org
References: <20180419190846.GE2066@avx2>
 <1c3b9cf3-3a36-568f-3da2-e560a721f4aa@redhat.com>
 <20180419195504.GA4343@avx2>
 <eb7c1569-e445-5cbb-6d10-2694b625232a@redhat.com>
 <20180419203949.GA4555@avx2>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <053d4061-6bf8-a772-aa3b-f5791fa75fab@redhat.com>
Date: Thu, 19 Apr 2018 17:05:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180419203949.GA4555@avx2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 04:39 PM, Alexey Dobriyan wrote:
>>
>> Yes, that can probably help.
>>
>> This is the data from the problematic skylake server:
>>
>> model name    : Intel(R) Xeon(R) Gold 6136 CPU @ 3.00GHz
>> 56 sosreport-carevalo.02076935-20180413085327/proc/stat
>> Interrupts: 5370
>> Interrupts without "0" entries: 1011
>>
>> There are still quite a large number of non-zero entries, though.
>>
>>> Or maintain array of registered irqs and iterate over them only.
>> Right, we can allocate a bitmap of used irqs to do that.
>>
>>> I have another idea.
>>>
>>> perf record shows mutex_lock/mutex_unlock at the top.
>>> Most of them are irq mutex not seqfile mutex as there are many more
>>> interrupts than reads. Take it once.
>>>
>> How many cpus are in your test system? In that skylake server, it was
>> the per-cpu summing operation of the irq counts that was consuming most
>> of the time for reading /proc/stat. I think we can certainly try to
>> optimize the lock taking.
> It's 16x(NR_IRQS: 4352, nr_irqs: 960, preallocated irqs: 16)
> Given that irq registering is rare operation, maintaining sorted array
> of irq should be the best option.
>

BTW, the skylake server is 2-socket 24-core 48-thread.

Cheers,
Longman
