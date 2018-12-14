Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BFE2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BFE2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeLNIzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:55:36 -0500
Received: from foss.arm.com ([217.140.101.70]:47230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeLNIzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:55:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D623E80D;
        Fri, 14 Dec 2018 00:55:35 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EEFB3F614;
        Fri, 14 Dec 2018 00:55:33 -0800 (PST)
Subject: Re: [PATCH 2/6] arm64: add sysfs vulnerability show for meltdown
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-3-jeremy.linton@arm.com>
 <d1ad00a8-1b87-f234-aa41-c1f342cb28dc@arm.com>
 <af4f1e1e-673d-28e0-909d-f1e85b4d5b45@arm.com>
 <3dfed0e1-9819-ccfd-1024-b6f64f5fbffe@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <a1a8fcb8-6a13-285a-0308-ccac37e36c49@arm.com>
Date:   Fri, 14 Dec 2018 08:55:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3dfed0e1-9819-ccfd-1024-b6f64f5fbffe@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On 12/12/2018 14:49, Jeremy Linton wrote:
> Hi Julien,
> 
> Thanks for taking a look at this!
> 
> On 12/13/2018 04:46 AM, Julien Thierry wrote:
>>
>>
>> On 13/12/2018 09:23, Julien Thierry wrote:
>>> Hi Jeremy,
>>>
>>> On 06/12/2018 23:44, Jeremy Linton wrote:
>>>> Add a simple state machine which will track whether
>>>> all the online cores in a machine are vulnerable.
>>>>
>>>> Once that is done we have a fairly authoritative view
>>>> of the machine vulnerability, which allows us to make a
>>>> judgment about machine safety if it hasn't been mitigated.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>   arch/arm64/kernel/cpufeature.c | 31 ++++++++++++++++++++++++++-----
>>>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/cpufeature.c
>>>> b/arch/arm64/kernel/cpufeature.c
>>>> index 242898395f68..bea9adfef7fa 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>> @@ -905,6 +905,8 @@ has_useable_cnp(const struct
>>>> arm64_cpu_capabilities *entry, int scope)
>>>>       return has_cpuid_feature(entry, scope);
>>>>   }
>>>>   +static enum { A64_MELT_UNSET, A64_MELT_SAFE, A64_MELT_UNKN }
>>>> __meltdown_safe = A64_MELT_UNSET;
>>>> +
>>>
>>> I'm wondering, do we really need that tri state?
>>>
>>> Can't we consider that we are safe an move to unsafe/unkown if any cpu
>>> during bring up is not in the safe list?
>>>
>>> The only user of this is cpu_show_meltdown, but I don't imagine it'll
>>> get called before unmap_kernel_at_el0() is called for the boot CPU which
>>> should initialise that state.
>>>
>>> Or is there another reason for having that UNSET state?
>>>
>>
>> Ok, I think I get the point of the UNSET as #ifndef
>> CONFIG_UNMAP_KERNEL_AT_EL0 we don't set the state. But does that mean we
>> always fall in the "Unknown" case when we don't build kpti in? Is that
>> desirable?
>>
>> If so, I'd suggest replacing the tri-state with the following change:
>>
>>
>>>> +
>>>> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
>>>> +ssize_t cpu_show_meltdown(struct device *dev, struct
>>>> device_attribute *attr,
>>>> +        char *buf)
>>>> +{
>>>> +    if (arm64_kernel_unmapped_at_el0())
>>>> +        return sprintf(buf, "Mitigation: KPTI\n");
>>>> +
>>
>>     if (!IS_ENABLED(UNMAP_KERNEL_AT_EL0) || !meltdown_safe)
>>         sprintf(buf, "Unknown\n");
>>     else
>>         sprintf(buf, "Not affected\n");
> 
> If I'm understanding what your suggesting:
> 
> Isn't this only checking the current core, rather than the whole
> machine? IIRC that was the fundamental complaint with the original set.
> 

Sorry, yes, I meant to check "!__meltdown_safe". Basically my suggestion
is to replace the static enum variable with a static bool and handle the
"UNSET" case on whether we built the mitigation.

Does that make sense?

However, there's still the same issue as with patch 4. If we don't build
the mitigation, we say that we don't know the status of the system. I
think it would be nice to be able to say that a system is safe even when
the mitigation is not built. People knowing they have a safe system
might be inclined to not build additional stuff they don't need.

Cheers.

-- 
Julien Thierry
