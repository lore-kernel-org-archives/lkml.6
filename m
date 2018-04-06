Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeDFImT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:42:19 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32579 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751312AbeDFImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:42:17 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38644329"
Subject: Re: [PATCH] genirq: only scan the present CPUs
To: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC: Li RongQing <lirongqing@baidu.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1522647902-11426-1-git-send-email-lirongqing@baidu.com>
 <alpine.DEB.2.21.1804031224150.2511@nanos.tec.linutronix.de>
 <20180403112311.GF4043@hirez.programming.kicks-ass.net>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f2bf898d-c9da-dfb8-f50d-6fe8ddb122e6@cn.fujitsu.com>
Date: Fri, 6 Apr 2018 16:42:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180403112311.GF4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 93A394D0EFF5.A9F89
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Peter,

At 04/03/2018 07:23 PM, Peter Zijlstra wrote:
> On Tue, Apr 03, 2018 at 12:25:56PM +0200, Thomas Gleixner wrote:
>> On Mon, 2 Apr 2018, Li RongQing wrote:
>>
>>> lots of application will read /proc/stat, like ps and vmstat, but we
>>> find the reading time are spreading on Purley platform which has lots
>>> of possible CPUs and interrupt.
>>>
>>> To reduce the reading time, only scan the present CPUs, not all possible
>>> CPUs, which speeds the reading of /proc/stat 20 times on Purley platform
>>> which has 56 present CPUs, and 224 possible CPUs
>>
>> Why is BIOS/ACPI telling the kernel that there are 224 possible CPUs unless
>> it supports physical CPU hotplug.
> 
> BIOS is crap, news at 11. I've got boxes like that too. Use
> possible_cpu=$nr if you're bothered by it -- it's what I do.
> 

Yes, I think so. it is a manual way to reset the number.

For this situation, I am investigating to restrict the number of
possible CPUs automatically, But, due to the limitation of ACPI
subsystem, I can do it _before_ setup_percpu_area where the number will
be used.

But, I can provider an indicator to tell the system that whether the 
physical CPU hotplug is support or not later. Can we use this indicator
like that in this situation:

    if ture

	Using for_each_possible_cpu(cpu)
    else

	Using for_each_present_cpu(cpu)	



Thanks,

	dou

> 
> 
