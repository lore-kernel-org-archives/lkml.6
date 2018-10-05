Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5BB2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5BB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeJEUlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:41:24 -0400
Received: from foss.arm.com ([217.140.101.70]:52092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbeJEUlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:41:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79605ED1;
        Fri,  5 Oct 2018 06:42:36 -0700 (PDT)
Received: from [10.4.13.99] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126793F5B3;
        Fri,  5 Oct 2018 06:42:33 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
To:     Matthias Brugger <mbrugger@suse.com>, matthias.bgg@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de,
        jason@lakedaemon.net, robert.richter@cavium.com
Cc:     suzuki.poulose@arm.com, shankerd@codeaurora.org,
        xiexiuqi@huawei.com, Dave.Martin@arm.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180912095232.2110-1-matthias.bgg@kernel.org>
 <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
 <95733d12-ee1d-9874-16a7-c614cc0ce8cd@arm.com>
 <8ef6b381-e170-30de-ad0e-fae8ccf189e5@suse.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <1d227152-2770-3e93-f78c-71e7a3b4fe76@arm.com>
Date:   Fri, 5 Oct 2018 14:42:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8ef6b381-e170-30de-ad0e-fae8ccf189e5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/18 13:33, Matthias Brugger wrote:
> 
> 
> On 05/10/2018 12:55, Marc Zyngier wrote:
>> Hi Matthias,
>>
>> On 04/10/18 23:11, Matthias Brugger wrote:
>>> Friendly reminder, if anyone has any comment on the patch :)
>>>
>>> On 9/12/18 11:52 AM, matthias.bgg@kernel.org wrote:
>>>> From: Matthias Brugger <mbrugger@suse.com>
>>>>
>>>> Some hardware does not implement two-level page tables so that
>>>> the amount of contigious memory needed by the baser is bigger
>>>> then the zone order. This is a known problem on Cavium Thunderx
>>>> with 4K page size.
>>>>
>>>> We fix this by adding an errata which allocates the memory early
>>>> in the boot cycle, using the memblock allocator.
>>>>
>>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>>> ---
>>>>    arch/arm64/Kconfig               | 12 ++++++++
>>>>    arch/arm64/include/asm/cpucaps.h |  3 +-
>>>>    arch/arm64/kernel/cpu_errata.c   | 33 +++++++++++++++++++++
>>>>    drivers/irqchip/irq-gic-v3-its.c | 50 ++++++++++++++++++++------------
>>>>    4 files changed, 79 insertions(+), 19 deletions(-)
>>
>> My only comment would be to state how much I dislike both the HW and the
>> patch... ;-) The idea that we have some erratum that depends on the page size
>> doesn't feel good at all.
>>
> 
> Well ugly HW needs ugly patches ;-)
> 
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 1b1a0e95c751..dfd9fe08f0b2 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -597,6 +597,18 @@ config QCOM_FALKOR_ERRATUM_E1041
>>>>            If unsure, say Y.
>>>>    +config CAVIUM_ALLOC_ITS_TABLE_EARLY
>>>> +    bool "Cavium Thunderx: Allocate the its table early"
>>>> +    default y
>>>> +    depends on ARM64_4K_PAGES && FORCE_MAX_ZONEORDER < 13
>>
>> Here's a though: Why don't we ensure that FORCE_MAX_ZONEORDER is such as we
>> could always allocate the same amount of memory, no matter what the page size
>> is? That, or bump FORCE_MAX_ZONEORDER to 13 if the kernel includes support for TX1.
>>
> 
> Bumping FORCE_MAX_ZONEORDER when TX1 is supported was proposed here:
> https://patchwork.kernel.org/patch/6322281/
> 
> To bring in some more history, the CMA approach ended with this discussion:
> https://patchwork.kernel.org/patch/9888041/
> 
>> Any of this of course requires buy-in from the arm64 maintainers, as this is
>> quite a departure from the way things work so far.
>>
> 
> With my distribution head on, I would prefer a solution that does not change
> FORCE_MAX_ZONEORDER. That's how I came to the idea providing a third solution to
> the same problem :)

Why is that a problem? What impact does this have on your favourite distro?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
