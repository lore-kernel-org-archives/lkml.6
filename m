Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D3EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C58720872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbfAKSdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:33:02 -0500
Received: from foss.arm.com ([217.140.101.70]:33454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733084AbfAKSdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:33:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1005480D;
        Fri, 11 Jan 2019 10:33:01 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20EAA3F6CF;
        Fri, 11 Jan 2019 10:32:59 -0800 (PST)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <a270215d-ec5a-8b8a-3786-c0480b640abc@arm.com>
Date:   Fri, 11 Jan 2019 18:32:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190110201217.GH2861@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/01/2019 20:12, Peter Zijlstra wrote:
> On Thu, Jan 10, 2019 at 06:25:57PM +0000, James Morse wrote:
> 
>> On arm64 if all the RAS and psuedo-NMI patches land, our worst-case interleaving
>> jumps to at least 7. The culprit is APEI using spinlocks to protect fixmap slots.
>>
>> I have an RFC to bump the number of node bits from 2 to 3, but as this is APEI
>> four times, it may be preferable to make it use something other than spinlocks.

>> The worst-case order is below. Each one masks those before it:
>> 1. process context
>> 2. soft-irq
>> 3. hard-irq
>> 4. psuedo-nmi [0]
>>    - using the irqchip priorities to configure some IRQs as NMI.
>> 5. SError [1]
>>    - a bit like an asynchronous MCE. ACPI allows this to convey CPER records,
>>      requiring an APEI call.
>> 6&7. SDEI [2]
>>      - a firmware triggered software interrupt, only its two of them, either of
>>        which could convey CPER records.
>> 8. Synchronous external abort
>>    - again, similar to MCE. There are systems using this with APEI.

> The thing is, everything non-maskable (NMI like) really should not be
> using spinlocks at all.
> 
> I otherwise have no clue about wth APEI is, but it sounds like horrible
> crap ;-)

I think you've called it that before!: its that GHES thing in drivers/acpi/apei.

What is the alternative? bit_spin_lock()?
These things can happen independently on multiple CPUs. On arm64 these NMIlike
things don't affect all CPUs like they seem to on x86.


Thanks,

James
