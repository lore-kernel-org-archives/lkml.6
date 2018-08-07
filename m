Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AAAC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7234214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7234214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbeHGO0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:26:10 -0400
Received: from foss.arm.com ([217.140.101.70]:53536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeHGO0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:26:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59BE980D;
        Tue,  7 Aug 2018 05:12:07 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6053F5D0;
        Tue,  7 Aug 2018 05:12:05 -0700 (PDT)
Subject: Re: [PATCH] arm64: Trap WFI executed in userspace
To:     Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180807093326.5090-1-marc.zyngier@arm.com>
 <20180807100437.GA9097@e103592.cambridge.arm.com>
 <9af8bb9a-7c6c-2560-5965-118dfadf8141@arm.com>
 <20180807103054.GB9097@e103592.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <da5d1650-fcd8-83ec-bd4c-02f236163776@arm.com>
Date:   Tue, 7 Aug 2018 13:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807103054.GB9097@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/18 11:30, Dave Martin wrote:
> On Tue, Aug 07, 2018 at 11:24:34AM +0100, Marc Zyngier wrote:
>> On 07/08/18 11:05, Dave Martin wrote:
>>> On Tue, Aug 07, 2018 at 10:33:26AM +0100, Marc Zyngier wrote:
>>>> It recently came to light that userspace can execute WFI, and that
>>>> the arm64 kernel doesn trap this event. This sounds rather benign,
>>>> but the kernel should decide when it wants to wait for an interrupt,
>>>> and not userspace.
>>>>
>>>> Let's trap WFI and treat it as a way to yield the CPU to another
>>>> process.
>>>
>>> This doesn't amount to a justification.
>>>
>>> If the power controller is unexpectedly left in a bad state so that
>>> WFI will do something nasty to a cpu that may enter userspace, then we
>>> probably have bigger problems.
>>>
>>> So, maybe it really is pretty harmless to let userspace execute this.
>>
>> Or not. It is also a very good way for userspace to find out when an
>> interrupt gets delivered and start doing all kind of probing on the
>> kernel. The least the userspace knows about that, the better I feel.
> 
> Possibly.  I suspect there are other ways to guess pretty accurately
> when an interrupt occurs, but WFI allows greater precision.

...unless you're running in a VM and it traps to KVM anyway ;)

>>> I can't think of a legitimate reason for userspace to execute WFI
>>> however.  Userspace doesn't have interrupts under Linux, so it makes
>>> no sense to wait for one.
>>>
>>> Have we seen anybody using WFI in userspace?  It may be cleaner to
>>> map this to SIGILL rather than be permissive and regret it later.
>>
>> I couldn't find any user, and I'm happy to just send userspace to hell
>> in that case. But it could also been said that since it was never
>> prevented, it is a de-facto ABI.
> 
> Agreed.  I wonder whether it's sufficient to have this mapping to SIGILL
> in -next for a while and see whether anybody complains.

I think we'd have to avoid that for compat, though, since v7 code would 
have the expectation that WFI can't be trapped by the kernel at all. 
Personally I'm in favour of this patch as-is, since the architectural 
intent of the instruction is essentially "I've got nothing better to do 
right now than wait for something to happen", so treating it as a poor 
man's sched_vield() stays close to that while mitigating the potential 
nefarious and/or minor DoS implications of letting it architecturally 
execute.

Robin.
