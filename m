Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC2RlB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 13:41:01 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37025 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeC2Rk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 13:40:59 -0400
X-Google-Smtp-Source: AIpwx4+uV8yQ7PiJxXVKaiHCtrZbizJ8XwsKYZ5uHrKu1Z2CChm66+4EtV57A7yfuzNCAken7zA/ZQ==
Subject: Re: Problem with commit 31e77c93e432 "sched/fair: Update blocked load
 when newly idle"
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
 <20180324064627.GA10884@linaro.org>
 <c5daea3c-0834-1629-3e38-3db5130eb32f@gmail.com>
 <6b151c56-9ead-7bbe-d1b7-b0e6d69c0d7f@arm.com>
 <CAKfTPtDigSEOmtxk7daTTBb3o6kVR8AgUVhu4X6YWutK9yWNwg@mail.gmail.com>
 <CAKfTPtAisq0tQ_Kw3OptJYm=u7tSk6vyi3CFZJdhBxD=d=EN1g@mail.gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <796bbd7b-8512-7370-28c9-0f082dc3f287@gmail.com>
Date: Thu, 29 Mar 2018 19:40:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAisq0tQ_Kw3OptJYm=u7tSk6vyi3CFZJdhBxD=d=EN1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.03.2018 um 09:41 schrieb Vincent Guittot:
> On 28 March 2018 at 16:01, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>> Hi,
>>
>> On 28 March 2018 at 12:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>> Hi,
>>>
>>> On 03/24/2018 01:47 PM, Heiner Kallweit wrote:
>>>>
>>>> Am 24.03.2018 um 07:46 schrieb Vincent Guittot:
>>>>>
>>>>> Hi Heiner,
>>>>>
>>>>> Le Friday 23 Mar 2018 à 22:28:09 (+0100), Heiner Kallweit a écrit :
>>>>>>
>>>>>> Recently I started to get the following problems with linux-next:
>>>>>>
>>>>>> - When working via Putty/SSH on the system the console frequently
>>>>>> freezes
>>>>>>    for few seconds. Sometimes only opening a second console makes the
>>>>>>    first one react again.
>>>>>>
>>>>>> - I get "INFO: rcu_sched detected stalls on CPUs/tasks:" warnings as
>>>>>>    described in [1].
>>>>>>
>>>
>>> I can't catch this issue on my Juno r0 (arm64 big.Little).
>>>
>>> root@juno:~# uname -r
>>> 4.16.0-rc4-00198-g31e77c93e432
>>>
>>> I'm using openssh-client and openssh-server though.
>>
>> I think that I have finally been able to reproduce it on my hikey
>> (octo cortex-A53) after unplugging 6 cores and waiting for almost 2
>> hours
>> This seems to happen only on dual core system as I haven't faced that
>> before on the hikey which I have used for my tests
>>
> 
> I'm finally not so sure that i have the right set up to reproduce the
> problem as I haven't been able to reproduce it since.
> 
> Heiner,
> 
> How fast the problem happens on your board ?
> Are you doing anything specific on the console that trigger the problem ?
> 
Hi Vincent,

the lag when working on the console is constantly there, the "rcu_preempt
detected stalls" happens after several hours (so far always within 24h)
w/o any triggering event I would be aware of. It occured also when the
system was idle at that point in time.

Rgds, Heiner

> Regards,
> Vincent
> 
>>>
>>>>>> Bisecting the issue resulted in:
>>>>>>
>>>>>> 31e77c93e432dec79c7d90b888bbfc3652592741 is the first bad commit
>>>>>> commit 31e77c93e432dec79c7d90b888bbfc3652592741
>>>>>> Author: Vincent Guittot <vincent.guittot@linaro.org>
>>>>>> Date:   Wed Feb 14 16:26:46 2018 +0100
>>>>>>
>>>>>>      sched/fair: Update blocked load when newly idle
>>>>>>
>>>>>>      When NEWLY_IDLE load balance is not triggered, we might need to
>>>>>> update the
>>>>>>      blocked load anyway. We can kick an ilb so an idle CPU will take
>>>>>> care of
>>>>>>      updating blocked load or we can try to update them locally before
>>>>>> entering
>>>>>>      idle. In the latter case, we reuse part of the nohz_idle_balance.
>>>>>>
>>>>>> After reversing this commit at least the issue with the freezing console
>>>>>> is gone. The second one appeared only sporadically, I still have to see
>>>>>> whether it pops up again.
>>>
>>>
>>> [...]
>>>
> 
