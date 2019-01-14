Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D91AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E82620657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfANNyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:54:53 -0500
Received: from foss.arm.com ([217.140.101.70]:34184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfANNyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:54:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D67E0A78;
        Mon, 14 Jan 2019 05:54:52 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7DF03F5AF;
        Mon, 14 Jan 2019 05:54:51 -0800 (PST)
Subject: Re: Question about qspinlock nest
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SRINIVAS <srinivas.eeda@oracle.com>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
 <d06126a1-1db8-f937-2084-2c1234b6f56f@arm.com>
 <20190110201217.GH2861@worktop.programming.kicks-ass.net>
 <a270215d-ec5a-8b8a-3786-c0480b640abc@arm.com>
 <20190114131613.GB10486@hirez.programming.kicks-ass.net>
From:   James Morse <james.morse@arm.com>
Message-ID: <830db851-d5cb-4081-8d72-e3f3a0a282df@arm.com>
Date:   Mon, 14 Jan 2019 13:54:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190114131613.GB10486@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 14/01/2019 13:16, Peter Zijlstra wrote:
> On Fri, Jan 11, 2019 at 06:32:58PM +0000, James Morse wrote:
>> On 10/01/2019 20:12, Peter Zijlstra wrote:
>>> On Thu, Jan 10, 2019 at 06:25:57PM +0000, James Morse wrote:
>>> The thing is, everything non-maskable (NMI like) really should not be
>>> using spinlocks at all.
>>>
>>> I otherwise have no clue about wth APEI is, but it sounds like horrible
>>> crap ;-)
>>
>> I think you've called it that before!: its that GHES thing in drivers/acpi/apei.
>>
>> What is the alternative? bit_spin_lock()?

>> These things can happen independently on multiple CPUs. On arm64 these NMIlike
>> things don't affect all CPUs like they seem to on x86.
> 
> It has nothing to do with how many CPUs are affected. It has everything
> to do with not being maskable.

(sorry, I didn't include any of the context, let me back-up a bit here:)

> What avoids the trivial self-recursion:
> 
>   spin_lock(&)
>   <NMI>
>     spin_lock(&x)
>      ... wait forever more ...
>   </NMI>
>   spin_unlock(&x)
> 
> ?

If its trying to take the same lock, I agree its deadlocked.
If the sequence above started with <NMI>, I agree its deadlocked.

APEI/GHES is doing neither of these things. It take a lock that is only ever
taken in_nmi(). nmi_enter()s BUG_ON(in_nmi()) means these never become re-entrant.

What is the lock doing? Protecting the 'NMI' fixmap slot in the unlikely case
that two CPUs end up in here at the same time.

(I though x86's NMI masked NMI until the next iret?)


This is murkier on arm64 as we have multiple things that behave like this, but
there is an order to them, and none of them can interrupt themselves.
e.g. We can't take an SError during the SError handler.

But we can take this SError/NMI on another CPU while the first one is still
running the handler.

These multiple NMIlike notifications mean having multiple locks/fixmap-slots,
one per notification. This is where the qspinlock node limit comes in, as we
could have more than 4 contexts.


Thanks,

James

> Normally for actual maskable interrupts, we use:
> 
>   spin_lock_irq(&x)
>   // our IRQ cannot happen here because: masked
>   spin_unlock_irq(&x)
> 
> But non-maskable, has, per definition, a wee issue there.

> Non-maskable MUST NOT _EVAH_ use any form of spinlocks, they're
> fundamentally incompatible. Non-maskable interrupts must employ
> wait-free atomic constructs.





