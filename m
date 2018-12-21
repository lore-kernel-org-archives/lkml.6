Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2080120866
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404037AbeLUO5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:57:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53046 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730979AbeLUO5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:57:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C945180D;
        Fri, 21 Dec 2018 06:57:13 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4878E3F59C;
        Fri, 21 Dec 2018 06:57:12 -0800 (PST)
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Cc:     peterz@infradead.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
 <20181206182551.GB37411@arrakis.emea.arm.com>
 <6424e0f6-7755-c19a-5bc4-a70be5839644@arm.com>
 <20181210145931.GE4048@arrakis.emea.arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <7fc4f5d1-a587-1a24-8fae-fc8e26195804@arm.com>
Date:   Fri, 21 Dec 2018 14:57:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210145931.GE4048@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 10/12/2018 14:59, Catalin Marinas wrote:
> On Fri, Dec 07, 2018 at 08:38:11AM +0000, Julien Thierry wrote:
>> On 12/06/2018 06:25 PM, Catalin Marinas wrote:
>>> On Mon, Dec 03, 2018 at 01:55:18PM +0000, Julien Thierry wrote:
>>>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>>>> index 07c3408..cabfcae 100644
>>>> --- a/arch/arm64/include/asm/uaccess.h
>>>> +++ b/arch/arm64/include/asm/uaccess.h
>>>> @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
>>>> +#define unsafe_user_region_active	uaccess_region_active
>>>> +static inline bool uaccess_region_active(void)
>>>> +{
>>>> +	if (system_uses_ttbr0_pan()) {

>>>> +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
>>>> +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
>>>> +				false :
>>>> +				!read_sysreg_s(SYS_PSTATE_PAN);
>>>> +	}
>>>
>>> ARM64_ALT_PAN_NOT_UAO implies ARM64_HAS_PAN which implies SCTLR_EL1.SPAN
>>> is 0 at run-time. Is this to cope with the case of being called prior to
>>> cpu_enable_pan()?
>>>
>>
>> Yes, the issue I can into is that for cpufeatures, .cpu_enable() callbacks
>> are called inside stop_machine() which obviously might_sleep and so attempts
>> to check whether user_access is on. But for features that get enabled before
>> PAN, the PAN bit will be set.
> 
> OK, so the PSTATE.PAN bit only makes sense when SCTLR_EL1.SPAN is 0, IOW
> the PAN hardware feature has been enabled. Maybe you could write it
> (together with some comment):
> 
> 	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO) &&
> 		 !(read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN)) {
> 		 /* only if PAN is present and enabled */
> 		return !read_sysreg_s(SYS_PSTATE_PAN)
> 	}
> 
> On the cpufeature.c side of things, it seems that we enable the
> static_branch before calling the cpu_enable. I wonder whether changing
> the order here would help with avoid the SCTLR_EL1 read (not sure what
> else it would break; cc'ing Suzuki).

Avoiding the system-register read would be good. Can we check
alternatives_applied? It gets set later, and is obviously connected to the PAN
alternatives being patched in to the uaccess routines.


Thanks,

James
