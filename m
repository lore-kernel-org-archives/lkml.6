Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26AAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6429320858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6429320858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeIRNJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:09:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40462 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbeIRNJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:09:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E262ED1;
        Tue, 18 Sep 2018 00:37:54 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.Emea.Arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32B073F5C0;
        Tue, 18 Sep 2018 00:37:52 -0700 (PDT)
Subject: Re: [PATCH v5 03/27] arm64: alternative: Apply alternatives early in
 boot process
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-4-git-send-email-julien.thierry@arm.com>
 <3becf020-b230-beb8-b304-d8097377f234@arm.com>
 <78781d82-e5c4-c590-6c0c-e7d2db456bf9@arm.com>
 <20180917234400.ctq3w2u6fi5s5coj@holly.lan>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <9505fbcc-796f-78bd-80b7-21d879c5e0bc@arm.com>
Date:   Tue, 18 Sep 2018 08:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180917234400.ctq3w2u6fi5s5coj@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/09/18 00:44, Daniel Thompson wrote:
> On Wed, Sep 12, 2018 at 05:49:09PM +0100, Julien Thierry wrote:
>>>> +	__apply_alternatives(&region, false, boot_capabilities);
>>>> +}
>>>> +
>>>>    #ifdef CONFIG_MODULES
>>>>    void apply_alternatives_module(void *start, size_t length)
>>>>    {
>>>
>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>> index 3bc1c8b..0d1e41e 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>> @@ -52,6 +52,8 @@
>>>>    DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>>>>    EXPORT_SYMBOL(cpu_hwcaps);
>>>> +unsigned long boot_capabilities;
>>>> +
>>>>    /*
>>>>     * Flag to indicate if we have computed the system wide
>>>>     * capabilities based on the boot time active CPUs. This
>>>> @@ -1375,6 +1377,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>>>>    		if (!cpus_have_cap(caps->capability) && caps->desc)
>>>>    			pr_info("%s %s\n", info, caps->desc);
>>>>    		cpus_set_cap(caps->capability);
>>>
>>> Hmm, the bitmap behind cpus_set_cap() is what cpus_have_cap() in
>>> __apply_alternatives() looks at. If you had a call to __apply_alternatives after
>>> update_cpu_capabilities(SCOPE_BOOT_CPU), but before any others, it would only
>>> apply those alternatives...
>>>
>>> (I don't think there is a problem re-applying the same alternative, but I
>>> haven't checked).
>>>
>>
>> Interesting idea. If someone can confirm that patching alternatives twice is
>> safe, I think it would make things simpler.
> 
> Early versions of this patch applied the alternatives twice. I never
> noticed any problems with double patching (second time round it will
> write out code that is identical to what is already there so it is
> merely inefficient rather than unsafe.
> 

When you say early version, do you mean the first ones you did? Because 
the one I picked up (v4 I believe) had a feature mask to select which 
ones to apply early and then which ones to exclude when applying the 
rest of the features.

But I admit I have not looked at the previous versions.

Cheers,

-- 
Julien Thierry
