Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E093C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A56206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBUOTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:19:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBUOTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:19:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9A280D;
        Thu, 21 Feb 2019 06:19:23 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63C563F575;
        Thu, 21 Feb 2019 06:19:21 -0800 (PST)
Subject: Re: [PATCH] trace: skip hwasan
To:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190217043434.46233-1-cai@lca.pw>
 <CACT4Y+ZYd0LFLJTwBbPRXpS1SorgPjN6c6woUB+25Vd6GuStsw@mail.gmail.com>
 <ec947849-5743-d48b-e2fc-acb90bbe6559@lca.pw>
 <CACT4Y+a=d3G06tjLU0qEz8RWthFybeiJZ_sAAt2ybi+-JEDPZw@mail.gmail.com>
 <20190218135929.GB15050@fuggles.cambridge.arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <aa6ef1c4-5073-4748-0c3c-b2d10c5bcdb7@arm.com>
Date:   Thu, 21 Feb 2019 14:19:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218135929.GB15050@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 18/02/2019 13:59, Will Deacon wrote:
> [+James, who knows how to decode these things]

Decode is a strong term!

This stuff is printed by Cavium's secure-world software. All I'm doing is spotting the
bits that vary between the out we've seen!


> On Mon, Feb 18, 2019 at 02:56:47PM +0100, Dmitry Vyukov wrote:
>> On Mon, Feb 18, 2019 at 2:27 PM Qian Cai <cai@lca.pw> wrote:
>>> On 2/17/19 2:30 AM, Dmitry Vyukov wrote:
>>>> On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
>>>>>
>>>>> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
>>>>> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
>>>>> because there is a burst of too much pointer access, and then KASAN will
>>>>> dereference each byte of the shadow address for the tag checking which
>>>>> will kill all the CPUs.
>>>>
>>>> Could you please elaborate what exactly happens and who/why kills
>>>> CPUs? Number of memory accesses should not make any difference.
>>>> With hardware support (MTE) it won't be possible to disable
>>>> instrumentation (loads and stores check tags themselves), so it would
>>>> be useful to keep track of exact reasons we disable instrumentation to
>>>> know how to deal with them with hardware support.
>>>> It would be useful to keep this info in the comment in the Makefile.
>>>
>>> It turns out sometimes it will trigger a hardware error.
>>
>> Please add this to the comment that there is that error, reason is
>> unknown, happens from time to time.
>> "Too much pointer access" is confusing and does not seem to be the
>> root cause (there are lots of source files that cause lots of pointer
>> accesses).

> I don't think this is directly related to KASAN, as I'm sure we've seen this
> RAS error before.

Not quite like this. I've had one choke on some PCIe transaction[0].

This looks like corruption detected in a cache associated with a CPU. 'Write back' and
'Physical Address' suggests its the data cache:


>>>  Node 0 NBU 0 Error report :
>>>  NBU BAR Error
[..]
>>>       Physical Address : 0x40011ff00
>>>
>>> NBU BAR Error : Decoded info :
>>>         Agent info : CPU
>>>             Core ID : 21
>>>             Thread ID : 1
>>>         Requ: type : 4 : Write Back
>>>  Node 0 NBU 1 Error report :
>>>  NBU BAR Error
[..]
>>>       Physical Address : 0x40011ff40
>>>
>>> NBU BAR Error : Decoded info :
>>>         Agent info : CPU
>>>             Core ID : 21
>>>             Thread ID : 1
>>>         Requ: type : 4 : Write Back
>>>  Node 0 NBU 2 Error report :
>>>  NBU BAR Error
[..]
>>>       Physical Address : 0x40011ff80

If you can reproduce it, and it always affects Core:21,Thread:1 I'd suggest offline-ing
all the threads/CPUs in that core. It may be one cache is close to some threshold, and you
can offline the core that its part of.


Thanks,

James


[0] For comparison, I've had one of these during kexec:
# NBU BAR Error : Decoded info :
#        Agent info : IO
#                   : PCIE0
#        Requ: type : 2 : Read
