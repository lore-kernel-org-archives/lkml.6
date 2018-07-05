Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAE523BFB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAE523BFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeGEOht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:37:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753250AbeGEOhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:37:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C22C401C876;
        Thu,  5 Jul 2018 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-118.ams2.redhat.com [10.36.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F40312156889;
        Thu,  5 Jul 2018 14:37:44 +0000 (UTC)
Subject: Re: [kvmtool test PATCH 22/24] kvmtool: arm64: Add support for guest
 physical address size
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-23-git-send-email-suzuki.poulose@arm.com>
 <20180704140943.GF4828@arm.com>
 <8c9bb3cd-f673-17f3-656f-66b7e14fc73c@arm.com>
 <20180704155231.GP4828@arm.com>
 <ca05f552-d0d7-b5b8-954b-7254e8c1e529@arm.com>
 <d0c005f8-eae4-3784-1ebc-d279df4ee608@arm.com>
 <bd5186ce-66ab-e2fa-3531-46a4a87b84d8@redhat.com>
 <29208b59-0224-00d2-0e2a-6f53a0cbc963@arm.com>
Cc:     cdall@kernel.org, kvm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        james.morse@arm.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <52eb61a0-e114-14ac-8f5e-fa99f566d1cb@redhat.com>
Date:   Thu, 5 Jul 2018 16:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <29208b59-0224-00d2-0e2a-6f53a0cbc963@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 05 Jul 2018 14:37:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 05 Jul 2018 14:37:47 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki, Marc,

On 07/05/2018 04:15 PM, Marc Zyngier wrote:
> Hi Eric,
> 
> On 05/07/18 14:46, Auger Eric wrote:
>> Hi Marc,
>>
>> On 07/05/2018 03:20 PM, Marc Zyngier wrote:
>>> On 05/07/18 13:47, Julien Grall wrote:
>>>> Hi Will,
>>>>
>>>> On 04/07/18 16:52, Will Deacon wrote:
>>>>> On Wed, Jul 04, 2018 at 04:00:11PM +0100, Julien Grall wrote:
>>>>>> On 04/07/18 15:09, Will Deacon wrote:
>>>>>>> On Fri, Jun 29, 2018 at 12:15:42PM +0100, Suzuki K Poulose wrote:
>>>>>>>> Add an option to specify the physical address size used by this
>>>>>>>> VM.
>>>>>>>>
>>>>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>>> ---
>>>>>>>>   arm/aarch64/include/kvm/kvm-config-arch.h | 5 ++++-
>>>>>>>>   arm/include/arm-common/kvm-config-arch.h  | 1 +
>>>>>>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
>>>>>>>> index 04be43d..dabd22c 100644
>>>>>>>> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
>>>>>>>> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
>>>>>>>> @@ -8,7 +8,10 @@
>>>>>>>>   			"Create PMUv3 device"),				\
>>>>>>>>   	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
>>>>>>>>   			"Specify random seed for Kernel Address Space "	\
>>>>>>>> -			"Layout Randomization (KASLR)"),
>>>>>>>> +			"Layout Randomization (KASLR)"),		\
>>>>>>>> +	OPT_INTEGER('\0', "phys-shift", &(cfg)->phys_shift,		\
>>>>>>>> +			"Specify maximum physical address size (not "	\
>>>>>>>> +			"the amount of memory)"),
>>>>>>>
>>>>>>> Given that this is a shift value, I think the help message could be more
>>>>>>> informative. Something like:
>>>>>>>
>>>>>>> 	"Specify maximum number of bits in a guest physical address"
>>>>>>>
>>>>>>> I think I'd actually leave out any mention of memory, because this does
>>>>>>> actually have an effect on the amount of addressable memory in a way that I
>>>>>>> don't think we want to describe in half of a usage message line :)
>>>>>> Is there any particular reasons to expose this option to the user?
>>>>>>
>>>>>> I have recently sent a series to allow the user to specify the position
>>>>>> of the RAM [1]. With that series in mind, I think the user would not really
>>>>>> need to specify the maximum physical shift. Instead we could automatically
>>>>>> find it.
>>>>>
>>>>> Marc makes a good point that it doesn't help for MMIO regions, so I'm trying
>>>>> to understand whether we can do something differently there and avoid
>>>>> sacrificing the type parameter.
>>>>
>>>> I am not sure to understand this. kvmtools knows the memory layout 
>>>> (including MMIOs) of the guest, so couldn't it guess the maximum 
>>>> physical shift for that?
>>>
>>> That's exactly what Will was trying to avoid, by having KVM to compute
>>> the size of the IPA space based on the registered memslots. We've now
>>> established that it doesn't work, so what we need to define is:
>>>
>>> - whether we need another ioctl(), or do we carry on piggy-backing on
>>> the CPU type,
>> kvm type I guess
> 
> I really meant target here. Whatever you pass as a "-cpu" on your QEMU
> command line.
Oh OK. It was not a slip then ;-)
> 
>>> - assuming the latter, whether we can reduce the number of bits used in
>>> the ioctl parameter by subtly encoding the IPA size.
>> Getting benefit from your Freudian slip, how should guest CPU PARange
>> and maximum number of bits in a guest physical address relate?
> 
> Freudian? I'm not on the sofa yet... ;-)
> 
>> My understanding is they are not correlated at the moment and our guest
>> PARange is fixed at the moment. But shouldn't they?
>>
>> On Intel there is
>>    qemu-system-x86_64 -M pc,accel=kvm -cpu SandyBridge,phys-bits=36
>> or
>>    qemu-system-x86_64 -M pc,accel=kvm -cpu SandyBridge,host-phys-bits=true
>>
>> where phys-bits, as far as I understand has a a similar semantics as the
>> PARange.
> 
> I think there is value in having it global, just like on x86. We don't
> really support heterogeneous guests anyway.

Assuming we would use such a ",phys-bits=n" cpu option, is my
understanding correct that it would set both
- guest CPU PARange an
- maximum number of bits in a guest physical address
to n?

Thanks

Eric
> 
> Independently, we should also repaint/satinize PARange so that the guest
> observes the same thing, no matter what CPU it runs on (an A53/A57
> system could be confusing in that respect).

> 
> Thanks,
> 
> 	M.
> 
