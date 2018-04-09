Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDIGd6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 02:33:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3704 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751367AbeDIGd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 02:33:57 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38704647"
Subject: Re: [PATCH] genirq: only scan the present CPUs
To: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Li RongQing <lirongqing@baidu.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1522647902-11426-1-git-send-email-lirongqing@baidu.com>
 <alpine.DEB.2.21.1804031224150.2511@nanos.tec.linutronix.de>
 <20180403112311.GF4043@hirez.programming.kicks-ass.net>
 <f2bf898d-c9da-dfb8-f50d-6fe8ddb122e6@cn.fujitsu.com>
 <20180406090228.GI4082@hirez.programming.kicks-ass.net>
 <20180406090502.GI4129@hirez.programming.kicks-ass.net>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <465754fe-8b49-c77c-9425-e077f6faf4df@cn.fujitsu.com>
Date: Mon, 9 Apr 2018 14:33:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180406090502.GI4129@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 3CB444D0EFE7.AB25F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

At 04/06/2018 05:05 PM, Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 11:02:28AM +0200, Peter Zijlstra wrote:
>> On Fri, Apr 06, 2018 at 04:42:14PM +0800, Dou Liyang wrote:
>>> Hi Thomas, Peter,
>>>
>>> At 04/03/2018 07:23 PM, Peter Zijlstra wrote:
>>>> On Tue, Apr 03, 2018 at 12:25:56PM +0200, Thomas Gleixner wrote:
>>>>> On Mon, 2 Apr 2018, Li RongQing wrote:
>>>>>
>>>>>> lots of application will read /proc/stat, like ps and vmstat, but we
>>>>>> find the reading time are spreading on Purley platform which has lots
>>>>>> of possible CPUs and interrupt.
>>>>>>
>>>>>> To reduce the reading time, only scan the present CPUs, not all possible
>>>>>> CPUs, which speeds the reading of /proc/stat 20 times on Purley platform
>>>>>> which has 56 present CPUs, and 224 possible CPUs
>>>>>
>>>>> Why is BIOS/ACPI telling the kernel that there are 224 possible CPUs unless
>>>>> it supports physical CPU hotplug.
>>>>
>>>> BIOS is crap, news at 11. I've got boxes like that too. Use
>>>> possible_cpu=$nr if you're bothered by it -- it's what I do.
>>>>
>>>
>>> Yes, I think so. it is a manual way to reset the number.
>>>
>>> For this situation, I am investigating to restrict the number of
>>> possible CPUs automatically, But, due to the limitation of ACPI
>>> subsystem, I can do it _before_ setup_percpu_area where the number will
>>> be used.
> 
> Ah, did you mean to day "I can _NOT_ do it" ? Still I don't see the
                                 ^----------- Oops, yes.

> point of frobbing random users if the whole thing is buggered.
> 

If ACPI subsystem can be initialized earlier, we can get the accurate
number of possible CPUs from the ACPI namespace. then, we can reset the
_cpu_possible_mask_ as the prefill_possible_map() does. So, it can
forbid random users.

But, It needs the memory to be initialized first, so it can't be called 
earlier setup_percpu_area() which is evoked earlier than mem_init().

and you are right:

"So if you see it enumerates a gazillion empty spots but the system does
  not in fact support physical hotplug, we should discard those."

I will think it more carefully.

Thanks,

	dou
> 
> 
