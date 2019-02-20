Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ED8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA821841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfBTUqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:46:38 -0500
Received: from foss.arm.com ([217.140.101.70]:34836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBTUqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:46:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57BE9EBD;
        Wed, 20 Feb 2019 12:46:37 -0800 (PST)
Received: from [10.37.8.123] (unknown [10.37.8.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4702D3F5C1;
        Wed, 20 Feb 2019 12:46:35 -0800 (PST)
Subject: Re: xen/evtchn and forced threaded irq
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave P Martin <dave.martin@arm.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Jan Beulich <JBeulich@suse.com>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
Date:   Wed, 20 Feb 2019 20:46:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Andrew and Jan for feedback on the event channel interrupt)

Hi Boris,

Thank you for the your feedback.

On 2/20/19 8:04 PM, Boris Ostrovsky wrote:
> On 2/20/19 1:05 PM, Julien Grall wrote:
>> Hi,
>>
>> On 20/02/2019 17:07, Boris Ostrovsky wrote:
>>> On 2/20/19 9:15 AM, Julien Grall wrote:
>>>> Hi Boris,
>>>>
>>>> Thank you for your answer.
>>>>
>>>> On 20/02/2019 00:02, Boris Ostrovsky wrote:
>>>>> On Tue, Feb 19, 2019 at 05:31:10PM +0000, Julien Grall wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> I have been looking at using Linux RT in Dom0. Once the guest is
>>>>>> started,
>>>>>> the console is ending to have a lot of warning (see trace below).
>>>>>>
>>>>>> After some investigation, this is because the irq handler will now
>>>>>> be threaded.
>>>>>> I can reproduce the same error with the vanilla Linux when passing
>>>>>> the option
>>>>>> 'threadirqs' on the command line (the trace below is from 5.0.0-rc7
>>>>>> that has
>>>>>> not RT support).
>>>>>>
>>>>>> FWIW, the interrupt for port 6 is used to for the guest to
>>>>>> communicate with
>>>>>> xenstore.
>>>>>>
>>>>>>    From my understanding, this is happening because the interrupt
>>>>>> handler is now
>>>>>> run in a thread. So we can have the following happening.
>>>>>>
>>>>>>       Interrupt context            |     Interrupt thread
>>>>>>                                    |
>>>>>>       receive interrupt port 6     |
>>>>>>       clear the evtchn port        |
>>>>>>       set IRQF_RUNTHREAD            |
>>>>>>       kick interrupt thread        |
>>>>>>                                    |    clear IRQF_RUNTHREAD
>>>>>>                                    |    call evtchn_interrupt
>>>>>>       receive interrupt port 6     |
>>>>>>       clear the evtchn port        |
>>>>>>       set IRQF_RUNTHREAD           |
>>>>>>       kick interrupt thread        |
>>>>>>                                    |    disable interrupt port 6
>>>>>>                                    |    evtchn->enabled = false
>>>>>>                                    |    [....]
>>>>>>                                    |
>>>>>>                                    |    *** Handling the second
>>>>>> interrupt ***
>>>>>>                                    |    clear IRQF_RUNTHREAD
>>>>>>                                    |    call evtchn_interrupt
>>>>>>                                    |    WARN(...)
>>>>>>
>>>>>> I am not entirely sure how to fix this. I have two solutions in mind:
>>>>>>
>>>>>> 1) Prevent the interrupt handler to be threaded. We would also
>>>>>> need to
>>>>>> switch from spin_lock to raw_spin_lock as the former may sleep on
>>>>>> RT-Linux.
>>>>>>
>>>>>> 2) Remove the warning
>>>>>
>>>>> I think access to evtchn->enabled is racy so (with or without the
>>>>> warning) we can't use it reliably.
>>>>
>>>> Thinking about it, it would not be the only issue. The ring is sized
>>>> to contain only one instance of the same event. So if you receive
>>>> twice the event, you may overflow the ring.
>>>
>>> Hm... That's another argument in favor of "unthreading" the handler.
>>
>> I first thought it would be possible to unthread it. However,
>> wake_up_interruptible is using a spin_lock. On RT spin_lock can sleep,
>> so this cannot be used in an interrupt context.
>>
>> So I think "unthreading" the handler is not an option here.
> 
> That sounds like a different problem. I.e. there are two issues:
> * threaded interrupts don't work properly (races, ring overflow)
> * evtchn_interrupt() (threaded or not) has spin_lock(), which is not
> going to work for RT

I am afraid that's not correct, you can use spin_lock() in threaded 
interrupt handler.

> The first can be fixed by using non-threaded handlers.

The two are somewhat related, if you use a non-threaded handler then you 
are not going to help the RT case.

In general, the unthreaded solution should be used in the last resort.

>>
>>>
>>>>
>>>>>
>>>>> Another alternative could be to queue the irq if !evtchn->enabled and
>>>>> handle it in evtchn_write() (which is where irq is supposed to be
>>>>> re-enabled).
>>>> What do you mean by queue? Is it queueing in the ring?
>>>
>>>
>>> No, I was thinking about having a new structure for deferred interrupts.
>>
>> Hmmm, I am not entirely sure what would be the structure here. Could
>> you expand your thinking?
> 
> Some sort of a FIFO that stores {irq, data} tuple. It could obviously be
> implemented as a ring but not necessarily as Xen shared ring (if that's
> what you were referring to).

The underlying question is what happen if you miss an interrupt. Is it 
going to be ok? If no, then we have to record everything and can't 
kill/send an error to the user app because it is not its fault.

This means a FIFO would not be a viable. How do you size it? Static (i.e 
pre-defined) size is not going to be possible because you don't know how 
many interrupt you are going to receive before the thread handler runs. 
You can't make it grow dynamically as it make become quite big for the 
same reason.

Discussing with my team, a solution that came up would be to introduce 
one atomic field per event to record the number of event received. I 
will explore that solution tomorrow.

Cheers,

-- 
Julien Grall
