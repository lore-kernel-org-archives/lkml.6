Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeDSU6z convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:58:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753011AbeDSU6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:58:54 -0400
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
Message-ID: <c0530769-50c3-87ad-1558-164873482130@redhat.com>
Date: Thu, 19 Apr 2018 16:58:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180419203949.GA4555@avx2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 04:39 PM, Alexey Dobriyan wrote:
> On Thu, Apr 19, 2018 at 04:21:14PM -0400, Waiman Long wrote:
>> On 04/19/2018 03:55 PM, Alexey Dobriyan wrote:
>>> On Thu, Apr 19, 2018 at 03:28:40PM -0400, Waiman Long wrote:
>>>> On 04/19/2018 03:08 PM, Alexey Dobriyan wrote:
>>>>>> Therefore, application performance can be impacted if the application
>>>>>> reads /proc/stat rather frequently.
>>>>> [nods]
>>>>> Text interfaces can be designed in a very stupid way.
>>>>>
>>>>>> For example, reading /proc/stat in a certain 2-socket Skylake server
>>>>>> took about 4.6ms because it had over 5k irqs.
>>>>> Is this top(1)? What is this application doing?
>>>>> If it needs percpu usage stats, then maybe /proc/stat should be
>>>>> converted away from single_open() so that core seq_file code doesn't
>>>>> generate everything at once.
>>>> The application is actually a database benchmarking tool used by a
>>>> customer.
>>> So it probably needs lines before "intr" line.
>>>
>>>> The reading of /proc/stat is an artifact of the benchmarking
>>>> tool that can actually be turned off. Without doing that, about 20% of
>>>> CPU time were spent reading /proc/stat and the trashing of cachelines
>>>> slowed the benchmark number quite significantly. However, I was also
>>>> told that there are legitimate cases where reading /proc/stat was
>>>> necessary in some of their applications.
>>>>
>>>>>> -
>>>>>> -	/* sum again ? it could be updated? */
>>>>>> -	for_each_irq_nr(j)
>>>>>> -		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
>>>>>> -
>>>>> This is direct userspace breakage.
>>>> Yes, I am aware of that. That is the cost of improving the performance
>>>> of applications that read /proc/stat, but don't need the individual irq
>>>> counts.
>>> Yeah, but all it takes is one script which cares.
>>>
>>> I have an idea.
>>>
>>> Maintain "maximum registered irq #", it should be much smaller than
>>> "nr_irqs":
>>>
>>> intr 4245359 151 0 0 0 0 0 0 0 38 0 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 44330 182364 57741 0 0 0 0 0 0 0 0 85 89124 0 0 0 0 0 323360 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
>> For the time being, I think I am going to have a clone /proc/stat2 as
>> suggested in my earlier email. Alternatively, I can put that somewhere
>> in sysfs if you have a good idea of where I can put it.
> sysfs is strictly one-value-per-file.
>
>> I will also look into ways to optimize the current per-IRQ stats
>> handling, but it will come later.
> There is always a time-honored way of ioctl(2) switching irq info off
> /proc supports that.
>
> There are many options.

OK, it is good to know. Do you have any existing code snippet in the
kernel that I can use as reference on how to use ioctl(2) switching?

I will look into how to optimize the existing per-IRQ stats code first
before venturing into cloning /proc/stat.

Cheers,
Longman
