Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A66C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C020842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfBYP0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:26:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfBYP0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:26:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E245A1596;
        Mon, 25 Feb 2019 07:26:15 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653243F703;
        Mon, 25 Feb 2019 07:26:14 -0800 (PST)
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        xen-devel <xen-devel@lists.xenproject.org>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
 <fe44917f-bbe9-3e0e-fdda-2eb4db9f25c2@arm.com>
 <13a9616c-2d9a-f90b-3358-f2dcadbbb64d@gmail.com>
 <dbfd87e9-48fc-f641-9e24-ddb6c4f61135@arm.com>
 <1aeda04d-3420-fa50-ad33-a0b3e981f5e4@gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <25316391-38b3-42d4-073f-46614307c240@arm.com>
Date:   Mon, 25 Feb 2019 15:26:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1aeda04d-3420-fa50-ad33-a0b3e981f5e4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On 25/02/2019 14:08, Oleksandr Andrushchenko wrote:
> On 2/25/19 3:55 PM, Julien Grall wrote:
>> Hi Oleksandr,
>>
>> On 25/02/2019 13:24, Oleksandr Andrushchenko wrote:
>>> On 2/22/19 3:33 PM, Julien Grall wrote:
>>>> Hi,
>>>>
>>>> On 22/02/2019 12:38, Oleksandr Andrushchenko wrote:
>>>>> On 2/20/19 10:46 PM, Julien Grall wrote:
>>>>>> Discussing with my team, a solution that came up would be to introduce one 
>>>>>> atomic field per event to record the number of event received. I will 
>>>>>> explore that solution tomorrow.
>>>>> How will this help if events have some payload?
>>>>
>>>> What payload? The event channel does not carry any payload. It only notify 
>>>> you that something happen. Then this is up to the user to decide what to you 
>>>> with it.
>>> Sorry, I was probably not precise enough. I mean that an event might have
>>> associated payload in the ring buffer, for example [1]. So, counting events
>>> may help somehow, but the ring's data may still be lost
>>
>> From my understanding of event channels are edge interrupts. By definition, 
>> they can be merged so you can get a signal notification to the guest for 
>> multiple "events". So if you rely on the event to have an associated payload, 
>> then you probably have done something wrong in your driver.
>>
>> I haven't implemented PV drivers myself, but I would expect either side to 
>> block if there were no space in the ring.
>>
>> What do you do in the displif driver when the ring is full?
>>
> It is handled by the originator, the display backend in our case: it doesn't send
> events if it sees that the ring will overflow. But I was worried about
> such a generic change with counting number of events received and if this
> really helps to recover in general case

Well, I was originally looking at modifying only the /dev/evtchn driver but it 
turns out the event flow for Xen irqchip is not entirely correct.

A lot of Xen PV drivers will thread the handler and set IRQF_ONESHOT expecting 
the event to be masked until the event handler has ran. However, the flow we use 
does not deal with it and actually warn you may receive another event before 
executing the handler for the first event.

I have discussed with Marc Z. (one of the irqchip maintainers) about the issue. 
He suggested a different interrupt flow that I need to try out.

Cheers,

-- 
Julien Grall
