Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62106C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB2020892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB2020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLGIiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:38:15 -0500
Received: from foss.arm.com ([217.140.101.70]:39576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeLGIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:38:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 547861596;
        Fri,  7 Dec 2018 00:38:14 -0800 (PST)
Received: from [10.37.9.129] (unknown [10.37.9.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24393F59C;
        Fri,  7 Dec 2018 00:38:12 -0800 (PST)
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, will.deacon@arm.com, mingo@redhat.com,
        james.morse@arm.com, hpa@zytor.com
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
 <20181206182551.GB37411@arrakis.emea.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <6424e0f6-7755-c19a-5bc4-a70be5839644@arm.com>
Date:   Fri, 7 Dec 2018 08:38:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181206182551.GB37411@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/2018 06:25 PM, Catalin Marinas wrote:
> On Mon, Dec 03, 2018 at 01:55:18PM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index 07c3408..cabfcae 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
>>   	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
>>   }
>>   
>> +#define unsafe_user_region_active	uaccess_region_active
>> +static inline bool uaccess_region_active(void)
>> +{
>> +	if (system_uses_ttbr0_pan()) {
>> +		u64 ttbr;
>> +
>> +		ttbr = read_sysreg(ttbr1_el1);
>> +		return ttbr & TTBR_ASID_MASK;
> 
> Nitpick: could write this in 1-2 lines.
> 

True, I can do that in 1 line.

>> +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
>> +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
>> +				false :
>> +				!read_sysreg_s(SYS_PSTATE_PAN);
>> +	}
> 
> ARM64_ALT_PAN_NOT_UAO implies ARM64_HAS_PAN which implies SCTLR_EL1.SPAN
> is 0 at run-time. Is this to cope with the case of being called prior to
> cpu_enable_pan()?
> 

Yes, the issue I can into is that for cpufeatures, .cpu_enable() 
callbacks are called inside stop_machine() which obviously might_sleep 
and so attempts to check whether user_access is on. But for features 
that get enabled before PAN, the PAN bit will be set.

Thanks,

Julien
