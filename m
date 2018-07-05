Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDB4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8C9223A8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8C9223A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeGEMrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:47:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49182 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753886AbeGEMra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:47:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D80E518A;
        Thu,  5 Jul 2018 05:47:29 -0700 (PDT)
Received: from [10.1.206.53] (e108454-lin.cambridge.arm.com [10.1.206.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD7053F2EA;
        Thu,  5 Jul 2018 05:47:27 -0700 (PDT)
Subject: Re: [kvmtool test PATCH 22/24] kvmtool: arm64: Add support for guest
 physical address size
To:     Will Deacon <will.deacon@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org,
        eric.auger@redhat.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-23-git-send-email-suzuki.poulose@arm.com>
 <20180704140943.GF4828@arm.com>
 <8c9bb3cd-f673-17f3-656f-66b7e14fc73c@arm.com>
 <20180704155231.GP4828@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <ca05f552-d0d7-b5b8-954b-7254e8c1e529@arm.com>
Date:   Thu, 5 Jul 2018 13:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180704155231.GP4828@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 04/07/18 16:52, Will Deacon wrote:
> On Wed, Jul 04, 2018 at 04:00:11PM +0100, Julien Grall wrote:
>> On 04/07/18 15:09, Will Deacon wrote:
>>> On Fri, Jun 29, 2018 at 12:15:42PM +0100, Suzuki K Poulose wrote:
>>>> Add an option to specify the physical address size used by this
>>>> VM.
>>>>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>   arm/aarch64/include/kvm/kvm-config-arch.h | 5 ++++-
>>>>   arm/include/arm-common/kvm-config-arch.h  | 1 +
>>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
>>>> index 04be43d..dabd22c 100644
>>>> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
>>>> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
>>>> @@ -8,7 +8,10 @@
>>>>   			"Create PMUv3 device"),				\
>>>>   	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
>>>>   			"Specify random seed for Kernel Address Space "	\
>>>> -			"Layout Randomization (KASLR)"),
>>>> +			"Layout Randomization (KASLR)"),		\
>>>> +	OPT_INTEGER('\0', "phys-shift", &(cfg)->phys_shift,		\
>>>> +			"Specify maximum physical address size (not "	\
>>>> +			"the amount of memory)"),
>>>
>>> Given that this is a shift value, I think the help message could be more
>>> informative. Something like:
>>>
>>> 	"Specify maximum number of bits in a guest physical address"
>>>
>>> I think I'd actually leave out any mention of memory, because this does
>>> actually have an effect on the amount of addressable memory in a way that I
>>> don't think we want to describe in half of a usage message line :)
>> Is there any particular reasons to expose this option to the user?
>>
>> I have recently sent a series to allow the user to specify the position
>> of the RAM [1]. With that series in mind, I think the user would not really
>> need to specify the maximum physical shift. Instead we could automatically
>> find it.
> 
> Marc makes a good point that it doesn't help for MMIO regions, so I'm trying
> to understand whether we can do something differently there and avoid
> sacrificing the type parameter.

I am not sure to understand this. kvmtools knows the memory layout 
(including MMIOs) of the guest, so couldn't it guess the maximum 
physical shift for that?

Cheers,

-- 
Julien Grall
